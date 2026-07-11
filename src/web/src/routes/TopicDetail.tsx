import { Link, useParams } from 'react-router-dom'

export function TopicDetail() {
  const { topicId } = useParams<{ topicId: string }>()

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-5xl items-center justify-between px-4 py-4">
          <h1 className="text-xl font-bold text-purple-600">NerdQuiz</h1>
          <Link
            to="/map"
            className="rounded-md border border-gray-300 px-3 py-1.5 text-sm text-gray-700 hover:bg-gray-50"
          >
            Back to map
          </Link>
        </div>
      </header>

      <main className="mx-auto max-w-3xl px-4 py-8">
        <h2 className="mb-2 text-2xl font-bold text-gray-900">Topic</h2>
        <p className="text-sm text-gray-500">
          Topic ID: <code className="rounded bg-gray-100 px-1.5 py-0.5">{topicId}</code>
        </p>
        <p className="mt-4 text-sm text-gray-500">
          Topic detail page is coming soon. Lessons and quizzes will live here.
        </p>
      </main>
    </div>
  )
}
