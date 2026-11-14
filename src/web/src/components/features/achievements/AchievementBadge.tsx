import { cn } from '../../../lib/cn'
import { achievementPercent } from '../../../lib/achievementProgress'
import type { Achievement } from '../../../types/Achievement'

interface AchievementBadgeProps {
  achievement: Achievement
}

export function AchievementBadge({ achievement }: AchievementBadgeProps) {
  const percent = achievementPercent(achievement)
  const { unlocked } = achievement

  return (
    <article
      aria-label={`${achievement.title}, ${unlocked ? 'unlocked' : 'locked'}`}
      className={cn(
        'group rounded-2xl border p-4 transition-all duration-200',
        unlocked
          ? 'border-purple-200 bg-purple-50/60 hover:border-purple-300 dark:border-purple-700 dark:bg-purple-900/20'
          : 'border-gray-100 bg-gray-50/80 dark:border-gray-700 dark:bg-gray-900/80',
      )}
    >
      <div className="flex items-start justify-between gap-2">
        <span
          className={cn(
            'flex size-11 items-center justify-center rounded-2xl text-2xl ring-1 transition-transform duration-200',
            unlocked
              ? 'bg-amber-100 ring-amber-200 group-hover:-rotate-6 group-hover:scale-110 dark:bg-amber-900/30 dark:ring-amber-700'
              : 'bg-gray-100 opacity-50 grayscale ring-gray-200 dark:bg-gray-800 dark:ring-gray-700',
          )}
          aria-hidden="true"
        >
          {achievement.icon}
        </span>
        <span
          className={cn(
            'rounded-full px-2 py-0.5 text-[11px] font-semibold',
            unlocked
              ? 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/30 dark:text-emerald-400'
              : 'bg-gray-100 text-gray-500 dark:bg-gray-800 dark:text-gray-400',
          )}
        >
          {unlocked ? 'Unlocked' : 'Locked'}
        </span>
      </div>
      <h3
        className={cn(
          'mt-4 font-bold',
          unlocked ? 'text-gray-900 dark:text-gray-100' : 'text-gray-600 dark:text-gray-300',
        )}
      >
        {achievement.title}
      </h3>
      <p className="mt-1 text-xs leading-5 text-gray-500 dark:text-gray-400">
        {achievement.description}
      </p>
      {!unlocked && (
        <div className="mt-3">
          <div
            className="h-1.5 overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700"
            role="progressbar"
            aria-label={`${achievement.title} progress`}
            aria-valuemin={0}
            aria-valuemax={achievement.target}
            aria-valuenow={achievement.progress}
          >
            {/* Dynamic width cannot be expressed as a static Tailwind class. */}
            <div
              className="h-full rounded-full bg-purple-500"
              style={{ width: `${percent}%` }}
            />
          </div>
          <p className="mt-1.5 text-[11px] font-semibold text-gray-500 dark:text-gray-400">
            {achievement.progress} / {achievement.target}
          </p>
        </div>
      )}
    </article>
  )
}
