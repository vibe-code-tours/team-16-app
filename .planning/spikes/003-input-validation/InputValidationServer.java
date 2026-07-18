import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Pattern;

/**
 * Spike 003: Input validation hardening.
 *
 * Tests whether malicious inputs are rejected cleanly.
 * Simulates Spring Boot's validation layer:
 * - Jakarta @Valid style structural validation
 * - XSS sanitization for free-text fields
 * - Payload size limits
 * - Path traversal prevention
 *
 * Run: javac InputValidationServer.java && java InputValidationServer
 * Test: bash test-input-validation.sh
 */
public class InputValidationServer {

    private static final int PORT = 9997;
    private static final int MAX_PAYLOAD_BYTES = 1024 * 100; // 100KB

    // XSS patterns — angle brackets, script tags, event handlers
    private static final Pattern XSS_PATTERN = Pattern.compile(
        "<script[^>]*>|javascript:|on\\w+\\s*=|<iframe|<object|<embed|<form",
        Pattern.CASE_INSENSITIVE
    );

    // SQL injection patterns — common attack vectors
    // Double quotes excluded (valid JSON). JPA parameterized queries prevent
    // SQL injection at the ORM level; this catches obvious injection attempts.
    private static final Pattern SQLI_PATTERN = Pattern.compile(
        "'\\s*(or|and)\\s+\\d|--\\s*$|;\\s*(drop|delete|insert|update|select)\\b|union\\s+select|select\\s+\\*\\s+from|drop\\s+table|delete\\s+from",
        Pattern.CASE_INSENSITIVE
    );

    // Path traversal patterns
    private static final Pattern PATH_TRAVERSAL_PATTERN = Pattern.compile(
        "\\.\\./|\\.\\.\\\\|%2e%2e|%252e%252e|\\.\\.%2f|%00"
    );

    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress(PORT), 0);

        // Endpoint that accepts user input in query params (simulates search)
        server.createContext("/api/v1/search", exchange -> {
            if (!"GET".equals(exchange.getRequestMethod())) {
                sendError(exchange, 405, "Method Not Allowed");
                return;
            }
            String query = getQueryParam(exchange, "q");
            if (query == null || query.isEmpty()) {
                sendError(exchange, 400, "Missing required parameter: q");
                return;
            }
            // Check for SQL injection
            if (SQLI_PATTERN.matcher(query).find()) {
                sendError(exchange, 400, "Invalid input: potentially malicious query parameter");
                return;
            }
            // Check for XSS
            if (XSS_PATTERN.matcher(query).find()) {
                sendError(exchange, 400, "Invalid input: potentially malicious content detected");
                return;
            }
            sendJson(exchange, 200, "{\"results\":[],\"query\":\"" + escapeJson(query) + "\"}");
        });

        // Endpoint that accepts JSON body (simulates creating a profile)
        server.createContext("/api/v1/profiles", exchange -> {
            if (!"POST".equals(exchange.getRequestMethod())) {
                sendError(exchange, 405, "Method Not Allowed");
                return;
            }

            // Check content length
            String contentLength = exchange.getRequestHeaders().getFirst("Content-Length");
            if (contentLength != null) {
                try {
                    int length = Integer.parseInt(contentLength);
                    if (length > MAX_PAYLOAD_BYTES) {
                        sendError(exchange, 413, "Payload Too Large: maximum " + MAX_PAYLOAD_BYTES + " bytes");
                        return;
                    }
                } catch (NumberFormatException e) {
                    sendError(exchange, 400, "Invalid Content-Length header");
                    return;
                }
            }

            // Read body
            String body;
            try (InputStream is = exchange.getRequestBody()) {
                body = new String(is.readAllBytes(), StandardCharsets.UTF_8);
            } catch (Exception e) {
                sendError(exchange, 400, "Failed to read request body");
                return;
            }

            // Validate JSON structure (basic check)
            if (body.isBlank() || !body.trim().startsWith("{")) {
                sendError(exchange, 400, "Invalid JSON: expected object");
                return;
            }

            // Check for XSS in body content
            if (XSS_PATTERN.matcher(body).find()) {
                sendError(exchange, 400, "Invalid input: potentially malicious content in body");
                return;
            }

            // Check for SQL injection in body
            if (SQLI_PATTERN.matcher(body).find()) {
                sendError(exchange, 400, "Invalid input: potentially malicious content in body");
                return;
            }

            sendJson(exchange, 201, "{\"id\":\"new-123\",\"status\":\"created\"}");
        });

        // Endpoint that serves static-like content (path traversal test)
        server.createContext("/api/v1/files", exchange -> {
            String path = exchange.getRequestURI().getPath();
            // Extract the filename part after /api/v1/files/
            String filename = path.substring("/api/v1/files/".length());

            // Check for path traversal
            if (PATH_TRAVERSAL_PATTERN.matcher(filename).find()
                || filename.contains("..")
                || filename.startsWith("/")) {
                sendError(exchange, 403, "Forbidden: path traversal not allowed");
                return;
            }

            sendJson(exchange, 200, "{\"file\":\"" + escapeJson(filename) + "\",\"status\":\"ok\"}");
        });

        server.start();
        System.out.println("=== Spike 003: Input Validation running on port " + PORT + "===");
        System.out.println("Test with: bash test-input-validation.sh");
    }

    private static String getQueryParam(HttpExchange exchange, String name) {
        String query = exchange.getRequestURI().getQuery();
        if (query == null) return null;
        for (String param : query.split("&")) {
            String[] kv = param.split("=", 2);
            if (kv.length == 2 && name.equals(URLDecoder.decode(kv[0], StandardCharsets.UTF_8))) {
                return URLDecoder.decode(kv[1], StandardCharsets.UTF_8);
            }
        }
        return null;
    }

    private static void sendError(HttpExchange exchange, int status, String message) throws IOException {
        String json = String.format(
            "{\"type\":\"urn:nerdquiz:validation-error\","
            + "\"title\":\"Validation Error\","
            + "\"status\":%d,"
            + "\"detail\":\"%s\"}",
            status, escapeJson(message)
        );
        sendJson(exchange, status, json);
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
                .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t");
    }
}
