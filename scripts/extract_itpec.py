#!/usr/bin/env python3
"""Extract ITPEC FE questions and answer keys from PDFs.

Uses the PDF text layer when present and PyMuPDF's Tesseract OCR fallback for
sparse pages. It also renders question regions, preserving diagrams and layout.
"""
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

import pymupdf

VERSION = "3.0"
Q_RE = re.compile(r"(?m)^\s*Q\s*(\d{1,2})(?:\.|\s)\s*")
CHOICE_RE = re.compile(r"(?<![A-Za-z])([a-i])(?:\)|(?=\s+\d))\s*")
FOOTER_RE = re.compile(r"(?m)^\s*FE Exam - (?:Morning|Afternoon).*?\d+\s*$")

# Source-specific visual boundaries for layouts where generic vector grouping
# cannot distinguish a diagram from nearby prose or graphical answer choices.
PAGE_FIGURE_OVERRIDES: dict[tuple[str, str, int, int], list[tuple[float, float, float, float]]] = {
    ("2021-april", "A", 8, 5): [(70, 532, 525, 676)],
    ("2021-april", "A", 21, 9): [(90, 500, 525, 593)],
    ("2021-april", "A", 22, 10): [
        (75, 130, 295, 228),   # a
        (295, 130, 525, 228),  # b
        (75, 222, 295, 318),   # c
        (295, 222, 525, 318),  # d
    ],
    ("2021-april", "A", 46, 17): [(120, 492, 480, 590)],
    # Legacy PM paper: keep the full Table 8 excerpt, discard the dashed
    # placeholder repeated later in prose.
    ("2021-april", "B", 1, 3): [],
    ("2021-april", "B", 1, 4): [],
    ("2021-april", "B", 1, 5): [(70, 470, 525, 735)],
    ("2021-april", "B", 1, 6): [],
    # Q2 figures/tables with exact captions and no following paragraphs.
    ("2021-april", "B", 2, 7): [],
    ("2021-april", "B", 2, 8): [],
    ("2021-april", "B", 2, 9): [
        (82, 288, 530, 373),
        (100, 428, 500, 535),
        (82, 660, 525, 730),
    ],
    ("2021-april", "B", 2, 10): [(90, 140, 510, 255)],
    ("2021-april", "B", 4, 15): [(75, 260, 525, 558)],
    ("2021-april", "B", 5, 19): [(130, 298, 475, 646)],
    ("2021-april", "B", 6, 24): [(145, 360, 430, 525)],
}


def page_text(page: pymupdf.Page, ocr_language: str) -> tuple[str, str]:
    text = page.get_text("text", sort=True).strip()
    if len(text) >= 80:
        return text, "native_text"
    try:
        tp = page.get_textpage_ocr(language=ocr_language, dpi=300, full=True)
        return page.get_text("text", textpage=tp, sort=True).strip(), "tesseract_ocr"
    except RuntimeError as exc:
        raise RuntimeError(
            "OCR is required for a sparse page. Install Tesseract and its English "
            f"language data, then retry. Original error: {exc}"
        ) from exc


def clean(text: str) -> str:
    text = FOOTER_RE.sub("", text).replace("\u00ad", "")
    text = re.sub(r"(?<=\w)-\n\s*(?=\w)", "", text)
    text = re.sub(r"[ \t]+", " ", text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()


def normalize_placeholders(text: str) -> str:
    return re.sub(r"_{2,}\s*([A-Z])\s*_{2,}", r"***\1***", text)


def semantic_subject_b(question_text: str, choices: list[dict], blocks: list[dict]) -> tuple[str, list[dict], list[dict]]:
    """Represent Subject-B prose, programs, and answer matrices semantically."""
    before_program, marker, _rest = question_text.partition("[Program]")
    paragraphs = [normalize_placeholders(part.strip()) for part in re.split(r"\n\s*\n", before_program) if part.strip()]
    semantic = []
    if paragraphs:
        semantic.append({"type": "prompt", "text": paragraphs[0]})
    if len(paragraphs) > 1:
        semantic.append({"type": "context", "text": "\n\n".join(paragraphs[1:])})

    code_blocks = [block for block in blocks if block["type"] == "code"]
    if marker and code_blocks:
        program = "\n".join(block["text"] for block in code_blocks)
        semantic.append({"type": "code", "language": "itpec-pseudocode", "text": normalize_placeholders(program)})

    answer_table = None
    for block in blocks:
        rows = block.get("rows")
        if block["type"] != "table" or not rows or len(rows[0]) < 2:
            continue
        headers = [clean(str(cell or "")) for cell in rows[0][1:]]
        if not headers or not all(re.fullmatch(r"[A-Z]", header) for header in headers):
            continue
        table_rows = []
        for row in rows[1:]:
            label = clean(str(row[0] or "")).rstrip(")")
            if not re.fullmatch(r"[a-h]", label):
                continue
            values = []
            for cell in row[1:len(headers) + 1]:
                value = clean(str(cell or ""))
                value = re.sub(r"\bm\s+c\s*([<>])\s*c\s*_?", r"m_c \1 c", value)
                values.append(value)
            table_rows.append({"label": label, "values": dict(zip(headers, values))})
        if table_rows:
            answer_table = {"type": "answer_table", "columns": headers, "rows": table_rows}
            break
    if answer_table:
        semantic.append(answer_table)
        values_by_label = {row["label"]: row["values"] for row in answer_table["rows"]}
        for choice in choices:
            if choice["label"] in values_by_label:
                choice["values"] = values_by_label[choice["label"]]

    normalized_question = normalize_placeholders("\n\n".join(paragraphs))
    return normalized_question, choices, semantic or blocks


def answers(path: Path) -> dict[int, str | list[dict]]:
    doc = pymupdf.open(path)
    words = doc[0].get_text("words", sort=False)
    header = doc[0].get_text("text", sort=True)
    if re.search(r"\bQ\s+SQ\s+BQ\b", header):
        rows: dict[int, list[dict]] = {}
        current_q = current_sq = None
        current_blank = None
        by_line: dict[int, list[tuple[float, str]]] = {}
        for x0, y0, _x1, _y1, word, *_ in words:
            if y0 < 90:
                continue
            by_line.setdefault(round(y0 / 3), []).append((x0, word))
        for line in sorted(by_line):
            cells = sorted(by_line[line])
            answer = None
            for x, word in cells:
                if x < 115 and word.isdigit():
                    current_q = int(word)
                elif 120 <= x < 155 and word.isdigit():
                    current_sq = int(word)
                elif 160 <= x < 195 and re.fullmatch(r"[A-Z]", word):
                    current_blank = word
                elif x >= 200 and re.fullmatch(r"[a-i]", word):
                    answer = word
            if current_q is not None and answer is not None:
                rows.setdefault(current_q, []).append({
                    "subquestion": current_sq,
                    "blank": current_blank,
                    "answer": answer,
                })
                current_blank = None
        return rows
    candidates: list[tuple[float, float, str]] = []
    for x0, y0, _x1, _y1, word, *_ in words:
        if re.fullmatch(r"(?:[1-9]|[1-5]\d|60)", word) or re.fullmatch(r"[a-i]", word):
            candidates.append((x0, y0, word))
    result: dict[int, str] = {}
    numbers = [w for w in candidates if w[2].isdigit()]
    letters = [w for w in candidates if re.fullmatch(r"[a-i]", w[2])]
    for x, y, number in numbers:
        near = sorted(letters, key=lambda w: abs(w[1] - y) * 10 + abs(w[0] - x))
        same_row = [w for w in near if abs(w[1] - y) < 5 and w[0] > x]
        if same_row:
            result[int(number)] = min(same_row, key=lambda w: w[0] - x)[2]
    return result


def split_choices(chunk: str) -> tuple[str, list[dict[str, str]]]:
    # Choices are frequently laid out in columns and become one physical line.
    # Prefer the explicit Subject-B marker; otherwise choose the last complete
    # a..d sequence, avoiding incidental "a)" references in the question body.
    choice_area_start = chunk.rfind("Answer group")
    search_start = choice_area_start if choice_area_start >= 0 else 0
    candidates = list(CHOICE_RE.finditer(chunk, search_start))
    matches = []
    for start_index, candidate in enumerate(candidates):
        if candidate.group(1) != "a":
            continue
        sequence = [candidate]
        expected = ord("b")
        for following in candidates[start_index + 1:]:
            if ord(following.group(1)) == expected:
                sequence.append(following)
                expected += 1
            elif following.group(1) == "a":
                break
        if len(sequence) >= 4:
            matches = sequence
    if not matches:
        return clean(chunk), []
    question_end = choice_area_start if choice_area_start >= 0 else matches[0].start()
    question = clean(chunk[:question_end])
    choices = []
    for index, match in enumerate(matches):
        end = matches[index + 1].start() if index + 1 < len(matches) else len(chunk)
        choices.append({"label": match.group(1), "text": clean(chunk[match.end():end])})
    return question, choices


def question_clips(doc: pymupdf.Document, start_page: int, end_page: int,
                   number: int, next_number: int | None) -> list[tuple[int, pymupdf.Rect]]:
    """Return tight per-page rectangles for a possibly multi-page question."""
    clips = []
    for page_index in range(start_page, end_page + 1):
        page = doc[page_index]
        top, bottom = 28.0, page.rect.height - 34.0  # exclude running header/footer
        if page_index == start_page:
            hits = page.search_for(f"Q{number}.") or page.search_for(f"Q{number}")
            if hits:
                top = max(0.0, hits[0].y0 - 8.0)
        if page_index == end_page and next_number is not None:
            hits = page.search_for(f"Q{next_number}.") or page.search_for(f"Q{next_number}")
            if hits:
                bottom = min(bottom, hits[0].y0 - 8.0)
        if bottom > top:
            clips.append((page_index, pymupdf.Rect(18.0, top, page.rect.width - 18.0, bottom)))
    return clips


def structured_blocks(page: pymupdf.Page, clip: pymupdf.Rect, page_number: int) -> list[dict]:
    """Extract ordered text/code blocks and vector-detected tables from a region."""
    result = []
    data = page.get_text("dict", clip=clip, sort=True)
    for block in data.get("blocks", []):
        if block.get("type") != 0:
            continue
        spans = [span for line in block.get("lines", []) for span in line.get("spans", [])]
        text = "\n".join(
            "".join(span.get("text", "") for span in line.get("spans", [])).rstrip()
            for line in block.get("lines", [])
        ).strip()
        if not text:
            continue
        fonts = " ".join(span.get("font", "").lower() for span in spans)
        code_signals = sum(token in text for token in ("←", "procedure(", "function(", "if (", "while (", "return ", "[Program]"))
        kind = "code" if "mono" in fonts or "courier" in fonts or code_signals >= 2 else "text"
        bbox = [round(value, 2) for value in block["bbox"]]
        result.append({"type": kind, "page": page_number, "bbox": bbox, "text": text})

    # PyMuPDF table detection preserves rows/cells for real ruled tables.
    try:
        tables = page.find_tables(clip=clip)
        for table in tables.tables:
            rows = table.extract()
            if rows:
                result.append({
                    "type": "table", "page": page_number,
                    "bbox": [round(value, 2) for value in table.bbox], "rows": rows,
                })
    except (TypeError, ValueError):
        # Some PDFs contain vector paths that cannot form a valid table grid.
        pass
    result.sort(key=lambda block: (block["page"], block["bbox"][1], block["bbox"][0]))
    return result


def visual_regions(page: pymupdf.Page, question_clip: pymupdf.Rect) -> list[pymupdf.Rect]:
    """Locate figures/diagrams while excluding table grids and ordinary text."""
    table_rects = []
    try:
        table_rects = [pymupdf.Rect(table.bbox) for table in page.find_tables(clip=question_clip).tables]
    except (TypeError, ValueError):
        pass

    seeds = []
    placeholder_zones = []
    page_dict = page.get_text("dict", clip=question_clip)
    for block in page_dict.get("blocks", []):
        for line in block.get("lines", []):
            spans = line.get("spans", [])
            line_text = "".join(span.get("text", "") for span in spans)
            semantic_blank = re.search(r"_{2,}\s*[A-H]\s*_{2,}", line_text)
            empty_box_phrase = re.search(
                r"inserted\s+into|produce\s+the\s+output|output\s+is\s+in\s+the\s+order",
                line_text, re.I,
            )
            if semantic_blank or empty_box_phrase:
                placeholder_zones.append(pymupdf.Rect(line["bbox"]) + (-8, -8, 8, 8))
    # Detect small rectangular blanks geometrically, independent of wording.
    # Their borders are often encoded as several black filled rectangles.
    raw_drawings = []
    for drawing in page.get_drawings():
        rect = pymupdf.Rect(drawing["rect"]) & question_clip
        if not rect.is_empty:
            raw_drawings.append((rect, drawing))
    box_groups: list[tuple[pymupdf.Rect, list[dict]]] = []
    for rect, drawing in raw_drawings:
        merged_at = None
        for index, (group_rect, members) in enumerate(box_groups):
            if ((group_rect + (-2, -2, 2, 2)) & rect).get_area() > 0:
                merged_at = index
                group_rect |= rect
                members.append(drawing)
                box_groups[index] = (group_rect, members)
                break
        if merged_at is None:
            box_groups.append((rect, [drawing]))
    for rect, members in box_groups:
        if not (18 <= rect.width <= 110 and 7 <= rect.height <= 32):
            continue
        if not all(all(item[0] == "re" for item in member.get("items", [])) for member in members):
            continue
        inside = re.sub(r"[_\s]", "", page.get_text("text", clip=rect)).strip()
        if not inside or re.fullmatch(r"[A-H]", inside):
            placeholder_zones.append(rect + (-3, -3, 3, 3))
    # Raster figures are explicit image blocks.
    for block in page_dict.get("blocks", []):
        if block.get("type") == 1:
            seeds.append(pymupdf.Rect(block["bbox"]) & question_clip)
    # Vector figures are sets of paths. Table paths are deliberately excluded.
    for drawing in page.get_drawings():
        stroke = drawing.get("color")
        fill = drawing.get("fill")
        # Invisible white rectangles behind answer text are PDF layout
        # artifacts, not figures (A-Q13 contains one of these).
        white_fill = fill is not None and all(channel >= 0.97 for channel in fill[:3])
        if stroke is None and (fill is None or white_fill):
            continue
        rect = pymupdf.Rect(drawing["rect"]) & question_clip
        if rect.is_empty or rect.width < 1 or rect.height < 1:
            continue
        if any((rect & zone).get_area() > 0 for zone in placeholder_zones):
            continue
        if any((rect & table).get_area() >= rect.get_area() * 0.8 for table in table_rects):
            continue
        seeds.append(rect)

    # Connected-component merge with enough tolerance for arrows and labels.
    regions: list[pymupdf.Rect] = []
    for seed in seeds:
        expanded = seed + (-10, -10, 10, 10)
        touching = [index for index, region in enumerate(regions) if (region & expanded).get_area() > 0]
        if not touching:
            regions.append(seed)
            continue
        merged = seed
        for index in reversed(touching):
            merged |= regions.pop(index)
        regions.append(merged)

    # Merge transitively, then include nearby label text (state names, edge weights, etc.).
    changed = True
    while changed:
        changed = False
        for i in range(len(regions)):
            for j in range(i + 1, len(regions)):
                if ((regions[i] + (-10, -10, 10, 10)) & regions[j]).get_area() > 0:
                    regions[i] |= regions.pop(j)
                    changed = True
                    break
            if changed:
                break
    raw_text_blocks = page.get_text("blocks", clip=question_clip)
    section_heading = re.compile(r"^\s*(?:\[Program\]|Answer group)\s*$", re.I)
    text_blocks = [
        pymupdf.Rect(block[:4]) for block in raw_text_blocks
        if not section_heading.match(block[4])
    ]
    caption_rects = [pymupdf.Rect(block[:4]) for block in raw_text_blocks if re.match(r"^\s*Figure\s+\d+", block[4])]
    output = []
    for region in regions:
        if region.get_area() < 250:  # ignore isolated decorative marks
            continue
        label_zone = region + (-14, -14, 14, 14)
        for text_rect in text_blocks:
            if (label_zone & text_rect).get_area() > 0 and text_rect.width < region.width * 1.6:
                region |= text_rect
        region = (region + (-8, -8, 8, 8)) & question_clip
        output.append(region)
    # Labels can bridge components only after their bounding boxes are included
    # (common in flowcharts: a decision diamond, its branch label, then a box).
    # Perform a final transitive merge on those enriched regions.
    changed = True
    while changed:
        changed = False
        for i in range(len(output)):
            for j in range(i + 1, len(output)):
                a, b = output[i], output[j]
                horizontal_overlap = max(0.0, min(a.x1, b.x1) - max(a.x0, b.x0))
                vertical_gap = max(0.0, max(a.y0, b.y0) - min(a.y1, b.y1))
                vertical_overlap = max(0.0, min(a.y1, b.y1) - max(a.y0, b.y0))
                horizontal_gap = max(0.0, max(a.x0, b.x0) - min(a.x1, b.x1))
                same_flow = (
                    horizontal_overlap >= min(a.width, b.width) * 0.25 and vertical_gap <= 24
                ) or (
                    # Parallel lanes / timing columns in one diagram can have a
                    # wider gutter than flowchart nodes (A-Q08).
                    vertical_overlap >= min(a.height, b.height) * 0.60 and horizontal_gap <= 45
                )
                if (a & b).get_area() > 0 or same_flow:
                    output[i] |= output.pop(j)
                    changed = True
                    break
            if changed:
                break
    # After columns/lanes have merged, include labels positioned outside the
    # vector bounds (for example Q08's left-side interrupt labels and right-side
    # time-axis caption). They could not be associated with one lane earlier.
    for index, region in enumerate(output):
        for text_rect in text_blocks:
            vertical_overlap = max(0.0, min(region.y1, text_rect.y1) - max(region.y0, text_rect.y0))
            horizontal_gap = max(0.0, max(region.x0, text_rect.x0) - min(region.x1, text_rect.x1))
            if vertical_overlap >= text_rect.height * 0.5 and horizontal_gap <= 100:
                region |= text_rect
        for caption_rect in caption_rects:
            horizontal_overlap = max(0.0, min(region.x1, caption_rect.x1) - max(region.x0, caption_rect.x0))
            vertical_gap = max(0.0, caption_rect.y0 - region.y1)
            is_below_figure = caption_rect.y0 >= region.y1 - 3
            if is_below_figure and horizontal_overlap >= min(region.width, caption_rect.width) * 0.30 and vertical_gap <= 35:
                region |= caption_rect
        output[index] = region
    # The PDF path bbox can omit stroke caps / arrowhead edges by a few points.
    # Apply padding only after the final union so the complete connected figure
    # receives one consistent safety boundary.
    output = [(region + (-30, -14, 30, 14)) & question_clip for region in output]
    for index, region in enumerate(output):
        for caption_rect in caption_rects:
            horizontal_overlap = max(0.0, min(region.x1, caption_rect.x1) - max(region.x0, caption_rect.x0))
            vertical_gap = max(0.0, caption_rect.y0 - region.y1)
            if caption_rect.y0 >= region.y0 and vertical_gap <= 35 and horizontal_overlap > 0:
                region |= caption_rect + (-8, -4, 8, 4)
        output[index] = region & question_clip
    return sorted(output, key=lambda rect: (rect.y0, rect.x0))


def extract(subject: str, question_pdf: Path, answer_pdf: Path, output: Path,
            exam_session: str = "2025-october") -> list[dict]:
    doc = pymupdf.open(question_pdf)
    pages = []
    for index, page in enumerate(doc):
        text, method = page_text(page, "eng")
        pages.append({"page": index + 1, "text": text, "method": method})

    candidates: dict[int, list[tuple[int, int]]] = {}
    for page_index, page in enumerate(pages):
        for match in Q_RE.finditer(page["text"]):
            candidates.setdefault(int(match.group(1)), []).append((page_index, match.start()))
    key = answers(answer_pdf)
    expected = list(range(1, max(key, default=0) + 1))
    if sorted(key) != expected:
        raise ValueError(f"Incomplete answer key in {answer_pdf.name}: found {sorted(key)}")
    starts: list[tuple[int, int, int]] = []
    previous = (-1, -1)
    for number in expected:
        options = sorted(candidates.get(number, []))
        valid = [position for position in options if position > previous]
        if not valid:
            raise ValueError(f"Could not locate Q{number} in {question_pdf.name}")
        # Intro pages sometimes contain a sample Q1. Choose the final Q1 that
        # still appears before Q2; all later question numbers are sequential.
        if number == 1 and candidates.get(2):
            first_q2 = min(candidates[2])
            before_q2 = [position for position in valid if position < first_q2]
            chosen = max(before_q2) if before_q2 else valid[0]
        else:
            chosen = valid[0]
        starts.append((number, chosen[0], chosen[1]))
        previous = chosen

    image_dir = output / "images"
    image_dir.mkdir(parents=True, exist_ok=True)
    rows = []
    for idx, (number, start_page, start_offset) in enumerate(starts):
        if idx + 1 < len(starts):
            _next_no, next_page, next_offset = starts[idx + 1]
            if next_page == start_page:
                end_page, end_offset = next_page, next_offset
            else:
                end_page, end_offset = next_page - 1, len(pages[next_page - 1]["text"])
        else:
            end_page, end_offset = len(pages) - 1, len(pages[-1]["text"])
        chunks = []
        for page_index in range(start_page, end_page + 1):
            begin = start_offset if page_index == start_page else 0
            end = end_offset if page_index == end_page else len(pages[page_index]["text"])
            chunks.append(pages[page_index]["text"][begin:end])
        raw = clean("\n\n".join(chunks))
        question, choices = split_choices(raw)

        image_paths = []
        content_blocks = []
        next_number = starts[idx + 1][0] if idx + 1 < len(starts) and starts[idx + 1][1] == end_page else None
        figure_number = 0
        for _part, (page_index, clip) in enumerate(question_clips(doc, start_page, end_page, number, next_number), 1):
            page = doc[page_index]
            override_key = (exam_session, subject, number, page_index + 1)
            if override_key in PAGE_FIGURE_OVERRIDES:
                figure_clips = [pymupdf.Rect(values) & clip for values in PAGE_FIGURE_OVERRIDES[override_key]]
            else:
                figure_clips = visual_regions(page, clip)
            for figure_clip in figure_clips:
                figure_number += 1
                filename = f"{exam_session}-{subject.lower()}-q{number:02d}-figure{figure_number}.webp"
                pix = page.get_pixmap(dpi=160, alpha=False, clip=figure_clip)
                pix.pil_image().save(image_dir / filename, format="WEBP", quality=86, method=6)
                image_paths.append(filename)
            content_blocks.extend(structured_blocks(page, clip, page_index + 1))
        if (exam_session, subject, number) == ("2021-april", "A", 22):
            for index, choice in enumerate(choices[:4]):
                choice["image"] = image_paths[index]
        if subject == "B":
            question, choices, content_blocks = semantic_subject_b(question, choices, content_blocks)
        rows.append({
            "exam_session": exam_session, "subject": subject,
            "question_number": number, "question_text": question,
            "choices": choices,
            "correct_answer": key[number] if isinstance(key[number], str) else json.dumps(key[number]),
            "answer_key": {"value": key[number]} if isinstance(key[number], str) else {"parts": key[number]},
            "images": image_paths, "source_file": question_pdf.name,
            "source_citation": f"({exam_session.split('-')[0]}{'S' if exam_session.endswith('april') else 'A'}, FE, Subject-{subject}, Q{number})",
            "source_pages": list(range(start_page + 1, end_page + 2)),
            "extraction_method": "ocr" if any(pages[p]["method"] != "native_text" for p in range(start_page, end_page + 1)) else "native_text",
            "extraction_version": VERSION, "source_text": raw,
            "content_blocks": content_blocks,
            "ref_doc": {
                "question_pdf": {
                    "filename": question_pdf.name,
                    "storage_path": f"{exam_session}/{subject.lower()}/{question_pdf.name}",
                    "pages": list(range(start_page + 1, end_page + 2)),
                },
                "answer_pdf": {
                    "filename": answer_pdf.name,
                    "storage_path": f"{exam_session}/{subject.lower()}/{answer_pdf.name}",
                    "pages": [1],
                },
            },
        })
    return rows


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-dir", type=Path, required=True)
    parser.add_argument("--output-dir", type=Path, default=Path("scripts/output/2025A_FE"))
    parser.add_argument("--exam-session", default="2025-october")
    args = parser.parse_args()
    args.output_dir.mkdir(parents=True, exist_ok=True)
    all_rows = []
    for subject in ("A", "B"):
        rows = extract(subject, args.input_dir / f"2025A_FE-{subject}_Questions.pdf", args.input_dir / f"2025A_FE-{subject}_Answers.pdf", args.output_dir, args.exam_session)
        (args.output_dir / f"questions-{subject.lower()}.json").write_text(json.dumps(rows, ensure_ascii=False, indent=2) + "\n")
        all_rows.extend(rows)
    (args.output_dir / "questions.json").write_text(json.dumps(all_rows, ensure_ascii=False, indent=2) + "\n")
    print(f"Extracted {len(all_rows)} questions to {args.output_dir}")


if __name__ == "__main__":
    main()
