import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.regex.Pattern;

/**
 * Spike 004: JWT Auth Hardening.
 *
 * Simulates the JwtAuthenticationFilter behavior from the real app.
 * Tests various JWT attack scenarios to verify:
 * - No internal details leak in 401 responses
 * - All malformed/tampered/expired tokens are rejected
 * - Algorithm confusion attacks are prevented
 *
 * Run: javac JwtHardeningServer.java && java JwtHardeningServer
 * Test: bash test-jwt-hardening.sh
 */
public class JwtHardeningServer {

    private static final int PORT = 9996;
    private static final String VALID_SECRET = "my-super-secret-key-for-testing-only";
    private static final String VALID_USER_ID = "user-123-abc";

    // Simulated "correct" algorithm — HMAC-SHA256
    private static final String EXPECTED_ALG = "HS256";

    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress(PORT), 0);

        // Protected endpoint — requires valid JWT
        server.createContext("/api/v1/profile", exchange -> {
            String authHeader = exchange.getRequestHeaders().getFirst("Authorization");

            // No token → 401
            if (authHeader == null || !authHeader.startsWith("Bearer ")) {
                sendUnauthorized(exchange, "Missing or malformed Authorization header");
                return;
            }

            String token = authHeader.substring(7);
            String rejectionReason = validateToken(token);

            if (rejectionReason != null) {
                // Token invalid — reject with generic message (no internal details)
                sendUnauthorized(exchange, rejectionReason);
                return;
            }

            // Token valid — return user data
            sendJson(exchange, 200, "{\"user\":\"" + VALID_USER_ID + "\",\"role\":\"user\"}");
        });

        // Public endpoint — no auth required
        server.createContext("/api/v1/health", exchange -> {
            sendJson(exchange, 200, "{\"status\":\"UP\"}");
        });

        server.start();
        System.out.println("=== Spike 004: JWT Auth Hardening running on port " + PORT + "===");
        System.out.println("Test with: bash test-jwt-hardening.sh");
    }

    /**
     * Validate a JWT token — simulates JwtUtil.verify() behavior.
     * Returns null if valid, rejection reason string if invalid.
     *
     * This mirrors what Nimbus JOSE+JWT does:
     * - Parse the JWT structure (header.payload.signature)
     * - Verify signature matches expected secret
     * - Check expiration
     * - Validate algorithm is not "none"
     *
     * IMPORTANT: All rejection reasons are generic — no internal details.
     */
    private static String validateToken(String token) {
        if (token == null || token.isBlank()) {
            return "Invalid token";
        }

        // Check for SQL injection in token (shouldn't execute, but test anyway)
        if (token.contains("'") || token.contains(";") || token.contains("--")) {
            return "Invalid token";
        }

        // Check for XSS in token
        if (token.contains("<") || token.contains(">")) {
            return "Invalid token";
        }

        // Split into parts
        String[] parts = token.split("\\.");
        if (parts.length != 3) {
            return "Invalid token";
        }

        // Decode header
        String headerJson;
        try {
            headerJson = new String(Base64.getUrlDecoder().decode(parts[0]), StandardCharsets.UTF_8);
        } catch (Exception e) {
            return "Invalid token";
        }

        // Check algorithm — reject "none" algorithm (algorithm confusion attack)
        if (!headerJson.contains("\"alg\"")) {
            return "Invalid token";
        }
        if (headerJson.contains("\"none\"") || headerJson.contains("\"NONE\"")) {
            return "Invalid token";
        }
        // Only allow HMAC-SHA256
        if (!headerJson.contains("\"HS256\"")) {
            return "Invalid token";
        }

        // Decode payload
        String payloadJson;
        try {
            payloadJson = new String(Base64.getUrlDecoder().decode(parts[1]), StandardCharsets.UTF_8);
        } catch (Exception e) {
            return "Invalid token";
        }

        // Check expiration
        if (payloadJson.contains("\"exp\"")) {
            // Extract exp value (simplified — real Nimbus JOSE checks timestamp)
            try {
                String expStr = payloadJson.replaceAll(".*\"exp\"\\s*:\\s*(\\d+).*", "$1");
                long exp = Long.parseLong(expStr);
                long now = System.currentTimeMillis() / 1000;
                if (exp < now) {
                    return "Invalid token";  // Generic — don't say "expired"
                }
            } catch (Exception e) {
                return "Invalid token";
            }
        }

        // Verify signature (simplified — real Nimbus JOSE uses HMAC)
        // In this spike, we check if the signature is "valid-sig" (simulated)
        if (!"valid-sig".equals(parts[2])) {
            return "Invalid token";  // Generic — don't say "signature mismatch"
        }

        return null;  // Valid
    }

    /**
     * Send 401 with generic error — no internal details.
     * This is the key security property: the error message must not reveal
     * - which library is used (Nimbus JOSE)
     * - what algorithm is expected (HS256)
     * - what the expected secret is
     * - whether the token was expired vs tampered
     */
    private static void sendUnauthorized(HttpExchange exchange, String detail) throws IOException {
        String json = String.format(
            "{\"type\":\"urn:nerdquiz:unauthorized\","
            + "\"title\":\"Unauthorized\","
            + "\"status\":401,"
            + "\"detail\":\"%s\"}",
            escapeJson(detail)
        );
        sendJson(exchange, 401, json);
    }

    private static void sendJson(HttpExchange exchange, int status, String json) throws IOException {
        byte[] bytes = json.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().set("Content-Type", "application/problem+json");
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) {
            os.write(bytes);
        }
    }

    private static String escapeJson(String s) {
        return s.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r");
    }
}
