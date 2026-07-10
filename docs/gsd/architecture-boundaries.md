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

| Route | Component | Auth required |
|---|---|---|
| `/` | LandingPage | No |
| `/login` | LoginPage | No |
| `/register` | RegisterPage | No |
| `/map` | LearningMap | Yes |
| `/topic/:id` | TopicDetail (lesson) | Yes |
| `/quiz/:topicId` | QuizSession | Yes |
| `/exam/:examId` | ExamSimulation | Yes |
| `/mistakes` | MistakeGarden | Yes |
| `/profile` | Profile (stretch) | Yes |

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
