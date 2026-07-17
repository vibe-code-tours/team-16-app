# Spike Manifest

## Idea
Security hardening for NerdQuiz — a gamified IT exam prep platform. The platform stores user progress, quiz data, and exam questions. We need to validate practical security measures before implementing them in the real build: rate limiting, security headers, input validation, JWT hardening, and RLS auditing.

## Requirements
- Must work with Spring Boot 3.x (Java 25) backend
- Must not break existing Supabase Auth flow
- Rate limiting must be per-IP, not global
- Security headers must not interfere with Supabase SDK calls from frontend
- All security measures must return RFC 7807 Problem Details format on rejection

## Spikes

| # | Name | Type | Validates | Verdict | Tags |
|---|------|------|-----------|---------|------|
| 001 | rate-limiting | standard | Given a Spring Boot endpoint, when >N requests/minute from one IP, then 429 is returned | **VALIDATED ✓** | [spring-boot, rate-limit, ddos] |
| 002 | security-headers | standard | Given a Spring Boot response, when sent to browser, then it carries CSP, HSTS, X-Frame-Options | PENDING | [spring-boot, headers, browser-hardening] |
| 003 | input-validation-hardening | standard | Given malicious input, when hitting endpoints, then rejected cleanly | PENDING | [spring-boot, security, input-validation] |
| 004 | jwt-auth-hardening | standard | Given expired/tampered JWT, when hitting protected endpoint, then rejected with 401 | PENDING | [spring-boot, jwt, auth] |
| 005 | supabase-rls-audit | standard | Given RLS policies, when a user tries to access another user's data, then denied | PENDING | [supabase, rls, data-security] |
