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
npm run dev                 # starts Vite dev server on http://localhost:5100
```

Open http://localhost:5100 in your browser.

---

## Docker Setup

The frontend can run in two Docker modes — **dev** (Vite hot reload) and **production** (nginx).

### Prerequisites

- Docker Desktop installed and running
  - **Windows:** Enable WSL 2 integration (Settings → General → "Use the WSL 2 based engine")
  - **Linux:** Ensure your user has Docker access: `sudo usermod -aG docker $USER` then reopen terminal
  - **macOS:** No extra setup needed — Docker Desktop works out of the box
- Supabase CLI running (`supabase start`) for local database access
- Backend running outside Docker (`./gradlew bootRun`) for API proxy

### Environment variables

Docker Compose reads from `src/web/.env`. Required vars:

```bash
VITE_SUPABASE_URL=your-supabase-url
VITE_SUPABASE_ANON_KEY=your-supabase-anon-key
```

### Dev mode (recommended for development)

```bash
docker compose --profile dev up
```

- Vite dev server with **hot reload** on http://localhost:5100
- Source files are volume-mounted — edits reflect instantly
- API requests proxy to http://localhost:8080 (run backend outside Docker with `./gradlew bootRun`)

### Production mode (nginx)

```bash
docker compose --profile production up
```

- Builds the React app and serves via **nginx** on http://localhost
- SPA routing works out of the box (`/map`, `/login`, etc. all serve `index.html`)
- `/api/*` requests proxied to the backend container

> **Note:** The production profile requires the backend Dockerfile (Issue #12). Until then, run the backend outside Docker.

---

## Remote Supabase (Staging/Production)

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
| Container | nginx (frontend), Docker Compose (orchestration) |
| Local dev | Supabase CLI + Docker |

## Project structure

| Path | What |
|---|---|
| `src/api/` | Spring Boot REST API |
| `src/web/` | React SPA (Vite) |
| `src/web/nginx/` | nginx config for Docker production mode |
| `docker-compose.yml` | Docker Compose with dev and production profiles |
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
