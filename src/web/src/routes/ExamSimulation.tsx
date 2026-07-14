import { useEffect, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import { useExamSimulation } from '../hooks/useExamSimulation'
import { useAuth } from '../hooks/useAuth'
import { ExamStartScreen } from '../components/features/exam/ExamStartScreen'
import { ExamQuestionCard } from '../components/features/exam/ExamQuestionCard'
import { ExamTimer } from '../components/features/exam/ExamTimer'
import { ExamProgressBar } from '../components/features/exam/ExamProgressBar'
import { ExamResultScreen } from '../components/features/exam/ExamResultScreen'
import { Button } from '../components/ui/Button'

export default function ExamSimulation() {
  const { user } = useAuth()
  const navigate = useNavigate()
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
  }, [reset, fetchAvailableExams])

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
        <header className="border-b border-gray-200 bg-white">
          <div className="mx-auto flex max-w-3xl items-center justify-between px-4 py-3">
            <h1 className="text-lg font-bold text-purple-600">NerdQuiz</h1>
            <span className="text-sm text-gray-500">Exam Complete</span>
          </div>
        </header>
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
    const isAnsweredCorrectly = currentAnswer?.result?.isCorrect === true

    // Check if all questions are answered
    const allAnswered = session.questions.every(
      (q) => answers[q.id]?.submitted === true
    )

    return (
      <div className="min-h-screen bg-gray-50">
        {/* Header */}
        <header className="sticky top-0 z-10 border-b border-gray-200 bg-white">
          <div className="mx-auto flex max-w-3xl items-center justify-between px-4 py-3">
            <div className="flex items-center gap-3">
              <h1 className="text-lg font-bold text-purple-600">NerdQuiz</h1>
              <span className="text-sm text-gray-500">
                {session.title} — Subject {session.subject}
              </span>
            </div>
            <div className="flex items-center gap-4">
              {/* Hearts */}
              <div className="flex items-center gap-1">
                {Array.from({ length: session.initialHearts }).map((_, i) => (
                  <span key={i} className={i < heartsRemaining ? 'text-red-500' : 'text-gray-300'}>
                    ❤️
                  </span>
                ))}
              </div>
              <ExamTimer timeRemaining={timeRemaining} />
            </div>
          </div>
        </header>

        {/* Main content */}
        <main className="mx-auto max-w-3xl px-4 py-6">
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
          <div className="mt-6 flex items-center justify-between">
            <Button
              variant="ghost"
              onClick={() => goToQuestion(Math.max(0, currentIndex - 1))}
              disabled={currentIndex === 0}
            >
              ← Previous
            </Button>

            <div className="flex gap-3">
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
              ) : (
                <>
                  {allAnswered ? (
                    <Button onClick={handleComplete} disabled={isLoading}>
                      {isLoading ? 'Finishing...' : 'Finish Exam'}
                    </Button>
                  ) : (
                    <Button onClick={nextQuestion}>
                      Next Question →
                    </Button>
                  )}
                </>
              )}
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
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-3xl items-center justify-between px-4 py-3">
          <h1 className="text-lg font-bold text-purple-600">NerdQuiz</h1>
          <span className="text-sm text-gray-500">Exam Simulation</span>
        </div>
      </header>
      <main className="mx-auto max-w-3xl px-4 py-6">
        {error && (
          <div className="mb-4 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700" role="alert">
            {error}
          </div>
        )}
        {!user ? (
          <div className="rounded-xl border border-gray-200 bg-white p-8 text-center">
            <h2 className="text-xl font-bold text-gray-900">Login Required</h2>
            <p className="mt-2 text-gray-600">
              You need to be logged in to start an exam simulation.
            </p>
            <div className="mt-6 flex justify-center gap-4">
              <Button onClick={() => navigate('/login')}>
                Log In
              </Button>
              <Button variant="outline" onClick={() => navigate('/register')}>
                Sign Up
              </Button>
            </div>
          </div>
        ) : (
          <ExamStartScreen
            exams={availableExams}
            isLoading={isLoading}
            isStarting={isLoading && availableExams.length > 0}
            onStart={startExam}
          />
        )}
      </main>
    </div>
  )
}
