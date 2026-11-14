import { CalendarDays } from 'lucide-react'
import { useActivity } from '../../hooks/useActivity'
import { cn } from '../../lib/cn'
import type { DailyActivity } from '../../types/Activity'

const ACTIVITY_DAYS = 7
const MIN_VISIBLE_BAR_PERCENT = 4
const BAR_ANIMATION_STEP_MS = 45

/** Weekly XP chart on the student profile, backed by GET /api/v1/me/activity. */
export function WeeklyActivityChart() {
  const { activity, loading, error, refetch } = useActivity(ACTIVITY_DAYS)
  const totalXp = activity.reduce((sum, day) => sum + day.xpEarned, 0)
  const totalQuestions = activity.reduce((sum, day) => sum + day.questionsAnswered, 0)
  const hasActivity = activity.some((day) => day.xpEarned > 0 || day.questionsAnswered > 0)

  return (
    <section
      className="learning-feature-enter rounded-3xl border border-gray-200/80 bg-white p-5 shadow-sm sm:p-6 dark:border-gray-700 dark:bg-gray-800"
      aria-labelledby="weekly-activity-title"
    >
      <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
        <div>
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-purple-600 dark:text-purple-400">
            Momentum
          </p>
          <h2 id="weekly-activity-title" className="mt-1 text-xl font-bold text-gray-950 dark:text-gray-50">
            Weekly activity
          </h2>
          <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">
            {hasActivity
              ? `You answered ${totalQuestions} ${totalQuestions === 1 ? 'question' : 'questions'} and earned ${totalXp} XP this week. Keep it going!`
              : 'Activity data will appear here once you start studying.'}
          </p>
        </div>
        <span className="inline-flex w-fit items-center gap-2 rounded-full bg-purple-50 px-3 py-1.5 text-xs font-semibold text-purple-700 dark:bg-purple-900/30 dark:text-purple-400">
          <CalendarDays className="size-3.5" aria-hidden="true" />
          Last 7 days
        </span>
      </div>

      <div className="mt-8 h-48">
        {loading ? (
          <ActivityLoading />
        ) : error ? (
          <ActivityError onRetry={refetch} />
        ) : hasActivity ? (
          <ActivityBars activity={activity} />
        ) : (
          <div className="flex h-full items-center justify-center text-sm text-gray-400 dark:text-gray-500">
            No activity data yet
          </div>
        )}
      </div>
    </section>
  )
}

function ActivityLoading() {
  return (
    <div className="grid h-full grid-cols-7 items-end gap-2 sm:gap-4" role="status" aria-label="Loading activity">
      {Array.from({ length: ACTIVITY_DAYS }, (_, slot) => (
        <div key={`skeleton-${slot}`} className="h-full animate-pulse rounded-xl bg-purple-50 dark:bg-purple-900/30" />
      ))}
    </div>
  )
}

interface ActivityErrorProps {
  onRetry: () => void
}

function ActivityError({ onRetry }: ActivityErrorProps) {
  return (
    <div className="flex h-full flex-col items-center justify-center gap-3 text-sm" role="alert">
      <p className="text-gray-500 dark:text-gray-400">We couldn&apos;t load your activity.</p>
      <button
        type="button"
        onClick={onRetry}
        className="rounded-full bg-purple-600 px-4 py-1.5 text-xs font-semibold text-white hover:bg-purple-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-400"
      >
        Try again
      </button>
    </div>
  )
}

interface ActivityBarsProps {
  activity: DailyActivity[]
}

function ActivityBars({ activity }: ActivityBarsProps) {
  const maxXp = Math.max(...activity.map((day) => day.xpEarned), 1)
  const lastIndex = activity.length - 1

  return (
    <ul className="grid h-full grid-cols-7 items-end gap-2 sm:gap-4" aria-label="XP earned each day">
      {activity.map((day, index) => {
        const weekday = formatWeekday(day.date)
        const heightPercent = day.xpEarned > 0 ? Math.max((day.xpEarned / maxXp) * 100, MIN_VISIBLE_BAR_PERCENT) : 0
        const label = `${weekday}: ${day.xpEarned} XP, ${day.questionsAnswered} ${day.questionsAnswered === 1 ? 'question' : 'questions'}`
        return (
          <li key={day.date} className="group flex h-full flex-col items-center justify-end gap-2" aria-label={label} title={label}>
            <span className="text-xs font-bold text-purple-700 opacity-0 transition-opacity group-hover:opacity-100 dark:text-purple-400">
              {day.xpEarned} XP
            </span>
            <div className="relative flex w-full flex-1 items-end justify-center overflow-hidden rounded-xl bg-purple-50 dark:bg-purple-900/30">
              {/* Bar height and stagger depend on runtime data, so they cannot be Tailwind classes. */}
              <div
                className="learning-progress-reveal w-full rounded-xl bg-gradient-to-t from-purple-600 to-fuchsia-400 transition-all duration-200 group-hover:from-purple-700 group-hover:to-fuchsia-500"
                style={{ height: `${heightPercent}%`, animationDelay: `${index * BAR_ANIMATION_STEP_MS}ms` }}
              />
            </div>
            <span className={cn('text-xs font-semibold', index === lastIndex ? 'text-purple-700 dark:text-purple-400' : 'text-gray-400 dark:text-gray-500')}>
              {weekday}
            </span>
            <span className="text-[10px] text-gray-400 dark:text-gray-500">{day.questionsAnswered}q</span>
          </li>
        )
      })}
    </ul>
  )
}

/** Formats a `YYYY-MM-DD` date as a short weekday in local time (avoids the UTC shift of `new Date(iso)`). */
function formatWeekday(isoDate: string): string {
  const [year, month, dayOfMonth] = isoDate.split('-').map(Number)
  return new Date(year, month - 1, dayOfMonth).toLocaleDateString('en-US', { weekday: 'short' })
}
