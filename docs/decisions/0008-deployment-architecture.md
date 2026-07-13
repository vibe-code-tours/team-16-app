# 8. Deployment Architecture

- Status: accepted
- Date: 2026-07-13

## Context

We need to deploy the NerdQuiz frontend and backend for the public demo. The team
previously containerized the frontend with Docker/nginx (ADR-0007), but Netlify offers
free static hosting with SPA support, CDN, and automatic HTTPS — eliminating the need
to manage frontend infrastructure. The backend needs a runtime environment for the
Spring Boot JAR.

## Decisions

### Frontend: Netlify (static hosting)

In the context of **deploying the React SPA**, facing **the choice between
self-managed Docker/nginx and managed static hosting**, we chose **Netlify** to achieve
**zero-infrastructure frontend deployment with SPA routing, CDN, and preview deploys**,
accepting **dependency on a third-party platform for the frontend**.

- Static build (`npm run build` → `dist/`) deployed via GitHub Actions
- SPA routing handled by Netlify's `[[redirects]]` config in `netlify.toml`
- No Docker, no nginx, no container management for the frontend
- PR preview deploys available via Netlify's deploy preview feature

### Backend: Google Cloud Run

In the context of **deploying the Spring Boot API**, facing **the choice between
container orchestration options (GKE, Cloud Run, Compute Engine)**, we chose
**Cloud Run** to achieve **serverless container deployment with automatic scaling,
pay-per-request pricing, and minimal ops overhead**, accepting **stateless-only
containers and cold start latency on low traffic**.

- Multi-stage Docker build: JDK 25 Alpine (build) → JRE 25 Alpine (runtime)
- Deploys from GitHub Actions via `gcloud run deploy`
- Image stored in Artifact Registry (`asia-northeast1-docker.pkg.dev`)
- Connects to Supabase Postgres via connection pooler

### CI/CD: GitHub Actions

In the context of **automating deployment**, facing **the need to build, test, and
deploy on every push to main**, we chose **GitHub Actions** to achieve **tight
integration with the repository, secrets management, and path-based triggers**,
accepting **vendor lock-in to GitHub's CI platform**.

- Frontend: lint → test → build → deploy to Netlify
- Backend: build Docker image → push to Artifact Registry → deploy to Cloud Run
- Path-based triggers: only deploy when `src/web/` or `src/api/` changes

## Consequences

- Frontend has zero server costs and automatic HTTPS
- Backend scales to zero when idle (cost optimization)
- CORS configuration is required since frontend and backend are on different origins
- Developers can still run everything locally via `docker compose` + `supabase start`
- Netlify and Cloud Run are both managed services — less operational burden for the team

## References

- ADR-0007 (superseded): Frontend Dockerization Strategy
- `.github/workflows/deploy-backend.yml`
- `.github/workflows/deploy-frontend.yml`
- `docker-compose.yml` (local dev only)
