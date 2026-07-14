import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth.tsx'
import { api } from '../lib/api'

interface QuizQuestion {
  id: string
  text: string
  choices: { label: string; text: string }[]
  correctAnswer: string
}

export function QuizPage() {
  const { quizId } = useParams<{ quizId: string }>()
  const navigate = useNavigate()
  const { user } = useAuth()

  const [questions, setQuestions] = useState<QuizQuestion[]>([])
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0)
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null)
  const [isAnswered, setIsAnswered] = useState(false)
  const [score, setScore] = useState(0)
  const [loading, setLoading] = useState(true)
  const [finished, setFinished] = useState(false)

  useEffect(() => {
    async function fetchQuiz() {
      if (!quizId) return
      setLoading(true)

      try {
        // Use backend API to start a quiz session
        const session = await api.post<{ id: string; questions: QuizQuestion[] }>(
          '/api/v1/quizzes/start',
          { questionCount: 10 }
        )
        setQuestions(session.questions || [])
      } catch (error) {
        console.error('Error starting quiz:', error)
      }

      setLoading(false)
    }

    fetchQuiz()
  }, [quizId])

  const handleOptionSelect = (label: string) => {
    if (isAnswered) return
    setSelectedAnswer(label)
  }

  const handleSubmitAnswer = async () => {
    if (!selectedAnswer) return

    const currentQuestion = questions[currentQuestionIndex]
    const isCorrect = selectedAnswer === currentQuestion.correctAnswer

    setIsAnswered(true)

    if (isCorrect) {
      setScore(prev => prev + 1)
    } else {
      // Record mistake via backend API
      if (user) {
        try {
          await api.post('/api/v1/me/mistakes', {
            questionId: currentQuestion.id,
            source: 'quiz',
            userAnswer: selectedAnswer,
          })
        } catch (error) {
          console.error('Error recording mistake:', error)
        }
      }
    }
  }

  const handleNext = async () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1)
      setSelectedAnswer(null)
      setIsAnswered(false)
    } else {
      await finishQuiz()
    }
  }

  const finishQuiz = async () => {
    setFinished(true)

    // XP is handled by the backend quiz session
    // Just refresh user profile to get updated XP
    if (user) {
      try {
        await api.get('/api/v1/me/profile')
      } catch (error) {
        console.error('Error refreshing profile:', error)
      }
    }
  }

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    )
  }

  if (finished) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center px-4">
        <div className="max-w-md w-full bg-white rounded-2xl shadow-sm border border-gray-200 p-8 text-center">
          <div className="mb-4 flex justify-center">
            <div className="h-20 w-20 rounded-full bg-purple-100 text-purple-600 flex items-center justify-center text-3xl">
              🎉
            </div>
          </div>
          <h2 className="text-2xl font-bold text-gray-900 mb-2">Quiz Complete!</h2>
          <p className="text-gray-500 mb-6">
            You scored <span className="font-bold text-purple-600">{score} / {questions.length}</span>
          </p>
          <div className="bg-purple-50 rounded-xl p-4 mb-8">
            <p className="text-sm text-purple-600 font-medium">XP Earned</p>
            <p className="text-3xl font-bold text-purple-700">+{score * 10} XP</p>
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

  if (questions.length === 0) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50">
        <p className="text-gray-500">No questions found for this quiz.</p>
      </div>
    )
  }

  const currentQ = questions[currentQuestionIndex]

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-4">
          <button
            onClick={() => navigate('/map')}
            className="text-purple-600 hover:text-purple-800 flex items-center gap-2 font-medium"
          >
            <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L5.414 9H17a1 1 0 010 2H5.414l4.293 4.293a1 1 0 010 1.414z" clipRule="evenodd" />
            </svg>
            Quit Quiz
          </button>
          <div className="text-sm font-medium text-gray-500">
            Question {currentQuestionIndex + 1} of {questions.length}
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-2xl px-4 py-8">
        <div className="mb-8">
          <div className="h-2 w-full bg-gray-200 rounded-full overflow-hidden">
            <div
              className="h-full bg-purple-600 transition-all duration-500"
              style={{ width: `${((currentQuestionIndex + 1) / questions.length) * 100}%` }}
            ></div>
          </div>
        </div>

        <div className="mb-8">
          <h2 className="text-xl font-bold text-gray-900 mb-6 leading-relaxed">
            {currentQ.text}
          </h2>

          <div className="space-y-3">
            {currentQ.choices.map((choice) => {
              const isCorrect = choice.label === currentQ.correctAnswer
              const isSelected = selectedAnswer === choice.label
              const showFeedback = isAnswered

              let bgColor = 'bg-white'
              let borderColor = 'border-gray-200'
              let textColor = 'text-gray-700'

              if (showFeedback) {
                if (isCorrect) {
                  bgColor = 'bg-green-100'
                  borderColor = 'border-green-500'
                  textColor = 'text-green-700'
                } else if (isSelected && !isCorrect) {
                  bgColor = 'bg-red-100'
                  borderColor = 'border-red-500'
                  textColor = 'text-red-700'
                }
              }

              return (
                <button
                  key={choice.label}
                  onClick={() => handleOptionSelect(choice.label)}
                  disabled={showFeedback}
                  className={`w-full text-left p-4 rounded-xl border-2 transition-all ${bgColor} ${borderColor} ${textColor} ${
                    isSelected ? 'border-purple-600 ring-2 ring-purple-100' : ''
                  }`}
                >
                  {choice.text}
                </button>
              )
            })}
          </div>
        </div>

        <div className="flex justify-end">
          {!isAnswered ? (
            <button
              onClick={handleSubmitAnswer}
              disabled={!selectedAnswer}
              className="rounded-lg bg-purple-600 px-6 py-3 font-bold text-white transition-colors hover:bg-purple-700 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Check Answer
            </button>
          ) : (
            <button
              onClick={handleNext}
              className="rounded-lg bg-purple-600 px-6 py-3 font-bold text-white transition-colors hover:bg-purple-700"
            >
              Next Question
            </button>
          )}
        </div>
      </main>
    </div>
  )
}
