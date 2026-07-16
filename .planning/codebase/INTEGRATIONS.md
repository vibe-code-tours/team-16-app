# External Integrations

**Analysis Date:** 2026-07-14

## APIs & External Services

**Supabase (Primary):**
- Database: Managed PostgreSQL with Row Level Security (RLS)
  - Connection: `DATABASE_URL` env var
  - Client: Spring Data JPA (backend), @supabase/supabase-js (frontend)
  - Tables: user_profiles, topics, lessons, subtopics, questions, quiz_sessions, quiz_answers, user_mistakes, user_lesson_progress, user_subtopic_mastery
  
- Authentication: Supabase Auth service
  - JWT tokens signed with Supabase keys
  - Endpoints for sign-in, sign-up, session management
  - Client SDK: `@supabase/supabase-js`
  - Backend verification: Nimbus JOSE+JWT library

- Frontend Auth Calls:
  - Email/password authentication
  - OAuth provider support (Google, GitHub, etc.)
  - Session management and token refresh
  - User profile CRUD operations

- Backend Auth Calls:
  - JWT verification against Supabase JWKS endpoint
  - User ID extraction from JWT `sub` claim
  - JWKS caching (1-hour TTL) for performance

**Spring Boot REST API:**
- Endpoints:
  - `/api/v1/health` - Health check (public)
  - `/api/v1/quizzes/*` - Quiz session management (authenticated)
  - `/api/v1/lessons/*` - Lesson content (authenticated)
  - `/api/v1/questions/*` - Question bank (authenticated)
  - `/api/v1/users/*` - User profile and progress (authenticated)
  - `/api/v1/topics/*` - Topic/subtopic metadata (authenticated)

- JSON API with standard REST verbs
- Authentication: JWT in Authorization header (Bearer scheme)

## Data Storage

**PostgreSQL Database:**
- Provider: Supabase (managed Postgres)
- Connection: `DATABASE_URL` JDBC string
- Client: Spring Data JPA (backend ORM)
- Migrations: Managed by Supabase CLI in `supabase/migrations/`
- Schema: 14 SQL migration files (2026-07-14 state)
- RLS: Enabled on all user-data tables (defense-in-depth security)

**Tables (primary entities):**
- `questions` - Question bank with answers and metadata
- `topics` - Topic categories (Technology, Security, Management, etc.)
- `lessons` - Learning content
- `subtopics` - Subtopic classifications
- `quiz_sessions` - Quiz session state and scores
- `quiz_answers` - Individual answer submissions
- `user_profiles` - User accounts and stats (XP, streaks)
- `user_mistakes` - Mistake Garden (reviewed wrong answers)
- `user_lesson_progress` - Learning progress tracking
- `user_subtopic_mastery` - Mastery levels per subtopic

**File Storage:**
- None (application handles no user uploads)

**Caching:**
- None (no Redis or in-memory cache)
- JWKS keys cached in-memory on backend (1-hour TTL)

## Authentication & Identity

**Auth Provider:**
- Supabase Auth (managed service)
  - Email/password authentication
  - OAuth support (Google, GitHub, etc.)
  - JWT token issuance
  - User management (registration, login, logout)

**Implementation:**
- Frontend: `@supabase/supabase-js` SDK
  - Initialization: `src/web/src/lib/supabase.ts`
  - Hook: `src/web/src/hooks/useAuth.tsx` (AuthProvider context)
  - Session handling, sign-in/out, OAuth flows

- Backend: JWT verification filter
  - Filter: `src/api/src/main/java/com/nerdquiz/config/JwtAuthenticationFilter.java`
  - JWT parsing: `src/api/src/main/java/com/nerdquiz/config/JwtUtil.java`
  - Configuration: `src/api/src/main/java/com/nerdquiz/config/SecurityConfig.java`

- Token Flow:
  1. Frontend authenticates with Supabase Auth
  2. JWT stored in browser storage
  3. JWT attached to API requests as `Authorization: Bearer <token>`
  4. Backend filter intercepts and verifies signature against Supabase JWKS
  5. User ID extracted from JWT and passed to service layer

## Monitoring & Observability

**Error Tracking:**
- None (no Sentry, Datadog, or similar)
- Logging via SLF4J (backend) and console (frontend)

**Logs:**
- Backend: Spring Boot + SLF4J framework
- Frontend: Browser console (development)
- Production: Container stdout/stderr

**Health Checks:**
- Backend: `/api/v1/health` endpoint (public, no auth)
- Docker: Built-in health check with wget
- Docker Compose: Configured with 15s intervals

## CI/CD & Deployment

**Hosting:**
- Frontend: Netlify (static hosting)
  - Configuration: `netlify.toml`
  - SPA routing: Redirect rules for React Router
  - Deploy trigger: Git push to main
  - URL: https://nerdquiz-16.netlify.app (current demo)

- Backend: Docker container
  - Image: eclipse-temurin:25-jre-alpine
  - Build: Multi-stage Dockerfile (build → runtime)
  - Container runtime: Docker or container orchestration

**CI Pipeline:**
- GitHub Actions workflows:
  - `ci.yml`: Main CI pipeline (lint → typecheck → test → build)
    - Node.js 20.x for frontend
    - Java 25 (Temurin) for backend
    - Runs on: push to main, PRs, manual trigger
  
  - `security.yml`: Security scanning
    - gitleaks: Secrets detection (v8.18.4)
    - semgrep: Static analysis (SAST)
    - Advisory mode (non-blocking, for learning)
  
  - `deploy-frontend.yml`: Netlify deployment
  - `deploy-backend.yml`: Backend deployment

**Deployment Flow:**
1. Developer pushes to feature branch
2. PR triggers CI (frontend + backend builds/tests)
3. Security scans run (gitleaks, semgrep)
4. Merge to main triggers deployments
5. Frontend → Netlify auto-deploy
6. Backend → Docker image build (manual/triggered)

## Environment Configuration

**Required env vars (local development):**
- Backend (`.env` or Docker Compose):
  - `DATABASE_URL` - Postgres connection string
  - `SUPABASE_URL` - Supabase project URL
  - `SUPABASE_ANON_KEY` - Supabase anonymous key
  - `PORT` - Server port (optional, default: 8080)
  - `CORS_ALLOWED_ORIGINS` - Allowed frontend origins

- Frontend (`.env` file):
  - `VITE_SUPABASE_URL` - Supabase project URL
  - `VITE_SUPABASE_ANON_KEY` - Supabase anonymous key
  - `VITE_API_URL` - Backend API URL (optional)

**Secrets location:**
- `.env` files (never committed)
- GitHub Secrets (for CI/CD workflows)
- `.env.example` provided with placeholder values

## Webhooks & Callbacks

**Incoming:**
- None (no webhook listeners)

**Outgoing:**
- Supabase Auth callbacks:
  - OAuth provider redirects
  - Email verification links

## Third-Party Services

**External APIs:**
- None currently (application is self-contained)
- ITPEC exam data seeded manually (PDF → JSON extraction)
- Future: Potential OpenAI API for AI-powered features (see `AiDraftPreview` route)

**External Dependencies:**
- Supabase services (database, auth, edge functions)
- Netlify (hosting, CDN)
- GitHub (source control, CI/CD)
- Docker Hub (base images)

## Integration Patterns

**Frontend ↔ Backend:**
- REST API with JSON payloads
- JWT authentication via Authorization header
- Vite dev server proxies /api/* to backend
- Relative URLs in production (nginx/Docker proxy)

**Frontend ↔ Supabase:**
- Direct client connection via SDK
- Row Level Security enforces permissions
- Real-time subscriptions available (not currently used)

**Backend ↔ Supabase:**
- JDBC connection to Postgres
- JWT verification against JWKS endpoint
- No direct Supabase SDK usage (pure SQL/JPA)

---

*Integration audit: 2026-07-14*
