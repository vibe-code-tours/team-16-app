# Phase 1: Admin Dashboard — Foundation & Stats Display

> **Goal:** Admins can log in and see platform health stats at a glance. Non-admins cannot access the admin page.

## Context

NerdQuiz currently has no way to see how the platform is being used. All the data already exists in the DB (quiz_sessions, exam_sessions, user_daily_activity, user_profiles) — this is purely an aggregation + display problem. The only schema change needed is a `role` column on `user_profiles`.

**What already exists:**
- `user_profiles` table (no `role` column yet) — migration 003
- `quiz_sessions`, `exam_sessions`, `user_daily_activity`, `user_stats` tables with rich data
- `JwtAuthenticationFilter` gives everyone `ROLE_USER` — no admin role handling
- `useAuth()` hook fetches user profile from `user_profiles` directly via Supabase
- `ProtectedRoute` checks auth only, not roles
- `UserProfile` type has no `role` field
- Backend `UserService` uses raw `JdbcTemplate`, no JPA entity for `user_profiles`

---

## Task 1: Database Migration — Add `role` to `user_profiles`

**What:** Add a `role` column to `user_profiles` with default `'user'`, valid values `'admin'` | `'user'`.

**Files to create:**
- `supabase/migrations/019_add_admin_role.sql`

**Implementation:**
```sql
-- Add role column to user_profiles
ALTER TABLE public.user_profiles
  ADD COLUMN role TEXT NOT NULL DEFAULT 'user'
  CHECK (role IN ('admin', 'user'));

-- Admin can read all user profiles (for stats/user management)
CREATE POLICY "Admins can view all profiles"
  ON public.user_profiles
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.user_profiles up
      WHERE up.id = auth.uid() AND up.role = 'admin'
    )
  );

-- After migration, manually set first admin:
-- UPDATE public.user_profiles SET role = 'admin' WHERE id = '<your-user-id>';
```

**Notes:**
- Existing RLS policies remain (users see own profile)
- Admin policy is additive — admins see all profiles, users still see only their own
- Manual `UPDATE` needed to promote the first admin (no admin UI for user management yet)

---

## Task 2: Frontend — Add `role` to `UserProfile` Type

**What:** Extend the `UserProfile` interface to include the `role` field so the frontend can use it.

**Files to edit:**
- `src/web/src/types/index.ts`

**Implementation:**
```typescript
export interface UserProfile {
  id: string
  email: string | null
  display_name: string | null
  avatar_url: string | null
  role: 'admin' | 'user'  // <-- add this
  total_xp: number
  streak_count: number
  last_login_at: string | null
  created_at: string
  updated_at: string
}
```

**Notes:**
- `useAuth()` already fetches `select('*')` from `user_profiles`, so the role will be included automatically once the DB column exists.

---

## Task 3: Frontend — `AdminRoute` Guard Component

**What:** Create a route guard that checks if the user has admin role. Redirects non-admins to `/`.

**Files to create:**
- `src/web/src/components/AdminRoute.tsx`

**Implementation:**
```typescript
import { Navigate } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth.tsx'

interface AdminRouteProps {
  children: React.ReactNode
}

export function AdminRoute({ children }: AdminRouteProps) {
  const { user, loading } = useAuth()

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-purple-500 border-t-transparent" />
      </div>
    )
  }

  if (!user || user.role !== 'admin') {
    return <Navigate to="/" replace />
  }

  return <>{children}</>
}
```

**Notes:**
- Follows same pattern as `ProtectedRoute.tsx`
- Checks `user.role` from the profile already loaded by `useAuth()`

---

## Task 4: Frontend — Admin Dashboard Page

**What:** Create the admin dashboard page with stats summary cards.

**Files to create:**
- `src/web/src/routes/AdminDashboard.tsx`
- `src/web/src/hooks/useAdminStats.ts`
- `src/web/src/types/index.ts` (add `AdminStats` type)

**Stats to display (cards):**
| Stat | Source |
|------|--------|
| Total Users | `COUNT(*) FROM user_profiles` |
| Active Today | `COUNT(DISTINCT user_id) FROM user_daily_activity WHERE activity_date = CURRENT_DATE` |
| Active This Week | `COUNT(DISTINCT user_id) FROM user_daily_activity WHERE activity_date >= CURRENT_DATE - 7` |
| Quiz Attempts | `COUNT(*) FROM quiz_sessions WHERE status = 'completed'` |
| Exam Attempts | `COUNT(*) FROM exam_sessions WHERE status = 'completed'` |

**Topic Engagement (table):**
| Column | Source |
|--------|--------|
| Topic Name | `topics.name` |
| Quiz Count | `COUNT(*) FROM quiz_sessions qs JOIN subtopics s ON ... JOIN topics t ON ...` |
| Avg Score | `AVG(qs.score)` |

**Hook `useAdminStats`:**
```typescript
export function useAdminStats() {
  const [stats, setStats] = useState<AdminStats | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    api.get<AdminStats>('/api/v1/admin/stats')
      .then(setStats)
      .catch((err) => setError(err.message))
      .finally(() => setLoading(false))
  }, [])

  return { stats, loading, error }
}
```

**Page layout:**
- Header: "Admin Dashboard"
- 5 stat cards in a responsive grid (1 col mobile, 2-3 cols desktop)
- Topic engagement table below
- Loading spinner, error state, empty state

---

## Task 5: Backend — `AdminController` + `AdminService`

**What:** Create the admin stats API endpoint.

**Files to create:**
- `src/api/src/main/java/com/nerdquiz/controller/AdminController.java`
- `src/api/src/main/java/com/nerdquiz/service/AdminService.java`
- `src/api/src/main/java/com/nerdquiz/dto/AdminStatsResponse.java`
- `src/api/src/main/java/com/nerdquiz/dto/TopicEngagementResponse.java`
- `src/api/src/main/java/com/nerdquiz/exception/AdminAccessDeniedException.java`

**API endpoint:**
```
GET /api/v1/admin/stats
Authorization: Bearer <admin-jwt>

Response 200:
{
  "totalUsers": 42,
  "activeToday": 5,
  "activeThisWeek": 18,
  "totalQuizAttempts": 156,
  "totalExamAttempts": 23,
  "topicEngagement": [
    { "topicName": "Technology", "quizCount": 45, "avgScore": 72.5 },
    { "topicName": "Security", "quizCount": 38, "avgScore": 68.2 }
  ]
}

Response 403:
{
  "type": "https://nerdquiz.com/errors/forbidden",
  "title": "Admin Access Required",
  "status": 403,
  "detail": "Only admin users can access this endpoint"
}
```

**`AdminController`:**
```java
@RestController
@RequestMapping("/api/v1/admin")
public class AdminController {

    private final AdminService adminService;

    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    @GetMapping("/stats")
    public ResponseEntity<AdminStatsResponse> getStats(Authentication authentication) {
        UUID userId = UUID.fromString(authentication.getName());
        AdminStatsResponse stats = adminService.getStats(userId);
        return ResponseEntity.ok(stats);
    }
}
```

**`AdminService`:**
```java
@Service
public class AdminService {

    private final JdbcTemplate jdbcTemplate;

    public AdminService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public AdminStatsResponse getStats(UUID userId) {
        // 1. Verify user is admin
        String role = jdbcTemplate.queryForObject(
            "SELECT role FROM user_profiles WHERE id = ?",
            String.class, userId
        );
        if (!"admin".equals(role)) {
            throw new AdminAccessDeniedException();
        }

        // 2. Aggregate stats
        // ... SQL queries for each stat
    }
}
```

**Notes:**
- Uses `JdbcTemplate` (same pattern as `UserService`)
- Role check happens in service layer, not JWT filter (simpler for v1)
- Returns 403 via `AdminAccessDeniedException` handled by `GlobalExceptionHandler`

**`AdminAccessDeniedException`:**
```java
package com.nerdquiz.exception;

public class AdminAccessDeniedException extends RuntimeException {
    public AdminAccessDeniedException() {
        super("Admin access required");
    }
}
```

**`GlobalExceptionHandler` — add this handler:**
```java
@ExceptionHandler(AdminAccessDeniedException.class)
public ResponseEntity<Map<String, Object>> handleAdminAccessDenied(AdminAccessDeniedException ex) {
    return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of(
        "type", "https://nerdquiz.com/errors/forbidden",
        "title", "Admin Access Required",
        "status", 403,
        "detail", ex.getMessage()
    ));
}
```

> **Important:** This MUST be added. Without it, `AdminAccessDeniedException` falls through to the `RuntimeException` catch-all and returns 500 instead of 403.

---

## Task 6: Backend — Wire Admin Route into SecurityConfig

**What:** Ensure `/api/v1/admin/**` is not publicly accessible (already covered by `anyRequest().authenticated()`), but add explicit documentation.

**Files to edit:**
- `src/api/src/main/java/com/nerdquiz/config/SecurityConfig.java` (no change needed — already requires auth)

**Notes:**
- The `SecurityConfig` already requires auth on all endpoints except health check
- Admin role check is in the service layer, not the filter chain
- No `SecurityConfig` changes needed for Phase 1

---

## Task 7: Frontend — Register Admin Route in `App.tsx`

**What:** Add the `/admin` route to the app, protected by `AdminRoute`.

**Files to edit:**
- `src/web/src/App.tsx`

**Implementation:**
```typescript
import { AdminRoute } from "./components/AdminRoute";
import { AdminDashboard } from "./routes/AdminDashboard";

// In Routes:
<Route
  path="/admin"
  element={
    <ProtectedRoute>
      <AdminRoute>
        <Layout>
          <AdminDashboard />
        </Layout>
      </AdminRoute>
    </ProtectedRoute>
  }
/>
```

---

## Task 8: Frontend — Add Admin Link to Sidebar (Admin Only)

**What:** Show an "Admin" nav item in the sidebar only for admin users.

**Files to edit:**
- `src/web/src/components/layout/Sidebar.tsx`

**Implementation:**
```typescript
// Add to navItems array (conditional):
// Note: Sidebar currently uses static navItems array, not hook-based.
// Need to either pass admin status via props or import useAuth inside Sidebar.

// Option: Add admin item after defaultNavItems when user is admin
const { user } = useAuth()
const allNavItems = user?.role === 'admin'
  ? [...defaultNavItems, {
      label: 'Admin',
      href: '/admin',
      icon: (
        <svg className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
        </svg>
      ),
    }]
  : defaultNavItems
```

**Notes:**
- Uses inline SVG (same pattern as other Sidebar nav items) — not lucide-react
- Only renders for admin users — invisible to regular users
- Shield icon from Heroicons (consistent with existing SVG style)

---

## Verification Checklist

- [ ] Migration runs without errors: `supabase db reset`
- [ ] `user_profiles` table has `role` column with default `'user'`
- [ ] First admin can be promoted via SQL: `UPDATE user_profiles SET role = 'admin' WHERE id = '...'`
- [ ] Admin user sees "Admin" link in sidebar
- [ ] Non-admin user does NOT see "Admin" link
- [ ] `/admin` route shows stats dashboard for admin user
- [ ] `/admin` route redirects to `/` for non-admin user
- [ ] `GET /api/v1/admin/stats` returns 200 with stats for admin
- [ ] `GET /api/v1/admin/stats` returns 403 for non-admin
- [ ] Stats cards show correct numbers (total users, active today, etc.)
- [ ] Topic engagement table shows correct data
- [ ] Loading state shows spinner
- [ ] Error state shows retry message
- [ ] Mobile responsive (cards stack on small screens)
- [ ] No `console.log` in production code
- [ ] No secrets in code

---

## Files Summary

| Action | File |
|--------|------|
| Create | `supabase/migrations/019_add_admin_role.sql` |
| Create | `src/web/src/components/AdminRoute.tsx` |
| Create | `src/web/src/routes/AdminDashboard.tsx` |
| Create | `src/web/src/hooks/useAdminStats.ts` |
| Create | `src/api/src/main/java/com/nerdquiz/controller/AdminController.java` |
| Create | `src/api/src/main/java/com/nerdquiz/service/AdminService.java` |
| Create | `src/api/src/main/java/com/nerdquiz/dto/AdminStatsResponse.java` |
| Create | `src/api/src/main/java/com/nerdquiz/dto/TopicEngagementResponse.java` |
| Create | `src/api/src/main/java/com/nerdquiz/exception/AdminAccessDeniedException.java` |
| Edit | `src/web/src/types/index.ts` (add `role` to `UserProfile`, add `AdminStats`) |
| Edit | `src/web/src/App.tsx` (add `/admin` route) |
| Edit | `src/web/src/components/layout/Sidebar.tsx` (add admin nav link) |
| Edit | `src/api/src/main/java/com/nerdquiz/exception/GlobalExceptionHandler.java` (add 403 handler) |
