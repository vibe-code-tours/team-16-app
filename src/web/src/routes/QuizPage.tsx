import { useCallback } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'
import { useQuizSession } from '../hooks/useQuizSession'
import { ProgressBar } from '../components/features/ProgressBar'
import { QuizAnswerFeedback } from '../components/features/quiz/QuizAnswerFeedback'
import { QuizQuestionCard } from '../components/features/quiz/QuizQuestionCard'
import { QuizStartScreen } from '../components/features/quiz/QuizStartScreen'

const ROUTE_MAP = '/map'
const PRIMARY_BUTTON =
  'rounded-lg bg-purple-600 px-6 py-3 font-bold text-white transition-colors hover:bg-purple-700'

export function QuizPage() {
  const { subtopicId } = useParams<{ subtopicId: string }>()
  const navigate = useNavigate()
  const { refreshUser } = useAuth()
  const quiz = useQuizSession(subtopicId)
  const { currentQuestion, currentIndex, questions } = quiz

  const handleBackToMap = useCallback(() => navigate(ROUTE_MAP), [navigate])

  const handleQuit = useCallback(() => {
    if (currentIndex > 0 && !window.confirm('Are you sure? Your progress will be lost.')) {
      return
    }
    navigate(ROUTE_MAP)
  }, [currentIndex, navigate])

  const handleNext = () => {
    if (!quiz.isLastQuestion) {
      quiz.goToNextQuestion()
      return
    }
    refreshUser()
    navigate(`/quiz-result/${quiz.sessionId}`)
  }

  if (!quiz.hasStarted) {
    return <QuizStartScreen onStart={quiz.startQuiz} onBack={handleBackToMap} />
  }

  if (quiz.isLoading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900">
        <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-purple-600" />
      </div>
    )
  }

  if (quiz.error) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900 px-4">
        <div className="max-w-md rounded-xl border border-red-200 bg-red-50 p-6 text-center text-sm text-red-700 dark:border-red-800 dark:bg-red-900/30 dark:text-red-400">
          Couldn't load quiz: {quiz.error}
        </div>
      </div>
    )
  }

  if (!currentQuestion) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900 px-4">
        <div className="max-w-md rounded-2xl border border-gray-200 bg-white p-8 text-center dark:border-gray-700 dark:bg-gray-800">
          <h2 className="mb-2 text-xl font-bold text-gray-900 dark:text-gray-100">No quiz available yet</h2>
          <p className="mb-6 text-sm text-gray-500 dark:text-gray-400">
            We don't have any practice questions for this subtopic yet. Try another topic on the map.
          </p>
          <button
            onClick={handleBackToMap}
            className="rounded-lg bg-purple-600 px-4 py-2 font-medium text-white hover:bg-purple-700"
          >
            Back to Map
          </button>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <header className="border-b border-gray-200 bg-white dark:border-gray-700 dark:bg-gray-800">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-4">
          <button
            onClick={handleQuit}
            className="flex items-center gap-2 font-medium text-purple-600 hover:text-purple-800 dark:text-purple-400 dark:hover:text-purple-300"
          >
            ← Quit quiz
          </button>
          <div className="text-sm font-medium text-gray-500 dark:text-gray-400">
            Question {currentIndex + 1} of {questions.length}
          </div>
        </div>
      </header>

      <div className="mx-auto max-w-2xl px-4 py-8">
        <div className="mb-8">
          <ProgressBar current={currentIndex + 1} total={questions.length} showLabel={false} variant="solid" />
        </div>

        <QuizQuestionCard
          question={currentQuestion}
          selectedLabel={quiz.selectedLabel}
          isAnswered={quiz.isAnswered}
          onSelect={quiz.selectAnswer}
        />

        {quiz.isAnswered && currentQuestion.explanation && (
          <QuizAnswerFeedback isCorrect={quiz.isCorrect} explanation={currentQuestion.explanation} />
        )}

        <div className="flex justify-end">
          {quiz.isAnswered ? (
            <button onClick={handleNext} className={PRIMARY_BUTTON}>
              {quiz.isLastQuestion ? 'See results' : 'Next question'}
            </button>
          ) : (
            <button
              onClick={quiz.checkAnswer}
              disabled={!quiz.selectedLabel}
              className={`${PRIMARY_BUTTON} disabled:cursor-not-allowed disabled:opacity-50`}
            >
              Check answer
            </button>
          )}
        </div>
      </div>
    </div>
  )
}
