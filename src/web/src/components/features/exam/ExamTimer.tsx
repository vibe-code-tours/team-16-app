interface ExamTimerProps {
  timeRemaining: number
}

export function ExamTimer({ timeRemaining }: ExamTimerProps) {
  const minutes = Math.floor(timeRemaining / 60)
  const seconds = timeRemaining % 60
  const isLow = timeRemaining < 300 // Under 5 minutes
  const isCritical = timeRemaining < 60 // Under 1 minute

  return (
    <div
      className={`font-mono text-lg font-bold ${
        isCritical
          ? 'text-red-600 animate-pulse'
          : isLow
            ? 'text-amber-600'
            : 'text-gray-900'
      }`}
    >
      {String(minutes).padStart(2, '0')}:{String(seconds).padStart(2, '0')}
    </div>
  )
}
