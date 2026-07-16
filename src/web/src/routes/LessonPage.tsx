import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { api } from '../lib/api'

interface LessonDetail {
  id: string
  subtopic_id: string
  topic_id: string
  subtopic_name: string
  title: string
  content_blocks: unknown[]
  summary: string | null
}

export function LessonPage() {
  const { lessonId } = useParams<{ lessonId: string }>()
  const navigate = useNavigate()
  const [lesson, setLesson] = useState<LessonDetail | null>(null)
  const [loading, setLoading] = useState(true)
  const [completing, setCompleting] = useState(false)

  useEffect(() => {
    async function fetchLessonData() {
      if (!lessonId) return

      setLoading(true)
      try {
        const lessonData = await api.get<LessonDetail>(`/api/v1/lessons/${lessonId}`)
        setLesson(lessonData)
      } catch (e) {
        console.error('Error fetching lesson:', e)
        setLesson(null)
      } finally {
        setLoading(false)
      }
    }

    fetchLessonData()
  }, [lessonId])

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50 dark:bg-gray-900">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
      </div>
    )
  }

  if (!lesson) {
    return (
      <div className="flex justify-center items-center min-h-screen bg-gray-50 dark:bg-gray-900">
        <p className="text-gray-500 dark:text-gray-400">Lesson not found.</p>
      </div>
    )
  }

  const handleComplete = async () => {
    if (!lessonId) return
    setCompleting(true)
    try {
      await api.post(`/api/v1/lessons/${lessonId}/complete`)
    } catch (e) {
      console.error('Failed to mark lesson complete:', e)
    } finally {
      navigate(`/map/${lesson.topic_id}`)
    }
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <header className="border-b border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-4">
          <button
            onClick={() => navigate(`/map/${lesson.topic_id}`)}
            className="text-purple-600 hover:text-purple-800 flex items-center gap-2 font-medium"
          >
            <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L5.414 9H17a1 1 0 010 2H5.414l4.293 4.293a1 1 0 010 1.414z" clipRule="evenodd" />
            </svg>
            Back to Topic
          </button>
          <h1 className="text-xl font-bold text-gray-900 dark:text-gray-100">{lesson.title}</h1>
        </div>
      </header>

      <main className="mx-auto max-w-3xl px-4 py-8">
        <div className="mb-8">
          <h2 className="text-3xl font-bold text-gray-900 dark:text-gray-100 mb-2">
            {lesson.subtopic_name}
          </h2>
          {lesson.summary && (
            <p className="text-gray-500 dark:text-gray-400">{lesson.summary}</p>
          )}
        </div>

        <div className="rounded-2xl bg-white dark:bg-gray-800 p-8 shadow-sm border border-gray-200 dark:border-gray-700">
          {(lesson.content_blocks as Array<Record<string, unknown>>).map((block, i) => {
            switch (block.type) {
              case 'heading':
                return <h3 key={i} className="text-xl font-bold text-gray-900 dark:text-gray-100 mt-6 mb-3">{block.content as string}</h3>
              case 'text':
                return <p key={i} className="text-gray-700 dark:text-gray-300 mb-3 leading-relaxed">{block.content as string}</p>
              case 'list':
                return (
                  <ul key={i} className="list-disc list-inside space-y-1 mb-3 text-gray-700 dark:text-gray-300">
                    {(block.items as string[]).map((item, j) => (
                      <li key={j}>{item}</li>
                    ))}
                  </ul>
                )
              case 'tip':
                return (
                  <div key={i} className="p-4 rounded-lg bg-blue-50 dark:bg-blue-900/30 border border-blue-200 dark:border-blue-800 mb-3">
                    <p className="text-sm text-blue-700 dark:text-blue-400">{block.content as string}</p>
                  </div>
                )
              case 'warning':
                return (
                  <div key={i} className="p-4 rounded-lg bg-amber-50 dark:bg-amber-900/30 border border-amber-200 dark:border-amber-800 mb-3">
                    <p className="text-sm text-amber-700 dark:text-amber-400">{block.content as string}</p>
                  </div>
                )
              case 'example':
                return (
                  <div key={i} className="p-4 rounded-lg bg-green-50 dark:bg-green-900/30 border border-green-200 dark:border-green-800 mb-3">
                    <p className="text-xs font-bold text-green-600 dark:text-green-400 uppercase mb-1">Example</p>
                    <p className="text-sm text-green-700 dark:text-green-400">{block.content as string}</p>
                  </div>
                )
              default:
                return null
            }
          })}
        </div>

        <div className="mt-8 flex justify-center">
          <button
            onClick={handleComplete}
            disabled={completing}
            className="rounded-lg bg-purple-600 px-8 py-3 font-bold text-white transition-colors hover:bg-purple-700 disabled:opacity-50"
          >
            {completing ? 'Saving...' : "I've read it!"}
          </button>
        </div>
      </main>
    </div>
  )
}
