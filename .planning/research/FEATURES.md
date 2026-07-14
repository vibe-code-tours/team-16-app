# Feature Landscape — NerdQuiz Admin Dashboard

**Domain:** Edtech admin dashboard for gamified learning platform (founders-only)
**Researched:** 2026-07-15
**Context:** Subsequent milestone — adding admin features to existing NerdQuiz app. 2-week MVP by 8 devs, React + Spring Boot + Supabase stack.

## Table Stakes

Features founders expect in a minimum admin panel. Missing any of these makes the dashboard feel incomplete or untrustworthy.

| Feature | Why Expected | Complexity | Notes |
|---------|--------------|------------|-------|
| **Route guard (admin-only access)** | Without this, the dashboard is a security hole. Non-admin users must never see admin data. | Low | Requires `role` column on `user_profiles` + backend JWT filter check + frontend route guard. Already specified in architecture-boundaries.md. |
| **Total user count** | The single "is this thing alive?" metric. Founders will check this compulsively. | Low | Simple `COUNT(*)` on `user_profiles`. Data already exists. |
| **Active users (last 7 days)** | Distinguishes signups from actual usage. Dead signups are vanity. | Low | Query `user_daily_activity` for distinct users in last 7 days. Table already exists with `activity_date`. |
| **Quiz completion count** | Core engagement metric — are people actually using the learning flow? | Low | `COUNT(*)` on `quiz_sessions WHERE status = 'completed'`. Table exists. |
| **Exam completion count** | Secondary engagement metric — how many are doing full simulations? | Low | `COUNT(*)` on `exam_sessions WHERE status = 'completed'`. Table exists. |
| **User list with search** | Founders need to look up specific users (debugging, support, "who is this person?"). | Medium | Paginated table, search by display_name or email (join with `auth.users` via backend). Filter by role. Requires backend endpoint. |
| **User detail view** | Click a user, see their full profile: XP, streak, join date, quiz history, exam history. | Medium | Aggregate from `user_profiles`, `user_stats`, `quiz_sessions`, `exam_sessions`. Single user page with sub-sections. |
| **Role management (assign/remove admin)** | Founders need to grant admin access to new team members. Only way to bootstrap admin access beyond the initial seed. | Low | `PATCH /api/v1/admin/users/{id}/role` — flip between `'admin'` and `'user'`. Simple column update. |
| **Account deactivation** | Founders need to disable problematic accounts without deleting data. | Low | Soft-deactivate: add `is_active BOOLEAN DEFAULT true` to `user_profiles`. Backend checks `is_active` during JWT filter. User can't log in but data is preserved. |

## Differentiators

Features that go beyond a basic stats page. Not strictly required for Week 2, but would make the dashboard genuinely useful for understanding platform health. Prioritized by value for founders.

| Feature | Value Proposition | Complexity | Notes |
|---------|-------------------|------------|-------|
| **Daily active users over time (chart)** | Trend lines reveal growth or decline. A single "active this week" number hides whether yesterday had 2 users or 20. | Medium | Line chart of `user_daily_activity` grouped by `activity_date`. Use Recharts (already common in React ecosystem). Requires frontend charting library. |
| **Topic category engagement breakdown** | Shows which FE syllabus areas users engage with most — informs content prioritization. | Medium | Join `quiz_answers` -> `questions` -> `question_subtopics` -> `subtopics` -> `topics`. Group by topic name, count attempts and correct rate. |
| **Quiz score distribution** | Are users mostly passing or failing? A platform where everyone scores 90% has different problems than one where everyone scores 30%. | Medium | Histogram of `quiz_sessions.score` bucketed into ranges. Simple SQL aggregation. |
| **Recent activity feed** | "What just happened?" — last 10 signups, last 10 quiz completions. Gives a pulse without requiring chart interpretation. | Low | Two simple sorted queries: recent `user_profiles.created_at` + recent `quiz_sessions.completed_at`. Display as a timeline. |
| **Question difficulty analysis** | Shows how `difficulty_score` distribution maps to actual correctness rates. Validates whether the rule-based difficulty assignment is working. | Medium | Join `questions` with `quiz_answers`. Group by difficulty bucket, compute avg correctness. Helps founders know if question calibration is off. |
| **XPEarnings leaderboard (top users)** | Quick view of most engaged users — useful for identifying power users and potential ambassadors. | Low | `SELECT display_name, total_xp FROM user_stats JOIN user_profiles ORDER BY total_xp DESC LIMIT 20`. |
| **Streak leaderboard (longest streaks)** | Gamification health check — are streaks motivating consistent usage? | Low | Same as above, ordered by `longest_streak`. |

## Anti-Features

Features to explicitly NOT build in this phase. Each would be valuable eventually but is wrong for a founders-only admin panel on a 2-week MVP.

| Anti-Feature | Why Avoid | What to Do Instead |
|--------------|-----------|-------------------|
| **Question/lesson CRUD** | Content management is a separate product surface. Building a CMS inside the admin panel would take weeks, and content is currently managed via SQL migrations + seed scripts which work fine for 180 questions. | Defer to a future "Content Manager" feature. The existing extraction pipeline + SQL is the workflow for now. |
| **Real-time updates (WebSockets, polling)** | Admin dashboard is checked a few times a day, not continuously. WebSocket infrastructure adds complexity with zero user-facing value. | Static data with manual refresh. Show a "last updated" timestamp. |
| **Bulk user import/export (CSV)** | Overkill for <50 users. Founders can use Supabase dashboard directly for bulk operations. | Direct database access via Supabase dashboard for edge cases. |
| **Custom date range filtering** | Adds significant UI + query complexity. "Last 7 days" covers 90% of founder needs for an MVP. | Fixed time periods: today, last 7 days, last 30 days, all time. |
| **Email/notification sending to users** | Communication features require careful UX (opt-in, unsubscribe, templates). Wrong scope for this milestone. | Use Supabase dashboard or direct email for the rare case. |
| **Audit log of admin actions** | With 1-2 founders, accountability tracking is unnecessary. | Defer. If more admins join, this becomes important. |
| **Multi-admin role hierarchy** | The decision is already made: admin vs. user. Introducing roles like "super-admin", "moderator", "analyst" adds complexity with zero benefit for a 2-person founding team. | Keep it binary: admin or user. |
| **API usage/analytics** | The API is internal — not a developer platform. API metrics are a DevOps concern, not a product dashboard concern. | Monitor via server logs if needed. |
| **Automated report generation (email PDFs)** | Report delivery infrastructure is a separate feature. Founders can just open the dashboard. | Manual dashboard viewing. |
| **Third-party analytics integration (Mixpanel, Amplitude)** | The platform already tracks everything needed in existing DB tables. Adding analytics SDKs creates data silos and privacy concerns. | Use the custom dashboard with data from existing tables. |

## Feature Dependencies

```
Migration: add role column to user_profiles
    |
    v
Backend: admin JWT filter (check role in user_profiles)
    |
    +---> Backend: GET /api/v1/admin/stats (depends on filter)
    +---> Backend: GET /api/v1/admin/users (depends on filter)
    +---> Backend: GET /api/v1/admin/users/{id} (depends on filter)
    +---> Backend: PATCH /api/v1/admin/users/{id}/role (depends on filter)
    +---> Backend: PATCH /api/v1/admin/users/{id}/deactivate (depends on filter)

Migration: add is_active column to user_profiles
    |
    v
Backend: JWT filter checks is_active (rejects deactivated users)
    |
    v
Frontend: PATCH /api/v1/admin/users/{id}/deactivate (calls above endpoint)

Frontend: admin route guard (depends on user_profiles.role being queryable)
    |
    +---> Frontend: AdminDashboard (stats overview page)
    +---> Frontend: UserList page (depends on GET /admin/users)
    +---> Frontend: UserDetail page (depends on GET /admin/users/{id})

Charts (Recharts): can be added independently after stats endpoint exists
    |
    +---> DAU over time chart
    +---> Topic engagement chart
    +---> Score distribution chart
```

## What the DB Already Supports (No New Tables Needed)

The existing schema is surprisingly rich. Most admin queries can run against existing tables:

| Data Need | Source Table(s) | Columns Available |
|-----------|-----------------|-------------------|
| Total users | `user_profiles` | `id`, `created_at` |
| Active users | `user_daily_activity` | `user_id`, `activity_date` |
| Quiz attempts | `quiz_sessions` | `user_id`, `status`, `score`, `xp_earned`, `started_at`, `completed_at` |
| Exam attempts | `exam_sessions` | `user_id`, `status`, `score_percentage`, `started_at`, `completed_at` |
| Topic engagement | `quiz_answers` + `questions` + `question_subtopics` + `subtopics` + `topics` | Join chain for topic-level aggregation |
| User XP/streak | `user_stats` | `total_xp`, `current_streak`, `longest_streak`, `quizzes_completed`, `exams_completed` |
| User daily activity | `user_daily_activity` | `questions_answered`, `xp_earned` per day |
| Mastery data | `user_subtopic_mastery` | `mastery_score`, `questions_seen`, `questions_correct` per subtopic |
| Mistake data | `mistakes` | `mistake_count`, `review_count`, `resolved_at` per user-question |

**Only 2 new columns needed** (no new tables):
1. `user_profiles.role TEXT NOT NULL DEFAULT 'user'` — admin access control
2. `user_profiles.is_active BOOLEAN NOT NULL DEFAULT true` — soft deactivation

## MVP Recommendation

Prioritize in this order:

1. **Migration + backend JWT filter** — foundation for everything else. Without role enforcement, no admin feature is safe.
2. **Stats overview page** (total users, active users, quiz/exam counts) — the "is it alive?" answer in 5 seconds.
3. **User list with search + user detail view** — the "who is using this?" answer.
4. **Role management** — so the second founder can get admin access.
5. **Account deactivation** — safety net for problematic accounts.

Defer to stretch:
- Charts (Recharts) — nice to have but a table of numbers works fine for MVP
- Topic engagement breakdown — interesting but not urgent
- Score distribution — analytical, not operational

**Defer entirely:**
- Question/lesson CRUD — separate product surface
- Real-time updates — unnecessary for <50 users
- Bulk import/export — Supabase dashboard covers this

## Sources

- Project context: `.planning/PROJECT.md`, `docs/REQUIREMENTS.md`, `docs/gsd/feature-board.md`
- Database schema: `supabase/migrations/001_initial_schema.sql`, `003_create_user_profiles.sql`
- Architecture decisions: `docs/gsd/architecture-boundaries.md`, `docs/gsd/decision-log.md`
- Existing codebase patterns: `src/web/src/App.tsx`, `.claude/rules/backend.md`, `.claude/rules/frontend.md`
- Domain knowledge: Edtech admin dashboard patterns (MEDIUM confidence — based on training data, not live web verification)
- Startup admin panel patterns: Founders-only SaaS dashboard conventions (MEDIUM confidence)
