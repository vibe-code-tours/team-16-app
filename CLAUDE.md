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

<!-- GSD:project-start source:PROJECT.md -->

## Project

**NerdQuiz Admin Dashboard**

An admin dashboard for NerdQuiz — a gamified IT exam prep platform for ITPEC FE certification. The dashboard lives inside the existing React SPA and gives founders a role-gated view to monitor platform health and manage user accounts. Students never see it; admins get stats, user search, user details, and role/deactivation controls.

**Core Value:** Founders can see at a glance whether the platform is working — who's using it, how they're engaging, and whether anything needs intervention. If the dashboard can't answer "is this thing alive and healthy?" in 5 seconds, it fails.

### Constraints

- **Same SPA**: Admin dashboard lives inside `src/web/`, not a separate app
- **Founders-only**: No multi-admin-role complexity — just admin vs. user
- **Existing patterns**: Follow established API conventions (`/api/v1/...`, RFC 7807 errors) and React patterns (hooks, Tailwind, React Router)
- **Supabase Auth**: Admin role verified via JWT + backend filter, not a separate auth system
- **Week 2 timeline**: This is a public demo feature — ship functional, not perfect

<!-- GSD:project-end -->

<!-- GSD:stack-start source:codebase/STACK.md -->

## Technology Stack

## Languages

- Java 25 - Backend API (Spring Boot service)
- TypeScript 6.0.2 - Frontend SPA (React application)
- SQL - Database migrations (Postgres)
- YAML - Configuration files (CI/CD, application config)
- Bash - Build scripts, Docker configuration

## Runtime

- JVM 25 (Eclipse Temurin) - Production container runtime
- Eclipse Temurin 25 JDK Alpine - Build stage
- Eclipse Temurin 25 JRE Alpine - Runtime stage
- Node.js 20.x - Build and development
- Vite 8.1.1 - Development server and bundler
- Backend: Gradle 8.x (wrapper included)
- Frontend: npm (with package-lock.json lockfile)

## Frameworks

- Spring Boot 3.5.9 - Backend REST API framework
- React 19.2.7 - Frontend UI framework (functional components)
- Tailwind CSS 4.3.2 - Utility-first CSS framework
- React Router DOM 7.18.1 - Client-side routing
- JUnit 5 - Java unit testing (backend)
- Mockito - Java mocking (backend)
- Vitest 4.1.10 - React component testing (frontend)
- React Testing Library 16.3.2 - UI component testing
- Vite 8.1.1 - Frontend development server and bundler
- Gradle - Backend build automation
- OxLint 1.71.0 - Frontend linting

## Key Dependencies

- Spring Data JPA - Database ORM and query management
- Spring Security - JWT authentication and authorization
- Nimbus JOSE+JWT 9.41.2 - JWT verification and validation
- PostgreSQL Driver - Database connectivity
- Spring Boot Starter Web - REST API support
- Spring Boot Starter Validation - Input validation (Jakarta Validation)
- Jackson - JSON serialization/deserialization
- @supabase/supabase-js 2.110.2 - Supabase client SDK (auth + database)
- React 19.2.7 - UI component framework
- TypeScript - Type safety and developer tooling
- Lucide React 1.24.0 - Icon library
- React Markdown 10.1.0 - Markdown rendering
- class-variance-authority 0.7.1 - Component variant management
- clsx + tailwind-merge - Conditional class merging

## Configuration

- `DATABASE_URL` - Postgres connection string (format: jdbc:postgresql://host:port/db?user=...&password=...)
- `SUPABASE_URL` - Supabase project URL (e.g., https://xxx.supabase.co)
- `SUPABASE_ANON_KEY` - Supabase public anonymous key
- `PORT` - Server port (default: 8080)
- `CORS_ALLOWED_ORIGINS` - Comma-separated frontend origins
- `VITE_SUPABASE_URL` - Supabase project URL
- `VITE_SUPABASE_ANON_KEY` - Supabase public anonymous key
- `VITE_API_URL` - Backend API base URL (optional, defaults to relative path)
- `src/api/build.gradle` - Gradle build configuration (dependencies, plugins)
- `src/web/package.json` - npm package manifest (scripts, dependencies)
- `src/web/vite.config.ts` - Vite build/dev configuration
- `src/web/tailwind.config.js` - Tailwind CSS customization
- `src/web/tsconfig.json` - TypeScript compiler options
- `docker-compose.yml` - Docker service orchestration
- `src/api/Dockerfile` - Backend container build

## Platform Requirements

- JDK 25+ (Eclipse Temurin recommended)
- Node.js 20.x+
- npm or compatible package manager
- Supabase CLI for local Postgres/edge functions
- Docker (optional, for containerized deployment)
- Backend: Docker container with JRE 25 Alpine (Eclipse Temurin)
- Frontend: Netlify (static hosting) or similar CDN
- Database: Supabase hosted Postgres (or compatible Postgres instance)
- Auth: Supabase Auth service
- Backend: 8080 (Spring Boot default)
- Frontend: 5100 (Vite default, configured in vite.config.ts)
- Supabase: 54321 (local Postgres via Supabase CLI)
- Proxy: Vite proxies /api/* requests to backend on 8080

<!-- GSD:stack-end -->

<!-- GSD:conventions-start source:CONVENTIONS.md -->

## Conventions

## Naming Patterns

- Controllers: PascalCase with `Controller` suffix - `QuizController.java`, `QuestionController.java`
- Services: PascalCase with `Service` suffix - `QuizService.java`, `QuestionService.java`
- Repositories: PascalCase with `Repository` suffix - `QuizSessionRepository.java`, `QuestionRepository.java`
- DTOs (Request): PascalCase with `Request` suffix - `StartQuizRequest.java`, `SubmitAnswerRequest.java`
- DTOs (Response): PascalCase with `Response` suffix - `QuizSessionResponse.java`, `QuizAnswerResponse.java`
- Exceptions: PascalCase with `Exception` suffix - `NoQuestionsAvailableException.java`, `QuizSessionNotFoundException.java`
- Entities: PascalCase, no suffix - `QuizSession.java`, `Question.java`, `QuizAnswer.java`
- Packages: lowercase singular - `com.nerdquiz.service`, `com.nerdquiz.model`, `com.nerdquiz.controller`
- Components: PascalCase + `.tsx` - `ProgressBar.tsx`, `ChoiceList.tsx`, `Button.tsx`
- Hooks: `use` + PascalCase + `.ts` - `useAuth.tsx`, `useTopics.ts`, `useLessons.ts`
- Utility functions: camelCase + `.ts` - `formatXp.ts`, `cn.ts`
- Type definitions: PascalCase + `.ts` - `Quiz.ts`, `types/index.ts`
- Routes: PascalCase + `.tsx` - `QuizSession.tsx`, `LearningMap.tsx`
- Methods: camelCase - `startQuiz()`, `submitAnswer()`, `getResult()`
- Variables: camelCase - `questionRepository`, `quizSession`, `isCorrect`
- Constants: UPPER_SNAKE_CASE - `XP_PER_CORRECT_ANSWER`, `BEARER_PREFIX`
- Event handlers: `handle` + Action - `handleSelectAnswer()`, `handleSubmitAnswer()`, `handleNextQuestion()`
- State: descriptive noun - `questions`, `currentIndex`, `answers`, `showExplanation`
- State setters: `set` + Noun - `setQuestions()`, `setCurrentIndex()`, `setAnswers()`
- Props interfaces: `<Component>Props` - `ProgressBarProps`, `ChoiceListProps`, `AnswerState`

## Code Style

- Backend: Java standard formatting (4-space indentation)
- Frontend: ESLint + Prettier (standard Vite config)
- Tailwind: Utility-first classes, responsive mobile-first approach
- CSS organization: Tailwind config in `tailwind.config.js` for custom tokens
- Backend: Spring Boot conventions (standard Java practices)
- Frontend: TypeScript strict mode with ESLint
- No custom ESLint config files found (standard Vite setup)

## Import Organization

## Error Handling

- Service layer: Throw specific custom exceptions (`NoQuestionsAvailableException`, `QuizSessionNotFoundException`)
- Controller layer: Let exceptions propagate to `GlobalExceptionHandler`
- Exception handler: Returns RFC 7807 Problem Details format with status code, title, detail
- Example response: `{ "type": "...", "title": "...", "status": 404, "detail": "..." }`
- Components: Render conditional UI based on state (loading, error, success)
- Hooks: Use try/catch with console.error for non-critical operations
- API calls: Return error objects instead of throwing: `{ error: message }`
- Example from `useAuth.tsx`:

## Logging

- Debug level for routine operations (JWT verification)
- Info level for significant events
- Use `LoggerFactory.getLogger(ClassName.class)`
- Never log PII (emails, user IDs, tokens)
- `console.error()` for actual errors
- `console.warn()` for deprecation notices or non-critical warnings
- No `console.log()` in production code

## Comments

- Javadoc for public API methods (controllers, services)
- Inline comments for complex business logic
- No comments for obvious code
- Backend: Javadoc style on service/controller classes
- Frontend: Not consistently used (rely on TypeScript types)
- Example:

## Function Design

- Methods: Under 30 lines preferred (flag over 30 lines)
- Components: Under 200 lines (flag and extract sub-components)
- Backend: Maximum 3-4 parameters; use Request/Response DTOs for more
- Frontend: Maximum 5-6 props; use Props interfaces for more
- Prefer composition over parameter lists
- Backend: Return DTOs, not entities; use ResponseEntity for status control
- Frontend: Return typed arrays/objects from hooks; return error objects for operations
- Use guard clauses instead of deep nesting
- Example from `JwtAuthenticationFilter`:

## Module Design

- Controllers: Thin (validate input, call service, return DTO)
- Services: Business logic only (no HTTP concerns)
- Repositories: Data access with Spring Data JPA
- DTOs: Records for request/response (immutable, type-safe)
- Route components: Fetch data, render pages
- UI components: Pure rendering logic
- Feature components: Interactive logic
- Hooks: Stateful logic and side effects
- Types: Centralized type definitions in `types/` directory
- `types/index.ts` - Exports shared types
- No other barrel files (components imported directly)

## Validation

- Jakarta Validation annotations on Request DTOs (`@Min`, `@Max`, `@Valid`)
- `@Valid` on controller parameters to trigger validation
- Validation errors caught by `GlobalExceptionHandler`
- TypeScript types for compile-time validation
- No runtime validation library (rely on backend validation)
- Optional chaining for nullable props

## Testing Conventions

- Unit: `*Test.java` in same package as source (mirrors main structure)
- Integration: Separate `*IntegrationTest.java` files
- Controller: `@WebMvcTest` with MockMvc
- Service: JUnit 5 + Mockito
- Component tests: `*.test.tsx` co-located with components
- Hook tests: `*.test.ts` co-located with hooks
- Framework: Vitest + React Testing Library + jsdom
- Setup: `src/test-setup.ts` with jest-dom matchers
- Backend: `methodName_Scenario_ExpectedResult` (e.g., `startQuiz_CreatesSession`)
- Frontend: Descriptive phrases (e.g., "renders all choices", "calls onClick when clicked")

<!-- GSD:conventions-end -->

<!-- GSD:architecture-start source:ARCHITECTURE.md -->

## Architecture

## System Overview

```text

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

- Frontend calls Supabase Auth **directly** for registration/login — credentials never pass through the backend
- Spring Boot receives JWT on every request, verifies signature via Supabase JWKS, extracts user ID
- Two distinct data access paths: frontend→Supabase (RLS-governed) and frontend→Spring Boot→Postgres (service-governed)
- REST API with JSON payloads, RFC 7807 error format
- Client-side routing with React Router v7 (SPA fallback on Netlify)
- Backend is stateless — no HTTP sessions, all auth via JWT

## Layers

- Purpose: User interface, client-side routing, direct Supabase integration
- Location: `src/web/src/`
- Contains: Route components, UI components, custom hooks, TypeScript types, utilities
- Depends on: Supabase JS SDK, React Router v7, Tailwind CSS
- Used by: End users (browser)
- Purpose: Business logic, JWT verification, quiz operations, user progress tracking
- Location: `src/api/src/main/java/com/nerdquiz/`
- Contains: Controllers, Services, Repositories, Models, DTOs, Config, Exceptions
- Depends on: Spring Boot, Spring Security, Spring Data JPA, Nimbus JOSE JWT, PostgreSQL driver
- Used by: React SPA (via HTTP)
- Purpose: Persistent data storage, row-level security, stored procedures
- Location: `supabase/migrations/`, `supabase/seed_data/`
- Contains: Schema migrations, seed data, stored procedures (RPC functions)
- Depends on: PostgreSQL + pgcrypto extension
- Used by: Spring Boot (via JDBC), React SPA (via Supabase JS SDK directly)
- Purpose: User authentication, session management, OAuth (Google)
- Location: Supabase managed infrastructure
- Contains: Auth tables, JWT signing, JWKS endpoint
- Used by: React SPA (via SDK), Spring Boot (via JWT verification)

## Data Flow

### Primary Request Path (Authenticated)

### Direct Supabase Path (Frontend)

### Authentication Flow

### Quiz Completion Flow

- React Context (`AuthContext`) for authentication state
- React local state (`useState`) for component-specific state
- Custom hooks encapsulate async data fetching (`useTopics`, `useLessons`)
- No Redux/Zustand — minimal state needs, Context sufficient

## Key Abstractions

- Purpose: Bridge between Supabase Auth (JWT) and application user profile
- Examples: `src/web/src/hooks/useAuth.tsx` — `fetchUserProfile()` creates/updates profile
- Pattern: On auth state change, query `user_profiles`, create if missing, sync OAuth metadata
- Purpose: Track quiz attempt state, answers, and score
- Examples: `src/api/src/main/java/com/nerdquiz/model/QuizSession.java`, `QuizService.java`
- Pattern: Create session → store answers → mark complete → return result
- Purpose: Display user progress across learning roadmap
- Examples: `src/web/src/routes/LearningMap.tsx`, `src/api/.../TopicController.java`
- Pattern: Fetch topics with user progress from backend, group by category, display roadmap
- Purpose: Review wrong answers for learning reinforcement
- Examples: `src/web/src/routes/MistakeGarden.tsx`
- Pattern: Query `user_mistakes` with joined `questions` from Supabase, display in UI
- Purpose: Track which lessons users have completed
- Examples: `src/web/src/routes/LessonPage.tsx`, `src/api/.../LessonController.java`
- Pattern: Fetch lesson content, update `user_lesson_progress` table via Supabase

## Entry Points

- Location: `src/web/src/main.tsx`
- Triggers: Browser loads `/`, React renders App
- Responsibilities: Mount React app, render BrowserRouter + AuthProvider
- Location: `src/web/src/App.tsx`
- Triggers: React Router navigation
- Responsibilities: Map URLs to page components, apply ProtectedRoute guard
- Location: `src/api/src/main/java/com/nerdquiz/NerdQuizApplication.java`
- Triggers: Spring Boot application startup
- Responsibilities: Bootstrap Spring context, start HTTP server on port 8080
- Location: `src/api/src/main/java/com/nerdquiz/controller/`
- Triggers: HTTP requests from frontend
- Responsibilities: Route to appropriate service methods, return DTOs
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

### Hardcoded Magic Numbers

### Missing Error Boundaries

### Type Assertions (`as` keyword)

## Error Handling

- **Frontend:** try/catch around API calls, display error state in components (loading/error/success states)
- **Backend:** `@RestControllerAdvice` global exception handler maps exceptions to HTTP status + Problem Details JSON
- **Supabase:** SDK returns error objects — check `.error` before using `.data`
- **Validation:** `@Valid` + Jakarta annotations in controllers, 400 response with field errors

## Cross-Cutting Concerns

- Backend: SLF4J logger in `JwtAuthenticationFilter`, debug-level for JWT failures
- Frontend: `console.error()` for Supabase/API failures — not logged to external service
- Security constraint: Never log JWT contents, PII, or user data
- Backend: Jakarta Validation (`@Valid`) on request bodies, enforced in controllers
- Frontend: Form validation in LoginPage/RegisterPage before submission, Supabase handles email format
- Supabase Auth for registration, login, session management (managed service)
- Spring Boot JWT verification via `JwtAuthenticationFilter` (stateless, no sessions)
- User ID extracted from JWT `sub` claim — never trust client-supplied user IDs
- Public endpoints (health check, landing page) explicitly bypass JWT filter
- Row Level Security (RLS) in Supabase — enforced at database level
- Spring Security filter chain — all endpoints require auth unless configured otherwise
- No role-based access control yet (single user role)
- Two patterns: Supabase SDK (frontend) and Spring Data JPA (backend)
- Spring Boot uses `@EntityGraph` or explicit queries to avoid N+1
- Supabase queries use PostgREST-style filters
- Stored procedures for complex operations (increment XP, get exam questions)

<!-- GSD:architecture-end -->

<!-- GSD:skills-start source:skills/ -->

## Project Skills

| Skill | Description | Path |
|-------|-------------|------|
| extract-data | Full ITPEC FE data extraction pipeline — from official ZIP archives to Supabase-ready SQL seed data | `.claude/skills/extract-data/SKILL.md` |
| pr-review | Automated code review on staged changes — checks conventions, security, correctness, and test coverage | `.claude/skills/pr-review/SKILL.md` |
| sync-reqs | Sync feature changes from staged code to REQUIREMENTS.md, feature-board.md, and create ADRs when needed | `.claude/skills/sync-reqs/SKILL.md` |
| spike-findings-team-16-app | Implementation patterns, constraints, and gotchas from security spike experiments — rate limiting, headers, input validation, JWT hardening, RLS | `.claude/skills/spike-findings-team-16-app/SKILL.md` |
<!-- GSD:skills-end -->

<!-- GSD:workflow-start source:GSD defaults -->

## GSD Workflow Enforcement

Before using Edit, Write, or other file-changing tools, start work through a GSD command so planning artifacts and execution context stay in sync.

Use these entry points:

- `/gsd-quick` for small fixes, doc updates, and ad-hoc tasks
- `/gsd-debug` for investigation and bug fixing
- `/gsd-execute-phase` for planned phase work

Do not make direct repo edits outside a GSD workflow unless the user explicitly asks to bypass it.
<!-- GSD:workflow-end -->

<!-- GSD:profile-start -->

## Developer Profile

> Profile not yet configured. Run `/gsd-profile-user` to generate your developer profile.
> This section is managed by `generate-claude-profile` -- do not edit manually.
<!-- GSD:profile-end -->
