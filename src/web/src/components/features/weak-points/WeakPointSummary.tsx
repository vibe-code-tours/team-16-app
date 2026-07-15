import type { TopicMastery } from '../../../types/WeakPoint'

interface WeakPointSummaryProps {
  topics: TopicMastery[]
}

export function WeakPointSummary({ topics }: WeakPointSummaryProps) {
  const totalSeen = topics.reduce((sum, t) => sum + t.questionsSeen, 0)
  const totalCorrect = topics.reduce((sum, t) => sum + t.questionsCorrect, 0)
  const averageMastery = topics.length > 0
    ? topics.reduce((sum, t) => sum + t.masteryScore, 0) / topics.length
    : 0

  const weakestTopic = topics.length > 0 ? topics[0] : null // topics already sorted weakest-first
  const strongestTopic = topics.length > 0 ? topics[topics.length - 1] : null

  return (
    <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
      <StatCard
        label="Topics Practiced"
        value={topics.filter((t) => t.questionsSeen > 0).length.toString()}
        sublabel={`of ${topics.length} total`}
      />
      <StatCard
        label="Overall Mastery"
        value={`${Math.round(averageMastery * 100)}%`}
        sublabel={`${totalCorrect}/${totalSeen} correct`}
      />
      {weakestTopic && weakestTopic.questionsSeen > 0 && (
        <StatCard
          label="Weakest Topic"
          value={weakestTopic.topicName}
          sublabel={`${Math.round(weakestTopic.masteryScore * 100)}% mastery`}
          variant="error"
        />
      )}
      {strongestTopic && strongestTopic.questionsSeen > 0 && (
        <StatCard
          label="Strongest Topic"
          value={strongestTopic.topicName}
          sublabel={`${Math.round(strongestTopic.masteryScore * 100)}% mastery`}
          variant="success"
        />
      )}
    </div>
  )
}

interface StatCardProps {
  label: string
  value: string
  sublabel: string
  variant?: 'default' | 'error' | 'success'
}

function StatCard({ label, value, sublabel, variant = 'default' }: StatCardProps) {
  const borderColors = {
    default: 'border-gray-200',
    error: 'border-red-200',
    success: 'border-green-200',
  }

  return (
    <div className={`bg-white rounded-xl shadow-sm border ${borderColors[variant]} p-4`}>
      <p className="text-xs font-bold text-gray-400 uppercase mb-1">{label}</p>
      <p className="text-xl font-bold text-gray-900 truncate">{value}</p>
      <p className="text-xs text-gray-500 mt-0.5">{sublabel}</p>
    </div>
  )
}
