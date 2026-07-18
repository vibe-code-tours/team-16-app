# Browser Hardening (Security Headers)

## Requirements

- Must work with Spring Boot 3.x (Java 25) backend
- Security headers must not interfere with Supabase SDK calls from frontend
- CSP must allow connections to `*.supabase.co` (API + WebSocket)

## How to Build It

**1. Create `SecurityHeadersConfig.java` using Spring Security's HeaderWriterFilter:**

```java
@Configuration
public class SecurityHeadersConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .headers(headers -> headers
                .contentSecurityPolicy(csp -> csp.policyDirectives(
                    "default-src 'self'; "
                    + "script-src 'self' 'unsafe-inline'; "
                    + "style-src 'self' 'unsafe-inline'; "
                    + "img-src 'self' data: https:; "
                    + "font-src 'self' https://fonts.gstatic.com; "
                    + "connect-src 'self' https://*.supabase.co wss://*.supabase.co; "
                    + "frame-src 'none'; "
                    + "object-src 'none'; "
                    + "base-uri 'self'; "
                    + "form-action 'self'; "
                    + "upgrade-insecure-requests"
                ))
                .frameOptions(frame -> frame.deny())
                .contentTypeOptions(Customizer.withDefaults())
                .httpStrictTransportSecurity(hsts -> hsts
                    .maxAgeInSeconds(31536000)
                    .includeSubdomains(true)
                )
                .referrerPolicy(referrer -> referrer
                    .policy(ReferrerPolicyHeaderWriter.ReferrerPolicy.STRICT_ORIGIN_WHEN_CROSS_ORIGIN)
                )
                .permissionsPolicy(permissions -> permissions
                    .policy("camera=(), microphone=(), geolocation=()")
                )
            );
        return http.build();
    }
}
```

**2. The CSP policy is the most critical header. Key directives explained:**

| Directive | Value | Why |
|-----------|-------|-----|
| `connect-src` | `'self' https://*.supabase.co wss://*.supabase.co` | Supabase SDK makes API calls + WebSocket connections |
| `script-src` | `'self' 'unsafe-inline'` | Supabase SDK uses inline scripts; upgrade to nonce-based later |
| `style-src` | `'self' 'unsafe-inline'` | Tailwind CSS + Supabase UI use inline styles |
| `frame-src` | `'none'` | NerdQuiz doesn't use iframes — prevents clickjacking |
| `object-src` | `'none'` | Blocks plugin injection (Flash, Java, etc.) |
| `upgrade-insecure-requests` | — | Forces HTTPS in production without breaking dev |

**3. For Netlify deployment, add `_headers` file as defense-in-depth:**

```
/*
  Content-Security-Policy: default-src 'self'; script-src 'self' 'unsafe-inline'; ...
  Strict-Transport-Security: max-age=31536000; includeSubDomains
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  Referrer-Policy: strict-origin-when-cross-origin
  Permissions-Policy: camera=(), microphone=(), geolocation=()
```

## What to Avoid

- **Don't use `frame-src 'self'`** — use `frame-src 'none'` unless you explicitly need iframes. `'self'` allows embedding your own site in frames (clickjacking).
- **Don't forget `wss://` in connect-src.** Supabase real-time features use WebSocket — without `wss://`, real-time subscriptions break silently.
- **Don't set HSTS without testing HTTPS.** HSTS is only effective over HTTPS. In dev (HTTP), it has no effect but is safe to set.
- **Don't use `script-src 'unsafe-eval'`** unless absolutely necessary. `'unsafe-inline'` is already a compromise; `unsafe-eval` opens XSS wider.
- **Don't set X-Powered-By to empty string** — it still sends the header. Suppress it via Spring Boot config instead.

## Constraints

- CSP `'unsafe-inline'` is needed for Supabase SDK and Tailwind — cannot use nonce-based without significant refactoring
- HSTS max-age of 31536000 (1 year) is standard; includeSubDomains covers subdomains
- `X-Frame-Options: DENY` is the most restrictive — use `SAMEORIGIN` only if embedding is needed
- CSP can be made stricter incrementally — start permissive, tighten after testing

## Origin

Synthesized from spikes: 002
Source files available in: sources/002-security-headers/
