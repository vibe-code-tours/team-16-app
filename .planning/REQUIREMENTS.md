# Requirements: NerdQuiz Admin Dashboard

**Defined:** 2026-07-15
**Core Value:** Founders can see at a glance whether the platform is working — who's using it, how they're engaging, and whether anything needs intervention.

## v1 Requirements

Requirements for initial release. Each maps to roadmap phases.

### Auth & Security

- [ ] **AUTH-01**: DB migration adds `role` column (`'admin'` | `'user'`, default `'user'`) to `user_profiles`
- [ ] **AUTH-02**: DB migration adds `is_active` column (`BOOLEAN`, default `true`) to `user_profiles`
- [ ] **AUTH-03**: JWT filter queries `user_profiles.role` for `/api/v1/admin/**` paths and adds `ROLE_ADMIN` to SecurityContext
- [ ] **AUTH-04**: `SecurityConfig` requires `ROLE_ADMIN` for all `/api/v1/admin/**` endpoints
- [ ] **AUTH-05**: Frontend `AdminRoute` wrapper checks user role and redirects non-admins to home
- [ ] **AUTH-06**: First admin user seeded via migration (founder's UUID)

### Stats Dashboard

- [ ] **STAT-01**: `GET /api/v1/admin/stats` returns total registered users, active users (last 7 days), total quiz attempts
- [ ] **STAT-02**: Stats endpoint returns topic category engagement breakdown (quiz attempts per category)
- [ ] **STAT-03**: Stats page displays metric cards: total users, active users, quiz attempts
- [ ] **STAT-04**: Stats page displays topic engagement chart (Recharts bar chart)

### Analytics Charts

- [ ] **ANAL-01**: Daily active users line chart (last 30 days)
- [ ] **ANAL-02**: Quiz attempts over time line chart (last 30 days)
- [ ] **ANAL-03**: Topic category distribution pie/bar chart

### User Management

- [ ] **USER-01**: `GET /api/v1/admin/users` returns paginated user list with search by name/email
- [ ] **USER-02**: User list supports filter by role (admin/user/all)
- [ ] **USER-03**: `GET /api/v1/admin/users/{id}` returns user detail: profile info, XP, streak, join date, last login
- [ ] **USER-04**: User detail shows quiz attempt history (recent sessions with scores)
- [ ] **USER-05**: Frontend user list page: paginated table with search input, role filter dropdown
- [ ] **USER-06**: Frontend user detail page: profile card, stats, quiz history table

### Role & Deactivation Management

- [ ] **ROLE-01**: `PATCH /api/v1/admin/users/{id}/role` changes user role (admin ↔ user)
- [ ] **ROLE-02**: `PATCH /api/v1/admin/users/{id}/deactivate` soft-deactivates user (`is_active = false`)
- [ ] **ROLE-03**: Deactivated users cannot access admin endpoints (backend checks `is_active`)
- [ ] **ROLE-04**: Role change UI with confirmation dialog
- [ ] **ROLE-05**: Deactivation UI with confirmation dialog, shows warning about effect

## v2 Requirements

Deferred to future release. Tracked but not in current roadmap.

### Question Management

- **QM-01**: Admin can create new questions with choices, explanation, topic assignment
- **QM-02**: Admin can edit existing questions
- **QM-03**: Admin can delete questions
- **QM-04**: Question list with search/filter by topic, difficulty, exam session

### Lesson Management

- **LM-01**: Admin can create/edit/delete lessons
- **LM-02**: Lesson content editor

### Bulk Operations

- **BULK-01**: CSV/JSON import of questions
- **BULK-02**: Export question bank

## Out of Scope

| Feature | Reason |
|---------|--------|
| Question/lesson CRUD | Deferred to v2 — higher priority on stats + user management for MVP |
| Real-time dashboard updates | Static refresh is fine for <50 users |
| Multi-admin roles (viewer, editor) | Just admin vs. user — founders only |
| Audit logging for admin actions | Acceptable risk for MVP with small team |
| Bulk user import/export | Overkill for founders-only admin |
| Student-facing features | This dashboard is admin-only |

## Traceability

Which phases cover which requirements. Updated during roadmap creation.

| Requirement | Phase | Status |
|-------------|-------|--------|
| AUTH-01 | | Pending |
| AUTH-02 | | Pending |
| AUTH-03 | | Pending |
| AUTH-04 | | Pending |
| AUTH-05 | | Pending |
| AUTH-06 | | Pending |
| STAT-01 | | Pending |
| STAT-02 | | Pending |
| STAT-03 | | Pending |
| STAT-04 | | Pending |
| ANAL-01 | | Pending |
| ANAL-02 | | Pending |
| ANAL-03 | | Pending |
| USER-01 | | Pending |
| USER-02 | | Pending |
| USER-03 | | Pending |
| USER-04 | | Pending |
| USER-05 | | Pending |
| USER-06 | | Pending |
| ROLE-01 | | Pending |
| ROLE-02 | | Pending |
| ROLE-03 | | Pending |
| ROLE-04 | | Pending |
| ROLE-05 | | Pending |

**Coverage:**
- v1 requirements: 24 total
- Mapped to phases: 0
- Unmapped: 24 ⚠️

---
*Requirements defined: 2026-07-15*
*Last updated: 2026-07-15 after initial definition*
