---
name: extract-data
description: Full ITPEC FE data extraction pipeline — from official ZIP archives to Supabase-ready SQL seed data
---

# Skill: ITPEC FE Data Extraction Pipeline

Use this procedure to extract ITPEC FE exam questions from official PDF archives into
structured JSON, cropped figures, and one Supabase SQL seed file. This is the team's
biggest technical risk — PDF text extraction is lossy, so nothing reaches the seed
without passing the validation gate.

**Source:** https://itpec.org/pastexamqa/fe.html (one ZIP of PDFs per exam session)
**Docs:** `docs/flow_summary/data-extraction.md`
**Prerequisites:** Python 3.12+ with `pymupdf` and `Pillow` (`pip install -r requirements-extraction.txt`)

## Pipeline overview

```
Official ITPEC ZIP
  → build_itpec_resources.py     download, extract PDFs → questions.json + figures
      ├ extract_itpec.py           PDF parsing
      ├ itpec_overrides.py         apply resources/exams/overrides/*.json
      └ copies figures to src/web/public/question-images/
  → validate_itpec_resources.py  the gate: must report zero failures
  → resources/exams/enrichment/  subtopic + explanation per question (committed)
  → generate_exam_seed_sql.py    → supabase/seed_data/009_seed_exam_questions.sql
```

## Quick reference

| Step | Command |
|---|---|
| Build all papers | `python scripts/build_itpec_resources.py --archive-dir /tmp/itpec-fe-archives --output-dir resources/exams` |
| Build one paper | `... --year 2021 --season April --subject A` |
| Validate | `python scripts/validate_itpec_resources.py --require-enrichment --public-images-dir src/web/public/question-images` |
| Generate seed | `python scripts/generate_exam_seed_sql.py --all --output supabase/seed_data/009_seed_exam_questions.sql` |
| Run tests | `python -m pytest tests -v` |
| Apply seed | `psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f supabase/seed_data/009_seed_exam_questions.sql` |

## What is committed

| Path | Committed | Notes |
|---|---|---|
| `resources/exams/index.json` | yes | manifest of built papers |
| `resources/exams/overrides/*.json` | yes | corrections transcribed from the page image |
| `resources/exams/enrichment/*.json` | yes | AI-written subtopic + explanation, editable |
| `src/web/public/question-images/*.webp` | yes | figures served by the web app |
| `supabase/seed_data/009_seed_exam_questions.sql` | yes | generated — never hand-edit |
| `resources/exams/{Year}-{Season}-{A\|B}/` | no | PDFs, `questions.json`, images; rebuilt by the build |

## Procedure

### 1. Build

Run `scripts/build_itpec_resources.py`. Each paper folder gets `questions.pdf`,
`answers.pdf`, `questions.json` and `images/*.webp`; overrides are applied and figures are
copied to the web app.

Expected question counts: Subject A — 80 for 2021–2023 (legacy morning paper), 60 from
2024; Subject B — 8 for 2021–2023 (legacy, multi-part), 20 from 2024.

### 2. Validate

`validate_itpec_resources.py` fails on: wrong question count or numbering, an
instruction-page sample question, missing/empty choices, an answer that matches no choice,
characters from broken PDF font maps (maths set in Cambria Math or Symbol), page-number
footers left in a choice, a question that swallowed later questions, missing figure files,
and (with `--require-enrichment`) a missing or invalid subtopic/explanation.

**The gate cannot see everything.** A flattened table, choices whose text was swapped, or
a figure cropped too tightly all pass. New papers also need the visual check in step 4.

### 3. Repair failures with overrides

Fix systematic causes in `extract_itpec.py` first. For the rest, add an entry to
`resources/exams/overrides/{paper}.json` (format documented at the top of
`scripts/itpec_overrides.py`): corrected `question_text`, `choices`, find/replace
`replacements`, re-cropped `figures`, or a per-choice `figure` for choices that are
drawings. Transcribe from the rendered page, not from the broken text layer. Rebuild and
re-validate until the gate reports zero failures.

### 4. Visual check

For every Subject A question, compare the extracted text, choices and figure images with
the printed page. Correct real defects through overrides. Record in each override `note`
what was wrong.

### 5. Enrich

Write `resources/exams/enrichment/{paper}.json` with, per question, `subtopic_slug` (one
of the 20 in `SUBTOPIC_SLUGS`), `confidence`, and a 2–4 sentence `explanation` that agrees
with the official answer. These are AI-written and not ITPEC content; review and edit them
in place.

### 6. Generate and apply the seed

Generate with `--all`, then apply with `psql` and run the verification queries in
[references/seeding.md](references/seeding.md).

## Reference files

- **[references/extraction.md](references/extraction.md)** — PDF parsing, question/answer detection, content blocks, legacy Subject B, provenance
- **[references/figures.md](references/figures.md)** — Figure extraction, cropping, grouping, false positives, overrides
- **[references/seeding.md](references/seeding.md)** — SQL generation, column mapping, applying the seed, figures

## Known limits

| Limit | Detail |
|---|---|
| Subject B is not served by the app | Backend filters to Subject A with a single-letter answer |
| Legacy Subject B (2021–2023) text is incomplete | Long multi-page questions: later sub-questions and programs are often missing from `question_text`; `choices` holds only the last answer group |
| Modern Subject B choice text | Tabular answer groups can be jumbled in `text`; the per-blank `values` are reliable |
| Mistake Garden | Shows choice text only — a choice that is an image appears blank there |
| Sessions outside 2021–2025 | `build_itpec_resources.py` accepts 2021–2025; older ZIPs use different file naming |

## Common issues

| Issue | Fix |
|---|---|
| Sample Q1 from the instruction page in output | Pages containing `[Sample Question]` are skipped; check `INSTRUCTION_PAGE_RE` |
| Subject A paper stops at Q60 on a 2021–2023 paper | Answer-key numbers above 80 are rejected; check `ANSWER_NUMBER_RE` |
| Choices empty although printed | A misprinted label (two `c)`) or drawn choices — add an override |
| Garbled maths (`ܣ̅・ሺܣ + ܤതሻ`) | Broken font map — transcribe from the page in an override |
| Flowchart split into multiple figures | Use an override `figures` rectangle, or `PAGE_FIGURE_OVERRIDES` |
| `build_itpec_resources.py` can't find PDF in ZIP | PDFs have inconsistent naming — script uses AM/PM and subject tokens |
| Generator refuses to run | The gate has failures; run the validator for the list |
