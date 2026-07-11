import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { supabase } from '../lib/supabase'
import type { Topic, Lesson, Quiz } from '../types'

export function TopicDetail() {
  const { topicId } = useParams<{ topicId: string }>()
  const navigate = useNavigate()
  const [topic, setTopic] = useState<Topic | null>(null)
  const [lessons, setLessons] = useState<Lesson[]>([])
  const [quiz, setQuiz] = useState<Quiz | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchTopicData() {
      if (!topicId) return

      setLoading(true)
      
      // Fetch Topic
      const { data: topicData, error: topicError } = await supabase
        .from('topics')
        .select('*')
        .eq('id', topicId)
        .single()

      if (topicError) {
        console.error('Error fetching topic:', topicError.message)
        setLoading(false)
        return
      }

      // Fetch Lessons
      const { data: lessonsData, error: lessonsError } = await supabase
        .from('lessons')
        .select('*')
        .eq('topic_id', topicId)
        .order('created_at', { ascending: true })

      if (lessonsError) {
        console.error('Error fetching lessons:', lessonsError.message)
      }

      // Fetch Quiz
      const { data: quizData, error: quizError } = await supabase
        .from('quizzes')
        .select('*')
        .eq('topic_id', topicId)
        .single()

      if (quizError) {
        console.error('Error fetching quiz:', quizError.message)
      }

      setTopic(topicData)
      setLessons(lessonsData || [])
      setQuiz(quizData || null)
      setLoading(false)
    }

    fetchTopicData()
  }, [topicId])

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    )
  }

  if (!topic) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50">
        <p className="text-gray-500">Topic not found.</p>
      </div>
    )
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
          <h1 className="text-xl font-bold text-gray-900">Topic Details</h1>
        </div>
      </header>

      <main className="mx-auto max-w-4xl px-4 py-8">
        <div className="mb-8">
          <h2 className="text-3xl font-bold text-gray-900 mb-2">{topic.title}</h2>
          <p className="text-gray-500">{topic.description || 'No description available.'}</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div className="md:col-span-2 space-y-4">
            <h3 className="text-xl font-semibold text-gray-900 mb-4">Lessons</h3>
            {lessons.length > 0 ? (
              lessons.map((lesson) => (
                <div 
                  key={lesson.id}
                  onClick={() => navigate(`/lesson/${lesson.id}`)}
                  className="group cursor-pointer rounded-xl border border-gray-200 bg-white p-4 transition-all hover:border-purple-300 hover:shadow-sm flex items-center justify-between"
                >
                  <div className="flex items-center gap-4">
                    <div className="flex h-10 w-10 items-center justify-center rounded-full bg-purple-100 text-purple-600 font-bold">
                      {lessons.indexOf(lesson) + 1}
                    </div>
                    <span className="font-medium text-gray-900 group-hover:text-purple-600">Lesson {lessons.indexOf(lesson) + 1}</span>
                  </div>
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 text-gray-400 group-hover:text-purple-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                  </svg>
                </div>
              ))
            ) : (
              <p className="text-gray-500 italic">No lessons available for this topic.</p>
            )}
          </div>

          <div className="space-y-4">
            <h3 className="text-xl font-semibold text-gray-900 mb-4">Quiz</h3>
            {quiz ? (
              <div className="rounded-xl border border-gray-200 bg-white p-6 text-center">
                <div className="mb-4 flex justify-center">
                  <div className="h-16 w-16 rounded-full bg-orange-100 text-orange-600 flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" className="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9.663 6.337h5.337m-8.663 6.337h12.664m-8.663 6.337h4.337" />
                    </svg>
                  </div>
                </div>
                <p className="text-sm text-gray-500 mb-6">Test your knowledge of {topic.title}!</p>
                <button 
                  onClick={() => navigate(`/quiz/${quiz.id}`)}
                  className="w-full rounded-lg bg-purple-600 px-4 py-3 font-bold text-white transition-colors hover:bg-purple-700"
                >
                  Start Quiz
                </button>
              </div>
            ) : (
              <p className="text-gray-500 italic">No quiz available for this topic.</p>
            )}
          </div>
        </div>
      </main>
    </div>
  )
}
