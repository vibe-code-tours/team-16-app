---
name: extract-itpec-pdfs
description: Extract ITPEC FE exam questions from PDF into structured JSON for the NerdQuiz database
---

# Skill: ITPEC PDF-to-JSON Extraction

Use this procedure when extracting exam questions from ITPEC past exam PDFs.
This is the team's biggest technical risk — follow the checklist carefully.

## Procedure

### 1. Download the PDF

- Source: https://itpec.org/pastexamqa/fe.html
- Download the ZIP for the target exam session, extract the PDF.
- Note the exam session name (e.g. "2025-October") and subject (A or B).

### 2. Extract raw text

- Use `pdftotext` (poppler-utils) or a similar tool to get raw text.
- For Subject-B PDFs with complex layouts, manual extraction may be needed.
- Save raw text alongside the PDF for reference.

### 3. Parse into JSON

- Feed the raw text to an LLM (Claude or GPT) with a structured prompt.
- The prompt should request the [target JSON schema](#target-schema) per question.
- For Subject-A: 4 choices (a-d), one correct answer.
- For Subject-B: may have 5-10 choices and "answer group" combinations — flag these.

### 4. Validate against checklist

Run through every extracted question:

- [ ] **Question text** is complete (no truncation, no missing lines).
- [ ] **All choices present** — Subject-A has exactly 4, Subject-B matches the PDF.
- [ ] **Correct answer matches** the official answer key PDF.
- [ ] **Topic category** is assigned (Technology, Security, Management, Strategy, Business).
- [ ] **No encoding artifacts** — Japanese/technical characters rendered correctly.
- [ ] **Code snippets** (if any) are preserved with formatting.
- [ ] **Question numbers** are sequential and match the original.

### 5. Import to database

- Insert via Supabase CLI seed file (`supabase/seed.sql`) or a migration.
- Use `ON CONFLICT` to handle re-runs safely.

## Target schema

```json
{
  "exam_session": "2025-October",
  "subject": "A",
  "question_number": 1,
  "topic_category": "Technology",
  "difficulty": "medium",
  "question_text": "Which of the following is...",
  "choices": [
    { "label": "a", "text": "Option A text" },
    { "label": "b", "text": "Option B text" },
    { "label": "c", "text": "Option C text" },
    { "label": "d", "text": "Option D text" }
  ],
  "correct_answer": "b",
  "explanation": "Because..."
}
```

## Human review checklist

Every extracted exam session must be reviewed by at least one person before import.
Focus on:

1. Pick 10 random questions and compare against the original PDF.
2. Verify the answer key matches for all questions.
3. Check that topic categories make sense (not random assignments).
4. Confirm no questions were missed (count should match exam total).
5. Check for garbled text, especially around technical terms and Japanese characters.

## Common issues

| Issue | Fix |
|---|---|
| Question text cuts off mid-sentence | Re-extract with a different PDF tool, or manually fill in |
| Japanese characters show as `???` | Ensure UTF-8 encoding throughout the pipeline |
| Answer key PDF has different numbering | Cross-reference by question text, not just number |
| Subject-B answer groups are malformed | Flag for manual entry — don't guess |
| Two questions merged into one | Split manually using the question number as a guide |
