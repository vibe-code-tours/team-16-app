import { useCallback, useEffect, useRef, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth.tsx'
import { supabase } from '../lib/supabase'
import type { QuizQuestion } from '../types'

const EXAM_DURATION_MINUTES = 60
const TOTAL_QUESTIONS = 60
const INITIAL_HEARTS = 3
const XP_PER_CORRECT = 10

type Difficulty = 'all' | 'easy' | 'medium' | 'hard'

interface ExamQuestion {
  question: QuizQuestion
  selectedAnswer?: string
  isCorrect?: boolean
}

export function ExamPage() {
  const navigate = useNavigate()
  const { user, refreshUser } = useAuth()

  const [questions, setQuestions] = useState<ExamQuestion[]>([])
  const [currentIndex, setCurrentIndex] = useState(0)
  const [hearts, setHearts] = useState(INITIAL_HEARTS)
  const [timeLeft, setTimeLeft] = useState(EXAM_DURATION_MINUTES * 60)
  const [loading, setLoading] = useState(false)
  const [loadError, setLoadError] = useState<string | null>(null)
  const [finished, setFinished] = useState(false)
  const [submitted, setSubmitted] = useState(false)
  const [difficulty, setDifficulty] = useState<Difficulty>('all')
  const [started, setStarted] = useState(false)
  const [awardedXp, setAwardedXp] = useState<number | null>(null)

  const finishedOnceRef = useRef(false)
  const sessionIdRef = useRef<string | null>(null)

  const loadQuestions = useCallback(async () => {
    setLoading(true)
    setLoadError(null)
    const { data, error } = await supabase.rpc('get_exam_questions', {
      question_count: TOTAL_QUESTIONS,
      difficulty_filter: difficulty === 'all' ? null : difficulty,
    })
    if (error) {
      setLoadError(error.message)
      setLoading(false)
      return
    }
    setQuestions(((data ?? []) as QuizQuestion[]).map((q) => ({ question: q })))
    setLoading(false)
  }, [difficulty])

  useEffect(() => {
    if (started) loadQuestions()
  }, [started, loadQuestions])

  // Create the exam_sessions row once questions have loaded.
  useEffect(() => {
    if (!user || !started || loading || questions.length === 0 || sessionIdRef.current) return

    const totalQuestions = questions.length
    const startedAt = new Date()
    const expiresAt = new Date(startedAt.getTime() + EXAM_DURATION_MINUTES * 60 * 1000)

    ;(async () => {
      const { data, error } = await supabase
        .from('exam_sessions')
        .insert({
          user_id: user.id,
          exam_id: null,
          total_questions: totalQuestions,
          initial_hearts: INITIAL_HEARTS,
          hearts_remaining: INITIAL_HEARTS,
          time_limit_minutes: EXAM_DURATION_MINUTES,
          started_at: startedAt.toISOString(),
          expires_at: expiresAt.toISOString(),
          status: 'in_progress',
        })
        .select('id')
        .single()

      if (error) {
        console.error('Failed to create exam session:', error.message)
        return
      }
      sessionIdRef.current = data.id
    })()
  }, [user, started, loading, questions.length])

  useEffect(() => {
    if (finished || loading || questions.length === 0) return

    const timer = setInterval(() => {
      setTimeLeft((prev) => {
        if (prev <= 1) {
          clearInterval(timer)
          setFinished(true)
          return 0
        }
        return prev - 1
      })
    }, 1000)

    return () => clearInterval(timer)
  }, [finished, loading, questions.length])

  useEffect(() => {
    if (hearts <= 0 && !finished) setFinished(true)
  }, [hearts, finished])

  // Persist final results, award XP, refresh — runs exactly once when finished.
  useEffect(() => {
    if (!finished || finishedOnceRef.current) return
    finishedOnceRef.current = true

    const correctCount = questions.filter((q) => q.isCorrect).length
    const xp = correctCount * XP_PER_CORRECT
    setAwardedXp(xp)
    if (!user) return

    const total = questions.length
    const scorePct = total === 0 ? 0 : Number(((correctCount / total) * 100).toFixed(2))
    const status = timeLeft === 0 ? 'expired' : 'completed'

    ;(async () => {
      if (sessionIdRef.current) {
        await supabase
          .from('exam_sessions')
          .update({
            correct_answers: correctCount,
            score_percentage: scorePct,
            hearts_remaining: Math.max(0, hearts),
            completed_at: new Date().toISOString(),
            status,
          })
          .eq('id', sessionIdRef.current)
      }
      if (xp > 0) {
        await supabase.rpc('increment_user_xp', { delta: xp })
        await refreshUser()
      }
    })()
  }, [finished, questions, user, refreshUser, hearts, timeLeft])

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60)
    const secs = seconds % 60
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
  }

  const handleAnswer = useCallback(
    (answer: string) => {
      if (submitted || finished) return

      const current = questions[currentIndex]
      const isCorrect = current.question.correct_answer === answer
      const sequenceNumber = currentIndex + 1

      setQuestions((prev) =>
        prev.map((q, i) => (i === currentIndex ? { ...q, selectedAnswer: answer, isCorrect } : q))
      )
      setSubmitted(true)

      if (!isCorrect) setHearts((prev) => prev - 1)

      const sessionId = sessionIdRef.current
      if (!sessionId) return

      ;(async () => {
        await supabase.from('exam_answers').insert({
          exam_session_id: sessionId,
          question_id: current.question.id,
          sequence_number: sequenceNumber,
          user_answer: answer,
          is_correct: isCorrect,
        })
        if (!isCorrect) {
          await supabase.from('exam_heart_events').insert({
            exam_session_id: sessionId,
            question_id: current.question.id,
            delta: -1,
            reason: 'wrong_answer',
          })
        }
      })()
    },
    [currentIndex, questions, submitted, finished]
  )

  const handleNext = useCallback(() => {
    if (currentIndex < questions.length - 1) {
      setCurrentIndex((prev) => prev + 1)
      setSubmitted(false)
    } else {
      setFinished(true)
    }
  }, [currentIndex, questions.length])

  const restartExam = useCallback(() => {
    finishedOnceRef.current = false
    sessionIdRef.current = null
    setQuestions([])
    setCurrentIndex(0)
    setHearts(INITIAL_HEARTS)
    setTimeLeft(EXAM_DURATION_MINUTES * 60)
    setFinished(false)
    setSubmitted(false)
    setAwardedXp(null)
    loadQuestions()
  }, [loadQuestions])

  if (!started) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 px-4">
        <div className="w-full max-w-md rounded-2xl border border-gray-200 bg-white p-8 shadow-sm">
          <div className="mb-6 text-center">
            <div className="mb-4 text-5xl">📝</div>
            <h1 className="mb-2 text-2xl font-bold text-gray-900">Exam Simulation</h1>
            <p className="text-gray-500">60 questions • 60 minutes • 3 hearts</p>
          </div>

          <div className="mb-6">
            <label className="mb-2 block text-sm font-medium text-gray-700">Select Difficulty</label>
            <div className="grid grid-cols-2 gap-2">
              {(['all', 'easy', 'medium', 'hard'] as Difficulty[]).map((d) => (
                <button
                  key={d}
                  onClick={() => setDifficulty(d)}
                  className={`rounded-lg border-2 px-4 py-2 transition-all ${
                    difficulty === d
                      ? 'border-purple-500 bg-purple-50 text-purple-700'
                      : 'border-gray-200 text-gray-600 hover:border-gray-300'
                  }`}
                >
                  {d.charAt(0).toUpperCase() + d.slice(1)}
                </button>
              ))}
            </div>
          </div>

          <div className="space-y-3">
            <button
              onClick={() => setStarted(true)}
              className="w-full rounded-lg bg-purple-600 px-4 py-3 font-bold text-white transition-colors hover:bg-purple-700"
            >
              Start Exam
            </button>
            <button
              onClick={() => navigate('/map')}
              className="w-full rounded-lg border border-gray-300 px-4 py-3 font-medium text-gray-700 hover:bg-gray-50"
            >
              Back to Map
            </button>
          </div>
        </div>
      </div>
    )
  }

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50">
        <div className="text-center">
          <div className="mx-auto mb-4 h-12 w-12 animate-spin rounded-full border-b-2 border-purple-600" />
          <p className="text-gray-600">Loading exam questions...</p>
        </div>
      </div>
    )
  }

  if (loadError) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 px-4">
        <div className="max-w-md rounded-xl border border-red-200 bg-red-50 p-6 text-center text-sm text-red-700">
          Couldn't load exam: {loadError}
        </div>
      </div>
    )
  }

  if (questions.length === 0 && !finished) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50">
        <div className="text-center">
          <p className="mb-4 text-gray-600">No exam questions available.</p>
          <button
            onClick={() => navigate('/map')}
            className="rounded-lg bg-purple-600 px-6 py-2 text-white hover:bg-purple-700"
          >
            Back to Map
          </button>
        </div>
      </div>
    )
  }

  if (finished) {
    const correctCount = questions.filter((q) => q.isCorrect).length
    const answered = questions.filter((q) => q.selectedAnswer).length
    const score = questions.length === 0 ? 0 : Math.round((correctCount / questions.length) * 100)
    const xpEarned = awardedXp ?? correctCount * XP_PER_CORRECT
    const passed = score >= 60

    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 px-4">
        <div className="w-full max-w-md rounded-2xl border border-gray-200 bg-white p-8 text-center shadow-sm">
          <div className="mb-4 flex justify-center">
            <div
              className={`flex h-20 w-20 items-center justify-center rounded-full text-3xl ${
                passed ? 'bg-green-100 text-green-600' : 'bg-red-100 text-red-600'
              }`}
            >
              {passed ? '🎉' : '📚'}
            </div>
          </div>

          <h2 className="mb-2 text-2xl font-bold text-gray-900">
            {passed ? 'Congratulations!' : 'Keep Practicing!'}
          </h2>
          <p className="mb-6 text-gray-500">
            {passed ? 'You passed the exam simulation!' : 'You need 60% to pass. Try again!'}
          </p>

          <div className="mb-6 grid grid-cols-2 gap-4">
            <div className="rounded-xl bg-purple-50 p-4">
              <p className="text-3xl font-bold text-purple-700">{score}%</p>
              <p className="text-sm text-purple-600">Score</p>
            </div>
            <div className="rounded-xl bg-blue-50 p-4">
              <p className="text-3xl font-bold text-blue-700">+{xpEarned}</p>
              <p className="text-sm text-blue-600">XP Earned</p>
            </div>
          </div>

          <div className="mb-6 text-sm text-gray-500">
            {correctCount} / {questions.length} correct • {answered} answered • Hearts remaining: {hearts}
          </div>

          <div className="space-y-3">
            <button
              onClick={restartExam}
              className="w-full rounded-lg bg-purple-600 px-4 py-3 font-bold text-white transition-colors hover:bg-purple-700"
            >
              Try Again
            </button>
            <button
              onClick={() => navigate('/map')}
              className="w-full rounded-lg border border-gray-300 px-4 py-3 font-medium text-gray-700 hover:bg-gray-50"
            >
              Back to Map
            </button>
          </div>
        </div>
      </div>
    )
  }

  const current = questions[currentIndex]
  const timeWarning = timeLeft < 300

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="sticky top-0 z-10 border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-3">
          <button
            onClick={async () => {
              if (!confirm('Are you sure you want to quit the exam? Your progress will be lost.')) return
              if (sessionIdRef.current) {
                await supabase
                  .from('exam_sessions')
                  .update({
                    hearts_remaining: Math.max(0, hearts),
                    completed_at: new Date().toISOString(),
                    status: 'abandoned',
                  })
                  .eq('id', sessionIdRef.current)
              }
              navigate('/map')
            }}
            className="text-sm font-medium text-red-600 hover:text-red-700"
          >
            Quit Exam
          </button>

          <div
            className={`flex items-center gap-2 font-mono text-lg font-bold ${
              timeWarning ? 'text-red-600' : 'text-gray-900'
            }`}
          >
            <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path
                fillRule="evenodd"
                d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z"
                clipRule="evenodd"
              />
            </svg>
            {formatTime(timeLeft)}
          </div>

          <div className="flex items-center gap-1">
            {Array.from({ length: INITIAL_HEARTS }).map((_, i) => (
              <span key={i} className={`text-xl ${i < hearts ? 'text-red-500' : 'text-gray-300'}`}>
                ❤️
              </span>
            ))}
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-2xl px-4 py-6">
        <div className="mb-6">
          <div className="mb-2 flex justify-between text-sm text-gray-500">
            <span>
              Question {currentIndex + 1} of {questions.length}
            </span>
            <span>{Math.round(((currentIndex + 1) / questions.length) * 100)}%</span>
          </div>
          <div className="h-2 w-full overflow-hidden rounded-full bg-gray-200">
            <div
              className="h-full bg-purple-600 transition-all duration-300"
              style={{ width: `${((currentIndex + 1) / questions.length) * 100}%` }}
            />
          </div>
        </div>

        <div className="mb-6 rounded-2xl border border-gray-200 bg-white p-6">
          <h2 className="mb-4 whitespace-pre-line text-lg font-semibold text-gray-900">
            {current.question.question_text}
          </h2>

          <div className="space-y-3">
            {current.question.choices?.map((choice) => {
              const isSelected = current.selectedAnswer === choice.label
              const isCorrectChoice = choice.label === current.question.correct_answer

              let styles = 'border-gray-200 bg-white text-gray-700'
              if (submitted && isCorrectChoice) styles = 'border-green-500 bg-green-50 text-green-700'
              else if (submitted && isSelected) styles = 'border-red-500 bg-red-50 text-red-700'
              else if (isSelected) styles = 'border-purple-500 bg-purple-50 text-purple-700'

              return (
                <button
                  key={choice.label}
                  onClick={() => handleAnswer(choice.label)}
                  disabled={submitted}
                  className={`w-full rounded-xl border-2 p-4 text-left transition-all ${styles}`}
                >
                  <span className="mr-2 font-medium">{choice.label}.</span>
                  {choice.text}
                </button>
              )
            })}
          </div>
        </div>

        {submitted ? (
          <div
            className={`mb-6 rounded-xl border p-4 ${
              current.isCorrect ? 'border-green-200 bg-green-50' : 'border-red-200 bg-red-50'
            }`}
          >
            <p className={`font-medium ${current.isCorrect ? 'text-green-700' : 'text-red-700'}`}>
              {current.isCorrect ? '✓ Correct!' : '✗ Incorrect'}
            </p>
            {!current.isCorrect ? (
              <p className="mt-1 text-sm text-red-600">
                Correct answer: {current.question.correct_answer}
              </p>
            ) : null}
          </div>
        ) : null}

        <div className="flex justify-end">
          {submitted ? (
            <button
              onClick={handleNext}
              className="rounded-lg bg-purple-600 px-6 py-3 font-bold text-white transition-colors hover:bg-purple-700"
            >
              {currentIndex < questions.length - 1 ? 'Next Question' : 'Finish Exam'}
            </button>
          ) : (
            <button
              onClick={() => setFinished(true)}
              className="rounded-lg border border-gray-300 px-6 py-3 font-medium text-gray-700 hover:bg-gray-50"
            >
              Submit Early
            </button>
          )}
        </div>
      </main>
    </div>
  )
}
