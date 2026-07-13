# Fix Cloud Run CI/CD Compatibility

## Context

The current Docker containerization and GitHub Actions workflow (`deploy-backend.yml`) have several issues that would cause failures or silent misconfigurations when deploying to Google Cloud Run. The most critical: only 1 of 5 environment variables actually gets deployed (gcloud CLI bug), and the app doesn't respect Cloud Run's `PORT` env var.

## Changes

### 1. Fix `--set-env-vars` bug (CRITICAL)

**File:** `.github/workflows/deploy-backend.yml` (lines 58-62)

The workflow passes five separate `--set-env-vars` flags. gcloud CLI silently ignores all but the last one — only `SUPABASE_ANON_KEY` would be set. Combine into a single comma-separated flag.

Also remove `DB_USER` and `DB_PASSWORD` — the app never reads them (credentials live inside `DATABASE_URL`).

### 2. Make app respect `PORT` env var

**File:** `src/api/src/main/resources/application.yml` (line 2)

Change `server.port: 8080` → `port: ${PORT:8080}` so Cloud Run can inject its preferred port. Falls back to 8080 for local dev.

### 3. Add resource limits to Cloud Run deploy

**File:** `.github/workflows/deploy-backend.yml` (deploy step)

Add `--memory=1Gi --cpu=1` and `--min-instances=0` (scale to zero when idle). Without this, default 512 MiB is tight for Spring Boot with JVM at 75% heap.

### 4. Migrate from GCR to Artifact Registry

**File:** `.github/workflows/deploy-backend.yml`

- Change `IMAGE` from `gcr.io/...` to `asia-northeast1-docker.pkg.dev/.../nerdquiz-api`
- Replace `gcloud auth configure-docker` with `gcloud auth configure-docker asia-northeast1.pkg.dev`

### 5. Add explicit `--port` to deploy command

**File:** `.github/workflows/deploy-backend.yml`

Add `--port 8080` for clarity, even though it matches the default.

## Files to modify

| File | Change |
|---|---|
| `.github/workflows/deploy-backend.yml` | Fix env vars, add resource limits, migrate to Artifact Registry |
| `src/api/src/main/resources/application.yml` | Read `PORT` env var with fallback |

## Verification

- Review the final `deploy-backend.yml` for correct gcloud CLI syntax
- Confirm `application.yml` still works locally (fallback to 8080)
- Confirm the Docker image name matches Artifact Registry format
