# 6. Use Supabase CLI + Docker for local development database

- Status: accepted
- Date: 2026-07-10

## Context

Developers need a local database that matches production schema and auth behavior. The tech stack specifies "Docker for containerization," and the project uses Supabase for both DB and auth.

## Decision

In the context of **needing a local Postgres instance that mirrors the Supabase production environment**, facing **the choice between a shared cloud project, plain Docker Postgres, or Supabase CLI**, we chose **Supabase CLI (`supabase start` / `supabase db reset`)** to achieve **full local parity with production (Postgres + auth + storage) in a single command**, accepting **Docker Desktop requirement for all developers (~2GB download on first run)**.

## How it works

- `supabase init` creates a `supabase/` config directory.
- `supabase start` spins up local Postgres, auth, and API via Docker Compose (managed by the CLI).
- `supabase db reset` drops and re-seeds the local DB from migration files + seed data.
- `supabase migration new <name>` creates a numbered migration file.

## Consequences

- Developers do NOT write their own `docker-compose.yml` — the CLI manages it.
- Local and production schemas stay in sync via the same `supabase/migrations/` files.
- CI can use a plain Postgres Docker image (no need for the full Supabase stack) since tests only need the DB.
- Each developer runs their own local instance (no shared dev DB conflicts).
