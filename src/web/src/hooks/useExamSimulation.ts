import { useState, useCallback, useEffect, useRef } from 'react'
import { api } from '../lib/api'
import type {
  ExamSession,
  ExamQuestion,
  ExamAnswerResult,
  ExamResult,
} from '../types/Exam'

interface StartExamApiResponse {
  sessionId: string
  questions: ExamQuestion[]
  timeLimitMinutes: number
  expiresAt: string
}

interface SubmitAnswerApiResponse {
  answerId: string
  questionId: string
  userAnswer: string
  isCorrect: boolean
  correctAnswer: string
  explanation: string | null
}

interface FinishExamApiResponse {
  sessionId: string
  totalQuestions: number
  correctAnswers: number
  scorePercentage: number
  status: string
  xpEarned: number
}

interface UseExamSimulationReturn {
  session: ExamSession | null
  currentQuestion: ExamQuestion | null
  currentIndex: number
  answers: Record<string, { selected: string | null; submitted: boolean; result: ExamAnswerResult | null }>
  timeRemaining: number
  isLoading: boolean
  isSubmitting: boolean
  error: string | null
  result: ExamResult | null
  startExam: (questionCount: number, difficulty: string | null) => Promise<void>
  selectAnswer: (questionId: string, label: string) => void
  submitAnswer: (questionId: string) => Promise<ExamAnswerResult | null>
  nextQuestion: () => void
  goToQuestion: (index: number) => void
  finishExam: () => Promise<ExamResult | null>
  reset: () => void
}

export function useExamSimulation(): UseExamSimulationReturn {
  const [session, setSession] = useState<ExamSession | null>(null)
  const [currentIndex, setCurrentIndex] = useState(0)
  const [answers, setAnswers] = useState<
    Record<string, { selected: string | null; submitted: boolean; result: ExamAnswerResult | null }>
  >({})
  const [timeRemaining, setTimeRemaining] = useState(0)
  const [isLoading, setIsLoading] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [result, setResult] = useState<ExamResult | null>(null)

  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null)
  const sessionRef = useRef<ExamSession | null>(null)
  const finishedRef = useRef(false)

  const currentQuestion = session?.questions[currentIndex] ?? null

  // Keep sessionRef in sync
  useEffect(() => {
    sessionRef.current = session
  }, [session])

  // Timer effect — counts down every second, auto-finishes when expired
  useEffect(() => {
    if (!session || session.status !== 'in_progress') return

    const expiresAt = new Date(session.expiresAt).getTime()
    const updateTimer = () => {
      const now = Date.now()
      const remaining = Math.max(0, Math.floor((expiresAt - now) / 1000))
      setTimeRemaining(remaining)
      if (remaining <= 0 && !finishedRef.current) {
        if (timerRef.current) clearInterval(timerRef.current)
        // Auto-finish when timer expires
        const currentSession = sessionRef.current
        if (currentSession) {
          finishExam(currentSession).catch(() => {})
        }
      }
    }

    updateTimer()
    timerRef.current = setInterval(updateTimer, 1000)

    return () => {
      if (timerRef.current) clearInterval(timerRef.current)
    }
  }, [session]) // eslint-disable-line react-hooks/exhaustive-deps

  const startExam = useCallback(async (questionCount: number, difficulty: string | null) => {
    setIsLoading(true)
    setError(null)
    finishedRef.current = false
    try {
      const data = await api.post<StartExamApiResponse>('/api/v1/exams/start', {
        questionCount,
        difficulty: difficulty === 'all' ? null : difficulty,
      })
      const newSession: ExamSession = {
        sessionId: data.sessionId,
        questions: data.questions,
        totalQuestions: data.questions.length,
        timeLimitMinutes: data.timeLimitMinutes,
        expiresAt: data.expiresAt,
        status: 'in_progress',
      }
      setSession(newSession)
      setCurrentIndex(0)
      setAnswers({})
      setResult(null)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to start exam')
    } finally {
      setIsLoading(false)
    }
  }, [])

  const selectAnswer = useCallback(
    (questionId: string, label: string) => {
      if (answers[questionId]?.submitted) return
      setAnswers((prev) => ({
        ...prev,
        [questionId]: { selected: label, submitted: false, result: null },
      }))
    },
    [answers],
  )

  const submitAnswer = useCallback(
    async (questionId: string): Promise<ExamAnswerResult | null> => {
      if (!session || isSubmitting) return null
      const selected = answers[questionId]?.selected
      if (!selected) return null

      setIsSubmitting(true)
      setError(null)
      try {
        const response = await api.post<SubmitAnswerApiResponse>(
          `/api/v1/exams/${session.sessionId}/answers`,
          { questionId, answer: selected, sequenceNumber: currentIndex + 1, responseTimeMs: 0 },
        )

        const answerResult: ExamAnswerResult = {
          questionId: response.questionId,
          userAnswer: response.userAnswer,
          isCorrect: response.isCorrect,
          correctAnswer: response.correctAnswer,
          explanation: response.explanation,
        }

        setAnswers((prev) => ({
          ...prev,
          [questionId]: { selected, submitted: true, result: answerResult },
        }))

        return answerResult
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to submit answer')
        return null
      } finally {
        setIsSubmitting(false)
      }
    },
    [session, answers, isSubmitting, currentIndex],
  )

  const nextQuestion = useCallback(() => {
    if (!session) return
    const nextIndex = currentIndex + 1
    if (nextIndex < session.questions.length) {
      setCurrentIndex(nextIndex)
    }
  }, [session, currentIndex])

  const goToQuestion = useCallback((index: number) => {
    setCurrentIndex(index)
  }, [])

  const finishExam = useCallback(async (overrideSession?: ExamSession): Promise<ExamResult | null> => {
    const currentSession = overrideSession ?? sessionRef.current
    if (!currentSession) return null
    if (finishedRef.current) return null
    finishedRef.current = true

    setIsLoading(true)
    setError(null)
    try {
      if (timerRef.current) clearInterval(timerRef.current)

      // Determine status based on time remaining
      const expiresAt = new Date(currentSession.expiresAt).getTime()
      const status = Date.now() >= expiresAt ? 'expired' : 'completed'

      // Call finish endpoint
      const finishData = await api.post<FinishExamApiResponse>(
        `/api/v1/exams/${currentSession.sessionId}/finish`,
        { status },
      )

      // Fetch full result with answer details
      const resultData = await api.get<ExamResult>(
        `/api/v1/exams/${currentSession.sessionId}/result`,
      )

      // Build ExamResult from finish + result data
      const examResult: ExamResult = {
        sessionId: resultData.sessionId,
        totalQuestions: resultData.totalQuestions,
        correctAnswers: resultData.correctAnswers,
        scorePercentage: resultData.scorePercentage,
        xpEarned: resultData.xpEarned,
        passed: resultData.passed,
        status: resultData.status,
        answers: resultData.answers.map((a) => ({
          questionId: a.questionId,
          questionNumber: currentSession.questions.find((q) => q.id === a.questionId)?.questionNumber ?? 0,
          questionText: a.questionText,
          userAnswer: a.userAnswer,
          correctAnswer: a.correctAnswer,
          isCorrect: a.isCorrect,
          explanation: a.explanation,
        })),
      }

      setResult(examResult)
      return examResult
    } catch (err) {
      finishedRef.current = false
      setError(err instanceof Error ? err.message : 'Failed to finish exam')
      return null
    } finally {
      setIsLoading(false)
    }
  }, [])

  const reset = useCallback(() => {
    if (timerRef.current) clearInterval(timerRef.current)
    finishedRef.current = false
    setSession(null)
    setCurrentIndex(0)
    setAnswers({})
    setTimeRemaining(0)
    setResult(null)
    setError(null)
  }, [])

  return {
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
  }
}
