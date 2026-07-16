import { useEffect, useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { api } from '../lib/api'
import type { QuizQuestion } from '../types'

interface QuizQuestionFromApi {
  id: string
  subtopicId: string
  questionText: string
  choices: { label: string; text: string }[]
  correctAnswer: string
  explanation: string | null
}

const QUIZ_LENGTH = 5
const XP_PER_CORRECT = 10

export function QuizPage() {
  const { subtopicId } = useParams<{ subtopicId: string }>()
  const navigate = useNavigate()
  const [questions, setQuestions] = useState<QuizQuestion[]>([])
  const [sessionId, setSessionId] = useState<string | null>(null)
  const [index, setIndex] = useState(0)
  const [selectedLabel, setSelectedLabel] = useState<string | null>(null)
  const [isAnswered, setIsAnswered] = useState(false)
  const [score, setScore] = useState(0)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [finished, setFinished] = useState(false)

  useEffect(() => {
    let cancelled = false

    async function load() {
      if (!subtopicId) return
      setLoading(true)
      setError(null)

      try {
        const data = await api.get<QuizQuestionFromApi[]>(
          `/api/v1/subtopics/${subtopicId}/quiz?count=${QUIZ_LENGTH}`
        )
        if (cancelled) return
        setQuestions(
          data.map((q) => ({
            id: q.id,
            subtopic_id: q.subtopicId,
            question_text: q.questionText,
            choices: q.choices,
            correct_answer: q.correctAnswer,
            explanation: q.explanation,
          }))
        )

        // Create quiz session for tracking
        if (!cancelled) {
          const session = await api.post<{ id: string }>(
            '/api/v1/quizzes/start',
            { subtopicId, questionCount: data.length }
          )
          if (!cancelled) setSessionId(session.id)
        }
      } catch (e) {
        if (cancelled) return
        setError(e instanceof Error ? e.message : 'Failed to load quiz')
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    load()

    return () => {
      cancelled = true
    }
  }, [subtopicId])

  const currentQuestion = questions[index]
  const isLastQuestion = index === questions.length - 1

  const handleSelect = (label: string) => {
    if (isAnswered) return
    setSelectedLabel(label)
  }

  const handleCheck = async () => {
    if (!selectedLabel || !currentQuestion) return
    setIsAnswered(true)

    const correct = selectedLabel === currentQuestion.correct_answer
    if (correct) {
      setScore((s) => s + 1)
    }

    // Submit answer to quiz session (backend tracks mastery + daily activity)
    if (sessionId) {
      api.post(`/api/v1/quizzes/${sessionId}/answers`, {
        questionId: currentQuestion.id,
        answer: selectedLabel,
      }).catch((err) => console.error('Failed to record answer:', err))
    }
  }

  const handleNext = () => {
    if (!isLastQuestion) {
      setIndex((i) => i + 1)
      setSelectedLabel(null)
      setIsAnswered(false)
      return
    }
    setFinished(true)
  }

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50">
        <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-purple-600" />
      </div>
    )
  }

  if (error) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 px-4">
        <div className="max-w-md rounded-xl border border-red-200 bg-red-50 p-6 text-center text-sm text-red-700">
          Couldn't load quiz: {error}
        </div>
      </div>
    )
  }

  if (questions.length === 0) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 px-4">
        <div className="max-w-md rounded-2xl border border-gray-200 bg-white p-8 text-center">
          <h2 className="mb-2 text-xl font-bold text-gray-900">No quiz available yet</h2>
          <p className="mb-6 text-sm text-gray-500">
            We don't have any practice questions for this subtopic yet. Try another topic on the map.
          </p>
          <button
            onClick={() => navigate('/map')}
            className="rounded-lg bg-purple-600 px-4 py-2 font-medium text-white hover:bg-purple-700"
          >
            Back to Map
          </button>
        </div>
      </div>
    )
  }

  if (finished) {
    const earnedXp = score * XP_PER_CORRECT
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 px-4">
        <div className="w-full max-w-md rounded-2xl border border-gray-200 bg-white p-8 text-center shadow-sm">
          <div className="mx-auto mb-4 flex h-20 w-20 items-center justify-center rounded-full bg-purple-100 text-3xl text-purple-600">
            🎉
          </div>
          <h2 className="mb-2 text-2xl font-bold text-gray-900">Quiz complete!</h2>
          <p className="mb-6 text-gray-500">
            You scored{' '}
            <span className="font-bold text-purple-600">
              {score} / {questions.length}
            </span>
          </p>
          <div className="mb-8 rounded-xl bg-purple-50 p-4">
            <p className="text-sm font-medium text-purple-600">XP earned</p>
            <p className="text-3xl font-bold text-purple-700">+{earnedXp} XP</p>
          </div>
          <button
            onClick={() => navigate('/map')}
            className="w-full rounded-lg bg-purple-600 px-4 py-3 font-bold text-white transition-colors hover:bg-purple-700"
          >
            Back to Map
          </button>
        </div>
      </div>
    )
  }

  const isCorrect = isAnswered && selectedLabel === currentQuestion.correct_answer

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-4">
          <button
            onClick={() => navigate('/map')}
            className="flex items-center gap-2 font-medium text-purple-600 hover:text-purple-800"
          >
            ← Quit quiz
          </button>
          <div className="text-sm font-medium text-gray-500">
            Question {index + 1} of {questions.length}
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-2xl px-4 py-8">
        <div className="mb-8 h-2 w-full overflow-hidden rounded-full bg-gray-200">
          <div
            className="h-full bg-purple-600 transition-all duration-500"
            style={{ width: `${((index + 1) / questions.length) * 100}%` }}
          />
        </div>

        <h2 className="mb-6 whitespace-pre-line text-lg font-semibold leading-relaxed text-gray-900">
          {currentQuestion.question_text}
        </h2>

        <div className="mb-8 space-y-3">
          {currentQuestion.choices.map((choice) => {
            const isSelected = selectedLabel === choice.label
            const isCorrectChoice = choice.label === currentQuestion.correct_answer

            let styles = 'border-gray-200 bg-white text-gray-700'
            if (isAnswered && isCorrectChoice) styles = 'border-green-500 bg-green-50 text-green-800'
            else if (isAnswered && isSelected) styles = 'border-red-500 bg-red-50 text-red-800'
            else if (isSelected) styles = 'border-purple-600 bg-purple-50 text-purple-800'

            return (
              <button
                key={choice.label}
                onClick={() => handleSelect(choice.label)}
                disabled={isAnswered}
                className={`w-full rounded-xl border-2 p-4 text-left transition ${styles}`}
              >
                <span className="mr-2 font-bold uppercase">{choice.label}.</span>
                {choice.text}
              </button>
            )
          })}
        </div>

        {isAnswered && currentQuestion.explanation ? (
          <div
            className={`mb-6 rounded-xl border p-4 text-sm ${
              isCorrect ? 'border-green-200 bg-green-50 text-green-800' : 'border-orange-200 bg-orange-50 text-orange-800'
            }`}
          >
            <p className="mb-1 font-bold">{isCorrect ? 'Correct!' : 'Not quite.'}</p>
            <p>{currentQuestion.explanation}</p>
          </div>
        ) : null}

        <div className="flex justify-end">
          {!isAnswered ? (
            <button
              onClick={handleCheck}
              disabled={!selectedLabel}
              className="rounded-lg bg-purple-600 px-6 py-3 font-bold text-white transition-colors hover:bg-purple-700 disabled:cursor-not-allowed disabled:opacity-50"
            >
              Check answer
            </button>
          ) : (
            <button
              onClick={handleNext}
              className="rounded-lg bg-purple-600 px-6 py-3 font-bold text-white transition-colors hover:bg-purple-700"
            >
              {isLastQuestion ? 'See results' : 'Next question'}
            </button>
          )}
        </div>
      </main>
    </div>
  )
}
