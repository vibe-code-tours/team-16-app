# Tech Stack — NerdQuiz

## 🚀 Overview
NerdQuiz is a gamified ITPEC FE certification prep platform. The architecture is designed for high performance, seamless auth, and rapid content iteration.

## 🛠 The Stack

### 🎨 Frontend: React & Tailwind CSS
- **Framework**: React 18+ with Vite for ultra-fast development and build times.
- **Styling**: Tailwind CSS for a modern, responsive, and "alive" UI.
- **Routing**: React Router v7 for type-safe, declarative navigation.
- **State Management**: React Context API for global auth and user profile state.

### ☁️ Backend: Supabase (BaaS)
Instead of a traditional monolithic backend, we utilize Supabase to accelerate development:
- **Database**: PostgreSQL with Row Level Security (RLS) to ensure data integrity.
- **Authentication**: Supabase Auth (Email/Password & Google OAuth) for secure, frictionless access.
- **API**: PostgREST (Auto-generated REST API) for direct frontend-to-db communication, reducing latency.
- **Storage**: Supabase Storage for mascot assets and PDF exam papers.

### ☕ Auxiliary Services: Java & Spring Boot
- **Role**: Used for complex business logic and potential integration with external PDF parsing services that require heavy JVM processing.

### 🛠 Infrastructure & DevOps
- **Version Control**: GitHub.
- **CI/CD**: GitHub Actions for automated linting, type-checking, and build verification on every PR.
- **Deployment Target**: Vercel / Netlify (Planned for Public Demo).

---

## 📐 Architecture Decisions (ADRs)

### ADR 01: Direct Supabase Access vs. Spring Boot API
**Decision**: We prefer direct Supabase calls for 90% of the app (Lessons, Quizzes, Profile).
**Rationale**: Eliminates the "middle-man" API layer, reducing latency and development overhead. RLS handles security at the database level.

### ADR 02: Content Seeding via SQL Migrations
**Decision**: Use `.sql` migration files for initial content.
**Rationale**: Ensures that every developer has the exact same set of "Short Lessons" and "Quizzes" upon running `supabase db reset`.

### ADR 03: Gamification Engine
**Decision**: XP and Streak calculations are handled on the client-side for immediate feedback, then synced to the DB.
**Rationale**: Provides the "snappy" feel required for a gamified experience (similar to Duolingo).
