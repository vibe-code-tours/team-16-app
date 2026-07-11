---
title: Frontend Dockerization Decisions
date: 2026-07-11
context: Exploration session for Issue #11 — frontend Docker setup
---

# Frontend Dockerization Decisions

## Key decisions made during exploration

### Dual-mode Docker Compose

Two profiles for `docker-compose.yml`:

- **`dev` profile**: Runs `npm run dev` with hot reload (Vite dev server on :5173). Fast iteration, no rebuild needed.
- **`production` profile**: Multi-stage Dockerfile builds static assets, nginx:alpine serves them. Production parity for staging/demo.

Daily development uses the dev profile. New onboarding, CI, and demo use the production profile.

### API routing: nginx proxy + Vite proxy

- **Nginx mode** (`production` profile): nginx config routes `/api/*` → `backend:8080`. Same-origin from browser, no CORS.
- **Dev mode** (`dev` profile): Vite's `server.proxy` config routes `/api/*` → `localhost:8080`. Also same-origin, no CORS.
- Backend CORS configuration is not needed for frontend traffic in either mode.

### Environment variable strategy

Supabase env vars (`VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`) are public (safe for frontend bundle).

- **Local dev**: `.env` file at repo root (gitignored), read by `docker-compose.yml` via `${VAR}` syntax.
- **CI (GitHub Actions)**: GitHub Secrets injected as env vars during `docker-compose build`. Same Dockerfile, different source.

### SPA routing

nginx must handle React Router v7 client-side routing — all routes fall back to `index.html` via `try_files $uri $uri/ /index.html`.

## References

- Issue #11: https://github.com/vibe-code-tours/team-16-app/issues/11
- Feature board item #19
