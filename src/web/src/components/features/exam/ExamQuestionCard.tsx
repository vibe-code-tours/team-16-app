import { Card } from '../../ui/Card'
import { Badge } from '../../ui/Badge'
import type { ExamQuestion } from '../../../types/Exam'
import type { ExamAnswerResult } from '../../../types/Exam'

interface ExamQuestionCardProps {
  question: ExamQuestion
  selectedAnswer: string | null
  isSubmitted: boolean
  result: ExamAnswerResult | null
  onSelect: (label: string) => void
}

export function ExamQuestionCard({
  question,
  selectedAnswer,
  isSubmitted,
  result,
  onSelect,
}: ExamQuestionCardProps) {
  return (
    <Card padding="lg">
      {/* Question header */}
      <div className="mb-4 flex items-start justify-between">
        <div className="flex items-center gap-2">
          <span className="text-sm font-bold text-purple-600 dark:text-purple-400">
            Q{question.questionNumber}
          </span>
          {!question.isRequired && (
            <Badge variant="warning">Optional</Badge>
          )}
          <Badge
            variant={
              question.difficulty === 'easy'
                ? 'success'
                : question.difficulty === 'hard'
                  ? 'error'
                  : 'default'
            }
          >
            {question.difficulty}
          </Badge>
        </div>
      </div>

      {/* Question text */}
      <div className="mb-6 text-gray-900 dark:text-gray-100 leading-relaxed">{question.questionText}</div>

      {/* Choices */}
      <div className="space-y-3">
        {question.choices.map((choice) => {
          const isSelected = selectedAnswer === choice.label
          let borderColor = 'border-gray-200 dark:border-gray-700'
          let bgColor = 'bg-white dark:bg-gray-800'
          if (isSelected) {
            borderColor = 'border-purple-500'
            bgColor = 'bg-purple-50 dark:bg-purple-900/30'
          }

          return (
            <button
              key={choice.label}
              onClick={() => !isSubmitted && onSelect(choice.label)}
              disabled={isSubmitted}
              className={`w-full text-left rounded-xl border-2 p-4 transition-all ${borderColor} ${bgColor} ${
                !isSubmitted ? 'hover:border-gray-300 dark:hover:border-gray-600 cursor-pointer' : 'cursor-default'
              }`}
            >
              <div className="flex items-start gap-3">
                <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full border border-gray-300 dark:border-gray-600 text-xs font-medium text-gray-700 dark:text-gray-300">
                  {choice.label}
                </span>
                <span className="text-gray-900 dark:text-gray-100">{choice.text}</span>
              </div>
            </button>
          )
        })}
      </div>

      {/* During an exam, acknowledge persistence without disclosing correctness. */}
      {result && (
        <div className="mt-4 rounded-xl border border-purple-200 bg-purple-50 p-4 text-purple-700 dark:border-purple-800 dark:bg-purple-900/30 dark:text-purple-300">
          <div className="font-medium">Answer recorded</div>
          <p className="mt-1 text-sm">Correct answers are shown after you finish the exam.</p>
        </div>
      )}
    </Card>
  )
}
