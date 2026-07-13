# 7. Frontend Dockerization Strategy

- Status: superseded by [ADR-0008](0008-deployment-architecture.md)
- Date: 2026-07-11

## Context

We need to containerize the React frontend for consistent local development and production-ready deployment. Developers should be able to run the app without installing Node.js locally, and the production build should serve static assets efficiently.

## Decisions

### Dual-mode Docker Compose

In the context of **local development workflows**, facing **the need for both fast iteration and production parity**, we chose **dual-mode Docker Compose with dev and production profiles** to achieve **hot reload during development and nginx-served static assets for production**, accepting **slightly more complex compose configuration**.

- **Dev profile**: Runs `npm run dev` with volume-mounted source (Vite dev server on :5100)
- **Production profile**: Multi-stage Dockerfile builds static assets, nginx:alpine serves them

### API routing strategy

In the context of **frontend-backend communication in Docker**, facing **the need to avoid CORS configuration**, we chose **proxy-based routing (nginx for production, Vite for dev)** to achieve **same-origin requests from the browser**, accepting **proxy configuration in two places**.

- **Production (nginx)**: `/api/*` → `backend:8080`
- **Development (Vite)**: `/api/*` → `localhost:8080`

### Environment variable strategy

In the context of **Supabase configuration across environments**, facing **the need for different secret sources (local vs CI)**, we chose **build-time injection via `.env` file or GitHub Secrets** to achieve **same Dockerfile works everywhere**, accepting **env vars must be provided at build time**.

- **Local dev**: `.env` file at `src/web/.env` (gitignored)
- **CI/CD**: GitHub Secrets injected as env vars

### SPA routing in nginx

In the context of **React Router v7 client-side routing**, facing **nginx serving static files that don't match filesystem paths**, we chose **`try_files $uri $uri/ /index.html`** to achieve **all routes serve the SPA correctly**, accepting **server-side routing is disabled**.

## Consequences

- Developers can run `docker compose --profile dev up` without installing Node.js
- Production builds use nginx with gzip compression and aggressive caching for static assets
- Backend Dockerfile (Issue #12) is required for production profile to work end-to-end
- CORS configuration is not needed for frontend traffic in either mode

## References

- Issue #11: https://github.com/vibe-code-tours/team-16-app/issues/11
- Issue #12: https://github.com/vibe-code-tours/team-16-app/issues/12
- Feature board items #19, #20
