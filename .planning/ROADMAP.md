# Roadmap: NerdQuiz Admin Dashboard

## Overview

The admin dashboard adds a role-gated founders-only view to the existing NerdQuiz SPA. The build follows a strict dependency chain: database schema and security infrastructure first, then all backend admin endpoints, then read-only frontend pages, and finally write-operation UIs with polish. Each phase validates the previous before building on top.

## Phases

- [ ] **Phase 1: Security Foundation** - DB migration + backend JWT filter + frontend route guard
- [ ] **Phase 2: Admin Endpoints** - All 5 backend admin API endpoints
- [ ] **Phase 3: Stats & User List** - Frontend dashboard, analytics charts, user list/detail
- [ ] **Phase 4: User Management UI** - Role change, deactivation, 403 handling, polish

## Phase Details

### Phase 1: Security Foundation
**Goal**: Admin role infrastructure is in place and enforced end-to-end
**Mode:** mvp
**Depends on**: Nothing (first phase)
**Requirements**: AUTH-01, AUTH-02, AUTH-03, AUTH-04, AUTH-05, AUTH-06
**Success Criteria** (what must be TRUE):
  1. Database has `role` and `is_active` columns on `user_profiles` with correct defaults
  2. Admin users are identified by JWT filter and receive `ROLE_ADMIN` authority
  3. Non-admin users hitting `/admin` routes see a redirect or access denied
  4. The initial admin account is seeded and can authenticate
**Plans:** 2 plans
Plans:
- [ ] 01-01-PLAN.md — DB migration (is_active + admin seed) + JWT hardening + InputSanitizer
- [ ] 01-02-PLAN.md — JWT admin role injection + SecurityConfig enforcement + rate limiting + security headers

### Phase 2: Admin Endpoints
**Goal**: All backend admin APIs are working and return correct data
**Mode:** mvp
**Depends on**: Phase 1
**Requirements**: STAT-01, STAT-02, USER-01, USER-02, USER-03, USER-04, ROLE-01, ROLE-02, ROLE-03
**Success Criteria** (what must be TRUE):
  1. `GET /api/v1/admin/stats` returns user counts, quiz attempts, and topic engagement breakdown
  2. `GET /api/v1/admin/users` returns paginated user list with search and role filter
  3. `GET /api/v1/admin/users/{id}` returns user profile with quiz attempt history
  4. `PATCH /api/v1/admin/users/{id}/role` changes user role
  5. `PATCH /api/v1/admin/users/{id}/deactivate` sets `is_active = false` and deactivated users get 403 on admin endpoints
**Plans**: TBD

### Phase 3: Stats & User List
**Goal**: Admin can view platform stats, charts, and user information in the browser
**Mode:** mvp
**Depends on**: Phase 2
**Requirements**: STAT-03, STAT-04, ANAL-01, ANAL-02, ANAL-03, USER-05, USER-06
**Success Criteria** (what must be TRUE):
  1. Admin dashboard displays metric cards: total users, active users, quiz attempts
  2. Topic engagement chart renders correctly (Recharts bar chart)
  3. Charts display daily active users, quiz attempts over time, and topic category distribution
  4. User list page shows paginated table with search input and role filter dropdown
  5. User detail page shows profile card, stats, and quiz history table
**Plans**: TBD

### Phase 4: User Management UI
**Goal**: Admin can change roles and deactivate users through the interface, with proper error handling
**Mode:** mvp
**Depends on**: Phase 3
**Requirements**: ROLE-04, ROLE-05
**Success Criteria** (what must be TRUE):
  1. Admin can change a user's role from the user detail page with a confirmation dialog
  2. Admin can deactivate a user account with a confirmation dialog and warning
  3. Non-admin users see a clear 403 Access Denied page
  4. Role change and deactivation show success/error feedback after action
**Plans**: TBD

## Progress

| Phase | Plans Complete | Status | Completed |
|-------|----------------|--------|-----------|
| 1. Security Foundation | 0/2 | Planning complete | - |
| 2. Admin Endpoints | 0/0 | Not started | - |
| 3. Stats & User List | 0/0 | Not started | - |
| 4. User Management UI | 0/0 | Not started | - |
