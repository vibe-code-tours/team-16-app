import { cn } from '../../lib/cn'
import { getProgressWidthClass } from '../../lib/progressWidth'
import { Badge } from '../ui/Badge'
import { Button } from '../ui/Button'

const DAILY_GOAL_QUESTIONS = 10

interface DailyGoalCardProps {
  questionsAnswered: number
  isLoading: boolean
  error: string | null
  onRetry: () => void
}

/** Today's quest: answer a fixed number of questions per day. */
export function DailyGoalCard({ questionsAnswered, isLoading, error, onRetry }: DailyGoalCardProps) {
  if (isLoading) {
    return (
      <div className="rounded-2xl border border-purple-100 dark:border-purple-800 bg-white/80 dark:bg-gray-800/80 p-4" role="status" aria-label="Loading today's goal">
        <p className="text-sm font-semibold text-gray-500 dark:text-gray-400">— / {DAILY_GOAL_QUESTIONS} questions today</p>
        <div className="mt-2 h-2 animate-pulse rounded-full bg-gray-200 dark:bg-gray-700" aria-hidden="true" />
      </div>
    )
  }

  if (error) {
    return (
      <div className="rounded-2xl border border-red-200 dark:border-red-800 bg-red-50 dark:bg-red-900/30 p-4 text-sm text-red-700 dark:text-red-400" role="alert">
        <p>Couldn&apos;t load today&apos;s goal.</p>
        <Button onClick={onRetry} variant="outline" size="sm" className="mt-2">
          Retry
        </Button>
      </div>
    )
  }

  const isComplete = questionsAnswered >= DAILY_GOAL_QUESTIONS
  const progressValue = Math.min(questionsAnswered, DAILY_GOAL_QUESTIONS)
  const percent = (progressValue / DAILY_GOAL_QUESTIONS) * 100

  return (
    <div
      className={cn(
        'rounded-2xl border p-4',
        isComplete
          ? 'border-green-200 dark:border-green-800 bg-green-50 dark:bg-green-900/20'
          : 'border-purple-100 dark:border-purple-800 bg-white/80 dark:bg-gray-800/80'
      )}
    >
      <div className="flex items-center justify-between gap-3">
        <p className="text-sm font-semibold text-gray-900 dark:text-gray-100">
          {questionsAnswered} / {DAILY_GOAL_QUESTIONS} questions today
        </p>
        {isComplete ? <Badge variant="success">Goal complete</Badge> : null}
      </div>
      <div
        className="mt-2 h-2 overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700"
        role="progressbar"
        aria-label="Daily goal progress"
        aria-valuemin={0}
        aria-valuemax={DAILY_GOAL_QUESTIONS}
        aria-valuenow={progressValue}
        aria-valuetext={`${questionsAnswered} of ${DAILY_GOAL_QUESTIONS} questions answered today`}
      >
        <div
          className={cn(
            'h-full rounded-full transition-all duration-300',
            isComplete ? 'bg-green-500' : 'bg-purple-600',
            getProgressWidthClass(percent)
          )}
        />
      </div>
      <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
        {isComplete
          ? 'Quest cleared! Anything more today is bonus practice.'
          : `${DAILY_GOAL_QUESTIONS - questionsAnswered} more to clear today's quest.`}
      </p>
    </div>
  )
}
