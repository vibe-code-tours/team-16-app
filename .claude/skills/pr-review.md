---
name: pr-review
description: Automated code review on staged changes — checks conventions, security, correctness, and test coverage
---

# Skill: PR Review

Run this before every commit to catch issues early. Reviews only what is staged
(`git diff --staged`), so stage your files first.

## Procedure

### 1. Get the staged diff

Run `git diff --staged` to get the exact changes about to be committed. If the diff
is empty, tell the developer nothing is staged and stop.

### 2. Identify which stack is affected

Check which paths are touched:

| Path prefix | Stack | Apply these rules |
|---|---|---|
| `src/api/**` | Spring Boot backend | `.claude/rules/backend.md` |
| `src/web/**` | React frontend | `.claude/rules/frontend.md` |
| `supabase/**` | Database | `.claude/rules/data-handling.md` |
| `docs/**` | Documentation | — |
| `.claude/**` | Tooling | — |

Load the relevant rule file(s) and use them as the review checklist.

### 3. Run the review checklist

Check every item below. Only report items that actually have problems — don't list
passing checks.

#### Code quality — backend (Java / Spring Boot)
- [ ] Java records for DTOs, no Lombok for data classes
- [ ] Constructor injection, no `@Autowired` on fields
- [ ] Controllers are thin — delegate to service layer
- [ ] REST base path is `/api/v1/...`
- [ ] Request validation with `@Valid` + Jakarta annotations
- [ ] Error responses use RFC 7807 Problem Details
- [ ] **No N+1 queries** — related entities loaded via `@EntityGraph` or `JOIN FETCH`, not one-by-one in a loop
- [ ] **List endpoints use pagination** (`Pageable` + `Page<T>`) unless data is guaranteed small
- [ ] **Repository methods return `Optional<T>`** for single lookups — no raw null returns
- [ ] **No string concatenation in loops** — use `StringBuilder` or `String.join()`
- [ ] **Try-with-resources** for IO/connection handling
- [ ] **No magic numbers** — extracted into named constants
- [ ] **No generic `Exception` catches** in service/controller (only in global handler)
- [ ] **Methods under ~30 lines, classes under ~300 lines** — flag if exceeded
- [ ] **Early returns** over deeply nested if/else blocks
- [ ] **No deprecated API usage** — use the current replacement

#### Naming — backend (Java / Spring Boot)
- [ ] **Classes:** PascalCase with correct suffix — `*Controller`, `*Service`, `*Repository`, `*Config`
- [ ] **DTOs:** `*Request` for input, `*Response` for output — no generic `*DTO` suffix
- [ ] **Exceptions:** `*Exception` suffix — `QuestionNotFoundException`, not `QuestionError`
- [ ] **Entities:** PascalCase, singular, no suffix — `Question`, `UserProgress`, not `Questions`, `QuestionEntity`
- [ ] **Methods:** camelCase — `getUserProgress()`, `calculateXp()`, not `GetUserProgress()`
- [ ] **Constants:** UPPER_SNAKE_CASE — `MAX_QUESTIONS_PER_QUIZ`, not `maxQuestions`
- [ ] **Packages:** lowercase, singular — `com.nerdquiz.service`, not `com.nerdquiz.Services`
- [ ] **DB tables:** snake_case, plural — `user_progress`, `mistakes`
- [ ] **DB columns:** snake_case — `created_at`, `user_id`
- [ ] **API paths:** plural nouns for resources (`/questions`), verb-noun for actions (`/exams/:id/start`)
- [ ] **No vague names** — no `Helper`, `Util`, `Manager`, `Processor`, `process()`, `handle()`, `doStuff()`

#### Code quality — frontend (React / TypeScript)
- [ ] Functional components only, no class components
- [ ] TypeScript — no `any` types without justification
- [ ] One component per file, name matches file name
- [ ] Tailwind utilities only — no `style={{ }}` inline styles
- [ ] API calls go through centralized client (`lib/api.ts`)
- [ ] **`useMemo` for expensive computations** — filtering/sorting questions, computing stats, aggregating data
- [ ] **`useCallback` for callbacks passed to child components** — prevents unnecessary child re-renders
- [ ] **Stable list keys** — entity IDs as `key`, never array indices for dynamic lists
- [ ] **Route-level code splitting** — `React.lazy()` + `<Suspense>` for page components
- [ ] **No unnecessary `useEffect`** — derived state is computed during render, not in effects
- [ ] **`useEffect` has cleanup** — timers, subscriptions, event listeners all have return cleanup
- [ ] **Every data-fetching component handles loading/error/empty states** — not just the happy path
- [ ] **No direct DOM manipulation** — use refs and state, never `document.querySelector`
- [ ] **Explicit prop types** — every component has a typed `Props` interface, no `any` props
- [ ] **Components under ~200 lines** — flag if exceeded; extract sub-components or hooks
- [ ] **Prop drilling past 2 levels** — use context or restructure instead
- [ ] **No inline functions in JSX for frequently re-rendered components** — pass memoized references

#### Naming — frontend (React / TypeScript)
- [ ] **Component files:** PascalCase + `.tsx` — `QuizCard.tsx`, `MistakeGarden.tsx`
- [ ] **Component names:** PascalCase, match file name — `QuizCard`, not `quizCard` or `component1`
- [ ] **Hook files:** `use` + PascalCase + `.ts` — `useAuth.ts`, `useQuizSession.ts`
- [ ] **Hook names:** `use` + PascalCase — `useAuth()`, `useQuizSession()`
- [ ] **Props interfaces:** `<Component>Props` — `QuizCardProps`, not `Props` or `QuizProps`
- [ ] **Event handlers:** `handle` + Event — `handleSubmit()`, `handleAnswerSelect()`
- [ ] **State setters:** `set` + Noun — `setQuestions()`, `setSelectedAnswer()`
- [ ] **Route constants:** UPPER_SNAKE_CASE — `ROUTE_MAP = '/map'`
- [ ] **Utility functions:** camelCase, descriptive — `formatXp()`, `calculateStreak()`
- [ ] **Type files:** PascalCase + `.ts` — `Quiz.ts`, `UserProgress.ts`
- [ ] **No vague names** — no `data`, `temp`, `info`, `res`, `process()`, `handle()`, `doStuff()`
- [ ] **No generic `utils.ts`** — split into focused files (`formatXp.ts`, `calculateStreak.ts`)

#### Security — secrets and credentials

Scan the staged diff for any of the following patterns. **All are 🔴 BLOCKING.**

**Hardcoded secrets (never allowed in source code):**
- [ ] API keys: strings matching patterns like `sk-...`, `api_key=`, `apikey:`, `AKIA...` (AWS), `ghp_...` (GitHub), `xoxb-...` (Slack)
- [ ] Supabase keys: `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY` with actual values (not env var references)
- [ ] Database connection strings: `postgresql://...`, `mysql://...`, `mongodb://...` with embedded passwords
- [ ] OAuth client secrets: `client_secret`, `CLIENT_SECRET`, `oauth_secret` with actual values
- [ ] JWT signing secrets: `JWT_SECRET`, `SIGNING_KEY`, `HMAC_SECRET` with actual values
- [ ] Private keys / certificates: `-----BEGIN (RSA |EC )?PRIVATE KEY-----`
- [ ] Passwords in code: `password = "..."`, `passwd: "..."`, `DB_PASSWORD=...` with actual values
- [ ] Base64-encoded secrets: long base64 strings assigned to key-like variable names
- [ ] Hardcoded IP addresses or internal URLs that aren't localhost/127.0.0.1
- [ ] `.env` files or files matching `.env.*` (other than `.env.example`)

**Supabase-specific (critical for this project):**
- [ ] `SUPABASE_SERVICE_ROLE_KEY` in any frontend code (`src/web/**`) — this key bypasses RLS and must NEVER be in the browser
- [ ] Service role key in any file that could be client-side bundled
- [ ] Only `SUPABASE_ANON_KEY` is allowed in frontend code — verify this is the anon key, not the service role key

**Secrets in non-code files:**
- [ ] No real keys in markdown, YAML, JSON, or config files (only `.env.example` with placeholder values)
- [ ] No credentials in Docker configs, docker-compose files, or CI workflow files
- [ ] No API tokens in README or documentation examples

**How to verify:** If a staged diff contains a string that looks like a long random/alphanumeric value (20+ chars) assigned to a variable with a security-related name, flag it even if it doesn't match the patterns above. False positives are acceptable — blocking a real secret is not.

#### Security — auth and data protection

- [ ] No `userId` accepted from request body — always extracted from JWT `sub` claim
- [ ] User-facing data (mistakes, progress, profile) requires auth check
- [ ] No PII logged: emails, user IDs, JWT tokens, passwords in log statements
- [ ] No `console.log()` or `System.out.println()` with request bodies or user data
- [ ] Error responses don't leak stack traces, SQL errors, or internal paths to the client
- [ ] CORS is not set to `*` in production config
- [ ] Input validation present on all endpoints that accept user data (`@Valid` on backend, form validation on frontend)

#### Database
- [ ] Table names are `snake_case` plural
- [ ] Primary keys are `UUID DEFAULT gen_random_uuid()`
- [ ] Timestamps use `TIMESTAMPTZ`
- [ ] Migrations are in `supabase/migrations/`, not Flyway/Liquibase
- [ ] RLS policies enabled on user-data tables

#### Correctness
- [ ] No obvious null/undefined risks
- [ ] Error states handled (not just happy path)
- [ ] No commented-out code left behind
- [ ] No `console.log` / `System.out.println` debugging left in

#### Tests
- [ ] Changes include tests (or explicitly justify why not)
- [ ] Tests cover the happy path at minimum

#### Documentation sync
- [ ] If the change adds, modifies, or cuts a feature → `docs/REQUIREMENTS.md` was updated
- [ ] If the change adds, modifies, or cuts a feature → `docs/gsd/feature-board.md` status/notes were updated
- [ ] If the change is an architectural decision (new tech, new integration, auth/DB change) → an ADR exists in `docs/decisions/`
- [ ] If the change affects shared constraints → `docs/gsd/architecture-boundaries.md` was updated

**How to check:** If the staged diff touches `src/` or `supabase/` and looks like a
feature addition/modification (not just a bug fix or refactor), verify that the docs
above were also staged. If they weren't, flag it as a WARNING and suggest running
`/sync-reqs` first.

### 4. Report findings

Format the output as a structured list. If no issues found:

```
✅ Review passed — no findings. Ready to commit.
```

If issues found, list them grouped by category:

```
🔴 BLOCKING (must fix before commit):
  [file:line] Finding description

🟡 WARNING (fix if possible, justify if not):
  [file:line] Finding description

ℹ️  INFO (suggestion, not blocking):
  [file:line] Finding description
```

End with a summary:

```
Review complete: N blocking, M warnings, K info
```

### 5. If blocking findings exist

The developer must fix them and re-run `/pr-review`. A commit should only happen
when there are zero blocking findings.

## Notes

- This review covers **code quality and conventions**. It does NOT replace human review
  for architectural decisions (schema changes, new endpoints, auth flow).
- See `.claude/rules/git-workflow.md` for when a teammate review is still required.
- The review scope is limited to the staged diff — not the entire codebase.
