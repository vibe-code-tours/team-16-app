# NerdQuiz — Intra Demo Script (6:00)

**Format:** Single presenter, voiceover with screen recordings + slides
**Total runtime:** 6:00
**Date:** Jul 11–12 (Intra Demo Weekend)

---

## 1. INTRO (0:00 – 0:05)

**[SLIDE: NerdQuiz logo + tagline]**

> "This is NerdQuiz — gamified IT exam prep for the ITPEC FE certification."

---

## 2. HOOK (0:05 – 0:35)

**[SLIDE: Competitor logos/websites — ITPEC.org, exam practice sites, PDF screenshots]**

> "ITPEC FE candidates already have places to practice — the official past exam papers, various exam prep websites. But let's be honest — they're just dumps of questions. Pick an answer, check if you're right, move on. No progression, no feedback loop, no reason to come back tomorrow. We asked: what if studying for the FE exam was actually fun?"

---

## 3. SOLUTION (0:35 – 1:05)

**[SLIDE: Feature overview grid — 4 key features with icons]**

> "NerdQuiz is Duolingo meets IT certification prep. Students get a visual learning map of the FE syllabus, short 2-minute lessons before each topic quiz, instant feedback on every answer, and a Mistake Garden that collects every wrong answer for targeted review. It's mobile-first, free, and built in two weeks by a team of eight."

---

## 4. LIVE DEMO (1:05 – 4:35)

**Screen recording with voiceover. Show each screen as you narrate.**

### 4a. Landing Page + Auth (1:05 – 1:35)

**[SCREEN: Landing page with mascot]**

> "Here's the landing page — meet our mascot. Clean, simple, mobile-responsive."

**[SCREEN: Register → Login flow]**

> "Sign up with email or Google. Supabase Auth handles everything — passwords never touch our backend."

### 4b. Learning Map (1:35 – 2:15)

**[SCREEN: Learning map with topic nodes — locked and unlocked]**

> "The learning map mirrors the FE syllabus. Each node is a topic — Technology, Security, Management, Strategy, Business. Locked topics are greyed out. You unlock them by completing prerequisites."

**[SCREEN: Topic detail page]**

> "Click a topic. You see a short lesson — two to three minutes of reading. No fluff, just what you need to know."

### 4c. Quiz Flow (2:15 – 3:15)

**[SCREEN: Quiz session — 5 questions]**

> "After the lesson, a five-question quiz. No timer here — learning first, pressure later."

**[SCREEN: Answer selected → correct feedback]**

> "Pick an answer. Instant feedback — green for correct, red for wrong, with the explanation shown right away."

**[SCREEN: Wrong answer → explanation]**

> "Wrong answer? You see why it's wrong and what the correct answer is. This is where learning happens."

**[SCREEN: Quiz result screen]**

> "Five questions done. You earn XP for every correct answer. Your streak updates. Progress saved."

### 4d. Mistake Garden (3:15 – 3:55)

**[SCREEN: Mistake Garden list]**

> "Every wrong answer across all quizzes lands here — the Mistake Garden. This is our core differentiator."

**[SCREEN: Click a mistake → detail view with explanation]**

> "Click any mistake. You see the question, your wrong answer, the correct answer, and the full explanation. This is how certification prep actually works — you learn from your mistakes, not from re-reading notes."

### 4e. Exam Simulation (3:55 – 4:35)

**[SCREEN: Exam simulation — 60 questions, countdown timer]**

> "Exam simulation mode. Sixty questions, real timer, hearts system — lose a heart per wrong answer. This is the pressure cooker. It mirrors the real FE exam conditions."

**[SCREEN: Submit exam → results summary]**

> "Submit. Score breakdown by topic. Weak areas highlighted. Back to the Mistake Garden to review."

---

## 5. TECH HIGHLIGHT (4:35 – 5:20)

**[SLIDE: Architecture diagram — Frontend → Spring Boot → Supabase]**

> "Under the hood: React and TypeScript on the frontend, Spring Boot on Java 25 for the backend, Supabase for auth and Postgres. Frontend calls Supabase directly for login — our backend only sees JWTs, never passwords."

**[SLIDE: Code snippet — RLS policy or JWT filter]**

> "Row-Level Security on every user-data table. The database itself enforces who can read what — defense in depth."

**[SLIDE: Code snippet — Mistake Garden service or quiz logic]**

> "The Mistake Garden isn't a feature bolted on — it's woven into the quiz flow. Every wrong answer is captured server-side, linked to the user, and queryable by topic. That's the architecture decision that makes the whole app work."

---

## 6. WHAT'S NEXT (5:20 – 5:50)

**[SLIDE: Roadmap — 3 items with icons]**

> "Next up: flashcards with spaced repetition for the Mistake Garden, AI-powered weak point analysis, and Subject-B support — the complex format with code snippets and answer groups. We're two weeks in. This is Week 1."

---

## 7. OUTRO (5:50 – 6:00)

**[SLIDE: NerdQuiz logo + team names + GitHub repo]**

> "NerdQuiz — built by eight developers in two weeks. Code's on GitHub. Thanks for watching."

---

## Production Notes

| Item | Detail |
|---|---|
| **Slides** | Create in Figma/Canva — logo, problem, features grid, architecture diagram, roadmap |
| **Screen recording** | Use OBS or Screen Studio — record on a 1280×720 or 1920×1080 viewport |
| **Voiceover** | Record in one take, or split per section and stitch in editing |
| **Dubbing** | Use ElevenLabs or similar for voice synthesis if needed |
| **No secrets on screen** | Blur `.env` values, use demo account with fake data |
| **Timing** | Practice with a stopwatch — the live demo is the hardest part to pace |

---

## Slide Content Guide

### Slide 1 — Title
- NerdQuiz logo (center)
- Tagline: "Gamified IT Exam Prep for ITPEC FE"
- Team names (8 developers)
- "Intra Demo — Jul 11–12"

### Slide 2 — Problem
- Title: "The Problem"
- Show screenshots of existing practice sites (ITPEC.org, PDF dumps)
- 3 pain points with icons:
  - Existing sites are just question dumps — no learning path
  - No feedback loop — answer and forget
  - No motivation to come back — it's boring
- Footer question: "What if FE exam prep was actually fun?"

### Slide 3 — Solution
- Title: "Our Solution"
- 4 feature boxes:
  - Visual Learning Map (skill tree icon)
  - Short Lessons + Quizzes (book/check icon)
  - Instant Feedback (lightning icon)
  - Mistake Garden (plant/growth icon)
- Footer: "Mobile-first · Free · 2-week build"

### Slide 4 — Architecture
- Title: "How It Works"
- Diagram:
  ```
  [React SPA] → [Spring Boot API] → [Supabase Postgres]
       ↓                                    ↓
  [Supabase Auth] ←→ [JWT Verification]
  ```
- Callouts:
  - "Frontend talks to Supabase directly for auth"
  - "Backend verifies JWTs — never sees passwords"
  - "RLS on every user-data table"

### Slide 5 — Tech Stack
- Title: "Tech Stack"
- Grid:
  - Frontend: React + TypeScript + Tailwind CSS
  - Backend: Spring Boot + Java 25
  - Database: Supabase (PostgreSQL)
  - Auth: Supabase Auth (JWT)
  - Build: Vite + Gradle

### Slide 6 — What's Next
- Title: "What's Next"
- 3 roadmap items:
  - Flashcards + Spaced Repetition
  - AI Weak Point Analysis
  - Subject-B Support (code snippets)
- Footer: "Week 1 complete · Week 2 in progress"

### Slide 7 — Closing
- NerdQuiz logo
- "Built by 8 developers in 2 weeks"
- GitHub repo URL
- "Thank you"
