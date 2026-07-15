# Architecture Boundaries

> Shared constraints every developer must follow. Decisions here are recorded as ADRs
> in `docs/decisions/`.

## API conventions

- Base path: `/api/v1/...`
- JSON request/response (`Content-Type: application/json`)
- Standard HTTP verbs: GET, POST, PUT, PATCH, DELETE
- Error format: RFC 7807 Problem Details
- See `.claude/rules/backend.md` for full conventions

## Database conventions

- Postgres via Supabase
- Table names: `snake_case`, plural
- Primary keys: `id UUID DEFAULT gen_random_uuid()`
- Timestamps: `created_at`, `updated_at` with `TIMESTAMPTZ`
- Migrations in `supabase/migrations/` — NOT Flyway/Liquibase
- See `.claude/rules/data-handling.md` for full conventions

## Auth flow

```
Frontend (React)                Supabase Auth           Backend (Spring Boot)
     │                               │                         │
     │── register/login ────────────▶│                         │
     │◀── JWT (access + refresh) ───│                         │
     │                               │                         │
     │── API call + Bearer token ─────────────────────────────▶│
     │                               │                         │── verify JWT via JWKS
     │                               │                         │── extract user ID from sub claim
     │◀── response ────────────────────────────────────────────│
```

- Frontend calls Supabase Auth directly (not through backend)
- Backend is a pure resource server — no auth endpoints, no passwords
- User ID comes from JWT `sub` claim, never from request body
- Admin role stored in `user_profiles.role` column (`'admin'` | `'user'`, default `'user'`)
- Admin-only endpoints check role via JWT filter → return 403 for non-admins

## Shared topic categories

Every question must be assigned one of these categories (used across the app):

| Category | Description |
|---|---|
| Technology | Hardware, software, networks, databases, programming |
| Security | Cybersecurity, encryption, access control, threats |
| Management | Project management, IT governance, quality management |
| Strategy | Business strategy, IT strategy, digital transformation |
| Business | Business knowledge, economics, accounting, law |

These are fixed for the demo — don't add new categories without team agreement.

## Frontend routing

| Route | Component | Auth required | Data source |
|---|---|---|---|
| `/` | LandingPage | No | Static |
| `/login` | LoginPage | No | Supabase Auth |
| `/register` | RegisterPage | No | Supabase Auth |
| `/ai-draft` | AiDraftPreview | No | Static markdown files |
| `/map` | LearningMap | Yes | Backend API: `GET /api/v1/topics` |
| `/map/:topicId` | TopicDetail | Yes | Backend API: `GET /api/v1/subtopics/{id}/lessons` |
| `/lesson/:lessonId` | LessonPage | Yes | ⚠️ Direct Supabase (not via backend) |
| `/quiz/:subtopicId` | QuizPage | Yes | Backend API: `GET /api/v1/subtopics/{id}/quiz` + direct Supabase for mistakes/XP |
| `/exam` | ExamPage | Yes | ⚠️ Direct Supabase (RPC + table inserts) |
| `/mistakes` | MistakeGarden | Yes | ⚠️ Direct Supabase (`user_mistakes` table) |
| `/profile` | UserProfile | Yes | Supabase Auth + direct Supabase (`user_profiles` table) |
| `/admin` | AdminDashboard | Yes (admin role) | Backend API: `GET /api/v1/admin/stats` |

### Data access pattern

**Via backend API (verified by JWT):**
- Topics: `GET /api/v1/topics`
- Lessons: `GET /api/v1/subtopics/{id}/lessons`, `POST /api/v1/lessons/{id}/complete`
- Quiz: `GET /api/v1/subtopics/{id}/quiz`, `POST /api/v1/quizzes/start`, `POST /api/v1/quizzes/{id}/answers`, `GET /api/v1/quizzes/{id}/result`
- Streak: `POST /api/v1/me/streak`
- Admin stats: `GET /api/v1/admin/stats` (admin role required)

**Direct Supabase (RLS only, no backend verification):**
- LessonPage reads `lessons` + `subtopics` directly
- QuizPage inserts into `user_mistakes` and calls `increment_user_xp` RPC
- ExamPage calls `get_exam_questions` RPC, inserts into `exam_sessions`, `exam_answers`, `exam_heart_events`
- MistakeGarden reads/updates `user_mistakes` directly
- useAuth/UserProfile reads/writes `user_profiles` directly

> **Note:** Direct Supabase calls are a known deviation from the intended architecture
> (Frontend → Backend → Supabase). These features work via Supabase RLS policies but
> bypass JWT verification and backend business logic. See feature-board.md known gaps.

## What you can decide freely

- Component implementation details (how you structure your code)
- Animation/transition choices within Tailwind
- Specific question text and explanations for extracted data
- How you organize your branch/commits within the git workflow

## What needs team sync first

- Changing the API contract (new endpoints, modified responses)
- Modifying the database schema (new tables, column changes)
- Adding new topic categories
- Changing the auth flow
- Introducing new dependencies
