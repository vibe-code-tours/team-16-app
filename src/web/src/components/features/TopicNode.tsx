import { Link } from 'react-router-dom'
import { cn } from '../../lib/cn'
import type { TopicCategory, TopicWithStatus } from '../../types/topic'

interface TopicNodeProps {
  topic: TopicWithStatus
  stepNumber: number
}

const CATEGORY_ACCENT: Record<TopicCategory, string> = {
  Technology: 'border-l-purple-500',
  Security: 'border-l-red-500',
  Management: 'border-l-blue-500',
  Strategy: 'border-l-emerald-500',
  Business: 'border-l-amber-500',
}

const CATEGORY_STEP_BG: Record<TopicCategory, string> = {
  Technology: 'bg-purple-100 text-purple-700',
  Security: 'bg-red-100 text-red-700',
  Management: 'bg-blue-100 text-blue-700',
  Strategy: 'bg-emerald-100 text-emerald-700',
  Business: 'bg-amber-100 text-amber-700',
}

export function TopicNode({ topic, stepNumber }: TopicNodeProps) {
  const { status, category, title, description, question_count, progress } = topic
  const isLocked = status === 'locked'
  const isCompleted = status === 'completed'
  const isInProgress = status === 'in_progress'

  const cardClasses = cn(
    'group flex items-center gap-4 rounded-2xl border border-gray-200 border-l-4 bg-white p-4 transition',
    CATEGORY_ACCENT[category],
    isLocked && 'border-l-gray-300 opacity-60',
    !isLocked && 'hover:border-gray-300 hover:shadow-sm'
  )

  const stepBadgeClasses = cn(
    'flex h-12 w-12 shrink-0 items-center justify-center rounded-xl text-sm font-bold',
    isLocked ? 'bg-gray-100 text-gray-400' : CATEGORY_STEP_BG[category]
  )

  const meta = isLocked
    ? 'Locked — clear the previous stop to unlock'
    : isCompleted
      ? `${progress?.questions_correct ?? question_count} / ${question_count} correct · Cleared`
      : isInProgress
        ? `${progress?.questions_answered ?? 0} / ${question_count} answered`
        : `${question_count} questions`

  const cardContent = (
    <div className={cardClasses}>
      <div className={stepBadgeClasses} aria-hidden="true">
        {isLocked ? <LockIcon className="h-5 w-5" /> : String(stepNumber).padStart(2, '0')}
      </div>
      <div className="min-w-0 flex-1">
        <div className="mb-0.5 flex items-center gap-2">
          <h3 className="truncate text-base font-semibold text-gray-900">{title}</h3>
          {isCompleted ? <CompletedBadge /> : null}
          {isInProgress ? <InProgressBadge /> : null}
        </div>
        <p className="line-clamp-2 text-xs text-gray-500">{description}</p>
        <p className="mt-1 text-xs font-medium text-gray-600">{meta}</p>
      </div>
      <ChevronIcon
        className={cn(
          'h-5 w-5 shrink-0 transition',
          isLocked
            ? 'text-gray-300'
            : 'text-gray-400 group-hover:translate-x-0.5 group-hover:text-gray-600'
        )}
        aria-hidden="true"
      />
    </div>
  )

  if (isLocked) {
    return (
      <div role="group" aria-label={`${title} — locked`} aria-disabled="true">
        {cardContent}
      </div>
    )
  }

  return (
    <Link
      to={`/map/${topic.id}`}
      aria-label={`Open ${title}`}
      className="block focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-400 focus-visible:ring-offset-2 rounded-2xl"
    >
      {cardContent}
    </Link>
  )
}

function CompletedBadge() {
  return (
    <span className="inline-flex items-center gap-1 rounded-full bg-emerald-100 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-emerald-700">
      <CheckIcon className="h-3 w-3" aria-hidden="true" />
      Done
    </span>
  )
}

function InProgressBadge() {
  return (
    <span className="rounded-full bg-purple-100 px-2 py-0.5 text-[10px] font-semibold uppercase tracking-wide text-purple-700">
      In progress
    </span>
  )
}

function LockIcon({ className }: { className?: string }) {
  return (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" className={className}>
      <path
        fillRule="evenodd"
        d="M10 1a4 4 0 0 0-4 4v3H5a2 2 0 0 0-2 2v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-7a2 2 0 0 0-2-2h-1V5a4 4 0 0 0-4-4Zm2 7V5a2 2 0 1 0-4 0v3h4Z"
        clipRule="evenodd"
      />
    </svg>
  )
}

function CheckIcon({ className }: { className?: string }) {
  return (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" className={className}>
      <path
        fillRule="evenodd"
        d="M16.7 5.3a1 1 0 0 1 0 1.4l-8 8a1 1 0 0 1-1.4 0l-4-4a1 1 0 1 1 1.4-1.4L8 12.6l7.3-7.3a1 1 0 0 1 1.4 0Z"
        clipRule="evenodd"
      />
    </svg>
  )
}

function ChevronIcon({ className }: { className?: string }) {
  return (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" className={className}>
      <path
        fillRule="evenodd"
        d="M7.3 4.3a1 1 0 0 1 1.4 0l5 5a1 1 0 0 1 0 1.4l-5 5a1 1 0 1 1-1.4-1.4L11.6 10 7.3 5.7a1 1 0 0 1 0-1.4Z"
        clipRule="evenodd"
      />
    </svg>
  )
}
