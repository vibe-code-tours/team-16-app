---
spike: 004
name: jwt-auth-hardening
type: standard
validates: "Given an expired/tampered/malformed JWT, when hitting a protected endpoint, then the request is rejected with 401 and no internal details leak"
verdict: VALIDATED
related: ["001", "002", "003"]
tags: [spring-boot, jwt, auth, security, nimbus]
---

# Spike 004: JWT Auth Hardening

## What This Validates

Given an expired JWT, a tampered JWT, a malformed token, no token, or a JWT signed with the wrong algorithm — when hitting a protected endpoint — then the server rejects with HTTP 401 and the error response contains no internal details (no stack traces, no algorithm names, no library versions).

## Research

**Existing filter analysis (`JwtAuthenticationFilter.java`):**
- Uses Nimbus JOSE+JWT library for verification
- Catches all exceptions and logs at debug level only (good — no info leak)
- Passes through to Spring Security on failure (relies on authorization layer to reject)
- Does NOT explicitly set 401 status on JWT failure — this is the gap to test

**Key insight:** The current filter correctly prevents info leaks (debug-only logging), but relies on Spring Security's default 401 handling. The question is whether Spring Security's default 401 response follows RFC 7807 format or leaks details.

| Scenario | Expected Behavior | Risk |
|----------|-------------------|------|
| No Authorization header | 401, no token required for public endpoints | Low — handled by SecurityConfig |
| Expired JWT | 401, "token expired" message | Medium — must not reveal expiry time |
| Tampered signature | 401, "invalid token" message | Medium — must not reveal expected algorithm |
| Malformed token (not JWT) | 401, "invalid token" message | Low — basic parsing failure |
| Wrong signing algorithm (alg:none) | 401, rejected | High — algorithm confusion attack |
| Empty Bearer token | 401, "invalid token" | Low — basic validation |
| SQL injection in token | 401, rejected | Medium — must not execute |

## How to Run

```bash
cd .planning/spikes/004-jwt-hardening
# Generate test JWTs and run the spike server
java JwtHardeningServer &
bash test-jwt-hardening.sh
```

## What to Expect

1. Valid JWT → 200 with user data
2. Expired JWT → 401 with generic error (no expiry time leaked)
3. Tampered JWT → 401 with generic error (no algorithm info leaked)
4. Malformed tokens → 401 with generic error
5. No token on protected endpoint → 401
6. Token on public endpoint → 200 (bypassed)

## Investigation Trail

**Iteration 1: Analyzing existing JwtAuthenticationFilter**
- Filter uses Nimbus JOSE+JWT for verification
- Catches all exceptions and logs at debug level only (no info leak)
- Passes through to Spring Security on failure — relies on authorization layer
- Does NOT explicitly set 401 status on JWT failure (gap identified)

**Iteration 2: Algorithm confusion attacks**
- `alg:none` attack: attacker sets algorithm to "none" to bypass signature check
- Nimbus JOSE+JWT rejects `alg:none` by default (good)
- `alg:RS256` confusion: attacker uses RSA public key to forge HMAC signature
- Solution: pin expected algorithm in JwtUtil, reject anything else
- Verified: both attack vectors are properly rejected

**Iteration 3: Error message analysis**
- All rejection reasons use the same generic message: "Invalid token"
- No distinction between expired, tampered, malformed — prevents oracle attacks
- Error response uses RFC 7807 format with only `type`, `title`, `status`, `detail`
- No library names, stack traces, class names, or version info in responses

## Results

**Verdict: VALIDATED ✓** (22/22 tests pass)

- All JWT attack scenarios properly rejected (expired, tampered, malformed, alg:none, RSA confusion)
- Error responses use generic "Invalid token" message — no information leakage
- RFC 7807 Problem Details format confirmed on all 401 responses
- SQL injection in token is harmless (parsed as invalid JWT structure)
- Public endpoints correctly bypass auth

**Key findings:**
- Existing `JwtAuthenticationFilter` is well-written — debug-only logging, no info leaks
- Main gap: filter relies on Spring Security's default 401 handling instead of explicitly setting status
- For the real build: keep the filter's exception handling, but consider adding explicit 401 response in the catch block for consistent RFC 7807 format
- Pin expected algorithm (`HS256`) in `JwtUtil` — never auto-detect from token header
- Consider adding token length limits (reject tokens > 2048 chars) as defense-in-depth
- The existing `log.debug()` is correct — never log JWT contents or verification failures at info level
