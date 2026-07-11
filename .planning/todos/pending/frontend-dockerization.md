---
title: Frontend Dockerization Implementation
date: 2026-07-11
priority: medium
---

# Frontend Dockerization Implementation

Based on Issue #11 acceptance criteria and exploration decisions.

## Tasks

1. **Create multi-stage `Dockerfile` in `src/web/`**
   - Stage 1 (build): Node 20, install deps, run `tsc -b && vite build`
   - Stage 2 (serve): nginx:alpine, copy built assets
   - Pass `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` as build args

2. **Create nginx config for SPA routing + API proxy**
   - `try_files $uri $uri/ /index.html` for React Router support
   - Proxy `/api/*` to `backend:8080` (Docker network service name)
   - Serve on port 80

3. **Add frontend to `docker-compose.yml` at repo root**
   - `dev` profile: volume-mount source, run `npm run dev` on :5173
   - `production` profile: build from Dockerfile, serve via nginx
   - Environment variables from `.env` file

4. **Add Vite proxy config for dev mode**
   - In `vite.config.ts`, add `server.proxy` for `/api` → `localhost:8080`
   - Only active in dev mode (not in Docker production build)

5. **Verify end-to-end**
   - `docker-compose --profile dev up` — frontend loads, hot reload works, API calls reach backend
   - `docker-compose --profile production up` — nginx serves built app, SPA routes work, /api proxied
   - New dev can clone and run without installing Node locally

## Dependencies

- Backend must be running (either `docker-compose up` with backend service, or `./gradlew bootRun` separately)
- `.env` file with `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` configured
