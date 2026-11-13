import { cn } from '../../lib/cn'

export type OwlMood = 'idle' | 'happy' | 'encouraging'

interface OwlMascotProps {
  mood?: OwlMood
  message?: string
  className?: string
}

/** Per-mood animation (only when the user allows motion) and decorative accent emoji. */
const MOOD_STYLES: Record<OwlMood, { animation: string; accent: string | null }> = {
  idle: { animation: 'motion-safe:animate-owl-idle', accent: null },
  happy: { animation: 'motion-safe:animate-owl-happy', accent: '✨' },
  encouraging: { animation: 'motion-safe:animate-owl-encouraging', accent: '💪' },
}

export function OwlMascot({ mood = 'idle', message, className }: OwlMascotProps) {
  const { animation, accent } = MOOD_STYLES[mood]

  return (
    <div
      data-testid="owl-mascot"
      data-mood={mood}
      className={cn('flex flex-col items-center gap-3', className)}
    >
      {message && (
        <p className="relative max-w-xs rounded-2xl bg-purple-50 px-4 py-2 text-sm font-medium text-purple-900 shadow-sm ring-1 ring-purple-100 dark:bg-purple-900/40 dark:text-purple-100 dark:ring-purple-800">
          {message}
          <span
            aria-hidden="true"
            className="absolute -bottom-1.5 left-1/2 size-3 -translate-x-1/2 rotate-45 bg-purple-50 ring-1 ring-purple-100 [clip-path:polygon(100%_0,100%_100%,0_100%)] dark:bg-purple-900/40 dark:ring-purple-800"
          />
        </p>
      )}
      <div className="relative">
        <span
          aria-hidden="true"
          data-testid="owl-mascot-emoji"
          className={cn('inline-block text-5xl leading-none', animation)}
        >
          🦉
        </span>
        {accent && (
          <span aria-hidden="true" className="absolute -right-4 -top-2 text-xl">
            {accent}
          </span>
        )}
      </div>
    </div>
  )
}
