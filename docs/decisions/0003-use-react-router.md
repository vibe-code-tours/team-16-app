# 3. Use React Router for client-side navigation

- Status: accepted
- Date: 2026-07-10

## Context

NerdQuiz has 7+ distinct views: landing page, auth screens, learning map, topic/lesson detail, quiz sessions, exam simulation, mistake garden, and (stretch) flashcards. The frontend needs a routing solution that handles nested layouts and clean URLs.

## Decision

In the context of **building a multi-view SPA with React**, facing **the need for nested routes, shared layouts, and URL-based navigation**, we chose **React Router v7** to achieve **industry-standard routing with minimal learning curve**, accepting **client-side routing limitations (no SSR, which we don't need)**.

## Alternatives considered

- **TanStack Router** — superior type safety, but adds ramp-up cost for a team that already knows React Router.
- **File-based routing (Next.js/Remix)** — unnecessary; we're not doing SSR/SSG.

## Consequences

- Each major view gets its own route: `/map`, `/quiz/:topicId`, `/exam/:examId`, `/mistakes`.
- Shared layouts (navbar, progress bar) use nested route outlets.
- No server-side routing needed — the frontend is a static SPA served separately from the API.
