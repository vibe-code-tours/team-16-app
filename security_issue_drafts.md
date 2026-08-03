# Security and Logic Issue Drafts

## [Critical][SEC-001] Prevent users from awarding themselves arbitrary XP

## What happens

An authenticated user can choose an arbitrary nonnegative XP amount and add it to their own profile through `POST /api/v1/me/xp`. The same behavior is independently exposed through the Supabase `increment_user_xp` RPC, which is granted to all authenticated users.

## What should happen

XP should only be awarded by trusted server-side completion flows. The server should calculate the amount from a validated, idempotent quiz, lesson, or exam event; users should never provide an XP delta directly.

## Steps to reproduce

1. Sign in as a regular user and obtain a valid access token.
2. Send `POST /api/v1/me/xp` with `{"delta":1000000}` and observe that the profile's XP increases by the requested amount. The equivalent authenticated Supabase RPC call also accepts a caller-selected delta.

## Environment

Spring Boot API and Supabase migration `20260715012201_increment_user_xp.sql`; all browsers and operating systems; authenticated API/Supabase session.

---

## [Critical][SEC-002] Ensure deactivated users lose API access

## What happens

The admin deactivation action changes a user's role to `deactivated`, but it does not set `is_active` to `false`. The JWT filter rejects only profiles whose `is_active` value is false and assigns every non-admin profile—including a `deactivated` profile—`ROLE_USER`.

## What should happen

Deactivation should atomically mark the profile inactive, revoke or invalidate refresh sessions where possible, and prevent the user from receiving an authenticated application role on their next request.

## Steps to reproduce

1. As an admin, deactivate a regular user through `POST /api/v1/admin/users/{id}/deactivate`.
2. Reuse that user's valid token against a protected endpoint such as `GET /api/v1/me` and observe that the request is still authorized.

## Environment

Spring Boot API with Supabase authentication; all browsers and operating systems; admin and regular-user accounts required.

---

## [High][SEC-003] Do not expose answer keys during exam simulations

## What happens

Starting an exam returns question objects containing `correctAnswer` and `explanation`. Submitting each exam answer also returns the correct answer immediately. In addition, the `get_exam_questions` Supabase RPC returns complete question rows and is executable by anonymous users.

## What should happen

Exam question responses should contain only the prompt, choices, images, and non-sensitive metadata. Correct answers and explanations should become available only after the exam is irreversibly finished. Anonymous database access must not expose answer columns.

## Steps to reproduce

1. Start an exam with `POST /api/v1/exams/start` and inspect the returned question JSON.
2. Observe `correctAnswer` and `explanation` before answering; alternatively, submit an answer and observe that the answer key is returned while the session remains in progress.

## Environment

Spring Boot exam API and Supabase RPC; any browser/OS or API client; authenticated user for the API path, no authentication required for the currently granted RPC path.

---

## [High][SEC-004] Perform complete JWT claim and algorithm validation

## What happens

The custom JWT verifier checks the signature and checks expiration only when an `exp` claim exists. It does not require expiration or validate issuer, audience, not-before time, issued-at bounds, or an explicit allowlist of signing algorithms.

## What should happen

The API should accept only tokens issued by the configured Supabase project for the intended API audience, within their valid time window, using explicitly approved algorithms. Tokens missing mandatory claims should be rejected.

## Steps to reproduce

1. In an isolated test environment, create signed test tokens using the configured test JWKS with cases such as missing `exp`, wrong `aud`, wrong `iss`, or a future `nbf`.
2. Call a protected endpoint and observe that the custom verifier accepts claim combinations that should be rejected, provided the signature is valid.

## Environment

Spring Boot API/JWT unit or integration-test environment; no browser dependency. Use test keys only—do not use or expose production signing keys.

---

## [High][SEC-005] Make submitted exam answers immutable and server-timed

## What happens

Submitting an answer for a question that already has an answer loads and overwrites the existing record. The API also trusts client-supplied sequence numbers and response times. Because correctness is returned immediately, a user can submit a guess and then replace an incorrect answer.

## What should happen

Each issued exam question should accept at most one immutable answer. The server should validate the persisted question sequence and calculate relevant timing from server-observed timestamps. Correctness should not be revealed before completion.

## Steps to reproduce

1. Start an exam and submit an incorrect answer for one of the issued questions; note the correct answer returned by the API.
2. Submit the same question again with the correct answer and altered `sequenceNumber` or `responseTimeMs`, then observe that the existing answer is updated rather than rejected.

## Environment

Spring Boot exam API; any browser/OS or API client; authenticated user with an in-progress exam session.

---

## [High][SEC-006] Replace spoofable, unbounded in-memory rate limiting

## What happens

The rate limiter uses the first caller-provided `X-Forwarded-For` value as its key. Changing that header bypasses the per-IP limit. Every unique value is retained indefinitely in an unbounded map, and limits are maintained independently per application instance.

## What should happen

Client identity should come from a trusted proxy boundary, and inbound forwarding headers should be overwritten by the edge. Rate-limit state should be bounded and expiring, and production limits should be shared or enforced at the trusted edge. Authenticated routes should also support user-based limits.

## Steps to reproduce

1. In a local or staging environment, send requests until one `X-Forwarded-For` value receives HTTP 429.
2. Change the first `X-Forwarded-For` value and observe that requests are accepted again; repeat with many unique values and observe that the counter map has no eviction path.

## Environment

Spring Boot API behind a proxy or called directly; any OS/API client. Perform load-oriented verification only in local or authorized staging environments.

---

## [Medium][SEC-007] Derive profile email from the verified identity

## What happens

The profile upsert endpoint accepts an email address from the request body and stores it without verifying that it belongs to the authenticated Supabase user.

## What should happen

The email should be derived from a validated JWT claim or a server-side lookup of the authenticated Supabase account. If an unverified contact email is supported, it should be stored separately and clearly labeled as unverified.

## Steps to reproduce

1. Sign in as a regular user and send `POST /api/v1/me/profile` with another person's email address in the body.
2. Fetch the profile or view it in the admin interface and observe that the supplied email is treated as the user's profile email.

## Environment

Spring Boot API and admin UI; all browsers and operating systems; authenticated regular-user account.

---

## [Medium][SEC-008] Add security headers to the deployed frontend

## What happens

The Netlify configuration sets MIME types for assets but does not define a frontend Content Security Policy, clickjacking protection, referrer policy, or permissions policy. Similar headers on the separately hosted API do not protect the frontend document.

## What should happen

The deployed HTML should receive an appropriate CSP and browser hardening headers from Netlify or the actual frontend edge. Inline styles should be moved or handled safely so the policy does not require broad unsafe directives.

## Steps to reproduce

1. Deploy the current frontend configuration or open the deployed site and inspect the document response headers in browser developer tools.
2. Observe that repository-configured frontend responses lack CSP, `frame-ancestors`/equivalent clickjacking protection, referrer policy, and permissions policy unless an external untracked edge adds them.

## Environment

Netlify-hosted React/Vite frontend; any modern browser and OS; verify the production URL and any CDN configuration.

---

## [Medium][SEC-009] Secure and authenticate the admin CSV export

## What happens

Only display names receive CSV escaping and formula neutralization. Email and other text cells are emitted directly and can break the CSV structure or be interpreted as spreadsheet formulas. The frontend opens the protected export URL with `window.open`, which does not attach the bearer token used by the API client.

## What should happen

Every CSV cell should use consistent RFC 4180 quoting and spreadsheet-formula neutralization. The frontend should download the export with authenticated `fetch`, create a Blob URL, and use the `text/csv` content type.

## Steps to reproduce

1. Create a test profile whose email or another exported text field starts with a spreadsheet formula marker, then export users as an admin and inspect/open the CSV in an authorized test environment.
2. Observe that the value is not neutralized; separately, click the current export button and observe that the new navigation lacks the bearer authorization header and may return 401/403.

## Environment

Admin UI and Spring Boot API; any browser/OS; spreadsheet behavior varies by application, so verify with the supported office suite using non-destructive test data.

---

## [Medium][SEC-010] Upgrade or mitigate vulnerable frontend dependencies

## What happens

The lockfile resolves a vulnerable PostCSS version and a React Router version covered by a high-severity RSC action advisory. The current Vite SPA does not appear to use React Server Components, so the React Router exploit path is likely not active, but the vulnerable version remains tracked.

## What should happen

Dependencies should be upgraded to patched compatible releases. The applicability of the React Router advisory should be documented, and untrusted CSS/source maps should never be processed by the vulnerable PostCSS toolchain.

## Steps to reproduce

1. Run `npm audit --package-lock-only` from `src/web`.
2. Observe high-severity findings for PostCSS (GHSA-r28c-9q8g-f849) and the React Router dependency chain (GHSA-qwww-vcr4-c8h2).

## Environment

Node/npm environment using `src/web/package-lock.json`; reproduced during the audit on macOS. React Router RSC applicability should also be checked against the deployed architecture.

---

## [Medium][LOGIC-001] Validate and cap admin pagination parameters

## What happens

The admin user-list endpoint accepts unrestricted `page` and `pageSize` values. Zero or negative values generate invalid limits/offsets, while very large values can cause excessive database work and large responses.

## What should happen

`page` should be at least 1 and `pageSize` should have a small positive upper bound such as 100. Invalid values should receive HTTP 400, and the service should enforce bounds even if called outside the controller.

## Steps to reproduce

1. As an admin, request `/api/v1/admin/users?page=0&pageSize=-1` and observe a server/database error instead of a validation response.
2. Request the endpoint with an excessively large page size and observe that no application-level maximum prevents a large query/response.

## Environment

Spring Boot admin API; any browser/OS or API client; authenticated admin account.

---

## [Low][LOGIC-002] Handle unavailable browser storage in the theme hook

## What happens

The theme hook checks whether `window` exists but directly reads the global `localStorage`. Test and restrictive browser environments where storage is unavailable cause rendering to fail.

## What should happen

Theme initialization should access `window.localStorage` only after checking availability and should handle access errors by falling back to the system theme. Tests should provide a consistent storage mock.

## Steps to reproduce

1. Run `npm test -- --run` from `src/web` in the current environment.
2. Observe four failing chart tests with `Cannot read properties of undefined (reading 'getItem')` from `useTheme.tsx`.

## Environment

Vitest/jsdom under Node; reproduced during the audit on macOS. Similar failures are possible in browsers that block storage access.

---

## [Low][LOGIC-003] Replace generic IllegalArgumentException domain errors

## What happens

Several exam/domain state failures use `IllegalArgumentException`, while the global handler also has a broad `RuntimeException` catch-all. Spring currently resolves the more specific handler, but the structure is fragile and makes error semantics hard to maintain.

## What should happen

Expired sessions, invalid transitions, and question/session mismatches should use explicit domain exceptions with stable HTTP status mappings. The generic catch-all should remain visibly last and be reserved for unexpected failures.

## Steps to reproduce

1. Submit an answer to an expired exam or finish an exam with an invalid state in an API test.
2. Observe that unrelated domain failures are represented by the same generic `IllegalArgumentException` path rather than distinct, testable API errors.

## Environment

Spring Boot API and MVC tests; no browser dependency.

---

## [Low][SEC-011] Remove or replace the regex-based XSS sanitizer

## What happens

`InputSanitizer` strips a small set of regex patterns and is not capable of safely sanitizing HTML. It is currently unused, but its name and documentation may encourage future code to rely on it as an XSS defense.

## What should happen

The unused sanitizer should be removed or clearly restricted to non-security normalization. Inputs should be validated by expected shape and safely encoded when rendered. Any future HTML feature should use a maintained allowlist sanitizer.

## Steps to reproduce

1. Review `InputSanitizer` and its regex allow/deny behavior, or run its unit tests with encoded and malformed HTML variants.
2. Observe that the implementation only removes selected literal patterns and cannot provide general HTML sanitization guarantees.

## Environment

Spring Boot source/unit-test environment; no browser dependency. No current production caller was found.

---

## [Low][LOGIC-004] Remove duplicate dead security-header configuration

## What happens

`SecurityHeadersConfig` is retained as a configuration class with a non-bean method that duplicates the active header configuration in `SecurityConfig`. Changes made to the dead copy do not affect the running filter chain.

## What should happen

There should be one tested source of truth for API security headers. Dead duplicated configuration should be removed to prevent drift and mistaken fixes.

## Steps to reproduce

1. Change or debug the policy in `SecurityHeadersConfig.securityHeadersFilterChain` and start the application.
2. Observe that the method is not registered as a bean and the live headers still come from `SecurityConfig`.

## Environment

Spring Boot API source/configuration; no browser dependency except when inspecting response headers.
