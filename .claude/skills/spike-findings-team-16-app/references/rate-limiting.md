# Rate Limiting & DDoS Protection

## Requirements

- Must work with Spring Boot 3.x (Java 25) backend
- Rate limiting must be per-IP, not global
- Must not break existing Supabase Auth flow
- All security measures must return RFC 7807 Problem Details format on rejection
- Health endpoints must bypass rate limiting (load balancers/monitoring hit these)

## How to Build It

**1. Create `RateLimitFilter.java` as a Spring `OncePerRequestFilter`:**

```java
@Component
public class RateLimitFilter extends OncePerRequestFilter {

    private final ConcurrentHashMap<String, RequestCounter> counters = new ConcurrentHashMap<>();
    private final int maxRequests;  // configurable via application.properties
    private final long windowMillis;

    // Use compute() for atomic create-or-reset — thread-safe without explicit locks
    public boolean tryAcquire(String clientIp) {
        long now = System.currentTimeMillis();
        RequestCounter counter = counters.compute(clientIp, (key, existing) -> {
            if (existing == null || now - existing.windowStart > windowMillis) {
                return new RequestCounter(now);
            }
            return existing;
        });
        return counter.count.incrementAndGet() <= maxRequests;
    }
}
```

**2. Add to Spring Security filter chain BEFORE JwtAuthenticationFilter:**

```java
// In SecurityConfig.java
.addFilterBefore(rateLimitFilter, JwtAuthenticationFilter.class)
.addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class);
```

**3. Configure in `application.properties`:**

```properties
security.rate-limit.max-requests=60
security.rate-limit.window-seconds=60
```

**4. Handle X-Forwarded-For for IP detection behind Netlify:**

```java
private String getClientIp(HttpServletRequest request) {
    String forwarded = request.getHeader("X-Forwarded-For");
    if (forwarded != null && !forwarded.isEmpty()) {
        return forwarded.split(",")[0].trim();
    }
    return request.getRemoteAddr();
}
```

**5. Return RFC 7807 on rejection:**

```java
// In the filter, when rate limited:
response.setStatus(429);
response.setHeader("Retry-After", String.valueOf(retryAfterSeconds));
response.setHeader("X-RateLimit-Limit", String.valueOf(maxRequests));
response.setHeader("X-RateLimit-Remaining", "0");
response.setContentType("application/problem+json");
response.getWriter().write("{\"type\":\"urn:nerdquiz:rate-limit-exceeded\","
    + "\"title\":\"Rate Limit Exceeded\",\"status\":429,"
    + "\"detail\":\"Too many requests. Try again in " + retryAfterSeconds + " seconds.\"}");
```

## What to Avoid

- **Don't use Redis for MVP.** In-memory ConcurrentHashMap is sufficient for single-instance demo. Redis adds operational complexity for no benefit at this scale.
- **Don't rate-limit health endpoints.** Load balancers and monitoring tools hit `/api/v1/health` frequently — rate limiting them causes false alarms.
- **Don't use `synchronized` blocks.** ConcurrentHashMap + AtomicInteger is lock-free and handles concurrent requests correctly.
- **Don't forget to clean up expired entries.** Without periodic cleanup, the map grows unbounded. Add a scheduled task or use a cache with TTL (Caffeine, Guava).
- **Don't match on `"` in patterns.** Discovered during spike 003 — double quotes are valid JSON syntax and cause 100% false positive rate.

## Constraints

- In-memory only — not shared across multiple app instances
- For production multi-instance: upgrade to Bucket4j + Redis
- Window size of 60 seconds is a good default for API endpoints
- 60 requests/minute per IP is appropriate for normal use; admin endpoints could have stricter limits (10/minute)

## Origin

Synthesized from spikes: 001
Source files available in: sources/001-rate-limiting/
