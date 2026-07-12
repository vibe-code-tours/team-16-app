import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth.tsx'
import { supabase } from '../lib/supabase'
import type { Topic } from '../types'

export function LearningMap() {
  const { user, signOut } = useAuth()
  const navigate = useNavigate()
  const [topics, setTopics] = useState<Topic[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchTopics() {
      setLoading(true)
      const { data, error } = await supabase
        .from('topics')
        .select('*')
        .order('created_at', { ascending: true })

      if (error) {
        console.error('Error fetching topics:', error.message)
      } else {
        setTopics(data || [])
      }
      setLoading(false)
    }

    fetchTopics()
  }, [])

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-4">
          <h1 className="text-xl font-bold text-purple-600">NerdQuiz</h1>
          <div className="flex items-center gap-4">
            <button 
              onClick={() => navigate('/mistakes')}
              className="rounded-md border border-gray-300 px-3 py-1.5 text-sm text-gray-700 hover:bg-gray-50 flex items-center gap-2"
            >
              <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4 text-orange-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5s3.332.477 4.5 1.253v13C17.832 18.477 16.246 18 14.5 18s-3.332.477-4.5 1.253" />
              </svg>
              Mistake Garden
            </button>
            <span className="text-sm text-gray-500">
              {user?.display_name || user?.id?.slice(0, 8)}
            </span>
            <button
              onClick={signOut}
              className="rounded-md border border-gray-300 px-3 py-1.5 text-sm text-gray-700 hover:bg-gray-50"
            >
              Sign out
            </button>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-4xl px-4 py-8">
        <h2 className="mb-4 text-2xl font-bold text-gray-900">Learning Map</h2>
        <p className="text-gray-500 mb-6">
          Master the ITPEC FE certification topic by topic.
        </p>

        {loading ? (
          <div className="flex justify-center py-12">
            <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
          </div>
        ) : (
          <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
            {topics.map((topic) => (
              <div
                key={topic.id}
                onClick={() => navigate(`/topic/${topic.id}`)}
                className="group cursor-pointer rounded-xl border border-gray-200 bg-white p-6 transition-all hover:border-purple-300 hover:shadow-sm"
              >
                <div className="flex items-center justify-between">
                  <div>
                    <h3 className="text-lg font-semibold text-gray-900 group-hover:text-purple-600">
                      {topic.title}
                    </h3>
                    <p className="text-sm text-gray-500 line-clamp-2">
                      {topic.description || 'No description available.'}
                    </p>
                  </div>
                  <div className="rounded-full bg-purple-100 p-2 text-purple-600 transition-colors group-hover:bg-purple-600 group-hover:text-white">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      className="h-5 w-5"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                      strokeWidth={2}
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        d="M9 5l7 7-7 7"
                      />
                    </svg>
                  </div>
                </div>
              </div>
            ))}
            {topics.length === 0 && (
              <div className="text-center py-12 text-gray-500">
                No topics found. Start by adding some to your database!
              </div>
            )}
          </div>
        )}

        <div className="mt-8 rounded-xl border border-gray-200 bg-white p-6">
          <h3 className="mb-2 font-semibold text-gray-900">Your Progress</h3>
          <div className="flex gap-6 text-sm text-gray-500">
            <div>
              <span className="block text-2xl font-bold text-purple-600">{user?.total_xp ?? 0}</span>
              XP earned
            </div>
            <div>
              <span className="block text-2xl font-bold text-orange-500">{user?.streak_count ?? 0}</span>
              Day streak
            </div>
          </div>
        </div>
      </main>
    </div>
  )
}
