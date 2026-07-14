# NerdQuiz

> Gamified IT exam prep platform for ITPEC FE certification — learn topics, practice
> quizzes, track progress, and simulate real exams.

![ci](../../actions/workflows/ci.yml/badge.svg) ![security](../../actions/workflows/security.yml/badge.svg)

---

## Quickstart

### Prerequisites

- Java 25 (JDK) — [Download](https://adoptium.net/) or `brew install openjdk@25` (macOS)
- Node.js 20+ and npm — [Download](https://nodejs.org/) or use `nvm`
- Docker Desktop — [Download](https://www.docker.com/products/docker-desktop/)
- [Supabase CLI](https://supabase.com/docs/guides/cli) (`supabase`)

#### Install Supabase CLI

```bash
npm install -g supabase
```

### 1. Clone and configure

```bash
git clone <your-repo-url> && cd team-16-app
cp .env.example src/api/.env # fill in real values locally — never commit .env
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
npm run dev                 # starts Vite dev server on http://localhost:5100
```

Open http://localhost:5100 in your browser.

---

## Local Development

### Frontend

```bash
cd src/web
npm install
npm run dev                 # Vite dev server on http://localhost:5100
```

API requests proxy to `http://localhost:8080` (configured in `vite.config.ts`).

### Backend

```bash
cd src/api
./gradlew bootRun           # Spring Boot on http://localhost:8080
```

### Backend (Docker alternative)

If you prefer running the backend in Docker:

```bash
docker compose up           # builds and runs Spring Boot on http://localhost:8080
```

Requires a running Postgres instance (Supabase CLI or external).

---

## Remote Supabase (Staging/Production)

The backend deployment must use Supabase's **session pooler**. The direct
`db.<project-ref>.supabase.co` endpoint is IPv6-only by default, while Cloud Run
outbound connections are IPv4. In Supabase Dashboard, open **Connect**, select
**Session pooler**, and configure these GitHub production secrets:

```text
DATABASE_URL=jdbc:postgresql://aws-0-REGION.pooler.supabase.com:5432/postgres?sslmode=require
DB_USER=postgres.PROJECT_REF
DB_PASSWORD=YOUR_RAW_DATABASE_PASSWORD
```

Use the raw database password for `DB_PASSWORD`; do not URL-encode it. The
deployment workflow rejects direct database URLs so an unreachable revision is
not deployed again.

To push migrations to a hosted Supabase project:

```bash
supabase login                 # opens browser for authentication
supabase link --project-ref <project-ref>   # connect to your project
supabase db push               # apply pending migrations
```

Find your project ref in Supabase Dashboard → **Settings** → **General** → **Reference ID**.

---

## Stack

| Layer | Technology |
|---|---|
| Frontend | React, Tailwind CSS, React Router v7 |
| Backend | Java 25, Spring Boot |
| Database | Supabase (Postgres) |
| Auth | Supabase Auth (JWT) |
| Frontend deploy | Netlify (static hosting, CDN) |
| Backend deploy | Docker → Cloud Run / Render |
| Local dev | Supabase CLI + npm + Gradle |

## Project structure

| Path | What |
|---|---|
| `src/api/` | Spring Boot REST API |
| `src/web/` | React SPA (Vite) |
| `docker-compose.yml` | Backend Docker setup (Spring Boot) |
| `netlify.toml` | Frontend deployment config (Netlify) |
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
| `netlify.toml` | Frontend deploy config (SPA routing, build settings) |
| `docker-compose.yml` | Backend Docker setup for local/production |
| `.env.example` | secret hygiene — copy to `.env`, never commit real keys |
| `.github/pull_request_template.md` · `ISSUE_TEMPLATE/` · `CODEOWNERS` | small reviewed PRs, one-owner issues |
| `docs/ARCHITECTURE.md` · `docs/decisions/` | a 1-page overview + lightweight ADRs |
| `working-agreement.md` | how your team works (GitHub Flow + rotating roles) |

**Git rule:** branch → `/pr-review` → commit → PR → merge. No push to `main`, no self-merge. Automated review is the primary quality gate; teammate review is only needed for schema/API/auth changes.

> A green pipeline ≠ secure. Scanners catch leaked keys, known-CVE deps, and injection
> patterns. They do **not** catch prompt-injection, over-scoped tokens, or hallucinated
> packages — a human still reviews for those.
