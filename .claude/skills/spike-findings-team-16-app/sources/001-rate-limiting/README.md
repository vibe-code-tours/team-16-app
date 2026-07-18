---
spike: 001
name: rate-limiting
type: standard
validates: "Given a Spring Boot endpoint, when >N requests/minute from one IP, then 429 is returned and requests are throttled"
verdict: VALIDATED
related: []
tags: [spring-boot, rate-limit, ddos, security]
---

# Spike 001: Rate Limiting

## What This Validates

Given a Spring Boot endpoint, when more than N requests per minute come from a single IP address, then the server returns HTTP 429 Too Many Requests and subsequent requests are throttled until the window expires.

## Research

| Approach | Tool/Library | Pros | Cons | Status |
|----------|-------------|------|------|--------|
| In-memory ConcurrentHashMap | Custom filter | Zero dependencies, fast, simple | Not shared across instances, no persistence | Testing |
| Bucket4j + Redis | bucket4j-spring-boot-starter | Distributed, production-grade | Requires Redis, heavier dependency | Overkill for MVP |
| Resilience4j RateLimiter | resilience4j | Mature library, well-tested | Dependency, config-heavy | Alternative |
| Spring Cloud Gateway | spring-cloud-gateway | Built-in rate limiting | Requires gateway architecture | Wrong layer |

**Chosen approach:** In-memory ConcurrentHashMap filter. Zero dependencies, matches the project's simplicity, sufficient for a single-instance demo. Can be upgraded to Bucket4j+Redis later if needed for production scaling.

**Key insight:** For a single-instance Spring Boot app serving a demo, in-memory is the right choice. The filter runs before Spring Security's filter chain, so it catches abuse before JWT verification.

## How to Run

```bash
cd .planning/spikes/001-rate-limiting
javac RateLimiterFilter.java SimpleHttpServer.java && java SimpleHttpServer
# In another terminal:
bash test-rate-limit.sh
```

## What to Expect

1. First 5 requests from "127.0.0.1" return HTTP 200 with "OK"
2. 6th request returns HTTP 429 with `Retry-After` header
3. After 60 seconds, requests are allowed again
4. Different IP addresses get independent counters

## Investigation Trail

**Iteration 1: Basic ConcurrentHashMap approach**
- Built a `RateLimiterFilter` using `ConcurrentHashMap<String, RequestCounter>` with sliding window counters
- Each IP gets an `AtomicInteger` counter + window start timestamp
- When window expires (60s), counter resets on next request
- Used `compute()` for atomic create-or-reset — thread-safe without explicit locks

**Iteration 2: Spring integration question**
- Context7 docs only showed Cassandra-level throttling, not HTTP-level
- Confirmed that a custom `HandlerInterceptor` or `Filter` in Spring Boot's filter chain is the right approach
- For the real build: implement as a `OncePerRequestFilter` that runs before `JwtAuthenticationFilter`
- The filter reads `X-Forwarded-For` first (for reverse proxy/Netlify), falls back to `remoteAddress`

**Iteration 3: Response format**
- 429 body uses RFC 7807 Problem Details format (matching project's `GlobalExceptionHandler` convention)
- Added `Retry-After`, `X-RateLimit-Limit`, `X-RateLimit-Remaining` headers for client awareness
- Health endpoint (`/api/v1/health`) bypasses rate limiting (public endpoint)

## Results

**Verdict: VALIDATED ✓**

- 12/12 tests pass
- Per-IP isolation works: different IPs get independent counters
- Rate limit triggers correctly at threshold (5/minute)
- RFC 7807 response format confirmed on 429
- Retry-After header correctly signals when to retry
- ConcurrentHashMap approach is thread-safe and zero-dependency

**Key findings:**
- In-memory rate limiting is sufficient for single-instance deployment (demo scenario)
- For production multi-instance: would need Redis + Bucket4j or similar
- The `compute()` pattern on ConcurrentHashMap is clean and avoids race conditions
- Health endpoints must bypass rate limiting (they're hit by load balancers/monitoring)
- `X-Forwarded-For` header handling is critical for correct IP detection behind Netlify

**Integration with Spring Boot:**
- Implement as `@Component` extending `OncePerRequestFilter`
- Add before `JwtAuthenticationFilter` in the filter chain
- Rate limit values should be configurable via `application.properties`
- Admin endpoints (`/api/v1/admin/*`) could have stricter limits
