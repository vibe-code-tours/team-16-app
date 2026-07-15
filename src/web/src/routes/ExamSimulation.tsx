import { useEffect, useCallback } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { useExamSimulation } from '../hooks/useExamSimulation'
import { useAuth } from '../hooks/useAuth'
import { ExamStartScreen } from '../components/features/exam/ExamStartScreen'
import { ExamQuestionCard } from '../components/features/exam/ExamQuestionCard'
import { ExamTimer } from '../components/features/exam/ExamTimer'
import { ExamProgressBar } from '../components/features/exam/ExamProgressBar'
import { ExamResultScreen } from '../components/features/exam/ExamResultScreen'
import { Button } from '../components/ui/Button'

export default function ExamSimulation() {
  const { session: authSession } = useAuth()
  const navigate = useNavigate()
  const { sessionId: routeSessionId } = useParams<{ sessionId?: string }>()
  const {
    availableExams,
    session,
    currentQuestion,
    currentIndex,
    answers,
    heartsRemaining,
    timeRemaining,
    isLoading,
    isSubmitting,
    error,
    result,
    fetchAvailableExams,
    startExam,
    selectAnswer,
    submitAnswer,
    nextQuestion,
    goToQuestion,
    completeExam,
    reset,
  } = useExamSimulation()

  useEffect(() => {
    fetchAvailableExams()
  }, [fetchAvailableExams])

  useEffect(() => {
    if (!session || routeSessionId === session.sessionId) return
    navigate(`/exam/${session.sessionId}`, { replace: true })
  }, [navigate, routeSessionId, session])

  const handleSubmitAnswer = useCallback(async () => {
    if (!currentQuestion) return
    await submitAnswer(currentQuestion.id)
  }, [currentQuestion, submitAnswer])

  const handleComplete = useCallback(async () => {
    await completeExam()
  }, [completeExam])

  const handleTryAgain = useCallback(() => {
    reset()
    fetchAvailableExams()
    navigate('/exam', { replace: true })
  }, [reset, fetchAvailableExams, navigate])

  // Auto-advance after answer submitted
  useEffect(() => {
    if (!session || !currentQuestion) return
    const answer = answers[currentQuestion.id]
    if (answer?.submitted && answer.result?.examComplete) {
      // Exam ended — don't auto-advance, result will show
      return
    }
  }, [answers, currentQuestion, session])

  // Show result screen
  if (result) {
    return (
      <div className="min-h-screen bg-gray-50">
        <main className="mx-auto max-w-3xl px-4 py-6">
          <ExamResultScreen result={result} onTryAgain={handleTryAgain} />
        </main>
      </div>
    )
  }

  // Show exam in progress
  if (session) {
    const currentAnswer = currentQuestion ? answers[currentQuestion.id] : null
    const isAnswered = currentAnswer?.submitted === true
    // Check if all questions are answered
    const allAnswered = session.questions.every(
      (q) => answers[q.id]?.submitted === true
    )

    return (
      <div className="min-h-screen bg-gray-50">
        {/* Exam status bar */}
        <div className="sticky top-16 z-10 border-b border-gray-200 bg-white">
          <div className="mx-auto flex max-w-3xl items-center justify-between px-4 py-2">
            <span className="text-sm font-medium text-gray-600">
              {session.title} — Subject {session.subject}
            </span>
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-1">
                {Array.from({ length: session.initialHearts }).map((_, i) => (
                  <span key={i} className={`text-sm ${i < heartsRemaining ? 'text-red-500' : 'text-gray-300'}`}>
                    ❤️
                  </span>
                ))}
              </div>
              <ExamTimer timeRemaining={timeRemaining} />
            </div>
          </div>
        </div>

        {/* Main content */}
        <main className="mx-auto max-w-3xl px-4 pb-32 pt-6">
          {/* Progress */}
          <div className="mb-6">
            <ExamProgressBar
              questions={session.questions}
              currentIndex={currentIndex}
              answers={answers}
              onGoTo={goToQuestion}
            />
            <p className="mt-2 text-sm text-gray-500">
              Question {currentIndex + 1} of {session.questions.length}
            </p>
          </div>

          {/* Question */}
          {currentQuestion && (
            <ExamQuestionCard
              key={currentQuestion.id}
              question={currentQuestion}
              selectedAnswer={currentAnswer?.selected || null}
              isSubmitted={isAnswered}
              result={currentAnswer?.result || null}
              onSelect={(label) => selectAnswer(currentQuestion.id, label)}
            />
          )}

          {/* Error message */}
          {error && (
            <div className="mt-4 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700" role="alert">
              {error}
            </div>
          )}

          {/* Actions */}
          <div
            className="fixed inset-x-0 bottom-0 z-40 border-t border-gray-200 bg-white/95 shadow-[0_-4px_16px_rgba(15,23,42,0.08)] backdrop-blur lg:left-64"
            role="group"
            aria-label="Exam navigation"
          >
            <div className="mx-auto flex max-w-3xl flex-wrap items-center justify-between gap-3 px-4 py-3">
              <Button
                variant="ghost"
                onClick={() => goToQuestion(Math.max(0, currentIndex - 1))}
                disabled={currentIndex === 0}
              >
                ← Previous
              </Button>

              <div className="flex flex-wrap justify-end gap-3">
                {!isAnswered ? (
                  <>
                    {/* Skip button for optional questions */}
                    {!currentQuestion?.isRequired && (
                      <Button
                        variant="ghost"
                        onClick={handleSubmitAnswer}
                        disabled={isSubmitting}
                      >
                        Skip
                      </Button>
                    )}
                    <Button
                      onClick={handleSubmitAnswer}
                      disabled={isSubmitting || (!currentAnswer?.selected && currentQuestion?.isRequired)}
                    >
                      {isSubmitting ? 'Submitting...' : 'Submit Answer'}
                    </Button>
                  </>
                ) : allAnswered ? (
                  <Button onClick={handleComplete} disabled={isLoading}>
                    {isLoading ? 'Finishing...' : 'Finish Exam'}
                  </Button>
                ) : (
                  <Button onClick={nextQuestion}>
                    Next Question →
                  </Button>
                )}
              </div>
            </div>
          </div>

          {/* Complete exam button (always available) */}
          {!allAnswered && (
            <div className="mt-8 text-center">
              <Button variant="outline" onClick={handleComplete} disabled={isLoading}>
                Submit Early
              </Button>
            </div>
          )}
        </main>
      </div>
    )
  }

  // Show start screen (no session yet)
  return (
    <div className="min-h-screen bg-gray-50">
      <main className="mx-auto max-w-3xl px-4 py-6">
        {!authSession ? (
          <div className="flex flex-col items-center justify-center py-16">
            <div className="w-full max-w-md rounded-2xl border border-gray-200 bg-white p-8 text-center shadow-sm">
              <div className="mb-4 text-5xl">📝</div>
              <h2 className="text-2xl font-bold text-gray-900">Exam Simulation</h2>
              <p className="mt-3 text-gray-500">
                Test your knowledge with a timed exam simulation.
                Track your progress and earn XP!
              </p>
              <div className="mt-6 flex flex-col gap-3">
                <Button
                  size="lg"
                  onClick={() => navigate('/login')}
                  className="w-full"
                >
                  Log In to Start
                </Button>
                <Button
                  variant="outline"
                  size="lg"
                  onClick={() => navigate('/register')}
                  className="w-full"
                >
                  Create Account
                </Button>
              </div>
            </div>
          </div>
        ) : (
          <>
            {error && availableExams.length === 0 && (
              <div className="mb-4 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-700" role="alert">
                <p className="font-medium">Could not load exams</p>
                <p className="mt-1">The server might be temporarily unavailable. Please try again later.</p>
                <Button
                  variant="ghost"
                  size="sm"
                  className="mt-2"
                  onClick={fetchAvailableExams}
                >
                  Retry
                </Button>
              </div>
            )}
            <ExamStartScreen
              exams={availableExams}
              isLoading={isLoading}
              isStarting={isLoading && availableExams.length > 0}
              onStart={startExam}
            />
          </>
        )}
      </main>
    </div>
  )
}
