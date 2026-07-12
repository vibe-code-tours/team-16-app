# Backend Review Checklist — Java / Spring Boot

Applies to: `src/api/**`

## Code quality

- Java records for DTOs, no Lombok for data classes
- Constructor injection, no `@Autowired` on fields
- Controllers are thin — delegate to service layer
- REST base path is `/api/v1/...`
- Request validation with `@Valid` + Jakarta annotations
- Error responses use RFC 7807 Problem Details
- **No N+1 queries** — related entities loaded via `@EntityGraph` or `JOIN FETCH`, not one-by-one in a loop
- **List endpoints use pagination** (`Pageable` + `Page<T>`) unless data is guaranteed small
- **Repository methods return `Optional<T>`** for single lookups — no raw null returns
- **No string concatenation in loops** — use `StringBuilder` or `String.join()`
- **Try-with-resources** for IO/connection handling
- **No magic numbers** — extracted into named constants
- **No generic `Exception` catches** in service/controller (only in global handler)
- **Methods under ~30 lines, classes under ~300 lines** — flag if exceeded
- **Early returns** over deeply nested if/else blocks
- **No deprecated API usage** — use the current replacement

## Naming

- **Classes:** PascalCase with correct suffix — `*Controller`, `*Service`, `*Repository`, `*Config`
- **DTOs:** `*Request` for input, `*Response` for output — no generic `*DTO` suffix
- **Exceptions:** `*Exception` suffix — `QuestionNotFoundException`, not `QuestionError`
- **Entities:** PascalCase, singular, no suffix — `Question`, `UserProgress`, not `Questions`, `QuestionEntity`
- **Methods:** camelCase — `getUserProgress()`, `calculateXp()`, not `GetUserProgress()`
- **Constants:** UPPER_SNAKE_CASE — `MAX_QUESTIONS_PER_QUIZ`, not `maxQuestions`
- **Packages:** lowercase, singular — `com.nerdquiz.service`, not `com.nerdquiz.Services`
- **DB tables:** snake_case, plural — `user_progress`, `mistakes`
- **DB columns:** snake_case — `created_at`, `user_id`
- **API paths:** plural nouns for resources (`/questions`), verb-noun for actions (`/exams/:id/start`)
- **No vague names** — no `Helper`, `Util`, `Manager`, `Processor`, `process()`, `handle()`, `doStuff()`

## Database

- Table names are `snake_case` plural
- Primary keys are `UUID DEFAULT gen_random_uuid()`
- Timestamps use `TIMESTAMPTZ`
- Migrations are in `supabase/migrations/`, not Flyway/Liquibase
- RLS policies enabled on user-data tables
