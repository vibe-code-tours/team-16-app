# Remove Heart System from Exam Simulation

## Goal

Remove the heart/lives penalty system from the exam simulation flow. Users answer questions during a countdown timer. When the timer expires or the user manually finishes, show result and per-question feedback.

## Files to change

### Backend

| File | Changes |
|------|---------|
| `ExamService.java` | Remove `INITIAL_HEARTS`, `ExamHeartEventRepository`, heart-decrement logic in `submitAnswer()`, heart fields from session creation |
| `StartExamResponse.java` | Remove `heartsRemaining` |
| `SubmitExamAnswerResponse.java` | Remove `heartsRemaining` |
| `FinishExamResponse.java` | Remove `heartsRemaining` |
| `ExamServiceTest.java` | Remove `examHeartEventRepository` mock, remove heart-related assertions and tests |

### Frontend (switch to component-based implementation)

| File | Changes |
|------|---------|
| `types/Exam.ts` | Remove `initialHearts`, `heartsRemaining`, `examComplete` from all interfaces |
| `hooks/useExamSimulation.ts` | Remove heart state/tracking; fix API calls to match backend's `StartExamRequest(questionCount, difficulty)`; add `stopExam()` and timer-based completion |
| `routes/ExamSimulation.tsx` | Wire to correct API shape; remove heart display; add "Finish Exam" button; handle timer expiry → auto-finish |
| `components/features/exam/ExamStartScreen.tsx` | Change from exam-session/subject selection to difficulty-based start (like current ExamPage) |
| `components/features/exam/ExamResultScreen.tsx` | Remove "Hearts Left" stat (keep score, correct/total, XP, answer review) |
| `components/features/exam/ExamQuestionCard.tsx` | Remove `examComplete` and `heartsRemaining` from result prop |
| `components/features/exam/ExamProgressBar.tsx` | No change needed (no heart references) |
| `components/features/exam/ExamTimer.tsx` | No change needed |
| `App.tsx` | Switch `/exam` route from `ExamPage` to `ExamSimulation` |
| Component test files | Update test mocks to remove heart-related fields |

## Detailed changes

### Backend — ExamService.java

1. **Remove field**: `private static final int INITIAL_HEARTS = 3`
2. **Remove field**: `private final ExamHeartEventRepository examHeartEventRepository`
3. **Remove from constructor**: `ExamHeartEventRepository` parameter
4. **`startExam()`**: Remove lines setting `initialHearts` and `heartsRemaining` on the session
5. **`submitAnswer()`**: Remove heart-decrement logic (lines 139-147), remove `ExamHeartEvent` creation and save
6. **`finishExam()`**: No hearts change needed for response

### Backend — DTOs

Remove `Integer heartsRemaining` from `StartExamResponse`, `SubmitExamAnswerResponse`, `FinishExamResponse`.

### Backend — ExamServiceTest.java

1. Remove `@Mock ExamHeartEventRepository examHeartEventRepository`
2. Remove `sampleSession.setInitialHearts(5)` and `sampleSession.setHeartsRemaining(5)` in `setUp()`
3. Update `startExam_CreatesSessionAndReturnsQuestions`: remove `assertEquals(3, result.heartsRemaining())`
4. Update `submitAnswer_CorrectAnswer_ReturnsCorrect`: remove `assertEquals(5, result.heartsRemaining())`
5. Remove or update `submitAnswer_WrongAnswer_DecreasesHearts`: heart decrement is no longer relevant
6. Update `finishExam_CompletedSession_ReturnsResults`: verify no hearts in response

### Frontend — types/Exam.ts

Remove from:
- `ExamSummary`: `initialHearts`
- `ExamSession`: `heartsRemaining`, `initialHearts`
- `ExamAnswerResult`: `heartsRemaining`, `examComplete`
- `ExamResult`: `heartsRemaining`

### Frontend — useExamSimulation.ts

1. Remove `heartsRemaining` state
2. Fix `fetchAvailableExams()`: Either remove (start screen shows difficulty selection, not session list) or rework for the actual backend
3. Fix `startExam()`: Accept `{questionCount, difficulty}` not `(examSession, subject)`, map to correct API shape
4. Remove heart-related code from `submitAnswer()`
5. Add `stopExam()` / `finishExam()` method that calls the backend finish endpoint
6. Handle timer expiry → auto-finish the exam
7. Fix response type mapping to match backend's actual `StartExamResponse` shape

### Frontend — ExamSimulation.tsx

1. Show `ExamStartScreen` with difficulty selection (after login check)
2. During exam: remove hearts from status bar, keep timer
3. Add "Finish Exam" button in the bottom bar (always visible)
4. When timer hits 0, auto-finish
5. Show `ExamResultScreen` with per-question feedback
6. Remove heart array rendering from header

### Frontend — ExamStartScreen.tsx

Change from "select exam session + subject" to "select difficulty" (all/easy/medium/hard), matching the current behavior in ExamPage.

### Frontend — ExamResultScreen.tsx

Remove the "Hearts Left" stat card (4th column in the grid).

### Frontend — App.tsx

Change line 140-149 from:
```tsx
<Route path="/exam" element={<ProtectedRoute><StudentRoute><Layout><ExamPage /></Layout></StudentRoute></ProtectedRoute>} />
```
to:
```tsx
<Route path="/exam" element={<ProtectedRoute><StudentRoute><Layout><ExamSimulation /></Layout></StudentRoute></ProtectedRoute>} />
```

### Frontend — Test updates

- `ExamStartScreen.test.tsx`: remove `initialHearts: 5` from mock data
- `ExamResultScreen.test.tsx`: remove `heartsRemaining: 3` from mock data; remove test for hearts display
- `ExamQuestionCard.test.tsx`: remove `heartsRemaining` and `examComplete` from mock result objects
