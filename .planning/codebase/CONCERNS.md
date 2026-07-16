# Codebase Concerns

**Analysis Date:** 2026-07-14

## Tech Debt

**Exam Simulation Backend:**
- Issue: `ExamPage.tsx` calls Supabase RPC directly (`get_exam_questions`, `increment_user_xp`) and manages all exam logic client-side
- Files: `src/web/src/routes/ExamPage.tsx`, `supabase/migrations/015_get_exam_questions.sql`
- Impact: No backend validation, no exam history API, no admin visibility, duplicate business logic
- Fix approach: Create `ExamController` + `ExamService` with endpoints for start/submit/result, then refactor `ExamPage.tsx` to use backend API instead of direct Supabase calls

**Mistake Garden Backend:**
- Issue: `MistakeGarden.tsx` queries Supabase directly without backend endpoint; two overlapping tables (`mistakes` + `user_mistakes`) exist in database
- Files: `src/web/src/routes/MistakeGarden.tsx`, `supabase/migrations/005_create_mistake_garden.sql`
- Impact: No backend validation, inconsistent data, potential duplicate user mistake records
- Fix approach: Consolidate to single `user_mistakes` table via migration, create `MistakeController` + `MistakeService`, update frontend to use backend API

**Orphaned Frontend Files:**
- Issue: `QuizSession.tsx`, `QuizResult.tsx`, `sampleQuestions.ts` not routed in `App.tsx`, using sample/hardcoded data
- Files: `src/web/src/routes/QuizSession.tsx`, `src/web/src/routes/QuizResult.tsx`, `src/web/src/data/sampleQuestions.ts`
- Impact: Confusion, dead code, potential for accidental use
- Fix approach: Delete these files; they're superseded by `QuizPage.tsx` and `ExamPage.tsx` which use live backend data

**Duplicate Database Tables:**
- Issue: `profiles` (migration 001) and `user_profiles` (migration 003) store similar data; `mistakes` (001) and `user_mistakes` (005) both track user mistakes
- Files: `supabase/migrations/001_initial_schema.sql`, `supabase/migrations/003_create_user_profiles.sql`, `supabase/migrations/005_create_mistake_garden.sql`
- Impact: Data inconsistency, migration complexity, confusion about which table to use
- Fix approach: Create consolidation migration to merge tables; drop unused ones after updating code

**Raw SQL in UserService:**
- Issue: `UserService` uses `JdbcTemplate` with raw SQL instead of JPA entities/repositories
- Files: `src/api/src/main/java/com/nerdquiz/service/UserService.java`
- Impact: No type safety, harder to maintain, doesn't follow codebase pattern
- Fix approach: Create `UserProfile` JPA entity + `UserProfileRepository`, migrate `UserService` to use repositories

**LessonPage Bypassing Backend:**
- Issue: `LessonPage.tsx` queries Supabase directly for lessons instead of using `/api/v1/subtopics/{id}/lessons` endpoint
- Files: `src/web/src/routes/LessonPage.tsx`, `src/api/src/main/java/com/nerdquiz/controller/LessonController.java`
- Impact: Backend lesson API underutilized, inconsistent data access patterns
- Fix approach: Refactor `LessonPage.tsx` to call backend API via `api.ts` client

## Known Bugs

**Exam Hearts Not Enforced Backend-Side:**
- Symptoms: Hearts system works client-side in `ExamPage.tsx` but backend `exam_sessions` table has no enforcement; users can theoretically answer more questions than allowed
- Files: `src/web/src/routes/ExamPage.tsx` (client-side enforcement), `supabase/migrations/016_exam_sessions_practice_mode.sql` (schema)
- Trigger: Users on unstable connections may see different heart counts than what's stored
- Workaround: Hearts work in practice for demo due to frontend validation

**Duplicate API Calls in Exam Flow:**
- Symptoms: `ExamPage.tsx` has race condition with `sessionIdRef.current` — multiple concurrent requests can try to create session
- Files: `src/web/src/routes/ExamPage.tsx` (lines 67-90, 171-187)
- Trigger: Rapid interaction during exam start with slow network
- Workaround: Frontend guards against it with `sessionIdRef.current` check, but not atomic

## Security Considerations

**Missing Rate Limiting:**
- Risk: No rate limiting on authentication endpoints or API in general; vulnerable to brute force and abuse
- Files: `src/api/src/main/java/com/nerdquiz/config/SecurityConfig.java`
- Current mitigation: JWT verification protects endpoints, but no throttling
- Recommendations: Add Spring rate limiting middleware or use Supabase edge functions for auth rate limiting

**No CSRF Protection on State-Changing Endpoints:**
- Risk: CSRF disabled globally via `AbstractHttpConfigurer::disable()`, relies on CORS and SameSite cookies
- Files: `src/api/src/main/java/com/nerdquiz/config/SecurityConfig.java` (line 33)
- Current mitigation: CORS restricts origins, stateless JWT auth
- Recommendations: For production, consider enabling CSRF on form-based endpoints or add request validation tokens

**Frontend Direct Supabase Calls:**
- Risk: Frontend calls `supabase.rpc()` directly, bypassing backend validation
- Files: `src/web/src/routes/ExamPage.tsx` (lines 42, 141, 172-186)
- Current mitigation: Supabase Row Level Security policies
- Recommendations: Move all business logic to backend; frontend should only call backend API

**Secrets in `.env` Files:**
- Risk: `.env` files contain real secrets; easy to accidentally commit
- Files: `.env`, `src/web/.env`
- Current mitigation: Listed in `.gitignore`, developer discipline
- Recommendations: Audit `.gitignore` regularly, use GitHub Secrets for CI/CD, consider vault solutions

## Performance Bottlenecks

**N+1 Query Risk in Quiz Results:**
- Problem: `QuizService.getResult()` fetches questions by ID list then maps in Java — could be slow with 60 questions
- Files: `src/api/src/main/java/com/nerdquiz/service/QuizService.java` (lines 135-136)
- Cause: Single query fetches all questions, but `questionMap` creation creates unnecessary intermediate list
- Improvement path: Use `@Query` with JOIN FETCH or `@EntityGraph` to fetch in single query with answers

**Exam Page Multiple useEffect Calls:**
- Problem: `ExamPage.tsx` has 6 useEffect hooks running sequentially, causing multiple re-renders
- Files: `src/web/src/routes/ExamPage.tsx` (lines 55-145)
- Cause: Complex state dependencies between effects
- Improvement path: Consolidate effects using state machines or custom hook (e.g., `useExamSimulation`)

**Unbounded List Rendering:**
- Problem: `MistakeGarden.tsx` and `LearningMap.tsx` render all items without virtualization
- Files: `src/web/src/routes/MistakeGarden.tsx`, `src/web/src/routes/LearningMap.tsx`
- Cause: No list virtualization, all items rendered to DOM
- Improvement path: Implement `react-window` or `react-virtuoso` for lists >50 items

## Fragile Areas

**QuizSession Race Condition:**
- Files: `src/web/src/routes/QuizPage.tsx`, `src/web/src/routes/ExamPage.tsx`
- Why fragile: Multiple state updates and async calls without proper coordination; `submitted` flag not atomic
- Safe modification: Extract quiz session logic into custom hook with proper state machine; test with slow network mocking
- Test coverage: Component tests exist but don't test async flows or race conditions

**Exam Session Creation Timing:**
- Files: `src/web/src/routes/ExamPage.tsx` (lines 60-90)
- Why fragile: Session creation depends on `questions.length > 0` and `!sessionIdRef.current`, but ref not updated atomically
- Safe modification: Use mutex or lock mechanism; ensure single creation call
- Test coverage: No tests for exam session initialization flow

**Streak Calculation Date Logic:**
- Files: `src/api/src/main/java/com/nerdquiz/service/UserService.java`
- Why fragile: Timezone handling across UTC and local time; edge cases around midnight boundaries
- Safe modification: Test with various timezone scenarios, ensure all dates use UTC consistently
- Test coverage: Unit tests exist but may not cover timezone edge cases

**Lesson Completion Side Effects:**
- Files: `src/web/src/hooks/useLessons.ts`, `src/api/src/main/java/com/nerdquiz/service/LessonService.java`
- Why fragile: Lesson completion triggers unlock cascade for dependent lessons; complex transactional logic
- Safe modification: Add integration tests for unlock cascade; verify dependency graph
- Test coverage: Backend tests exist but may not cover full unlock cascade

## Scaling Limits

**Database Connection Pool:**
- Current capacity: Default Spring Boot HikariCP pool (~10 connections)
- Limit: Concurrent users >50 may exhaust pool
- Scaling path: Increase pool size in `application.yml`, add connection pool monitoring

**Exam Session Table Size:**
- Current capacity: No limit on rows in `exam_sessions` table
- Limit: Millions of rows may slow queries without indexing
- Scaling path: Add index on `user_id` and `status`; archive old sessions periodically

**Frontend Bundle Size:**
- Current capacity: ~500KB unminified bundle
- Limit: >1MB bundle will cause slow initial load
- Scaling path: Use route-level code splitting with `React.lazy()`, lazy-load heavy components

## Dependencies at Risk

**Spring Boot 3.5.9 (Java 25):**
- Risk: Cutting-edge Java version may have library compatibility issues
- Impact: Some libraries may not support Java 25 yet, causing runtime errors
- Migration plan: Downgrade to Java 21 if compatibility issues arise; test all dependencies with Java 25

**Vite 8.1.1:**
- Risk: Very new major version (Vite 8 released 2026), may have breaking changes or bugs
- Impact: Build issues, unexpected behavior in dev server
- Migration plan: Pin to Vite 7.x if issues arise; monitor changelog

**React 19.2.7:**
- Risk: React 19 is recent release; some third-party libraries may not support it
- Impact: Component compatibility issues, missing peer dependency warnings
- Migration plan: Verify all dependencies support React 19; downgrade to React 18 if needed

**Tailwind CSS 4.3.2:**
- Risk: Tailwind CSS 4 is relatively new; different configuration format from v3
- Impact: Configuration changes, missing utilities, different styling behavior
- Migration plan: Document v3-v4 differences; pin to v3 if v4 causes issues

## Missing Critical Features

**Backend for Exam Simulation:**
- Problem: No backend service for exams, all logic client-side; no admin visibility into exam attempts
- Blocks: Cannot track exam statistics, cannot enforce hearts server-side, cannot provide exam history

**Backend for Mistake Garden:**
- Problem: Frontend queries Supabase directly, no API endpoints for mistakes
- Blocks: No backend validation, no mistake statistics, cannot scale to complex mistake tracking

**Weak Point Analysis (Week 2):**
- Problem: DB index exists (`idx_mastery_weak_points`) but no service or frontend to display weak points
- Blocks: Cannot show users their weak areas, cannot recommend targeted practice

**Flashcards Feature (Week 2):**
- Problem: DB schema exists (`flashcards`, `user_flashcard_state`, `flashcard_reviews`) but no code
- Blocks: Cannot implement spaced repetition flashcards

**Admin Dashboard (Week 2):**
- Problem: Schema lacks `role` column on `user_profiles`; no admin endpoints
- Blocks: Cannot show admin stats (total users, active users, quiz attempts)

## Test Coverage Gaps

**ExamPage Component:**
- What's not tested: Exam initialization flow, session creation, hearts calculation, timer logic, race conditions
- Files: `src/web/src/routes/ExamPage.tsx`
- Risk: Exam simulation may have subtle bugs that only appear under specific timing/network conditions
- Priority: High — exam simulation is core feature

**QuizPage State Management:**
- What's not tested: Answer submission flow, result calculation, XP awarding
- Files: `src/web/src/routes/QuizPage.tsx`
- Risk: Quiz scoring bugs could frustrate users
- Priority: High — quizzes are core feature

**User Streak Calculation:**
- What's not tested: Timezone edge cases, DST transitions, consecutive day boundaries
- Files: `src/api/src/main/java/com/nerdquiz/service/UserService.java`, `src/api/src/test/java/com/nerdquiz/service/QuizServiceTest.java`
- Risk: Streak resets incorrectly at timezone boundaries
- Priority: Medium — affects user engagement metrics

**Authentication Edge Cases:**
- What's not tested: Expired tokens, invalid tokens, token refresh, concurrent login sessions
- Files: `src/api/src/main/java/com/nerdquiz/config/JwtAuthenticationFilter.java`, `src/web/src/hooks/useAuth.tsx`
- Risk: Users logged out unexpectedly or security bypass
- Priority: High — security critical

**RLS Policy Enforcement:**
- What's not tested: Row-level security policies actually prevent unauthorized access
- Files: `supabase/migrations/*.sql`
- Risk: Data leaks or unauthorized modifications if RLS policies are incorrectly configured
- Priority: Critical — security critical

---

*Concerns audit: 2026-07-14*
