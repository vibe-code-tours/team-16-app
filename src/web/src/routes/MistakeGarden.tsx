import { useState, useEffect, useMemo } from 'react'
import { useNavigate } from 'react-router-dom'
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

const CATEGORIES = ['All', 'Technology', 'Security', 'Management', 'Strategy', 'Business'] as const

export function MistakeGarden() {
  const navigate = useNavigate()
  const [mistakes, setMistakes] = useState<Mistake[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedCategory, setSelectedCategory] = useState<string>('All')

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

  const filteredMistakes = useMemo(() => {
    return mistakes.filter((mistake) => {
      // Search filter
      const matchesSearch = searchQuery === '' ||
        mistake.questionText?.toLowerCase().includes(searchQuery.toLowerCase()) ||
        mistake.explanation?.toLowerCase().includes(searchQuery.toLowerCase())

      // Category filter (placeholder - would need category data from API)
      const matchesCategory = selectedCategory === 'All' || true // TODO: Add category to Mistake type

      return matchesSearch && matchesCategory
    })
  }, [mistakes, searchQuery, selectedCategory])

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
        <h1 className="text-3xl font-bold text-gray-900 dark:text-gray-100 mb-2">Your Mistake Garden</h1>
        <p className="text-gray-500 dark:text-gray-400">
          Every mistake is a seed for growth. Review your wrong answers to master the material.
        </p>
      </div>

      {error && (
        <div role="alert" className="mb-6 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/30 dark:text-red-400">
          Couldn't load your mistakes: {error}
        </div>
      )}

      {loading ? (
        <div className="flex justify-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
        </div>
      ) : mistakes.length === 0 ? (
        <div className="text-center py-20 bg-white rounded-2xl border border-dashed border-gray-300 dark:bg-gray-800 dark:border-gray-700">
          <div className="text-5xl mb-4">🌱</div>
          <h3 className="text-xl font-semibold text-gray-900 dark:text-gray-100 mb-2">Your garden is empty!</h3>
          <p className="text-gray-500 dark:text-gray-400">You haven't made any mistakes yet. Keep studying!</p>
        </div>
      ) : (
        <>
          {/* Search and Filter */}
          <div className="mb-6 space-y-4">
            <div className="relative">
              <input
                type="text"
                placeholder="Search questions..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full rounded-xl border border-gray-200 bg-white px-4 py-3 pl-10 text-gray-900 placeholder-gray-500 focus:border-purple-500 focus:outline-none focus:ring-2 focus:ring-purple-500/20 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-100 dark:placeholder-gray-400"
              />
              <svg
                className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-gray-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>

            <div className="flex flex-wrap gap-2">
              {CATEGORIES.map((category) => (
                <button
                  key={category}
                  onClick={() => setSelectedCategory(category)}
                  className={`rounded-full px-4 py-2 text-sm font-medium transition ${
                    selectedCategory === category
                      ? 'bg-purple-600 text-white'
                      : 'bg-gray-100 text-gray-700 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700'
                  }`}
                >
                  {category}
                </button>
              ))}
            </div>

            {(searchQuery || selectedCategory !== 'All') && (
              <div className="flex items-center justify-between text-sm text-gray-500 dark:text-gray-400">
                <span>
                  Showing {filteredMistakes.length} of {mistakes.length} mistakes
                </span>
                <button
                  onClick={() => {
                    setSearchQuery('')
                    setSelectedCategory('All')
                  }}
                  className="text-purple-600 hover:text-purple-700 dark:text-purple-400 dark:hover:text-purple-300"
                >
                  Clear filters
                </button>
              </div>
            )}
          </div>

          {filteredMistakes.length === 0 ? (
            <div className="text-center py-12 bg-white rounded-2xl border border-dashed border-gray-300 dark:bg-gray-800 dark:border-gray-700">
              <div className="text-4xl mb-4">🔍</div>
              <h3 className="text-lg font-semibold text-gray-900 dark:text-gray-100 mb-2">No mistakes match your filters</h3>
              <p className="text-gray-500 dark:text-gray-400 mb-4">Try adjusting your search or category filter.</p>
              <button
                onClick={() => {
                  setSearchQuery('')
                  setSelectedCategory('All')
                }}
                className="rounded-lg bg-purple-600 px-4 py-2 text-white hover:bg-purple-700"
              >
                Clear filters
              </button>
            </div>
          ) : (
            <div className="grid grid-cols-1 gap-6">
              {filteredMistakes.map((mistake) => {
                return (
                  <div key={mistake.id} className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm dark:bg-gray-800 dark:border-gray-700">
                    <div className="flex items-start justify-between mb-4">
                      <div className="text-sm text-gray-400 dark:text-gray-500">
                        {new Date(mistake.lastMissedAt).toLocaleDateString()}
                      </div>
                      <button
                        onClick={() => handleMarkReviewed(mistake.id)}
                        className="text-xs font-medium text-green-600 hover:text-green-700 bg-green-50 px-2 py-1 rounded dark:text-green-400 dark:hover:text-green-300 dark:bg-green-900/30"
                      >
                        Mark as Reviewed
                      </button>
                    </div>

                    <div className="mb-4">
                      <p className="text-sm font-medium text-gray-500 dark:text-gray-400 mb-1">Question</p>
                      <p className="text-lg text-gray-900 dark:text-gray-100">{mistake.questionText}</p>
                    </div>

                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                      <div className="p-4 rounded-xl bg-red-50 border border-red-100 dark:bg-red-900/30 dark:border-red-800">
                        <p className="text-xs font-bold text-red-600 uppercase mb-1 dark:text-red-400">Your Answer</p>
                        <p className="text-gray-700 dark:text-gray-300">
                          {mistake.lastUserAnswer}.{' '}
                          {getChoiceText(mistake.choices, mistake.lastUserAnswer || '')}
                        </p>
                      </div>
                      <div className="p-4 rounded-xl bg-green-50 border border-green-100 dark:bg-green-900/30 dark:border-green-800">
                        <p className="text-xs font-bold text-green-600 uppercase mb-1 dark:text-green-400">Correct Answer</p>
                        <p className="text-gray-700 dark:text-gray-300">
                          {mistake.correctAnswer}.{' '}
                          {getChoiceText(mistake.choices, mistake.correctAnswer || '')}
                        </p>
                      </div>
                    </div>

                    {mistake.explanation && (
                      <div className="mt-4 p-3 rounded-lg bg-blue-50 border border-blue-100 dark:bg-blue-900/30 dark:border-blue-800">
                        <p className="text-xs font-bold text-blue-600 uppercase mb-1 dark:text-blue-400">Explanation</p>
                        <p className="text-sm text-blue-700 dark:text-blue-300">{mistake.explanation}</p>
                      </div>
                    )}
                  </div>
                )
              })}
            </div>
          )}
        </>
      )}
    </div>
  )
}
