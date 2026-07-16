# Project Research Summary

**Project:** NerdQuiz Admin Dashboard
**Domain:** Edtech admin dashboard (founders-only) added to existing gamified learning platform
**Researched:** 2026-07-15
**Confidence:** HIGH

## Executive Summary

The NerdQuiz admin dashboard is a founders-only analytics and user management panel for an existing React + Spring Boot + Supabase education platform. The existing codebase is well-structured with clear separation of concerns, but it was built as a single-role application -- every authenticated user is `ROLE_USER`. Adding admin functionality requires modifying the JWT authentication filter to perform conditional role lookups, enforcing admin authorization at the backend security layer, and building 5 new frontend routes backed by 5 new backend endpoints. The database schema needs only 2 new columns (`role` and `is_active` on `user_profiles`) and no new tables, which keeps the migration low-risk.

The recommended approach is a strictly ordered build: database migration first, then backend security modifications, then backend admin endpoints, then frontend pages. This order is dictated by hard dependencies -- the JWT filter cannot emit `ROLE_ADMIN` without the `role` column existing, and admin endpoints cannot return data without the security layer being in place. The frontend admin pages depend on working backend APIs. Only 4 new frontend dependencies are needed (recharts, react-is, @tanstack/react-table v8, date-fns v4), all well-established libraries with confirmed React 19 compatibility.

The critical risk is that the current JWT filter hardcodes `ROLE_USER` for all authenticated users, which means any admin role check will silently fail with 403 errors until the filter is modified. A second major risk is that frontend-only route guards provide zero security -- the backend must enforce admin authorization independently. A third risk is that Supabase RLS blocks cross-user data access on direct frontend calls, so all admin data queries must go through the Spring Boot backend which bypasses RLS via direct JDBC. All three risks are well-understood with clear prevention strategies identified in the pitfalls research.

## Key Findings

### Recommended Stack

Four new packages are needed. The existing component library (Card, Badge, Button, ProtectedRoute), styling system (Tailwind + CVA + clsx/merge), and icon library (lucide-react) are all reusable for the admin dashboard with no additions.

**Core technologies:**
- **recharts ^3.9.2**: Bar/line/pie charts for analytics -- declarative React components, SVG-based, React 19 peer dep confirmed
- **@tanstack/react-table ^8.21.3**: Headless data table with server-side pagination and filtering -- stable v8 API, not v9 beta
- **date-fns ^4.4.0**: Date formatting and relative time -- tree-shakeable, TypeScript native, ESM-compatible
- **react-is ^19.2.7**: Peer dependency required by recharts -- must match React 19 major version

**Avoid:** antd, @tremor/react, react-admin, MUI DataGrid (all conflict with existing Tailwind component system). Avoid TanStack Query for now (only ~5 endpoints, not worth the abstraction). Avoid TanStack Table v9 (beta with breaking API changes).

### Expected Features

**Must have (table stakes):**
- Route guard (admin-only access) -- security foundation; requires `role` column + backend JWT filter change + frontend AdminRoute
- Total user count -- basic "is it alive?" metric; simple `COUNT(*)`
- Active users (last 7 days) -- distinguishes signups from real usage; query `user_daily_activity`
- Quiz completion count -- core engagement metric
- Exam completion count -- secondary engagement metric
- User list with search -- paginated table with role filter; needs backend endpoint
- User detail view -- profile + quiz/exam history for a single user
- Role management -- assign/remove admin; `PATCH /api/v1/admin/users/{id}/role`
- Account deactivation -- soft-delete via `is_active` flag

**Should have (stretch / time permitting):**
- Daily active users over time chart (Recharts line chart)
- Topic category engagement breakdown
- Quiz score distribution histogram
- Recent activity feed (last 10 signups + completions)
- XP and streak leaderboards

**Explicitly deferred (anti-features):**
- Question/lesson CRUD (separate product surface)
- Real-time updates / WebSockets (unnecessary for <50 users)
- Bulk user import/export (Supabase dashboard covers this)
- Custom date range filtering (fixed periods are sufficient)
- Audit log, multi-admin hierarchy, automated reports, third-party analytics

### Architecture Approach

The admin dashboard integrates into the existing architecture by modifying 3 components (JwtAuthenticationFilter, SecurityConfig, Sidebar), adding 2 new backend classes (AdminController, AdminService), and adding 5 new frontend routes/pages. All admin data access goes through the Spring Boot backend via JdbcTemplate, which bypasses Supabase RLS by connecting directly to Postgres. The frontend never calls Supabase directly for admin data. The JWT filter performs a conditional role lookup only for `/api/v1/admin/**` paths, keeping the per-request DB query cost isolated to admin requests.

**Major components:**
1. **Database migration** -- Adds `role TEXT` and `is_active BOOLEAN` to `user_profiles`, plus indexes for admin query performance
2. **JwtAuthenticationFilter (modified)** -- Queries `user_profiles.role` on admin paths and emits `ROLE_ADMIN` authority
3. **AdminService + AdminController** -- 5 endpoints: stats, user list, user detail, role change, deactivation
4. **AdminRoute (frontend)** -- Composes with existing ProtectedRoute to add role check; redirects non-admins to `/map`
5. **Admin pages** -- AdminDashboard (stats), AdminUserList (paginated table), AdminUserDetail (profile + history)

### Critical Pitfalls

1. **JWT filter hardcodes ROLE_USER** -- The single biggest blocker. Every admin endpoint will return 403 until `JwtAuthenticationFilter.doFilterInternal()` is modified to query `user_profiles.role` and emit `ROLE_ADMIN` for admin users. This must be the first code change after the migration.

2. **Supabase RLS blocks cross-user data access** -- Admin stats and user management require reading ALL users' data. Frontend Supabase calls are subject to RLS policies (`auth.uid() = user_id`). All admin queries must go through the backend's JDBC connection which bypasses RLS. Never use the Supabase JS client for admin data.

3. **Frontend route guard without backend enforcement** -- An `AdminRoute` component is UX only. The backend must independently enforce `@PreAuthorize("hasRole('ADMIN')")` or SecurityConfig `.hasRole("ADMIN")` on admin endpoints. Without this, any authenticated user can call admin APIs via curl.

4. **Frontend type mismatch drops role data** -- When the `role` column is added to the DB, the `UserProfile` TypeScript interface in `types/index.ts` must also be updated to include `role: 'admin' | 'user'`. Otherwise the role data is silently dropped and `user.role` is `undefined` in the frontend.

5. **Stats queries without indexes cause slow loads** -- The admin aggregation queries (COUNT DISTINCT over date ranges, GROUP BY for topic engagement) need composite indexes on `user_daily_activity(activity_date, user_id)`, `quiz_sessions(status, created_at)`, and `quiz_answers(question_id)`.

## Implications for Roadmap

Based on research, suggested phase structure:

### Phase 1: Schema + Backend Security Foundation
**Rationale:** This is the non-negotiable foundation. Nothing works without the role column, and no admin feature is safe without backend role enforcement. The JWT filter modification is the single most critical code change.
**Delivers:** Database migration with `role` + `is_active` columns and indexes; modified `JwtAuthenticationFilter` that emits `ROLE_ADMIN` for admin users; modified `SecurityConfig` that enforces `.hasRole("ADMIN")` on `/api/v1/admin/**`; updated `UserProfile` TypeScript type with `role` field.
**Addresses:** Route guard foundation, role management foundation, account deactivation foundation
**Avoids:** Pitfall #1 (hardcoded ROLE_USER), Pitfall #3 (missing role claim), Pitfall #4 (frontend-only guard), Pitfall #5 (type mismatch)
**Research flags:** LOW risk -- all patterns are well-documented Spring Security + React conventions. No research-phase needed.

### Phase 2: Backend Admin Endpoints
**Rationale:** Backend endpoints depend on Phase 1's security infrastructure. Stats endpoint is simpler than user management, so it should be built first to validate the full stack end-to-end.
**Delivers:** `AdminController` + `AdminService` with 5 endpoints: `GET /api/v1/admin/stats`, `GET /api/v1/admin/users` (paginated), `GET /api/v1/admin/users/{id}`, `PATCH /api/v1/admin/users/{id}/role`, `PATCH /api/v1/admin/users/{id}/deactivate`. DTOs as Java records.
**Uses:** JdbcTemplate (consistent with existing UserService pattern), Java records for DTOs, RFC 7807 error responses
**Implements:** AdminService (stats aggregation via SQL), AdminController (thin REST layer)
**Avoids:** Pitfall #2 (RLS blocking -- all queries go through backend JDBC), Pitfall #6 (deactivation -- `is_active` check in JWT filter), Pitfall #7 (slow queries -- indexes created in Phase 1 migration)
**Research flags:** LOW risk -- standard Spring Boot CRUD patterns. Consider a research-phase only if topic engagement queries get complex (multi-table JOINs through quiz_answers -> questions -> subtopics -> topics).

### Phase 3: Frontend Admin Dashboard (Stats + User List)
**Rationale:** Frontend depends on working backend APIs from Phase 2. Stats overview (read-only) is simpler than user management (write operations), so build it first. User list is the second priority because founders need to look up users.
**Delivers:** `AdminRoute` guard component, `AdminDashboard` page (stat cards + optional charts), `AdminUserList` page (paginated table with search + role filter), `AdminUserDetail` page (profile + quiz/exam history), `useAdminStats` and `useAdminUsers` hooks, conditional admin nav item in Sidebar, installs recharts + react-is + @tanstack/react-table + date-fns
**Uses:** Recharts (ResponsiveContainer + BarChart/LineChart/PieChart), TanStack Table v8 (useReactTable with manualPagination), date-fns (format, formatDistanceToNow), existing Card/Badge/Button components, existing cn() utility
**Avoids:** Anti-pattern of direct Supabase calls for admin data; anti-pattern of frontend-only security
**Research flags:** LOW risk -- Recharts and TanStack Table v8 have extensive documentation. Only consider research-phase if TanStack Table v8 server-side pagination setup is unclear.

### Phase 4: Frontend User Management + Polish
**Rationale:** Write operations (role change, deactivation) are higher-risk than read operations and should come after the read-only pages are validated. Polish (loading states, error handling, confirmation dialogs) completes the dashboard.
**Delivers:** Role change UI (dropdown or button on user detail/list), Account deactivation UI (with confirmation dialog), 403 error handling (dedicated "Access Denied" page), loading skeletons, success/error toast notifications, self-deactivation prevention
**Avoids:** UX pitfalls (no loading state, confusing 403 errors, accidental self-deactivation, missing confirmation dialogs)
**Research flags:** No research-phase needed -- these are standard UI patterns.

### Phase Ordering Rationale

- **Phase 1 before everything else:** The migration + JWT filter modification is a hard dependency for all other phases. No admin endpoint or page works without it.
- **Phase 2 before Phase 3:** Frontend pages need working APIs. Building the backend first allows curl-testing before building UI.
- **Phase 3 before Phase 4:** Read operations before write operations. Validates the full stack (migration -> filter -> endpoint -> frontend) before adding complexity.
- **Grouping by layer (backend before frontend):** Each phase can be independently tested and verified before moving to the next, reducing integration surprises.

### Research Flags

Phases likely needing deeper research during planning:
- **Phase 2 (topic engagement queries):** If the topic engagement breakdown requires complex multi-table JOINs, a research-phase may clarify the optimal SQL approach. The stats and user management queries are straightforward.
- **Phase 3 (TanStack Table v8 server-side pagination):** While well-documented, the exact setup for server-side pagination + filtering with the v8 API may benefit from a focused research check during planning.

Phases with standard patterns (skip research-phase):
- **Phase 1:** Standard Spring Security JWT filter modification + Supabase migration
- **Phase 4:** Standard React UI patterns (toasts, confirmation dialogs, loading states)

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Stack | HIGH | All 4 new libraries verified via Context7 docs and npm registry. React 19 compatibility confirmed for all. Existing component reuse is straightforward. |
| Features | HIGH | Features derived from clear founder needs and existing database schema. 9 table-stakes features all map to existing tables with simple queries. |
| Architecture | HIGH | Component boundaries are well-defined. Backend JDBC bypasses RLS is confirmed by existing codebase patterns. Build order has hard dependencies that are unambiguous. |
| Pitfalls | HIGH | All 7 pitfalls identified through actual codebase analysis (e.g., hardcoded ROLE_USER on line 65 of JwtAuthenticationFilter), not theoretical. Recovery strategies are low-cost. |

**Overall confidence:** HIGH

### Gaps to Address

- **Founder UUID for initial admin seed:** The migration needs a `UPDATE user_profiles SET role = 'admin' WHERE id = '<founder-uuid>'` statement. The actual founder user ID must be determined during implementation.
- **Topic engagement query complexity:** The join chain (quiz_answers -> questions -> question_subtopics -> subtopics -> topics) may have edge cases around missing subtopics or questions without topic assignments. Validate during Phase 2 implementation.
- **Supabase token refresh and deactivation:** Deactivated users retain valid JWTs for up to 1 hour. The `is_active` check in the JWT filter mitigates this, but the exact Supabase token refresh behavior should be verified during Phase 2.
- **Performance baseline:** No performance testing plan exists for admin aggregation queries. Add `EXPLAIN ANALYZE` verification during Phase 2 to catch slow queries before they become visible to founders.

## Sources

### Primary (HIGH confidence)
- Context7 `/recharts/recharts` -- React 19 peer dep confirmed; ResponsiveContainer, BarChart, LineChart, PieChart API
- Context7 `/tanstack/table` -- v8 `useReactTable` API vs v9 beta; server-side pagination setup
- npm registry -- verified current stable versions: recharts 3.9.2, @tanstack/react-table 8.21.3, date-fns 4.4.0
- Codebase: `JwtAuthenticationFilter.java` (hardcoded ROLE_USER at line 65)
- Codebase: `SecurityConfig.java`, `useAuth.tsx`, `ProtectedRoute.tsx`, `App.tsx`
- Codebase: `supabase/migrations/` (existing schema, RLS policies)

### Secondary (MEDIUM confidence)
- Spring Security 6.5 Reference -- method security with `@PreAuthorize`, filter chain config
- Supabase Auth documentation -- JWT claims behavior, RLS policies, service role key usage
- Edtech admin dashboard patterns -- founders-only SaaS dashboard conventions

### Tertiary (LOW confidence)
- Topic engagement query complexity -- multi-table JOIN feasibility needs validation against actual data

---
*Research completed: 2026-07-15*
*Ready for roadmap: yes*
