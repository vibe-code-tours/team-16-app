import { CalendarClock } from 'lucide-react'
import { MistakeRetryCard } from './MistakeRetryCard'
import type { Mistake } from '../../../types/Mistake'

interface DueTodaySectionProps {
  mistakes: Mistake[]
  onReviewed: (mistakeId: string) => Promise<void>
  onMissed: (questionId: string, selectedLabel: string) => Promise<void>
}

/** Spaced-review queue: mistakes whose next review date has arrived, shown above the full garden. */
export function DueTodaySection({ mistakes, onReviewed, onMissed }: DueTodaySectionProps) {
  return (
    <section
      aria-labelledby="due-today-heading"
      className="mb-6 overflow-hidden rounded-2xl border border-amber-200 bg-white shadow-sm dark:border-amber-800 dark:bg-gray-800"
    >
      <div className="flex items-center gap-2 border-b border-amber-100 bg-amber-50 px-6 py-4 dark:border-amber-900 dark:bg-amber-900/20">
        <CalendarClock aria-hidden="true" className="size-5 text-amber-600 dark:text-amber-400" />
        <h2 id="due-today-heading" className="text-lg font-bold text-gray-900 dark:text-gray-100">
          Due today ({mistakes.length})
        </h2>
      </div>
      {mistakes.length === 0 ? (
        <p className="px-6 py-4 text-sm text-gray-500 dark:text-gray-400">
          Nothing due right now. Reviewed mistakes come back after 1, 3, 7, then 14 days.
        </p>
      ) : (
        <div className="divide-y divide-gray-100 dark:divide-gray-700">
          {mistakes.map((mistake) => (
            <MistakeRetryCard key={mistake.id} mistake={mistake} onReviewed={onReviewed} onMissed={onMissed} />
          ))}
        </div>
      )}
    </section>
  )
}
