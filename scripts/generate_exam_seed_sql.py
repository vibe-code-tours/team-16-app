#!/usr/bin/env python3
"""Generate one idempotent Supabase SQL seed file for an A+B exam term."""
from __future__ import annotations

import argparse
import json
from pathlib import Path


def literal(value) -> str:
    if value is None:
        return "NULL"
    return "'" + str(value).replace("'", "''") + "'"


def jsonb(value) -> str:
    return literal(json.dumps(value, ensure_ascii=False, separators=(",", ":"))) + "::jsonb"


def array(values: list[int]) -> str:
    return "ARRAY[" + ",".join(str(value) for value in values) + "]::int[]"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--resources-dir", type=Path, required=True)
    parser.add_argument("--year", type=int, required=True)
    parser.add_argument("--season", choices=("April", "October"), required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    exam_session = f"{args.year}-{args.season.lower()}"
    rows = []
    counts = {}
    for subject in ("A", "B"):
        path = args.resources_dir / f"{args.year}-{args.season}-{subject}" / "questions.json"
        subject_rows = json.loads(path.read_text())
        counts[subject] = len(subject_rows)
        rows.extend(subject_rows)

    columns = [
        "exam_session", "subject", "question_number", "question_text",
        "content_blocks", "images", "choices", "correct_answer", "answer_key",
        "explanation", "difficulty", "difficulty_score", "source_file",
        "source_citation", "source_pages", "extraction_method",
        "extraction_version", "source_text", "ref_doc", "published",
    ]
    lines = [
        f"-- NerdQuiz seed: {args.year} {args.season} FE Subjects A and B",
        "-- Generated from the original ITPEC question and answer PDFs.",
        "BEGIN;", "",
        "INSERT INTO questions (", "  " + ",\n  ".join(columns), ") VALUES",
    ]
    values = []
    for row in rows:
        record = [
            literal(exam_session), literal(row["subject"]), str(row["question_number"]),
            literal(row["question_text"]), jsonb(row["content_blocks"]),
            jsonb(row["images"]), jsonb(row["choices"]), literal(row["correct_answer"]),
            jsonb(row["answer_key"]), literal(row.get("explanation")),
            literal(row.get("difficulty", "medium")), str(row.get("difficulty_score", 0.5)),
            literal(row.get("source_file")), literal(row.get("source_citation")),
            array(row.get("source_pages", [])), literal(row.get("extraction_method", "native_text")),
            literal(row.get("extraction_version")), literal(row.get("source_text")),
            jsonb(row.get("ref_doc", {})), "true",
        ]
        values.append("(\n  " + ",\n  ".join(record) + "\n)")
    lines.append(",\n".join(values))
    lines.extend([
        "ON CONFLICT (exam_session, subject, question_number) DO UPDATE SET",
        "  question_text = EXCLUDED.question_text,",
        "  content_blocks = EXCLUDED.content_blocks,",
        "  images = EXCLUDED.images,",
        "  choices = EXCLUDED.choices,",
        "  correct_answer = EXCLUDED.correct_answer,",
        "  answer_key = EXCLUDED.answer_key,",
        "  source_citation = EXCLUDED.source_citation,",
        "  source_pages = EXCLUDED.source_pages,",
        "  source_text = EXCLUDED.source_text,",
        "  ref_doc = EXCLUDED.ref_doc,",
        "  extraction_method = EXCLUDED.extraction_method,",
        "  extraction_version = EXCLUDED.extraction_version,",
        "  updated_at = now();", "",
    ])

    for subject in ("A", "B"):
        time_limit = 150 if args.year <= 2023 else (90 if subject == "A" else 100)
        title = f"{args.year} {args.season} FE Subject {subject}"
        lines.extend([
            "INSERT INTO exams (exam_session, subject, title, question_count, time_limit_minutes, initial_hearts, published)",
            f"VALUES ({literal(exam_session)}, {literal(subject)}, {literal(title)}, {counts[subject]}, {time_limit}, 5, true)",
            "ON CONFLICT (exam_session, subject) DO UPDATE SET",
            "  title = EXCLUDED.title, question_count = EXCLUDED.question_count,",
            "  time_limit_minutes = EXCLUDED.time_limit_minutes, published = EXCLUDED.published;", "",
            "DELETE FROM exam_questions",
            f"WHERE exam_id = (SELECT id FROM exams WHERE exam_session = {literal(exam_session)} AND subject = {literal(subject)});",
            "INSERT INTO exam_questions (exam_id, question_id, sequence_number)",
            "SELECT e.id, q.id, q.question_number",
            "FROM exams e",
            "JOIN questions q ON q.exam_session = e.exam_session AND q.subject = e.subject",
            f"WHERE e.exam_session = {literal(exam_session)} AND e.subject = {literal(subject)}",
            "ORDER BY q.question_number;", "",
        ])

    lines.extend(["COMMIT;", ""])
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text("\n".join(lines))
    print(f"Generated {args.output} with {len(rows)} questions")


if __name__ == "__main__":
    main()
