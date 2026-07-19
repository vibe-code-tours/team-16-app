interface ExamTimerProps {
  timeRemaining: number
}

export function ExamTimer({ timeRemaining }: ExamTimerProps) {
  const minutes = Math.floor(timeRemaining / 60)
  const seconds = timeRemaining % 60
  const isLow = timeRemaining < 300 // Under 5 minutes
  const isCritical = timeRemaining < 60 // Under 1 minute

  const timeString = `${String(minutes).padStart(2, '0')}:${String(seconds).padStart(2, '0')}`
  const ariaLabel = isCritical
    ? `Less than 1 minute remaining: ${timeString}`
    : isLow
      ? `Less than 5 minutes remaining: ${timeString}`
      : `Time remaining: ${timeString}`

  return (
    <div
      role="timer"
      aria-live="polite"
      aria-atomic="true"
      aria-label={ariaLabel}
      className={`font-mono text-lg font-bold ${
        isCritical
          ? 'text-red-600 animate-pulse'
          : isLow
            ? 'text-amber-600'
            : 'text-gray-900'
      }`}
    >
      {timeString}
    </div>
  )
}
