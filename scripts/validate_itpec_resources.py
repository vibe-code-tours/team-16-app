#!/usr/bin/env python3
"""Validation gate for extracted ITPEC FE resources.

Reads ``resources/exams/index.json`` and every paper's ``questions.json`` and
reports each question that must not reach the database: sample questions,
missing or empty choices, answers that match no choice, text damaged by broken
PDF font maps, and missing figure files. With ``--require-enrichment`` it also
checks the committed subtopic/explanation files.

Exit status is 0 only when there are no failures.
"""
from __future__ import annotations

import argparse
import json
import re
import unicodedata
from dataclasses import dataclass
from pathlib import Path

SUBJECT_A_QUESTION_COUNTS = (60, 80)  # current Subject A / 2021-2023 morning paper
MAX_SUBJECT_A_QUESTION_LENGTH = 2500  # longer means it swallowed the next questions
SUBJECT_B_QUESTION_COUNTS = (8, 20)  # legacy afternoon paper / modern Subject B
SUBJECT_A_LABELS = ["a", "b", "c", "d"]
MIN_EXPLANATION_LENGTH = 40
SAMPLE_MARKERS = ("[Sample Question]", "[Sample Answer]", "marking your answer on the answer")

# Slugs seeded by supabase/migrations/20260712122400_initial_schema.sql.
SUBTOPIC_SLUGS = (
    "computer-architecture", "data-structures", "algorithms", "databases",
    "networking", "operating-systems", "software-development",
    "cryptography", "network-security", "access-control", "security-threats",
    "project-management", "quality-assurance", "development-processes",
    "intellectual-property", "it-governance",
    "business-strategy", "finance", "procurement", "business-operations",
)

ALLOWED_LETTER_SCRIPTS = ("LATIN", "GREEK")
ALLOWED_MARKS = {"̄", "̅"}  # combining macron / overline (logical NOT)
ALLOWED_WIDE = {"・", "："}  # katakana middle dot, fullwidth colon
ANSWER_LABEL_RE = re.compile(r"[a-j]")
PAGE_FOOTER_RE = re.compile(r"(?m)^\s*[-–—]\s*\d{1,3}\s*[-–—]\s*$")


@dataclass(frozen=True)
class Failure:
    paper: str
    question_number: int
    code: str
    message: str

    def __str__(self) -> str:
        return f"{self.paper} Q{self.question_number}: [{self.code}] {self.message}"


def damaged_characters(text: str) -> list[str]:
    """Return characters that only appear when a PDF font map is broken.

    Maths set in Cambria Math or Symbol is exported with code points that land
    in unrelated scripts (Syriac, Ethiopic, Malayalam), the private-use area,
    or the mathematical-alphanumeric block with its layout lost.
    """
    damaged = []
    for char in text:
        if char in "\n\t" or " " <= char <= "~" or char in ALLOWED_MARKS or char in ALLOWED_WIDE:
            continue
        category = unicodedata.category(char)
        if category in ("Co", "Cn", "Cs", "Cc", "Cf"):
            damaged.append(char)
        elif category.startswith("L"):
            if not unicodedata.name(char, "").startswith(ALLOWED_LETTER_SCRIPTS):
                damaged.append(char)
        elif category.startswith("M") or category == "Nd":
            damaged.append(char)
    return damaged


def describe(chars: list[str]) -> str:
    unique = sorted(set(chars))
    return ", ".join(f"U+{ord(char):04X}" for char in unique[:8]) + (" …" if len(unique) > 8 else "")


def is_legacy_subject_b(question: dict) -> bool:
    return "parts" in question.get("answer_key", {})


def choice_has_content(choice: dict) -> bool:
    return bool(choice.get("text", "").strip() or choice.get("image") or choice.get("values"))


def validate_question(paper: str, question: dict, image_names: set[str]) -> list[Failure]:
    number = question["question_number"]
    subject = question["subject"]
    failures: list[Failure] = []

    def fail(code: str, message: str) -> None:
        failures.append(Failure(paper, number, code, message))

    question_text = question.get("question_text", "")
    choices = question.get("choices", [])
    labels = [choice.get("label") for choice in choices]

    if not question_text.strip():
        fail("empty-question", "question_text is empty")
    if any(marker in question_text or marker in question.get("source_text", "") for marker in SAMPLE_MARKERS):
        fail("sample-question", "instruction-page sample question, not a real question")

    if subject == "A":
        if len(question_text) > MAX_SUBJECT_A_QUESTION_LENGTH:
            fail("oversized-question", f"{len(question_text)} characters; it probably contains later questions")
        if labels != SUBJECT_A_LABELS:
            fail("choice-labels", f"expected choices a-d, found {labels}")
        if question.get("correct_answer") not in labels:
            fail("answer-mismatch", f"correct_answer {question.get('correct_answer')!r} is not a choice label")
    elif is_legacy_subject_b(question):
        parts = question["answer_key"]["parts"]
        if not parts:
            fail("answer-mismatch", "legacy Subject B answer key has no parts")
        if any(not ANSWER_LABEL_RE.fullmatch(str(part.get("answer", ""))) for part in parts):
            fail("answer-mismatch", "legacy Subject B answer part is not a single letter")
    else:
        if len(labels) < 2 or len(set(labels)) != len(labels):
            fail("choice-labels", f"expected at least two distinct choices, found {labels}")
        if question.get("correct_answer") not in labels:
            fail("answer-mismatch", f"correct_answer {question.get('correct_answer')!r} is not a choice label")

    empty = [choice.get("label") for choice in choices if not choice_has_content(choice)]
    if empty:
        fail("empty-choice", f"choices with no text or image: {empty}")

    if PAGE_FOOTER_RE.search(question_text) or any(PAGE_FOOTER_RE.search(c.get("text", "")) for c in choices):
        fail("page-footer", "page-number footer left inside the question or a choice")

    damaged = damaged_characters(question_text)
    damaged.extend(damaged_characters(json.dumps(choices, ensure_ascii=False)))
    damaged.extend(damaged_characters(json.dumps(question.get("content_blocks", []), ensure_ascii=False)))
    if damaged:
        fail("damaged-text", f"characters from a broken font map: {describe(damaged)}")

    referenced = list(question.get("images", [])) + [c["image"] for c in choices if c.get("image")]
    missing = [name for name in referenced if name not in image_names]
    if missing:
        fail("missing-image", f"figure files not found: {missing}")
    return failures


def validate_paper(paper: str, subject: str, questions: list[dict], image_names: set[str]) -> list[Failure]:
    failures: list[Failure] = []
    numbers = [question["question_number"] for question in questions]
    expected_counts = SUBJECT_A_QUESTION_COUNTS if subject == "A" else SUBJECT_B_QUESTION_COUNTS
    if len(questions) not in expected_counts:
        failures.append(Failure(paper, 0, "question-count", f"{len(questions)} questions, expected {expected_counts}"))
    if numbers != list(range(1, len(numbers) + 1)):
        failures.append(Failure(paper, 0, "question-numbers", "question numbers are not 1..N in order"))
    for question in questions:
        failures.extend(validate_question(paper, question, image_names))
    return failures


def validate_enrichment(paper: str, questions: list[dict], enrichment: dict | None) -> list[Failure]:
    if enrichment is None:
        return [Failure(paper, 0, "enrichment-missing", "no enrichment file for this paper")]
    entries = enrichment.get("questions", {})
    failures: list[Failure] = []
    for question in questions:
        number = question["question_number"]
        entry = entries.get(str(number))
        if entry is None:
            failures.append(Failure(paper, number, "enrichment-missing", "no enrichment entry"))
            continue
        if entry.get("subtopic_slug") not in SUBTOPIC_SLUGS:
            failures.append(Failure(paper, number, "enrichment-subtopic", f"unknown subtopic {entry.get('subtopic_slug')!r}"))
        explanation = str(entry.get("explanation") or "").strip()
        if len(explanation) < MIN_EXPLANATION_LENGTH:
            failures.append(Failure(paper, number, "enrichment-explanation", "explanation is missing or too short"))
        elif damaged_characters(explanation):
            failures.append(Failure(paper, number, "enrichment-explanation", f"damaged characters: {describe(damaged_characters(explanation))}"))
        confidence = entry.get("confidence")
        if not isinstance(confidence, (int, float)) or not 0 <= confidence <= 1:
            failures.append(Failure(paper, number, "enrichment-confidence", "confidence must be a number from 0 to 1"))
    extra = sorted(set(entries) - {str(question["question_number"]) for question in questions})
    if extra:
        failures.append(Failure(paper, 0, "enrichment-extra", f"entries for questions that do not exist: {extra}"))
    return failures


def load_enrichment(resources_dir: Path, paper: str) -> dict | None:
    path = resources_dir / "enrichment" / f"{paper}.json"
    return json.loads(path.read_text()) if path.exists() else None


def validate_all(resources_dir: Path, require_enrichment: bool = False,
                 public_images_dir: Path | None = None) -> list[Failure]:
    manifest = json.loads((resources_dir / "index.json").read_text())
    public_names = None
    if public_images_dir is not None:
        public_names = {path.name for path in public_images_dir.glob("*.webp")}
    failures: list[Failure] = []
    for item in manifest:
        paper = item["name"]
        paper_dir = resources_dir / paper
        questions_path = paper_dir / "questions.json"
        if not questions_path.exists():
            failures.append(Failure(paper, 0, "not-built", "questions.json is missing; run build_itpec_resources.py"))
            continue
        questions = json.loads(questions_path.read_text())
        image_names = {path.name for path in (paper_dir / "images").glob("*.webp")}
        if public_names is not None:
            image_names &= public_names
        failures.extend(validate_paper(paper, item["subject"], questions, image_names))
        if require_enrichment:
            failures.extend(validate_enrichment(paper, questions, load_enrichment(resources_dir, paper)))
    return failures


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--resources-dir", type=Path, default=Path("resources/exams"))
    parser.add_argument("--public-images-dir", type=Path,
                        help="also require every figure to exist in this directory")
    parser.add_argument("--require-enrichment", action="store_true")
    parser.add_argument("--report", type=Path, help="write failures as JSON to this path")
    args = parser.parse_args()

    failures = validate_all(args.resources_dir, args.require_enrichment, args.public_images_dir)
    for failure in failures:
        print(failure)
    if args.report:
        args.report.write_text(json.dumps([failure.__dict__ for failure in failures], indent=2) + "\n")
    questions = {(failure.paper, failure.question_number) for failure in failures}
    print(f"{len(failures)} failure(s) across {len(questions)} question(s)" if failures else "OK: no failures")
    raise SystemExit(1 if failures else 0)


if __name__ == "__main__":
    main()
