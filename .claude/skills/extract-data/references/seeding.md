# SQL Seed Generation Reference

How `scripts/generate_exam_seed_sql.py` produces Supabase-ready SQL from extracted JSON.

## Table of contents

- [How it works](#how-it-works)
- [SQL structure](#sql-structure)
- [Column mapping](#column-mapping)
- [Idempotent upserts](#idempotent-upserts)
- [Schema overview](#schema-overview)
- [Deployment](#deployment)
- [Storage layout](#storage-layout)

## How it works

The generator reads `questions.json` from both Subject A and Subject B folders for a
given exam term and produces a single combined SQL file.

```bash
python scripts/generate_exam_seed_sql.py \
  --resources-dir resources/exams \
  --year 2021 \
  --season April \
  --output supabase/seed_data/2021-April-Exam.sql
```

**Input:** `resources/exams/2021-April-A/questions.json` + `resources/exams/2021-April-B/questions.json`
**Output:** `supabase/seed_data/2021-April-Exam.sql`

## SQL structure

The generated file contains:

```sql
-- NerdQuiz seed: 2021 April FE Subjects A and B
BEGIN;

-- 1. Subject A exam definition
INSERT INTO exams (...) VALUES (...) ON CONFLICT ...;

-- 2. Subject B exam definition
INSERT INTO exams (...) VALUES (...) ON CONFLICT ...;

-- 3. All question records (Subject A + B)
INSERT INTO questions (...) VALUES (...)
ON CONFLICT (exam_session, subject, question_number)
DO UPDATE SET ...;

-- 4. Ordered exam-question mappings
INSERT INTO exam_questions (...) VALUES (...)
ON CONFLICT ...;

COMMIT;
```

Everything is wrapped in a single transaction — all-or-nothing.

## Column mapping

JSON fields map to database columns:

| JSON field | DB column | Type |
|---|---|---|
| `exam_session` | `exam_session` | `text` |
| `subject` | `subject` | `text` |
| `question_number` | `question_number` | `integer` |
| `question_text` | `question_text` | `text` |
| `content_blocks` | `content_blocks` | `jsonb` |
| `images` | `images` | `jsonb` |
| `choices` | `choices` | `jsonb` |
| `correct_answer` | `correct_answer` | `text` |
| `answer_key` | `answer_key` | `jsonb` |
| `explanation` | `explanation` | `text` |
| `difficulty` | `difficulty` | `text` |
| `source_file` | `source_file` | `text` |
| `source_citation` | `source_citation` | `text` |
| `source_pages` | `source_pages` | `integer[]` |
| `extraction_method` | `extraction_method` | `text` |
| `extraction_version` | `extraction_version` | `text` |
| `source_text` | `source_text` | `text` |
| `ref_doc` | `ref_doc` | `jsonb` |

## Idempotent upserts

All inserts use `ON CONFLICT ... DO UPDATE SET` to make seed files safely re-runnable.

**Questions:** conflict on `(exam_session, subject, question_number)`
**Exams:** conflict on `(exam_session, subject)`
**Exam questions:** conflict on `(exam_id, question_id)`

This means running the same seed twice won't fail — it updates existing rows.

## Schema overview

The seed writes to these tables (defined in `supabase/migrations/001_initial_schema.sql`):

| Table | Purpose |
|---|---|
| `exams` | Exam definitions (session, subject, total questions) |
| `questions` | All question records with structured content |
| `exam_questions` | Many-to-many: which questions belong to which exam, with ordering |

The full schema also includes topics, lessons, quizzes, user progress, XP, streaks,
mistake garden, flashcards, and more — but the seed only touches the three tables above.

## Deployment

### Browser-only deployment order

1. **SQL Editor:** run `001_initial_schema.sql` (first time only)
2. **Storage → question-images:** upload all WebP figures
3. **Storage → exam-reference-docs:** upload original PDFs
4. **SQL Editor:** run the generated seed file
5. **Verify:** count queries

### Verification queries

```sql
-- Count questions per subject
SELECT subject, COUNT(*) FROM questions
WHERE exam_session = '2021-april'
GROUP BY subject;

-- Count exams
SELECT * FROM exams WHERE exam_session = '2021-april';

-- Verify mappings are ordered
SELECT eq.question_number, q.question_text[:50]
FROM exam_questions eq
JOIN questions q ON q.id = eq.question_id
JOIN exams e ON e.id = eq.exam_id
WHERE e.exam_session = '2021-april' AND e.subject = 'A'
ORDER BY eq.question_number;
```

## Storage layout

### question-images/

All WebP figures, named by convention:

```
question-images/
├── 2021-april-a-q08-figure1.webp
├── 2021-april-a-q22-figure1.webp
├── 2021-april-a-q22-figure2.webp
├── 2021-april-b-q01-figure1.webp
└── ...
```

### exam-reference-docs/

Original PDFs organized by exam term and subject:

```
exam-reference-docs/
└── 2021-april/
    ├── a/
    │   ├── questions.pdf
    │   └── answers.pdf
    └── b/
        ├── questions.pdf
        └── answers.pdf
```

The subject subdirectory prevents filename collisions (both A and B have `questions.pdf`).
