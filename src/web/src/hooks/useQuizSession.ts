import { useCallback, useEffect, useState } from 'react'
import { api } from '../lib/api'
import type { QuizQuestion } from '../types'

const QUIZ_LENGTH = 5
const API_QUIZ_START = '/api/v1/quizzes/start'

interface QuizSessionFromApi {
  id: string
  questions: {
    id: string
    subtopicId: string
    questionText: string
    images?: unknown[]
    choices: { label: string; text: string; image?: string }[]
    correctAnswer: string
    explanation: string | null
  }[]
  status: string
}

interface UseQuizSessionReturn {
  sessionId: string | null
  questions: QuizQuestion[]
  currentQuestion: QuizQuestion | undefined
  currentIndex: number
  selectedLabel: string | null
  isAnswered: boolean
  isCorrect: boolean
  isLastQuestion: boolean
  hasStarted: boolean
  isLoading: boolean
  error: string | null
  startQuiz: () => void
  selectAnswer: (label: string) => void
  checkAnswer: () => void
  goToNextQuestion: () => void
}

/** Runs one practice quiz for a subtopic: loading, answering and moving between questions. */
export function useQuizSession(subtopicId: string | undefined): UseQuizSessionReturn {
  const [questions, setQuestions] = useState<QuizQuestion[]>([])
  const [sessionId, setSessionId] = useState<string | null>(null)
  const [currentIndex, setCurrentIndex] = useState(0)
  const [selectedLabel, setSelectedLabel] = useState<string | null>(null)
  const [isAnswered, setIsAnswered] = useState(false)
  const [hasStarted, setHasStarted] = useState(false)
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const loadQuiz = useCallback(async () => {
    if (!subtopicId) return
    setIsLoading(true)
    setError(null)

    try {
      // The start response includes the questions to display.
      const session = await api.post<QuizSessionFromApi>(API_QUIZ_START, {
        subtopicId,
        questionCount: QUIZ_LENGTH,
      })
      setSessionId(session.id)
      setQuestions(
        session.questions.map((question) => ({
          id: question.id,
          subtopic_id: question.subtopicId,
          question_text: question.questionText,
          images: question.images,
          choices: question.choices,
          correct_answer: question.correctAnswer,
          explanation: question.explanation,
        }))
      )
    } catch (e) {
      setError(e instanceof Error ? e.message : 'Failed to load quiz')
    } finally {
      setIsLoading(false)
    }
  }, [subtopicId])

  useEffect(() => {
    if (hasStarted) {
      loadQuiz()
    }
  }, [hasStarted, loadQuiz])

  const currentQuestion = questions[currentIndex]

  const startQuiz = useCallback(() => setHasStarted(true), [])

  const selectAnswer = useCallback(
    (label: string) => {
      if (!isAnswered) setSelectedLabel(label)
    },
    [isAnswered]
  )

  const checkAnswer = useCallback(() => {
    if (!selectedLabel || !currentQuestion) return
    setIsAnswered(true)

    // The backend tracks mastery and daily activity from recorded answers.
    if (sessionId) {
      api
        .post(`/api/v1/quizzes/${sessionId}/answers`, {
          questionId: currentQuestion.id,
          answer: selectedLabel,
        })
        .catch((err) => console.error('Failed to record answer:', err))
    }
  }, [selectedLabel, currentQuestion, sessionId])

  const goToNextQuestion = useCallback(() => {
    setCurrentIndex((index) => index + 1)
    setSelectedLabel(null)
    setIsAnswered(false)
  }, [])

  return {
    sessionId,
    questions,
    currentQuestion,
    currentIndex,
    selectedLabel,
    isAnswered,
    isCorrect: isAnswered && selectedLabel === currentQuestion?.correct_answer,
    isLastQuestion: currentIndex === questions.length - 1,
    hasStarted,
    isLoading,
    error,
    startQuiz,
    selectAnswer,
    checkAnswer,
    goToNextQuestion,
  }
}
