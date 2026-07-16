import { useMemo } from 'react'
import { Link } from 'react-router-dom'
import { Card } from '../components/ui/Card'
import { Badge } from '../components/ui/Badge'
import { useTopics } from '../hooks/useTopics'
import type { TopicCategory, TopicWithStatus } from '../types/topic'

const CATEGORY_ORDER: readonly TopicCategory[] = [
  'Technology',
  'Security',
  'Management',
  'Strategy',
  'Business',
]

const CATEGORY_BADGE_COLORS: Record<TopicCategory, string> = {
  Technology: 'bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-400',
  Security: 'bg-red-100 dark:bg-red-900/30 text-red-700 dark:text-red-400',
  Management: 'bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-400',
  Strategy: 'bg-emerald-100 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-400',
  Business: 'bg-amber-100 dark:bg-amber-900/30 text-amber-700 dark:text-amber-400',
}

export function QuizListingPage() {
  const { topics, loading, error } = useTopics()

  const topicsByCategory = useMemo(() => {
    const grouped: Record<TopicCategory, TopicWithStatus[]> = {
      Technology: [],
      Security: [],
      Management: [],
      Strategy: [],
      Business: [],
    }
    for (const topic of topics) {
      if (topic.question_count > 0 && grouped[topic.category]) {
        grouped[topic.category].push(topic)
      }
    }
    return grouped
  }, [topics])

  const totalQuizzes = useMemo(
    () => topics.filter((t) => t.question_count > 0).length,
    [topics],
  )

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900">
        <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-purple-600" />
      </div>
    )
  }

  if (error) {
    return (
      <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900 px-4">
        <div className="max-w-md rounded-xl border border-red-200 dark:border-red-800 bg-red-50 dark:bg-red-900/30 p-6 text-center text-sm text-red-700 dark:text-red-400">
          Couldn't load quizzes: {error}
        </div>
      </div>
    )
  }

  return (
    <div className="mx-auto max-w-4xl px-4 py-8">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-gray-900 dark:text-gray-100">Practice Quizzes</h1>
        <p className="mt-1 text-gray-500 dark:text-gray-400">
          {totalQuizzes} quiz{totalQuizzes !== 1 ? 'es' : ''} available across{' '}
          {CATEGORY_ORDER.filter((c) => topicsByCategory[c].length > 0).length} categories
        </p>
      </div>

      <div className="space-y-8">
        {CATEGORY_ORDER.map((category) => {
          const categoryTopics = topicsByCategory[category]
          if (categoryTopics.length === 0) return null

          return (
            <section key={category}>
              <div className="mb-3 flex items-center gap-2">
                <h2 className="text-lg font-semibold text-gray-800 dark:text-gray-200">{category}</h2>
                <Badge className={CATEGORY_BADGE_COLORS[category]}>
                  {categoryTopics.length}
                </Badge>
              </div>
              <div className="grid gap-3 sm:grid-cols-2">
                {categoryTopics.map((topic) => (
                  <Link key={topic.id} to={`/quiz/${topic.id}`}>
                    <Card className="flex items-center justify-between p-4 transition-colors hover:border-purple-300 dark:hover:border-purple-600 hover:bg-purple-50 dark:hover:bg-purple-900/20">
                      <div className="min-w-0 flex-1">
                        <h3 className="truncate font-medium text-gray-900 dark:text-gray-100">
                          {topic.title}
                        </h3>
                        <p className="mt-0.5 text-sm text-gray-500 dark:text-gray-400">
                          {topic.question_count} question{topic.question_count !== 1 ? 's' : ''}
                        </p>
                      </div>
                      <span className="ml-3 shrink-0 rounded-lg bg-purple-600 px-3 py-1.5 text-xs font-bold text-white">
                        Quiz →
                      </span>
                    </Card>
                  </Link>
                ))}
              </div>
            </section>
          )
        })}
      </div>
    </div>
  )
}
