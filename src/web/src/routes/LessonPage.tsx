import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { supabase } from '../lib/supabase'
import type { Lesson, Topic } from '../types'

export function LessonPage() {
  const { lessonId } = useParams<{ lessonId: string }>()
  const navigate = useNavigate()
  const [lesson, setLesson] = useState<Lesson | null>(null)
  const [topic, setTopic] = useState<Topic | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchLessonData() {
      if (!lessonId) return

      setLoading(true)
      const { data: lessonData, error: lessonError } = await supabase
        .from('lessons')
        .select('*')
        .eq('id', lessonId)
        .single()

      if (lessonError) {
        console.error('Error fetching lesson:', lessonError.message)
        setLoading(false)
        return
      }

      const { data: topicData, error: topicError } = await supabase
        .from('topics')
        .select('*')
        .eq('id', lessonData.topic_id)
        .single()

      if (topicError) {
        console.error('Error fetching topic:', topicError.message)
      }

      setLesson(lessonData)
      setTopic(topicData || null)
      setLoading(false)
    }

    fetchLessonData()
  }, [lessonId])

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    )
  }

  if (!lesson) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50">
        <p className="text-gray-500">Lesson not found.</p>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-4">
          <button 
            onClick={() => navigate(`/topic/${topic?.id}`)}
            className="text-purple-600 hover:text-purple-800 flex items-center gap-2 font-medium"
          >
            <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L5.414 9H17a1 1 0 010 2H5.414l4.293 4.293a1 1 0 010 1.414z" clipRule="evenodd" />
            </svg>
            Back to Topic
          </button>
          <h1 className="text-xl font-bold text-gray-900">Lesson</h1>
        </div>
      </header>

      <main className="mx-auto max-w-3xl px-4 py-8">
        <div className="mb-8">
          <h2 className="text-3xl font-bold text-gray-900 mb-2">
            {topic?.title} — Lesson
          </h2>
          <p className="text-gray-500">Quick read before you quiz!</p>
        </div>

        <div className="rounded-2xl bg-white p-8 shadow-sm border border-gray-200 prose prose-purple max-w-none">
          <div className="text-lg leading-relaxed text-gray-700 whitespace-pre-wrap">
            {lesson.content}
          </div>
        </div>

        <div className="mt-8 flex justify-center">
          <button 
            onClick={() => navigate(`/topic/${topic?.id}`)}
            className="rounded-lg bg-purple-600 px-8 py-3 font-bold text-white transition-colors hover:bg-purple-700"
          >
            I've read it!
          </button>
        </div>
      </main>
    </div>
  )
}
