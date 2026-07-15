import { useAdminStats } from '../hooks/useAdminStats'

export function AdminDashboard() {
  const { stats, loading, error, refetch } = useAdminStats()

  if (loading) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-purple-500 border-t-transparent" />
      </div>
    )
  }

  if (error) {
    return (
      <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4">
        <p className="text-red-600">{error}</p>
        <button
          onClick={refetch}
          className="rounded-lg bg-purple-600 px-4 py-2 text-sm font-medium text-white hover:bg-purple-700"
        >
          Retry
        </button>
      </div>
    )
  }

  if (!stats) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <p className="text-gray-500">No data available</p>
      </div>
    )
  }

  const statCards = [
    { label: 'Total Users', value: stats.totalUsers, color: 'bg-purple-50 text-purple-700' },
    { label: 'Active Today', value: stats.activeToday, color: 'bg-green-50 text-green-700' },
    { label: 'Active This Week', value: stats.activeThisWeek, color: 'bg-blue-50 text-blue-700' },
    { label: 'Quiz Attempts', value: stats.totalQuizAttempts, color: 'bg-amber-50 text-amber-700' },
    { label: 'Exam Attempts', value: stats.totalExamAttempts, color: 'bg-rose-50 text-rose-700' },
  ]

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold text-gray-900">Admin Dashboard</h1>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {statCards.map((card) => (
          <div
            key={card.label}
            className="rounded-xl border border-gray-200 bg-white p-5 shadow-sm"
          >
            <p className="text-sm font-medium text-gray-500">{card.label}</p>
            <p className={`mt-2 text-3xl font-bold ${card.color.split(' ')[1]}`}>
              {card.value.toLocaleString()}
            </p>
          </div>
        ))}
      </div>

      {/* Topic Engagement Table */}
      <div className="rounded-xl border border-gray-200 bg-white shadow-sm">
        <div className="border-b border-gray-200 px-5 py-4">
          <h2 className="text-lg font-semibold text-gray-900">Topic Engagement</h2>
        </div>

        {stats.topicEngagement.length === 0 ? (
          <div className="px-5 py-8 text-center text-gray-500">
            No quiz data yet
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-left text-sm">
              <thead>
                <tr className="border-b border-gray-100 bg-gray-50">
                  <th className="px-5 py-3 font-medium text-gray-600">Topic</th>
                  <th className="px-5 py-3 text-right font-medium text-gray-600">Quiz Count</th>
                  <th className="px-5 py-3 text-right font-medium text-gray-600">Avg Score</th>
                </tr>
              </thead>
              <tbody>
                {stats.topicEngagement.map((topic) => (
                  <tr
                    key={topic.topicName}
                    className="border-b border-gray-50 last:border-0"
                  >
                    <td className="px-5 py-3 font-medium text-gray-900">
                      {topic.topicName}
                    </td>
                    <td className="px-5 py-3 text-right text-gray-700">
                      {topic.quizCount.toLocaleString()}
                    </td>
                    <td className="px-5 py-3 text-right text-gray-700">
                      {topic.avgScore.toFixed(1)}%
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  )
}
