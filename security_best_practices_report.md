# NerdQuiz Security and Logic Audit

## Executive summary

The review found **2 critical, 4 high, 5 medium, and 4 low** issues. The most urgent defects let any authenticated user mint arbitrary XP through two independent paths, allow a supposedly deactivated account to continue using the API, and expose exam answer keys before or during an exam. The custom JWT verifier also omits important claim validation.

This was a read-only source review of the React/Vite client, Spring Boot API, Supabase migrations/RLS, deployment configuration, and dependency manifests. No production runtime or live Supabase policies were tested, so deployed configuration should be verified separately.

## Critical

### SEC-001 — Arbitrary XP minting through the public API and Supabase RPC

- **Rule ID:** AUTHZ-BUSINESS-001
- **Severity:** Critical
- **Location:** `UserController.incrementXp`, `src/api/src/main/java/com/nerdquiz/controller/UserController.java:53`; `IncrementXpRequest`, `src/api/src/main/java/com/nerdquiz/dto/IncrementXpRequest.java:6`; `increment_user_xp`, `supabase/migrations/20260715012201_increment_user_xp.sql:1`
- **Evidence:** The authenticated API accepts a caller-selected nonnegative `delta` and adds it directly to `total_xp`. Independently, the `SECURITY DEFINER` function accepts the same arbitrary delta and is granted to every `authenticated` Supabase user.
- **Impact:** Any account can assign itself effectively unlimited XP, corrupting rankings, progress, analytics, and any authorization/reward decisions based on XP. Large values can also trigger integer overflow/database errors.
- **Fix:** Remove `/api/v1/me/xp` from client reach and revoke direct execution of `increment_user_xp` from `authenticated`. Award XP only inside server-side, idempotent completion transactions derived from validated quiz/lesson/exam events. Add a ledger with a unique event key.
- **Mitigation:** Until redesigned, cap deltas, rate-limit reward actions by user, and alert on abnormal XP changes. A cap alone does not prevent repeated abuse.
- **False-positive notes:** None; both paths are directly callable by authenticated users.

### SEC-002 — Account deactivation does not deactivate the account

- **Rule ID:** AUTHZ-STATE-001
- **Severity:** Critical
- **Location:** `AdminService.deactivateUser`, `src/api/src/main/java/com/nerdquiz/service/AdminService.java:317`; `JwtAuthenticationFilter.doFilterInternal`, `src/api/src/main/java/com/nerdquiz/config/JwtAuthenticationFilter.java:85`
- **Evidence:** The admin action changes only `role` to `deactivated`. The auth filter rejects only `is_active = false`; every non-admin role, including `deactivated`, receives `ROLE_USER` at lines 107–109.
- **Impact:** An admin can believe an account is disabled while that user retains normal authenticated API access and can continue reading and mutating data.
- **Fix:** Make deactivation update `is_active = false` atomically (and optionally keep role unchanged), reject both inactive and deactivated profiles in the filter, revoke Supabase refresh sessions, and add an integration test that the next request returns 401/403.
- **Mitigation:** Query for `is_active = true` when creating any authenticated principal.
- **False-positive notes:** If an untracked production trigger synchronizes `role` and `is_active`, verify it; no such trigger is present in this repository.

## High

### SEC-003 — Exam answer keys are disclosed before and during the exam

- **Rule ID:** DATA-EXPOSURE-001
- **Severity:** High
- **Location:** `QuestionService.toResponse`, `src/api/src/main/java/com/nerdquiz/service/QuestionService.java:52`; `ExamService.startExam`, `src/api/src/main/java/com/nerdquiz/service/ExamService.java:89`; `ExamService.submitAnswer`, `src/api/src/main/java/com/nerdquiz/service/ExamService.java:132`; `get_exam_questions`, `supabase/migrations/20260715012202_get_exam_questions.sql:1`
- **Evidence:** The common question DTO includes `correctAnswer` and `explanation`; exam start maps questions through it. Each submitted exam answer also returns the correct answer and explanation. The Supabase RPC returns complete `questions` rows and is granted to `anon`.
- **Impact:** Users can inspect the start response or call the anonymous RPC to obtain every answer, defeating exam-simulation scoring and analytics.
- **Fix:** Create separate DTOs: exam questions must omit answers/explanations until the session is irreversibly finished. Revoke the anonymous full-row RPC and expose a projection without answer fields. Keep practice-mode answer disclosure explicitly separate.
- **Mitigation:** Treat existing scores as untrusted until this is fixed.
- **False-positive notes:** Answer visibility may be intended for practice quizzes; it conflicts with the separate timed exam-simulation flow.

### SEC-004 — JWT verification validates the signature but not the token's full security context

- **Rule ID:** AUTHN-JWT-001
- **Severity:** High
- **Location:** `JwtUtil.verify`, `src/api/src/main/java/com/nerdquiz/config/JwtUtil.java:51`
- **Evidence:** Verification checks a present `kid`, signature, and expiration only when `exp` exists. It does not require `exp`, validate issuer (`iss`), audience (`aud`), not-before (`nbf`), issued-at bounds, or explicitly constrain the JWS algorithm before verifier selection.
- **Impact:** A signed token minted for a different audience/purpose, a token without expiry, or a not-yet-valid token may be accepted as an API session.
- **Fix:** Use Spring Security's OAuth2 Resource Server `JwtDecoder` configured from the exact Supabase issuer/JWKS, then add validators for issuer, expected audience, timestamps, and allowed algorithms. Require a UUID `sub`.
- **Mitigation:** Add claim-validation tests for wrong issuer/audience, missing expiry, future `nbf`, and unexpected algorithms.
- **False-positive notes:** Project-specific JWKS limits cross-project forgery, but does not replace purpose/audience and lifetime validation.

### SEC-005 — Exam answers can be changed and sequence/timing data can be forged

- **Rule ID:** BUSINESS-INTEGRITY-001
- **Severity:** High
- **Location:** `ExamService.submitAnswer`, `src/api/src/main/java/com/nerdquiz/service/ExamService.java:121`; `SubmitExamAnswerRequest`, `src/api/src/main/java/com/nerdquiz/dto/SubmitExamAnswerRequest.java:10`
- **Evidence:** Existing answers are loaded and overwritten rather than rejected. Client-supplied `sequenceNumber` and `responseTimeMs` are stored without matching them to the issued question sequence or server-observed time.
- **Impact:** A user can submit guesses, learn correctness from the response, overwrite incorrect answers, and finish with a perfect score; timing/sequence analytics are also untrustworthy.
- **Fix:** Make answers immutable with a database unique constraint and conflict response, compare against the server-persisted issued sequence, derive elapsed time server-side, and disclose correctness only after exam completion.
- **Mitigation:** Detect repeated updates and impossible response times in current data.
- **False-positive notes:** The behavior is acceptable only for an explicitly editable, open-book practice mode, not the timed exam flow.

### SEC-006 — Rate limiting is bypassable and consumes unbounded memory

- **Rule ID:** DOS-RATE-001
- **Severity:** High
- **Location:** `RateLimitFilter`, `src/api/src/main/java/com/nerdquiz/security/RateLimitFilter.java:30`, `:90`
- **Evidence:** The client key trusts the first `X-Forwarded-For` value without a trusted-proxy boundary. Arbitrary keys are retained forever in a `ConcurrentHashMap`; expired counters are replaced only when the same key returns. State is also per application instance.
- **Impact:** A caller can rotate spoofed header values to bypass throttling and grow heap until service degradation or outage. Multi-instance deployment further multiplies the allowed rate.
- **Fix:** Enforce limits at the trusted edge or use a bounded/distributed limiter. Configure Spring proxy-header handling for known proxies, use the normalized remote address, expire idle keys, cap map size, and apply user-based keys after authentication.
- **Mitigation:** Strip inbound forwarding headers at the load balancer and set strict request/header-size limits.
- **False-positive notes:** If the production edge overwrites rather than appends `X-Forwarded-For`, spoofing may be reduced, but the memory and per-instance issues remain.

## Medium

### SEC-007 — Profile email is caller-controlled instead of derived from the verified identity

- **Rule ID:** IDENTITY-INTEGRITY-001
- **Severity:** Medium
- **Location:** `UserProfileController.upsertProfile`, `src/api/src/main/java/com/nerdquiz/controller/UserProfileController.java:35`; `UpsertUserProfileRequest`, `src/api/src/main/java/com/nerdquiz/dto/UpsertUserProfileRequest.java:7`
- **Evidence:** Any authenticated user supplies the email persisted to their profile; the API does not obtain it from verified JWT claims or the auth provider.
- **Impact:** Users can impersonate another email in admin exports/UI, corrupt contact data, and undermine workflows that assume email ownership.
- **Fix:** Remove email from the request and derive it from a validated token claim or server-side Supabase Admin lookup. Track `email_verified` if relied upon.
- **Mitigation:** Label the field as unverified user input until migrated.
- **False-positive notes:** Lower impact if the field is purely decorative and never used for identity/contact decisions.

### SEC-008 — Production frontend lacks visible browser security headers

- **Rule ID:** REACT-HEADERS-001
- **Severity:** Medium
- **Location:** `netlify.toml:10`; `src/web/index.html:3`; backend `SecurityConfig.java:68`
- **Evidence:** Netlify sets only asset MIME types. CSP/HSTS/frame/referrer/permissions headers are configured on API responses, not on the separately hosted frontend document. The HTML contains inline styles, while the API CSP allows `unsafe-inline` scripts despite serving JSON.
- **Impact:** The UI lacks repository-visible CSP and clickjacking/referrer hardening; API headers do not protect a document served from another origin.
- **Fix:** Configure Netlify headers for `/*` (CSP, `frame-ancestors`, `nosniff`, referrer and permissions policies). Move inline styles to CSS so CSP can avoid `unsafe-inline`. Keep API headers minimal and appropriate for JSON.
- **Mitigation:** Verify actual deployed headers first; an external edge may already add them.
- **False-positive notes:** Runtime/edge configuration outside this repo could supply these headers.

### SEC-009 — Admin CSV export can still execute spreadsheet formulas and the UI export is unauthenticated

- **Rule ID:** CSV-INJECTION-001
- **Severity:** Medium
- **Location:** `AdminService.exportUsers`, `src/api/src/main/java/com/nerdquiz/service/AdminService.java:374`; `UserFilters`, `src/web/src/components/features/admin/UserFilters.tsx:40`
- **Evidence:** Only display name uses `escapeCsv`; email and other text fields are emitted unquoted/unescaped. The frontend uses `window.open('/api/...')`, which cannot attach the bearer token used by the API client.
- **Impact:** Crafted email/text can become a spreadsheet formula or break CSV structure when an admin opens the export. In normal bearer-auth deployment, the export button also receives 401/403 instead of a file.
- **Fix:** Apply RFC 4180 quoting plus formula neutralization to every cell, return `text/csv`, and download through authenticated `fetch` to a Blob URL.
- **Mitigation:** Warn admins to import as plain text.
- **False-positive notes:** Some spreadsheet clients disable formula execution, but it should not be assumed.

### SEC-010 — Dependency audit reports high-severity vulnerable packages

- **Rule ID:** SUPPLY-CHAIN-001
- **Severity:** Medium (context-adjusted)
- **Location:** `src/web/package-lock.json`; `src/web/package.json:17`
- **Evidence:** `npm audit --package-lock-only` reports GHSA-r28c-9q8g-f849 in PostCSS and GHSA-qwww-vcr4-c8h2 through `react-router-dom` 7.18.1.
- **Impact:** PostCSS can disclose source-map files when processing attacker-controlled CSS/source maps. The React Router advisory affects RSC action handling; this project is a Vite SPA and no RSC action use was found, so that path is likely not exploitable here.
- **Fix:** Upgrade to patched versions when available and rerun build/tests. Confirm the React Router advisory's applicability before accepting npm's suggested downgrade.
- **Mitigation:** Never run the build pipeline on untrusted CSS/source maps.
- **False-positive notes:** React Router RSC advisory likely does not apply to this architecture; retain as supply-chain tracking rather than a confirmed exploit.

### LOGIC-001 — Admin pagination is unbounded and accepts invalid ranges

- **Rule ID:** INPUT-BOUNDS-001
- **Severity:** Medium
- **Location:** `AdminController.getUsers`, `src/api/src/main/java/com/nerdquiz/controller/AdminController.java:39`; `AdminService.getUsers`, `src/api/src/main/java/com/nerdquiz/service/AdminService.java:153`
- **Evidence:** `page` and `pageSize` have no validation. Zero/negative values produce invalid offsets/limits; very large values can force huge queries and responses; offset arithmetic can overflow.
- **Impact:** An admin request can cause 500 errors or excessive database/heap work.
- **Fix:** Add `@Min(1)` to page and `@Min(1) @Max(100)` to page size, use long/checked offset arithmetic, and return 400 for invalid values.
- **Mitigation:** Enforce response/query limits at the service layer too.
- **False-positive notes:** Admin-only access lowers exploitability but not operational risk.

## Low

### LOGIC-002 — Frontend tests fail because localStorage availability is not checked

- **Rule ID:** CLIENT-ROBUSTNESS-001
- **Severity:** Low
- **Location:** `src/web/src/hooks/useTheme.tsx:20`
- **Evidence:** The hook checks `window` but directly accesses global `localStorage`. Four tests fail with `Cannot read properties of undefined (reading 'getItem')`.
- **Impact:** Tests are not clean and restrictive browser/storage contexts can break theme initialization.
- **Fix:** Access `window.localStorage` behind capability/error handling and mock it consistently in test setup.
- **Mitigation:** None needed beyond fixing the test environment and hook.
- **False-positive notes:** Production browsers normally provide storage, but privacy/security settings can make access throw.

### LOGIC-003 — Generic exception handler ordering makes IllegalArgumentException handling fragile

- **Rule ID:** ERROR-MAPPING-001
- **Severity:** Low
- **Location:** `GlobalExceptionHandler`, `src/api/src/main/java/com/nerdquiz/exception/GlobalExceptionHandler.java:159`, `:170`
- **Evidence:** A `RuntimeException` handler is declared before the more specific `IllegalArgumentException` handler. Spring normally resolves by type specificity rather than source order, but the layout is misleading and several domain state errors are represented as generic `IllegalArgumentException`.
- **Impact:** Future handler changes can accidentally turn client/state errors into 500 responses; semantics are difficult to maintain.
- **Fix:** Use explicit domain exceptions (expired session, invalid status, question mismatch) with stable 4xx mappings and keep the catch-all last.
- **Mitigation:** Add MVC tests for every error mapping.
- **False-positive notes:** Current Spring resolution should choose the more specific handler, so this is maintainability risk rather than a confirmed current failure.

### SEC-011 — Regex-based XSS sanitizer provides a false sense of safety

- **Rule ID:** INPUT-SANITIZATION-001
- **Severity:** Low
- **Location:** `InputSanitizer`, `src/api/src/main/java/com/nerdquiz/security/InputSanitizer.java:18`
- **Evidence:** The sanitizer strips a small regex list and cannot safely sanitize HTML. No production callers were found, and React's escaped rendering currently limits impact.
- **Impact:** A future developer may rely on it for HTML and introduce stored XSS through bypass variants.
- **Fix:** Delete the unused class or clearly prohibit HTML use. Validate field shape server-side and encode at the output context; if HTML is required, use a maintained allowlist sanitizer.
- **Mitigation:** Keep `react-markdown` raw HTML disabled and do not add `rehype-raw` without sanitization.
- **False-positive notes:** Not currently exploitable because no usage or raw HTML render path was found.

### LOGIC-004 — Duplicate/incorrect security-header configuration is retained as dead code

- **Rule ID:** CONFIG-DRIFT-001
- **Severity:** Low
- **Location:** `SecurityHeadersConfig`, `src/api/src/main/java/com/nerdquiz/security/SecurityHeadersConfig.java:17`
- **Evidence:** The class is annotated `@Configuration` but its method is not a bean and duplicates the live configuration, including `unsafe-inline` script policy.
- **Impact:** Future fixes can be applied to the wrong copy, producing security configuration drift.
- **Fix:** Remove the dead class and keep one tested source of truth.
- **Mitigation:** Add response-header integration tests against the actual filter chain.
- **False-positive notes:** The dead method does not currently create a second filter chain.

## Verification performed

- `src/api/./gradlew test`: **passed**.
- `src/web/npm run build`: **passed**.
- `src/web/npm test -- --run`: **142 passed, 4 failed** (theme/localStorage issue above).
- `src/web/npm audit --package-lock-only --json`: **3 high advisories** (two package entries are the same React Router chain).
- Secret-oriented tracked-file review found only `.env.example`; no committed private key file was identified. This is not a historical secret scan.

## Recommended remediation order

1. Close both arbitrary-XP paths (SEC-001).
2. Correct deactivation semantics and revoke active sessions (SEC-002).
3. Separate practice/exam DTOs and make exam submissions immutable (SEC-003, SEC-005).
4. Replace custom JWT validation with a fully validated resource-server decoder (SEC-004).
5. Move rate limiting to a trusted bounded/distributed layer (SEC-006).
6. Address identity, CSV, frontend headers, bounds, and dependency upgrades.
