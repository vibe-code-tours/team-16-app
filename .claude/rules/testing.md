# Testing strategy

Applies to: `src/api/**` and `src/web/**`

## Principles

- Tests verify **user-visible behavior**, not implementation details.
- A failing test should tell you **what broke**, not which line of code changed.
- Write tests alongside features — not after. "Done" includes tests.

## Backend testing (Spring Boot)

| Layer | Tool | What to test |
|---|---|---|
| Unit tests | JUnit 5 + Mockito | Service logic, business rules, calculations (XP, streak) |
| Integration tests | `@SpringBootTest` + Testcontainers | Repository queries, API endpoint responses |
| Controller tests | `@WebMvcTest` | HTTP status codes, request/response JSON shapes |

- Mock external calls (Supabase JWKS) in unit tests.
- Use `@Sql` or `@Testcontainers` for test-specific seed data.
- Test edge cases: zero questions, expired tokens, duplicate registrations.

## Frontend testing (React)

| Layer | Tool | What to test |
|---|---|---|
| Component tests | React Testing Library + Vitest | Rendering, user interactions, conditional display |
| Hook tests | `renderHook` + Vitest | Custom hook return values, side effects |
| E2E (stretch) | Playwright | Full user flows (login → quiz → results) |

- Mock Supabase client and API responses — never hit real services in tests.
- Test accessibility: buttons have labels, forms have associated labels.
- Snapshot tests are discouraged — they break on every styling change.

## CI

- `ci.yml` runs: lint → typecheck → test → build.
- All tests must pass before a PR can merge.
- Test coverage is not enforced by CI yet (stretch goal).
