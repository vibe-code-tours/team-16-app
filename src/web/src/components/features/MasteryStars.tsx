import { cn } from '../../lib/cn'
import { MAX_MASTERY_STARS, getMasteryStars } from '../../lib/masteryStars'

interface MasteryStarsProps {
  masteryScore: number
  questionsSeen: number
}

const STAR_SLOTS = Array.from({ length: MAX_MASTERY_STARS }, (_, index) => index)

export function MasteryStars({ masteryScore, questionsSeen }: MasteryStarsProps) {
  const stars = getMasteryStars(masteryScore, questionsSeen)

  return (
    <span
      role="img"
      aria-label={`Mastery: ${stars} of ${MAX_MASTERY_STARS} stars`}
      className="inline-flex items-center gap-0.5"
    >
      {STAR_SLOTS.map((slot) => (
        <StarIcon
          key={slot}
          className={cn(
            'h-3.5 w-3.5',
            slot < stars ? 'text-amber-400' : 'text-gray-300 dark:text-gray-600'
          )}
        />
      ))}
    </span>
  )
}

function StarIcon({ className }: { className?: string }) {
  return (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" className={className} aria-hidden="true">
      <path d="M10 1.5l2.6 5.3 5.9.9-4.3 4.1 1 5.8L10 14.9l-5.2 2.7 1-5.8L1.5 7.7l5.9-.9L10 1.5Z" />
    </svg>
  )
}
