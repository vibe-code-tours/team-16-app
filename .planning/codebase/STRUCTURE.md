# Codebase Structure

**Analysis Date:** 2026-07-14

## Directory Layout

```
team-16-app/
├── src/
│   ├── api/                              # Spring Boot backend
│   │   ├── build.gradle                  # Gradle build config (Spring Boot 3.5.9, Java 25)
│   │   ├── Dockerfile                    # Backend container config
│   │   ├── src/main/java/com/nerdquiz/  # Application source
│   │   │   ├── NerdQuizApplication.java # Entry point
│   │   │   ├── annotation/              # Custom annotations (@Public)
│   │   │   ├── config/                  # Security, CORS, JWT filter
│   │   │   ├── controller/              # REST controllers (thin layer)
│   │   │   ├── dto/                     # Request/Response records
│   │   │   ├── exception/              # Custom exceptions + global handler
│   │   │   ├── model/                  # JPA entities
│   │   │   ├── repository/            # Spring Data JPA repositories
│   │   │   └── service/               # Business logic
│   │   └── src/test/java/com/nerdquiz/ # Test classes (mirror main structure)
│   │
│   └── web/                              # React frontend
│       ├── package.json                 # Dependencies + scripts
│       ├── vite.config.ts               # Vite build config
│       ├── tailwind.config.js           # Tailwind CSS config
│       ├── tsconfig.json                # TypeScript config
│       ├── index.html                   # SPA entry HTML
│       ├── public/                      # Static assets (favicon, mascot)
│       └── src/
│           ├── main.tsx                 # React entry point
│           ├── App.tsx                  # Root component + route definitions
│           ├── index.css                # Tailwind directives
│           ├── routes/                  # Page components (one per route)
│           ├── components/             # Reusable UI components
│           │   ├── ui/                 # Generic (Button, Card, Badge)
│           │   ├── features/          # Feature-specific (ChoiceList, ProgressBar)
│           │   ├── layout/            # Layout chrome (Header, Sidebar, Layout)
│           │   └── ProtectedRoute.tsx # Auth route guard
│           ├── hooks/                 # Custom React hooks
│           ├── lib/                   # Utilities, API client, Supabase init
│           ├── types/                 # TypeScript interfaces
│           ├── data/                  # Static data (sample questions)
│           └── styles/               # CSS globals
│
├── supabase/                            # Database management
│   ├── migrations/                     # Schema migrations (versioned SQL)
│   ├── seed_data/                     # Seed data files (lessons, questions)
│   ├── snippets/                     # SQL snippets
│   └── verify.sql                   # Schema verification script
│
├── docs/                               # Project documentation
│   ├── ARCHITECTURE.md               # System diagram and layout
│   ├── REQUIREMENTS.md               # MVP scope
│   ├── decisions/                   # Architecture Decision Records (ADRs)
│   ├── gsd/                        # How-we-work, feature board, boundaries
│   ├── diagrams/                   # Architecture diagrams
│   └── flow_summary/              # Workflow documentation
│
├── .claude/                           # AI-assisted development
│   ├── rules/                       # Path-scoped coding conventions
│   │   ├── backend.md              # Spring Boot conventions
│   │   ├── frontend.md             # React conventions
│   │   ├── testing.md             # Testing strategy
│   │   ├── security.md           # Security rules
│   │   ├── git-workflow.md       # Git workflow
│   │   └── data-handling.md     # Data extraction conventions
│   ├── skills/                     # On-demand procedures
│   │   ├── extract-data/         # ITPEC PDF extraction
│   │   ├── pr-review/           # Pull request review
│   │   └── sync-reqs/          # Requirements sync
│   └── plans/                   # Development plans
│
├── .github/                          # CI/CD
│   ├── workflows/
│   │   ├── ci.yml                 # Lint + typecheck + test + build
│   │   ├── deploy-backend.yml    # Backend deployment
│   │   ├── deploy-frontend.yml   # Frontend deployment (Netlify)
│   │   └── security.yml         # Gitleaks + Semgrep scanning
│   └── ISSUE_TEMPLATE/        # Issue templates
│
├── scripts/                         # Utility scripts
│   └── hooks/                   # Git hooks
│
├── resources/                       # Reference materials
│   └── exams/                   # ITPEC exam PDFs (source data)
│
├── tests/                         # Root-level tests
│
├── docker-compose.yml             # Backend container orchestration
├── netlify.toml                 # Frontend SPA routing config
├── CLAUDE.md                   # Project brief and conventions
├── README.md                  # Quickstart and overview
├── SETUP.md                  # Development setup guide
└── working-agreement.md      # Team collaboration agreement
```

## Directory Purposes

**`src/api/` (Spring Boot backend):**
- Purpose: REST API for business logic, quiz operations, user progress
- Contains: Java source organized by layer (controller, service, repository, model, dto, exception, config)
- Key files:
  - `src/main/java/com/nerdquiz/NerdQuizApplication.java` — entry point
  - `src/main/java/com/nerdquiz/config/SecurityConfig.java` — JWT auth filter chain
  - `src/main/java/com/nerdquiz/config/JwtAuthenticationFilter.java` — JWT verification
  - `src/main/java/com/nerdquiz/controller/QuizController.java` — quiz endpoints
  - `src/main/java/com/nerdquiz/service/QuizService.java` — quiz business logic
  - `src/main/java/com/nerdquiz/exception/GlobalExceptionHandler.java` — error responses

**`src/web/` (React frontend):**
- Purpose: User interface for exam prep platform
- Contains: React components, hooks, types, utilities, API client
- Key files:
  - `src/main.tsx` — React entry point
  - `src/App.tsx` — route definitions, AuthProvider
  - `src/lib/api.ts` — centralized API client (auto-attaches JWT)
  - `src/lib/supabase.ts` — Supabase client initialization
  - `src/hooks/useAuth.tsx` — authentication state management
  - `src/components/layout/Layout.tsx` — page chrome

**`src/web/src/routes/` (Page components):**
- Purpose: One file per route/page
- Contains: Feature-specific page components
- Key files:
  - `LearningMap.tsx` — topic roadmap with category grouping
  - `QuizPage.tsx` — quiz-taking flow
  - `MistakeGarden.tsx` — wrong answer review
  - `LoginPage.tsx` / `RegisterPage.tsx` — authentication pages

**`src/web/src/hooks/` (Custom React hooks):**
- Purpose: Encapsulate async data fetching and state logic
- Contains: useAuth, useTopics, useLessons
- Pattern: Return `{ data, loading, error }` objects

**`src/web/src/components/features/` (Feature components):**
- Purpose: Reusable UI components for specific features
- Contains: ChoiceList, ProgressBar, QuestionBlock, ExplanationBox, TopicNode

**`src/web/src/components/ui/` (Generic UI components):**
- Purpose: Reusable, style-agnostic UI primitives
- Contains: Button, Badge, Card (styled with Tailwind)

**`src/web/src/lib/` (Utilities and clients):**
- Purpose: Centralized utilities and API access
- Contains: api.ts (API client), supabase.ts (client init), cn.ts (classnames), utils.ts

**`src/web/src/types/` (TypeScript definitions):**
- Purpose: Shared type definitions
- Contains: index.ts (export barrel), Quiz.ts, topic.ts

**`supabase/migrations/` (Schema migrations):**
- Purpose: Version-controlled database schema
- Contains: Numbered SQL files (001, 002, 003...)
- Naming: `XXX_description.sql` (e.g., `001_initial_schema.sql`)
- Managed by: Supabase CLI (not Flyway/Liquibase)

**`supabase/seed_data/` (Seed data):**
- Purpose: Initial data for development/testing
- Contains: SQL files with INSERT statements
- Key files: `003_seed_lessons.sql`, `009_seed_exam_questions.sql`

**`docs/` (Documentation):**
- Purpose: Project documentation and architecture decisions
- Contains: ARCHITECTURE.md, REQUIREMENTS.md, ADRs, feature board
- Key files:
  - `ARCHITECTURE.md` — system diagram, external services
  - `REQUIREMENTS.md` — MVP scope (Week 1/2/out-of-scope)
  - `decisions/0001-record-architecture-decisions.md` — ADR format

**`.claude/rules/` (AI development conventions):**
- Purpose: Path-scoped coding standards for AI assistants
- Contains: backend.md, frontend.md, testing.md, security.md, git-workflow.md, data-handling.md
- Pattern: Each file documents conventions for a specific domain (backend, frontend, etc.)

**`.claude/skills/` (On-demand procedures):**
- Purpose: Step-by-step procedures for complex tasks
- Contains: extract-data (ITPEC PDF), pr-review (code review), sync-reqs (requirements sync)
- Usage: Invoked by AI assistants when performing specific tasks

**`.github/workflows/` (CI/CD pipelines):**
- Purpose: Automated testing, building, deployment
- Contains: ci.yml, deploy-backend.yml, deploy-frontend.yml, security.yml
- ci.yml runs: lint → typecheck → test → build for both frontend and backend

**`docs/gsd/` (How-we-work documentation):**
- Purpose: Team collaboration guidelines, feature tracking
- Contains: architecture-boundaries.md, decision-log.md, feature-board.md
- Usage: Guides development process and tracks feature status

## Key File Locations

**Entry Points:**
- `src/web/src/main.tsx` — React app bootstrap
- `src/web/src/App.tsx` — route definitions, providers
- `src/api/src/main/java/com/nerdquiz/NerdQuizApplication.java` — Spring Boot app
- `supabase/migrations/001_initial_schema.sql` — database schema

**Configuration:**
- `src/api/build.gradle` — backend dependencies and build
- `src/web/package.json` — frontend dependencies and scripts
- `src/web/vite.config.ts` — Vite build configuration
- `src/web/tailwind.config.js` — Tailwind CSS customization
- `src/web/tsconfig.json` — TypeScript settings
- `docker-compose.yml` — backend container config
- `netlify.toml` — frontend SPA routing

**Core Logic:**
- `src/api/src/main/java/com/nerdquiz/service/QuizService.java` — quiz business logic
- `src/api/src/main/java/com/nerdquiz/service/TopicService.java` — topic/progress logic
- `src/web/src/hooks/useAuth.tsx` — authentication state
- `src/web/src/lib/api.ts` — API client (auto-attaches JWT)

**Testing:**
- `src/api/src/test/java/com/nerdquiz/` — backend tests (mirror main structure)
- `src/web/src/test-setup.ts` — frontend test setup
- `src/web/src/components/**/*.test.tsx` — component tests (Vitest + React Testing Library)

**Database Schema:**
- `supabase/migrations/` — versioned SQL migrations
- `supabase/seed_data/` — seed data SQL
- `supabase/verify.sql` — schema verification

## Naming Conventions

**Files:**
- Frontend: PascalCase for components (`QuizPage.tsx`, `TopicNode.tsx`), camelCase for hooks/utilities (`useAuth.tsx`, `api.ts`)
- Backend: PascalCase for Java files (`QuizController.java`, `QuizService.java`), snake_case for SQL (`001_initial_schema.sql`)

**Directories:**
- Frontend: lowercase (`routes/`, `hooks/`, `lib/`, `components/`)
- Backend: lowercase singular (`controller/`, `service/`, `repository/`, `model/`, `dto/`)
- Database: lowercase (`migrations/`, `seed_data/`)

**Components:**
- File name matches component name: `QuizPage.tsx` exports `QuizPage()`
- Props interfaces: `<Component>Props` (e.g., `QuizCardProps`)
- One component per file

**Hooks:**
- File name: `use` + PascalCase + `.ts` or `.tsx` (e.g., `useAuth.tsx`)
- Hook name: `use` + PascalCase (e.g., `useAuth()`)

**Types:**
- File name: PascalCase + `.ts` (e.g., `Quiz.ts`, `topic.ts`)
- Interface name: PascalCase (e.g., `QuizQuestion`, `TopicWithStatus`)
- Export barrel: `src/web/src/types/index.ts`

**API Endpoints:**
- Path: `/api/v1/<resource>` (plural nouns for collections)
- Actions: POST `/api/v1/quizzes/start` (verb-noun)
- Status codes: 200, 201, 400, 401, 403, 404, 500

**Java Classes:**
- Controllers: `*Controller` (e.g., `QuizController`)
- Services: `*Service` (e.g., `QuizService`)
- Repositories: `*Repository` (e.g., `QuestionRepository`)
- DTOs: `*Request` or `*Response` (e.g., `StartQuizRequest`, `QuizSessionResponse`)
- Exceptions: `*Exception` (e.g., `QuizSessionNotFoundException`)

**Database:**
- Tables: snake_case, plural (`questions`, `user_progress`, `quiz_sessions`)
- Columns: snake_case (`user_id`, `created_at`, `correct_answer`)
- Primary keys: UUID with `gen_random_uuid()` default
- Timestamps: `created_at TIMESTAMPTZ DEFAULT now()`, `updated_at TIMESTAMPTZ DEFAULT now()`

## Where to Add New Code

**New Feature (Frontend):**
- Route: `src/web/src/routes/<FeatureName>.tsx`
- Components: `src/web/src/components/features/<FeatureName>*.tsx`
- Hook: `src/web/src/hooks/use<FeatureName>.ts`
- Types: Add to `src/web/src/types/<FeatureName>.ts` or `index.ts`
- Register in: `src/web/src/App.tsx` (routes)

**New Feature (Backend):**
- Controller: `src/api/src/main/java/com/nerdquiz/controller/<Feature>Controller.java`
- Service: `src/api/src/main/java/com/nerdquiz/service/<Feature>Service.java`
- Repository: `src/api/src/main/java/com/nerdquiz/repository/<Entity>Repository.java`
- Model: `src/api/src/main/java/com/nerdquiz/model/<Entity>.java`
- DTOs: `src/api/src/main/java/com/nerdquiz/dto/<Feature>Request.java`, `<Feature>Response.java`
- Exceptions: `src/api/src/main/java/com/nerdquiz/exception/<Feature>Exception.java`

**New Database Table:**
- Migration: `supabase/migrations/XXX_<description>.sql` (next sequential number)
- Seed data (if needed): `supabase/seed_data/XXX_<description>.sql`
- Update JPA entities: `src/api/src/main/java/com/nerdquiz/model/<Entity>.java`
- Update repositories: `src/api/src/main/java/com/nerdquiz/repository/<Entity>Repository.java`

**New Utility (Frontend):**
- File: `src/web/src/lib/<utilityName>.ts` (camelCase)
- Export from appropriate barrel or import directly

**New Type Definition:**
- File: `src/web/src/types/<TypeName>.ts` (PascalCase)
- Re-export from `src/web/src/types/index.ts` if globally shared

**New Test:**
- Backend: `src/api/src/test/java/com/nerdquiz/<layer>/<Class>Test.java`
- Frontend: `src/web/src/<path>/<Component>.test.tsx` (co-located with component)

**New CI/CD Step:**
- Edit: `.github/workflows/ci.yml`
- Add step to appropriate job (Node or Java)

**New Documentation:**
- Architecture decision: `docs/decisions/XXXX-<title>.md` (ADR format)
- Feature spec: `docs/<feature-name>.md`
- Process update: `docs/gsd/` (appropriate file)

**New Claude Rule:**
- File: `.claude/rules/<domain>.md`
- Reference from: Other rule files if cross-cutting

## Special Directories

**`src/web/node_modules/`:**
- Purpose: NPM dependencies
- Generated: Yes (by `npm install`)
- Committed: No

**`src/api/build/`:**
- Purpose: Gradle build output
- Generated: Yes (by `./gradlew build`)
- Committed: No

**`src/api/.gradle/`:**
- Purpose: Gradle cache
- Generated: Yes
- Committed: No

**`src/web/dist/`:**
- Purpose: Vite production build output
- Generated: Yes (by `npm run build`)
- Committed: No

**`.git/`:**
- Purpose: Git repository data
- Generated: Yes
- Committed: N/A (version control system)

**`.env`:**
- Purpose: Local environment variables (secrets)
- Generated: Manually by developer
- Committed: No (listed in `.gitignore`)

**`resources/exams/`:**
- Purpose: ITPEC exam PDFs (source data for extraction)
- Generated: No (downloaded manually)
- Committed: Yes (reference materials)

---

*Structure analysis: 2026-07-14*
