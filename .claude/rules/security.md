# Security rules

Applies to: all files

## Secrets — never commit

**Absolute rule:** no real secrets in source code, config files, or documentation.
If it looks like a key, token, password, or credential — it does not go in a commit.

**What counts as a secret:**
- API keys (any service: Supabase, AWS, GitHub, OpenAI, etc.)
- Database connection strings with embedded passwords
- OAuth client secrets
- JWT signing keys / HMAC secrets
- Private keys or certificates (`-----BEGIN PRIVATE KEY-----`)
- Passwords, even in test code or comments
- Supabase `SERVICE_ROLE_KEY` — anywhere, ever (especially not in frontend code)

**Where secrets live:**
- `.env` file (local only, never committed)
- `.env.example` with **placeholder values only** (e.g., `SUPABASE_URL=your-url-here`)
- GitHub Secrets (CI/CD only)
- If a secret is accidentally committed: **rotate it immediately** + scrub git history with `git filter-branch` or BFG Repo-Cleaner

**Supabase key rules (critical):**
- `SUPABASE_ANON_KEY` — safe for frontend code (`src/web/`). This is the public key.
- `SUPABASE_SERVICE_ROLE_KEY` — **backend only** (`src/api/` via `.env`) or **not in code at all**. This key bypasses RLS — if it leaks, anyone can read/write all data.
- `SUPABASE_URL` — can be in frontend code (it's just a URL, not a secret).

## Authentication

- Supabase Auth manages registration and login — the backend never handles passwords.
- Spring Boot verifies JWTs on every request via a filter.
- Extract user ID from the JWT `sub` claim — never trust a `userId` field in the request body.
- Use the Supabase **anon key** for the frontend; the **service role key** stays server-side only (or in `.env`).

## Input validation

- Validate all user input on the backend with Jakarta Validation (`@Valid`).
- Validate form inputs on the frontend before sending — but never trust client-side validation alone.
- Sanitize any user-generated content rendered in HTML (XSS prevention).

## API security

- CORS: allow only the frontend origin — no `*` in production.
- Rate limiting: plan for it but don't need it for the demo.
- No sensitive data in URL query parameters (use POST body or headers).
- Error responses must not leak stack traces, SQL errors, or internal file paths.

## Logging

- Never log PII: emails, user IDs, JWT tokens, passwords.
- Never log request bodies that may contain credentials.
- `console.log()` in frontend and `System.out.println()` in backend should not contain user data.
- In production, only log what's needed for debugging — not everything.

## Data handling

- Questions and answers are public — no auth needed to read them.
- User progress, XP, streaks, and mistakes are private — require auth.
- Supabase Row Level Security (RLS) policies should enforce access at the DB level as a defense-in-depth layer.

## Dependency security

- Dependabot scans weekly — review and merge PRs promptly.
- `security.yml` runs gitleaks + semgrep on every PR — fix findings before merge.
- Don't add dependencies without checking for known vulnerabilities (`npm audit`, `gradle dependencyCheck`).
