# Backend conventions — Spring Boot

Applies to: `src/api/**`

## Stack

- Java 25, Spring Boot 3.x, Gradle
- REST API only — no server-side rendering
- JWT verification via Supabase JWKS (no auth logic in the backend)

## Project layout

```
src/api/
├── build.gradle
├── src/main/java/com/nerdquiz/
│   ├── NerdQuizApplication.java
│   ├── config/            # Security config, CORS, JWT filter
│   ├── controller/        # REST controllers (thin — delegate to service)
│   ├── service/           # Business logic
│   ├── repository/        # Spring Data JPA repositories
│   ├── model/             # JPA entities
│   ├── dto/               # Request/Response DTOs (records preferred)
│   └── exception/         # Global exception handler (@RestControllerAdvice)
└── src/test/java/         # Mirror of main structure
```

## Coding conventions

- Use Java records for DTOs — no Lombok for data classes.
- Use `@RestController` + `@RequestMapping` for controllers.
- Keep controllers thin: validate input, call service, return DTO.
- Business logic lives in `@Service` classes.
- Use constructor injection (no `@Autowired` on fields).
- Return `ResponseEntity<T>` for endpoints that need status control; otherwise Spring's defaults are fine.
- Use `@Valid` + Jakarta Validation annotations for request body validation.

## Naming conventions

| Element | Convention | Example |
|---|---|---|
| Classes | PascalCase | `QuizService`, `MistakeController`, `QuestionNotFoundException` |
| Methods | camelCase | `getUserProgress()`, `calculateXp()`, `verifyJwt()` |
| Variables | camelCase | `questionCount`, `userStreak`, `totalXp` |
| Constants | UPPER_SNAKE_CASE | `MAX_QUESTIONS_PER_QUIZ`, `STREAK_WINDOW_HOURS` |
| Packages | lowercase, singular | `com.nerdquiz.service`, `com.nerdquiz.model` |
| DB tables | snake_case, plural | `questions`, `user_progress`, `mistakes` |
| DB columns | snake_case | `created_at`, `user_id`, `exam_session` |

**Suffix conventions (enforced):**

| Type | Suffix | Example |
|---|---|---|
| Controllers | `Controller` | `QuizController`, `MistakeController` |
| Services | `Service` | `QuizService`, `XpService` |
| Repositories | `Repository` | `QuestionRepository`, `UserProgressRepository` |
| DTOs (request) | `Request` | `CreateMistakeRequest`, `SubmitQuizRequest` |
| DTOs (response) | `Response` | `QuizResponse`, `UserProgressResponse` |
| Exceptions | `Exception` | `QuestionNotFoundException`, `ExamSessionExpiredException` |
| Config classes | `Config` | `SecurityConfig`, `CorsConfig` |
| JPA entities | singular, no suffix | `Question`, `UserProgress`, `Mistake` |

**API path conventions:**

- Resources: plural nouns — `/api/v1/questions`, `/api/v1/mistakes`
- Actions: verb-noun — `/api/v1/exams/:id/start`, `/api/v1/quizzes/:id/submit`
- Never pluralize verbs — `/api/v1/users` not `/api/v1/users/`

**What to flag:**
- Class named `Helper`, `Util`, `Manager`, `Processor` — these are too vague; rename to what they actually do
- Variable named `data`, `temp`, `info`, `result` — give it a meaningful name
- Method named `process()`, `handle()`, `doStuff()` — name the action specifically

## API conventions

- Base path: `/api/v1/...`
- JSON everywhere (`Content-Type: application/json`).
- Use standard HTTP verbs: GET (read), POST (create), PUT (full update), PATCH (partial), DELETE.
- Return meaningful HTTP status codes: 200, 201, 400, 401, 403, 404, 500.
- Error responses follow RFC 7807 Problem Details format.

## Database

- Spring Data JPA with Postgres dialect.
- Migrations managed by Supabase CLI in `supabase/migrations/` — NOT by Flyway or Liquibase.
- Entity table names match Supabase migration table names exactly.
- Use `UUID` for primary keys (matching Supabase's `gen_random_uuid()`).

## Performance

- **No N+1 queries.** Use `@EntityGraph`, `JOIN FETCH`, or `@EntityGraph(attributePaths = ...)` when loading entities with relations. If a list endpoint loads related entities one-by-one in a loop, it's a bug.
- **Specific queries over SELECT \*.** Use `@Query` with specific columns when only a subset of fields is needed (e.g., question text + answer, not the entire entity).
- **Pagination on list endpoints.** Return unbounded result sets only if the data is guaranteed small (<100 items). Otherwise, use `Pageable` + `Page<T>`.
- **`Optional` over null.** Repository methods should return `Optional<T>` for single-entity lookups. Service methods should use `Optional.map/orElse` instead of null checks.
- **No string concatenation in loops.** Use `StringBuilder` or `String.join()` — string `+` in a loop creates O(n²) garbage.
- **Try-with-resources** for any `InputStream`, `Connection`, `Reader`, etc. — never leave resources open.
- **Avoid unnecessary object creation in hot paths.** Don't create new `BeanUtils.copyProperties()` or mapper objects inside loops — use static utilities or inject once.

## Maintainability

- **Single Responsibility.** One service class = one domain concept. If a service handles both quiz logic and user profile logic, split it.
- **Small methods, small classes.** Flag methods over ~30 lines or classes over ~300 lines — they're probably doing too much.
- **Early returns over deep nesting.** Use guard clauses (`if (invalid) return;`) instead of wrapping entire method bodies in `if/else`.
- **Named constants over magic numbers.** `MAX_QUESTIONS_PER_QUIZ = 5` not a bare `5` scattered through code.
- **No generic `Exception` catches** in service/controller layers. Catch specific exceptions; let the global handler deal with the rest.
- **Prefer composition over inheritance.** Inject dependencies rather than extending base classes.
- **No deprecated API usage.** If the code uses a deprecated Spring/Java method, flag it with the recommended replacement.

## Security

- JWT filter reads `Authorization: Bearer <token>`, verifies signature against Supabase JWKS.
- Extract user ID from JWT `sub` claim — pass it to services as a method argument, never trust client-supplied user IDs.
- All endpoints require auth unless explicitly marked `@Public`.
- Never log JWT contents or user PII.

## Testing

- Unit tests for services (mock repositories).
- Integration tests for controllers (`@WebMvcTest` with mock service layer).
- Test file lives next to the class it tests in `src/test/java/`.
