# Tech Stack — NerdQuiz

> Last updated: 2026-07-15

## 🚀 Overview
NerdQuiz is a gamified ITPEC FE certification prep platform. The architecture is designed for high performance, seamless auth, and rapid content iteration.

## 🛠 The Stack

### 🎨 Frontend: React & Tailwind CSS
- **Framework**: React 19 with Vite 8 for ultra-fast development and build times.
- **Styling**: Tailwind CSS v4 for a modern, responsive, and "alive" UI.
- **Routing**: React Router v7 for type-safe, declarative navigation.
- **State Management**: React Context API for global auth and user profile state.
- **HTTP Client**: Centralized `lib/api.ts` wrapper (fetch with auto-auth headers).

### ☕ Backend: Spring Boot API
- **Framework**: Spring Boot 3.5.9, Java 25, Gradle.
- **Role**: Primary REST API server — handles quiz logic, topic/lesson management, user streaks, and JWT verification.
- **Auth**: Pure resource server — verifies JWTs via Supabase JWKS. No auth endpoints, no passwords.
- **ORM**: Spring Data JPA with PostgreSQL dialect.
- **Base path**: `/api/v1/...`

### ☁️ Database & Auth: Supabase
- **Database**: PostgreSQL with Row Level Security (RLS) on all user-data tables.
- **Auth**: Supabase Auth (Email/Password & Google OAuth) — frontend calls directly, backend verifies JWT.
- **Local dev**: Supabase CLI + Docker for local Postgres instance.
- **Migrations**: Managed via `supabase/migrations/` SQL files (NOT Flyway/Liquibase).

### 🛠 Infrastructure & DevOps
- **Version Control**: GitHub.
- **CI/CD**: GitHub Actions for automated linting, type-checking, and build verification on every PR.
- **Deployment**: Netlify (frontend) + Cloud Run (backend).
- **Containerization**: Multi-stage Dockerfile for backend, docker-compose.yml for local dev.

---

## 📐 Architecture Decisions (ADRs)

See `docs/decisions/` for full ADR documents.

### ADR 01: Three-Tier Architecture
**Decision**: Frontend → Spring Boot API → Supabase (Postgres).
**Rationale**: Backend handles business logic (quiz scoring, streak calculation, topic progression) and JWT verification. Supabase handles auth and provides the database. Frontend calls Supabase Auth directly for registration/login, then passes JWTs to the backend for all data operations.

### ADR 02: Content Seeding via SQL Migrations
**Decision**: Use `.sql` migration files for initial content.
**Rationale**: Ensures that every developer has the exact same set of "Short Lessons" and "Quizzes" upon running `supabase db reset`.

### ADR 03: Gamification Engine
**Decision**: XP and Streak calculations are handled by the Spring Boot backend, with atomic DB functions (`increment_user_xp`, `update_user_streak`) for data consistency.
**Rationale**: Centralizes gamification logic in the backend while using DB-level atomicity for concurrent access safety.

> **Note:** Some features (ExamPage, MistakeGarden, LessonPage) still call Supabase
> directly from the frontend. This is a known deviation from the intended architecture
> and is tracked as a gap in `docs/gsd/feature-board.md`.
