# Pitfalls Research

**Domain:** Admin dashboard added to existing React + Spring Boot + Supabase app
**Researched:** 2026-07-15
**Confidence:** HIGH

## Critical Pitfalls

### Pitfall 1: JWT Filter Hardcodes ROLE_USER -- Admin Authorization Silently Fails

**What goes wrong:**
The current `JwtAuthenticationFilter` (line 65) hardcodes every authenticated user as `ROLE_USER`:
```java
List.of(new SimpleGrantedAuthority("ROLE_USER"))
```
If backend admin endpoints use `@PreAuthorize("hasRole('ADMIN')")`, every call returns 403 -- even for actual admins. The role never enters the Spring Security context because the filter never reads `user_profiles.role`.

**Why it happens:**
The original auth setup was built for a single-role app (everyone is a user). When adding admin, developers focus on the new admin endpoints and forget that the JWT filter is the single point where roles enter the security context.

**How to avoid:**
Modify `JwtAuthenticationFilter.doFilterInternal()` to query `user_profiles.role` after extracting the user ID from the JWT. Load the role and map it to the corresponding Spring Security authority (`ROLE_ADMIN` or `ROLE_USER`). Alternatively, enable `@EnableMethodSecurity` in the Spring Boot config and use `@PreAuthorize("hasRole('ADMIN')")` on admin service/controller methods -- but only after the filter is fixed to emit the correct authority.

The modification must happen in the filter, NOT in individual controllers. Controllers that manually check role are fragile and easy to forget on new endpoints.

**Warning signs:**
- Admin endpoints return 403 even for users with `role = 'admin'` in the database
- `SecurityContextHolder.getContext().getAuthentication().getAuthorities()` only shows `ROLE_USER`
- Writing `if` role checks inside controllers instead of using `@PreAuthorize`

**Phase to address:**
Phase 1 (Backend auth infrastructure) -- this is foundational; everything else depends on it.

---

### Pitfall 2: Supabase RLS Blocks Admin Cross-User Data Access

**What goes wrong:**
Every user-data table has RLS policies like `auth.uid() = user_id` -- users can only see their own rows. The admin dashboard needs to read ALL users' quiz sessions, exam results, and profiles. If admin endpoints try to fetch data through direct Supabase client calls (like the frontend does for MistakeGarden and ExamPage), RLS silently returns empty results. The admin sees zero users, zero quizzes -- not an error, just empty data.

**Why it happens:**
Several existing features (MistakeGarden, ExamPage, LessonPage) bypass the backend and call Supabase directly from the frontend. Developers may copy this pattern for admin data queries, not realizing RLS will block cross-user reads.

**How to avoid:**
Admin data access MUST go through the Spring Boot backend, which connects to Postgres directly via JdbcTemplate or JPA (not through the Supabase JS client). The backend's database connection uses a service-level Postgres user that bypasses RLS. This is already the pattern used by `UserService.updateUserStreak()` -- follow that pattern.

Never use the Supabase anon key or the frontend Supabase client for admin queries. Never use `SUPABASE_SERVICE_ROLE_KEY` in the frontend either.

**Warning signs:**
- Admin stats return 0 for all counts despite having real data
- Adding RLS policies like "admins can see everything" to Supabase -- this is a band-aid that leaks the role check to the DB layer and is hard to audit
- Frontend code calling `supabase.from('quiz_sessions').select('*')` in admin components

**Phase to address:**
Phase 1 (Backend auth) and Phase 2 (Admin API endpoints) -- the backend queries must be designed to bypass RLS from the start.

---

### Pitfall 3: Supabase JWT Does Not Contain Custom Role Claim

**What goes wrong:**
Supabase Auth JWTs contain standard claims (`sub`, `email`, `exp`, etc.) but do NOT include custom columns from `user_profiles` by default. The `role` column added to `user_profiles` is invisible to the JWT. This means:
1. The JWT filter cannot read the role from the token -- it must make a separate database query.
2. If developers assume the role is in the JWT (a common assumption), admin checks silently fail.

**Why it happens:**
Developers accustomed to auth systems where roles are embedded in the token (Auth0, Keycloak) assume Supabase works the same way. Supabase does support custom JWT claims via Postgres functions, but it requires explicit setup that is non-obvious.

**How to avoid:**
Two options, ranked by simplicity for this project:

**Option A (recommended for MVP):** Query `user_profiles.role` in the JWT filter after extracting the user ID. Accept the small per-request cost (one indexed lookup by primary key UUID). For a founders-only admin dashboard with <100 requests/second, this is negligible.

**Option B (stretch):** Create a Supabase Postgres function that injects `role` into the JWT via `auth.jwt()` and `set_config()`. This embeds the role in the token so no extra query is needed. More complex to set up and requires token refresh coordination.

Do NOT store the role in localStorage or React state and send it as a custom header -- that is trivially spoofable.

**Warning signs:**
- Code that reads `jwt.getCustomClaim("role")` and gets null
- Storing admin status in `localStorage` and sending it as `X-Admin: true` header
- Making the role check only in the frontend and assuming the backend trusts it

**Phase to address:**
Phase 1 (Backend auth infrastructure).

---

### Pitfall 4: Frontend Route Guard Without Backend Enforcement

**What goes wrong:**
A new `AdminRoute` component checks `user.role === 'admin'` and redirects non-admins. But the backend endpoints (`/api/v1/admin/stats`, `/api/v1/admin/users`) don't check admin role. Any logged-in user can call these endpoints directly via curl or browser dev tools and get all platform data -- user emails, XP, activity.

**Why it happens:**
Frontend work and backend work happen in parallel. The frontend developer builds the route guard and considers it "done." The backend developer builds the API endpoint and considers it "done." Neither verifies that both layers enforce the same policy.

**How to avoid:**
Enforce admin role at THREE layers, in this priority order:
1. **Backend API filter or method security** (`@PreAuthorize("hasRole('ADMIN')")`) -- the authoritative gate. Return 403 for non-admins.
2. **Supabase RLS** (optional defense-in-depth) -- admin read policies on `user_profiles` for direct Supabase calls.
3. **Frontend route guard** -- UX convenience to redirect non-admins away from `/admin` before they see a 403 error page.

Never rely on layer 3 alone. The frontend guard is a UX improvement, not a security control.

**Warning signs:**
- Admin endpoints work without authentication when tested with curl
- No `@PreAuthorize` or role check in admin controllers/services
- Only a React route guard protects admin data

**Phase to address:**
Phase 1 (backend enforcement) before Phase 3 (frontend admin page).

---

### Pitfall 5: user_profiles Type Mismatch Silently Drops Role Data

**What goes wrong:**
The frontend `UserProfile` interface in `types/index.ts` does not include a `role` field. When the `role` column is added to `user_profiles` via migration, the `fetchUserProfile()` function in `useAuth.tsx` does `supabase.from('user_profiles').select('*').single()` -- the role data comes back from Supabase but is silently dropped because the TypeScript type doesn't have a `role` property. The frontend never knows if the user is an admin.

**Why it happens:**
Adding a database column is a backend task. Frontend developers don't always get notified, and TypeScript's structural typing means there is no compile error when extra properties are returned but not declared in the type.

**How to avoid:**
When adding the `role` column migration, simultaneously update:
1. `types/index.ts` -- add `role: 'admin' | 'user'` to `UserProfile` interface
2. `useAuth.tsx` -- no code change needed (it already does `select('*')`), but verify the role arrives
3. `useAuth.tsx` -- expose `isAdmin` derived from `user.role === 'admin'` in the AuthContextType
4. Any admin route guard -- consume `isAdmin` from `useAuth()`

**Warning signs:**
- `console.log(user)` in admin components shows no `role` property
- TypeScript compilation succeeds but admin check always evaluates to false
- The role column exists in the DB but `user.role` is `undefined` in the frontend

**Phase to address:**
Phase 1 (schema + frontend type sync).

---

### Pitfall 6: Soft-Deactivation Does Not Invalidate Active Sessions

**What goes wrong:**
Admin deactivates a user by setting `is_active = false` (or similar) in `user_profiles`. But the user's existing JWT is still valid for up to 1 hour (Supabase default token expiry). During that window, the deactivated user can still make API calls, complete quizzes, and earn XP. Worse, if the frontend caches the session, the user may not even notice they are deactivated until the token expires and refresh fails.

**Why it happens:**
Developers conflate "deactivation" with "session invalidation." In Supabase Auth, these are separate operations. Deactivating a user profile does not revoke their JWT or refresh token.

**How to avoid:**
For the MVP, accept this limitation and document it: deactivation takes effect when the JWT expires (max ~1 hour). If immediate revocation is needed later, options include:
- Calling Supabase Admin API `supabase.auth.admin.user.signOut(userId)` to revoke all sessions (requires service_role key on the backend)
- Adding an `is_active` check in the JWT filter that rejects tokens for deactivated users (requires a DB query per request -- already paying that cost for role lookup)

For the demo, the 1-hour window is acceptable. For production, implement JWT filter rejection.

**Warning signs:**
- Deactivated user can still log in and use the app until they manually sign out
- No mechanism to revoke active sessions
- `is_active` check only exists in the frontend

**Phase to address:**
Phase 2 (backend endpoints) -- implement the basic check in the JWT filter. Full revocation is a production concern.

---

### Pitfall 7: Admin Stats Queries Without Indexes Cause Slow Page Loads

**What goes wrong:**
The admin stats endpoint runs aggregation queries:
- `COUNT(DISTINCT user_id) FROM user_daily_activity WHERE activity_date >= now() - interval '7 days'`
- `COUNT(*) FROM quiz_sessions WHERE status = 'completed'`
- Per-topic engagement breakdowns via GROUP BY

Without proper indexes, these scans grow linearly with data volume. At 100 users and 1000 quiz sessions it is fast. At 10,000 users and 100,000 sessions, the stats page takes 5-10 seconds and the admin thinks the app is broken.

**Why it happens:**
Indexes are usually added for user-facing queries (lookup by user_id, filter by topic). Admin aggregation queries use different column combinations (date ranges, status filters, GROUP BY columns) that may not have matching indexes. The `user_daily_activity` table in particular needs a composite index on `(activity_date, user_id)` for the "active this week" query.

**How to avoid:**
Add indexes as part of the admin migration:
- `user_daily_activity`: composite index on `(activity_date, user_id)` for active-user counts
- `quiz_sessions`: index on `(status, created_at)` for quiz attempt counts
- `quiz_answers`: index on `(question_id)` for topic engagement breakdowns
- `exam_sessions`: index on `(status)` for exam attempt counts

Also add a query timeout (e.g., 5 seconds) to prevent admin queries from blocking the database for other users.

**Warning signs:**
- Admin dashboard takes >2 seconds to load
- `EXPLAIN ANALYZE` on admin queries shows sequential scans on large tables
- The backend logs slow query warnings for admin endpoints

**Phase to address:**
Phase 2 (admin API endpoints) -- include index creation in the migration.

---

## Technical Debt Patterns

Shortcuts that seem reasonable but create long-term problems.

| Shortcut | Immediate Benefit | Long-term Cost | When Acceptable |
|----------|-------------------|----------------|-----------------|
| Check admin role only in frontend | Faster to build, no backend changes | Any user can call admin APIs directly via curl | Never -- security vulnerability |
| Use Supabase service_role key in frontend | Bypasses RLS, simpler admin queries | Exposes full database access to anyone with browser dev tools | Never -- catastrophic security risk |
| Skip pagination on admin user list | Simpler code, faster to build | Memory exhaustion and slow responses at scale (< 100 users is fine) | Only if user count is guaranteed < 100 |
| Hardcode admin email check instead of role column | No migration needed, immediate | Doesn't scale, can't change without code deploy, mixes auth concerns | Never -- use a proper role column |
| Add `@PreAuthorize` to controllers only, not services | Faster, visible at the endpoint layer | Business logic called from other services bypasses the check | Only for truly thin controllers with no reused logic |
| Cache admin role in frontend localStorage | Avoids re-checking on every navigation | Stale role data if admin is demoted; requires cache invalidation logic | Never -- derive from useAuth() context |

## Integration Gotchas

Common mistakes when connecting to external services.

| Integration | Common Mistake | Correct Approach |
|-------------|----------------|------------------|
| Supabase Auth + custom role | Assume role is in the JWT without verifying | Check `supabase.auth.getJWT()` or decode the token; if role is missing, query `user_profiles` separately |
| Supabase RLS + admin queries | Try to add "admin bypass" RLS policies | Route admin queries through the backend (JdbcTemplate/JPA), which bypasses RLS by connecting as the Postgres superuser |
| Spring Security + Supabase JWT | Assume Spring Security auto-maps JWT claims to authorities | The current JwtFilter manually sets authorities; you must modify it to include the admin role |
| Frontend `useAuth()` + role | Forget to update the `AuthContextType` interface | When adding `role` to `user_profiles`, update `UserProfile` type AND add `isAdmin` to the context |
| React Router + admin routes | Nest admin routes inside `<ProtectedRoute>` without additional role check | Create `AdminRoute` that wraps `ProtectedRoute` and adds role verification |

## Performance Traps

Patterns that work at small scale but fail as usage grows.

| Trap | Symptoms | Prevention | When It Breaks |
|------|----------|------------|----------------|
| Unbounded user list query | Memory spike, slow response as users grow | Always use `Pageable` + `Page<T>` on `GET /api/v1/admin/users` from day one | ~500 users |
| COUNT(*) without WHERE on large tables | Stats endpoint slows down as quiz_sessions grows | Use date-bounded queries; add indexes on filter columns | ~10K quiz sessions |
| N+1 query loading user profiles in a loop | User list endpoint fires 1 query per user for profile data | Use a single JOIN query or `@EntityGraph` to load profiles in one shot | ~100 users per page |
| Repeated aggregation on every request | Stats page feels slow on every visit | Cache aggregation results for 30-60 seconds (simple in-memory cache is fine for MVP) | Any scale -- even 10 users notice 2-second delays |
| Frontend fetches all users to search client-side | Browser tab freezes with large datasets | Do search/filter on the backend via query parameters | ~200 users |

## Security Mistakes

Domain-specific security issues beyond general web security.

| Mistake | Risk | Prevention |
|---------|------|------------|
| Admin role check only in React route guard | Any logged-in user can call admin API endpoints directly | Backend must enforce `@PreAuthorize("hasRole('ADMIN')")` on all admin endpoints |
| Sending `X-Admin: true` header from frontend | Trivially spoofable; provides zero security | Never trust client-supplied role claims; derive from JWT + database lookup |
| Exposing user emails in admin user list without access logging | Privacy violation; no audit trail for who viewed what | Log admin access to user data (even a simple structured log line is enough for MVP) |
| Admin can deactivate their own account | Locks out the only admin; no recovery path | Prevent self-deactivation: `if (targetUserId.equals(currentUserId)) return 403` |
| Admin can change their own role to admin (no-op) or another admin's role to user | Accidental lockout; no role-change audit trail | Log all role changes; consider preventing self-demotion for MVP |
| SQL injection in admin search endpoint | If search parameter is concatenated into SQL instead of using parameterized queries | Always use `?` placeholders in JdbcTemplate or `@Query` with named parameters |
| Admin stats endpoint leaks user-level data | Aggregated stats should not include individual user identifiers | Design response DTOs to return only aggregate numbers, never individual user data in stats endpoint |

## UX Pitfalls

Common user experience mistakes in this domain.

| Pitfall | User Impact | Better Approach |
|---------|-------------|-----------------|
| No loading state on admin dashboard | Admin sees blank page and refreshes repeatedly, creating more load | Show skeleton loaders during data fetch |
| 403 error page looks like a crash | Admin thinks the app is broken, not that they lack permission | Dedicated "Access Denied" page with clear message and link back to home |
| Admin dashboard in the main sidebar navigation | Non-admin users see a link they cannot use, causing confusion | Conditionally render admin nav items only when `user.role === 'admin'` |
| Confirmation dialog missing on deactivation | Admin accidentally deactivates a user | Require explicit confirmation: "Type the user's email to confirm deactivation" |
| No success feedback after role change | Admin changes a role and doesn't know if it worked | Show a toast notification: "Role updated for [email]" |
| Admin user list doesn't show current page / total count | Admin doesn't know how many users there are total | Show "Showing 1-20 of 147 users" in the pagination footer |

## "Looks Done But Isn't" Checklist

Things that appear complete but are missing critical pieces.

- [ ] **Admin route guard:** Route guard redirects non-admins, but backend returns 200 for non-admin requests -- verify with curl that `GET /api/v1/admin/stats` returns 403 without admin JWT
- [ ] **Role migration:** `role` column exists in `user_profiles`, but no user has `role = 'admin'` yet -- verify by running `UPDATE user_profiles SET role = 'admin' WHERE id = '<founder-uuid>'`
- [ ] **Admin stats endpoint:** Returns numbers, but the numbers are all 0 because the aggregation queries use wrong table names or missing WHERE clauses -- verify against actual seeded data
- [ ] **User deactivation:** Sets `is_active = false`, but the login flow doesn't check `is_active` -- verify that deactivated users get a meaningful error on login, not a generic "invalid credentials"
- [ ] **Frontend admin type:** `UserProfile` type includes `role`, but `useAuth()` doesn't expose `isAdmin` -- verify that admin components can access role info without casting
- [ ] **Pagination:** User list appears to work, but requesting page 100 with 10 users per page still loads all rows from the database -- verify with `EXPLAIN ANALYZE` that pagination is DB-level, not in-memory
- [ ] **CORS:** Admin endpoints work from the frontend, but CORS config only allows the frontend origin -- verify that admin API calls from other origins are blocked
- [ ] **Error handling:** Admin endpoints return RFC 7807 errors for 403, but the frontend shows raw JSON error text instead of a user-friendly message -- verify error display in the UI

## Recovery Strategies

When pitfalls occur despite prevention, how to recover.

| Pitfall | Recovery Cost | Recovery Steps |
|---------|---------------|----------------|
| JWT filter doesn't emit admin role | LOW | Modify `JwtAuthenticationFilter` to query `user_profiles.role` and add `ROLE_ADMIN` authority. Deploy and restart. |
| RLS blocks admin data access | LOW | Move admin queries to backend JdbcTemplate/JPA. No schema change needed -- just code refactor. |
| Frontend type missing `role` field | LOW | Add `role` to `UserProfile` interface, rebuild frontend. |
| Admin endpoints lack backend role check | MEDIUM | Add `@PreAuthorize("hasRole('ADMIN')")` to admin controllers. Test each endpoint. Requires understanding all admin endpoints. |
| Soft-deactivated user still active | MEDIUM | Add `is_active` check in JWT filter. Requires re-querying `user_profiles` per request (already doing this for role). Token remains valid but is rejected. |
| Admin accidentally locked out (self-deactivation) | HIGH | Manually UPDATE the database to restore admin role. If no direct DB access, use Supabase SQL editor. Prevention is cheaper. |
| Stats queries too slow in production | MEDIUM | Add targeted indexes. May require a brief maintenance window if table is large. |
| Role change not logged | LOW | Add logging to role-change endpoint. Retroactive audit is impossible without logs. |

## Pitfall-to-Phase Mapping

How roadmap phases should address these pitfalls.

| Pitfall | Prevention Phase | Verification |
|---------|------------------|--------------|
| JWT filter hardcodes ROLE_USER | Phase 1: Backend auth infra | Unit test: admin user gets `ROLE_ADMIN` authority after filter |
| RLS blocks admin queries | Phase 1: Backend auth infra | Integration test: admin endpoint returns data for all users |
| JWT missing role claim | Phase 1: Backend auth infra | Decode a test JWT; confirm role is loaded from DB, not token |
| Frontend type missing role | Phase 1: Schema + types | TypeScript compiles; `user.role` is defined in admin components |
| Frontend-only route protection | Phase 1: Backend auth infra | curl test: non-admin JWT gets 403 on admin endpoints |
| Deactivated user still active | Phase 2: Admin endpoints | Test: deactivate user, verify they cannot log in after JWT expiry |
| Stats queries slow | Phase 2: Admin endpoints | EXPLAIN ANALYZE on stats queries shows index scans, not seq scans |
| Admin self-deactivation | Phase 2: Admin endpoints | Test: admin tries to deactivate self, gets 403 |
| UX issues (loading, error, empty states) | Phase 3: Frontend admin page | Manual QA: test all admin pages with slow network, empty data, non-admin user |

## Sources

- Codebase analysis: `JwtAuthenticationFilter.java` (hardcoded ROLE_USER), `SecurityConfig.java`, `JwtUtil.java`, `useAuth.tsx`, `ProtectedRoute.tsx`, `UserProfile.ts` types, `003_create_user_profiles.sql` (RLS policies), `UserService.java` (JdbcTemplate pattern)
- Spring Security 6.5 Reference: Method Security with `@PreAuthorize` -- https://docs.spring.io/spring-security/reference/6.5/servlet/authorization/method-security.html
- Supabase Auth documentation: JWT claims, RLS policies, service role key usage
- Common RBAC pitfalls in React apps: client-side-only auth, localStorage role storage, missing route guards
- N+1 query patterns in Spring Data JPA: `@EntityGraph`, `JOIN FETCH`, DTO projections

---
*Pitfalls research for: Admin dashboard added to existing NerdQuiz app*
*Researched: 2026-07-15*
