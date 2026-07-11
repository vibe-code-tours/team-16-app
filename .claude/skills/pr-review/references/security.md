# Security Review Checklist

Applies to: all files. **All findings here are BLOCKING.**

## Table of contents

- [Hardcoded secrets](#hardcoded-secrets)
- [Supabase-specific](#supabase-specific)
- [Secrets in non-code files](#secrets-in-non-code-files)
- [Auth and data protection](#auth-and-data-protection)

## Hardcoded secrets

Scan the staged diff for any of the following patterns. **All are BLOCKING.**

- API keys: strings matching `sk-...`, `api_key=`, `apikey:`, `AKIA...` (AWS), `ghp_...` (GitHub), `xoxb-...` (Slack)
- Database connection strings: `postgresql://...`, `mysql://...`, `mongodb://...` with embedded passwords
- OAuth client secrets: `client_secret`, `CLIENT_SECRET`, `oauth_secret` with actual values
- JWT signing secrets: `JWT_SECRET`, `SIGNING_KEY`, `HMAC_SECRET` with actual values
- Private keys / certificates: `-----BEGIN (RSA |EC )?PRIVATE KEY-----`
- Passwords in code: `password = "..."`, `passwd: "..."`, `DB_PASSWORD=...` with actual values
- Base64-encoded secrets: long base64 strings assigned to key-like variable names
- Hardcoded IP addresses or internal URLs that aren't localhost/127.0.0.1
- `.env` files or files matching `.env.*` (other than `.env.example`)

**How to verify:** If a staged diff contains a string that looks like a long
random/alphanumeric value (20+ chars) assigned to a variable with a security-related
name, flag it even if it doesn't match the patterns above. False positives are
acceptable — blocking a real secret is not.

## Supabase-specific

- `SUPABASE_SERVICE_ROLE_KEY` in any frontend code (`src/web/**`) — this key bypasses RLS and must NEVER be in the browser
- Service role key in any file that could be client-side bundled
- Only `SUPABASE_ANON_KEY` is allowed in frontend code — verify this is the anon key, not the service role key

## Secrets in non-code files

- No real keys in markdown, YAML, JSON, or config files (only `.env.example` with placeholder values)
- No credentials in Docker configs, docker-compose files, or CI workflow files
- No API tokens in README or documentation examples

## Auth and data protection

- No `userId` accepted from request body — always extracted from JWT `sub` claim
- User-facing data (mistakes, progress, profile) requires auth check
- No PII logged: emails, user IDs, JWT tokens, passwords in log statements
- No `console.log()` or `System.out.println()` with request bodies or user data
- Error responses don't leak stack traces, SQL errors, or internal paths to the client
- CORS is not set to `*` in production config
- Input validation present on all endpoints that accept user data (`@Valid` on backend, form validation on frontend)
