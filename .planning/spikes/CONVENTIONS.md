# Spike Conventions

Patterns and stack choices established across spike sessions. New spikes follow these unless the question requires otherwise.

## Stack

- **Language:** Java 25 (backend), TypeScript (frontend)
- **Backend:** Spring Boot 3.x with Spring Security
- **Frontend:** React + Vite + Tailwind CSS
- **Database:** Supabase (Postgres) with Row Level Security
- **Auth:** Supabase Auth (JWT verification via Nimbus JOSE+JWT)
- **Spikes:** Plain Java with `com.sun.net.httpserver.HttpServer` — no Spring Boot dependency needed for validation experiments

## Structure

- Spikes live in `.planning/spikes/NNN-descriptive-name/`
- Each spike has: `README.md` (frontmatter + investigation trail), source files, test scripts
- Spike sources are standalone Java files with `main()` — compilable with just `javac`
- Test scripts use `bash` + `curl` — no test framework needed for spikes
- Port assignment: 9999, 9998, 9997, 9996, ... (countdown from 9999 to avoid conflicts)

## Patterns

- **RFC 7807 Problem Details** for all error responses (matches project convention)
- **ConcurrentHashMap** for in-memory state (thread-safe, zero dependencies)
- **OncePerRequestFilter** for Spring Security filters (runs once per request)
- **Generic error messages** for auth failures — never reveal internal details
- **Debug-only logging** for security events — never log PII or JWT contents
- **`--data-urlencode`** with curl for testing special characters in URLs
- **Write large payloads to file** before curl to avoid shell argument length limits

## Tools & Libraries

- **Nimbus JOSE+JWT 9.41.2** — JWT verification (rejects `alg:none` by default)
- **Jakarta Validation** — `@Valid`, `@NotBlank`, `@Size`, `@Email` for request validation
- **Spring Security HeaderWriter** — CSP, HSTS, X-Frame-Options configuration
- **ConcurrentHashMap + AtomicInteger** — lock-free concurrent state management
