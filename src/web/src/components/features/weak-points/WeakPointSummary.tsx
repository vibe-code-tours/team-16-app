import type { TopicMastery } from '../../../types/WeakPoint'

interface WeakPointSummaryProps {
  topics: TopicMastery[]
}

export function WeakPointSummary({ topics }: WeakPointSummaryProps) {
  const practicedTopics = topics.filter((topic) => topic.questionsSeen > 0)
  const totalSeen = practicedTopics.reduce((sum, topic) => sum + topic.questionsSeen, 0)
  const totalCorrect = practicedTopics.reduce((sum, topic) => sum + topic.questionsCorrect, 0)
  const overallAccuracy = totalSeen > 0 ? Math.round((totalCorrect / totalSeen) * 100) : 0
  const focusAreas = practicedTopics.filter((topic) => topic.masteryScore < 0.7).length

  const metrics: SummaryMetric[] = [
    {
      label: 'Questions analyzed',
      value: totalSeen.toString(),
      detail: `${totalCorrect} answered correctly`,
      icon: '✦',
      tone: 'purple',
    },
    {
      label: 'Overall accuracy',
      value: `${overallAccuracy}%`,
      detail: getAccuracyMessage(overallAccuracy),
      icon: '◎',
      tone: 'blue',
      progress: overallAccuracy,
    },
    {
      label: 'Topics practiced',
      value: practicedTopics.length.toString(),
      detail: practicedTopics.length === 1 ? 'Active learning area' : 'Active learning areas',
      icon: '◇',
      tone: 'emerald',
    },
    {
      label: 'Focus areas',
      value: focusAreas.toString(),
      detail: focusAreas === 1 ? 'Priority topic identified' : 'Priority topics identified',
      icon: '↗',
      tone: 'orange',
    },
  ]

  return (
    <section aria-label="Analysis summary" className="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
      {metrics.map((metric) => (
        <SummaryCard key={metric.label} metric={metric} />
      ))}
    </section>
  )
}

function SummaryCard({ metric }: { metric: SummaryMetric }) {
  const toneClasses = {
    purple: 'bg-purple-50 dark:bg-purple-900/30 text-purple-700 dark:text-purple-400 ring-purple-100 dark:ring-purple-800',
    blue: 'bg-sky-50 dark:bg-sky-900/30 text-sky-700 dark:text-sky-400 ring-sky-100 dark:ring-sky-800',
    emerald: 'bg-emerald-50 dark:bg-emerald-900/30 text-emerald-700 dark:text-emerald-400 ring-emerald-100 dark:ring-emerald-800',
    orange: 'bg-orange-50 dark:bg-orange-900/30 text-orange-700 dark:text-orange-400 ring-orange-100 dark:ring-orange-800',
  }

  return (
    <article className="learning-feature-enter group relative overflow-hidden rounded-2xl border border-gray-200/80 dark:border-gray-700 bg-white dark:bg-gray-800 p-5 shadow-sm transition-all duration-200 hover:-translate-y-1 hover:border-purple-200 dark:hover:border-purple-700 hover:shadow-lg hover:shadow-purple-100/60 motion-reduce:transform-none motion-reduce:transition-none">
      <div className="flex items-start justify-between gap-4">
        <div>
          <p className="text-xs font-bold uppercase tracking-[0.14em] text-gray-400 dark:text-gray-500">{metric.label}</p>
          <p className="mt-2 text-3xl font-bold tracking-tight text-gray-950 dark:text-gray-50">{metric.value}</p>
        </div>
        <span className={`flex size-11 items-center justify-center rounded-2xl text-xl font-bold ring-1 transition-transform duration-200 group-hover:scale-110 group-hover:-rotate-3 motion-reduce:transform-none motion-reduce:transition-none ${toneClasses[metric.tone]}`} aria-hidden="true">
          {metric.icon}
        </span>
      </div>
      <p className="mt-3 text-xs font-medium text-gray-500 dark:text-gray-400">{metric.detail}</p>
      {metric.progress !== undefined ? (
        <div className="mt-3 h-1.5 overflow-hidden rounded-full bg-gray-100 dark:bg-gray-700" aria-hidden="true">
          <div className="learning-progress-reveal h-full rounded-full bg-gradient-to-r from-sky-500 to-purple-500" style={{ width: `${metric.progress}%` }} />
        </div>
      ) : null}
    </article>
  )
}

function getAccuracyMessage(accuracy: number) {
  if (accuracy >= 80) return 'Excellent momentum'
  if (accuracy >= 60) return 'Building confidence'
  if (accuracy > 0) return 'Every review makes you stronger'
  return 'Ready for a focused comeback'
}

interface SummaryMetric {
  label: string
  value: string
  detail: string
  icon: string
  tone: 'purple' | 'blue' | 'emerald' | 'orange'
  progress?: number
}
