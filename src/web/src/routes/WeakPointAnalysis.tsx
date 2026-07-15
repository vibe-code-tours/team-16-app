import { useWeakPoints } from '../hooks/useWeakPoints'
import { WeakPointCard } from '../components/features/weak-points/WeakPointCard'
import { WeakPointSummary } from '../components/features/weak-points/WeakPointSummary'

export function WeakPointAnalysis() {
  const { data, loading, error } = useWeakPoints()

  return (
    <div>
      <div className="mb-8 text-center">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">Weak Point Analysis</h1>
        <p className="text-gray-500">
          See which topics you need to focus on. Weaker areas appear first.
        </p>
      </div>

      {error && (
        <div role="alert" className="mb-6 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">
          Couldn't load your analysis: {error}
        </div>
      )}

      {loading ? (
        <div className="flex justify-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
        </div>
      ) : data && data.topics.length > 0 ? (
        <>
          <WeakPointSummary topics={data.topics} />
          <div className="grid grid-cols-1 gap-6">
            {data.topics.map((topic) => (
              <WeakPointCard
                key={topic.topicId}
                topic={topic}
                subtopics={data.subtopics}
              />
            ))}
          </div>
        </>
      ) : (
        <div className="text-center py-20 bg-white rounded-2xl border border-dashed border-gray-300">
          <div className="text-5xl mb-4">📊</div>
          <h3 className="text-xl font-semibold text-gray-900 mb-2">No data yet</h3>
          <p className="text-gray-500">
            Complete some quizzes to see your weak point analysis.
          </p>
        </div>
      )}
    </div>
  )
}
