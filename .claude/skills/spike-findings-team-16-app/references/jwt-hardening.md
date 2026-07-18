# JWT Authentication Hardening

## Requirements

- Must work with Spring Boot 3.x (Java 25) backend
- Must not break existing Supabase Auth flow
- All security measures must return RFC 7807 Problem Details format on rejection
- Error responses must not leak internal details (library names, algorithms, timestamps)

## How to Build It

**1. Pin expected algorithm in `JwtUtil.java`:**

```java
// NEVER auto-detect algorithm from token header
// Always verify against the expected algorithm
JWSVerifier verifier = new MACSigner(secretKey);  // Forces HS256
SignedJWT jwt = SignedJWT.parse(token);
JWTClaimsSet claims = jwt.verify(verifier) ? jwt.getJWTClaimsSet() : null;
```

**2. Add explicit 401 response in `JwtAuthenticationFilter.java` catch block:**

```java
} catch (Exception e) {
    log.debug("JWT verification failed: {}", e.getMessage());  // Debug only — no info leak
    SecurityContextHolder.clearContext();

    // Add explicit 401 response (currently relies on Spring Security default)
    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    response.setContentType("application/problem+json");
    response.getWriter().write(
        "{\"type\":\"urn:nerdquiz:unauthorized\","
        + "\"title\":\"Unauthorized\",\"status\":401,"
        + "\"detail\":\"Invalid or expired token\"}"
    );
    return;  // Don't call filterChain.doFilter — request is rejected
}
```

**3. Use generic error messages — never reveal why the token failed:**

| Attack | What NOT to say | What to say |
|--------|-----------------|-------------|
| Expired token | "Token expired at 2026-07-15T10:00:00Z" | "Invalid or expired token" |
| Tampered signature | "Signature does not match HMAC-SHA256" | "Invalid or expired token" |
| Wrong algorithm | "Expected HS256, got RS256" | "Invalid or expired token" |
| alg:none attack | "Algorithm 'none' is not allowed" | "Invalid or expired token" |

**4. Add token length limit as defense-in-depth:**

```java
private static final int MAX_TOKEN_LENGTH = 2048;

if (token.length() > MAX_TOKEN_LENGTH) {
    log.debug("Token exceeds maximum length");
    // Reject — don't even try to parse
}
```

**5. Log at debug level only — never log JWT contents:**

```java
// CORRECT
log.debug("JWT verification failed: {}", e.getMessage());

// WRONG — never do this
log.info("JWT verification failed for token: {}", token);
log.warn("JWT payload: {}", jwt.getJWTClaimsSet().toString());
```

## What to Avoid

- **Don't auto-detect algorithm from JWT header.** The `alg:none` attack works by setting the header algorithm to "none" — if the server auto-detects, it skips signature verification. Pin `HS256` explicitly.
- **Don't distinguish between expired vs tampered in error messages.** Attackers use different error messages as an oracle to learn which attack vector works.
- **Don't log JWT contents, even at debug level.** The `sub` claim contains the user ID — logging it violates the "never log PII" rule.
- **Don't rely on Spring Security's default 401 handling.** It may not return RFC 7807 format. Set the response explicitly in the filter.
- **Don't forget to call `return` after sending 401.** If you call `filterChain.doFilter()` after setting 401, the request continues processing.

## Constraints

- Nimbus JOSE+JWT rejects `alg:none` by default — no extra configuration needed
- Pin `HS256` in `JwtUtil` — the only algorithm Supabase uses for JWT signing
- Token length limit of 2048 is generous — real Supabase JWTs are ~500 chars
- `log.debug()` is correct — never escalate to `log.info()` for auth failures

## Origin

Synthesized from spikes: 004
Source files available in: sources/004-jwt-hardening/
