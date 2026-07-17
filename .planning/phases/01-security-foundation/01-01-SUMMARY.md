---
phase: 01-security-foundation
plan: 01
subsystem: security
tags: [jwt, xss, migration, admin-seed]
dependency_graph:
  requires: []
  provides: [JwtUtil, JwtAuthenticationFilter, InputSanitizer, is_active migration]
  affects: [src/api, supabase/migrations]
tech_stack:
  added: []
  patterns: [RFC-7807-problem-details, regex-xss-sanitization, JWT-length-guard]
key_files:
  created:
    - supabase/migrations/20260717000000_add_is_active_and_seed_admin.sql
    - src/api/src/test/java/com/nerdquiz/config/JwtUtilTest.java
    - src/api/src/main/java/com/nerdquiz/security/InputSanitizer.java
    - src/api/src/test/java/com/nerdquiz/security/InputSanitizerTest.java
  modified:
    - src/api/src/main/java/com/nerdquiz/config/JwtUtil.java
    - src/api/src/main/java/com/nerdquiz/config/JwtAuthenticationFilter.java
decisions:
  - "Regex extended to cover closing tags (</?script, </?iframe, etc.) — original spike pattern only matched opening tags"
  - "Null/empty token throws IllegalArgumentException rather than SecurityException to distinguish from tampered tokens"
  - "InputSanitizer regex uses </? prefix for all HTML tags to catch both opening and closing variants"
metrics:
  duration: "15 minutes"
  tasks_completed: 3
  files_created: 4
  files_modified: 2
completed_date: "2026-07-17"
---

# Phase 01 Plan 01: JWT Hardening, InputSanitizer, Admin Seed Migration Summary

Database migration for is_active column and admin seed, JWT hardening (token length limit + RFC 7807 401), and InputSanitizer for XSS defense-in-depth.

## What Was Built

### 1. Database Migration (Task 1)
- `supabase/migrations/20260717000000_add_is_active_and_seed_admin.sql` adds `is_active BOOLEAN NOT NULL DEFAULT true` to `user_profiles`
- Seeds an admin user with `role='admin', is_active=true` using `ON CONFLICT` for idempotent application
- Placeholder `<FOUNDER_UUID>` must be replaced with the actual founder user ID before applying

### 2. JWT Hardening (Task 2)
- **JwtUtil.java**: Added `MAX_TOKEN_LENGTH = 2048` constant; tokens exceeding this length are rejected immediately with `SecurityException("Invalid token")` before any JWKS fetch or parsing
- **JwtAuthenticationFilter.java**: Catch block now writes an explicit 401 response with `application/problem+json` Content-Type and RFC 7807 body containing `type`, `title`, `status`, `detail` fields. Returns immediately after writing (no `filterChain.doFilter`). Log.debug contains only `e.getMessage()` — no token contents or user ID (PII)
- **JwtUtilTest.java**: 5 test methods covering token length rejection, null token, empty token, boundary at 2048, and just-over-2048

### 3. InputSanitizer (Task 3)
- **InputSanitizer.java**: `@Component` with `sanitize(String)` and `isSafe(String)` methods
- Regex pattern strips `<script>`, `</script>`, `javascript:`, `on*=`, `<iframe>`, `<object>`, `<embed>`, `<form>` (and closing variants)
- Does NOT match double quotes (per spike finding: avoids JSON false positives)
- **InputSanitizerTest.java**: 10 test methods covering XSS payloads, null handling, and clean text passthrough

## Deviations from Plan

### Regex Pattern Adjustment

- **Found during:** Task 3
- **Issue:** Original spike regex `<script[^>]*>` only matched opening `<script>` tags, not closing `</script>` tags
- **Fix:** Extended regex to `</?script[^>]*>|...|</?iframe|</?object|</?embed|</?form` to handle both opening and closing HTML tags
- **Files modified:** `src/api/src/main/java/com/nerdquiz/security/InputSanitizer.java`

### Gradle Task Name

- **Found during:** Task 2
- **Issue:** `-x spotbugsMain` flag in the plan's verification command does not exist in this Gradle project
- **Fix:** Ran tests without the `-x spotbugsMain` flag; all tests pass
- **Impact:** None on deliverables

## Auth Gates

None — no authentication was required during execution.

## Threat Flags

| Flag | File | Description |
|------|------|-------------|
| threat_flag: JWT validation | JwtUtil.java | MAX_TOKEN_LENGTH constant controls token rejection threshold |
| threat_flag: 401 response | JwtAuthenticationFilter.java | Explicit RFC 7807 response replaces Spring Security default handling |
| threat_flag: XSS defense | InputSanitizer.java | Regex-based XSS stripping as defense-in-depth layer |

## Verification Evidence

- JwtUtilTest: 5/5 pass
- InputSanitizerTest: 10/10 pass
- Full backend test suite: all pass (BUILD SUCCESSFUL)
- Backend compilation: clean

## Self-Check: PASSED

### Created Files Exist
- [x] supabase/migrations/20260717000000_add_is_active_and_seed_admin.sql
- [x] src/api/src/main/java/com/nerdquiz/config/JwtUtil.java (modified)
- [x] src/api/src/main/java/com/nerdquiz/config/JwtAuthenticationFilter.java (modified)
- [x] src/api/src/main/java/com/nerdquiz/security/InputSanitizer.java
- [x] src/api/src/test/java/com/nerdquiz/config/JwtUtilTest.java
- [x] src/api/src/test/java/com/nerdquiz/security/InputSanitizerTest.java

### Commits Exist
- [x] 688a85a: test(01-01): add is_active column and seed admin migration
- [x] 7fde160: feat(01-01): harden JWT with token length limit and RFC 7807 401 response
- [x] fb693e9: feat(01-01): create InputSanitizer for XSS defense-in-depth
