---
spike: 003
name: input-validation-hardening
type: standard
validates: "Given malicious input (SQL injection, XSS payloads), when hitting any endpoint, then requests are rejected cleanly with 400 or 403"
verdict: VALIDATED
related: ["001", "002"]
tags: [spring-boot, security, input-validation, sql-injection, xss]
---

# Spike 003: Input Validation Hardening

## What This Validates

Given malicious input — SQL injection strings, XSS payloads, path traversal attempts, oversized payloads — when hitting API endpoints, then the server rejects them cleanly with appropriate HTTP status codes and no information leakage.

## Research

| Approach | Tool/Library | Pros | Cons | Status |
|----------|-------------|------|------|--------|
| Jakarta @Valid + Bean Validation | spring-boot-starter-validation | Already in project, annotation-driven | Only validates structure, not content | Baseline |
| Custom sanitizer (OWASP-style) | Manual | Catches XSS in free-text fields | Must maintain per-field rules | Testing |
| Regex-based input filtering | Manual | Catches known patterns | Brittle, false positives | Testing |
| Supabase RLS (database level) | Supabase | Defense-in-depth, SQL injection impossible via RLS | Only covers data access, not input | Reference |

**Chosen approach:** Multi-layer defense:
1. Jakarta `@Valid` for structural validation (already in project)
2. Custom `InputSanitizer` for XSS in free-text fields (project-specific)
3. Spring's default rejection of malformed JSON (built-in)
4. Supabase RLS as final backstop (SQL injection impossible at DB level)

**Key insight:** JPA parameterized queries prevent SQL injection at the ORM level. The real risk is XSS in rendered content and oversized payloads causing DoS.

## How to Run

```bash
cd .planning/spikes/003-input-validation
javac InputValidationServer.java && java InputValidationServer
# In another terminal:
bash test-input-validation.sh
```

## What to Expect

1. SQL injection strings in query params → 400 Bad Request
2. XSS payloads in body → sanitized or rejected
3. Oversized payloads → 413 Payload Too Large
4. Malformed JSON → 400 with clear error message
5. Path traversal attempts → 403 Forbidden

## Investigation Trail

**Iteration 1: Naive SQL injection pattern**
- Initial pattern included `"` (double quote) as SQL injection indicator
- Result: every JSON body matched — 100% false positive rate
- Lesson: never match on characters that are valid syntax in the input format

**Iteration 2: Refined SQL injection pattern**
- Removed double quotes, focused on SQL-specific constructs: `' OR 1=1`, `UNION SELECT`, `;DROP TABLE`, `--` (comment marker)
- Pattern: `'\\s*(or|and)\\s+\\d|--\\s*$|;\\s*(drop|delete|insert|update|select)\\b|union\\s+select|...`
- All 3 SQL injection tests pass, valid JSON passes through

**Iteration 3: Shell quoting issues**
- curl with special chars (`'`, `<`, `>`) in URLs caused shell interpretation errors
- Solution: use `--data-urlencode` with `-G` flag for query params, `--data-raw` for body
- Oversized payload test required writing to file (shell arg length limit)

**Iteration 4: Path traversal via HTTP path normalization**
- `../../etc/passwd` in URL path gets normalized by HTTP libraries
- Solution: test with URL-encoded paths (`%2F..%2F..%2F`) which bypass normalization
- Server-side check uses `contains("..")` to catch both raw and encoded variants

## Results

**Verdict: VALIDATED ✓** (17/17 tests pass)

- SQL injection patterns correctly block `' OR 1=1--`, `UNION SELECT`, `;DROP TABLE`
- XSS patterns correctly block `<script>`, `javascript:`, `onerror=` event handlers
- Path traversal blocked with both encoded and double-encoded attempts
- Oversized payloads (200KB) rejected with 413
- Malformed JSON rejected with 400
- Valid input passes through without false positives
- All error responses use RFC 7807 Problem Details format

**Key findings:**
- Never match on `"` in SQL injection patterns — it's valid JSON syntax
- JPA parameterized queries are the primary SQL injection defense; input patterns are defense-in-depth
- XSS patterns should be per-field (free-text fields only), not global
- Path traversal must check for `..` in filename components, not just URL-encoded variants
- For the real build: use Jakarta `@Size`, `@Pattern` annotations for structural validation, plus a custom `InputSanitizer` component for XSS in free-text fields
- Spring Boot's `server.tomcat.max-http-form-post-size` handles payload size limits natively
