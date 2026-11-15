"""Apply committed, human-reviewable corrections to extracted ITPEC questions.

PDF text extraction cannot recover maths set in fonts with broken Unicode maps
or answer choices that are drawings. Corrections live in
``resources/exams/overrides/{paper}.json`` and are re-applied on every build:

    {"questions": {"24": {
        "note": "why this override exists",
        "replacements": [{"find": "damaged", "replace": "corrected"}],
        "question_text": "full corrected text",
        "choices": [{"label": "a", "text": "...",
                     "figure": {"page": 9, "rect": [x0, y0, x1, y1]}}],
        "figures": [{"page": 9, "rect": [x0, y0, x1, y1]}]
    }}}

All keys except ``note`` are optional. ``page`` is 1-based and ``rect`` is in
PDF points. ``figures`` replaces the question's figures; a choice ``figure`` is
rendered to its own image and stored as the choice's ``image``.
"""
from __future__ import annotations

import json
from pathlib import Path

import pymupdf

FIGURE_DPI = 160
WEBP_QUALITY = 86
REVIEWED_METHOD = "manual_review"


def load_overrides(overrides_dir: Path, paper: str) -> dict:
    path = overrides_dir / f"{paper}.json"
    if not path.exists():
        return {}
    return json.loads(path.read_text()).get("questions", {})


def replace_in(value, replacements: list[dict]):
    """Apply find/replace pairs to every string nested inside ``value``."""
    if isinstance(value, str):
        for pair in replacements:
            value = value.replace(pair["find"], pair["replace"])
        return value
    if isinstance(value, list):
        return [replace_in(item, replacements) for item in value]
    if isinstance(value, dict):
        return {key: replace_in(item, replacements) for key, item in value.items()}
    return value


def render_region(doc: pymupdf.Document, region: dict, target: Path) -> None:
    page = doc[region["page"] - 1]
    clip = pymupdf.Rect(region["rect"]) & page.rect
    if clip.is_empty:
        raise ValueError(f"Empty figure region {region} for {target.name}")
    pixmap = page.get_pixmap(dpi=FIGURE_DPI, alpha=False, clip=clip)
    pixmap.pil_image().save(target, format="WEBP", quality=WEBP_QUALITY, method=6)


def apply_override(question: dict, override: dict, doc: pymupdf.Document, image_dir: Path) -> None:
    stem = f"{question['exam_session']}-{question['subject'].lower()}-q{question['question_number']:02d}"

    replacements = override.get("replacements", [])
    if replacements:
        for field in ("question_text", "choices", "content_blocks"):
            question[field] = replace_in(question[field], replacements)

    if "question_text" in override:
        question["question_text"] = override["question_text"]
        # Raw layout blocks would still carry the uncorrected text.
        question["content_blocks"] = [{"type": "text", "text": override["question_text"]}]

    if "figures" in override:
        for stale in image_dir.glob(f"{stem}-figure*.webp"):
            stale.unlink()
        names = []
        for index, region in enumerate(override["figures"], 1):
            name = f"{stem}-figure{index}.webp"
            render_region(doc, region, image_dir / name)
            names.append(name)
        question["images"] = names

    if "choices" in override:
        choices = []
        for entry in override["choices"]:
            choice = {key: value for key, value in entry.items() if key != "figure"}
            if "figure" in entry:
                name = f"{stem}-choice-{entry['label']}.webp"
                render_region(doc, entry["figure"], image_dir / name)
                choice["image"] = name
            choices.append(choice)
        question["choices"] = choices

    question["extraction_method"] = REVIEWED_METHOD


def apply_overrides(questions: list[dict], overrides: dict, question_pdf: Path, image_dir: Path) -> int:
    """Apply overrides in place; return how many questions were corrected."""
    if not overrides:
        return 0
    by_number = {str(question["question_number"]): question for question in questions}
    unknown = sorted(set(overrides) - set(by_number))
    if unknown:
        raise ValueError(f"Overrides reference questions that do not exist: {unknown}")
    doc = pymupdf.open(question_pdf)
    for number, override in overrides.items():
        apply_override(by_number[number], override, doc, image_dir)
    return len(overrides)
