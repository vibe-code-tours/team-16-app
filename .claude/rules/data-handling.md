# Data handling — ITPEC exam data

Applies to: `supabase/migrations/**`, `supabase/seed.sql`, and any extraction scripts

## Source

All exam questions come from [ITPEC Past Exam Papers](https://itpec.org/pastexamqa/fe.html),
freely available for educational use.

## Extraction pipeline

Questions start as PDFs and must be extracted into structured JSON. This is our
**biggest technical risk** — see `.claude/skills/extract-data.md` for the
full procedure.

## Target JSON schema (per question)

```json
{
  "exam_session": "2025-October",
  "subject": "A",
  "question_number": 1,
  "topic_category": "Technology | Security | Management | Strategy | Business",
  "difficulty": "easy | medium | hard",
  "question_text": "...",
  "choices": [
    { "label": "a", "text": "..." },
    { "label": "b", "text": "..." },
    { "label": "c", "text": "..." },
    { "label": "d", "text": "..." }
  ],
  "correct_answer": "b",
  "explanation": "..."
}
```

## Database conventions

- Table names: `snake_case`, plural (`questions`, `user_progress`, `mistakes`).
- Primary keys: `id UUID PRIMARY KEY DEFAULT gen_random_uuid()`.
- Timestamps: `created_at TIMESTAMPTZ DEFAULT now()`, `updated_at TIMESTAMPTZ DEFAULT now()`.
- Foreign keys: use explicit constraints, not ORMs-only.
- Row Level Security (RLS): enabled on all user-data tables. Questions table is public-read.

## Scope for demo

- Subject-A only for Week 1 (60 questions per exam × 3 exams = ~180 questions).
- Subject-B can be added in Week 2 if extraction progress allows.
- Focus on 3 recent exam sessions for the demo.
