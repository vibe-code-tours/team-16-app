# Plan: CD Setup with GitHub Actions (Netlify + Cloud Run)

## Context

Set up continuous deployment for both frontend (Netlify) and backend (Cloud Run) using GitHub Actions workflows. Frontend deploys on push to `main`, backend deploys on push to `main` when `src/api/` changes.

## Files to Create

### 1. `.github/workflows/deploy-frontend.yml`

**Trigger:** Push to `main` (only when `src/web/**` changes)

**Steps:**
1. Checkout code
2. Setup Node.js 20
3. Install dependencies (`npm ci` in `src/web`)
4. Build (`npm run build`)
5. Deploy to Netlify using `netlify-cli`

**Required GitHub Secrets:**
- `NETLIFY_AUTH_TOKEN` — Netlify personal access token
- `NETLIFY_SITE_ID` — Netlify site ID

### 2. `.github/workflows/deploy-backend.yml`

**Trigger:** Push to `main` (only when `src/api/**` changes)

**Steps:**
1. Checkout code
2. Authenticate to Google Cloud
3. Build Docker image
4. Push to Google Container Registry (GCR)
5. Deploy to Cloud Run

**Required GitHub Secrets:**
- `GCP_PROJECT_ID` — Google Cloud project ID
- `GCP_SA_KEY` — Service account JSON key (base64 encoded)
- `SUPABASE_URL` — Backend env var
- `SUPABASE_ANON_KEY` — Backend env var
- `DATABASE_URL` — Backend env var

### 3. Update `netlify.toml`

Add build environment variables reference (VITE_SUPABASE_URL, VITE_SUPABASE_ANON_KEY).

## Architecture

```
Push to main (src/web/**)
  └─► deploy-frontend.yml
       ├─ npm ci
       ├─ npm run build
       └─ netlify deploy --prod

Push to main (src/api/**)
  └─► deploy-backend.yml
       ├─ docker build
       ├─ docker push to GCR
       └─ deploy to Cloud Run
```

## Verification

1. Create Netlify account and get auth token + site ID
2. Create GCP project and service account
3. Add secrets to GitHub repo
4. Push to main and verify both workflows run
