import { AchievementBadge } from './AchievementBadge'
import type { Achievement } from '../../../types/Achievement'

const SKELETON_BADGE_COUNT = 3

interface AchievementsSectionProps {
  achievements: Achievement[]
  unlockedCount: number
  loading: boolean
  error: string | null
  onRetry: () => void
}

export function AchievementsSection({
  achievements,
  unlockedCount,
  loading,
  error,
  onRetry,
}: AchievementsSectionProps) {
  return (
    <section
      className="learning-feature-enter rounded-3xl border border-gray-200/80 bg-white p-5 shadow-sm sm:p-6 dark:border-gray-700 dark:bg-gray-800"
      aria-labelledby="achievements-title"
      aria-busy={loading}
    >
      <div className="flex items-center justify-between gap-4">
        <div>
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-purple-600 dark:text-purple-400">
            Milestones
          </p>
          <h2
            id="achievements-title"
            className="mt-1 text-xl font-bold text-gray-950 dark:text-gray-50"
          >
            Achievements
          </h2>
        </div>
        {!loading && !error && achievements.length > 0 && (
          <span className="text-sm font-semibold text-gray-400 dark:text-gray-500">
            {unlockedCount} of {achievements.length} unlocked
          </span>
        )}
      </div>

      <AchievementsBody
        achievements={achievements}
        loading={loading}
        error={error}
        onRetry={onRetry}
      />
    </section>
  )
}

interface AchievementsBodyProps {
  achievements: Achievement[]
  loading: boolean
  error: string | null
  onRetry: () => void
}

function AchievementsBody({ achievements, loading, error, onRetry }: AchievementsBodyProps) {
  if (loading) {
    return (
      <div className="mt-5 grid gap-3 md:grid-cols-3" data-testid="achievements-loading">
        {Array.from({ length: SKELETON_BADGE_COUNT }, (_, slot) => (
          <div
            key={`skeleton-${slot}`}
            className="h-36 animate-pulse rounded-2xl bg-gray-100 dark:bg-gray-700"
          />
        ))}
      </div>
    )
  }

  if (error) {
    return (
      <div
        role="alert"
        className="mt-5 flex flex-col items-start gap-3 rounded-2xl border border-rose-200 bg-rose-50 p-4 text-sm text-rose-700 dark:border-rose-800 dark:bg-rose-900/20 dark:text-rose-300"
      >
        <p>We couldn&apos;t load your achievements right now.</p>
        <button
          type="button"
          onClick={onRetry}
          className="min-h-11 rounded-xl bg-rose-600 px-4 py-2 font-semibold text-white transition-colors hover:bg-rose-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-rose-500 focus-visible:ring-offset-2"
        >
          Try again
        </button>
      </div>
    )
  }

  if (achievements.length === 0) {
    return (
      <p className="mt-5 rounded-2xl bg-gray-50 p-4 text-sm text-gray-500 dark:bg-gray-900/60 dark:text-gray-400">
        No achievements yet. Complete a quiz to start earning badges.
      </p>
    )
  }

  return (
    <div className="mt-5 grid gap-3 sm:grid-cols-2 md:grid-cols-3">
      {achievements.map((achievement) => (
        <AchievementBadge key={achievement.id} achievement={achievement} />
      ))}
    </div>
  )
}
