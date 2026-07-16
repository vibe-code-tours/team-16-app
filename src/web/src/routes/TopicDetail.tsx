import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { useLessons } from '../hooks/useLessons'
import { LessonContent } from '../components/features/LessonContent'

export function TopicDetail() {
  const { topicId } = useParams<{ topicId: string }>()
  const navigate = useNavigate()
  const { lessons, progress, loading, error, completeLesson } = useLessons(topicId)
  const [selectedLessonId, setSelectedLessonId] = useState<string | null>(null)

  const selectedLesson = lessons.find((l) => l.id === selectedLessonId)
  const selectedProgress = progress.find((p) => p.lesson_id === selectedLessonId)

  const getLessonStatus = (lessonId: string) => {
    const p = progress.find((pr) => pr.lesson_id === lessonId)
    return p?.status ?? 'locked'
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 dark:bg-gray-900 flex items-center justify-center">
        <div className="text-gray-500 dark:text-gray-400">Loading lessons...</div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="min-h-screen bg-gray-50 dark:bg-gray-900 flex items-center justify-center">
        <div className="text-red-500">Error: {error}</div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <main className="mx-auto max-w-3xl px-4 py-8">
        <button
          onClick={() => selectedLesson ? setSelectedLessonId(null) : navigate('/map')}
          className="mb-4 inline-flex items-center gap-1 text-sm text-purple-600 hover:text-purple-700 dark:text-purple-400 dark:hover:text-purple-300"
        >
          ← Back
        </button>

        {lessons.length === 0 ? (
          <div className="text-center py-12">
            <h2 className="text-xl font-bold text-gray-900 dark:text-gray-100 mb-2">No Lessons Yet</h2>
            <p className="text-gray-500 dark:text-gray-400">
              Lessons for this topic are coming soon. Check back later!
            </p>
          </div>
        ) : selectedLesson ? (
          <div>
            <LessonContent
              lesson={selectedLesson}
              onComplete={() => completeLesson(selectedLesson.id)}
              isCompleted={selectedProgress?.status === 'completed'}
            />
          </div>
        ) : (
          <div>
            <h2 className="text-2xl font-bold text-gray-900 dark:text-gray-100 mb-2">Lessons</h2>
            <p className="text-sm text-gray-500 dark:text-gray-400 mb-6">
              Complete each lesson to unlock the next one.
            </p>

            <div className="mb-6">
              <button
                onClick={() => topicId && navigate(`/quiz/${topicId}`)}
                className="w-full rounded-xl border-2 border-purple-600 bg-purple-600 p-4 text-left text-white transition hover:bg-purple-700"
              >
                <div className="flex items-center justify-between">
                  <div>
                    <h3 className="font-bold">Take the 5-question quiz</h3>
                    <p className="text-sm text-purple-100">
                      Test yourself and earn XP for every correct answer.
                    </p>
                  </div>
                  <span aria-hidden="true">→</span>
                </div>
              </button>
            </div>

            <div className="space-y-3">
              {lessons.map((lesson, index) => {
                const isCompleted = getLessonStatus(lesson.id) === 'completed'
                const previousCompleted =
                  index === 0 || getLessonStatus(lessons[index - 1].id) === 'completed'
                const isLocked = !isCompleted && !previousCompleted

                return (
                  <button
                    key={lesson.id}
                    onClick={() => !isLocked && setSelectedLessonId(lesson.id)}
                    disabled={isLocked}
                    className={`w-full text-left p-4 rounded-xl border transition ${
                      isLocked
                        ? 'border-gray-200 bg-gray-50 opacity-60 cursor-not-allowed dark:border-gray-700 dark:bg-gray-800'
                        : isCompleted
                        ? 'border-green-200 bg-green-50 hover:bg-green-100 dark:border-green-800 dark:bg-green-900/30 dark:hover:bg-green-900/50'
                        : 'border-gray-200 bg-white hover:border-purple-300 hover:shadow-sm dark:border-gray-700 dark:bg-gray-800 dark:hover:border-purple-500'
                    }`}
                  >
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-3">
                        <span
                          className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold ${
                            isCompleted
                              ? 'bg-green-500 text-white'
                              : isLocked
                              ? 'bg-gray-200 text-gray-400 dark:bg-gray-700 dark:text-gray-500'
                              : 'bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-400'
                          }`}
                        >
                          {isCompleted ? '✓' : index + 1}
                        </span>
                        <div>
                          <h3 className="font-medium text-gray-900 dark:text-gray-100">{lesson.title}</h3>
                          <p className="text-sm text-gray-500 dark:text-gray-400">
                            {lesson.estimated_minutes} min · {lesson.xp_reward} XP
                          </p>
                        </div>
                      </div>
                      {isLocked && (
                        <span className="text-gray-400 dark:text-gray-500 text-sm">🔒</span>
                      )}
                    </div>
                    {lesson.summary && (
                      <p className="mt-2 text-sm text-gray-600 dark:text-gray-400 ml-11">
                        {lesson.summary}
                      </p>
                    )}
                  </button>
                )
              })}
            </div>
          </div>
        )}
      </main>
    </div>
  )
}
