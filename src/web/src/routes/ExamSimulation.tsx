import { useCallback } from 'react'
import { Link, useNavigate } from 'react-router-dom'
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
  const {
    session,
    currentQuestion,
    currentIndex,
    answers,
    timeRemaining,
    isLoading,
    isSubmitting,
    error,
    result,
    startExam,
    selectAnswer,
    submitAnswer,
    nextQuestion,
    goToQuestion,
    finishExam,
    reset,
  } = useExamSimulation()

  const handleSubmitAnswer = useCallback(async () => {
    if (!currentQuestion) return
    await submitAnswer(currentQuestion.id)
  }, [currentQuestion, submitAnswer])

  const handleFinish = useCallback(async () => {
    await finishExam()
  }, [finishExam])

  const handleTryAgain = useCallback(() => {
    reset()
    navigate('/exam', { replace: true })
  }, [reset, navigate])

  // Check if all questions are answered
  const allAnswered = session
    ? session.questions.every((q) => answers[q.id]?.submitted === true)
    : false

  // Check if all remaining questions are answered (for navigating past current)
  const currentAnswer = currentQuestion ? answers[currentQuestion.id] : null
  const isAnswered = currentAnswer?.submitted === true

  // Full page layout wrapper — used for all states
  const PageWrapper = ({ children }: { children: React.ReactNode }) => (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      {children}
    </div>
  )

  // Show result screen
  if (result) {
    return (
      <PageWrapper>
        <main className="mx-auto max-w-3xl px-4 py-6">
          <ExamResultScreen result={result} onTryAgain={handleTryAgain} />
        </main>
      </PageWrapper>
    )
  }

  // Show exam in progress
  if (session) {
    return (
      <PageWrapper>
        {/* Exam status bar */}
        <div className="sticky top-0 z-10 border-b border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800">
          <div className="mx-auto flex max-w-3xl items-center justify-between px-4 py-2">
            <span className="text-sm font-medium text-gray-600 dark:text-gray-400">
              Exam Simulation
            </span>
            <div className="flex items-center gap-4">
              <Button
                variant="ghost"
                size="sm"
                onClick={handleFinish}
                disabled={isLoading}
              >
                {isLoading ? 'Finishing...' : 'Finish Exam'}
              </Button>
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
            <p className="mt-2 text-sm text-gray-500 dark:text-gray-400">
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
            <div className="mt-4 rounded-xl border border-red-200 dark:border-red-800 bg-red-50 dark:bg-red-900/30 p-4 text-sm text-red-700 dark:text-red-400" role="alert">
              {error}
            </div>
          )}

          {/* Bottom navigation */}
          <div
            className="fixed inset-x-0 bottom-0 z-40 border-t border-gray-200 dark:border-gray-700 bg-white/95 dark:bg-gray-800/95 shadow-[0_-4px_16px_rgba(15,23,42,0.08)] backdrop-blur"
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
                  <Button
                    onClick={handleSubmitAnswer}
                    disabled={isSubmitting || !currentAnswer?.selected}
                  >
                    {isSubmitting ? 'Submitting...' : 'Submit Answer'}
                  </Button>
                ) : allAnswered ? (
                  <Button onClick={handleFinish} disabled={isLoading}>
                    {isLoading ? 'Finishing...' : 'View Results'}
                  </Button>
                ) : (
                  <Button onClick={nextQuestion}>
                    Next Question →
                  </Button>
                )}
              </div>
            </div>
          </div>

          {/* Submit early button */}
          {!allAnswered && (
            <div className="mt-8 text-center">
              <Button variant="outline" onClick={handleFinish} disabled={isLoading}>
                Submit Early
              </Button>
            </div>
          )}
        </main>
      </PageWrapper>
    )
  }

  // Show start screen (no session yet)
  return (
    <PageWrapper>
      {/* Minimal nav bar for the start screen */}
      <header className="border-b border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800">
        <div className="mx-auto flex h-14 max-w-3xl items-center justify-between px-4">
          <Link
            to="/map"
            className="flex items-center gap-2 text-sm font-medium text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-gray-200"
          >
            <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
            </svg>
            Back to Map
          </Link>
          <div className="flex items-center gap-2">
            <span className="text-lg">🦉</span>
            <span className="text-base font-bold text-purple-600 dark:text-purple-400">NerdQuiz</span>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-3xl px-4 py-6">
        {!authSession ? (
          <div className="flex flex-col items-center justify-center py-16">
            <div className="w-full max-w-md rounded-2xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-8 text-center shadow-sm">
              <div className="mb-4 text-5xl">📝</div>
              <h2 className="text-2xl font-bold text-gray-900 dark:text-gray-100">Exam Simulation</h2>
              <p className="mt-3 text-gray-500 dark:text-gray-400">
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
            {error && (
              <div className="mb-4 rounded-xl border border-amber-200 dark:border-amber-800 bg-amber-50 dark:bg-amber-900/30 p-4 text-sm text-amber-700 dark:text-amber-400" role="alert">
                <p className="font-medium">Could not start exam</p>
                <p className="mt-1 font-mono text-xs">{error}</p>
              </div>
            )}
            <ExamStartScreen
              isLoading={isLoading}
              isStarting={isLoading}
              onStart={startExam}
            />
          </>
        )}
      </main>
    </PageWrapper>
  )
}
