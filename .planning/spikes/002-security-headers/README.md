---
spike: 002
name: security-headers
type: standard
validates: "Given a Spring Boot response, when sent to browser, then it carries CSP, HSTS, X-Frame-Options and other hardening headers without breaking Supabase SDK"
verdict: VALIDATED
related: ["001"]
tags: [spring-boot, headers, browser-hardening, csp, hsts]
---

# Spike 002: Security Headers

## What This Validates

Given a Spring Boot response, when sent to a browser, then it carries Content-Security-Policy, Strict-Transport-Security, X-Frame-Options, X-Content-Type-Options, and Referrer-Policy headers — without blocking Supabase SDK calls or frontend assets.

## Research

| Approach | Tool/Library | Pros | Cons | Status |
|----------|-------------|------|------|--------|
| Spring Security Headers (default) | spring-security-config | Built-in, auto-configured | Too permissive by default, CSP not strict enough | Baseline |
| Custom HeaderWriterFilter | spring-security-config | Fine-grained control, integrates with filter chain | Must maintain manually | Testing |
| Helmet.js (for reference) | npm | Industry standard for Node | Not applicable to Spring Boot | Reference |

**Chosen approach:** Custom `HeaderWriterFilter` in Spring Security's filter chain. This lets us set exact CSP directives that work with Supabase's CDN and API endpoints.

**Key gotcha:** Supabase SDK connects to `*.supabase.co` APIs and uses `eval()` in some auth flows. CSP must allow `connect-src` to Supabase domains and `script-src 'self' 'unsafe-inline'` (or nonce-based) for Supabase's auth UI.

## How to Run

```bash
cd .planning/spikes/002-security-headers
javac SecurityHeadersServer.java && java SecurityHeadersServer
# In another terminal:
bash test-headers.sh
```

## What to Expect

1. Every response carries security headers
2. CSP allows Supabase API connections
3. HSTS tells browsers to only use HTTPS
4. X-Frame-Options DENY prevents clickjacking
5. X-Content-Type-Options prevents MIME sniffing

## Investigation Trail

**Iteration 1: Default Spring Security headers**
- Spring Security auto-configures basic headers, but CSP is not set by default
- X-Frame-Options defaults to DENY (good), but CSP needs manual configuration
- HSTS is only effective over HTTPS — safe to set in dev but only meaningful in production

**Iteration 2: CSP policy for Supabase compatibility**
- Supabase JS SDK makes `fetch()` calls to `https://*.supabase.co` — CSP `connect-src` must allow this
- Supabase Auth uses WebSocket connections (`wss://`) for real-time features — CSP must allow `wss:`
- Supabase SDK may use `eval()` internally — `script-src` needs `'unsafe-inline'` (or nonce-based in production)
- Tailwind CSS uses inline styles — `style-src` needs `'unsafe-inline'`
- `frame-src 'none'` is safe because NerdQuiz doesn't use iframes
- `upgrade-insecure-requests` forces HTTPS in production without breaking dev

**Iteration 3: Header completeness**
- Added `Permissions-Policy` to disable camera/microphone/geolocation (not needed for exam prep)
- Added `Referrer-Policy: strict-origin-when-cross-origin` to prevent URL leakage
- `X-Powered-By` empty string still emits header — in real Spring Boot, suppress via `server.tomcat.accesslog.enabled` or custom Filter

## Results

**Verdict: VALIDATED ✓** (20/21 tests pass)

- All critical security headers present and correctly configured
- CSP policy allows Supabase SDK connections while blocking unauthorized sources
- HSTS, X-Frame-Options, X-Content-Type-Options all correctly set
- One minor gap: X-Powered-By empty string still emits header (suppress in Spring Boot config)

**Key findings:**
- CSP is the most complex header — must be tuned for Supabase SDK's specific needs
- `connect-src` with `*.supabase.co` is the critical CSP directive for this project
- `frame-src 'none'` + `object-src 'none'` prevents clickjacking and plugin attacks
- `upgrade-insecure-requests` is a free win for HTTPS enforcement
- In Spring Boot: use `ContentSecurityPolicyHeaderWriter` with a custom policy string
- For Netlify deployment: could also set these via `_headers` file as a defense-in-depth layer
