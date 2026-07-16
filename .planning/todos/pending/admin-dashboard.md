---
title: Admin Dashboard — Platform Usage Stats
date: 2026-07-15
priority: medium
status: pending
---

## Context

NerdQuiz has no way to see how many users are on the platform or how they're using it.
All the data already exists in the DB (quiz_sessions, exam_sessions, user_daily_activity,
user_profiles) — this is purely an aggregation + display problem.

The only schema change needed is a `role` column on `user_profiles`.

## Tasks

### 1. Migration: Add `role` column to `user_profiles`

- Add `role TEXT NOT NULL DEFAULT 'user'` to `user_profiles`
- Valid values: `'admin'`, `'user'`
- Seed the first admin user (manual UPDATE after migration)
- Update RLS policies: admin reads require admin role

### 2. Backend: Expose admin role from JWT filter

- Read `role` from `user_profiles` during JWT authentication
- Attach role to the security context so controllers can check it
- Create `@PreAuthorize` or utility method for admin-only endpoints

### 3. Backend: Admin stats API endpoint

- `GET /api/v1/admin/stats` — aggregate stats:
  - `totalUsers`: COUNT from `user_profiles`
  - `activeToday`: COUNT from `user_daily_activity` where `activity_date = today`
  - `activeThisWeek`: COUNT distinct users in `user_daily_activity` last 7 days
  - `totalQuizAttempts`: COUNT from `quiz_sessions` where `status = 'completed'`
  - `totalExamAttempts`: COUNT from `exam_sessions` where `status = 'completed'`
  - `topicEngagement`: per-topic breakdown from quiz/exam answers
- Require admin role — return 403 for non-admins

### 4. Frontend: Admin dashboard page

- Route: `/admin` (protected — redirect non-admins)
- Stats summary cards: total users, active today, quiz attempts, exam attempts
- Topic engagement table/chart (simple table is fine for v1)
- Responsive, Tailwind, follows existing component patterns

### 5. Frontend: Route protection

- Check user role in route guard or layout
- Redirect non-admin users to `/` or show "not authorized"

## Design decisions

- **Stats summary page, not full admin panel** — ship quickly, grow later
- **Role column on user_profiles** — simplest approach, no extra tables
- **No new tracking tables** — all analytics data already exists in schema
- **Aggregation via SQL** — backend computes stats, frontend just displays

## Depends on

- Feature #1 (user registration) — must exist for user_profiles to have data
- Feature #5 (XP tracking) — quiz_sessions must be populated for stats to be meaningful
