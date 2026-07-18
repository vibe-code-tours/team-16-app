import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Spike 002: Security headers for a Spring Boot-style API.
 *
 * Demonstrates the exact headers and CSP policy that would be applied
 * via Spring Security's HeaderWriterFilter in the real build.
 *
 * Run: javac SecurityHeadersServer.java && java SecurityHeadersServer
 * Test: bash test-headers.sh
 */
public class SecurityHeadersServer {

    private static final int PORT = 9998;

    // Supabase domains that the frontend needs to connect to
    private static final String SUPABASE_CONNECT = "https://*.supabase.co wss://*.supabase.co";
    // Vite dev server and production origin
    private static final String FRONTEND_ORIGIN = "http://localhost:5173 http://localhost:5100";

    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress(PORT), 0);

        // Simulated API endpoint
        server.createContext("/api/v1/health", exchange -> {
            applySecurityHeaders(exchange);
            String json = "{\"status\":\"UP\",\"headers\":\"applied\"}";
            sendResponse(exchange, 200, json);
        });

        // Simulated frontend-serving endpoint (for CSP testing)
        server.createContext("/", exchange -> {
            applySecurityHeaders(exchange);
            String html = """
                <!DOCTYPE html>
                <html>
                <head><title>Spike 002</title></head>
                <body>
                <h1>Security Headers Test</h1>
                <p>Check response headers in DevTools Network tab.</p>
                <script>console.log('CSP allows inline');</script>
                </body>
                </html>""";
            exchange.getResponseHeaders().set("Content-Type", "text/html");
            sendResponse(exchange, 200, html);
        });

        server.start();
        System.out.println("=== Spike 002: Security Headers running on port " + PORT + "===");
        System.out.println("Test with: bash test-headers.sh");
    }

    /**
     * Apply security headers — mirrors what Spring Security's HeaderWriterFilter does.
     * This is the exact CSP policy validated in this spike.
     */
    private static void applySecurityHeaders(HttpExchange exchange) {
        Map<String, String> headers = getSecurityHeaders();
        for (Map.Entry<String, String> entry : headers.entrySet()) {
            exchange.getResponseHeaders().set(entry.getKey(), entry.getValue());
        }
    }

    /**
     * Security headers configuration — the real build would use Spring Security's
     * ContentSecurityPolicyHeaderWriter, FrameOptionsHeaderWriter, etc.
     *
     * CSP is the most complex — must allow:
     * - Supabase API calls (connect-src)
     * - Supabase auth UI iframes (frame-src)
     * - Inline scripts for Supabase SDK (script-src unsafe-inline or nonce)
     * - Self-hosted assets (default-src 'self')
     */
    static Map<String, String> getSecurityHeaders() {
        Map<String, String> headers = new LinkedHashMap<>();

        // Content Security Policy — the critical one
        // Carefully crafted to work with Supabase SDK
        String csp = String.join("; ",
            "default-src 'self'",
            "script-src 'self' 'unsafe-inline'",           // Supabase SDK uses inline
            "style-src 'self' 'unsafe-inline'",            // Tailwind + Supabase UI
            "img-src 'self' data: https:",                  // Avatars, data URIs
            "font-src 'self' https://fonts.gstatic.com",   // Google Fonts
            "connect-src 'self' " + SUPABASE_CONNECT,      // Supabase API calls
            "frame-src 'none'",                             // No iframes (clickjacking prevention)
            "object-src 'none'",                            // No plugins
            "base-uri 'self'",                              // Prevent base tag injection
            "form-action 'self'",                           // Form submissions stay on-origin
            "upgrade-insecure-requests"                     // Force HTTPS in production
        );
        headers.put("Content-Security-Policy", csp);

        // HSTS — force HTTPS (only effective over HTTPS, but safe to set always)
        headers.put("Strict-Transport-Security", "max-age=31536000; includeSubDomains");

        // Clickjacking prevention
        headers.put("X-Frame-Options", "DENY");

        // MIME type sniffing prevention
        headers.put("X-Content-Type-Options", "nosniff");

        // Referrer policy — don't leak full URL to third parties
        headers.put("Referrer-Policy", "strict-origin-when-cross-origin");

        // Permissions policy — disable features we don't use
        headers.put("Permissions-Policy", "camera=(), microphone=(), geolocation=()");

        // Remove server identification
        headers.put("X-Powered-By", "");

        return headers;
    }

    private static void sendResponse(HttpExchange exchange, int status, String body) throws IOException {
        byte[] bytes = body.getBytes("UTF-8");
        exchange.sendResponseHeaders(status, bytes.length);
        try (OutputStream os = exchange.getResponseBody()) {
            os.write(bytes);
        }
    }
}
