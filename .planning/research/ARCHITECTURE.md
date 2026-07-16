# Architecture Research: Admin Dashboard Integration

**Domain:** Admin dashboard for existing React + Spring Boot + Supabase app
**Researched:** 2026-07-15
**Confidence:** HIGH

## System Overview: Current State

```
┌──────────────────────────────────────────────────────────────────────┐
│                        Frontend Layer                                │
│  ┌────────────────────────────────────────────────────────────────┐  │
│  │  React SPA (src/web/)                                         │  │
│  │                                                                │  │
│  │  useAuth() ──▶ Supabase Auth SDK ──▶ Supabase Auth Service    │  │
│  │       │                                                      │  │
│  │       └──▶ user_profiles (direct Supabase call, RLS)          │  │
│  │                                                                │  │
│  │  api.ts ──▶ Spring Boot API (JWT Bearer header)               │  │
│  │                                                                │  │
│  │  Direct Supabase calls:                                        │  │
│  │    LessonPage, QuizPage, ExamPage, MistakeGarden, UserProfile │  │
│  └────────────────────────────────────────────────────────────────┘  │
├──────────────────────────────────────────────────────────────────────┤
│                        Backend Layer                                 │
│  ┌────────────────────────────────────────────────────────────────┐  │
│  │  Spring Boot API (src/api/)                                   │  │
│  │                                                                │  │
│  │  JwtAuthenticationFilter ──▶ verifies JWT via Supabase JWKS   │  │
│  │       │                                                        │  │
│  │       └──▶ Sets SecurityContext with userId + ROLE_USER        │  │
│  │                                                                │  │
│  │  Controllers (thin) ──▶ Services (business logic)              │  │
│  │       │                      │                                 │  │
│  │       │                      ├──▶ JdbcTemplate (raw SQL)       │  │
│  │       │                      └──▶ JPA Repositories             │  │
│  └────────────────────────────────────────────────────────────────┘  │
├──────────────────────────────────────────────────────────────────────┤
│                        Data Layer                                    │
│  ┌────────────────────────────────────────────────────────────────┐  │
│  │  Supabase Postgres                                            │  │
│  │                                                                │  │
│  │  Tables: user_profiles, user_stats, user_daily_activity,       │  │
│  │          quiz_sessions, quiz_answers, exam_sessions,           │  │
│  │          exam_answers, questions, topics, subtopics, etc.      │  │
│  │                                                                │  │
│  │  RLS: enabled on all user-data tables                          │  │
│  │  Backend JDBC: bypasses RLS (direct Postgres connection)       │  │
│  └────────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────────┘
```

### Key Architectural Facts

1. **Backend connects to Postgres via JDBC directly** -- not through Supabase's PostgREST API. This means JdbcTemplate/JPA queries bypass RLS entirely. Admin queries for other users' data will work without RLS policy changes.

2. **Frontend direct Supabase calls ARE subject to RLS**. The existing RLS policies restrict users to their own data (`auth.uid() = user_id`). Admin cannot read other users' data via direct Supabase calls -- this data MUST go through the backend.

3. **The JWT filter currently assigns `ROLE_USER` to all authenticated users** -- there is no admin role distinction in the SecurityContext today.

4. **`user_profiles` table lacks a `role` column** -- the architecture-boundaries.md specifies this pattern but the migration has not been created yet.

5. **The `/admin` route is NOT registered in `App.tsx`** -- it is documented in architecture-boundaries.md but not implemented.

6. **Sidebar has no admin nav items** -- all nav items are student-facing.

## Recommended Architecture: Admin Dashboard Integration

### Component Boundaries

| Component | Responsibility | Communicates With | New/Modified |
|-----------|---------------|-------------------|--------------|
| DB migration | Add `role` + `is_active` columns to `user_profiles`, update RLS | -- | NEW |
| `JwtAuthenticationFilter` | Look up role from `user_profiles` for admin paths, add `ROLE_ADMIN` authority | `user_profiles` via JdbcTemplate | MODIFIED |
| `SecurityConfig` | Enforce `.hasRole("ADMIN")` on `/api/v1/admin/**` | `JwtAuthenticationFilter` | MODIFIED |
| `AdminController` | Thin REST controller for admin endpoints | `AdminService` | NEW |
| `AdminService` | Stats aggregation, user list/detail, role management, deactivation | JdbcTemplate | NEW |
| `AdminRoute` | Frontend route guard: auth + admin role check | `useAuth()` | NEW |
| `AdminDashboard` | Stats overview page | `useAdminStats` hook | NEW |
| `AdminUserList` | Paginated user table with search/filter | `useAdminUsers` hook | NEW |
| `AdminUserDetail` | Individual user profile + quiz history | `useAdminUsers` hook | NEW |
| `Sidebar` | Conditional admin nav item | `useAuth()` | MODIFIED |
| `UserProfile` type | Add `role` field | -- | MODIFIED |

### Data Flow: Admin Stats Request

```
Admin clicks /admin
    |
    v
AdminRoute ── checks useAuth().user.role === 'admin'
    |              (if not: redirect to /map)
    v
AdminDashboard ── useAdminStats() hook
    |                   |
    |                   └──▶ api.get('/api/v1/admin/stats')
    |                              |
    v                              v
JwtAuthenticationFilter ──▶ verifies JWT (existing)
    |                              |
    |                   └──▶ queries user_profiles.role
    |                              |
    |                   └──▶ adds ROLE_ADMIN to SecurityContext
    v
SecurityConfig ──▶ .requestMatchers("/api/v1/admin/**").hasRole("ADMIN")
    |                     (returns 403 if no ROLE_ADMIN)
    v
AdminController.stats() ──▶ AdminService.getStats()
    |                              |
    |                   └──▶ JdbcTemplate queries:
    |                         - COUNT(*) FROM user_profiles
    |                         - COUNT(DISTINCT user_id) FROM user_daily_activity
    |                         - COUNT(*) FROM quiz_sessions WHERE status='completed'
    |                         - topic engagement aggregation
    v
AdminStatsResponse (record) ──▶ JSON to frontend
    |
    v
AdminDashboard renders stats cards + tables
```

### Data Flow: User Management (Role Change)

```
Admin clicks "Make Admin" on user row
    |
    v
useAdminUsers.updateUserRole(userId, 'admin')
    |
    └──▶ api.patch('/api/v1/admin/users/{id}/role', { role: 'admin' })
              |
              v
    JwtAuthenticationFilter ──▶ verifies JWT + admin role (same as above)
              |
              v
    AdminController.updateRole(userId) ──▶ AdminService.updateUserRole()
              |                                      |
              |                           └──▶ UPDATE user_profiles SET role = 'admin' WHERE id = ?
              v
    200 OK ──▶ frontend refreshes user list
```

## Recommended Project Structure

### Backend additions (`src/api/`)

```
src/api/src/main/java/com/nerdquiz/
├── config/
│   ├── SecurityConfig.java              # MODIFY: add admin role path matching
│   ├── JwtAuthenticationFilter.java     # MODIFY: role lookup for admin paths
│   └── ...
├── annotation/
│   ├── Public.java                      # existing
│   └── AdminOnly.java                   # NEW (optional, for documentation)
├── controller/
│   ├── AdminController.java             # NEW: all admin REST endpoints
│   └── ...
├── service/
│   ├── AdminService.java                # NEW: stats, user management logic
│   └── ...
├── dto/
│   ├── AdminStatsResponse.java          # NEW: stats aggregation response
│   ├── AdminUserListResponse.java       # NEW: paginated user list
│   ├── AdminUserDetailResponse.java     # NEW: user detail with quiz history
│   ├── UpdateRoleRequest.java           # NEW: role change request body
│   ├── DeactivateUserRequest.java       # NEW: deactivation request body
│   └── ...
└── exception/
    ├── AdminAccessDeniedException.java  # NEW: non-admin trying admin ops
    ├── UserNotFoundException.java       # NEW: target user not found
    └── ...
```

**Structure rationale:**
- `AdminController` follows the same thin-controller pattern as `QuizController` -- extract userId from Authentication, delegate to service.
- `AdminService` uses `JdbcTemplate` (consistent with existing `UserService`) because admin stats involve complex aggregation queries across multiple tables that are awkward to express with JPA.
- DTOs use Java records (consistent with existing `StreakResponse`, `QuizSessionResponse`).
- No new JPA entity for `user_profiles` is created here -- that consolidation is a separate concern (known gap #6 in feature-board.md). The admin service uses JdbcTemplate to read/write the role column.

### Frontend additions (`src/web/`)

```
src/web/src/
├── routes/
│   ├── AdminDashboard.tsx               # NEW: stats overview page
│   ├── AdminUserList.tsx                # NEW: paginated user table
│   ├── AdminUserDetail.tsx              # NEW: user detail view
│   └── ...
├── hooks/
│   ├── useAdminStats.ts                 # NEW: fetch + cache admin stats
│   ├── useAdminUsers.ts                 # NEW: user list, search, role, deactivation
│   └── ...
├── components/
│   ├── ProtectedRoute.tsx               # existing (auth guard)
│   ├── AdminRoute.tsx                   # NEW: auth + role guard
│   ├── features/
│   │   ├── admin/
│   │   │   ├── StatsCard.tsx            # NEW: single stat display card
│   │   │   ├── TopicEngagementTable.tsx # NEW: topic breakdown table
│   │   │   ├── UserTable.tsx            # NEW: user list table row
│   │   │   └── ...
│   │   └── ...
│   └── ...
├── types/
│   ├── index.ts                         # MODIFY: add role to UserProfile
│   └── admin.ts                         # NEW: AdminStats, AdminUser types
├── App.tsx                              # MODIFY: add admin routes
└── components/layout/
    └── Sidebar.tsx                      # MODIFY: conditional admin nav item
```

**Structure rationale:**
- `AdminRoute` wraps the existing `ProtectedRoute` pattern -- it first checks auth (like ProtectedRoute), then additionally checks `user.role === 'admin'`. This avoids duplicating the auth logic.
- Admin-specific components live in `components/features/admin/` to keep them grouped but separate from student features.
- `useAdminStats` and `useAdminUsers` follow the existing hook pattern (`useTopics`, `useLessons`) -- they encapsulate API calls and state management.
- Types in a separate `admin.ts` file to keep the main `types/index.ts` focused on shared types.

### Database migration

```sql
-- New migration: add role and is_active to user_profiles

-- Add role column
ALTER TABLE public.user_profiles
  ADD COLUMN role TEXT NOT NULL DEFAULT 'user'
  CHECK (role IN ('admin', 'user'));

-- Add is_active column for soft deactivation
ALTER TABLE public.user_profiles
  ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT true;

-- Index for admin user list queries
CREATE INDEX idx_user_profiles_role ON public.user_profiles(role);
CREATE INDEX idx_user_profiles_active ON public.user_profiles(is_active);
CREATE INDEX idx_user_profiles_email ON public.user_profiles(email);

-- Seed the first admin (replace UUID with actual founder user ID)
-- UPDATE public.user_profiles SET role = 'admin' WHERE id = '<founder-uuid>';
```

**Why this migration design:**
- `role TEXT NOT NULL DEFAULT 'user'` -- all existing users become non-admin by default. Safe.
- `is_active BOOLEAN DEFAULT true` -- soft deactivation preserves data while blocking login.
- Indexes on `role` and `is_active` support the admin user list filter queries.
- RLS does NOT need admin-specific policies because admin access goes through the backend (JDBC bypasses RLS). The existing RLS policies remain unchanged -- they protect direct Supabase calls from the frontend, which is correct behavior.

## Architectural Patterns

### Pattern 1: Conditional Role Lookup in JWT Filter

**What:** The `JwtAuthenticationFilter` looks up the user's role from `user_profiles` only when the request path starts with `/api/v1/admin/`. For all other paths, it behaves exactly as today (just verifies JWT, sets ROLE_USER).

**When to use:** When you need role-based authorization on a subset of endpoints without adding a DB query to every request.

**Trade-offs:**
- Pro: Only pays the DB query cost for admin requests (rare).
- Pro: Authorization is centralized in the filter -- controllers just use `@PreAuthorize` or rely on SecurityConfig path matching.
- Con: Slight filter complexity (path-based conditional).
- Con: Admin role changes take effect on next request (no session cache -- this is fine for a small app).

**Example:**
```java
// In JwtAuthenticationFilter.doFilterInternal():
String userId = jwtUtil.extractUserId(jwt);

// Default: ROLE_USER for all authenticated users
List<SimpleGrantedAuthority> authorities = new ArrayList<>();
authorities.add(new SimpleGrantedAuthority("ROLE_USER"));

// Admin path: look up role from user_profiles
if (request.getRequestURI().startsWith("/api/v1/admin/")) {
    String role = jdbcTemplate.queryForObject(
        "SELECT role FROM user_profiles WHERE id = ?::uuid AND is_active = true",
        String.class,
        userId
    );
    if ("admin".equals(role)) {
        authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
    }
}

UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(
    userId, null, authorities
);
SecurityContextHolder.getContext().setAuthentication(auth);
```

### Pattern 2: AdminRoute Guard (Frontend)

**What:** A route guard component that wraps `ProtectedRoute` logic and additionally checks the user's role. Non-admin users are redirected to `/map` (not a 404 -- they should not know the admin route exists).

**When to use:** When a route requires both authentication AND a specific role.

**Trade-offs:**
- Pro: Composes with existing `ProtectedRoute` -- no duplication.
- Pro: Role comes from `useAuth().user.role` which is already fetched on login (no extra API call).
- Con: Role is cached in React state -- if an admin's role is revoked, they keep access until they refresh/re-login. Acceptable for an MVP with trusted founders.

**Example:**
```tsx
// AdminRoute.tsx
export function AdminRoute({ children }: { children: React.ReactNode }) {
  const { user, loading } = useAuth()

  if (loading) {
    return <LoadingSpinner />
  }

  if (!user) {
    return <Navigate to="/login" replace />
  }

  if (user.role !== 'admin') {
    return <Navigate to="/map" replace />
  }

  return <>{children}</>
}
```

### Pattern 3: Backend-Aggregated Stats (No Client-Side Aggregation)

**What:** All statistics are computed in the backend via SQL aggregation queries. The frontend receives pre-computed numbers and renders them directly.

**When to use:** When the data volume is small enough for SQL aggregation, and you want a thin frontend.

**Trade-offs:**
- Pro: Frontend is simple -- just renders numbers.
- Pro: Consistent stats across all clients.
- Pro: No raw user data leaves the backend.
- Con: Every stats refresh hits the database.
- Con: No real-time updates (acceptable for MVP -- manual refresh is fine).

**Example:**
```sql
-- AdminService.getStats() runs these queries:
SELECT COUNT(*) FROM user_profiles WHERE is_active = true;
SELECT COUNT(DISTINCT user_id) FROM user_daily_activity WHERE activity_date >= CURRENT_DATE - 7;
SELECT COUNT(*) FROM quiz_sessions WHERE status = 'completed';
SELECT subtopic_id, COUNT(*) as attempts FROM quiz_answers qa
  JOIN quiz_sessions qs ON qa.quiz_session_id = qs.id
  WHERE qs.status = 'completed'
  GROUP BY subtopic_id;
```

## Anti-Patterns to Avoid

### Anti-Pattern 1: Frontend-Only Admin Check

**What people do:** Only check `user.role === 'admin'` in React route guards, skip backend role verification.

**Why it's wrong:** Any user can craft a request to `/api/v1/admin/stats` with a valid JWT. Without backend role checking, non-admin users can access all admin data and perform admin actions (role changes, deactivation).

**Do this instead:** Always verify admin role in the backend JWT filter AND enforce it in SecurityConfig with `.hasRole("ADMIN")`. The frontend guard is UX only -- it prevents non-admins from seeing the admin UI, but the backend is the security boundary.

### Anti-Pattern 2: Storing Role in JWT Claims

**What people do:** Add the user's role to the Supabase JWT custom claims so the backend can read it without a DB lookup.

**Why it's wrong:** JWTs are issued by Supabase Auth and expire/refresh independently. If you change a user's role in the database, the old JWT still carries the old role until it expires (up to 1 hour). This creates a window where a de-admined user retains admin access.

**Do this instead:** Look up the role from the database (via JdbcTemplate) on admin requests. This always reflects the current state. The DB query cost is negligible for admin-only paths with few concurrent admins.

### Anti-Pattern 3: Admin Stats via Direct Supabase Calls

**What people do:** Have the frontend query `user_profiles`, `quiz_sessions`, etc. directly via Supabase to build admin stats.

**Why it's wrong:** RLS policies restrict users to their own data. The frontend cannot read other users' quiz sessions or profiles. You would need to add permissive RLS policies for admins, which is complex and error-prone.

**Do this instead:** All admin data queries go through the Spring Boot backend. The backend's JDBC connection bypasses RLS, so it can freely aggregate across all users' data.

### Anti-Pattern 4: Massive AdminService Class

**What people do:** Put all stats queries, user management, role changes, and deactivation logic in a single `AdminService` that grows to 500+ lines.

**Why it's wrong:** Violates single responsibility. Makes testing harder. Future developers cannot find what they need.

**Do this instead:** Keep `AdminService` focused on the 5 endpoints needed for MVP. Methods should be small (10-20 lines each). If stats and user management feel like separate domains, they can be split into `AdminStatsService` and `AdminUserService` later -- but for 5 endpoints, one service is fine.

## Data Flow: Authentication Path Comparison

### Student Request (unchanged)

```
Frontend ──▶ Supabase Auth (login) ──▶ JWT
Frontend ──▶ api.ts ──▶ Spring Boot with Bearer JWT
JwtFilter ──▶ verify JWT ──▶ extract userId ──▶ SecurityContext(ROLE_USER)
Controller ──▶ Service ──▶ JdbcTemplate ──▶ Postgres
```

### Admin Request (new)

```
Frontend ──▶ Supabase Auth (login) ──▶ JWT
Frontend ──▶ api.ts ──▶ Spring Boot with Bearer JWT
JwtFilter ──▶ verify JWT ──▶ extract userId
  └── path starts with /api/v1/admin/
  └── JdbcTemplate query: SELECT role FROM user_profiles WHERE id = ?
  └── if role == 'admin': add ROLE_ADMIN to authorities
SecurityConfig ──▶ .hasRole("ADMIN") check passes
AdminController ──▶ AdminService ──▶ JdbcTemplate ──▶ Postgres (bypasses RLS)
Response ──▶ AdminStatsResponse DTO ──▶ JSON ──▶ Frontend
```

## Scaling Considerations

| Scale | Architecture Adjustments |
|-------|--------------------------|
| 0-100 users (MVP) | Current architecture is fine. SQL aggregation is fast. No caching needed. |
| 100-10K users | Add caching to stats endpoint (e.g., Spring `@Cacheable` with 60s TTL). Stats queries may slow down with large `user_daily_activity` and `quiz_answers` tables. |
| 10K+ users | Consider materialized views for stats. Add pagination cursor-based API for user list. Consider separate analytics pipeline. |

**Scaling priorities:**
1. **First bottleneck:** `COUNT(DISTINCT user_id) FROM user_daily_activity` over 7 days will slow down as the table grows. Fix: add a daily materialized view or cache.
2. **Second bottleneck:** User list search by name/email without an index. Fix: already addressed by the migration's `idx_user_profiles_email` index; add a trigram index for name search if needed.

## Integration Points

### External Services

| Service | Integration Pattern | Notes |
|---------|---------------------|-------|
| Supabase Auth | JWT verification via JWKS (existing, unchanged) | Admin role is NOT in the JWT -- it is looked up from DB |
| Supabase Postgres | JDBC via Spring Data/JdbcTemplate (existing) | Backend bypasses RLS; admin queries work without RLS changes |

### Internal Boundaries

| Boundary | Communication | Notes |
|----------|---------------|-------|
| AdminRoute (frontend) <-> AdminController (backend) | REST API + JWT | Frontend guard is UX only; backend is security boundary |
| JwtAuthenticationFilter <-> AdminService | SecurityContext (role authority) | Filter sets ROLE_ADMIN; controllers/services rely on it |
| AdminService <-> Postgres | JdbcTemplate (SQL) | Direct Postgres connection; no RLS; no Supabase API |

## Build Order Implications

The following components have dependencies that dictate build order:

```
Phase 1 (Foundation):
  DB migration (role + is_active columns)
    └──> Must exist before anything else

Phase 2 (Backend Security):
  JwtAuthenticationFilter modification (role lookup)
  SecurityConfig modification (admin role path matching)
    └──> Must exist before admin endpoints work

Phase 3 (Backend Endpoints):
  AdminService + AdminController (stats endpoint first, then user management)
    └──> Depends on Phase 2 for role verification

Phase 4 (Frontend Guard + Dashboard):
  UserProfile type (add role field)
  AdminRoute component
  useAdminStats hook
  AdminDashboard page
    └──> Depends on Phase 3 for the stats API

Phase 5 (Frontend User Management):
  useAdminUsers hook
  AdminUserList page
  AdminUserDetail page
  Sidebar admin nav item
    └──> Depends on Phase 3 for user management APIs

Phase 6 (Frontend Polish):
  Role change UI
  Deactivation UI
  Error handling for 403 responses
```

**Why this order:**
- The DB migration is the foundation -- nothing works without the `role` column.
- Backend security (filter + config) must precede admin endpoints because endpoints depend on role verification.
- Stats endpoint is simpler than user management, so build it first to validate the full stack.
- Frontend guard must exist before any admin page to prevent non-admin access.
- Dashboard (read-only) is simpler than user management (write operations), so build it first.

## Confidence Assessment

| Area | Confidence | Notes |
|------|------------|-------|
| Backend admin role in JWT filter | HIGH | Well-established Spring Security pattern. Confirmed by Spring Boot 3.4 docs. |
| SecurityConfig `.hasRole("ADMIN")` | HIGH | Standard Spring Security path-based authorization. |
| JdbcTemplate for admin queries | HIGH | Matches existing pattern (UserService uses JdbcTemplate). Confirmed backend bypasses RLS. |
| AdminRoute frontend guard | HIGH | Simple composition of existing ProtectedRoute + role check from useAuth. |
| UserProfile role field in useAuth | HIGH | useAuth already fetches user_profiles.* -- adding role column automatically makes it available. |
| DB migration (role + is_active) | HIGH | Straightforward ALTER TABLE. No data loss risk. Default 'user' is safe. |
| No RLS changes needed | HIGH | Backend JDBC bypasses RLS. Admin access through backend only. Frontend direct calls remain restricted. |

## Sources

- Existing codebase: `JwtAuthenticationFilter.java`, `SecurityConfig.java`, `useAuth.tsx`, `ProtectedRoute.tsx`, `App.tsx`
- Architecture boundaries: `docs/gsd/architecture-boundaries.md` (specifies admin auth pattern)
- Feature board: `docs/gsd/feature-board.md` (feature #20 admin dashboard)
- Spring Boot 3.4 Security docs: role-based access control, `hasRole()`, filter chain configuration
- React Router v7: redirect patterns, route guards
- Supabase Postgres: RLS behavior with direct JDBC connections

---
*Architecture research for: NerdQuiz Admin Dashboard integration*
*Researched: 2026-07-15*
