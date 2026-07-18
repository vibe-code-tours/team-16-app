# NerdQuiz — Complete Features & Functionalities Reference

> Auto-generated reference of all features, routes, API endpoints, database objects,
> CI/CD pipelines, and infrastructure for the NerdQuiz platform.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Frontend Routes & Pages](#2-frontend-routes--pages)
3. [Frontend Components](#3-frontend-components)
4. [Frontend Hooks](#4-frontend-hooks)
5. [Backend API Endpoints](#5-backend-api-endpoints)
6. [Backend Services](#6-backend-services)
7. [Database Schema](#7-database-schema)
8. [Database Functions (RPC)](#8-database-functions-rpc)
9. [Database Migrations](#9-database-migrations)
10. [Seed Data](#10-seed-data)
11. [CI/CD Pipelines](#11-cicd-pipelines)
12. [Infrastructure & Deployment](#12-infrastructure--deployment)
13. [Environment Variables](#13-environment-variables)
14. [Scripts & Commands](#14-scripts--commands)
15. [Security Features](#15-security-features)
16. [Feature Status Matrix](#16-feature-status-matrix)

---

## 1. Project Overview

| Attribute | Value |
|-----------|-------|
| **Name** | NerdQuiz |
| **Purpose** | Gamified IT exam prep platform for ITPEC FE certification |
| **Frontend** | React 19 + TypeScript + Tailwind CSS + Vite |
| **Backend** | Java 25 + Spring Boot 3.5.9 |
| **Database** | PostgreSQL (via Supabase) |
| **Auth** | Supabase Auth (JWT) |
| **Frontend Deploy** | Netlify (static hosting) |
| **Backend Deploy** | Google Cloud Run (Docker) |
| **Local Dev** | Supabase CLI + npm + Gradle |

---

## 2. Frontend Routes & Pages

### Public Routes (no auth required)

| Route | Component | Description |
|-------|-----------|-------------|
| `/` | `LandingPage` | Hero page with mascot, CTA buttons |
| `/login` | `LoginPage` | Email/password + Google sign-in |
| `/register` | `RegisterPage` | New user registration |
| `/ai-draft` | `AiDraftPreview` | AI-generated content preview (no header) |

### Protected Routes (auth required)

| Route | Component | Guard | Description |
|-------|-----------|-------|-------------|
| `/map` | `LearningMap` | StudentRoute | Topic roadmap with categories |
| `/map/:topicId` | `TopicDetail` | StudentRoute | Individual topic with subtopics |
| `/lesson/:lessonId` | `LessonPage` | StudentRoute | Short reading content |
| `/quiz/:subtopicId` | `QuizPage` | StudentRoute | 5-question quiz with feedback |
| `/quizzes` | `QuizListingPage` | — | Browse all available quizzes |
| `/exam` | `ExamPage` | StudentRoute | 60-question timed exam simulation |
| `/mistakes` | `MistakeGarden` | StudentRoute | Review wrong answers |
| `/profile` | `UserProfile` | — | User profile & stats |
| `/weak-points` | `WeakPointAnalysis` | — | Personalized focus areas |
| `/admin` | `AdminDashboard` | AdminRoute | Platform stats & charts |
| `/admin/users` | `AdminUsers` | AdminRoute | User management table |

### Route Guards

| Guard | Purpose |
|-------|---------|
| `ProtectedRoute` | Redirects to `/login` if no session |
| `StudentRoute` | Blocks admin users from student-only routes |
| `AdminRoute` | Blocks non-admin users from admin routes |

---

## 3. Frontend Components

### UI Components (`components/ui/`)

| Component | Description |
|-----------|-------------|
| `Badge` | Status/label badges with variants |
| `Card` | Container with padding options |
| `Modal` | Dialog overlay |
| `Button` | Styled button with variants |
| `ProgressBar` | Visual progress indicator |
| `ChoiceList` | Quiz answer choice list |

### Feature Components (`components/features/`)

| Component | Description |
|-----------|-------------|
| `TopicNode` | Topic card in learning map |
| `QuizCard` | Quiz preview card |
| `ActiveUsersChart` | Daily active users line chart (Recharts) |
| `TopicQuizChart` | Quiz count by topic bar chart |
| `TopicScoreChart` | Avg score by topic bar chart |
| `QuizCompletionChart` | Quiz completion pie chart |
| `ExamPassChart` | Exam pass/fail pie chart |
| `UserFilters` | Admin user search/filter bar |
| `UserTable` | Desktop user list table |
| `UserCard` | Mobile user card |
| `UserPagination` | Pagination controls |
| `UserDrawer` | User detail side panel |
| `WeakPointCard` | Topic weakness card |
| `WeakPointSummary` | Mastery summary grid |

### Layout Components (`components/layout/`)

| Component | Description |
|-----------|-------------|
| `Layout` | Page chrome (Header + Sidebar + content) |
| `Header` | Top navigation bar |
| `Sidebar` | Side navigation (student/admin) |

---

## 4. Frontend Hooks

| Hook | File | Description |
|------|------|-------------|
| `useAuth` | `hooks/useAuth.tsx` | Supabase auth state, sign-in/up/out, user profile sync |
| `useTopics` | `hooks/useTopics.ts` | Fetch topics with user progress |
| `useLessons` | `hooks/useLessons.ts` | Fetch lesson content |
| `useAdminStats` | `hooks/useAdminStats.ts` | Admin dashboard statistics |
| `useAdminUsers` | `hooks/useAdminUsers.ts` | Admin user list with filters |
| `useWeakPoints` | `hooks/useWeakPoints.ts` | Weak point analysis data |
| `useTheme` | `hooks/useTheme.ts` | Dark/light mode toggle |

---

## 5. Backend API Endpoints

### Topic Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/v1/topics` | List all topics with user progress |

### Quiz Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `POST` | `/api/v1/quizzes/start` | Start a quiz session |
| `POST` | `/api/v1/quizzes/:sessionId/answers` | Submit quiz answer |
| `GET` | `/api/v1/subtopics/:subtopicId/quiz` | Get quiz questions for subtopic |

### Exam Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `POST` | `/api/v1/exams/start` | Start exam session (60 questions) |
| `POST` | `/api/v1/exams/:sessionId/answers` | Submit exam answer |
| `POST` | `/api/v1/exams/:sessionId/finish` | Finish exam, award XP |

### Mistake Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/v1/me/mistakes` | Get user's mistakes |
| `PUT` | `/api/v1/me/mistakes/:mistakeId/review` | Mark mistake as reviewed |

### User Profile Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/v1/users/me` | Get current user profile |
| `PATCH` | `/api/v1/users/me` | Update user profile |

### Admin Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/v1/admin/stats` | Get platform statistics |
| `GET` | `/api/v1/admin/users` | List users with filters |
| `GET` | `/api/v1/admin/users/:userId` | Get user details |
| `PATCH` | `/api/v1/admin/users/:userId/role` | Change user role |
| `POST` | `/api/v1/admin/users/:userId/deactivate` | Deactivate user |

### Weak Point Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/v1/me/weak-points` | Get weak point analysis |

### Health Check

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/api/v1/health` | Health check (public) |

---

## 6. Backend Services

| Service | Description |
|---------|-------------|
| `QuizService` | Quiz session management, answer tracking, mastery updates |
| `ExamService` | Exam session lifecycle, hearts system, XP award |
| `TopicService` | Topic listing with user progress |
| `MistakeService` | Mistake collection and review |
| `UserService` | User profile CRUD |
| `AdminService` | Admin stats, user management |
| `WeakPointService` | Mastery analysis and recommendations |
| `JwtAuthenticationFilter` | JWT verification via Supabase JWKS |

---

## 7. Database Schema

### Tables

| Table | Columns | Description |
|-------|---------|-------------|
| `user_profiles` | `id`, `user_id`, `display_name`, `email`, `total_xp`, `streak_count`, `longest_streak`, `last_active_at`, `role`, `created_at`, `updated_at` | User profiles (linked to Supabase Auth) |
| `topics` | `id`, `title`, `description`, `category`, `order_index`, `created_at` | Topic categories (Technology, Security, etc.) |
| `subtopics` | `id`, `topic_id`, `title`, `description`, `order_index`, `created_at` | Subtopics within topics |
| `lessons` | `id`, `subtopic_id`, `title`, `content`, `order_index`, `created_at` | Short reading content |
| `questions` | `id`, `exam_session`, `subject`, `question_number`, `topic_category`, `difficulty`, `question_text`, `choices`, `correct_answer`, `explanation`, `subtopic_id`, `created_at` | Exam questions |
| `quiz_sessions` | `id`, `user_id`, `subtopic_id`, `question_count`, `score`, `status`, `created_at`, `completed_at` | Quiz session tracking |
| `quiz_answers` | `id`, `session_id`, `question_id`, `answer`, `is_correct`, `created_at` | Individual quiz answers |
| `exam_sessions` | `id`, `user_id`, `question_count`, `difficulty`, `hearts_remaining`, `time_limit_minutes`, `status`, `xp_earned`, `created_at`, `completed_at` | Exam session tracking |
| `exam_answers` | `id`, `session_id`, `question_id`, `sequence_number`, `answer`, `is_correct`, `created_at` | Individual exam answers |
| `user_mistakes` | `id`, `user_id`, `question_id`, `last_user_answer`, `miss_count`, `last_missed_at`, `reviewed_at` | Wrong answers for review |
| `user_subtopic_mastery` | `id`, `user_id`, `subtopic_id`, `mastery_score`, `questions_seen`, `questions_correct`, `last_practiced_at` | Mastery tracking per subtopic |
| `daily_activity` | `id`, `user_id`, `activity_date`, `quizzes_taken`, `exams_taken`, `questions_answered`, `correct_answers`, `xp_earned` | Daily activity log |

### Enums

| Enum | Values |
|------|--------|
| `topic_category` | Technology, Security, Management, Strategy, Business |
| `difficulty` | easy, medium, hard |
| `user_role` | student, admin, deactivated |
| `quiz_status` | in_progress, completed, abandoned |
| `exam_status` | in_progress, completed, expired, abandoned |

---

## 8. Database Functions (RPC)

| Function | Description |
|----------|-------------|
| `increment_user_xp(user_id, xp_amount)` | Atomically add XP to user profile |
| `update_user_streak(user_id)` | Update daily streak counter |
| `get_exam_questions(count, difficulty)` | Fetch random exam questions |
| `classify_question(text)` | Rule-based difficulty classification |
| `calculate_mastery(user_id, subtopic_id)` | Compute mastery score |

---

## 9. Database Migrations

| Migration | Description |
|-----------|-------------|
| `20260712122400_initial_schema.sql` | Core tables: questions, quiz_sessions, exam_sessions |
| `20260712122401_classify_questions_2021_april.sql` | Classify 2021 April exam questions |
| `20260713134300_update_streak.sql` | Streak calculation function |
| `20260713140900_create_user_profiles.sql` | User profiles table |
| `20260714145800_create_mistake_garden.sql` | Mistake tracking tables |
| `20260714145801_secure_update_user_streak.sql` | RLS for streak updates |
| `20260714232400_seed_lessons.sql` | Lesson content seed |
| `20260715005500_classify_questions_and_build_lessons.sql` | Auto-classify questions |
| `20260715012200_difficulty_rules.sql` | Difficulty classification rules |
| `20260715012201_increment_user_xp.sql` | XP increment function |
| `20260715012202_get_exam_questions.sql` | Exam question fetcher |
| `20260715012203_exam_sessions_practice_mode.sql` | Practice mode support |
| `20260715012204_seed_business_questions.sql` | Business category questions |
| `20260715012205_seed_subtopic_descriptions.sql` | Subtopic descriptions |
| `20260715042300_add_admin_role.sql` | Admin role support |
| `20260716000000_add_longest_streak_to_user_profiles.sql` | Longest streak tracking |
| `20260716013000_fix_restrict_profile_columns_trigger.sql` | Profile column restrictions |
| `20260716020000_add_deactivated_role.sql` | Deactivated user role |

---

## 10. Seed Data

| Seed File | Description |
|-----------|-------------|
| `003_seed_lessons.sql` | Lesson content for topics |
| `004_seed_lesson_content.sql` | Detailed lesson markdown |
| `005_classify_questions_and_build_lessons.sql` | Auto-link questions to lessons |
| `006_seed_more_content.sql` | Additional lesson content |
| `007_seed_comprehensive_content.sql` | Comprehensive topic coverage |
| `008_populate_lesson_content.sql` | Populate lesson body content |
| `009_seed_exam_questions.sql` | Exam questions from ITPEC |
| `2021-April-Exam.sql` | 2021 April exam (60 Subject-A) |
| `2021-October-Exam.sql` | 2021 October exam (60 Subject-A) |
| `2022-April-Exam.sql` | 2022 April exam (60 Subject-A) |

---

## 11. CI/CD Pipelines

### CI Workflow (`ci.yml`)

Triggers: push to main, PRs, manual dispatch

| Step | Tool | Description |
|------|------|-------------|
| Setup Node | `actions/setup-node@v7` | Node.js 20 |
| Install | `npm ci` | Install frontend deps |
| Lint | `oxlint` | Frontend linting |
| Typecheck | `tsc --noEmit` | TypeScript check |
| Test | `vitest run` | Frontend tests |
| Build | `tsc -b && vite build` | Frontend build |
| Setup Java | `actions/setup-java@v5` | JDK 25 (Temurin) |
| Build & Test | `./gradlew build` | Backend build + tests |

### Security Workflow (`security.yml`)

| Job | Tool | Description |
|-----|------|-------------|
| `secrets` | gitleaks v8.18.4 | Leaked API keys scan |
| `sast` | semgrep | Static analysis (injection, insecure defaults) |

### Backend Deploy (`deploy-backend.yml`)

Triggers: push to main when `src/api/**` changes

| Step | Description |
|------|-------------|
| Authenticate | Google Cloud SA |
| Build Docker | `docker build -t $IMAGE` |
| Push | Artifact Registry |
| Deploy | Cloud Run (1Gi memory, 1 CPU, min 0) |

### Frontend Deploy (`deploy-frontend.yml`)

Triggers: push to main when `src/web/**` changes

| Step | Description |
|------|-------------|
| Setup Node | Node.js 20 |
| Install | `npm ci` |
| Lint | `oxlint` |
| Test | `vitest run` |
| Build | `npm run build` (with env vars) |
| Deploy | Netlify CLI (`--prod`) |

### Dependabot (`dependabot.yml`)

- Weekly dependency update PRs
- npm ecosystem monitoring
- GitHub Actions monitoring

---

## 12. Infrastructure & Deployment

### Local Development

```bash
# Start local database
supabase start
supabase db reset

# Start backend
cd src/api && ./gradlew bootRun

# Start frontend
cd src/web && npm install && npm run dev
```

### Docker

```bash
# Backend only (requires running Postgres)
docker compose up
docker compose up -d    # background
docker compose down     # stop
```

### Production

| Service | Platform | URL Pattern |
|---------|----------|-------------|
| Frontend | Netlify | `https://nerdquiz.netlify.app` |
| Backend | Cloud Run | `https://nerdquiz-api-xxx.a.run.app` |
| Database | Supabase | `https://xxx.supabase.co` |

---

## 13. Environment Variables

### Frontend (Vite)

| Variable | Description | Required |
|----------|-------------|----------|
| `VITE_SUPABASE_URL` | Supabase project URL | Yes |
| `VITE_SUPABASE_ANON_KEY` | Supabase public anon key | Yes |
| `VITE_API_URL` | Backend API base URL | No (defaults to relative) |

### Backend (Spring Boot)

| Variable | Description | Required |
|----------|-------------|----------|
| `DATABASE_URL` | Postgres connection string | Yes |
| `DB_USER` | Database username | Yes |
| `DB_PASSWORD` | Database password | Yes |
| `SUPABASE_URL` | Supabase project URL | Yes |
| `SUPABASE_ANON_KEY` | Supabase public anon key | Yes |
| `PORT` | Server port (default: 8080) | No |
| `CORS_ALLOWED_ORIGINS` | Frontend origins | Yes |

### CI/CD Secrets

| Secret | Pipeline |
|--------|----------|
| `GCP_PROJECT_ID` | Backend deploy |
| `GCP_REGION` | Backend deploy |
| `GCP_SA_KEY` | Backend deploy |
| `VITE_SUPABASE_URL` | Frontend deploy |
| `VITE_SUPABASE_ANON_KEY` | Frontend deploy |
| `VITE_API_URL` | Frontend deploy |
| `NETLIFY_AUTH_TOKEN` | Frontend deploy |
| `NETLIFY_SITE_ID` | Frontend deploy |

---

## 14. Scripts & Commands

### Frontend (`src/web/package.json`)

| Command | Description |
|---------|-------------|
| `npm run dev` | Start Vite dev server (port 5100) |
| `npm run build` | TypeScript build + Vite production build |
| `npm run lint` | OxLint frontend linting |
| `npm run typecheck` | TypeScript type checking |
| `npm test` | Vitest test runner |
| `npm run preview` | Preview production build |

### Backend (`src/api/`)

| Command | Description |
|---------|-------------|
| `./gradlew bootRun` | Start Spring Boot (port 8080) |
| `./gradlew build` | Build + test |
| `./gradlew test` | Run tests only |
| `./gradlew clean` | Clean build artifacts |

### Supabase

| Command | Description |
|---------|-------------|
| `supabase start` | Start local Postgres + auth |
| `supabase db reset` | Apply migrations + seed data |
| `supabase login` | Authenticate to Supabase |
| `supabase link --project-ref <ref>` | Link to remote project |
| `supabase db push` | Push migrations to remote |

### Project Root

| Command | Description |
|---------|-------------|
| `docker compose up` | Start backend in Docker |
| `docker compose down` | Stop Docker services |

---

## 15. Security Features

### Authentication

- Supabase Auth for registration/login (JWT)
- Backend JWT verification via JWKS endpoint
- No passwords stored in backend
- Role-based access (student, admin, deactivated)

### Authorization

- Row Level Security (RLS) on all user-data tables
- Admin routes protected by `AdminRoute` guard
- Student routes protected by `StudentRoute` guard
- Backend filter chain requires auth unless `@Public`

### Data Protection

- No secrets in source code (`.env` only)
- Gitleaks scanning in CI
- Semgrep SAST scanning
- Dependabot for dependency vulnerabilities
- No PII logging
- CORS restricted to frontend origin

### Input Validation

- Jakarta Validation on backend DTOs
- TypeScript types on frontend
- Supabase RLS policies

---

## 16. Feature Status Matrix

### Week 1 — Local Demo ✅

| Feature | Status | Frontend | Backend | Database |
|---------|--------|----------|---------|----------|
| User registration & login | ✅ Done | LoginPage, RegisterPage | Supabase Auth | user_profiles |
| Learning map | ✅ Done | LearningMap, TopicNode | TopicController | topics, subtopics |
| Short lessons | ✅ Done | LessonPage | LessonController | lessons |
| 5-question quizzes | ✅ Done | QuizPage | QuizController | quiz_sessions, quiz_answers |
| XP tracking | ✅ Done | UserProfile | UserService | user_profiles.total_xp |
| Hearts (exam sim) | ✅ Done | ExamPage | ExamService | exam_sessions.hearts |
| Streak tracking | ✅ Done | LearningMap, UserProfile | UserService | user_profiles.streak_count |
| Mistake Garden | ✅ Done | MistakeGarden | MistakeService | user_mistakes |
| Exam simulation | ✅ Done | ExamPage | ExamService | exam_sessions, exam_answers |
| Rule-based difficulty | ✅ Done | — | classify_question() | questions.difficulty |
| Landing page | ✅ Done | LandingPage | — | — |
| Mobile-responsive | ✅ Done | Tailwind responsive | — | — |
| ~180 questions seeded | ✅ Done | — | — | 3 exam sessions |
| Dark mode | ✅ Done | useTheme, ThemeProvider | — | — |

### Week 2 — Public Demo ✅

| Feature | Status | Frontend | Backend | Database |
|---------|--------|----------|---------|----------|
| Polish UI/UX | ✅ Done | Loading/error/empty states | — | — |
| Weak point analysis | ✅ Done | WeakPointAnalysis | WeakPointService | user_subtopic_mastery |
| Admin dashboard | ✅ Done | AdminDashboard | AdminService | — |
| Admin user management | ✅ Done | AdminUsers, UserDrawer | AdminService | user_profiles.role |
| Quiz listing | ✅ Done | QuizListingPage | — | — |
| User profile | ✅ Done | UserProfile | UserService | — |
| Role-based routing | ✅ Done | AdminRoute, StudentRoute | JwtAuthFilter | user_profiles.role |
| Deactivated users | ✅ Done | — | — | user_profiles.role = deactivated |

### Out of Scope ❌

| Feature | Status | Notes |
|---------|--------|-------|
| AI adaptive difficulty | ❌ Not built | Future feature |
| All 3,120 questions | ❌ Not built | Gradual expansion |
| Leaderboards | ❌ Not built | Advanced gamification |
| Native mobile app | ❌ Not built | Web-only |
| Payment/subscription | ❌ Not built | Not planned |
| Flashcards | ❌ Not built | Stretch goal |

---

## File Tree Reference

```
team-16-app/
├── .github/
│   ├── workflows/
│   │   ├── ci.yml                    # Lint, typecheck, test, build
│   │   ├── security.yml              # Gitleaks + semgrep
│   │   ├── deploy-backend.yml        # Cloud Run deployment
│   │   └── deploy-frontend.yml       # Netlify deployment
│   ├── dependabot.yml                # Dependency updates
│   ├── ISSUE_TEMPLATE/               # Issue templates
│   ├── PULL_REQUEST_TEMPLATE.md      # PR template
│   └── CODEOWNERS                    # Code ownership
├── .claude/
│   ├── rules/                        # Coding conventions
│   │   ├── backend.md
│   │   ├── frontend.md
│   │   ├── git-workflow.md
│   │   ├── testing.md
│   │   ├── security.md
│   │   └── data-handling.md
│   └── skills/                       # On-demand procedures
│       ├── extract-data/
│       ├── pr-review/
│       └── sync-reqs/
├── docs/
│   ├── ARCHITECTURE.md               # System diagram
│   ├── REQUIREMENTS.md               # MVP scope
│   ├── NerdQuiz-Team-Briefing.md     # Feature overview
│   ├── decisions/                    # ADRs
│   └── gsd/                          # How-we-work
├── supabase/
│   ├── migrations/                   # 22 SQL migrations
│   ├── seed_data/                    # 10 seed files
│   └── verify.sql                    # Verification queries
├── src/
│   ├── api/                          # Spring Boot backend
│   │   ├── build.gradle
│   │   ├── Dockerfile
│   │   └── src/main/java/com/nerdquiz/
│   │       ├── config/               # SecurityConfig, JwtAuthFilter
│   │       ├── controller/           # REST controllers
│   │       ├── service/              # Business logic
│   │       ├── repository/           # Spring Data JPA
│   │       ├── model/                # JPA entities
│   │       ├── dto/                  # Request/Response DTOs
│   │       └── exception/            # GlobalExceptionHandler
│   └── web/                          # React frontend
│       ├── package.json
│       ├── vite.config.ts
│       ├── tailwind.config.js
│       └── src/
│           ├── App.tsx               # Root routes
│           ├── routes/               # 14 page components
│           ├── components/
│           │   ├── ui/               # Generic UI components
│           │   ├── features/         # Feature-specific components
│           │   └── layout/           # Layout, Header, Sidebar
│           ├── hooks/                # Custom hooks
│           ├── lib/                  # Utilities, API client, Supabase
│           ├── types/                # TypeScript types
│           └── styles/globals.css    # Tailwind directives
├── docker-compose.yml                # Backend Docker setup
├── netlify.toml                      # Frontend deploy config
├── README.md                         # Project documentation
└── scripts/
    └── features.md                   # This file
```
