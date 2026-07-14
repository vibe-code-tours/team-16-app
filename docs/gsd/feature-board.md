# Feature Board

> Owner column is blank — fill in during team kickoff.
> Last synced with codebase: 2026-07-15

| # | Feature | Owner | Status | Notes |
|---|---------|-------|--------|-------|
| 1 | User registration & login | Sandar Win | Finished | Supabase Auth (email + Google). Backend: useAuth + LoginPage + RegisterPage |
| 2 | Learning map | Htet Lin Ko | Done | Backend: `TopicController` + `TopicService` with prerequisite chain. Frontend: `LearningMap.tsx` + `TopicNode.tsx` + `useTopics` hook. Wired to `/api/v1/topics` |
| 3 | Short lessons | YE MIN KO | Done | Backend: `LessonController` (3 endpoints). Frontend: `TopicDetail.tsx` + `LessonPage.tsx` + `LessonContent.tsx` + `useLessons` hook. 32+ lessons seeded. Lesson completion tracking via `/api/v1/lessons/{id}/complete` |
| 4 | 5-question quizzes | YE MIN KO | Done | Backend: `QuizController` (start/submit/result). Frontend: `QuizPage.tsx`. Instant feedback, per-subtopic |
| 5 | XP tracking | | Done | Backend: `QuizService` awards 10 XP/correct. DB: `increment_user_xp()` RPC. Frontend: Header shows total XP |
| 6 | Hearts (exam sim) | | In progress | Frontend: `ExamPage.tsx` has client-side 3-heart system. DB: `exams.initial_hearts`, `exam_sessions.hearts_remaining`, `exam_heart_events`. **No backend enforcement yet** — hearts are client-side only |
| 7 | Streak tracking | | Done | Backend: `UserService.updateUserStreak()` (atomic CTE). Frontend: Header shows streak, syncs on login via `/api/v1/me/streak` |
| 8 | Mistake Garden | | Partial | Frontend: `MistakeGarden.tsx` works (reads `user_mistakes` via direct Supabase). **No backend** (no MistakeController/Service). Two overlapping DB tables: `mistakes` (rich) + `user_mistakes` (simple) — needs consolidation |
| 9 | Exam simulation | | In progress | Frontend: `ExamPage.tsx` (full UI: timer, hearts, difficulty selector, scoring). DB: `exams`, `exam_sessions`, `exam_answers`, `exam_heart_events` + functions `get_exam_questions()`, `increment_user_xp()`. **No backend controller/service yet** — frontend calls Supabase directly |
| 10 | Rule-based difficulty | | Done | DB trigger `assign_question_difficulty()` (migration 007) auto-calculates `difficulty_score` + `difficulty` label from question metadata |
| 11 | Landing page + mascot | | In progress | `LandingPage.tsx` has hero section, feature cards, CTAs. Needs mascot design + polish |
| 12 | Mobile responsiveness | | In progress | Tailwind mobile-first classes. Header has hamburger menu. Sidebar mobile overlay not yet wired (hardcoded `hidden`) |
| 13 | Data extraction | Myat | Done | 3 exam sessions seeded (2021-April, 2021-October, 2022-April) + business questions (migration 017). Pipeline documented in `.claude/skills/` |
| 14 | Database schema + seed | Myat | Done | 27 tables across migrations 001–018. RLS on all tables. 5 functions, 12 triggers, 18 indexes |
| 15 | CI/CD setup | Myo Min Lin | Finished | GitHub Actions deployment |
| 16 | Flashcards | | Week 2 stretch | DB schema ready (`flashcards`, `user_flashcard_state`, `flashcard_reviews`). No backend/frontend code |
| 17 | Weak point analysis | | Week 2 stretch | DB index `idx_mastery_weak_points` exists. No backend/frontend code |
| 18 | Additional exams | | Week 2 stretch | Extraction pipeline ready for remaining exam sessions |
| 19 | Backend Dockerization | Myo Min Lin | Finished | Multi-stage Dockerfile (Gradle + Java 25), docker-compose.yml orchestrating backend + Supabase local. [Issue #12](https://github.com/vibe-code-tours/team-16-app/issues/12) |

## Week 1 target: #1–15 functional (local demo)
## Week 2 target: #16–20 + polish (public demo)

## Known gaps (from codebase audit 2026-07-15)

1. **Mistake Garden (#8) needs backend**: No `MistakeController`/`MistakeService` exists. Frontend bypasses backend entirely via direct Supabase calls.
2. **Exam simulation (#9) needs backend**: No `ExamController`/`ExamService`. Frontend calls `supabase.rpc('get_exam_questions')` directly.
3. **Duplicate DB tables**: `profiles` (001) vs `user_profiles` (003), `mistakes` (001) vs `user_mistakes` (005). Needs consolidation migration.
4. **LessonPage bypasses backend**: `LessonPage.tsx` queries Supabase directly instead of using the `/api/v1/subtopics/{id}/lessons` endpoint.
5. **Orphaned frontend files**: `QuizSession.tsx`, `QuizResult.tsx`, `sampleQuestions.ts` not routed — legacy code should be removed.
6. **No JPA entity for `user_profiles`**: `UserService` uses raw `JdbcTemplate` instead of a repository.
