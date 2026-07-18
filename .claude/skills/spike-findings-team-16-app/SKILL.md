---
name: spike-findings-team-16-app
description: Implementation blueprint from spike experiments. Requirements, proven patterns, and verified knowledge for building NerdQuiz security hardening. Auto-loaded during implementation work.
---

<context>
## Project: team-16-app

Security hardening for NerdQuiz — a gamified IT exam prep platform for ITPEC FE certification. The platform stores user progress, quiz data, and exam questions. Spike experiments validated practical security measures: rate limiting, security headers, input validation, JWT hardening, and RLS auditing.

Spike sessions wrapped: 2026-07-17
</context>

<requirements>
## Requirements

Non-negotiable design decisions that emerged from spike experiments:

- Must work with Spring Boot 3.x (Java 25) backend
- Must not break existing Supabase Auth flow
- Rate limiting must be per-IP, not global
- Security headers must not interfere with Supabase SDK calls from frontend
- All security measures must return RFC 7807 Problem Details format on rejection
- Service role key must stay server-side only (never in frontend code)
- Error responses must not leak internal details (library names, algorithms, timestamps)
</requirements>

<findings_index>
## Feature Areas

| Area | Reference | Key Finding |
|------|-----------|-------------|
| Rate Limiting & DDoS Protection | references/rate-limiting.md | ConcurrentHashMap sliding window, per-IP, zero dependencies, 60 req/min default |
| Browser Hardening (Security Headers) | references/security-headers.md | CSP must allow `*.supabase.co` + `wss:` for SDK; `frame-src 'none'` prevents clickjacking |
| Input Validation & Sanitization | references/input-validation.md | Never match `"` in SQLi regex (false positive on JSON); XSS patterns per-field only |
| JWT Authentication Hardening | references/jwt-hardening.md | Pin HS256 algorithm; generic "Invalid token" for all failures; debug-only logging |
| Data Security (RLS) | references/data-security-rls.md | All user-data tables have RLS; no service role in frontend; two-layer security model |

## Source Files

Original spike source files are preserved in `sources/` for complete reference.
Each source directory contains the README.md (investigation trail + results) and all code/test files.
</findings_index>

<metadata>
## Processed Spikes

- 001-rate-limiting (VALIDATED)
- 002-security-headers (VALIDATED)
- 003-input-validation-hardening (VALIDATED)
- 004-jwt-auth-hardening (VALIDATED)
- 005-supabase-rls-audit (VALIDATED)
</metadata>
