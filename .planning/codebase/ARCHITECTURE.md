<!-- refreshed: 2026-07-14 -->
# Architecture

**Analysis Date:** 2026-07-14

## System Overview

```text
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                     │
│                  React SPA (src/web/)                       │
│                                                             │
│   Components: ui/, features/, layout/, routes/              │
│   State: useAuth(), useTopics(), useLessons()                │
│   Routing: React Router v7 (BrowserRouter)                  │
└───────────────────────┬─────────────────────────────────────┘
                        │
          ┌─────────────┼─────────────┐
          │             │             │
          ▼             ▼             ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ Supabase     │ │ Spring Boot  │ │ Supabase     │
│ Auth SDK     │ │ REST API     │ │ Postgres     │
│ (frontend)   │ │ (src/api/)   │ │ (managed)    │
│              │ │              │ │              │
│ JWT tokens   │ │ Controllers  │ │ Tables       │
│ Direct calls │ │ Services     │ │ RLS policies │
│              │ │ Repositories │ │ Stored procs │
└──────────────┘ └──────┬───────┘ └──────────────┘
                        │
                        ▼
                 ┌──────────────┐
                 │ Spring Data  │
                 │ JPA + JDBC   │
                 │ PostgreSQL   │
                 └──────────────┘
```

## Component Responsibilities

| Component | Responsibility | File |
|-----------|----------------|------|
| **App** | Root layout, route definitions, AuthProvider wrapper | `src/web/src/App.tsx` |
| **Layout** | Page chrome (Header + Sidebar + main content area) | `src/web/src/components/layout/Layout.tsx` |
| **ProtectedRoute** | Route guard — redirects to /login if no session | `src/web/src/components/ProtectedRoute.tsx` |
| **AuthProvider** | Supabase auth state, user profile sync, sign-in/up/out | `src/web/src/hooks/useAuth.tsx` |
| **LearningMap** | Topic roadmap UI with category grouping | `src/web/src/routes/LearningMap.tsx` |
| **QuizPage** | Quiz-taking flow (questions, answers, scoring, XP) | `src/web/src/routes/QuizPage.tsx` |
| **MistakeGarden** | Review wrong answers from Supabase directly | `src/web/src/routes/MistakeGarden.tsx` |
| **TopicController** | REST endpoint for topic listing with user progress | `src/api/src/main/java/com/nerdquiz/controller/TopicController.java` |
| **QuizController** | REST endpoints for quiz start/answer/result flow | `src/api/src/main/java/com/nerdquiz/controller/QuizController.java` |
| **QuizService** | Business logic for quiz sessions, answers, scoring | `src/api/src/main/java/com/nerdquiz/service/QuizService.java` |
| **JwtAuthenticationFilter** | JWT verification on every Spring request | `src/api/src/main/java/com/nerdquiz/config/JwtAuthenticationFilter.java` |
| **SecurityConfig** | Spring Security filter chain, auth rules | `src/api/src/main/java/com/nerdquiz/config/SecurityConfig.java` |
| **GlobalExceptionHandler** | RFC 7807 Problem Details error responses | `src/api/src/main/java/com/nerdquiz/exception/GlobalExceptionHandler.java` |

## Pattern Overview

**Overall:** Client-Server with Dual Backend Pattern (Supabase + Spring Boot)

**Key Characteristics:**
- Frontend calls Supabase Auth **directly** for registration/login — credentials never pass through the backend
- Spring Boot receives JWT on every request, verifies signature via Supabase JWKS, extracts user ID
- Two distinct data access paths: frontend→Supabase (RLS-governed) and frontend→Spring Boot→Postgres (service-governed)
- REST API with JSON payloads, RFC 7807 error format
- Client-side routing with React Router v7 (SPA fallback on Netlify)
- Backend is stateless — no HTTP sessions, all auth via JWT

## Layers

**React SPA (src/web/):**
- Purpose: User interface, client-side routing, direct Supabase integration
- Location: `src/web/src/`
- Contains: Route components, UI components, custom hooks, TypeScript types, utilities
- Depends on: Supabase JS SDK, React Router v7, Tailwind CSS
- Used by: End users (browser)

**Spring Boot REST API (src/api/):**
- Purpose: Business logic, JWT verification, quiz operations, user progress tracking
- Location: `src/api/src/main/java/com/nerdquiz/`
- Contains: Controllers, Services, Repositories, Models, DTOs, Config, Exceptions
- Depends on: Spring Boot, Spring Security, Spring Data JPA, Nimbus JOSE JWT, PostgreSQL driver
- Used by: React SPA (via HTTP)

**Supabase Postgres Database:**
- Purpose: Persistent data storage, row-level security, stored procedures
- Location: `supabase/migrations/`, `supabase/seed_data/`
- Contains: Schema migrations, seed data, stored procedures (RPC functions)
- Depends on: PostgreSQL + pgcrypto extension
- Used by: Spring Boot (via JDBC), React SPA (via Supabase JS SDK directly)

**Supabase Auth (Managed Service):**
- Purpose: User authentication, session management, OAuth (Google)
- Location: Supabase managed infrastructure
- Contains: Auth tables, JWT signing, JWKS endpoint
- Used by: React SPA (via SDK), Spring Boot (via JWT verification)

## Data Flow

### Primary Request Path (Authenticated)

1. **User action triggers API call** — e.g., clicking "Start Quiz" (`src/web/src/routes/QuizPage.tsx`)
2. **Frontend API client attaches JWT** — `src/web/src/lib/api.ts` reads Supabase session, adds `Authorization: Bearer` header
3. **Request reaches Spring Boot** — hits controller endpoint (`src/api/.../QuizController.java`)
4. **JWT filter verifies token** — `JwtAuthenticationFilter.java` decodes JWT, extracts user ID, sets SecurityContext
5. **Controller extracts user ID** — `Authentication.getName()` returns UUID string
6. **Service executes business logic** — `QuizService.startQuiz()` calls repositories, applies rules
7. **Repository queries Postgres** — Spring Data JPA executes queries via JDBC
8. **Response returns to frontend** — JSON response, frontend updates state

### Direct Supabase Path (Frontend)

1. **User action triggers Supabase call** — e.g., recording a mistake (`src/web/src/routes/QuizPage.tsx`)
2. **Supabase SDK sends request with anon key** — RLS policies enforce user isolation
3. **Supabase executes query + RLS** — Postgres enforces access rules at database level
4. **Response returns to frontend** — JavaScript SDK parses result

### Authentication Flow

1. **User submits credentials** — LoginPage or RegisterPage (`src/web/src/routes/LoginPage.tsx`)
2. **Supabase Auth handles login** — SDK calls Supabase Auth API directly
3. **Session established** — JWT stored in Supabase default storage (localStorage)
4. **AuthProvider syncs user profile** — `useAuth.tsx` fetches from `user_profiles` table
5. **Backend receives JWT on next request** — `JwtAuthenticationFilter` verifies signature

### Quiz Completion Flow

1. **User answers questions** — QuizPage sends answers to Spring Boot API
2. **Backend calculates score** — `QuizService` tracks correct/incorrect, stores in `quiz_answers`
3. **Frontend records mistakes** — Wrong answers inserted into `user_mistakes` via Supabase
4. **XP awarded** — Frontend calls `increment_user_xp` RPC via Supabase

**State Management:**
- React Context (`AuthContext`) for authentication state
- React local state (`useState`) for component-specific state
- Custom hooks encapsulate async data fetching (`useTopics`, `useLessons`)
- No Redux/Zustand — minimal state needs, Context sufficient

## Key Abstractions

**User Profile Sync:**
- Purpose: Bridge between Supabase Auth (JWT) and application user profile
- Examples: `src/web/src/hooks/useAuth.tsx` — `fetchUserProfile()` creates/updates profile
- Pattern: On auth state change, query `user_profiles`, create if missing, sync OAuth metadata

**Quiz Session:**
- Purpose: Track quiz attempt state, answers, and score
- Examples: `src/api/src/main/java/com/nerdquiz/model/QuizSession.java`, `QuizService.java`
- Pattern: Create session → store answers → mark complete → return result

**Topic Progress:**
- Purpose: Display user progress across learning roadmap
- Examples: `src/web/src/routes/LearningMap.tsx`, `src/api/.../TopicController.java`
- Pattern: Fetch topics with user progress from backend, group by category, display roadmap

**Mistake Garden:**
- Purpose: Review wrong answers for learning reinforcement
- Examples: `src/web/src/routes/MistakeGarden.tsx`
- Pattern: Query `user_mistakes` with joined `questions` from Supabase, display in UI

**Lesson Progress:**
- Purpose: Track which lessons users have completed
- Examples: `src/web/src/routes/LessonPage.tsx`, `src/api/.../LessonController.java`
- Pattern: Fetch lesson content, update `user_lesson_progress` table via Supabase

## Entry Points

**Frontend Entry:**
- Location: `src/web/src/main.tsx`
- Triggers: Browser loads `/`, React renders App
- Responsibilities: Mount React app, render BrowserRouter + AuthProvider

**Route Definitions:**
- Location: `src/web/src/App.tsx`
- Triggers: React Router navigation
- Responsibilities: Map URLs to page components, apply ProtectedRoute guard

**Backend Entry:**
- Location: `src/api/src/main/java/com/nerdquiz/NerdQuizApplication.java`
- Triggers: Spring Boot application startup
- Responsibilities: Bootstrap Spring context, start HTTP server on port 8080

**API Endpoints:**
- Location: `src/api/src/main/java/com/nerdquiz/controller/`
- Triggers: HTTP requests from frontend
- Responsibilities: Route to appropriate service methods, return DTOs

**Database Entry:**
- Location: `supabase/migrations/001_initial_schema.sql`
- Triggers: `supabase db reset` or migration apply
- Responsibilities: Create schema, tables, constraints, stored procedures

## Architectural Constraints

- **Threading:** Single-threaded event loop in React SPA; multi-threaded request handling in Spring Boot (Tomcat thread pool)
- **Global state:** `supabase` client singleton in `src/web/src/lib/supabase.ts`; `SecurityContextHolder` in Spring for request-scoped auth
- **Circular imports:** None detected — clean dependency direction (routes → hooks/lib → Supabase/API)
- **Two-backend coupling:** Frontend directly queries Supabase AND calls Spring Boot API — schema must stay in sync between direct access and JPA entities
- **JWT verification:** Every authenticated request hits `JwtAuthenticationFilter` — JWKS must be cached to avoid latency
- **RLS dependency:** Supabase queries rely on Row Level Security — if RLS is disabled/misconfigured, data leaks across users

## Anti-Patterns

### Direct Supabase Access in Route Components

**What happens:** Some route components (e.g., `MistakeGarden.tsx`, `QuizPage.tsx`) query Supabase directly instead of going through Spring Boot API
**Why it's wrong:** Bypasses business logic validation, makes it harder to audit data access, creates two data access patterns to maintain
**Do this instead:** Route components should call `api.*()` methods that route to Spring Boot endpoints, which then interact with Postgres via repositories. Keep Supabase direct access to auth operations only.

### Hardcoded Magic Numbers

**What happens:** Quiz constants (`QUIZ_LENGTH = 5`, `XP_PER_CORRECT = 10`) are defined in route components
**Why it's wrong:** Duplicated across components, hard to change, not discoverable
**Do this instead:** Define in `src/web/src/data/constants.ts` or pull from backend configuration endpoint

### Missing Error Boundaries

**What happens:** Unhandled errors in components crash the entire app
**Why it's wrong:** Poor UX, hard to debug in production
**Do this instead:** Add React Error Boundary components wrapping major route sections, catch and display user-friendly error messages

### Type Assertions (`as` keyword)

**What happens:** Some components use `as Mistake[]` type assertions instead of runtime validation
**Why it's wrong:** Hides type mismatches at compile time, can cause runtime errors
**Do this instead:** Use Zod or io-ts for runtime validation of API responses, or create proper mapper functions

## Error Handling

**Strategy:** Layered — frontend catches API errors and displays user messages; backend catches exceptions and returns RFC 7807 Problem Details

**Patterns:**
- **Frontend:** try/catch around API calls, display error state in components (loading/error/success states)
- **Backend:** `@RestControllerAdvice` global exception handler maps exceptions to HTTP status + Problem Details JSON
- **Supabase:** SDK returns error objects — check `.error` before using `.data`
- **Validation:** `@Valid` + Jakarta annotations in controllers, 400 response with field errors

## Cross-Cutting Concerns

**Logging:**
- Backend: SLF4J logger in `JwtAuthenticationFilter`, debug-level for JWT failures
- Frontend: `console.error()` for Supabase/API failures — not logged to external service
- Security constraint: Never log JWT contents, PII, or user data

**Validation:**
- Backend: Jakarta Validation (`@Valid`) on request bodies, enforced in controllers
- Frontend: Form validation in LoginPage/RegisterPage before submission, Supabase handles email format

**Authentication:**
- Supabase Auth for registration, login, session management (managed service)
- Spring Boot JWT verification via `JwtAuthenticationFilter` (stateless, no sessions)
- User ID extracted from JWT `sub` claim — never trust client-supplied user IDs
- Public endpoints (health check, landing page) explicitly bypass JWT filter

**Authorization:**
- Row Level Security (RLS) in Supabase — enforced at database level
- Spring Security filter chain — all endpoints require auth unless configured otherwise
- No role-based access control yet (single user role)

**Database Access:**
- Two patterns: Supabase SDK (frontend) and Spring Data JPA (backend)
- Spring Boot uses `@EntityGraph` or explicit queries to avoid N+1
- Supabase queries use PostgREST-style filters
- Stored procedures for complex operations (increment XP, get exam questions)

---

*Architecture analysis: 2026-07-14*
