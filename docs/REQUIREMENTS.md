# Requirements — NerdQuiz MVP

> Sourced from `docs/NerdQuiz-Team-Briefing.md`. Nothing here is invented.

## Week 1 — Local Demo (functional, rough)

| Feature | What "done" means |
|---|---|
| User registration & login | Email/password + Google sign-in via Supabase Auth |
| Learning map | Visual topic tree — locked/unlocked states, category nodes |
| Short lessons | Brief reading notes (2-3 min) displayed before each quiz |
| 5-question quizzes | Per-topic quiz, instant feedback after each answer |
| XP tracking | Earn XP per correct answer, display total XP on profile |
| Hearts (exam sim only) | Lose a heart per wrong answer during exam simulation, not during practice |
| Streak tracking | Daily login streak, displayed on dashboard |
| Mistake Garden | Wrong answers collected per user, reviewable with correct answer + explanation |
| Exam simulation | Timed exam (Subject-A: 60 questions), countdown timer, submit-and-score |
| Rule-based difficulty | Assign easy/medium/hard based on question metadata — no AI |
| Landing page | Mascot + hero text + CTA buttons |
| Mobile-responsive | Works on phone browser (no native app) |
| ~180 questions seeded | 3 recent exam sessions × 60 Subject-A questions |
| Data extraction pipeline | PDF → JSON → SQL seed, PyMuPDF + OCR fallback, figures as WebP |
| Database schema | Complete Supabase schema with RLS, deployed to remote |

## Week 2 — Public Demo (polish + stretch)

| Feature | What "done" means |
|---|---|
| Polish UI/UX | Transitions, loading states, empty states, error handling |
| Flashcards | Key concept cards with manual flip (spaced repetition is a stretch) |
| Weak point analysis | Dashboard shows which topic categories the user scores lowest in |
| Additional exams | Extract and seed 1-2 more exam sessions if time allows |
| Subject-B questions | Add if extraction progress allows |
| Performance tuning | API response times, frontend load speed |
| Admin dashboard (stats) | Role-gated dashboard with: stat cards (total users, active today/this week, quiz/exam attempts, avg scores, exam pass rate), charts (daily active users line chart, topic engagement bar charts, quiz completion pie chart, exam pass/fail pie chart). User management page with searchable/sortable table, quick filters (Active Today, Inactive 30d+, New 7d), detail drawer with tabs (Overview, Activity, Performance), and actions (change role, reset streak, deactivate, CSV export). Requires `role` column on `user_profiles`. Uses Recharts for visualization. |

## Explicitly out of scope (this project)

- Full AI adaptive difficulty (AI Coach) — future feature
- All 3,120 questions extracted — expand gradually after demo
- Advanced gamification (leaderboards, achievements, social features)
- Native mobile app
- Payment / subscription model
- Full admin panel for content management (CRUD on questions, lessons, etc.)

## Non-functional requirements

| Requirement | Target |
|---|---|
| Mobile responsive | All screens usable on phone (360px+ width) |
| API response time | < 500ms for quiz/progress endpoints |
| Accessibility | Basic: semantic HTML, labels on forms, keyboard navigable |
| Data integrity | RLS policies on all user-data tables |
| Deployment | Deployable to a public URL by end of Week 2 |

## Risks

| Risk | Impact | Mitigation |
|---|---|---|
| Data extraction takes too long | No questions = no app | Start day 1, use AI + human review, focus on Subject-A |
| Subject-B questions too complex | Missing data | Defer Subject-B to Week 2 |
| Team skill level variance | Slow progress | Pair programming, clear task breakdown |
| Scope creep | Nothing finishes | Stick to this list, defer extras |
| Integration issues | Demo fails | Deploy early, test daily |
