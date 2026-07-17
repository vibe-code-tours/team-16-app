import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Spike 001: In-memory per-IP rate limiter.
 *
 * Uses a sliding window counter approach:
 * - Each IP gets a counter + window start timestamp
 * - When window expires (60s), counter resets
 * - When counter exceeds limit (5 req/min), reject with 429
 *
 * Thread-safe via ConcurrentHashMap + AtomicInteger.
 * Production version would use a Spring HandlerInterceptor or Filter.
 */
public class RateLimiterFilter {

    private final int maxRequests;
    private final long windowMillis;
    private final ConcurrentHashMap<String, RequestCounter> counters = new ConcurrentHashMap<>();

    public RateLimiterFilter(int maxRequests, long windowMillis) {
        this.maxRequests = maxRequests;
        this.windowMillis = windowMillis;
    }

    /**
     * Check if a request from the given IP is allowed.
     * Returns true if allowed, false if rate-limited.
     */
    public boolean tryAcquire(String clientIp) {
        long now = System.currentTimeMillis();
        RequestCounter counter = counters.compute(clientIp, (key, existing) -> {
            if (existing == null || now - existing.windowStart > windowMillis) {
                return new RequestCounter(now);
            }
            return existing;
        });

        int current = counter.count.incrementAndGet();
        return current <= maxRequests;
    }

    /**
     * Get seconds until the rate limit window resets for this IP.
     * Returns 0 if not rate-limited.
     */
    public long getRetryAfterSeconds(String clientIp) {
        RequestCounter counter = counters.get(clientIp);
        if (counter == null) return 0;
        long elapsed = System.currentTimeMillis() - counter.windowStart;
        long remaining = windowMillis - elapsed;
        return remaining > 0 ? (remaining / 1000) + 1 : 0;
    }

    /**
     * Get current count for an IP (for testing/debugging).
     */
    public int getCount(String clientIp) {
        RequestCounter counter = counters.get(clientIp);
        return counter != null ? counter.count.get() : 0;
    }

    /**
     * Simple counter with window timestamp.
     */
    static class RequestCounter {
        final long windowStart;
        final AtomicInteger count;

        RequestCounter(long windowStart) {
            this.windowStart = windowStart;
            this.count = new AtomicInteger(0);
        }
    }
}
