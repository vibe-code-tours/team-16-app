# GSD Feature Report — ITPEC FE Data Extraction

> Feature: PDF → structured questions, figures, references, and Supabase seed data  
> Status: **2021 April extraction and Supabase deployment complete**
> Official source: [ITPEC FE Past Examination Questions and Answers](https://itpec.org/pastexamqa/fe.html)

## Goal

Build a repeatable pipeline that converts official ITPEC FE question and answer PDFs into NerdQuiz-ready data.

The output must support:

- Subject A and Subject B
- April and October sessions from 2021–2025
- Modern and legacy multipart exam formats
- Text, pseudocode, answer tables, and graphical questions
- Small, correctly cropped figure images
- Original PDFs as reference documents
- One combined Subject A+B SQL seed per exam term

## Done means

- [x] Official archives are downloaded and validated.
- [x] Exam terms and subjects use normalized names.
- [x] Original question and answer PDFs are preserved.
- [x] Questions and answers are extracted into structured JSON.
- [x] Programs are stored as code, not screenshots.
- [x] Answer matrices are stored as tables.
- [x] Real figures are cropped and stored as WebP.
- [x] Blank boxes, prose, and section headings are not stored as figures.
- [x] Legacy multipart Subject B answers are preserved.
- [x] Source citations and PDF references are included.
- [x] A reusable SQL seed generator exists.
- [x] The 2021 April A+B seed is generated and validated.
- [x] Browser-only Supabase deployment steps are documented.
- [x] Storage assets are uploaded to Supabase.
- [x] Initial schema and seed are applied to the remote database.

## Scope delivered

| Item | Result |
|---|---:|
| Normalized exam/subject folders | 20 |
| Top-level questions | 728 |
| Years covered | 2021–2025 |
| Sessions per year | April and October |
| Original PDFs preserved | 40 |
| First combined SQL seed | 2021-April-Exam.sql |
| Questions in first seed | 68 |

Question counts differ by exam format:

- 2021–2023 Subject A: 60 questions per paper
- 2021–2023 legacy PM/Subject B: 8 multipart questions per paper
- 2024–2025 Subject A: 60 questions per paper
- 2024–2025 Subject B: 20 questions per paper

## Execution

### Phase 1 — Inspect the source

**Goal:** Determine whether OCR is required and understand the PDF layouts.

Steps completed:

1. Inspected the initial October 2025 question and answer PDFs.
2. Measured page counts and native text coverage.
3. Confirmed the PDFs contain usable English text layers.
4. Selected PyMuPDF for text, coordinate, vector, table, and image extraction.
5. Added Tesseract OCR as a fallback for sparse or scanned pages.

Decision:

```text
Use native PDF text first → OCR only when native text is insufficient.
```

Why: native extraction preserves formulas and characters more accurately than unnecessary OCR.

### Phase 2 — Build question and answer parsing

**Goal:** Extract reliable question boundaries and correct answers.

Steps completed:

1. Extracted each page in reading order.
2. Detected question headings such as `Q1.`, `Q 1`, and `Q8`.
3. Parsed answer sheets using word coordinates.
4. Derived expected question counts from answer keys.
5. Validated continuous question numbering.

Problem: instruction pages sometimes contained a sample Q1.

Solution:

- Collect all question-heading candidates.
- Use the answer key to determine the expected sequence.
- Select a monotonic Q1…Qn sequence.
- Choose the final valid Q1 before Q2.

Problem: modern Subject B uses answers through option `i`.

Solution: expand choice and answer parsing from `a–h` to `a–i`.

### Phase 3 — Support legacy Subject B

**Goal:** Preserve the 2021–2023 PM papers without flattening multipart answers.

Legacy answer sheets use:

```text
Q | SQ | BQ | Correct Answer
```

Solution: parse each top-level question into a structured answer key.

```json
{
  "parts": [
    {
      "subquestion": 1,
      "blank": "A",
      "answer": "c"
    }
  ]
}
```

The structured value is stored in `answer_key`. A serialized value remains in `correct_answer` for compatibility with the existing application model.

### Phase 4 — Store semantic content

**Goal:** Avoid screenshots for content that can be represented structurally.

Subject B content is stored using these block types:

```text
prompt
context
code
answer_table
figure
```

Programs retain line breaks and indentation:

```json
{
  "type": "code",
  "language": "itpec-pseudocode",
  "text": "○ integer: findMode(integer []: arr)\n..."
}
```

Answer groups retain columns and labeled rows:

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

Program blanks are normalized as `***A***`, `***B***`, and so on.

### Phase 5 — Extract figures

**Goal:** Store only useful visual content.

The approach evolved in three iterations:

1. Full-page screenshots — accurate but too large.
2. Full-question crops — smaller but included prose, code, and choices.
3. Visual-region extraction — final approach.

The final detector uses:

- Embedded image blocks
- Vector drawing paths
- Connected-component grouping
- Nearby labels and captions
- Table-region exclusion
- Blank-placeholder exclusion

Figures are rendered as WebP at 160 DPI.

### Phase 6 — Fix figure grouping and false positives

**Goal:** Produce complete diagrams without unrelated content.

Problems and solutions:

| Problem | Resolution |
|---|---|
| Flowcharts split into several files | Merge vertically aligned components and connectors |
| Timing diagrams split into lanes | Merge horizontally aligned components with shared vertical bands |
| Figure labels clipped | Include nearby label bounding boxes |
| Caption clipped | Include the complete caption block |
| Prose mentioning “Figure” treated as a caption | Require captions to begin with `Figure` |
| `[Program]` included below a figure | Exclude semantic section headings |
| Question text included above a figure | Limit label association and add verified overrides |
| Empty output boxes stored as images | Detect small empty rectangular placeholders |
| A/B blank boxes stored as images | Detect underscore placeholders and single-letter boxes |
| Invisible white PDF rectangles stored as images | Ignore non-stroked white layout artifacts |
| Table grids treated as figures | Exclude regions detected as tables |

### Phase 7 — Add verified crop overrides

**Goal:** Handle source layouts that generic geometry cannot disambiguate reliably.

Overrides are stored in `PAGE_FIGURE_OVERRIDES` and keyed by:

```text
(exam_session, subject, question_number, source_page)
```

Verified examples include:

- 2021-April-A Q08: binary tree only
- 2021-April-A Q21: complete half-adder
- 2021-April-A Q22: four option figures stored separately
- 2021-April-A Q46: DFD without textual choices
- 2021-April-B Q01: complete Table 8
- 2021-April-B Q02: scheduling figures and captions
- 2021-April-B Q04: network diagram and caption
- 2021-April-B Q05: complete ER diagram
- 2021-April-B Q06: social graph, legend, and caption

Graphical answer choices reference their individual files:

```json
{
  "label": "a",
  "image": "2021-april-a-q22-figure1.webp"
}
```

### Phase 8 — Build normalized resources

**Goal:** Make every paper reproducible from the official archive.

The batch builder:

```text
scripts/build_itpec_resources.py
```

performs:

```text
download/reuse ZIP
→ validate ZIP
→ locate PDFs despite inconsistent names
→ normalize AM/PM to A/B
→ copy original PDFs
→ extract JSON and figures
→ update the archive manifest
```

Normalized folder example:

```text
resources/exams/2021-April-A/
├── questions.pdf
├── answers.pdf
├── questions.json
└── images/
```

Targeted rebuild example:

```bash
python scripts/build_itpec_resources.py \
  --archive-dir /tmp/itpec-fe-archives \
  --output-dir resources/exams \
  --year 2021 \
  --season April \
  --subject A
```

A targeted rebuild removes stale outputs only for the selected paper and preserves other manifest entries.

### Phase 9 — Add provenance and references

**Goal:** Make every question traceable to the official source.

Each question includes:

- Source filename
- Source page numbers
- Extraction method and version
- Original extracted text
- ITPEC source citation
- Question PDF reference
- Answer PDF reference

Reference example:

```json
{
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
```

The subject directory prevents A/B PDF filename collisions.

### Phase 10 — Consolidate the database schema

**Goal:** Prepare a new Supabase project for the full product scope.

The schema was consolidated into:

```text
supabase/migrations/001_initial_schema.sql
```

It covers:

- Topics, subtopics, lessons, and prerequisites
- Learning-map progress
- Structured questions and classifications
- Quizzes and quiz answers
- Exam definitions and attempts
- XP, hearts, streaks, and daily activity
- Mistake Garden reviews
- Flashcards and spaced repetition
- Mastery and weak-point analysis
- Source documents and figures
- Indexes, constraints, triggers, and RLS

The question schema includes `content_blocks`, `answer_key`, `images`, `ref_doc`, and source provenance.

### Phase 11 — Generate seed data

**Goal:** Produce one Subject A+B SQL file per exam term.

Generator:

```text
scripts/generate_exam_seed_sql.py
```

First generated seed:

```text
supabase/seed_data/2021-April-Exam.sql
```

Contents:

- 60 Subject A questions
- 8 multipart Subject B questions
- 68 total question records
- Subject A and Subject B exam definitions
- Ordered `exam_questions` mappings
- Idempotent upserts
- One database transaction

Generation command:

```bash
python scripts/generate_exam_seed_sql.py \
  --resources-dir resources/exams \
  --year 2021 \
  --season April \
  --output supabase/seed_data/2021-April-Exam.sql
```

### Phase 12 — Prepare browser-only Supabase deployment

**Goal:** Deploy without the Supabase CLI or local credential-based automation.

Decision:

```text
Use the authenticated Supabase browser dashboard for schema, Storage, seed, and verification.
```

The agreed deployment order is:

```text
SQL Editor: run 001_initial_schema.sql
→ Storage: upload question figures
→ Storage: upload original question/answer PDFs
→ SQL Editor: run 2021-April-Exam.sql
→ SQL Editor: verify counts, mappings, images, and PDF references
```

Storage layout for the first term:

```text
question-images/
├── 2021-april-a-q08-figure1.webp
├── 2021-april-a-q22-figure1.webp
└── ...

exam-reference-docs/
└── 2021-april/
    ├── a/
    │   ├── questions.pdf
    │   └── answers.pdf
    └── b/
        ├── questions.pdf
        └── answers.pdf
```

No API key, personal access token, service-role key, or database URL needs to be pasted into the SQL Editor. The existing browser session authorizes dashboard operations.

## Key decisions

| Decision | Reason |
|---|---|
| Native text before OCR | Better accuracy for formulas and symbols |
| PyMuPDF as primary library | Text, coordinates, vectors, tables, rendering, and OCR support |
| WebP figures | Small files with readable labels |
| Semantic code/table blocks | Better UI rendering and accessibility than screenshots |
| Answer-key-derived counts | Supports both legacy and modern papers |
| Page-specific crop overrides | Deterministic resolution for ambiguous layouts |
| Preserve original PDFs | Auditability and user reference |
| One A+B seed per term | Simple deployment and rollback boundary |
| Idempotent upserts | Safe seed reruns |

## Artifacts

| Artifact | Purpose |
|---|---|
| `scripts/extract_itpec.py` | Core PDF, question, answer, semantic block, and figure extraction |
| `scripts/build_itpec_resources.py` | Official archive download and normalized resource generation |
| `scripts/generate_exam_seed_sql.py` | Combined term SQL generation |
| `requirements-extraction.txt` | Extraction dependencies |
| `resources/exams/` | PDFs, JSON, and figures for 2021–2025 |
| `resources/exams/index.json` | Resource archive manifest |
| `supabase/migrations/001_initial_schema.sql` | Complete initial database schema |
| `supabase/seed_data/2021-April-Exam.sql` | First combined A+B seed |
| `tests/test_extract_itpec.py` | Extraction regression validation |

## Verification

Completed checks:

- [x] All downloaded ZIPs pass archive validation.
- [x] All 20 normalized folders contain question PDF, answer PDF, and JSON.
- [x] Question numbers are continuous within each paper.
- [x] Answer keys determine expected question counts.
- [x] JSON figure references point to existing WebP files.
- [x] Figure names follow the normalized convention.
- [x] Targeted crop cases were visually inspected.
- [x] 2021 April SQL contains 68 question rows.
- [x] 2021 April SQL creates two exams and ordered mappings.
- [x] A/B PDF references use different storage paths.
- [x] Extraction tests pass.
- [x] Browser-only schema, Storage, seed, and verification sequence is defined.

## Remaining work

### Required before remote use

- [x] Apply `001_initial_schema.sql` to the Supabase project.
- [x] Upload figure assets to `question-images`.
- [x] Upload original PDFs to `exam-reference-docs`.
- [x] Execute `2021-April-Exam.sql`.
- [ ] Update Java entities and DTOs for all structured question fields.
- [ ] Run an end-to-end API/UI question rendering test.

### Current deployment status

The browser-only Supabase deployment completed without errors.

Completed through the authenticated dashboard:

1. Applied the complete initial schema through SQL Editor.
2. Created the required tables, RLS policies, indexes, and Storage buckets.
3. Uploaded question figures to `question-images`.
4. Uploaded original PDFs to `exam-reference-docs` using subject-specific paths.
5. Executed the combined `2021-April-Exam.sql` seed.
6. Completed all Supabase actions without a reported error.

Remaining work is now application-side integration and end-to-end rendering verification.

## Final state

```text
Official ITPEC archive
→ validated original PDFs
→ normalized exam resources
→ structured questions and multipart answers
→ semantic programs and answer tables
→ cropped figures with verified exceptions
→ source citations and PDF references
→ complete initial Supabase schema
→ combined term SQL seed
→ deployed schema, assets, PDFs, and 2021 April seed to Supabase
```

The 2021 April extraction pipeline and Supabase deployment are complete. The same process can now be repeated term-by-term for the remaining exam resources.
