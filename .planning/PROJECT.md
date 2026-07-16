# NerdQuiz Admin Dashboard

## What This Is

An admin dashboard for NerdQuiz — a gamified IT exam prep platform for ITPEC FE certification. The dashboard lives inside the existing React SPA and gives founders a role-gated view to monitor platform health and manage user accounts. Students never see it; admins get stats, user search, user details, and role/deactivation controls.

## Core Value

Founders can see at a glance whether the platform is working — who's using it, how they're engaging, and whether anything needs intervention. If the dashboard can't answer "is this thing alive and healthy?" in 5 seconds, it fails.

## Requirements

### Validated

(None yet — ship to validate)

### Active

- [ ] Admin-only route guard: non-admin users see 403 or redirect, can't access `/admin`
- [ ] Stats overview: total registered users, active users (last 7 days), total quiz attempts, topic engagement breakdown
- [ ] Analytics charts: daily active users over time, quiz attempts over time, topic category distribution
- [ ] User list: paginated table of all users with search by name/email, filter by role
- [ ] User detail view: profile info (XP, streak, join date, last login), quiz attempt history
- [ ] Role management: assign/remove admin role on user accounts
- [ ] Account deactivation: soft-deactivate user accounts (user can't log in, data preserved)
- [ ] DB migration: add `role` column to `user_profiles` (`'admin'` | `'user'`, default `'user'`)
- [ ] Backend: admin-only JWT filter check (extract role from `user_profiles`, return 403 for non-admins)
- [ ] Backend: `GET /api/v1/admin/stats` endpoint returning aggregated platform stats
- [ ] Backend: `GET /api/v1/admin/users` endpoint with search, filter, pagination
- [ ] Backend: `GET /api/v1/admin/users/{id}` endpoint returning user detail with quiz history
- [ ] Backend: `PATCH /api/v1/admin/users/{id}/role` endpoint for role changes
- [ ] Backend: `PATCH /api/v1/admin/users/{id}/deactivate` endpoint for soft deactivation

### Out of Scope

- Question/lesson CRUD — deferred to a future iteration, not in this phase
- Exam session management — not needed yet
- Bulk user import/export — overkill for founders-only admin
- Real-time dashboard updates — static refresh is fine
- Student-facing features — this dashboard is admin-only

## Context

NerdQuiz is a 2-week MVP built by 8 developers. The existing stack is React + Tailwind + React Router v7 (frontend), Spring Boot + Java 25 (backend), Supabase Postgres (database), Supabase Auth (JWT). The `/admin` route and `AdminDashboard` component are already stubbed in the frontend routing. The architecture-boundaries doc already specifies the admin auth pattern: role in `user_profiles.role`, checked in JWT filter. The `user_profiles` table currently lacks the `role` column — a migration is needed.

## Constraints

- **Same SPA**: Admin dashboard lives inside `src/web/`, not a separate app
- **Founders-only**: No multi-admin-role complexity — just admin vs. user
- **Existing patterns**: Follow established API conventions (`/api/v1/...`, RFC 7807 errors) and React patterns (hooks, Tailwind, React Router)
- **Supabase Auth**: Admin role verified via JWT + backend filter, not a separate auth system
- **Week 2 timeline**: This is a public demo feature — ship functional, not perfect

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Same SPA, not separate app | Simpler deploy, one codebase, founders are power users | — Pending |
| Role column on user_profiles | Matches existing schema pattern, RLS-friendly | — Pending |
| Backend-enforced admin check | Security: never trust frontend-only role checks | — Pending |
| Question CRUD deferred | Users + stats are higher priority for founders | — Pending |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):
1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):
1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---
*Last updated: 2026-07-15 after initialization*
