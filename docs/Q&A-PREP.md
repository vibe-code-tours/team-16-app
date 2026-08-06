# Q&A Prep — Public Demo (Myo Min Lin)

> You worked on: **CI/CD (GitHub Actions + Netlify + Cloud Run)**, **Admin Dashboard**,
> **Role-based access control (admin/user/deactivated)**, **Docker/backend containerization**.
> This doc covers **every feature** so you can answer any question about the platform.

---

## Table of Contents

1. [Architecture Overview](#1-architecture-overview)
2. [Authentication & Authorization](#2-authentication--authorization)
3. [Learning Map](#3-learning-map)
4. [Lessons](#4-lessons)
5. [Quizzes](#5-quizzes)
6. [Exam Simulation](#6-exam-simulation)
7. [Mistake Garden](#7-mistake-garden)
8. [XP & Streaks](#8-xp--streaks)
9. [Weak Point Analysis](#9-weak-point-analysis)
10. [Flashcards (stretch)](#10-flashcards-stretch)
11. [Admin Dashboard](#11-admin-dashboard)
12. [User Profile](#12-user-profile)
13. [Dark/Light Theme](#13-darklight-theme)
14. [AI Content Engine](#14-ai-content-engine)
15. [CI/CD & Deployment](#15-cicd--deployment)
16. [Database & Data](#16-database--data)
17. [Security](#17-security)
18. [Potential Questions & Answers](#18-potential-questions--answers)

---

## 1. Architecture Overview

### System Diagram

```
┌──────────────┐       ┌──────────────────┐       ┌──────────────────┐
│   React SPA  │──────▶│  Spring Boot API  │──────▶│  Supabase        │
│  (Netlify)   │       │  (Cloud Run)      │       │  (Postgres DB)   │
│              │       │                   │       │                  │
│  React Router│       │  REST endpoints   │       │  18 migrations   │
│  Tailwind CSS│       │  JWT verification │       │  RLS on all      │
└──────┬───────┘       └───────────────────┘       └──────────────────┘
       │
       │  Supabase Auth SDK
       │  (register, login, session)
       ▼
┌──────────────────┐
│  Supabase Auth   │
│  (managed)       │
│  Email/Google    │
└──────────────────┘
```

### Two Data Access Paths

1. **Frontend → Supabase Auth (direct)** — Registration, login, session management. Credentials **never** touch the backend.
2. **Frontend → Spring Boot → Postgres** — All business data (quizzes, exams, XP, mistakes, profiles). JWT attached as Bearer token.

### Tech Stack

| Layer | Technology | Hosting |
|-------|-----------|---------|
| Frontend | React 19, TypeScript, Tailwind CSS 4, React Router v7, Vite | Netlify (static) |
| Backend | Java 25, Spring Boot 3.5, Spring Data JPA, Spring Security, Nimbus JWT | Cloud Run (serverless) |
| Database | Supabase Postgres with RLS | Supabase managed |
| Auth | Supabase Auth (email/password + Google OAuth) | Supabase managed |

---

## 2. Authentication & Authorization

### How it works

1. User signs up/logs in via Supabase Auth SDK directly from the frontend
2. Supabase returns a JWT token, stored in browser localStorage by the SDK
3. Every API call to Spring Boot attaches `Authorization: Bearer <token>`
4. Spring Boot's `JwtAuthenticationFilter` verifies the JWT signature against Supabase's JWKS endpoint
5. User ID extracted from JWT `sub` claim — backend never trusts client-supplied user IDs
6. Backend upserts a `user_profiles` row on first login (via `POST /api/v1/me/profile`)

### Route Guards (Frontend)

| Component | What it does |
|-----------|-------------|
| `ProtectedRoute` | Redirects to `/login` if no session |
| `AdminRoute` | Redirects to `/` if `user.role !== 'admin'` |
| `StudentRoute` | Redirects admins to `/admin` so they don't see student pages |

### Role System

Three roles in `user_profiles` table:
- `user` — standard student (default)
- `admin` — full access to admin dashboard + user management
- `deactivated` — account disabled; cannot log in (check enforced by a RLS policy? — verify)

### Login Options

1. **Email + Password** — standard Supabase Auth
2. **Google OAuth** — one-click via Supabase's Google provider
3. Registration is open — anyone can sign up

---

## 3. Learning Map

### What it is

A visual topic tree with 5 milestone categories × 20 subtopics, inspired by Duolingo's skill tree.

### Categories

| Category | Color | Subtopics |
|----------|-------|-----------|
| Technology | Purple | Computer Architecture, Data Structures, Algorithms, Databases, Networking, Operating Systems, Software Development |
| Security | Red | Cryptography, Network Security, Access Control, Security Threats |
| Management | Blue | Project Management, Quality Assurance, Development Processes |
| Strategy | Emerald | Intellectual Property, IT Governance, Business Strategy |
| Business | Amber | Finance, Procurement, Business Operations |

### How progress works

- Each topic has a status: `locked`, `not_started`, `in_progress`, `completed`
- Topics unlock as prerequisites are completed
- The welcome hero shows: XP, streak count, journey progress %, next recommended topic
- "Continue / Start" CTA takes user to the next uncompleted topic
- When all topics complete → CTA changes to "Celebrate with an exam"

### API endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v1/topics` | Fetch all topics with user progress status |

### Frontend

- Route: `/map`
- Component: `LearningMap.tsx`
- Hook: `useTopics()`
- Sub-components: `TopicNode.tsx`, `Badge`, `Card`
- States: loading (skeleton), error (red alert with retry), empty (friendly message + link to exam)

---

## 4. Lessons

### What it is

Short reading notes (2-3 min) displayed before each quiz. Content is Markdown-rendered.

### Key data

- 32+ seeded lessons across subtopics
- Content stored as JSONB (`content_blocks`) in the `lessons` table
- Each lesson has: title, summary, content blocks, estimated reading time, XP reward
- Prerequisites: lessons can require other lessons to be completed first

### Lesson flow

1. User clicks a topic on the Learning Map → `TopicDetail.tsx` shows subtopics + lessons
2. User clicks a lesson → `LessonPage.tsx` renders content
3. Users can also go directly to `/quizzes` to see standalone quiz listing
4. Lesson completion tracked via `user_lesson_progress` table

### API endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v1/subtopics/{id}/lessons` | Fetch lessons for a subtopic |
| GET | `/api/v1/lessons/{id}` | Fetch a single lesson with full content |
| POST | `/api/v1/lessons/{id}/complete` | Mark lesson as completed |

### Known gap

`LessonPage.tsx` bypasses the backend for some data and queries Supabase directly — less secure but functional.

---

## 5. Quizzes

### What it is

Bite-sized 5-question practice after each lesson with instant feedback and XP rewards.

### Quiz flow

1. User navigates to a subtopic → clicks "Start Quiz"
2. Backend selects 5 questions for the subtopic
3. User answers one at a time — instant feedback after each answer (correct/incorrect + explanation)
4. After answering all 5 → results screen with score and XP earned
5. Wrong answers automatically recorded in the Mistake Garden

### Key implementation details

- Questions are drawn from the `questions` table, linked to subtopics via `question_subtopics`
- XP: 10 XP per correct answer
- Difficulty: rule-based (easy/medium/hard from metadata), also assigned via DB trigger
- Timer: none in practice mode — students can take their time

### API endpoints

| Method | Path | Purpose |
|--------|------|---------|
| POST | `/api/v1/quizzes` | Start a new quiz session |
| POST | `/api/v1/quizzes/{sessionId}/answer` | Submit answer for current question |
| GET | `/api/v1/quizzes/{sessionId}/result` | Get quiz result |

### Frontend

- Route: `/quiz/:subtopicId`
- Component: `QuizPage.tsx`
- Sub-components: `ChoiceList`, `QuestionBlock`, `ExplanationBox`, `ProgressBar`
- States: question display, feedback overlay, results summary
- Shows explanation after each answer (learning-oriented, not test-oriented)

---

## 6. Exam Simulation

### What it is

A full timed exam simulation that mirrors real ITPEC FE conditions — 60 questions (Subject-A) with a 60-minute countdown timer.

### Exam flow

1. User clicks "Start Exam" → `ExamStartScreen` shows exam info + difficulty selector
2. Timer starts counting down from 60 minutes
3. User answers 60 questions one at a time (or navigates freely?)
4. On submit (or time-up) → results screen with score, percentage, pass/fail
5. Wrong answers added to Mistake Garden

### Key implementation details

- Questions fetched from `exam_questions` join table (pre-defined question set per exam)
- **Hearts system was removed** during development — wrong answers have no penalty. The timer provides enough structure.
- Timer persists across page refreshes (stored server-side via `expires_at` on `exam_sessions`)
- Results shown per question — user can review all 60 answers after completion
- XP awarded based on number of correct answers

### API endpoints

| Method | Path | Purpose |
|--------|------|---------|
| POST | `/api/v1/exams/{examId}/start` | Start an exam session |
| POST | `/api/v1/exams/sessions/{sessionId}/answer` | Submit answer |
| POST | `/api/v1/exams/sessions/{sessionId}/complete` | Complete/score the exam |
| GET | `/api/v1/exams/sessions/{sessionId}/results` | Get full results |

### Frontend

- Route: `/exam`
- Components: `ExamSimulation.tsx`, `ExamStartScreen.tsx`, `ExamQuestionCard.tsx`, `ExamProgressBar.tsx`, `ExamTimer.tsx`, `ExamResultScreen.tsx`
- Hook: `useExamSimulation.ts`
- UI: Question navigation, timer display, progress bar, result summary with score breakdown

### Data source

- 3 exam sessions seeded: 2021-April, 2021-October, 2022-April
- Each session has 60 Subject-A questions

---

## 7. Mistake Garden

### What it is

A core exam-prep feature: automatically collects every wrong answer so students can review and learn from their mistakes.

### How it works

- Every time a user gets a question wrong in a quiz or exam, it's automatically saved to the `mistakes` table
- The Mistake Garden page shows: question text, what the user answered, the correct answer, and an explanation
- Users can mark mistakes as "reviewed" → removes from active review queue
- Mistakes are deduplicated per question per user (unique constraint on `user_id, question_id`)
- Tracks: mistake count, review count, last missed date, resolved status

### API endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v1/me/mistakes` | Fetch current user's mistakes |
| POST | `/api/v1/me/mistakes` | Record a mistake |
| PUT | `/api/v1/me/mistakes/{id}/review` | Mark mistake as reviewed |

### Frontend

- Route: `/mistakes`
- Component: `MistakeGarden.tsx`
- States: loading, empty ("No mistakes yet — keep studying!"), list with cards, reviewed state
- Each card shows: question, user's wrong answer (highlighted), correct answer, explanation, review button

---

## 8. XP & Streaks

### XP System

| Action | XP |
|--------|----|
| Correct quiz answer | 10 XP |
| Complete lesson | varies (lesson.xp_reward) |

- Total XP displayed on: Learning Map hero, Header, Profile page
- XP is idempotent — each event has a unique `idempotency_key` to prevent double-counting
- XP events logged in `xp_events` table with source tracking
- Total stored in `user_stats.total_xp`

### Streak System

- Tracks consecutive days the user logs in
- Updated on every login via `POST /api/v1/me/streak`
- Uses atomic CTE (Common Table Expression) in the database for consistency
- If user misses a day → streak resets to 0
- Streak count shown with 🔥 fire emoji

### API endpoints

| Method | Path | Purpose |
|--------|------|---------|
| POST | `/api/v1/me/streak` | Update/login streak (called automatically during auth flow) |
| GET | `/api/v1/me/profile` | Get user profile with XP and streak |

---

## 9. Weak Point Analysis

### What it is

Topic-level accuracy tracking that shows users where they're struggling most.

### How it works

- Tracks accuracy per subtopic via `user_subtopic_mastery` table
- Color-coded indicators:
  - 🟢 Green (≥80%) — strong
  - 🟡 Yellow (50-79%) — needs work
  - 🔴 Red (<50%) — weak point
- Shows: subtopic name, accuracy percentage, questions seen/correct, direct link to practice
- Data backfilled from existing quiz/exam answers via migration

### Frontend

- Route: `/weak-points`
- Components: `WeakPointAnalysis.tsx`, `WeakPointCard.tsx`, `WeakPointSummary.tsx`
- Hook: `useWeakPoints.ts`
- States: loading skeleton, empty ("Not enough data yet — try a few quizzes"), list with color bars

### API endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v1/me/weak-points` | Fetch weak point analysis data |

---

## 10. Flashcards (stretch)

### Status: Schema only — not implemented in frontend or backend

- Database tables exist: `flashcards`, `user_flashcard_state`, `flashcard_reviews`
- Schema supports spaced repetition (SM-2 algorithm fields: `interval_days`, `ease_factor`, `repetitions`, `due_at`)
- No frontend route or component built
- No backend controller or service built
- Marked as "Week 2 stretch" — was de-scoped if time didn't allow

---

## 11. Admin Dashboard

### What it is (Your feature!)

A role-gated dashboard for founders to monitor platform health and manage user accounts. **Students never see it; admins get full access.**

### Access Control

1. `user_profiles.role` column — values: `admin`, `user`, `deactivated`
2. `AdminRoute` component — checks `user.role === 'admin'`, redirects non-admins
3. `StudentRoute` component — redirects admins away from student pages
4. Backend: `@AdminOnly` annotation or role check in `AdminController` methods

### Dashboard Page (`/admin`)

Four key stat cards at the top:

| Stat | What it measures |
|------|-----------------|
| Total Users | All registered users |
| Active Today | Users who logged in today |
| Quiz Attempts | Total quiz sessions started |
| Average Score | Mean score across all quizzes |

Five charts (powered by Recharts library):

| Chart | Type | What it shows |
|-------|------|--------------|
| Active Users | Line chart | Daily active users over time |
| Topic Engagement | Bar chart | Quiz attempts per topic category |
| Quiz Completion | Pie/Donut chart | Completion rates — in_progress vs completed vs abandoned |
| Exam Pass Rate | Pie/Donut chart | Pass vs fail distribution (pass threshold = 60%) |
| Topic Scores | Bar chart | Average scores per topic category |

### User Management Page (`/admin/users`)

**Searchable/sortable table** with columns:
- Name, Email, Role, XP, Streak, Last Active, Status

**Quick filters:**
- Active Today
- Inactive 30d+
- New (last 7 days)
- All

**User Detail Drawer** — slides out when clicking a user row. Has 3 tabs:
1. **Overview** — profile info, member since, role, status
2. **Activity** — recent activity log (login events, quiz completions)
3. **Performance** — XP history, quiz scores, weak point data

**Actions:**
- Change role (user ↔ admin)
- Reset streak
- Deactivate / Reactivate account
- CSV Export — downloads all user data as CSV

### Admin API endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v1/admin/stats` | Stat card totals |
| GET | `/api/v1/admin/stats/active-users` | Daily active user time series |
| GET | `/api/v1/admin/stats/topic-engagement` | Quiz attempts by topic category |
| GET | `/api/v1/admin/stats/quiz-completion` | Quiz completion rate data |
| GET | `/api/v1/admin/stats/exam-pass-rate` | Exam pass/fail distribution |
| GET | `/api/v1/admin/stats/topic-scores` | Average scores per topic |
| GET | `/api/v1/admin/users` | Paginated, searchable, filterable user list |
| GET | `/api/v1/admin/users/{id}` | Single user detail |
| GET | `/api/v1/admin/users/{id}/activity` | User activity history |
| GET | `/api/v1/admin/users/{id}/performance` | User performance data |
| PATCH | `/api/v1/admin/users/{id}/role` | Change user role |
| PATCH | `/api/v1/admin/users/{id}/deactivate` | Deactivate user |
| PATCH | `/api/v1/admin/users/{id}/reactivate` | Reactivate user |
| POST | `/api/v1/admin/users/{id}/reset-streak` | Reset user's streak |
| GET | `/api/v1/admin/users/export` | CSV export |

### Backend implementation

- `AdminController.java` — REST controller with role-checked endpoints
- `AdminService.java` — business logic using `JdbcTemplate` for complex queries
- Role check: reads `user_profiles.role` from the JWT-authenticated user
- Uses `JdbcTemplate` directly rather than JPA (simpler for aggregate queries)

### Frontend components

| Component | What it does |
|-----------|-------------|
| `AdminDashboard.tsx` | Dashboard page with stat cards + charts |
| `AdminUsers.tsx` | User management page |
| `UserTable.tsx` | Sortable/searchable user table |
| `UserCard.tsx` | Individual user row/card |
| `UserFilters.tsx` | Filter buttons (Active Today, etc.) |
| `UserDrawer.tsx` | Slide-out detail panel |
| `UserPagination.tsx` | Table pagination |
| `ActiveUsersChart.tsx` | Line chart (Recharts) |
| `TopicQuizChart.tsx` | Topic engagement bar chart |
| `QuizCompletionChart.tsx` | Quiz completion pie chart |
| `ExamPassChart.tsx` | Exam pass/fail pie chart |
| `TopicScoreChart.tsx` | Topic scores bar chart |

### Seeding the first admin

```sql
UPDATE public.user_profiles SET role = 'admin' WHERE id = '<your-user-id>';
```

Or use the seed_admin.sql script with a specific email.

### Routes

```
/admin        → AdminDashboard
/admin/users  → AdminUsers
/ai-draft     → AiDraftPreview (admin-only AI content view)
```

---

## 12. User Profile

### What it is

A personal stats page at `/profile` showing:

- Display name (editable)
- Total XP
- Current streak + longest streak
- Level badge (computed from total XP)
- Member since date
- Weekly activity chart (questions answered per day)
- Learning statistics (quizzes completed, exams completed, total questions answered)
- Dark/Light theme toggle
- Sign out button

### API endpoints

| Method | Path | Purpose |
|--------|------|---------|
| GET | `/api/v1/me/profile` | Get full profile |
| POST | `/api/v1/me/profile` | Create/upsert profile |
| PUT | `/api/v1/me/profile` | Update profile (display name) |

---

## 13. Dark/Light Theme

### How it works

- Semantic CSS variables defined in Tailwind config
- Uses Tailwind's `dark:` variant classes
- Theme toggle (`ThemeToggle.tsx` on Profile page)
- `useTheme.tsx` hook — persists preference to `localStorage`
- Supports: light (default), dark, follows system preference
- Applied via class on `<html>` element (`class="dark"`)

### Implementation details

- No external theme library — custom implementation
- Toggle button: sun/moon icons from Lucide
- Theme state managed via React Context
- Transition animation on theme switch

---

## 14. AI Content Engine

### What it is

A 3-agent pipeline that extracts ITPEC exam questions from PDFs and generates structured quiz data + lesson content.

### Pipeline

1. **Extractor** — Parses ITPEC PDF using PyMuPDF, extracts question text, choices, and answer key
2. **Reviewer** — Validates extracted data, flags ambiguous or incomplete entries
3. **Weaver** — Generates lesson content from the question data, creates Markdown summaries

### Output

- Structured JSON per question (see schema in data-handling rules)
- Lesson content (Markdown with key points, tips, examples)
- Figures extracted as WebP images stored in Supabase Storage

### Implementation status

- Extraction pipeline documented in `.claude/skills/extract-data/`
- 3 exam sessions fully extracted and seeded
- Admin-only preview page at `/ai-draft` — shows extracted content for review

---

## 15. CI/CD & Deployment

> **This is your area.** You own this end-to-end.

### CI Pipeline (`.github/workflows/ci.yml`)

Triggers on: push to main, pull requests.

| Step | What it does |
|------|-------------|
| Setup Node | Node 20, npm cache |
| Install | `npm ci` (or `npm install` as fallback) |
| Lint | `npm run lint` |
| Typecheck | `npm run typecheck` |
| Test | `npm test` |
| Build | `npm run build` |
| Setup Java | JDK 25 (Temurin), Gradle cache |
| Build & Test | `./gradlew build` — compiles + runs all tests |

Key feature: **Progressive enforcement** — each step is guarded by `if: hashFiles(...)` so a fresh repo stays GREEN until you add the matching files. Steps only run when their dependencies exist.

### Security Pipeline (`.github/workflows/security.yml`)

| Step | Tool | What it catches |
|------|------|----------------|
| Secrets | Gitleaks | Leaked API keys, tokens, credentials in git history |
| SAST | Semgrep | Injection flaws, insecure defaults, bad patterns |

Both run with `continue-on-error: true` (advisory mode) so findings are reported but don't block merges. Can be flipped to enforcement later.

### Deployment: Frontend (`.github/workflows/deploy-frontend.yml`)

| Detail | Value |
|--------|-------|
| Platform | Netlify (static hosting) |
| Trigger | Push to `main` with changes in `src/web/**` or `netlify.toml` |
| Steps | Install → Lint → Test → Build → Deploy via `netlify-cli` |
| SPA routing | `[[redirects]]` in `netlify.toml`: `/*` → `/index.html` (status 200) |
| Build output | `dist/` directory |
| Env vars | `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`, `VITE_API_URL` stored as GitHub Secrets → build-time env |

### Deployment: Backend (`.github/workflows/deploy-backend.yml`)

| Detail | Value |
|--------|-------|
| Platform | Google Cloud Run (serverless container) |
| Trigger | Push to `main` with changes in `src/api/**` or `docker-compose.yml` |
| Steps | Auth to GCP → Configure Docker → Create Artifact Registry (if needed) → Build & push image → Deploy to Cloud Run |
| Image registry | Artifact Registry (`REGION-docker.pkg.dev/PROJECT/nerdquiz-api`) |
| Container | Multi-stage Dockerfile: JDK 25 Alpine (build) → JRE 25 Alpine (runtime) |
| JVM flags | `-XX:+UseContainerSupport`, `-XX:MaxRAMPercentage=75.0` |
| Scaling | `--min-instances 0` (scale to zero when idle) |
| Memory | 1Gi, 1 CPU |
| Env vars | `DATABASE_URL`, `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `CORS_ALLOWED_ORIGINS` from GitHub Secrets |
| Health check | `HEALTHCHECK` in Dockerfile: `wget -qO /dev/null http://localhost:8080/` (15s intervals, 40s start period) |

### Dependabot (`.github/dependabot.yml`)

- npm dependencies: weekly, grouped minor/patch PRs
- pip dependencies: weekly
- GitHub Actions: weekly

### Docker Compose (local dev)

```yaml
services:
  backend:
    build: ./src/api
    network_mode: host
    environment:
      - DATABASE_URL, DB_USER, DB_PASSWORD, SUPABASE_URL, SUPABASE_ANON_KEY
```

Frontend runs separately via `npm run dev` (Vite proxies `/api/*` to backend).

---

## 16. Database & Data

### Key Tables

| Table | Purpose |
|-------|---------|
| `questions` | All exam questions (180+ seeded, Subject-A) |
| `topics` | 5 category milestones |
| `subtopics` | 20 learning topics (4 per category) |
| `lessons` | Lesson content with Markdown blocks |
| `quiz_sessions` | Quiz attempt tracking |
| `quiz_answers` | Individual answer records |
| `exam_sessions` | Timed exam session tracking |
| `exam_answers` | Exam answer records |
| `user_profiles` | User profile + role + status |
| `user_stats` | XP, streak, quiz/exam counts |
| `xp_events` | Idempotent XP event log |
| `mistakes` | Wrong answer collection (Mistake Garden) |
| `user_subtopic_mastery` | Per-subtopic accuracy for weak point analysis |

### RLS (Row-Level Security)

- Enforced on ALL user-data tables
- Public tables (questions, topics, lessons) — read-only for anyone
- User-owned tables — `auth.uid() = user_id` check on every row
- Admin override policy: "Admins can view all profiles" on `user_profiles`

### Seed Data

- 3 exam sessions (2021-April, 2021-October, 2022-April) — ~180 Subject-A questions
- 5 categories, 20 subtopics
- 32+ lessons with content
- Business questions (migration 017)

---

## 17. Security

### Key measures

1. **JWT verification on every request** — `JwtAuthenticationFilter` validates token signature against Supabase JWKS
2. **No credentials in backend** — Supabase Auth handles all authentication
3. **RLS defense-in-depth** — even if API is compromised, DB-level RLS protects user data
4. **User ID from JWT, never from request body** — prevents ID spoofing
5. **No PII in logs** — emails, user IDs, JWT tokens never logged
6. **CORS restricted** — only allowed frontend origins
7. **RFC 7807 error responses** — no stack traces or SQL errors leaked to clients
8. **Migration to remove exposed view** — dropped `public.users` view that leaked email addresses without RLS (migration 20260720000000)
9. **Secrets management** — all secrets in GitHub Secrets or `.env`, never in code
10. **Regular scanning** — Gitleaks (secrets) + Semgrep (SAST) in CI

---

## 18. Potential Questions & Answers

### General Platform Questions

**Q: What problem does NerdQuiz solve?**
A: ITPEC FE certification has a pass rate below 30% in many regions. Students lack structured, gamified study tools. NerdQuiz turns dry exam prep into a Duolingo-style learning experience — short lessons, bite-sized quizzes, mistake review, and real exam simulations, all in one place with motivation systems (XP, streaks) to keep students coming back.

**Q: How is this different from a plain question bank app?**
A: Three things: (1) Learning Map with progression — you don't just answer random questions, you follow a structured path through the syllabus. (2) Mistake Garden — wrong answers are automatically collected for focused review, which is the core of effective exam prep. (3) Full exam simulation — timed, 60 questions, mirrors real exam conditions.

**Q: How many questions are in the system?**
A: ~180 Subject-A questions from 3 exam sessions (2021-April, 2021-October, 2022-April). The extraction pipeline can handle more — this covers the demo scope.

**Q: Who is the target user?**
A: ITPEC FE certification candidates. The app is designed for self-study — students use it alongside their regular study materials.

**Q: Is this production-ready or a demo?**
A: This is a functional demo built in 2 weeks by 8 developers. It works end-to-end and is deployed to a public URL, but it's not production-scale. Known gaps: no rate limiting, no load testing, limited question count, some edge cases not fully handled.

### Architecture Questions

**Q: Why Spring Boot + React instead of a simpler stack?**
A: The team wanted to demonstrate enterprise-grade architecture skills. Spring Boot gives us proper REST APIs with JWT security, JPA for data access, and a clean layered architecture. React gives us a modern SPA with component reusability. Overkill for a demo? Maybe — but it shows we can build production-quality systems.

**Q: Why two data paths (frontend→Supabase and frontend→Spring Boot)?**
A: Supabase Auth is a managed service — it handles registration, login, session management, and OAuth out of the box. We call it directly from the frontend so credentials never pass through our backend (security best practice). All business data (quizzes, XP, mistakes) goes through Spring Boot so we can enforce business logic, validation, and audit trails.

**Q: Why Cloud Run instead of a VPS?**
A: Cloud Run is serverless — it scales to zero when not in use (zero cost during idle) and scales up automatically under load. No server management, no SSH, no patching. The tradeoff is cold start latency (~2-3s) on the first request after idle.

**Q: Why Netlify instead of Cloud Run for the frontend?**
A: Netlify is purpose-built for static SPAs — global CDN, automatic HTTPS, SPA redirects, deploy previews. It's simpler, faster, and cheaper than serving static files from a container. And it's free.

### Auth Questions

**Q: How does authentication work?**
A: Three layers: (1) Supabase Auth handles registration/login and issues JWTs. (2) React's `AuthProvider` listens for auth state changes and stores the user profile in context. (3) Spring Boot's `JwtAuthenticationFilter` verifies every API call's JWT against Supabase's public JWKS endpoint — no sessions, no cookies, stateless.

**Q: What happens if Supabase is down?**
A: Users can't log in (that's a hard dependency). But if they're already logged in, the JWT is still valid until it expires — so existing sessions continue to work for API calls. The frontend would still render, but any auth-dependent operation fails gracefully.

**Q: Can I use the app without an account?**
A: No — registration is required. The Learning Map, quizzes, XP tracking, and Mistake Garden are all personalized per user.

### Feature Questions

**Q: How does the Learning Map decide which topics are unlocked?**
A: The backend tracks user progress per topic. Topics are unlocked based on prerequisite completion. The `TopicNode` component shows visual states: locked (gray), unlocked (available), in progress (partial), completed (checkmark). The exact prerequisite chain is defined in the database schema (`lesson_prerequisites` table and `topics` ordering).

**Q: How are quiz questions selected?**
A: For practice quizzes, the backend selects questions from the subtopic's pool. For exam simulations, questions come from a pre-defined `exam_questions` join table that maps exam sessions to their specific question sets. The difficulty selector on the exam start screen lets users choose easy/medium/hard — this filters questions by their `difficulty` field.

**Q: How does the exam timer work?**
A: When an exam session starts, the backend records `started_at` and `expires_at` (start + 60 min). The frontend reads `expires_at` on load and runs a local countdown. On every answer submission, the frontend checks if time has expired. The backend also validates that the session hasn't expired when answers are submitted. Timer persists across page refreshes because `expires_at` is server-side.

**Q: What happens when exam time runs out?**
A: The exam auto-submits. All answered questions are scored, unanswered questions are marked as incorrect. The user sees their results screen with the score.

**Q: How is XP calculated and stored?**
A: 10 XP per correct answer. Each XP event has a unique `idempotency_key` so the same action can't be double-counted. XP events are logged in the `xp_events` table, and the running total is cached in `user_stats.total_xp`. The database function `increment_user_xp()` handles the atomic update.

**Q: How does the Mistake Garden collect mistakes?**
A: Automatically — when a user submits a wrong answer in a quiz or exam, the backend inserts a row into the `mistakes` table. If the same question was already in their mistake garden, it increments `mistake_count` and updates `last_missed_at`. The deduplication is enforced by a unique constraint on `(user_id, question_id)`.

**Q: What's the Weak Point Analysis based on?**
A: The `user_subtopic_mastery` table tracks per-subtopic accuracy (questions seen vs. questions correct). The analysis shows this as a percentage with color coding. Data is backfilled from existing quiz and exam answers, and updated in real-time as users answer more questions.

**Q: Are flashcards implemented?**
A: The database schema is ready — we have the `flashcards`, `user_flashcard_state`, and `flashcard_reviews` tables with SM-2 spaced repetition fields. But the frontend and backend code weren't built due to time constraints. It's a candidate for future development.

### Admin-Specific Questions (Your Area)

**Q: How do I access the admin dashboard?**
A: Your account needs `role = 'admin'` in the `user_profiles` table. This is set manually via SQL. Once set, you'll see a link to `/admin` in the sidebar. The `AdminRoute` component checks `user.role === 'admin'` and redirects non-admins.

**Q: Can there be multiple admins?**
A: Yes — the role is just a column in `user_profiles`. Any user can be promoted to admin. There's no hierarchy (no super-admin vs admin distinction).

**Q: How is the admin API secured?**
A: The frontend `AdminRoute` prevents non-admins from seeing admin pages. The backend `AdminController` checks the user's role on every endpoint — if the caller isn't an admin, it returns 403 Forbidden. Both layers (frontend route guard + backend role check) must pass.

**Q: What data can admins see that regular users can't?**
A: Admin users can see: (1) Aggregate stats (total users, active counts, quiz/exam metrics across all users). (2) All user profiles (via the "Admins can view all profiles" RLS policy). (3) Individual user activity and performance histories. Regular users only see their own data.

**Q: Can an admin's account be deactivated?**
A: Yes — the `deactivated` role exists. If an admin is deactivated, they lose access to the admin panel. Only another admin can reactivate them (via the `/admin/users` page).

**Q: How are the admin charts implemented?**
A: Using Recharts, a React charting library. Each chart type (line, bar, pie) has its own component with loading states and responsive sizing. Data is fetched from the `/api/v1/admin/stats/*` endpoints which use `JdbcTemplate` for aggregate SQL queries.

**Q: Can I export user data?**
A: Yes — there's a CSV export endpoint. It returns all users' data as a downloadable CSV file. Useful for founders who want to analyze engagement in a spreadsheet.

**Q: How do I create the first admin?**
A: After signing up with your email, run:
```sql
UPDATE public.user_profiles SET role = 'admin' WHERE id = '<your-user-id>';
```
Or there's a `seed_admin.sql` script in `supabase/scripts/` that can do it by email lookup.

### CI/CD & Deployment Questions (Your Area)

**Q: What happens when I push to main?**
A: Two things trigger independently:
1. If `src/web/**` changed → Frontend CI runs (lint → typecheck → test → build → Netlify deploy)
2. If `src/api/**` changed → Backend CI runs (Gradle build → test → Docker build → push to Artifact Registry → Cloud Run deploy)
3. Both CI and Security workflows run on every push

**Q: How long does deployment take?**
A: Frontend: ~3-4 minutes (npm install + build + Netlify deploy). Backend: ~5-7 minutes (Docker build + push + Cloud Run deploy). Netlify and Cloud Run both support zero-downtime deployments.

**Q: How do I roll back a deployment?**
A: Netlify: use the Deploys tab in the Netlify dashboard to publish a previous deploy. Cloud Run: each deployment creates a new revision — you can roll back to any previous revision from the Cloud Run console with one click. Or re-run the previous workflow from GitHub Actions.

**Q: What happens if the backend crashes?**
A: Cloud Run automatically restarts the container. If it crashes repeatedly, Cloud Run shows the crash loop in the logs. The health check (every 15s) determines if the container is healthy — 3 consecutive failures trigger a restart.

**Q: How does the backend scale?**
A: Cloud Run auto-scales based on request concurrency. With `--min-instances 0`, it scales to zero when idle (no cost). During traffic, it creates new container instances as needed. The container has 1GB RAM and 1 CPU — enough for our Spring Boot API at demo traffic levels.

**Q: How are environment variables managed?**
A: In GitHub Secrets (encrypted at rest). For the backend: `DATABASE_URL`, `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `CORS_ALLOWED_ORIGINS`, `GCP_PROJECT_ID`, `GCP_REGION`, `GCP_SA_KEY`. For the frontend: `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`, `VITE_API_URL`. At deploy time, these are injected as environment variables into the respective platforms.

**Q: Why use GitHub Actions instead of Netlify's built-in CI?**
A: GitHub Actions gives us a single CI pipeline for both frontend and backend, consistent linting/testing regardless of deployment target, and integration with our security scanning. Netlify's built-in CI only handles the frontend.

**Q: How do you handle CORS?**
A: The backend has a `CorsConfig` that allows only the origins specified in `CORS_ALLOWED_ORIGINS` environment variable. In production, this is the Netlify frontend URL. In development, Vite proxies API requests so CORS isn't an issue locally.

**Q: Is there monitoring/alerts?**
A: Not yet. Cloud Run provides built-in logging and error reporting via Google Cloud Console. There are no external monitoring tools (Datadog, Sentry, etc.) configured. This is a known gap for production readiness.

### Data Questions

**Q: Where do the questions come from?**
A: All questions come from [ITPEC Past Exam Papers](https://itpec.org/pastexamqa/fe.html) — freely available for educational use. They're in PDF format, and we built an extraction pipeline (AI-powered) to convert them to structured JSON, then seed them into the database.

**Q: Are the questions officially from ITPEC?**
A: Yes — they're the actual past exam questions published by ITPEC. We don't modify the question content, just present them in a structured learning format.

**Q: How many questions are there?**
A: ~180 Subject-A questions from 3 exam sessions. ITPEC has published 39 sessions (~3,120 questions total) — extracting all of them was out of scope for the 2-week build.

**Q: Why Subject-A only?**
A: Subject-A (morning session) has 60 multiple-choice questions per exam — straightforward to extract and present. Subject-B (afternoon session) has complex questions with code snippets, diagrams, and multi-part answers. We prioritized Subject-A for the demo and planned Subject-B as a stretch goal.

### Team & Process Questions

**Q: How was the team organized?**
A: 8 developers, 2 weeks. GSD (Get Stuff Done) approach — each developer owned their feature end-to-end: plan, build, test, ship. No PM, no Scrum master. Daily 15-minute standups. AI tools (Claude Code) used extensively for code generation and review.

**Q: What was your role specifically?**
A: Backend Lead and Deployment. I owned: (1) CI/CD pipeline — GitHub Actions workflows for frontend and backend deployment. (2) Backend infrastructure — Docker containerization, Cloud Run deployment, environment configuration. (3) Admin Dashboard — stat cards, charts, user management API + frontend, role-based access control. (4) Team coordination — architecture decisions, integration testing, deployment strategy.

**Q: What was the biggest challenge?**
A: Data extraction — ITPEC questions are in PDFs, not structured data. We had to build an AI-powered pipeline to extract, parse, and validate ~180 questions. The second biggest challenge was integration — 8 developers working on different features meant we had to coordinate API contracts carefully to avoid conflicts.

**Q: What would you do differently?**
A: (1) Start deployment earlier — we were coding in isolation until Day 5, then spent 2 days fixing integration issues. (2) More frontend tests — we focused on functionality and didn't write enough component tests. (3) Standardize error handling patterns across the frontend earlier. (4) Better API contract documentation — some endpoints were discovered by reading code rather than docs.

**Q: Is the code open source?**
A: Yes — MIT licensed. Available on GitHub. We believe in sharing educational tools freely.

### Edge Cases You Might Get Asked

**Q: What happens if 2 users answer the same question at the same time?**
A: Each quiz session has its own set of questions. XP updates use atomic database operations with idempotency keys, so concurrent submissions are safe. The `xp_events` table has a unique constraint on `(user_id, idempotency_key)` preventing double-counting.

**Q: What happens if the database connection pool is exhausted?**
A: Spring Boot with default HikariCP uses a connection pool (default 10 connections). At demo traffic levels, this is more than sufficient. If exhausted, new requests queue up and wait for a connection to free up, or time out after 30 seconds.

**Q: How does the app handle network failures?**
A: The frontend API client (`api.ts`) throws errors that are caught by hooks and displayed as user-friendly messages. Most routes have error states (red alerts with retry suggestions). The Supabase SDK handles token refresh transparently.

**Q: What if a user's JWT expires mid-quiz?**
A: Supabase JS SDK automatically refreshes the JWT before it expires. If the refresh fails, the API call returns 401, and the user is redirected to login. Their quiz session is saved in the database — they can resume? (This depends on whether quiz resumption is implemented — current code creates a new session on start, so probably not.)

**Q: How do you prevent users from gaming the XP system?**
A: Idempotency keys on XP events prevent double-counting from retries. XP is only awarded for correct answers in quizzes/exams — there's no way to earn XP without answering questions. If a user repeatedly starts and abandons quizzes, no XP is awarded for unanswered questions.
