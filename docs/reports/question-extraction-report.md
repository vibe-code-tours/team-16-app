# Report: ITPEC Question Extraction to Markdown Syntax

## Executive Summary

This report documents the process of extracting ITPEC FE exam questions from official PDF archives and converting them into structured markdown syntax for storage in the NerdQuiz database. The extraction pipeline transforms visual PDF content—including text, diagrams, tables, and code—into a structured JSON format that can be rendered as markdown in the web application.

---

## Table of Contents

1. [Overview](#overview)
2. [Challenges](#challenges)
3. [Step-by-Step Procedure](#step-by-step-procedure)
4. [Markdown Conversion Examples](#markdown-conversion-examples)
5. [Quality Assurance](#quality-assurance)
6. [Conclusion](#conclusion)

---

## Overview

### Source Material

ITPEC FE exam questions are published as PDF files on [itpec.org/pastexamqa/fe.html](https://itpec.org/pastexamqa/fe.html). Each exam consists of:

- **Questions PDF** — Contains question text, diagrams, tables, code snippets, and answer choices
- **Answers PDF** — Contains the official answer key

### Target Format

Questions are converted to structured JSON with markdown syntax:

```json
{
  "exam_session": "2025-october",
  "subject": "A",
  "question_number": 12,
  "question_text": "One (1) server, three (3) clients...",
  "content_blocks": [
    {
      "type": "markdown",
      "text": "| Device | Availability |\n|--------|--------------|\n| Server | a |"
    }
  ],
  "choices": [
    {"label": "a", "text": "ab³c²"},
    {"label": "b", "text": "a(1-b³)(1-c²)"}
  ],
  "correct_answer": "d"
}
```

### Pipeline Architecture

```
Official ITPEC ZIP
  → build_itpec_resources.py  (download, normalize, extract)
    → extract_itpec.py        (parse PDFs into JSON + figures)
  → generate_exam_seed_sql.py (JSON → SQL seed)
  → Supabase dashboard        (schema, upload assets, run seed)
```

---

## Challenges

### 1. PDF Text Extraction Complexity

**Challenge:** PDFs use various encoding methods, and text may be embedded as layers, images, or a combination.

**Impact:**
- Native text extraction may miss content on scanned pages
- OCR fallback introduces potential accuracy issues
- Formulas and special characters may not extract correctly

**Solution:**
- Primary: Native text extraction using PyMuPDF (preserves Unicode/Japanese)
- Fallback: Tesseract OCR for sparse/scanned pages
- Coordinate tracking for answer-key parsing and figure placement

### 2. Question Detection Ambiguity

**Challenge:** Some PDFs include sample questions on instruction pages (e.g., "Q1" on page 1).

**Impact:**
- Parser may detect false Q1 from instruction pages
- Duplicate question numbers could corrupt the extraction

**Solution:**
- Collect all question-heading candidates across pages
- Use answer key to determine expected question count
- Select a monotonic Q1…Qn sequence
- Choose the final valid Q1 before Q2

### 3. Diagram and Figure Extraction

**Challenge:** Visual content (flowcharts, network diagrams, timing diagrams) must be detected and cropped accurately.

**Impact:**
- Single diagrams may be split into multiple visual elements
- Labels and captions may be clipped
- False positives (blank boxes, table grids) may be stored as figures

**Solution:**
- Vector path analysis for drawing commands
- Connected-component grouping for nearby visual elements
- Manual overrides via `PAGE_FIGURE_OVERRIDES` dictionary
- False positive prevention (blank boxes, A/B underscores, white rectangles)

### 4. Code Block Preservation

**Challenge:** Pseudocode and program blocks must preserve formatting (line breaks, indentation).

**Impact:**
- Malformed code blocks are unreadable
- Program blanks (***A***, ***B***） must be normalized for UI highlighting

**Solution:**
- Detect code blocks via monospace font or code keywords
- Preserve line breaks and indentation in JSON
- Normalize program blanks as `***A***`, `***B***`, etc.

### 5. Multi-Format Answer Choices

**Challenge:** Subject A uses 4 choices (a–d), while Subject B may use up to 9 choices (a–i).

**Impact:**
- Parser must handle variable choice counts
- Graphical answer choices may reference image files

**Solution:**
- Regex pattern: `CHOICE_RE = re.compile(r"(?<![A-Za-z])([a-i])(?:\)|(?=\s+\d))\s*")`
- Graphical choices stored with `image` field pointing to WebP files

### 6. Legacy Subject B Format

**Challenge:** 2021–2023 Subject B questions have multipart answers with sub-questions.

**Impact:**
- Simple answer key format insufficient
- Sub-question structure must be preserved

**Solution:**
- Structured `answer_key` with `parts` array:
  ```json
  {
    "parts": [
      {"subquestion": 1, "blank": "A", "answer": "c"},
      {"subquestion": 2, "blank": "B", "answer": "a"}
    ]
  }
  ```
- Serialized value in `correct_answer` for compatibility

---

## Step-by-Step Procedure

### Phase 1: Download and Normalize

**Step 1: Run Build Script**

```bash
python scripts/build_itpec_resources.py \
  --archive-dir /tmp/itpec-fe-archives \
  --output-dir resources/exams
```

**What it does:**
- Downloads ZIP archives from itpec.org
- Extracts PDFs from ZIPs
- Normalizes folder structure
- Runs extraction pipeline

**Output:**
```
resources/exams/
├── 2021-April-A/
│   ├── questions.pdf
│   ├── answers.pdf
│   ├── questions.json
│   └── images/*.webp
├── 2021-April-B/
│   └── ...
└── index.json
```

### Phase 2: Extract Questions

**Step 2: Parse PDFs into JSON**

The `extract_itpec.py` script processes each PDF:

1. **Text Extraction**
   - Try native text extraction first
   - Fall back to Tesseract OCR if sparse

2. **Question Detection**
   - Apply regex: `Q_RE = re.compile(r"(?m)^\s*Q\s*(\d{1,2})(?:\.|\s)\s*")`
   - Filter false positives from instruction pages
   - Validate against answer key count

3. **Content Block Generation**

   For Subject A (text-based):
   ```json
   {
     "type": "text",
     "text": "Extracted question text..."
   }
   ```

   For Subject B (semantic blocks):
   ```json
   [
     {"type": "prompt", "text": "Consider the following program..."},
     {"type": "code", "language": "itpec-pseudocode", "text": "..."},
     {"type": "answer_table", "columns": ["A", "B"], "rows": [...]}
   ]
   ```

4. **Figure Extraction**
   - Detect embedded raster images
   - Analyze vector drawing paths
   - Group nearby visual elements
   - Crop and save as WebP at 160 DPI

5. **Answer Parsing**
   - Subject A: Simple letter per question
   - Subject B (legacy): Multipart with sub-questions
   - Subject B (modern): Up to 9 choices

### Phase 3: Convert to Markdown

**Step 3: Transform Content Blocks to Markdown**

The extraction outputs structured JSON, which is then converted to markdown syntax for database storage:

#### Text Blocks → Markdown

**Input (JSON):**
```json
{
  "type": "text",
  "text": "**Network Topology:** Bus network with the following devices:"
}
```

**Output (Markdown):**
```markdown
**Network Topology:** Bus network with the following devices:
```

#### Tables → Markdown Tables

**Input (JSON):**
```json
{
  "type": "table",
  "headers": ["Device", "Availability"],
  "rows": [
    ["Server", "a"],
    ["Client", "b"],
    ["Printer", "c"],
    ["LAN", "1"]
  ]
}
```

**Output (Markdown):**
```markdown
| Device | Availability |
|--------|--------------|
| Server | a |
| Client | b |
| Printer | c |
| LAN | 1 |
```

#### Code Blocks → Markdown Code

**Input (JSON):**
```json
{
  "type": "code",
  "language": "itpec-pseudocode",
  "text": "○ integer: findMode(integer []: arr)\n  // body\n  return arr[0]"
}
```

**Output (Markdown):**
```markdown
○ integer: findMode(integer []: arr)
  // body
  return arr[0]
```

#### Figures → Image References

**Input (JSON):**
```json
{
  "images": ["2025-october-a-q12-figure1.webp"]
}
```

**Output (Markdown with HTML):**
```html
<figure>
  <img src="/question-images/2025-october-a-q12-figure1.webp" alt="Network topology diagram" />
</figure>
```

### Phase 4: Generate SQL Seed

**Step 4: Convert JSON to SQL**

```bash
python scripts/generate_exam_seed_sql.py \
  --resources-dir resources/exams \
  --year 2025 \
  --season October \
  --output supabase/seed_data/2025-October-Exam.sql
```

**Output SQL Structure:**
```sql
BEGIN;

-- 1. Exam definition
INSERT INTO exams (...) VALUES (...) ON CONFLICT ...;

-- 2. Questions with markdown content
INSERT INTO questions (
  exam_session, subject, question_number,
  question_text, content_blocks, choices, correct_answer
) VALUES (
  '2025-october', 'A', 12,
  'One (1) server, three (3) clients...',
  '[{"type":"markdown","text":"| Device | Availability |..."}]'::jsonb,
  '[{"label":"a","text":"ab³c²"}]'::jsonb,
  'd'
) ON CONFLICT (exam_session, subject, question_number)
DO UPDATE SET ...;

-- 3. Exam-question mappings
INSERT INTO exam_questions (...) VALUES (...) ON CONFLICT ...;

COMMIT;
```

### Phase 5: Deploy to Database

**Step 5: Upload to Supabase**

1. **Run Schema Migration** (first time only)
   ```sql
   -- Via Supabase SQL Editor
   \i supabase/migrations/001_initial_schema.sql
   ```

2. **Upload Figure Images**
   - Go to Storage → `question-images` bucket
   - Upload all WebP files from `resources/exams/*/images/`

3. **Upload Reference PDFs**
   - Go to Storage → `exam-reference-docs` bucket
   - Upload PDFs under `2025-october/{a,b}/`

4. **Run Seed SQL**
   - Via Supabase SQL Editor
   - Run the generated seed file

5. **Verify**
   ```sql
   SELECT subject, COUNT(*) FROM questions
   WHERE exam_session = '2025-october'
   GROUP BY subject;
   ```

---

## Markdown Conversion Examples

### Example 1: Network Availability Question (Q12)

**Original PDF Content:**
- Question text with network topology description
- Bus network diagram (Server, Clients, Printers)
- Availability table (Device vs. Availability value)
- 4 answer choices (mathematical expressions)

**Extracted JSON:**
```json
{
  "exam_session": "2025-october",
  "subject": "A",
  "question_number": 12,
  "question_text": "One (1) server, three (3) clients, and two (2) printers...",
  "content_blocks": [
    {
      "type": "text",
      "text": "**Network Topology:** Bus network with the following devices:"
    },
    {
      "type": "markdown",
      "text": "| Device | Availability |\n|--------|--------------|\n| Server | a |\n| Client | b |\n| Printer | c |\n| LAN | 1 |"
    },
    {
      "type": "text",
      "text": "**System Availability Condition:** The system is available if:\n- The server is available AND\n- At least one of the three clients is available AND\n- At least one of the two printers is available"
    }
  ],
  "choices": [
    {"label": "a", "text": "ab³c²"},
    {"label": "b", "text": "a(1-b³)(1-c²)"},
    {"label": "c", "text": "a(1-b)³(1-c)²"},
    {"label": "d", "text": "a(1-(1-b)³)(1-(1-c)²)"}
  ],
  "correct_answer": "d"
}
```

**Rendered Markdown in Web App:**

```markdown
One (1) server, three (3) clients, and two (2) printers are connected via a LAN...

**Network Topology:** Bus network with the following devices:

| Device | Availability |
|--------|--------------|
| Server | a |
| Client | b |
| Printer | c |
| LAN | 1 |

**System Availability Condition:** The system is available if:
- The server is available AND
- At least one of the three clients is available AND
- At least one of the two printers is available

a) ab³c²
b) a(1-b³)(1-c²)
c) a(1-b)³(1-c)²
d) a(1-(1-b)³)(1-(1-c)²)
```

### Example 2: Subject B Code Question

**Extracted JSON:**
```json
{
  "content_blocks": [
    {"type": "prompt", "text": "Consider the following program:"},
    {
      "type": "code",
      "language": "itpec-pseudocode",
      "text": "○ integer: findMode(integer []: arr)\n  integer: count\n  integer: mode\n  // body\n  return arr[0]"
    },
    {"type": "text", "text": "What is the output when arr = [3, 1, 2, 3, 3]?"}
  ]
}
```

**Rendered Markdown:**
```markdown
Consider the following program:

○ integer: findMode(integer []: arr)
  integer: count
  integer: mode
  // body
  return arr[0]

What is the output when arr = [3, 1, 2, 3, 3]?
```

---

## Quality Assurance

### Extraction Validation Checklist

- [ ] Question count matches expected (Subject A: 60, Subject B: 8/20)
- [ ] Question numbers continuous, no gaps or duplicates
- [ ] All choices present (A: a–d, B: up to a–i)
- [ ] Correct answer matches official answer key
- [ ] Figure references point to existing WebP files
- [ ] Figure names follow `{exam_session}-{subject}-q{number}-figure{n}.webp`
- [ ] Code blocks preserve formatting (line breaks, indentation)
- [ ] Content block types correct (`text`, `markdown`, `code`, `table`)
- [ ] `ref_doc` paths use subject-specific directories
- [ ] Extraction tests pass

### Human Review Process

1. Pick 10 random questions and compare against the original PDF
2. Verify the answer key matches for all questions
3. Confirm no questions were missed (count matches exam total)
4. Check for garbled text around technical terms
5. Visually inspect cropped figures against original PDF
6. Verify multipart Subject B answers have correct sub-parts

### Common Issues and Fixes

| Issue | Fix |
|-------|-----|
| Instruction page sample Q1 in output | Parser uses answer-key counts to select correct Q1 |
| Subject B has >4 choices (a–i) | Expected for modern format — parser supports a–i |
| Flowchart split into multiple figures | Check `PAGE_FIGURE_OVERRIDES` — may need manual crop region |
| Empty rectangular boxes stored as figures | Blank-placeholder detector should exclude |
| `build_itpec_resources.py` can't find PDF in ZIP | PDFs have inconsistent naming — script uses AM/PM tokens |
| SQL seed duplicate key errors | Upserts use `ON CONFLICT` — check if schema migration was applied |

---

## Conclusion

The ITPEC question extraction pipeline successfully transforms visual PDF content into structured markdown syntax for the NerdQuiz platform. Key achievements:

1. **Automated Extraction:** PyMuPDF-based parser handles native text and OCR fallback
2. **Structured Content:** Semantic content blocks preserve question structure
3. **Markdown Conversion:** Tables, code, and text convert to readable markdown
4. **Figure Management:** Visual content cropped and stored as optimized WebP
5. **Idempotent Seeding:** SQL generation supports safe re-runs

The pipeline processes approximately 60 questions per Subject A exam and 8–20 questions per Subject B exam, with figure counts ranging from 5–17 per exam.

### Recommendations

1. **Expand Markdown Support:** Add more content block types (e.g., `formula` for LaTeX)
2. **Improve Figure Detection:** Manual overrides remain necessary for complex layouts
3. **Automate Validation:** Integrate extraction tests into CI/CD pipeline
4. **Enhance Preview:** Build a web-based preview tool for extraction quality review

---

*Report generated: 2026-07-13*
*Extraction pipeline version: 3.0*
*Target: NerdQuiz ITPEC FE Exam Prep Platform*
