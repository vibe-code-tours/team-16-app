import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { supabase } from '../lib/supabase'

interface Choice {
  label: string
  text: string
}

interface ItpecQuestion {
  id: string
  subtopic_id: string
  question_text: string
  choices: Choice[]
  correct_answer: string
  explanation: string | null
  difficulty: string | null
}

const QUIZ_SIZE = 5

export function QuizPage() {
  const { subtopicId } = useParams<{ subtopicId: string }>()
  const navigate = useNavigate()
  const [questions, setQuestions] = useState<ItpecQuestion[]>([])
  const [currentIdx, setCurrentIdx] = useState(0)
  const [selectedLabel, setSelectedLabel] = useState<string | null>(null)
  const [isAnswered, setIsAnswered] = useState(false)
  const [score, setScore] = useState(0)
  const [loading, setLoading] = useState(true)
  const [finished, setFinished] = useState(false)

  useEffect(() => {
    async function fetchQuestions() {
      if (!subtopicId) return
      setLoading(true)

      const { data, error } = await supabase
        .from('questions')
        .select('id, subtopic_id, question_text, choices, correct_answer, explanation, difficulty')
        .eq('subtopic_id', subtopicId)
        .eq('published', true)
        .order('random()')
        .limit(QUIZ_SIZE)

      if (error) {
        console.error('Error fetching questions:', error.message)
      } else {
        setQuestions(data || [])
      }
      setLoading(false)
    }

    fetchQuestions()
  }, [subtopicId])

  const handleSelect = (label: string) => {
    if (isAnswered) return
    setSelectedLabel(label)
  }

  const handleSubmit = () => {
    if (!selectedLabel) return
    const correct = questions[currentIdx].correct_answer
    if (selectedLabel === correct) {
      setScore((s) => s + 1)
    }
    setIsAnswered(true)
  }

  const handleNext = () => {
    if (currentIdx < questions.length - 1) {
      setCurrentIdx((i) => i + 1)
      setSelectedLabel(null)
      setIsAnswered(false)
    } else {
      setFinished(true)
    }
  }

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600" />
      </div>
    )
  }

  if (finished) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center px-4">
        <div className="max-w-md w-full bg-white rounded-2xl shadow-sm border border-gray-200 p-8 text-center">
          <div className="mb-4 flex justify-center">
            <div className="h-20 w-20 rounded-full bg-purple-100 text-purple-600 flex items-center justify-center text-3xl">
              {score === questions.length ? '🎉' : '📝'}
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
        <div className="text-center">
          <p className="text-gray-600 mb-4">No questions available for this topic yet.</p>
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

  const q = questions[currentIdx]

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
            Question {currentIdx + 1} of {questions.length}
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-2xl px-4 py-8">
        <div className="mb-8">
          <div className="h-2 w-full bg-gray-200 rounded-full overflow-hidden">
            <div
              className="h-full bg-purple-600 transition-all duration-500"
              style={{ width: `${((currentIdx + 1) / questions.length) * 100}%` }}
            />
          </div>
        </div>

        <div className="mb-8">
          <h2 className="text-xl font-bold text-gray-900 mb-6 leading-relaxed">
            {q.question_text}
          </h2>

          <div className="space-y-3">
            {q.choices.map((choice) => {
              const isCorrect = choice.label === q.correct_answer
              const isSelected = selectedLabel === choice.label
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
                  onClick={() => handleSelect(choice.label)}
                  disabled={showFeedback}
                  className={`w-full text-left p-4 rounded-xl border-2 transition-all ${bgColor} ${borderColor} ${textColor} ${
                    isSelected && !showFeedback ? 'border-purple-600 ring-2 ring-purple-100' : ''
                  }`}
                >
                  <span className="font-medium mr-2">{choice.label}.</span>
                  {choice.text}
                </button>
              )
            })}
          </div>
        </div>

        {isAnswered && q.explanation && (
          <div className="mb-6 p-4 rounded-xl bg-blue-50 border border-blue-200">
            <p className="text-sm font-medium text-blue-700 mb-1">Explanation</p>
            <p className="text-sm text-blue-600">{q.explanation}</p>
          </div>
        )}

        <div className="flex justify-end">
          {!isAnswered ? (
            <button
              onClick={handleSubmit}
              disabled={!selectedLabel}
              className="rounded-lg bg-purple-600 px-6 py-3 font-bold text-white transition-colors hover:bg-purple-700 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Check Answer
            </button>
          ) : (
            <button
              onClick={handleNext}
              className="rounded-lg bg-purple-600 px-6 py-3 font-bold text-white transition-colors hover:bg-purple-700"
            >
              {currentIdx < questions.length - 1 ? 'Next Question' : 'Finish Quiz'}
            </button>
          )}
        </div>
      </main>
    </div>
  )
}
