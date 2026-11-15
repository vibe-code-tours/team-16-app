# ADR-0009: Question figures as static web assets

## Status

Accepted

## Context

About 240 exam questions and answer choices depend on a figure (circuit, graph, table,
flowchart). The extraction pipeline renders each one as a small WebP file. The initial schema
created a public `question-images` Supabase Storage bucket for them, and the first three exam
sessions were uploaded there by hand through the dashboard. Nothing in the app built Storage
URLs, so figures never displayed, and every environment (local, hosted) needed its own upload.

## Decision

In the context of **serving exam question figures**, facing **a manual upload step per
environment and figures that never reached the screen**, we chose **to commit the WebP files
to `src/web/public/question-images/` and serve them as static assets of the web app** to
achieve **figures that work in every environment with no upload step and are versioned with
the seed that references them**, accepting **about 4 MB of binary files in the repository and
a redeploy of the frontend whenever a figure changes**.

## Consequences

- The database stores bare filenames in `questions.images` and in a choice's `image` field;
  `src/web/src/lib/questionImage.ts` turns a filename into `/question-images/<name>`.
- `scripts/build_itpec_resources.py` copies figures into the web app folder; the validation
  gate fails if a referenced figure is missing there.
- The `question-images` Storage bucket and `scripts/seed_itpec_supabase.py` are no longer
  used for figures. They are left in place.
- Adding many more exam sessions grows the repository; if the set passes a few tens of MB,
  revisit Storage or a CDN.
