import { Link } from 'react-router-dom'
import { Award, ChevronRight } from 'lucide-react'
import { achievementPercent } from '../../../lib/achievementProgress'
import type { Achievement } from '../../../types/Achievement'

const ROUTE_QUIZZES = '/quizzes'

interface NextGoalCardProps {
  goal: Achievement | null
  hasAchievements: boolean
  loading: boolean
  error: string | null
}

export function NextGoalCard({ goal, hasAchievements, loading, error }: NextGoalCardProps) {
  return (
    <section
      className="learning-feature-enter overflow-hidden rounded-3xl border border-amber-200 bg-gradient-to-br from-amber-50 to-orange-50 p-5 shadow-sm sm:p-6 dark:border-amber-700 dark:bg-gray-800"
      aria-labelledby="next-goal-title"
      aria-busy={loading}
    >
      <span className="inline-flex items-center gap-1.5 rounded-full bg-white/80 px-2.5 py-1 text-xs font-semibold text-amber-700 ring-1 ring-amber-200 dark:bg-gray-700 dark:text-amber-400 dark:ring-amber-700">
        <Award className="size-3.5" aria-hidden="true" />
        Next goal
      </span>

      <NextGoalBody goal={goal} hasAchievements={hasAchievements} loading={loading} error={error} />

      <Link
        to={ROUTE_QUIZZES}
        className="group mt-5 inline-flex min-h-11 w-full items-center justify-center gap-2 rounded-xl bg-gray-950 px-4 py-2.5 text-sm font-bold text-white transition-all hover:-translate-y-0.5 hover:bg-purple-700 hover:shadow-lg focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2 dark:bg-white dark:text-gray-900 dark:hover:bg-purple-600"
      >
        Continue learning
        <ChevronRight
          className="size-4 transition-transform group-hover:translate-x-0.5"
          aria-hidden="true"
        />
      </Link>
    </section>
  )
}

function NextGoalBody({ goal, hasAchievements, loading, error }: NextGoalCardProps) {
  if (loading) {
    return (
      <div className="mt-3 space-y-3" data-testid="next-goal-loading">
        <div className="h-5 w-2/3 animate-pulse rounded bg-amber-200/70 dark:bg-gray-700" />
        <div className="h-2 animate-pulse rounded-full bg-amber-200/70 dark:bg-gray-700" />
      </div>
    )
  }

  if (error) {
    return (
      <GoalMessage title="Next goal unavailable" detail="We couldn't load your achievement progress." />
    )
  }

  if (!goal) {
    return hasAchievements ? (
      <GoalMessage title="All badges unlocked" detail="You've earned every achievement. Keep the streak going!" />
    ) : (
      <GoalMessage title="Your first badge awaits" detail="Complete a quiz to start earning achievements." />
    )
  }

  const percent = achievementPercent(goal)
  const remaining = Math.max(goal.target - goal.progress, 0)

  return (
    <>
      <div className="mt-3 flex items-start justify-between gap-3">
        <div>
          <h2 id="next-goal-title" className="text-lg font-bold text-gray-950 dark:text-gray-50">
            {goal.title}
          </h2>
          <p className="mt-1 text-sm leading-6 text-gray-600 dark:text-gray-400">
            {goal.description}. {remaining} more to unlock.
          </p>
        </div>
        <span className="text-4xl" aria-hidden="true">
          {goal.icon}
        </span>
      </div>
      <div
        className="mt-5 h-2 overflow-hidden rounded-full bg-amber-200/70 dark:bg-amber-900/30"
        role="progressbar"
        aria-label={`${goal.title} achievement progress`}
        aria-valuemin={0}
        aria-valuemax={goal.target}
        aria-valuenow={goal.progress}
      >
        {/* Dynamic width cannot be expressed as a static Tailwind class. */}
        <div
          className="learning-progress-reveal h-full rounded-full bg-gradient-to-r from-amber-500 to-orange-500"
          style={{ width: `${percent}%` }}
        />
      </div>
      <div className="mt-2 flex items-center justify-between text-xs font-semibold text-amber-800 dark:text-amber-400">
        <span>
          {goal.progress} of {goal.target}
        </span>
        <span>{percent}%</span>
      </div>
    </>
  )
}

interface GoalMessageProps {
  title: string
  detail: string
}

function GoalMessage({ title, detail }: GoalMessageProps) {
  return (
    <div className="mt-3">
      <h2 id="next-goal-title" className="text-lg font-bold text-gray-950 dark:text-gray-50">
        {title}
      </h2>
      <p className="mt-1 text-sm leading-6 text-gray-600 dark:text-gray-400">{detail}</p>
    </div>
  )
}
