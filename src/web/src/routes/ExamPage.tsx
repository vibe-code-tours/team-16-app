import { useState, useEffect, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth.tsx'
import { supabase } from '../lib/supabase'
import type { Question } from '../types/Quiz'

const EXAM_DURATION_MINUTES = 60
const TOTAL_QUESTIONS = 60
const INITIAL_HEARTS = 3

type Difficulty = 'all' | 'easy' | 'medium' | 'hard'

interface ExamQuestion {
  question: Question
  selectedAnswer?: string
  isCorrect?: boolean
}

export function ExamPage() {
  const navigate = useNavigate()
  const { user } = useAuth()
  
  const [questions, setQuestions] = useState<ExamQuestion[]>([])
  const [currentIndex, setCurrentIndex] = useState(0)
  const [hearts, setHearts] = useState(INITIAL_HEARTS)
  const [timeLeft, setTimeLeft] = useState(EXAM_DURATION_MINUTES * 60)
  const [loading, setLoading] = useState(true)
  const [finished, setFinished] = useState(false)
  const [submitted, setSubmitted] = useState(false)
  const [difficulty, setDifficulty] = useState<Difficulty>('all')
  const [started, setStarted] = useState(false)

  // Fetch 60 random Subject-A questions
  useEffect(() => {
    async function fetchExamQuestions() {
      setLoading(true)
      
      let query = supabase
        .from('questions')
        .select('*')
        .eq('subject', 'A')
        .order('random()')
        .limit(TOTAL_QUESTIONS)

      if (difficulty !== 'all') {
        query = query.eq('difficulty', difficulty)
      }

      const { data, error } = await query

      if (error) {
        console.error('Error fetching exam questions:', error.message)
        setLoading(false)
        return
      }

      setQuestions((data || []).map(q => ({ question: q })))
      setLoading(false)
    }

    if (started) {
      fetchExamQuestions()
    }
  }, [difficulty, started])

  // Timer countdown
  useEffect(() => {
    if (finished || loading || questions.length === 0) return

    const timer = setInterval(() => {
      setTimeLeft(prev => {
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

  // Auto-finish when hearts run out
  useEffect(() => {
    if (hearts <= 0 && !finished) {
      setFinished(true)
    }
  }, [hearts, finished])

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60)
    const secs = seconds % 60
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
  }

  const handleAnswer = useCallback((answer: string) => {
    if (submitted || finished) return

    const current = questions[currentIndex]
    const isCorrect = current.question.correct_answer === answer

    setQuestions(prev => prev.map((q, i) => 
      i === currentIndex ? { ...q, selectedAnswer: answer, isCorrect } : q
    ))

    setSubmitted(true)

    if (!isCorrect) {
      setHearts(prev => prev - 1)
    }
  }, [currentIndex, questions, submitted, finished])

  const handleNext = useCallback(() => {
    if (currentIndex < questions.length - 1) {
      setCurrentIndex(prev => prev + 1)
      setSubmitted(false)
    } else {
      setFinished(true)
    }
  }, [currentIndex, questions.length])

  const handleFinish = useCallback(async () => {
    const correctCount = questions.filter(q => q.isCorrect).length
    const xpEarned = correctCount * 10

    if (user) {
      await supabase
        .from('user_profiles')
        .update({ total_xp: (user.total_xp || 0) + xpEarned })
        .eq('id', user.id)
    }

    setFinished(true)
  }, [questions, user])

  // Start screen with difficulty selector
  if (!started) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center px-4">
        <div className="max-w-md w-full bg-white rounded-2xl shadow-sm border border-gray-200 p-8">
          <div className="text-center mb-6">
            <div className="text-5xl mb-4">📝</div>
            <h1 className="text-2xl font-bold text-gray-900 mb-2">Exam Simulation</h1>
            <p className="text-gray-500">60 questions • 60 minutes • 3 hearts</p>
          </div>

          <div className="mb-6">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Select Difficulty
            </label>
            <div className="grid grid-cols-2 gap-2">
              {(['all', 'easy', 'medium', 'hard'] as Difficulty[]).map((d) => (
                <button
                  key={d}
                  onClick={() => setDifficulty(d)}
                  className={`px-4 py-2 rounded-lg border-2 transition-all ${
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
      <div className="flex justify-center items-center min-h-screen bg-gray-50">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-purple-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Loading exam questions...</p>
        </div>
      </div>
    )
  }

  if (questions.length === 0) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50">
        <div className="text-center">
          <p className="text-gray-600 mb-4">No exam questions available.</p>
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
    const correctCount = questions.filter(q => q.isCorrect).length
    const score = Math.round((correctCount / questions.length) * 100)
    const xpEarned = correctCount * 10
    const passed = score >= 60

    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center px-4">
        <div className="max-w-md w-full bg-white rounded-2xl shadow-sm border border-gray-200 p-8 text-center">
          <div className="mb-4 flex justify-center">
            <div className={`h-20 w-20 rounded-full flex items-center justify-center text-3xl ${
              passed ? 'bg-green-100 text-green-600' : 'bg-red-100 text-red-600'
            }`}>
              {passed ? '🎉' : '📚'}
            </div>
          </div>
          
          <h2 className="text-2xl font-bold text-gray-900 mb-2">
            {passed ? 'Congratulations!' : 'Keep Practicing!'}
          </h2>
          
          <p className="text-gray-500 mb-6">
            {passed ? 'You passed the exam simulation!' : 'You need 60% to pass. Try again!'}
          </p>

          <div className="grid grid-cols-2 gap-4 mb-6">
            <div className="bg-purple-50 rounded-xl p-4">
              <p className="text-3xl font-bold text-purple-700">{score}%</p>
              <p className="text-sm text-purple-600">Score</p>
            </div>
            <div className="bg-blue-50 rounded-xl p-4">
              <p className="text-3xl font-bold text-blue-700">+{xpEarned}</p>
              <p className="text-sm text-blue-600">XP Earned</p>
            </div>
          </div>

          <div className="text-sm text-gray-500 mb-6">
            {correctCount} / {questions.length} correct • Hearts remaining: {hearts}
          </div>

          <div className="space-y-3">
            <button 
              onClick={() => {
                setQuestions([])
                setCurrentIndex(0)
                setHearts(INITIAL_HEARTS)
                setTimeLeft(EXAM_DURATION_MINUTES * 60)
                setFinished(false)
                setSubmitted(false)
                setLoading(true)
                // Re-fetch questions
                supabase
                  .from('questions')
                  .select('*')
                  .eq('subject', 'A')
                  .order('random()')
                  .limit(TOTAL_QUESTIONS)
                  .then(({ data }) => {
                    setQuestions((data || []).map(q => ({ question: q })))
                    setLoading(false)
                  })
              }}
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
  const timeWarning = timeLeft < 300 // Less than 5 minutes

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="sticky top-0 z-10 border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-3">
          <button 
            onClick={() => {
              if (confirm('Are you sure you want to quit the exam? Your progress will be lost.')) {
                navigate('/map')
              }
            }}
            className="text-red-600 hover:text-red-700 font-medium text-sm"
          >
            Quit Exam
          </button>
          
          {/* Timer */}
          <div className={`flex items-center gap-2 font-mono text-lg font-bold ${
            timeWarning ? 'text-red-600' : 'text-gray-900'
          }`}>
            <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clipRule="evenodd" />
            </svg>
            {formatTime(timeLeft)}
          </div>

          {/* Hearts */}
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
        {/* Progress */}
        <div className="mb-6">
          <div className="flex justify-between text-sm text-gray-500 mb-2">
            <span>Question {currentIndex + 1} of {questions.length}</span>
            <span>{Math.round(((currentIndex + 1) / questions.length) * 100)}%</span>
          </div>
          <div className="h-2 w-full bg-gray-200 rounded-full overflow-hidden">
            <div 
              className="h-full bg-purple-600 transition-all duration-300" 
              style={{ width: `${((currentIndex + 1) / questions.length) * 100}%` }}
            />
          </div>
        </div>

        {/* Question */}
        <div className="bg-white rounded-2xl border border-gray-200 p-6 mb-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">
            {current.question.question_text}
          </h2>
          
          <div className="space-y-3">
            {current.question.choices && current.question.choices.map((choice) => {
              const isSelected = current.selectedAnswer === choice.label
              const showFeedback = submitted
              const isCorrect = choice.label === current.question.correct_answer

              let bgColor = 'bg-white'
              let borderColor = 'border-gray-200'
              let textColor = 'text-gray-700'

              if (showFeedback) {
                if (isCorrect) {
                  bgColor = 'bg-green-50'
                  borderColor = 'border-green-500'
                  textColor = 'text-green-700'
                } else if (isSelected && !isCorrect) {
                  bgColor = 'bg-red-50'
                  borderColor = 'border-red-500'
                  textColor = 'text-red-700'
                }
              } else if (isSelected) {
                borderColor = 'border-purple-500'
                bgColor = 'bg-purple-50'
              }

              return (
                <button
                  key={choice.label}
                  onClick={() => handleAnswer(choice.label)}
                  disabled={submitted}
                  className={`w-full text-left p-4 rounded-xl border-2 transition-all ${bgColor} ${borderColor} ${textColor} ${
                    !submitted && !isSelected ? 'hover:border-gray-300' : ''
                  }`}
                >
                  <span className="font-medium mr-2">{choice.label}.</span>
                  {choice.text}
                </button>
              )
            })}
          </div>
        </div>

        {/* Feedback */}
        {submitted && (
          <div className={`mb-6 p-4 rounded-xl ${
            current.isCorrect ? 'bg-green-50 border border-green-200' : 'bg-red-50 border border-red-200'
          }`}>
            <p className={`font-medium ${current.isCorrect ? 'text-green-700' : 'text-red-700'}`}>
              {current.isCorrect ? '✓ Correct!' : '✗ Incorrect'}
            </p>
            {!current.isCorrect && (
              <p className="text-sm text-red-600 mt-1">
                Correct answer: {current.question.correct_answer}
              </p>
            )}
          </div>
        )}

        {/* Actions */}
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
              onClick={handleFinish}
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
