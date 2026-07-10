# NerdQuiz

> Gamified IT exam prep platform for ITPEC FE certification — learn topics, practice
> quizzes, track progress, and simulate real exams.

![ci](../../actions/workflows/ci.yml/badge.svg) ![security](../../actions/workflows/security.yml/badge.svg)

---

## Quickstart

### Prerequisites

- Java 25 (JDK)
- Node.js 20+ and npm
- Docker Desktop (for local Supabase)
- [Supabase CLI](https://supabase.com/docs/guides/cli) (`supabase`)

### 1. Clone and configure

```bash
git clone <your-repo-url> && cd team-16-app
cp .env.example .env        # fill in real values locally — never commit .env
```

### 2. Start the local database

```bash
supabase start              # spins up Postgres + auth via Docker
supabase db reset           # apply migrations and seed data
```

### 3. Run the backend

```bash
cd src/api
./gradlew bootRun           # starts Spring Boot on http://localhost:8080
```

### 4. Run the frontend

```bash
cd src/web
npm install
npm run dev                 # starts Vite dev server on http://localhost:5173
```

Open http://localhost:5173 in your browser.

---

## Stack

| Layer | Technology |
|---|---|
| Frontend | React, Tailwind CSS, React Router v7 |
| Backend | Java 25, Spring Boot |
| Database | Supabase (Postgres) |
| Auth | Supabase Auth (JWT) |
| Local dev | Supabase CLI + Docker |

## Project structure

| Path | What |
|---|---|
| `src/api/` | Spring Boot REST API |
| `src/web/` | React SPA (Vite) |
| `supabase/` | Migrations, seed data, config |
| `docs/` | ARCHITECTURE.md, REQUIREMENTS.md, decision records |
| `docs/gsd/` | How-we-work, feature board, architecture boundaries |
| `.claude/rules/` | Coding conventions for AI-assisted development |
| `.claude/skills/` | ITPEC PDF extraction, PR review (`/pr-review`), requirements sync (`/sync-reqs`) |
| `.github/` | CI, security, PR/issue templates |

## Team

<!-- Members + this week's roles (Anchor / Reviewer). Link your board. -->

---

## What's already set up for you

| File | Gives you |
|---|---|
| `.github/workflows/ci.yml` | lint · typecheck · test · build on every PR |
| `.github/workflows/security.yml` | gitleaks (leaked keys) + semgrep (SAST) — advisory |
| `.github/dependabot.yml` | weekly PRs for vulnerable / outdated dependencies |
| `.env.example` | secret hygiene — copy to `.env`, never commit real keys |
| `.github/pull_request_template.md` · `ISSUE_TEMPLATE/` · `CODEOWNERS` | small reviewed PRs, one-owner issues |
| `docs/ARCHITECTURE.md` · `docs/decisions/` | a 1-page overview + lightweight ADRs |
| `working-agreement.md` | how your team works (GitHub Flow + rotating roles) |

**Git rule:** branch → `/pr-review` → commit → PR → merge. No push to `main`, no self-merge. Automated review is the primary quality gate; teammate review is only needed for schema/API/auth changes.

> A green pipeline ≠ secure. Scanners catch leaked keys, known-CVE deps, and injection
> patterns. They do **not** catch prompt-injection, over-scoped tokens, or hallucinated
> packages — a human still reviews for those.
