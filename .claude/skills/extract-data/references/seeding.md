# SQL Seed Generation Reference

How `scripts/generate_exam_seed_sql.py` produces one Supabase-ready SQL file from the
extracted papers.

## Table of contents

- [How it works](#how-it-works)
- [SQL structure](#sql-structure)
- [Column mapping](#column-mapping)
- [Idempotent upserts](#idempotent-upserts)
- [Schema overview](#schema-overview)
- [Applying the seed](#applying-the-seed)
- [Figures and reference PDFs](#figures-and-reference-pdfs)

## How it works

The generator reads every paper listed in `resources/exams/index.json` and joins three
inputs per paper:

| Input | Path | Committed? |
|---|---|---|
| Extracted questions | `resources/exams/{Year}-{Season}-{A\|B}/questions.json` | No — rebuilt by `build_itpec_resources.py` |
| Corrections | `resources/exams/overrides/{paper}.json` | Yes — already applied to `questions.json` by the build |
| Subtopic + explanation | `resources/exams/enrichment/{paper}.json` | Yes |

```bash
python scripts/generate_exam_seed_sql.py --all \
  --output supabase/seed_data/009_seed_exam_questions.sql
```

`--year 2021 --season April` writes a single term instead. Generation refuses to run while
`validate_itpec_resources.py --require-enrichment` reports any failure.

**Output:** `supabase/seed_data/009_seed_exam_questions.sql` — a generated file; never edit
it by hand.

## SQL structure

One transaction for the whole file. For each paper, in order:

```sql
BEGIN;

-- 2021 April FE Subject A: 80 questions
INSERT INTO questions (...) VALUES (...), (...)
ON CONFLICT (exam_session, subject, question_number) DO UPDATE SET ...;

DELETE FROM question_subtopics WHERE question_id IN (...this paper...);
INSERT INTO question_subtopics (question_id, subtopic_id, is_primary, confidence, classification_source)
SELECT q.id, s.id, true, v.confidence, 'llm' FROM (VALUES ...) ...;

INSERT INTO exams (...) VALUES (...) ON CONFLICT (exam_session, subject) DO UPDATE SET ...;
DELETE FROM exam_questions WHERE exam_id = (...);
INSERT INTO exam_questions (exam_id, question_id, sequence_number) SELECT ...;

-- next paper ...
COMMIT;
```

## Column mapping

| Source | DB column | Type |
|---|---|---|
| `exam_session`, `subject`, `question_number` | same | `text`, `text`, `integer` |
| `question_text` | `question_text` | `text` |
| `content_blocks`, `images`, `choices`, `answer_key`, `ref_doc` | same | `jsonb` |
| `correct_answer` | `correct_answer` | `text` |
| enrichment `explanation` | `explanation` | `text` |
| enrichment `subtopic_slug` | `subtopic_id` | `(SELECT id FROM subtopics WHERE slug = ...)` |
| `source_file`, `source_citation`, `source_text` | same | `text` |
| `source_pages` | `source_pages` | `integer[]` |
| `extraction_method` | `extraction_method` | `native_text`, or `manual_review` for overridden questions |
| `extraction_version` | `extraction_version` | `text` |

`difficulty` and `difficulty_score` are written but then overwritten by the
`set_question_difficulty` trigger (`20260715012200_difficulty_rules.sql`).

`images` holds bare filenames (`2021-april-a-q08-figure1.webp`); a choice that is a drawing
has `"image": "2022-october-a-q20-choice-a.webp"` and empty `text`.

## Idempotent upserts

- **Questions:** `ON CONFLICT (exam_session, subject, question_number) DO UPDATE` refreshes
  every generated column, including `explanation` and `subtopic_id`. Row ids and the usage
  counters (`times_answered`, `times_correct`) are left untouched.
- **Question subtopics:** deleted and re-inserted per paper, one primary link per question.
- **Exams:** `ON CONFLICT (exam_session, subject) DO UPDATE`.
- **Exam questions:** deleted and re-inserted per exam, ordered by question number.

Running the file twice leaves the same rows.

## Schema overview

Defined in `supabase/migrations/20260712122400_initial_schema.sql`. The seed writes to
`questions`, `question_subtopics`, `exams` and `exam_questions`, and reads `subtopics` (the
20 slugs are seeded by that migration and mirrored in `SUBTOPIC_SLUGS` in
`scripts/validate_itpec_resources.py`).

## Applying the seed

The file is several MB — too large for the dashboard SQL Editor. Use `psql`:

```bash
psql "$DATABASE_URL" -v ON_ERROR_STOP=1 -f supabase/seed_data/009_seed_exam_questions.sql
```

Migrations must already be applied. There is no `supabase/config.toml` seed wiring, so
`supabase db reset` does not load this file.

### Verification queries

```sql
SELECT exam_session, subject, COUNT(*) FROM questions
WHERE exam_session ~ '^20' GROUP BY 1, 2 ORDER BY 1, 2;

-- Subject A questions the app cannot serve (expect 0)
SELECT COUNT(*) FROM questions
WHERE subject = 'A' AND exam_session ~ '^20'
  AND (jsonb_array_length(choices) = 0 OR correct_answer !~ '^[a-z]$'
       OR subtopic_id IS NULL OR explanation IS NULL);

-- Exactly one primary subtopic per question (expect 0 rows)
SELECT question_id FROM question_subtopics WHERE is_primary
GROUP BY 1 HAVING COUNT(*) <> 1;
```

## Figures and reference PDFs

Figures are committed with the web app in `src/web/public/question-images/` (flat, named
`{session}-{subject}-q{NN}-figure{n}.webp` or `...-choice-{label}.webp`). The build copies
them there, and `src/web/src/lib/questionImage.ts` turns a stored filename into
`/question-images/<name>`. Nothing needs uploading to Supabase Storage for figures.

`ref_doc.storage_path` still records where the original PDFs would live in the
`exam-reference-docs` bucket (`2021-april/a/questions.pdf`); uploading them is optional and
nothing in the app reads them.
