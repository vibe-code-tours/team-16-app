import { useMemo } from 'react'
import { Link } from 'react-router-dom'
import { TopicNode } from '../components/features/TopicNode'
import { Badge } from '../components/ui/Badge'
import { Card } from '../components/ui/Card'
import { useAuth } from '../hooks/useAuth'
import { useTopics } from '../hooks/useTopics'
import type { TopicCategory, TopicWithStatus } from '../types/topic'

const CATEGORY_ORDER: readonly TopicCategory[] = [
  'Technology',
  'Security',
  'Management',
  'Strategy',
  'Business',
]

const CATEGORY_MARKER_BG: Record<TopicCategory, string> = {
  Technology: 'bg-purple-500',
  Security: 'bg-red-500',
  Management: 'bg-blue-500',
  Strategy: 'bg-emerald-500',
  Business: 'bg-amber-500',
}

const CATEGORY_PANEL_ACCENT: Record<TopicCategory, string> = {
  Technology: 'border-t-purple-400',
  Security: 'border-t-red-400',
  Management: 'border-t-blue-400',
  Strategy: 'border-t-emerald-400',
  Business: 'border-t-amber-400',
}

const PROGRESS_WIDTH_CLASSES = [
  'w-0',
  'w-[10%]',
  'w-[20%]',
  'w-[30%]',
  'w-[40%]',
  'w-1/2',
  'w-[60%]',
  'w-[70%]',
  'w-4/5',
  'w-[90%]',
  'w-full',
] as const

export function LearningMap() {
  const { user } = useAuth()
  const { topics, loading, error } = useTopics()
  const learningSummary = useMemo(() => summarizeLearning(topics), [topics])
  const topicsByCategory = useMemo(() => groupTopicsByCategory(topics), [topics])
  const learnerName = getLearnerName(user?.display_name, user?.email)

  return (
    <div className="mx-auto flex max-w-6xl flex-col gap-10">
      <WelcomeHero
        learnerName={learnerName}
        totalXp={user?.total_xp ?? 0}
        streakCount={user?.streak_count ?? 0}
        summary={learningSummary}
        isLoading={loading}
        hasError={Boolean(error)}
      />

      <section id="learning-path" aria-labelledby="learning-path-title" className="scroll-mt-24">
        <div className="mb-6 flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <Badge className="mb-2 bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-400">Your roadmap</Badge>
            <h2 id="learning-path-title" className="text-2xl font-bold text-gray-900 dark:text-gray-100">
              Follow your learning journey
            </h2>
            <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">
              Clear each stop, collect XP, and get closer to exam day confidence.
            </p>
          </div>
          {!loading && !error && topics.length > 0 ? (
            <p className="text-sm font-semibold text-purple-700 dark:text-purple-400">
              {learningSummary.completedTopics} of {learningSummary.totalTopics} stops cleared
            </p>
          ) : null}
        </div>

        {loading ? <LoadingState /> : null}
        {error ? <ErrorState message={error} /> : null}
        {!loading && !error && topics.length === 0 ? <EmptyState /> : null}

        {!loading && !error && topics.length > 0 ? (
          <div className="flex flex-col gap-6">
            {CATEGORY_ORDER.map((category) => {
              const categoryTopics = topicsByCategory.get(category) ?? []
              if (categoryTopics.length === 0) return null
              return (
                <CategorySection
                  key={category}
                  category={category}
                  topics={categoryTopics}
                />
              )
            })}
          </div>
        ) : null}
      </section>
    </div>
  )
}

interface WelcomeHeroProps {
  learnerName: string
  totalXp: number
  streakCount: number
  summary: LearningSummary
  isLoading: boolean
  hasError: boolean
}

function WelcomeHero({
  learnerName,
  totalXp,
  streakCount,
  summary,
  isLoading,
  hasError,
}: WelcomeHeroProps) {
  const motivation = getMotivation(summary.progressPercent, streakCount)

  return (
    <section
      aria-labelledby="welcome-heading"
      className="learning-hero-enter relative overflow-hidden rounded-3xl border border-purple-200 dark:border-purple-800 bg-gradient-to-br from-purple-50 via-white to-amber-50 dark:from-purple-900/40 dark:via-gray-800 dark:to-amber-900/20 p-6 shadow-sm sm:p-8"
    >
      <div
        className="absolute -right-10 -top-12 size-40 rounded-full bg-purple-100/70 dark:bg-purple-500/20"
        aria-hidden="true"
      />
      <div
        className="absolute -bottom-16 right-24 size-32 rounded-full bg-amber-100/70 dark:bg-amber-500/20"
        aria-hidden="true"
      />

      <div className="relative grid gap-8 lg:grid-cols-[minmax(0,1.35fr)_minmax(300px,0.65fr)] lg:items-center">
        <div>
          <div className="mb-5 flex items-center gap-4">
            <span
              className="learning-owl-enter flex size-20 shrink-0 items-center justify-center rounded-3xl bg-white dark:bg-gray-700 text-5xl shadow-md ring-1 ring-purple-100 dark:ring-purple-800"
              aria-hidden="true"
            >
              🦉
            </span>
            <div>
              <Badge className="mb-2 bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-400">Today&apos;s quest</Badge>
              <p className="text-sm font-semibold text-purple-700 dark:text-purple-400">ITPEC FE adventure</p>
            </div>
          </div>

          <h1 id="welcome-heading" className="max-w-2xl text-3xl font-bold text-gray-900 dark:text-gray-100 sm:text-4xl">
            Ready for your next win, {learnerName}?
          </h1>
          <p className="mt-3 max-w-2xl text-base text-gray-600 dark:text-gray-400 sm:text-lg">{motivation}</p>

          <div className="mt-6 flex flex-col gap-3 sm:flex-row sm:items-center">
            <ContinueAction summary={summary} isLoading={isLoading} hasError={hasError} />
            <a
              href="#learning-path"
              className="inline-flex min-h-11 items-center justify-center rounded-lg px-5 py-3 text-sm font-semibold text-purple-700 dark:text-purple-400 transition-colors duration-200 hover:bg-purple-100 dark:hover:bg-purple-900/30 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2"
            >
              View full roadmap
            </a>
          </div>
        </div>

        <Card className="relative border-purple-100 dark:border-purple-800 bg-white/90 dark:bg-gray-800/90" padding="lg">
          <div className="flex flex-col gap-5">
            <div className="flex items-center justify-between gap-4">
              <div>
                <p className="text-xs font-medium uppercase tracking-widest text-gray-500 dark:text-gray-400">Journey progress</p>
                <p className="mt-1 text-3xl font-bold text-gray-900 dark:text-gray-100">
                  {isLoading ? '—' : `${summary.progressPercent}%`}
                </p>
              </div>
              <span className="text-4xl" aria-hidden="true">🏆</span>
            </div>

            <JourneyProgress percent={summary.progressPercent} isLoading={isLoading} />

            <dl className="grid grid-cols-2 gap-3">
              <StatCard label="Total XP" value={`${totalXp}`} icon="⚡" />
              <StatCard label="Day streak" value={`${streakCount}`} icon="🔥" />
            </dl>
          </div>
        </Card>
      </div>
    </section>
  )
}

interface ContinueActionProps {
  summary: LearningSummary
  isLoading: boolean
  hasError: boolean
}

function ContinueAction({ summary, isLoading, hasError }: ContinueActionProps) {
  const baseClasses = 'inline-flex min-h-11 items-center justify-center rounded-lg px-6 py-3 text-sm font-bold shadow-md transition-all duration-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2'

  if (isLoading) {
    return (
      <span className={`${baseClasses} cursor-wait bg-purple-200 dark:bg-purple-800 text-purple-700 dark:text-purple-300 shadow-none`} role="status">
        Finding your next stop…
      </span>
    )
  }

  if (hasError) {
    return (
      <a href="#learning-path" className={`${baseClasses} bg-purple-600 text-white hover:bg-purple-700`}>
        Check your learning path
      </a>
    )
  }

  if (summary.nextTopic) {
    const action = summary.nextTopic.status === 'in_progress' ? 'Continue' : 'Start'
    return (
      <Link
        to={`/map/${summary.nextTopic.id}`}
        className={`${baseClasses} bg-purple-600 text-white hover:-translate-y-0.5 hover:bg-purple-700 hover:shadow-lg`}
      >
        {action} {summary.nextTopic.title}
        <span className="ml-2" aria-hidden="true">→</span>
      </Link>
    )
  }

  return (
    <Link
      to="/exam"
      className={`${baseClasses} bg-purple-600 text-white hover:-translate-y-0.5 hover:bg-purple-700 hover:shadow-lg`}
    >
      {summary.isComplete ? 'Celebrate with an exam' : 'Explore exam practice'}
      <span className="ml-2" aria-hidden="true">→</span>
    </Link>
  )
}

function JourneyProgress({ percent, isLoading }: { percent: number; isLoading: boolean }) {
  if (isLoading) {
    return (
      <div className="h-3 overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700" role="status" aria-label="Loading journey progress">
        <div className="h-full w-1/3 animate-pulse rounded-full bg-purple-300" />
      </div>
    )
  }

  return (
    <div
      className="h-3 overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700"
      role="progressbar"
      aria-label="Overall learning progress"
      aria-valuemin={0}
      aria-valuemax={100}
      aria-valuenow={percent}
    >
      <div
        className={`learning-progress-reveal h-full rounded-full bg-gradient-to-r from-purple-500 to-purple-600 ${getProgressWidthClass(percent)}`}
      />
    </div>
  )
}

function StatCard({ label, value, icon }: { label: string; value: string; icon: string }) {
  return (
    <div className="rounded-2xl border border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-700/50 p-3">
      <dt className="text-xs font-medium text-gray-500 dark:text-gray-400">
        <span className="mr-1" aria-hidden="true">{icon}</span>
        {label}
      </dt>
      <dd className="mt-1 text-xl font-bold text-gray-900 dark:text-gray-100">{value}</dd>
    </div>
  )
}

interface CategorySectionProps {
  category: TopicCategory
  topics: TopicWithStatus[]
}

function CategorySection({ category, topics }: CategorySectionProps) {
  const completed = topics.filter((topic) => topic.status === 'completed').length

  return (
    <section
      aria-labelledby={`cat-${category}`}
      className={`learning-topic-enter rounded-3xl border border-t-4 border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-4 shadow-sm sm:p-6 ${CATEGORY_PANEL_ACCENT[category]}`}
    >
      <MileMarker category={category} completed={completed} total={topics.length} />
      <ol className="mt-5 flex flex-col">
        {topics.map((topic, index) => (
          <li key={topic.id}>
            <TopicNode topic={topic} stepNumber={index + 1} />
            {index < topics.length - 1 ? <Connector /> : null}
          </li>
        ))}
      </ol>
    </section>
  )
}

interface MileMarkerProps {
  category: TopicCategory
  completed: number
  total: number
}

function MileMarker({ category, completed, total }: MileMarkerProps) {
  return (
    <div className="flex items-center gap-3">
      <div className={`flex size-9 shrink-0 items-center justify-center rounded-xl ${CATEGORY_MARKER_BG[category]}`} aria-hidden="true">
        <span className="size-3 rounded-full border-2 border-white bg-white/40" />
      </div>
      <div className="min-w-0 flex-1">
        <h3 id={`cat-${category}`} className="text-sm font-bold uppercase tracking-widest text-gray-900 dark:text-gray-100">
          {category}
        </h3>
        <p className="text-xs text-gray-500 dark:text-gray-400">Milestone · {completed} of {total} cleared</p>
      </div>
      {completed === total ? <Badge variant="success">Complete</Badge> : null}
    </div>
  )
}

function Connector() {
  return (
    <div className="ml-6 h-6 border-l-2 border-dashed border-purple-200 dark:border-purple-800" aria-hidden="true" />
  )
}

function LoadingState() {
  return (
    <div className="flex flex-col gap-3" role="status" aria-label="Loading your learning journey">
      <span className="sr-only">Loading your learning journey…</span>
      {Array.from({ length: 4 }).map((_, index) => (
        <div key={index} className="h-24 animate-pulse rounded-2xl bg-gray-200 dark:bg-gray-700" aria-hidden="true" />
      ))}
    </div>
  )
}

function ErrorState({ message }: { message: string }) {
  return (
    <div role="alert" className="rounded-xl border border-red-200 dark:border-red-800 bg-red-50 dark:bg-red-900/30 p-5 text-sm text-red-700 dark:text-red-400">
      <p className="font-bold">Your roadmap took a little detour.</p>
      <p className="mt-1">Couldn&apos;t load topics: {message}. Check your connection and try again.</p>
    </div>
  )
}

function EmptyState() {
  return (
    <Card className="text-center" padding="lg">
      <span className="text-4xl" aria-hidden="true">🌱</span>
      <h3 className="mt-3 text-lg font-bold text-gray-900 dark:text-gray-100">Your learning path is sprouting</h3>
      <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">
        No topics are available yet. Try an exam challenge while new stops are being prepared.
      </p>
      <Link
        to="/exam"
        className="mt-5 inline-flex min-h-11 items-center justify-center rounded-lg bg-purple-600 px-5 py-3 text-sm font-bold text-white transition-colors duration-200 hover:bg-purple-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2"
      >
        Explore exam practice
      </Link>
    </Card>
  )
}

interface LearningSummary {
  completedTopics: number
  totalTopics: number
  progressPercent: number
  nextTopic: TopicWithStatus | null
  isComplete: boolean
}

function summarizeLearning(topics: TopicWithStatus[]): LearningSummary {
  const completedTopics = topics.filter((topic) => topic.status === 'completed').length
  const nextTopic = topics.find((topic) => topic.status === 'in_progress')
    ?? topics.find((topic) => topic.status === 'not_started')
    ?? null
  const progressPercent = topics.length === 0
    ? 0
    : Math.round((completedTopics / topics.length) * 100)

  return {
    completedTopics,
    totalTopics: topics.length,
    progressPercent,
    nextTopic,
    isComplete: topics.length > 0 && completedTopics === topics.length,
  }
}

function groupTopicsByCategory(topics: TopicWithStatus[]) {
  const grouped = new Map<TopicCategory, TopicWithStatus[]>()
  for (const category of CATEGORY_ORDER) grouped.set(category, [])
  for (const topic of topics) grouped.get(topic.category)?.push(topic)
  for (const categoryTopics of grouped.values()) {
    categoryTopics.sort((firstTopic, secondTopic) => firstTopic.order - secondTopic.order)
  }
  return grouped
}

function getLearnerName(displayName?: string | null, email?: string | null) {
  const name = displayName?.trim() || email?.split('@')[0] || 'learner'
  return name.split(/\s+/)[0]
}

function getMotivation(progressPercent: number, streakCount: number) {
  if (progressPercent === 100) return 'You cleared the whole map! Put that knowledge to the test in an exam simulation.'
  if (streakCount > 1) return `Your ${streakCount}-day streak is glowing. One focused lesson today keeps the momentum going.`
  if (progressPercent > 0) return 'Every completed topic is proof that you are getting exam-ready. Keep the momentum going!'
  return 'Start small, stay curious, and let each bite-sized lesson move you closer to exam confidence.'
}

function getProgressWidthClass(percent: number) {
  const index = Math.min(10, Math.max(0, Math.round(percent / 10)))
  return PROGRESS_WIDTH_CLASSES[index]
}
