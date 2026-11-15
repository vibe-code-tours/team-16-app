#!/usr/bin/env python3
"""Generate one idempotent Supabase SQL seed file from extracted ITPEC FE papers.

``--all`` writes every paper in ``resources/exams/index.json`` into a single
file; ``--year``/``--season`` writes one term. Generation refuses to run while
``validate_itpec_resources.py`` reports failures.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path

from validate_itpec_resources import load_enrichment, validate_all

CLASSIFICATION_SOURCE = "llm"
LEGACY_FORMAT_LAST_YEAR = 2023
LEGACY_TIME_LIMIT_MINUTES = 150
SUBJECT_TIME_LIMIT_MINUTES = {"A": 90, "B": 100}
INITIAL_HEARTS = 5

QUESTION_COLUMNS = [
    "exam_session", "subject", "question_number", "question_text",
    "content_blocks", "images", "choices", "correct_answer", "answer_key",
    "explanation", "subtopic_id", "difficulty", "difficulty_score", "source_file",
    "source_citation", "source_pages", "extraction_method",
    "extraction_version", "source_text", "ref_doc", "published",
]
# Everything the generator owns is refreshed on re-run. Usage counters
# (times_answered, times_correct) and ids are left untouched.
UPSERT_COLUMNS = [
    "question_text", "content_blocks", "images", "choices", "correct_answer",
    "answer_key", "explanation", "subtopic_id", "source_file", "source_citation",
    "source_pages", "source_text", "ref_doc", "extraction_method", "extraction_version",
]


def literal(value) -> str:
    if value is None:
        return "NULL"
    return "'" + str(value).replace("'", "''") + "'"


def jsonb(value) -> str:
    return literal(json.dumps(value, ensure_ascii=False, separators=(",", ":"))) + "::jsonb"


def array(values: list[int]) -> str:
    return "ARRAY[" + ",".join(str(value) for value in values) + "]::int[]"


def subtopic_lookup(slug: str | None) -> str:
    if slug is None:
        return "NULL"
    return f"(SELECT id FROM subtopics WHERE slug = {literal(slug)})"


def question_record(row: dict, exam_session: str, enrichment: dict) -> str:
    entry = enrichment.get(str(row["question_number"]), {})
    record = [
        literal(exam_session), literal(row["subject"]), str(row["question_number"]),
        literal(row["question_text"]), jsonb(row["content_blocks"]),
        jsonb(row["images"]), jsonb(row["choices"]), literal(row["correct_answer"]),
        jsonb(row["answer_key"]), literal(entry.get("explanation", row.get("explanation"))),
        subtopic_lookup(entry.get("subtopic_slug")),
        literal(row.get("difficulty", "medium")), str(row.get("difficulty_score", 0.5)),
        literal(row.get("source_file")), literal(row.get("source_citation")),
        array(row.get("source_pages", [])), literal(row.get("extraction_method", "native_text")),
        literal(row.get("extraction_version")), literal(row.get("source_text")),
        jsonb(row.get("ref_doc", {})), "true",
    ]
    return "(\n  " + ",\n  ".join(record) + "\n)"


def questions_sql(rows: list[dict], exam_session: str, enrichment: dict) -> list[str]:
    lines = ["INSERT INTO questions (", "  " + ",\n  ".join(QUESTION_COLUMNS), ") VALUES"]
    lines.append(",\n".join(question_record(row, exam_session, enrichment) for row in rows))
    lines.append("ON CONFLICT (exam_session, subject, question_number) DO UPDATE SET")
    lines.extend(f"  {column} = EXCLUDED.{column}," for column in UPSERT_COLUMNS)
    lines.extend(["  updated_at = now();", ""])
    return lines


def question_subtopics_sql(rows: list[dict], exam_session: str, subject: str, enrichment: dict) -> list[str]:
    """Replace the paper's topic links with one primary subtopic per question."""
    classified = [
        (row["question_number"], enrichment[str(row["question_number"])])
        for row in rows if enrichment.get(str(row["question_number"]), {}).get("subtopic_slug")
    ]
    if not classified:
        return []
    values = ",\n".join(
        f"  ({number}, {literal(entry['subtopic_slug'])}, {float(entry.get('confidence', 0.5)):.3f})"
        for number, entry in classified
    )
    session, paper_subject = literal(exam_session), literal(subject)
    return [
        "DELETE FROM question_subtopics",
        "WHERE question_id IN (",
        f"  SELECT id FROM questions WHERE exam_session = {session} AND subject = {paper_subject}",
        ");",
        "INSERT INTO question_subtopics (question_id, subtopic_id, is_primary, confidence, classification_source)",
        f"SELECT q.id, s.id, true, v.confidence, {literal(CLASSIFICATION_SOURCE)}",
        "FROM (VALUES",
        values,
        ") AS v(question_number, slug, confidence)",
        "JOIN questions q ON q.question_number = v.question_number",
        f"  AND q.exam_session = {session} AND q.subject = {paper_subject}",
        "JOIN subtopics s ON s.slug = v.slug;", "",
    ]


def exam_sql(year: int, season: str, subject: str, question_count: int) -> list[str]:
    exam_session = f"{year}-{season.lower()}"
    time_limit = LEGACY_TIME_LIMIT_MINUTES if year <= LEGACY_FORMAT_LAST_YEAR else SUBJECT_TIME_LIMIT_MINUTES[subject]
    title = f"{year} {season} FE Subject {subject}"
    exam_lookup = f"(SELECT id FROM exams WHERE exam_session = {literal(exam_session)} AND subject = {literal(subject)})"
    return [
        "INSERT INTO exams (exam_session, subject, title, question_count, time_limit_minutes, initial_hearts, published)",
        f"VALUES ({literal(exam_session)}, {literal(subject)}, {literal(title)}, {question_count}, {time_limit}, {INITIAL_HEARTS}, true)",
        "ON CONFLICT (exam_session, subject) DO UPDATE SET",
        "  title = EXCLUDED.title, question_count = EXCLUDED.question_count,",
        "  time_limit_minutes = EXCLUDED.time_limit_minutes, published = EXCLUDED.published;", "",
        "DELETE FROM exam_questions",
        f"WHERE exam_id = {exam_lookup};",
        "INSERT INTO exam_questions (exam_id, question_id, sequence_number)",
        "SELECT e.id, q.id, q.question_number",
        "FROM exams e",
        "JOIN questions q ON q.exam_session = e.exam_session AND q.subject = e.subject",
        f"WHERE e.exam_session = {literal(exam_session)} AND e.subject = {literal(subject)}",
        "ORDER BY q.question_number;", "",
    ]


def paper_sql(resources_dir: Path, year: int, season: str, subject: str) -> tuple[list[str], int]:
    paper = f"{year}-{season}-{subject}"
    exam_session = f"{year}-{season.lower()}"
    rows = json.loads((resources_dir / paper / "questions.json").read_text())
    enrichment = (load_enrichment(resources_dir, paper) or {}).get("questions", {})
    lines = [f"-- {year} {season} FE Subject {subject}: {len(rows)} questions"]
    lines.extend(questions_sql(rows, exam_session, enrichment))
    lines.extend(question_subtopics_sql(rows, exam_session, subject, enrichment))
    lines.extend(exam_sql(year, season, subject, len(rows)))
    return lines, len(rows)


def header(terms: list[tuple[int, str]], question_count: int) -> list[str]:
    covered = ", ".join(f"{year} {season}" for year, season in terms)
    return [
        "-- NerdQuiz seed: ITPEC Fundamental IT Engineer (FE) examination questions",
        f"-- Terms: {covered}",
        f"-- Questions: {question_count} (Subjects A and B)",
        "--",
        "-- GENERATED FILE - do not edit by hand. Regenerate with:",
        "--   python scripts/generate_exam_seed_sql.py --all --output supabase/seed_data/009_seed_exam_questions.sql",
        "--",
        "-- Source: https://itpec.org/pastexamqa/fe.html. Questions (c) Information Technology",
        "-- Professionals Examination Council, used for educational purposes; each row cites",
        "-- its source in source_citation, e.g. (2025S, FE, Subject-A, Q1).",
        "-- Modifications: questions whose PDF text could not be extracted (maths, drawn",
        "-- answer choices) were re-transcribed from the page image and are marked",
        "-- extraction_method = 'manual_review'; see resources/exams/overrides/.",
        "-- The explanation and subtopic of every question were written by an AI model, are",
        "-- not ITPEC content, and live in resources/exams/enrichment/.",
        "--",
        "-- Idempotent: safe to run repeatedly. Requires the schema migrations to be applied.",
        "",
    ]


def terms_in_manifest(resources_dir: Path) -> list[tuple[int, str]]:
    manifest = json.loads((resources_dir / "index.json").read_text())
    terms = {(int(item["name"].split("-")[0]), item["name"].split("-")[1]) for item in manifest}
    return sorted(terms, key=lambda term: (term[0], term[1] != "April"))


def build_sql(resources_dir: Path, terms: list[tuple[int, str]]) -> tuple[str, int]:
    body: list[str] = []
    total = 0
    for year, season in terms:
        for subject in ("A", "B"):
            lines, count = paper_sql(resources_dir, year, season, subject)
            body.extend(lines)
            total += count
    lines = header(terms, total) + ["BEGIN;", ""] + body + ["COMMIT;", ""]
    return "\n".join(lines), total


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--resources-dir", type=Path, default=Path("resources/exams"))
    parser.add_argument("--all", action="store_true", help="write every term in index.json")
    parser.add_argument("--year", type=int)
    parser.add_argument("--season", choices=("April", "October"))
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    if args.all == bool(args.year and args.season):
        parser.error("pass either --all or both --year and --season")

    failures = validate_all(args.resources_dir, require_enrichment=True)
    if failures:
        for failure in failures[:20]:
            print(failure)
        raise SystemExit(
            f"Refusing to generate: {len(failures)} validation failure(s). "
            "Run scripts/validate_itpec_resources.py --require-enrichment for the full list."
        )

    terms = terms_in_manifest(args.resources_dir) if args.all else [(args.year, args.season)]
    sql, total = build_sql(args.resources_dir, terms)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(sql)
    print(f"Generated {args.output} with {total} questions from {len(terms)} term(s)")


if __name__ == "__main__":
    main()
