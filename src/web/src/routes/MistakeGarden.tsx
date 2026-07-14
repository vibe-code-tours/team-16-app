import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth.tsx'
import { api } from '../lib/api'

interface Mistake {
  id: string
  createdAt: string
  questionId: string
  questionText: string
  userAnswer: string
  correctAnswer: string
  explanation: string | null
  source: string
  reviewed: boolean
}

export function MistakeGarden() {
  const { user } = useAuth()
  const navigate = useNavigate()
  const [mistakes, setMistakes] = useState<Mistake[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchMistakes() {
      setLoading(true)

      try {
        const data = await api.get<Mistake[]>('/api/v1/me/mistakes')
        setMistakes(data || [])
      } catch (error) {
        console.error('Error fetching mistakes:', error)
      }

      setLoading(false)
    }

    if (user) {
      fetchMistakes()
    }
  }, [user])

  const markAsReviewed = async (mistakeId: string) => {
    try {
      await api.put(`/api/v1/me/mistakes/${mistakeId}/review`)
      setMistakes(prev => prev.filter(m => m.id !== mistakeId))
    } catch (error) {
      console.error('Error marking mistake as reviewed:', error)
    }
  }

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
            Back to Map
          </button>
          <h1 className="text-xl font-bold text-gray-900">Mistake Garden</h1>
        </div>
      </header>

      <main className="mx-auto max-w-4xl px-4 py-8">
        <div className="mb-8 text-center">
          <h2 className="text-3xl font-bold text-gray-900 mb-2">Your Mistake Garden</h2>
          <p className="text-gray-500">
            Every mistake is a seed for growth. Review your wrong answers to master the material.
          </p>
        </div>

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
            {mistakes.map((mistake) => (
              <div key={mistake.id} className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
                <div className="flex items-start justify-between mb-4">
                  <div className="text-sm text-gray-400">
                    {new Date(mistake.createdAt).toLocaleDateString()}
                  </div>
                  <button
                    onClick={() => markAsReviewed(mistake.id)}
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
                    <p className="text-gray-700">{mistake.userAnswer}</p>
                  </div>
                  <div className="p-4 rounded-xl bg-green-50 border border-green-100">
                    <p className="text-xs font-bold text-green-600 uppercase mb-1">Correct Answer</p>
                    <p className="text-gray-700">{mistake.correctAnswer}</p>
                  </div>
                </div>

                {mistake.explanation && (
                  <div className="mt-4 p-4 rounded-xl bg-blue-50 border border-blue-100">
                    <p className="text-xs font-bold text-blue-600 uppercase mb-1">Explanation</p>
                    <p className="text-gray-700">{mistake.explanation}</p>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </main>
    </div>
  )
}
