import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

/**
 * Spike 001: Minimal HTTP server demonstrating per-IP rate limiting.
 *
 * Run: javac RateLimiterFilter.java SimpleHttpServer.java && java SimpleHttpServer
 * Test: bash test-rate-limit.sh
 *
 * - GET /api/v1/health → always 200 (public, not rate-limited)
 * - GET /api/v1/topics → rate-limited at 5 requests per 60 seconds per IP
 * - Returns RFC 7807 Problem Details on 429 (matching project convention)
 */
public class SimpleHttpServer {

    private static final int PORT = 9999;
    private static final int RATE_LIMIT = 5;
    private static final long WINDOW_SECONDS = 60;

    // Only rate-limit /api/v1/topics (simulating protected endpoint)
    private static final String RATE_LIMITED_PATH = "/api/v1/topics";

    public static void main(String[] args) throws IOException {
        RateLimiterFilter rateLimiter = new RateLimiterFilter(RATE_LIMIT, WINDOW_SECONDS * 1000);

        HttpServer server = createServer(rateLimiter);
        server.start();
        System.out.println("=== Spike 001: Rate Limiter running on port " + PORT + "===");
        System.out.println("Rate limit: " + RATE_LIMIT + " requests per " + WINDOW_SECONDS + "s per IP");
        System.out.println("Test with: bash test-rate-limit.sh");
        System.out.println("Endpoints:");
        System.out.println("  GET /api/v1/health  → always 200 (public, no rate limit)");
        System.out.println("  GET /api/v1/topics  → rate-limited, returns 429 when exceeded");
    }

    private static HttpServer createServer(RateLimiterFilter rateLimiter) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress(PORT), 0);

        // Health endpoint — no rate limiting (public)
        server.createContext("/api/v1/health", exchange -> {
            String json = "{\"status\":\"UP\",\"service\":\"nerdquiz-spike\"}";
            sendResponse(exchange, 200, json);
        });

        // Topics endpoint — rate limited
        server.createContext(RATE_LIMITED_PATH, exchange -> {
            String clientIp = getClientIp(exchange);

            if (rateLimiter.tryAcquire(clientIp)) {
                String json = "{\"topics\":[{\"id\":\"1\",\"name\":\"Technology\"},{\"id\":\"2\",\"name\":\"Security\"}]}";
                String countHeader = "X-RateLimit-Remaining: " + (RATE_LIMIT - rateLimiter.getCount(clientIp));
                sendResponse(exchange, 200, json, countHeader);
            } else {
                long retryAfter = rateLimiter.getRetryAfterSeconds(clientIp);
                String problemDetails = String.format(
                    "{\"type\":\"urn:nerdquiz:rate-limit-exceeded\","
                    + "\"title\":\"Rate Limit Exceeded\","
                    + "\"status\":429,"
                    + "\"detail\":\"Too many requests from %s. Try again in %d seconds.\"}",
                    clientIp, retryAfter
                );
                String headers = "Retry-After: " + retryAfter
                    + "\nX-RateLimit-Limit: " + RATE_LIMIT
                    + "\nX-RateLimit-Remaining: 0";
                sendResponse(exchange, 429, problemDetails, headers);
            }
        });

        return server;
    }

    private static String getClientIp(HttpExchange exchange) {
        // In production, check X-Forwarded-For first (behind reverse proxy)
        String forwarded = exchange.getRequestHeaders().getFirst("X-Forwarded-For");
        if (forwarded != null && !forwarded.isEmpty()) {
            return forwarded.split(",")[0].trim();
        }
        return exchange.getRemoteAddress().getAddress().getHostAddress();
    }

    private static void sendResponse(HttpExchange exchange, int status, String body) throws IOException {
        sendResponse(exchange, status, body, null);
    }

    private static void sendResponse(HttpExchange exchange, int status, String body, String extraHeaders) throws IOException {
        byte[] bytes = body.getBytes("UTF-8");
        exchange.getResponseHeaders().set("Content-Type", "application/problem+json");
        if (extraHeaders != null) {
            for (String line : extraHeaders.split("\n")) {
                String[] parts = line.split(": ", 2);
                if (parts.length == 2) {
                    exchange.getResponseHeaders().set(parts[0], parts[1]);
                }
            }
        }
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) {
            os.write(bytes);
        }
    }
}
