package com.nerdquiz.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.Ordered;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

/**
 * Per-IP sliding window rate limiter using ConcurrentHashMap.
 * Rejects requests exceeding the configured limit with RFC 7807 429 response.
 */
public class RateLimitFilter extends OncePerRequestFilter implements Ordered {

    @Override
    public int getOrder() {
        return Ordered.HIGHEST_PRECEDENCE + 10;
    }

    private static final Logger log = LoggerFactory.getLogger(RateLimitFilter.class);

    private final ConcurrentHashMap<String, RequestCounter> counters = new ConcurrentHashMap<>();
    private final int maxRequests;
    private final long windowMillis;

    public RateLimitFilter(
            @Value("${security.rate-limit.max-requests:60}") int maxRequests,
            @Value("${security.rate-limit.window-seconds:60}") long windowSeconds
    ) {
        this.maxRequests = maxRequests;
        this.windowMillis = windowSeconds * 1000;
    }

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain
    ) throws ServletException, IOException {

        String clientIp = getClientIp(request);
        long retryAfterSeconds = windowMillis / 1000;

        if (!tryAcquire(clientIp)) {
            log.debug("Rate limit exceeded for IP: {}", clientIp);

            response.setStatus(429);
            response.setContentType("application/problem+json");
            response.setHeader("Retry-After", String.valueOf(retryAfterSeconds));
            response.setHeader("X-RateLimit-Limit", String.valueOf(maxRequests));
            response.setHeader("X-RateLimit-Remaining", "0");
            response.getWriter().write(
                "{\"type\":\"urn:nerdquiz:rate-limit-exceeded\","
                + "\"title\":\"Rate Limit Exceeded\",\"status\":429,"
                + "\"detail\":\"Too many requests. Try again in " + retryAfterSeconds + " seconds.\"}"
            );
            return;
        }

        filterChain.doFilter(request, response);
    }

    /**
     * Try to acquire a request slot for the given client IP.
     * Uses ConcurrentHashMap.compute() for atomic create-or-reset (lock-free).
     */
    public boolean tryAcquire(String clientIp) {
        long now = System.currentTimeMillis();
        RequestCounter counter = counters.compute(clientIp, (key, existing) -> {
            if (existing == null || now - existing.windowStart.get() > windowMillis) {
                return new RequestCounter(now);
            }
            return existing;
        });
        return counter.count.incrementAndGet() <= maxRequests;
    }

    /**
     * Extract client IP from X-Forwarded-For header (first comma-separated value)
     * or fall back to remote address.
     */
    private String getClientIp(HttpServletRequest request) {
        String forwarded = request.getHeader("X-Forwarded-For");
        if (forwarded != null && !forwarded.isEmpty()) {
            return forwarded.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        return "/api/v1/health".equals(request.getRequestURI());
    }

    /**
     * Per-IP request counter with window start timestamp.
     */
    private static class RequestCounter {
        final AtomicLong count = new AtomicLong(0);
        final AtomicLong windowStart;

        RequestCounter(long windowStart) {
            this.windowStart = new AtomicLong(windowStart);
        }
    }
}
