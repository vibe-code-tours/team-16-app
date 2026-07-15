---
name: feature-audit-2026-07-15
description: Full audit of NerdQuiz features — what's implemented, broken, missing, and priority fixes for public demo
metadata:
  type: project
---

## Feature Audit (2026-07-15)

### ✅ Fully Implemented (12 features)
Login, Learning Map, Short Lessons, 5-Question Quizzes, XP Tracking, Hearts (Exam Sim), Streak Tracking, Exam Simulation, Rule-Based Difficulty, Landing Page, User Profile, Data Extraction + Schema

### ❌ Not Implemented (Week 2 stretch — no code)
- **Flashcards (#18)** — DB tables exist (migration 001), no controller/service/component/route
- **Weak Point Analysis (#19)** — Index idx_mastery_weak_points exists, repository only, no controller/dashboard
- **Additional Exams (#20)** — Pipeline ready, no DB/backend/frontend

### ⚠️ Partially Implemented / Broken
- **Mistake Garden (#8)** — Frontend calls GET /api/v1/me/mistakes and PUT /api/v1/me/mistakes/{id}/review but backend only has POST. Listing and reviewing mistakes will 404 at runtime. Feature-board says "Done" but it's broken.
- **Mobile Responsiveness (#17)** — Header hamburger works, but sidebar mobile overlay is hardcoded hidden.
- **Lesson Completion Tracking** — LessonPage.tsx "I've read it!" button navigates back but never calls the completion endpoint.

### 🔍 Known Gaps
- Duplicate DB tables: profiles (001) vs user_profiles (003), mistakes (001) vs user_mistakes (005)
- Orphaned files: QuizSession.tsx, QuizResult.tsx, sampleQuestions.ts, ExamSimulation.tsx — none are routed
- No JPA entity for user_profiles: UserService uses raw JdbcTemplate
- No JPA entity for user_mistakes: MistakeService uses JPA but endpoints are missing
- LessonProgressController duplicates LessonController — two endpoints for the same thing
- Architecture doc outdated: Says some pages call Supabase directly, but code actually calls backend API

### Priority Fixes for Public Demo
1. Mistake Garden — add missing GET/PUT backend endpoints (broken right now)
2. Flashcards — DB ready, needs backend + frontend (Week 2 stretch)
3. Weak Point Analysis — DB ready, needs backend + frontend (Week 2 stretch)
4. Lesson completion — wire up the "I've read it!" button
5. Mobile sidebar — un-hardcode the hidden class
6. Clean up orphaned files — remove QuizSession.tsx, QuizResult.tsx, sampleQuestions.ts
