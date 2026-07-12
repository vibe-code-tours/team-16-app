# PDF Extraction Reference

Detailed internals of `scripts/extract_itpec.py` — the core extraction engine.

## Table of contents

- [How it works](#how-it-works)
- [Question detection](#question-detection)
- [Answer parsing](#answer-parsing)
- [Legacy Subject B](#legacy-subject-b)
- [Content blocks](#content-blocks)
- [Provenance and references](#provenance-and-references)
- [Validation checklist](#validation-checklist)

## How it works

The extraction uses PyMuPDF (fitz) to read PDFs:

1. **Native text first** — extract text from the PDF's embedded text layer.
2. **OCR fallback** — if a page has too little text (scanned page), use Tesseract.
3. **Coordinate tracking** — text positions are used for answer-key parsing and figure placement.
4. **Vector path analysis** — drawing commands identify figures and diagrams.

Why native first: it preserves formulas and Unicode characters better than unnecessary OCR.

## Question detection

The parser detects question headings with regex:

```python
Q_RE = re.compile(r"(?m)^\s*Q\s*(\d{1,2})(?:\.|\s)\s*")
```

Matches: `Q1.`, `Q 1`, `Q8`, etc.

### Problem: instruction pages with sample Q1

Some PDFs have a sample question on instruction pages. The parser handles this by:

1. Collecting all question-heading candidates across pages
2. Using the answer key to determine expected question count
3. Selecting a monotonic Q1…Qn sequence
4. Choosing the final valid Q1 before Q2

## Answer parsing

### Subject A (modern)

Simple answer sheet — one letter per question:

```
Q | Answer
1 | b
2 | a
...
```

Parsed using word coordinates to match answer positions to question numbers.

### Subject B (modern, 2024–2025)

20 questions, answers through option `i` (not just `a–d`):

```python
CHOICE_RE = re.compile(r"(?<![A-Za-z])([a-i])(?:\)|(?=\s+\d))\s*")
```

### Subject B (legacy, 2021–2023)

Multipart format — each top-level question has sub-questions:

```
Q | SQ | BQ | Correct Answer
1 |  1 |  A | c
1 |  2 |  B | a
```

Parsed into structured `answer_key`:

```json
{
  "parts": [
    { "subquestion": 1, "blank": "A", "answer": "c" },
    { "subquestion": 2, "blank": "B", "answer": "a" }
  ]
}
```

The structured value is stored in `answer_key`. A serialized value remains in
`correct_answer` for compatibility with the application model.

## Content blocks

Subject B questions use semantic block types instead of screenshots:

| Type | Purpose | Example |
|---|---|---|
| `prompt` | Question text or instruction | "Consider the following program..." |
| `context` | Background information | "Given the following table..." |
| `code` | Pseudocode or program | Line breaks and indentation preserved |
| `answer_table` | Multi-column answer choices | Columns and labeled rows |
| `figure` | Reference to a cropped image | Points to a `.webp` file |

### Code blocks

Programs retain formatting:

```json
{
  "type": "code",
  "language": "itpec-pseudocode",
  "text": "○ integer: findMode(integer []: arr)\n  // body\n  return arr[0]"
}
```

### Answer tables

Multi-column answer choices:

```json
{
  "type": "answer_table",
  "columns": ["A", "B"],
  "rows": [
    {
      "label": "a",
      "values": {
        "A": "arr[i] = arr[j]",
        "B": "m < arr[i]"
      }
    }
  ]
}
```

### Program blanks

Normalized as `***A***`, `***B***`, etc., so the UI can highlight answer positions.

## Provenance and references

Every question includes traceability back to the official source:

```json
{
  "source_file": "questions.pdf",
  "source_citation": "ITPEC FE April 2021 Subject A",
  "source_pages": [5],
  "extraction_method": "native",
  "extraction_version": "3.0",
  "source_text": "Original extracted text...",
  "ref_doc": {
    "question_pdf": {
      "filename": "questions.pdf",
      "storage_path": "2021-april/a/questions.pdf",
      "pages": [5]
    },
    "answer_pdf": {
      "filename": "answers.pdf",
      "storage_path": "2021-april/a/answers.pdf",
      "pages": [1]
    }
  }
}
```

The subject directory in `storage_path` prevents A/B PDF filename collisions.

## Validation checklist

- [ ] Question numbers are continuous (Q1…Qn, no gaps)
- [ ] All choices present (Subject A: 4, Subject B: up to 9)
- [ ] Correct answer matches official answer key
- [ ] `content_blocks` types are valid (`prompt`, `context`, `code`, `answer_table`, `figure`)
- [ ] Code blocks preserve line breaks and indentation
- [ ] `answer_key` parts are complete for legacy Subject B
- [ ] `ref_doc` paths use subject-specific directories
- [ ] No encoding artifacts in Unicode/Japanese text
