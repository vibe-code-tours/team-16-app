# Real Exam Simulation — Implementation Report

> **Feature:** Real Exam Simulation (ITPEC FE format)
> **Date:** 2026-07-24
> **Approach:** GSD (Get Shit Done) — full-stack implementation with tests

---

## What Was Built

### Backend (Spring Boot)
- **3 JPA entities:** `ExamSession`, `ExamAnswer`, `ExamSessionQuestion`
- **3 repositories:** `ExamSessionRepository`, `ExamAnswerRepository`, `ExamSessionQuestionRepository`
- **DTOs:** `StartExamRequest`, `StartExamResponse`, `SubmitExamAnswerRequest`, `SubmitExamAnswerResponse`, `FinishExamRequest`, `FinishExamResponse`, `ExamResultResponse`
- **1 service:** `ExamService` — full business logic for exam lifecycle (start, submit, finish, get result)
- **1 controller:** `ExamController` — 4 REST endpoints
- **2 test classes:** `ExamServiceTest` (14 tests), `ExamControllerTest` (8 tests)

### Frontend (React)
- **1 type file:** `Exam.ts` — 5 TypeScript interfaces
- **1 custom hook:** `useExamSimulation` — all exam state + API calls
- **6 components:** `ExamStartScreen`, `ExamQuestionCard`, `ExamTimer`, `ExamProgressBar`, `ExamResultScreen`, `ExamSimulation` (route)
- **4 test files:** 18 tests across components

### API Endpoints
| Method | Path | Auth | Description |
|---|---|---|---|
| `POST` | `/api/v1/exams/start` | Yes | Start exam session with difficulty selection |
| `POST` | `/api/v1/exams/{id}/answers` | Yes | Submit answer with immediate correct/incorrect feedback |
| `POST` | `/api/v1/exams/{id}/finish` | Yes | Finish exam (status: completed/expired/abandoned) |
| `GET` | `/api/v1/exams/{id}/result` | Yes | Get full results with per-question answer breakdown |

### Exam Format Implemented
| | Subject A (Morning) | Subject B (Afternoon) |
|---|---|---|
| Questions | Q1–Q60, all compulsory | Q1–Q8 with selection rules |
| Time | 60 minutes | 60 minutes |
| Data | 60 questions (seeded) | 8 questions (seeded) |

### Key Design Decisions
- **No heart/lives system** — wrong answers don't penalize lives; the countdown timer is the only pressure mechanism
- **Per-question feedback** — after each submission, the user sees correct/incorrect with explanation
- **Countdown auto-finish** — when timer expires, status becomes `"expired"` and results are shown
- **Manual finish with "View Results"** — user can submit all answers and finish early
- **Per-question result endpoint** — `GET /api/v1/exams/{id}/result` returns each question with user's answer, correct answer, and explanation
- **Difficulty selection** — start screen lets users filter questions by difficulty (all/easy/medium/hard)
- **XPs awarded on completion** — correct answers earn XP toward the user's total

### Mistake Garden Integration
- Incorrect answers are eligible for mistake garden review (tracked via `ExamAnswer.is_correct` field)
- Source tracked as a finished exam session in the `exam_sessions` table

---

## Challenges Faced

### 1. Two Competing Exam Implementations
**Challenge:** The codebase had two exam simulation implementations — a self-contained `ExamPage.tsx` (433 lines, direct Supabase calls, inline UI) and a component-based `ExamSimulation.tsx` (lazily routed). The `ExamPage` was the one actually registered in the router.

**Resolution:** The component-based implementation was chosen as the active route. It uses the backend API exclusively, has proper component decomposition, and cleaner state management via the `useExamSimulation` hook.

### 2. API Shape Inconsistencies
**Challenge:** The frontend hook was designed for a different backend API shape (exam session/subject-based start, hearts in responses). The actual backend uses difficulty-based start and doesn't have hearts.

**Resolution:** Rewrote `useExamSimulation` to match the server's actual `StartExamRequest(questionCount, difficulty)` shape and removed all heart tracking. Added `ExamResultResponse` DTO with per-question details for the result screen.

### 3. Heart System State Management
**Challenge:** The previous implementation had a full heart/lives system: `INITIAL_HEARTS`, `ExamHeartEvent` entity, `exam_heart_events` table, heart decrement logic in `submitAnswer()`, auto-completion when hearts hit 0, and heart displays in UI components. Removing this required coordinated changes across the full stack.

**Resolution:** Removed the heart system entirely:
- Backend: removed `ExamHeartEventRepository`, heart fields from session creation, heart decrement logic
- DTOs: removed `heartsRemaining` from all response DTOs
- Frontend: removed heart state, heart UI rendering, and auto-finish-on-zero-hearts effect
- DB: columns remain (nullable/unused) — no migration needed

### 4. Timer + State Coordination
**Challenge:** The exam needs real-time timer countdown, auto-completion when timer expires, and coordination between client-side countdown and server-side expiry validation.

**Resolution:** Centralized all state in `useExamSimulation` hook with `useEffect` for timer countdown and `useCallback` for stable function references. Timer expiry triggers the `finishExam()` function automatically. Server also validates `expires_at` on every answer submission.

---

## Pros and Cons

### Pros

| Aspect | Detail |
|---|---|
| **Real exam format** | Follows actual ITPEC FE structure with timer and scoring |
| **Backend-driven** | All logic lives in the backend — frontend is a thin UI layer |
| **No lives penalty** | Removed frustrating heart system; honest countdown timer is the only pressure |
| **Per-question feedback** | Immediate correct/incorrect feedback after each answer with explanation |
| **Detailed result screen** | Full answer review showing every question, user answer, correct answer, and explanation |
| **Timer** | Server-set expiry time, client-side countdown with warning states (amber at 5min, red at 1min) |
| **Component architecture** | 6 focused components vs 433-line monolith |
| **Test coverage** | Backend + frontend tests covering happy paths and edge cases |
| **Mobile-first** | Responsive layout with proper touch targets |

### Cons

| Aspect | Detail |
|---|---|
| **Subject A has 60 questions, not 80** | Real exam has 80 questions; we only have 60 seeded |
| **Subject B has 8 questions** | Real exam has selection; we simulate with what's available |
| **No exam history page** | Can't view past exam attempts (would need additional frontend) |
| **No streak integration** | Exam completion doesn't update daily streak |
| **Timer is client-side** | A user could manipulate the timer; server-side expiry is checked on submit |

---

## Files Created/Modified

### New Files

**Backend:**
```
src/api/src/main/java/com/nerdquiz/dto/ExamResultResponse.java
src/api/src/main/java/com/nerdquiz/dto/ExamAnswerDetailResponse.java
src/api/src/main/java/com/nerdquiz/dto/FinishExamResponse.java
src/api/src/main/java/com/nerdquiz/dto/FinishExamRequest.java
```

**Modified Files**

**Backend:**
```
src/api/src/main/java/com/nerdquiz/service/ExamService.java — removed heart system
src/api/src/main/java/com/nerdquiz/controller/ExamController.java — added GET result endpoint
src/api/src/main/java/com/nerdquiz/repository/ExamAnswerRepository.java — added findByExamSessionIdOrderBySequenceNumber
src/api/src/main/java/com/nerdquiz/dto/StartExamResponse.java — removed heartsRemaining
src/api/src/main/java/com/nerdquiz/dto/SubmitExamAnswerResponse.java — removed heartsRemaining, added correctAnswer+explanation
src/api/src/main/java/com/nerdquiz/dto/FinishExamResponse.java — removed heartsRemaining
src/api/src/test/java/com/nerdquiz/service/ExamServiceTest.java — removed heart mocks
src/api/src/test/java/com/nerdquiz/controller/ExamControllerTest.java — updated DTO constructors
```

**Frontend:**
```
src/web/src/App.tsx — switched to ExamSimulation route
src/web/src/types/Exam.ts — removed heart fields
src/web/src/hooks/useExamSimulation.ts — removed hearts, fixed API calls, added finish
src/web/src/routes/ExamSimulation.tsx — removed hearts, added finish button
src/web/src/components/features/exam/ExamStartScreen.tsx — changed to difficulty selection
src/web/src/components/features/exam/ExamResultScreen.tsx — removed hearts stat
src/web/src/components/features/exam/__tests__/ExamStartScreen.test.tsx — updated for new props
src/web/src/components/features/exam/__tests__/ExamResultScreen.test.tsx — removed hearts from mocks
src/web/src/components/features/exam/__tests__/ExamQuestionCard.test.tsx — removed hearts from mocks
```

---

## Test Results

### Backend Tests (Java)
- **ExamServiceTest:** 14 tests — all passing
- **ExamControllerTest:** 8 tests — all passing

### Frontend Tests (Vitest)
- **ExamQuestionCard:** 7 tests ✅
- **ExamTimer:** 4 tests ✅
- **ExamStartScreen:** 4 tests ✅
- **ExamResultScreen:** 8 tests ✅
- **Total:** 146 tests passing across 27 test files

---

## Next Steps

1. **Seed 80-question Subject A data** — Currently 60 per session; need full ITPEC FE datasets
2. **Add exam history page** — Show past attempts with scores and trends
3. **Add streak integration** — Update daily activity on exam completion
4. **Add 2022-October data** — Extract and seed the October 2022 exam papers
