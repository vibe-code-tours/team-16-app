#!/usr/bin/env python3
"""Build normalized FE resources from official ITPEC ZIP archives (2021-2025)."""
from __future__ import annotations

import argparse
import json
import shutil
import tempfile
import urllib.request
import zipfile
from pathlib import Path

from extract_itpec import extract
from itpec_overrides import apply_overrides, load_overrides

BASE_URL = "https://itpec.org/pastexamqa/fe"
DEFAULT_PUBLIC_IMAGES_DIR = Path("src/web/public/question-images")


def publish_figures(image_dir: Path, public_dir: Path, exam_session: str, subject: str) -> None:
    """Mirror one paper's figures into the web app's static folder."""
    public_dir.mkdir(parents=True, exist_ok=True)
    for stale in public_dir.glob(f"{exam_session}-{subject.lower()}-q*.webp"):
        stale.unlink()
    for figure in image_dir.glob("*.webp"):
        shutil.copy2(figure, public_dir / figure.name)


def find_pdf(files: list[Path], subject: str, kind: str) -> Path:
    paper = "AM" if subject == "A" else "PM"
    subject_token = f"-{subject}_"
    kind_tokens = ("question",) if kind == "questions" else ("answer",)
    matches = []
    for path in files:
        name = path.name.lower()
        modern = subject_token.lower() in name
        legacy = f"_{paper.lower()}_" in name
        if (modern or legacy) and any(token in name for token in kind_tokens):
            matches.append(path)
    if len(matches) != 1:
        raise RuntimeError(f"Expected one {subject} {kind} PDF, found {matches}")
    return matches[0]


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output-dir", type=Path, default=Path("resources/exams"))
    parser.add_argument("--archive-dir", type=Path)
    parser.add_argument("--year", type=int, choices=range(2021, 2026))
    parser.add_argument("--season", choices=("April", "October"))
    parser.add_argument("--subject", choices=("A", "B"))
    parser.add_argument("--public-images-dir", type=Path, default=DEFAULT_PUBLIC_IMAGES_DIR,
                        help="web app folder that serves question figures")
    args = parser.parse_args()
    overrides_dir = args.output_dir / "overrides"
    args.output_dir.mkdir(parents=True, exist_ok=True)

    with tempfile.TemporaryDirectory(prefix="itpec-fe-") as temp_name:
        temp = Path(temp_name)
        manifest_path = args.output_dir / "index.json"
        manifest = json.loads(manifest_path.read_text()) if manifest_path.exists() else []
        for year in range(2021, 2026):
            if args.year and year != args.year:
                continue
            for code, season in (("S", "April"), ("A", "October")):
                if args.season and season != args.season:
                    continue
                archive_name = f"{year}{code}_FE.zip"
                archive = (args.archive_dir / archive_name) if args.archive_dir else temp / archive_name
                if not archive.exists():
                    urllib.request.urlretrieve(f"{BASE_URL}/{archive_name}", archive)
                extract_dir = temp / archive.stem
                with zipfile.ZipFile(archive) as bundle:
                    bundle.testzip()
                    bundle.extractall(extract_dir)
                pdfs = list(extract_dir.rglob("*.pdf"))
                for subject in ("A", "B"):
                    if args.subject and subject != args.subject:
                        continue
                    resource_name = f"{year}-{season}-{subject}"
                    resource_dir = args.output_dir / resource_name
                    if resource_dir.exists():
                        shutil.rmtree(resource_dir)
                    resource_dir.mkdir(parents=True, exist_ok=True)
                    question_source = find_pdf(pdfs, subject, "questions")
                    answer_source = find_pdf(pdfs, subject, "answers")
                    question_pdf = resource_dir / "questions.pdf"
                    answer_pdf = resource_dir / "answers.pdf"
                    shutil.copy2(question_source, question_pdf)
                    shutil.copy2(answer_source, answer_pdf)
                    exam_session = f"{year}-{season.lower()}"
                    rows = extract(subject, question_pdf, answer_pdf, resource_dir, exam_session)
                    corrected = apply_overrides(
                        rows, load_overrides(overrides_dir, resource_name), question_pdf, resource_dir / "images"
                    )
                    publish_figures(resource_dir / "images", args.public_images_dir, exam_session, subject)
                    (resource_dir / "questions.json").write_text(
                        json.dumps(rows, ensure_ascii=False, indent=2) + "\n"
                    )
                    manifest = [item for item in manifest if item["name"] != resource_name]
                    manifest.append({
                        "name": resource_name,
                        "exam_session": exam_session,
                        "subject": subject,
                        "question_count": len(rows),
                        "figure_count": len(list((resource_dir / "images").glob("*.webp"))),
                        "source_url": f"{BASE_URL}/{archive_name}",
                    })
                    print(f"Built {resource_name}: {len(rows)} questions, {corrected} corrected by override")
        manifest.sort(key=lambda item: item["name"])
        manifest_path.write_text(json.dumps(manifest, indent=2) + "\n")


if __name__ == "__main__":
    main()
