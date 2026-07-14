# Architecture — NerdQuiz

> One page. Keep it true as the project grows. A teammate should be able to read
> this and find their way around in 5 minutes.

## What it does

NerdQuiz is a gamified IT exam study platform for ITPEC FE certification candidates.
Students read short lessons, answer topic quizzes, track XP and streaks, review wrong
answers in a Mistake Garden, and run timed exam simulations — all structured around
the FE syllabus categories (Technology, Security, Management, etc.).

## Diagram

```
┌──────────────┐       ┌──────────────────┐       ┌──────────────────┐
│   React SPA  │──────▶│  Spring Boot API  │──────▶│  Supabase        │
│  (src/web/)  │       │  (src/api/)       │       │  (Postgres DB)   │
│              │       │                   │       │                  │
│  React Router│       │  REST endpoints   │       │  Migrations in   │
│  Tailwind CSS│       │  JWT verification │       │  supabase/       │
└──────┬───────┘       └───────────────────┘       └──────────────────┘
       │
       │  Supabase Auth SDK
       │  (register, login, session)
       ▼
┌──────────────────┐
│  Supabase Auth   │
│  (managed)       │
└──────────────────┘
```

The frontend calls Supabase Auth **directly** for registration and login. It never
passes credentials through the backend. Spring Boot receives a JWT on every API call,
verifies it, and trusts the user identity from the token.

## Where things live

| Path | What |
|---|---|
| `src/api/` | Spring Boot backend (Java 25, REST API) |
| `src/web/` | React frontend (Tailwind CSS, React Router) |
| `supabase/migrations/` | Database schema (version-controlled SQL) |
| `supabase/seed_data/` | Seed data SQL files (exam questions, lessons) |
| `docs/` | This file, REQUIREMENTS.md, decision records |
| `docs/gsd/` | How-we-work, feature board, architecture boundaries |
| `docs/decisions/` | Architecture Decision Records (ADRs) |
| `.claude/rules/` | Path-scoped coding conventions for AI-assisted development |
| `.claude/skills/` | On-demand procedures (e.g. ITPEC PDF extraction) |
| `.github/workflows/` | CI + security scanning |

## External services

| Service | Purpose | Keys needed |
|---|---|---|
| Supabase | Postgres DB + Auth | `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY` |
| Google OAuth (via Supabase) | Social login | Configured in Supabase dashboard |

All secrets live in `.env` (local) or GitHub Secrets (CI). See `.env.example` for the
full list.

## How to run

See the [README](../README.md) Quickstart.
