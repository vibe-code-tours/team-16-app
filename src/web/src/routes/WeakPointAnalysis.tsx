import { useState } from 'react'
import { Link } from 'react-router-dom'
import { WeakPointCard } from '../components/features/weak-points/WeakPointCard'
import { WeakPointSummary } from '../components/features/weak-points/WeakPointSummary'
import { useWeakPoints } from '../hooks/useWeakPoints'

const FILTERS: FocusFilterOption[] = [
  { value: 'all', label: 'All topics' },
  { value: 'focus', label: 'Needs focus' },
  { value: 'developing', label: 'Developing' },
  { value: 'strong', label: 'Strong' },
]

export function WeakPointAnalysis() {
  const { data, loading, error } = useWeakPoints()
  const [activeFilter, setActiveFilter] = useState<FocusFilter>('all')

  if (loading) return <LoadingState />
  if (error) return <ErrorState message={error} />
  if (!data || data.topics.length === 0) return <EmptyState />

  const practicedSubtopics = data.subtopics
    .filter((subtopic) => subtopic.questionsSeen > 0)
    .sort((a, b) => a.masteryScore - b.masteryScore || b.questionsSeen - a.questionsSeen)
  const topFocus = practicedSubtopics[0] ?? null
  const totalQuestions = data.topics.reduce((sum, topic) => sum + topic.questionsSeen, 0)
  const filteredTopics = data.topics.filter((topic) => matchesFilter(topic.masteryScore, activeFilter))

  return (
    <div className="mx-auto flex max-w-6xl flex-col gap-6 pb-8">
      <FocusHero topFocus={topFocus} totalQuestions={totalQuestions} />

      <WeakPointSummary topics={data.topics} />

      <section aria-labelledby="focus-breakdown-title" className="mt-2">
        <div className="mb-5 flex flex-col gap-4 lg:flex-row lg:items-end lg:justify-between">
          <div>
            <p className="text-xs font-bold uppercase tracking-[0.16em] text-purple-600 dark:text-purple-400">Your learning radar</p>
            <h2 id="focus-breakdown-title" className="mt-1 text-2xl font-bold tracking-tight text-gray-950 dark:text-gray-50">Topic breakdown</h2>
            <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">Explore each topic and jump directly into focused practice.</p>
          </div>

          <div className="flex max-w-full gap-2 overflow-x-auto pb-1" role="group" aria-label="Filter topics by mastery">
            {FILTERS.map((filter) => {
              const count = data.topics.filter((topic) => matchesFilter(topic.masteryScore, filter.value)).length
              const isActive = activeFilter === filter.value
              return (
                <button
                  key={filter.value}
                  type="button"
                  onClick={() => setActiveFilter(filter.value)}
                  className={`inline-flex min-h-10 shrink-0 items-center gap-2 rounded-xl px-3.5 py-2 text-sm font-semibold transition-all focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2 motion-reduce:transition-none ${isActive ? 'bg-gray-950 dark:bg-white text-white dark:text-gray-950 shadow-md' : 'border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 text-gray-500 dark:text-gray-400 hover:border-purple-200 dark:hover:border-purple-700 hover:bg-purple-50 dark:hover:bg-purple-900/30 hover:text-purple-700 dark:hover:text-purple-400'}`}
                  aria-pressed={isActive}
                >
                  {filter.label}
                  <span className={`rounded-full px-1.5 py-0.5 text-[10px] ${isActive ? 'bg-white/15 text-white' : 'bg-gray-100 dark:bg-gray-700 text-gray-500 dark:text-gray-400'}`}>{count}</span>
                </button>
              )
            })}
          </div>
        </div>

        {filteredTopics.length > 0 ? (
          <div className="grid gap-4">
            {filteredTopics.map((topic) => (
              <WeakPointCard
                key={topic.topicId}
                topic={topic}
                subtopics={data.subtopics}
                rank={data.topics.findIndex((item) => item.topicId === topic.topicId) + 1}
              />
            ))}
          </div>
        ) : (
          <FilterEmptyState filter={activeFilter} onClear={() => setActiveFilter('all')} />
        )}
      </section>
    </div>
  )
}

interface FocusHeroProps {
  topFocus: {
    subtopicId: string
    subtopicName: string
    questionsSeen: number
    masteryScore: number
  } | null
  totalQuestions: number
}

function FocusHero({ topFocus, totalQuestions }: FocusHeroProps) {
  const focusPercentage = topFocus ? Math.round(topFocus.masteryScore * 100) : 0

  return (
    <header className="learning-hero-enter relative overflow-hidden rounded-3xl border border-purple-200 bg-gradient-to-br from-violet-700 via-purple-600 to-fuchsia-600 p-6 text-white shadow-xl shadow-purple-200/50 sm:p-8">
      <div className="absolute -right-16 -top-20 size-64 rounded-full bg-white/10" aria-hidden="true" />
      <div className="absolute -bottom-28 left-1/3 size-56 rounded-full bg-fuchsia-300/20 blur-2xl" aria-hidden="true" />
      <div className="absolute right-8 top-8 hidden text-8xl text-white/10 lg:block" aria-hidden="true">◎</div>

      <div className="relative grid gap-7 lg:grid-cols-[minmax(0,1.35fr)_minmax(300px,0.65fr)] lg:items-center">
        <div>
          <span className="inline-flex items-center gap-2 rounded-full bg-white/15 px-3 py-1.5 text-xs font-bold ring-1 ring-white/20 backdrop-blur-sm">
            <span className="size-2 animate-pulse rounded-full bg-amber-300" aria-hidden="true" />
            Personalized from {totalQuestions} {totalQuestions === 1 ? 'answer' : 'answers'}
          </span>
          <h1 className="mt-5 max-w-2xl text-3xl font-bold tracking-tight sm:text-4xl">Turn weak points into your next wins.</h1>
          <p className="mt-3 max-w-2xl text-sm leading-6 text-purple-100 sm:text-base">
            Your learning radar finds the areas that deserve attention first, so every practice session has a clear purpose.
          </p>
          {topFocus ? (
            <Link
              to={`/quiz/${topFocus.subtopicId}`}
              className="group mt-6 inline-flex min-h-11 items-center justify-center gap-2 rounded-xl bg-white px-5 py-3 text-sm font-bold text-purple-700 shadow-lg transition-all hover:-translate-y-0.5 hover:bg-purple-50 hover:shadow-xl focus:outline-none focus-visible:ring-2 focus-visible:ring-white focus-visible:ring-offset-2 focus-visible:ring-offset-purple-600 motion-reduce:transform-none motion-reduce:transition-none"
            >
              Start focused practice
              <span className="transition-transform group-hover:translate-x-1 motion-reduce:transform-none" aria-hidden="true">→</span>
            </Link>
          ) : null}
        </div>

        <div className="rounded-2xl border border-white/20 bg-white/10 p-5 backdrop-blur-md">
          <div className="flex items-start justify-between gap-4">
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.16em] text-purple-100">Recommended next</p>
              <h2 className="mt-2 text-xl font-bold">{topFocus?.subtopicName ?? 'Explore a new topic'}</h2>
              <p className="mt-1 text-sm text-white/70">{topFocus ? `${topFocus.questionsSeen} answers analyzed` : 'Build your first insight'}</p>
            </div>
            <span className="flex size-12 shrink-0 items-center justify-center rounded-2xl bg-amber-300 text-2xl text-amber-950 shadow-lg" aria-hidden="true">⚡</span>
          </div>
          <div className="mt-6 flex items-end justify-between gap-4">
            <div>
              <p className="text-xs font-medium text-purple-100">Current mastery</p>
              <p className="mt-1 text-3xl font-bold">{focusPercentage}%</p>
            </div>
            <p className="max-w-36 text-right text-xs leading-5 text-white/65">One focused quiz can change this score.</p>
          </div>
          <div className="mt-3 h-2.5 overflow-hidden rounded-full bg-purple-950/25" role="progressbar" aria-label={`${topFocus?.subtopicName ?? 'Recommended topic'} mastery`} aria-valuemin={0} aria-valuemax={100} aria-valuenow={focusPercentage}>
            <div className="learning-progress-reveal h-full rounded-full bg-gradient-to-r from-amber-300 to-yellow-200" style={{ width: `${focusPercentage}%` }} />
          </div>
        </div>
      </div>
    </header>
  )
}

function LoadingState() {
  return (
    <div className="mx-auto max-w-6xl" role="status" aria-label="Loading weak point analysis">
      <div className="h-72 animate-pulse rounded-3xl bg-gradient-to-br from-purple-200 to-fuchsia-100" />
      <div className="mt-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
        {[0, 1, 2, 3].map((item) => <div key={item} className="h-32 animate-pulse rounded-2xl bg-gray-200 dark:bg-gray-700" />)}
      </div>
      <div className="mt-6 h-56 animate-pulse rounded-3xl bg-gray-200 dark:bg-gray-700" />
      <span className="sr-only">Loading your personalized analysis…</span>
    </div>
  )
}

function ErrorState({ message }: { message: string }) {
  return (
    <div className="mx-auto max-w-2xl rounded-3xl border border-rose-200 dark:border-red-800 bg-white dark:bg-gray-800 p-8 text-center shadow-sm" role="alert">
      <span className="mx-auto flex size-14 items-center justify-center rounded-2xl bg-rose-50 dark:bg-rose-900/30 text-2xl" aria-hidden="true">!</span>
      <h1 className="mt-4 text-2xl font-bold text-gray-950 dark:text-gray-50">We couldn&apos;t build your analysis</h1>
      <p className="mt-2 text-sm text-gray-500 dark:text-gray-400">{message}</p>
      <button type="button" onClick={() => window.location.reload()} className="mt-6 min-h-11 rounded-xl bg-purple-600 px-5 py-2.5 text-sm font-bold text-white hover:bg-purple-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2">
        Try again
      </button>
    </div>
  )
}

function EmptyState() {
  return (
    <div className="learning-hero-enter mx-auto max-w-3xl overflow-hidden rounded-3xl border border-purple-200 bg-gradient-to-br from-purple-50 via-white to-amber-50 p-8 text-center shadow-sm sm:p-12">
      <span className="mx-auto flex size-20 items-center justify-center rounded-3xl bg-white text-4xl shadow-md ring-1 ring-purple-100" aria-hidden="true">📊</span>
      <h1 className="mt-6 text-3xl font-bold text-gray-950 dark:text-gray-50">Your learning radar is ready</h1>
      <p className="mx-auto mt-3 max-w-lg text-gray-500 dark:text-gray-400">Complete a quiz and we&apos;ll turn your answers into a personalized focus plan.</p>
      <Link to="/quizzes" className="mt-7 inline-flex min-h-11 items-center justify-center rounded-xl bg-purple-600 px-6 py-3 text-sm font-bold text-white shadow-md hover:bg-purple-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2">
        Take a quiz
      </Link>
    </div>
  )
}

function FilterEmptyState({ filter, onClear }: { filter: FocusFilter; onClear: () => void }) {
  return (
    <div className="rounded-3xl border border-dashed border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 p-10 text-center">
      <span className="text-3xl" aria-hidden="true">✨</span>
      <h3 className="mt-3 text-lg font-bold text-gray-900 dark:text-gray-100">No {getFilterLabel(filter).toLowerCase()} topics right now</h3>
      <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">Try another filter to explore your complete analysis.</p>
      <button type="button" onClick={onClear} className="mt-5 min-h-10 rounded-xl bg-gray-950 dark:bg-white px-4 py-2 text-sm font-bold text-white dark:text-gray-950 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2">
        Show all topics
      </button>
    </div>
  )
}

function matchesFilter(score: number, filter: FocusFilter) {
  if (filter === 'focus') return score < 0.4
  if (filter === 'developing') return score >= 0.4 && score < 0.7
  if (filter === 'strong') return score >= 0.7
  return true
}

function getFilterLabel(filter: FocusFilter) {
  return FILTERS.find((option) => option.value === filter)?.label ?? 'Selected'
}

type FocusFilter = 'all' | 'focus' | 'developing' | 'strong'

interface FocusFilterOption {
  value: FocusFilter
  label: string
}
