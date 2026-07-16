import { useAdminStats } from '../hooks/useAdminStats'
import { ActiveUsersChart } from '../components/features/admin/ActiveUsersChart'
import { TopicQuizChart } from '../components/features/admin/TopicQuizChart'
import { TopicScoreChart } from '../components/features/admin/TopicScoreChart'
import { QuizCompletionChart } from '../components/features/admin/QuizCompletionChart'
import { ExamPassChart } from '../components/features/admin/ExamPassChart'

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
    { label: 'Total Users', value: stats.totalUsers, color: 'text-purple-700' },
    { label: 'Active Today', value: stats.activeToday, color: 'text-green-700' },
    { label: 'Active This Week', value: stats.activeThisWeek, color: 'text-blue-700' },
    { label: 'Quiz Attempts', value: stats.totalQuizAttempts, color: 'text-amber-700' },
    { label: 'Exam Attempts', value: stats.totalExamAttempts, color: 'text-rose-700' },
    { label: 'Avg Quiz Score', value: `${stats.avgQuizScore.toFixed(1)}%`, color: 'text-emerald-700' },
    { label: 'Avg Exam Score', value: `${stats.avgExamScore.toFixed(1)}%`, color: 'text-cyan-700' },
    { label: 'Exam Pass Rate', value: `${stats.examPassRate}%`, color: 'text-indigo-700' },
  ]

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold text-gray-900">Admin Dashboard</h1>

      {/* Stats Cards */}
      <div className="grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-4">
        {statCards.map((card) => (
          <div
            key={card.label}
            className="rounded-xl border border-gray-200 bg-white p-5 shadow-sm"
          >
            <p className="text-sm font-medium text-gray-500">{card.label}</p>
            <p className={`mt-2 text-3xl font-bold ${card.color}`}>
              {typeof card.value === 'number' ? card.value.toLocaleString() : card.value}
            </p>
          </div>
        ))}
      </div>

      {/* Daily Active Users Chart */}
      <div className="rounded-xl border border-gray-200 bg-white shadow-sm">
        <div className="border-b border-gray-200 px-5 py-4">
          <h2 className="text-lg font-semibold text-gray-900">Daily Active Users (30 days)</h2>
        </div>
        <div className="p-5">
          <ActiveUsersChart data={stats.dailyActiveUsers} />
        </div>
      </div>

      {/* Topic Engagement Charts */}
      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <div className="rounded-xl border border-gray-200 bg-white shadow-sm">
          <div className="border-b border-gray-200 px-5 py-4">
            <h2 className="text-lg font-semibold text-gray-900">Quiz Count by Topic</h2>
          </div>
          <div className="p-5">
            <TopicQuizChart data={stats.topicEngagement} />
          </div>
        </div>

        <div className="rounded-xl border border-gray-200 bg-white shadow-sm">
          <div className="border-b border-gray-200 px-5 py-4">
            <h2 className="text-lg font-semibold text-gray-900">Avg Score by Topic</h2>
          </div>
          <div className="p-5">
            <TopicScoreChart data={stats.topicEngagement} />
          </div>
        </div>
      </div>

      {/* Completion & Pass Rate Charts */}
      <div className="grid grid-cols-1 gap-6 lg:grid-cols-2">
        <div className="rounded-xl border border-gray-200 bg-white shadow-sm">
          <div className="border-b border-gray-200 px-5 py-4">
            <h2 className="text-lg font-semibold text-gray-900">Quiz Completion</h2>
          </div>
          <div className="flex justify-center p-5">
            <QuizCompletionChart
              completed={stats.totalQuizAttempts}
              total={stats.totalQuizSessions}
            />
          </div>
        </div>

        <div className="rounded-xl border border-gray-200 bg-white shadow-sm">
          <div className="border-b border-gray-200 px-5 py-4">
            <h2 className="text-lg font-semibold text-gray-900">Exam Pass Rate</h2>
          </div>
          <div className="flex justify-center p-5">
            <ExamPassChart
              passRate={stats.examPassRate}
              totalAttempts={stats.totalExamAttempts}
            />
          </div>
        </div>
      </div>
    </div>
  )
}
