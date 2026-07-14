import { useState, useCallback, useEffect, useRef } from 'react'
import { api } from '../lib/api'
import type {
  ExamSummary,
  ExamSession,
  ExamQuestion,
  ExamAnswerResult,
  ExamResult,
} from '../types/Exam'

interface UseExamSimulationReturn {
  // Available exams
  availableExams: ExamSummary[]
  // Current session
  session: ExamSession | null
  currentQuestion: ExamQuestion | null
  currentIndex: number
  // Answers state: questionId -> { selected, submitted, result }
  answers: Record<string, { selected: string | null; submitted: boolean; result: ExamAnswerResult | null }>
  // Hearts
  heartsRemaining: number
  // Timer
  timeRemaining: number
  // Loading states
  isLoading: boolean
  isSubmitting: boolean
  error: string | null
  // Results
  result: ExamResult | null
  // Actions
  fetchAvailableExams: () => Promise<void>
  startExam: (examSession: string, subject: string) => Promise<void>
  selectAnswer: (questionId: string, label: string) => void
  submitAnswer: (questionId: string) => Promise<ExamAnswerResult | null>
  nextQuestion: () => void
  goToQuestion: (index: number) => void
  completeExam: () => Promise<ExamResult | null>
  reset: () => void
}

export function useExamSimulation(): UseExamSimulationReturn {
  const [availableExams, setAvailableExams] = useState<ExamSummary[]>([])
  const [session, setSession] = useState<ExamSession | null>(null)
  const [currentIndex, setCurrentIndex] = useState(0)
  const [answers, setAnswers] = useState<
    Record<string, { selected: string | null; submitted: boolean; result: ExamAnswerResult | null }>
  >({})
  const [heartsRemaining, setHeartsRemaining] = useState(5)
  const [timeRemaining, setTimeRemaining] = useState(0)
  const [isLoading, setIsLoading] = useState(false)
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [result, setResult] = useState<ExamResult | null>(null)

  const timerRef = useRef<ReturnType<typeof setInterval> | null>(null)

  const currentQuestion = session?.questions[currentIndex] || null

  // Timer effect
  useEffect(() => {
    if (!session || session.status !== 'in_progress') return

    const expiresAt = new Date(session.expires_at).getTime()
    const updateTimer = () => {
      const now = Date.now()
      const remaining = Math.max(0, Math.floor((expiresAt - now) / 1000))
      setTimeRemaining(remaining)
      if (remaining <= 0) {
        if (timerRef.current) clearInterval(timerRef.current)
      }
    }

    updateTimer()
    timerRef.current = setInterval(updateTimer, 1000)

    return () => {
      if (timerRef.current) clearInterval(timerRef.current)
    }
  }, [session])

  const fetchAvailableExams = useCallback(async () => {
    setIsLoading(true)
    setError(null)
    try {
      const exams = await api.get<ExamSummary[]>('/api/v1/exams/sessions', { skipAuth: true })
      setAvailableExams(exams)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load exams')
    } finally {
      setIsLoading(false)
    }
  }, [])

  const startExam = useCallback(async (examSession: string, subject: string) => {
    setIsLoading(true)
    setError(null)
    try {
      const newSession = await api.post<ExamSession>('/api/v1/exams/start', { examSession, subject })
      setSession(newSession)
      setCurrentIndex(0)
      setAnswers({})
      setHeartsRemaining(newSession.hearts_remaining)
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
    [answers]
  )

  const submitAnswer = useCallback(
    async (questionId: string): Promise<ExamAnswerResult | null> => {
      if (!session) return null
      const selected = answers[questionId]?.selected
      // Allow null answer for optional questions (skip)
      if (!selected && !isSubmitting) return null

      setIsSubmitting(true)
      setError(null)
      try {
        const response = await api.post<ExamAnswerResult>(
          `/api/v1/exams/${session.session_id}/answers`,
          { questionId, answer: selected }
        )

        setAnswers((prev) => ({
          ...prev,
          [questionId]: { selected, submitted: true, result: response },
        }))
        setHeartsRemaining(response.hearts_remaining)

        if (response.exam_complete) {
          // Exam ended due to hearts running out — fetch full result
          const examResult = await api.get<ExamResult>(
            `/api/v1/exams/${session.session_id}/result`
          )
          setResult(examResult)
        }

        return response
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to submit answer')
        return null
      } finally {
        setIsSubmitting(false)
      }
    },
    [session, answers, isSubmitting]
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

  const completeExam = useCallback(async (): Promise<ExamResult | null> => {
    if (!session) return null
    setIsLoading(true)
    setError(null)
    try {
      const examResult = await api.post<ExamResult>(`/api/v1/exams/${session.session_id}/complete`)
      setResult(examResult)
      return examResult
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to complete exam')
      return null
    } finally {
      setIsLoading(false)
    }
  }, [session])

  const reset = useCallback(() => {
    if (timerRef.current) clearInterval(timerRef.current)
    setSession(null)
    setCurrentIndex(0)
    setAnswers({})
    setHeartsRemaining(5)
    setTimeRemaining(0)
    setResult(null)
    setError(null)
  }, [])

  return {
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
  }
}
