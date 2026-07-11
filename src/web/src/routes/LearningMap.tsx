import { useMemo } from 'react'
import { useAuth } from '../hooks/useAuth.tsx'
import { useTopics } from '../hooks/useTopics'
import { TopicNode } from '../components/features/TopicNode'
import type { TopicCategory, TopicWithStatus } from '../types/topic'

const CATEGORY_ORDER: TopicCategory[] = [
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

export function LearningMap() {
  const { user, signOut } = useAuth()
  const { topics, loading, error } = useTopics()

  const topicsByCategory = useMemo(() => {
    const grouped = new Map<TopicCategory, TopicWithStatus[]>()
    for (const category of CATEGORY_ORDER) grouped.set(category, [])
    for (const topic of topics) {
      grouped.get(topic.category)?.push(topic)
    }
    for (const list of grouped.values()) {
      list.sort((a, b) => a.order - b.order)
    }
    return grouped
  }, [topics])

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="sticky top-0 z-10 border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-2xl items-center justify-between gap-3 px-4 py-3">
          <h1 className="text-lg font-bold text-purple-600">NerdQuiz</h1>
          <div className="flex items-center gap-3 text-sm">
            <Stat icon="⚡" value={user?.total_xp ?? 0} tone="text-purple-600" label="XP" />
            <Stat icon="🔥" value={user?.streak_count ?? 0} tone="text-orange-500" label="Streak" />
            <button
              onClick={signOut}
              className="rounded-md border border-gray-300 px-2 py-1 text-xs text-gray-700 hover:bg-gray-50"
              aria-label="Sign out"
            >
              Sign out
            </button>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-2xl px-4 py-6">
        <div className="mb-6">
          <h2 className="text-xl font-bold text-gray-900">Your journey</h2>
          <p className="text-sm text-gray-500">
            Follow the roadmap to ace the ITPEC FE exam.
          </p>
        </div>

        {loading ? <LoadingState /> : null}
        {error ? <ErrorState message={error} /> : null}
        {!loading && !error && topics.length === 0 ? <EmptyState /> : null}

        {!loading && !error && topics.length > 0 ? (
          <div className="flex flex-col gap-10">
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
      </main>
    </div>
  )
}

interface CategorySectionProps {
  category: TopicCategory
  topics: TopicWithStatus[]
}

function CategorySection({ category, topics }: CategorySectionProps) {
  const completed = topics.filter((t) => t.status === 'completed').length
  return (
    <section aria-labelledby={`cat-${category}`}>
      <MileMarker category={category} completed={completed} total={topics.length} />
      <ol className="mt-4 flex flex-col">
        {topics.map((topic, i) => (
          <li key={topic.id}>
            <TopicNode topic={topic} stepNumber={i + 1} />
            {i < topics.length - 1 ? <Connector /> : null}
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
      <div
        className={`h-2.5 w-2.5 shrink-0 rounded-full ${CATEGORY_MARKER_BG[category]}`}
        aria-hidden="true"
      />
      <h2
        id={`cat-${category}`}
        className="text-xs font-bold uppercase tracking-widest text-gray-700"
      >
        {category}
      </h2>
      <div className="h-px flex-1 bg-gray-200" aria-hidden="true" />
      <span className="text-xs font-medium text-gray-500">
        {completed} / {total}
      </span>
    </div>
  )
}

function Connector() {
  return (
    <div
      className="ml-9 h-4 w-0.5 border-l-2 border-dashed border-gray-300"
      aria-hidden="true"
    />
  )
}

interface StatProps {
  icon: string
  value: number
  tone: string
  label: string
}

function Stat({ icon, value, tone, label }: StatProps) {
  return (
    <span className="flex items-center gap-1" aria-label={`${value} ${label}`}>
      <span aria-hidden="true">{icon}</span>
      <span className={`font-bold ${tone}`}>{value}</span>
    </span>
  )
}

function LoadingState() {
  return (
    <div className="flex flex-col gap-3">
      {Array.from({ length: 5 }).map((_, i) => (
        <div key={i} className="h-24 animate-pulse rounded-2xl bg-gray-200" />
      ))}
    </div>
  )
}

function ErrorState({ message }: { message: string }) {
  return (
    <div
      role="alert"
      className="rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700"
    >
      Couldn't load topics: {message}
    </div>
  )
}

function EmptyState() {
  return (
    <div className="rounded-xl border border-gray-200 bg-white p-6 text-center text-sm text-gray-500">
      No topics available yet. Check back soon.
    </div>
  )
}
