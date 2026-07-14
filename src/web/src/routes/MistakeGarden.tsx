import { useState, useEffect } from 'react'
import { api } from '../lib/api'

interface Choice {
  label: string
  text: string
}

interface Mistake {
  id: string
  questionId: string
  questionText: string | null
  correctAnswer: string | null
  choices: Choice[]
  explanation: string | null
  lastUserAnswer: string | null
  lastMissedAt: string
}

export function MistakeGarden() {
  const [mistakes, setMistakes] = useState<Mistake[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    let cancelled = false

    async function fetchMistakes() {
      setLoading(true)
      setError(null)

      try {
        const data = await api.get<Mistake[]>('/api/v1/me/mistakes')
        if (!cancelled) setMistakes(data)
      } catch (requestError) {
        if (!cancelled) {
          setError(requestError instanceof Error ? requestError.message : 'Failed to load mistakes')
        }
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    fetchMistakes()

    return () => {
      cancelled = true
    }
  }, [])

  const getChoiceText = (choices: Choice[], label: string) => {
    const choice = choices.find((c) => c.label === label)
    return choice?.text || label
  }

  const handleMarkReviewed = async (mistakeId: string) => {
    setError(null)
    try {
      await api.put(`/api/v1/me/mistakes/${mistakeId}/review`)
      setMistakes((previous) => previous.filter((mistake) => mistake.id !== mistakeId))
    } catch (requestError) {
      setError(requestError instanceof Error ? requestError.message : 'Failed to review mistake')
    }
  }

  return (
    <div>
      <div className="mb-8 text-center">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">Your Mistake Garden</h1>
        <p className="text-gray-500">
          Every mistake is a seed for growth. Review your wrong answers to master the material.
        </p>
      </div>

      {error && (
        <div role="alert" className="mb-6 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">
          Couldn't load your mistakes: {error}
        </div>
      )}

      {loading ? (
        <div className="flex justify-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
        </div>
      ) : mistakes.length === 0 ? (
        <div className="text-center py-20 bg-white rounded-2xl border border-dashed border-gray-300">
          <div className="text-5xl mb-4">🌱</div>
          <h3 className="text-xl font-semibold text-gray-900 mb-2">Your garden is empty!</h3>
          <p className="text-gray-500">You haven't made any mistakes yet. Keep studying!</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 gap-6">
          {mistakes.map((mistake) => {
            return (
              <div key={mistake.id} className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
                <div className="flex items-start justify-between mb-4">
                  <div className="text-sm text-gray-400">
                    {new Date(mistake.lastMissedAt).toLocaleDateString()}
                  </div>
                  <button
                    onClick={() => handleMarkReviewed(mistake.id)}
                    className="text-xs font-medium text-green-600 hover:text-green-700 bg-green-50 px-2 py-1 rounded"
                  >
                    Mark as Reviewed
                  </button>
                </div>

                <div className="mb-4">
                  <p className="text-sm font-medium text-gray-500 mb-1">Question</p>
                  <p className="text-lg text-gray-900">{mistake.questionText}</p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="p-4 rounded-xl bg-red-50 border border-red-100">
                    <p className="text-xs font-bold text-red-600 uppercase mb-1">Your Answer</p>
                    <p className="text-gray-700">
                      {mistake.lastUserAnswer}.{' '}
                      {getChoiceText(mistake.choices, mistake.lastUserAnswer || '')}
                    </p>
                  </div>
                  <div className="p-4 rounded-xl bg-green-50 border border-green-100">
                    <p className="text-xs font-bold text-green-600 uppercase mb-1">Correct Answer</p>
                    <p className="text-gray-700">
                      {mistake.correctAnswer}.{' '}
                      {getChoiceText(mistake.choices, mistake.correctAnswer || '')}
                    </p>
                  </div>
                </div>

                {mistake.explanation && (
                  <div className="mt-4 p-3 rounded-lg bg-blue-50 border border-blue-100">
                    <p className="text-xs font-bold text-blue-600 uppercase mb-1">Explanation</p>
                    <p className="text-sm text-blue-700">{mistake.explanation}</p>
                  </div>
                )}
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}
