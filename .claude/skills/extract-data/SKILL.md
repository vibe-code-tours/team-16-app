---
name: extract-data
description: Full ITPEC FE data extraction pipeline — from official ZIP archives to Supabase-ready SQL seed data
---

# Skill: ITPEC FE Data Extraction Pipeline

Use this procedure to extract ITPEC FE exam questions from official PDF archives into
structured JSON, cropped figures, and Supabase SQL seed files. This is the team's
biggest technical risk — follow each phase carefully.

**Source:** https://itpec.org/pastexamqa/fe.html
**Docs:** `docs/flow_summary/data-extraction.md`
**Prerequisites:** Python 3.12+ with `pymupdf` and `Pillow` (`pip install -r requirements-extraction.txt`)

## Pipeline overview

```
Official ITPEC ZIP
  → build_itpec_resources.py  (download, normalize, extract)
    → extract_itpec.py        (parse PDFs into JSON + figures)
  → generate_exam_seed_sql.py (JSON → SQL seed)
  → Supabase dashboard        (schema, upload assets, run seed)
```

## Quick reference

| Step | Command | Details |
|---|---|---|
| Build all | `python scripts/build_itpec_resources.py --archive-dir /tmp/itpec-fe-archives --output-dir resources/exams` | Downloads ZIPs, normalizes folders, runs extraction |
| Build one | `... --year 2021 --season April --subject A` | Targeted rebuild, preserves other manifest entries |
| Generate seed | `python scripts/generate_exam_seed_sql.py --resources-dir resources/exams --year 2021 --season April --output supabase/seed_data/2021-April-Exam.sql` | Combined A+B SQL per term |
| Run tests | `python -m pytest tests/test_extract_itpec.py -v` | Regression validation |

## Procedure

### 1. Build normalized resources

Run `scripts/build_itpec_resources.py` to download ZIPs, extract PDFs, run extraction,
and produce normalized folders under `resources/exams/`.

Each folder contains: `questions.pdf`, `answers.pdf`, `questions.json`, `images/*.webp`.
Manifest: `resources/exams/index.json`.

### 2. Verify extraction quality

- [ ] Question count matches expected (Subject A: 60, Subject B: 8 legacy / 20 modern)
- [ ] Question numbers continuous, no gaps or duplicates
- [ ] All choices present (A: a–d, B: up to a–i)
- [ ] Correct answer matches official answer key
- [ ] Figure references point to existing WebP files
- [ ] Figure names follow `{exam_session}-{subject}-q{number}-figure{n}.webp`
- [ ] Code blocks preserve formatting (line breaks, indentation)
- [ ] Content block types correct (`prompt`, `context`, `code`, `answer_table`, `figure`)
- [ ] `ref_doc` paths use subject-specific directories
- [ ] Extraction tests pass

### 3. Generate and verify SQL seed

```bash
python scripts/generate_exam_seed_sql.py \
  --resources-dir resources/exams --year 2021 --season April \
  --output supabase/seed_data/2021-April-Exam.sql
```

Verify: question count, exam definitions, ordered mappings, idempotent upserts, valid `::jsonb` fields.

### 4. Deploy to Supabase (browser-only)

1. **SQL Editor:** run `001_initial_schema.sql` (first time only)
2. **Storage → question-images:** upload all WebP figures
3. **Storage → exam-reference-docs:** upload original PDFs under `2021-april/{a,b}/`
4. **SQL Editor:** run the generated seed file
5. **Verify:** count queries confirm question rows, exam definitions, and mappings

## Reference files

- **[references/extraction.md](references/extraction.md)** — PDF parsing, question/answer detection, content blocks, legacy Subject B, provenance
- **[references/figures.md](references/figures.md)** — Figure extraction, cropping, grouping, false positives, overrides
- **[references/seeding.md](references/seeding.md)** — SQL generation, schema, deployment, storage layout

## Common issues

| Issue | Fix |
|---|---|
| Instruction page sample Q1 in output | Parser uses answer-key counts to select correct Q1 — re-run |
| Subject B has >4 choices (a–i) | Expected for modern format — parser supports a–i |
| Flowchart split into multiple figures | Check `PAGE_FIGURE_OVERRIDES` — may need manual crop region |
| Empty rectangular boxes stored as figures | Blank-placeholder detector should exclude — check false negative |
| `build_itpec_resources.py` can't find PDF in ZIP | PDFs have inconsistent naming — script uses AM/PM and subject tokens |
| SQL seed duplicate key errors | Upserts use `ON CONFLICT` — check if schema migration was applied |

## Human review checklist

1. Pick 10 random questions and compare against the original PDF.
2. Verify the answer key matches for all questions.
3. Confirm no questions were missed (count matches exam total).
4. Check for garbled text around technical terms.
5. Visually inspect cropped figures against original PDF.
6. Verify multipart Subject B answers have correct sub-parts.
