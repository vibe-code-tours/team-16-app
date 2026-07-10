# 4. Use Supabase as the database

- Status: accepted
- Date: 2026-07-10

## Context

NerdQuiz needs a relational database for questions, user progress, XP, streaks, and mistake tracking. The project already uses Supabase for auth, so using the same platform for the database reduces moving parts.

## Decision

In the context of **choosing a database for a2-week sprint with8 developers**, facing **the need for a fast-to-setup, production-ready Postgres instance**, we chose **Supabase (managed Postgres)** to achieve **schema migrations, a web dashboard, and local dev parity via the Supabase CLI**, accepting **vendor coupling to the Supabase platform**.

## Consequences

- All data lives in Postgres (via Supabase), queried from Spring Boot using JDBC/SQL.
- Supabase migrations (`supabase/migrations/`) define the schema in version-controlled SQL.
- The Supabase web dashboard gives visibility into table data during development.
- Supabase CLI provides local Postgres + auth services via Docker Compose for dev.
