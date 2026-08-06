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
    private final int maxTrackedClients;
    private final AtomicLong requestSequence = new AtomicLong();

    public RateLimitFilter(
            @Value("${security.rate-limit.max-requests:60}") int maxRequests,
            @Value("${security.rate-limit.window-seconds:60}") long windowSeconds
    ) {
        this(maxRequests, windowSeconds, 10_000);
    }

    public RateLimitFilter(int maxRequests, long windowSeconds, int maxTrackedClients) {
        if (maxRequests < 1 || windowSeconds < 1 || maxTrackedClients < 1) {
            throw new IllegalArgumentException("Rate-limit settings must be positive");
        }
        this.maxRequests = maxRequests;
        this.windowMillis = windowSeconds * 1000;
        this.maxTrackedClients = maxTrackedClients;
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
            log.debug("Rate limit exceeded for client");

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
        if ((requestSequence.incrementAndGet() & 255) == 0 || counters.size() >= maxTrackedClients) {
            counters.entrySet().removeIf(entry -> now - entry.getValue().windowStart > windowMillis);
        }
        if (!counters.containsKey(clientIp)) {
            synchronized (counters) {
                if (!counters.containsKey(clientIp)) {
                    counters.entrySet().removeIf(
                            entry -> now - entry.getValue().windowStart > windowMillis);
                    if (counters.size() >= maxTrackedClients) {
                        log.warn("Rate-limit client capacity reached; rejecting untracked client");
                        return false;
                    }
                    counters.put(clientIp, new RequestCounter(now));
                }
            }
        }
        RequestCounter counter = counters.compute(clientIp, (key, existing) -> {
            if (existing == null || now - existing.windowStart > windowMillis) {
                return new RequestCounter(now);
            }
            return existing;
        });
        return counter.count.incrementAndGet() <= maxRequests;
    }

    /**
     * Uses the servlet container's remote address. Forwarded headers are intentionally
     * ignored unless a trusted edge/container is configured to normalize remoteAddr.
     */
    private String getClientIp(HttpServletRequest request) {
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
        final long windowStart;

        RequestCounter(long windowStart) {
            this.windowStart = windowStart;
        }
    }

    int trackedClientCount() {
        return counters.size();
    }
}
