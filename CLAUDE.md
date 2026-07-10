# NerdQuiz

Gamified IT exam prep platform for ITPEC FE certification. Students read short lessons,
answer topic quizzes, track XP and streaks, review wrong answers in a Mistake Garden,
and run timed exam simulations.

8 developers, 2-week build: local demo after Week 1, public demo after Week 2.

## Stack

| Layer | Technology |
|---|---|
| Frontend | React, Tailwind CSS, React Router v7 |
| Backend | Java 25, Spring Boot |
| Database | Supabase (Postgres) |
| Auth | Supabase Auth (JWT — frontend calls directly, backend verifies) |
| Local dev | Supabase CLI + Docker |

## Repo layout

| Path | What |
|---|---|
| `src/api/` | Spring Boot REST API — see [`.claude/rules/backend.md`](.claude/rules/backend.md) |
| `src/web/` | React SPA — see [`.claude/rules/frontend.md`](.claude/rules/frontend.md) |
| `supabase/` | Postgres migrations + seed data |
| `docs/ARCHITECTURE.md` | System diagram, where things live, external services |
| `docs/REQUIREMENTS.md` | MVP scope (Week 1 / Week 2 / out of scope) |
| `docs/decisions/` | Architecture Decision Records (ADRs) |
| `docs/gsd/` | How-we-work, feature board, boundaries, decision log |
| `.claude/rules/` | Path-scoped conventions (backend, frontend, git, testing, security, data) |
| `.claude/skills/` | On-demand procedures (ITPEC PDF extraction, `/pr-review`, `/sync-reqs`) |

## How to run

```bash
supabase start && supabase db reset   # local Postgres + auth
cd src/api && ./gradlew bootRun       # backend on :8080
cd src/web && npm install && npm run dev  # frontend on :5173
```

Full Quickstart: [README.md](README.md). Full architecture: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## Process

- **GSD approach:** each developer owns their feature end-to-end. You get a feature goal,
  you figure out the details, you build it, you ship it.
- **Git:** branch → `/pr-review` → commit → PR → merge. No push to `main`, no
  self-merge. Automated review is the primary quality gate; teammate review is only
  needed for schema/API/auth changes (see `.claude/rules/git-workflow.md`).
- **Decisions:** record as ADRs in `docs/decisions/` using the Y-statement format from
  `0001-record-architecture-decisions.md`.
- **Open votes:** tracked in `docs/gsd/decision-log.md`, graduate to ADRs once decided.

## Key documents to read first

1. `docs/NerdQuiz-Team-Briefing.md` — feature list, data challenges, scope, GSD approach
2. `docs/ARCHITECTURE.md` — system diagram and layout
3. `docs/decisions/0001-record-architecture-decisions.md` — ADR format convention
