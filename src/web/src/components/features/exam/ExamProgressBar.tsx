import type { ExamQuestion } from '../../../types/Exam'

interface ExamProgressBarProps {
  questions: ExamQuestion[]
  currentIndex: number
  answers: Record<string, { selected: string | null; submitted: boolean; result: { isCorrect: boolean } | null }>
  onGoTo: (index: number) => void
}

export function ExamProgressBar({
  questions,
  currentIndex,
  answers,
  onGoTo,
}: ExamProgressBarProps) {
  const progress = ((currentIndex + 1) / questions.length) * 100

  return (
    <div className="space-y-2">
      {/* Progress bar */}
      <div className="h-2 overflow-hidden rounded-full bg-gray-200">
        <div
          className="h-full rounded-full bg-purple-600 transition-all duration-300"
          style={{ width: `${progress}%` }}
        />
      </div>

      {/* Question indicators */}
      <div className="flex flex-wrap gap-1">
        {questions.map((q, index) => {
          const answer = answers[q.id]
          let color = 'bg-gray-200' // unanswered
          if (answer?.submitted) {
            color = answer.result?.isCorrect ? 'bg-green-500' : 'bg-red-500'
          } else if (answer?.selected) {
            color = 'bg-purple-300'
          }

          return (
            <button
              key={q.id}
              onClick={() => onGoTo(index)}
              className={`h-6 w-6 rounded text-xs font-medium text-white transition-colors ${color} ${
                index === currentIndex ? 'ring-2 ring-purple-600 ring-offset-1' : ''
              }`}
            >
              {q.questionNumber}
            </button>
          )
        })}
      </div>
    </div>
  )
}
