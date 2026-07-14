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
          <span className="text-sm font-bold text-purple-600">
            Q{question.question_number}
          </span>
          {!question.is_required && (
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
      <div className="mb-6 text-gray-900 leading-relaxed">{question.question_text}</div>

      {/* Choices */}
      <div className="space-y-3">
        {question.choices.map((choice) => {
          const isSelected = selectedAnswer === choice.label
          const isCorrect = result?.is_correct && isSelected
          const isWrong = result && !result.is_correct && isSelected
          const showCorrectAnswer = result && !result.is_correct && choice.label === result.correct_answer

          let borderColor = 'border-gray-200'
          let bgColor = 'bg-white'
          if (isSelected && !isSubmitted) {
            borderColor = 'border-purple-500'
            bgColor = 'bg-purple-50'
          } else if (isCorrect) {
            borderColor = 'border-green-500'
            bgColor = 'bg-green-50'
          } else if (isWrong) {
            borderColor = 'border-red-500'
            bgColor = 'bg-red-50'
          } else if (showCorrectAnswer) {
            borderColor = 'border-green-500'
            bgColor = 'bg-green-50'
          }

          return (
            <button
              key={choice.label}
              onClick={() => !isSubmitted && onSelect(choice.label)}
              disabled={isSubmitted}
              className={`w-full text-left rounded-xl border-2 p-4 transition-all ${borderColor} ${bgColor} ${
                !isSubmitted ? 'hover:border-gray-300 cursor-pointer' : 'cursor-default'
              }`}
            >
              <div className="flex items-start gap-3">
                <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full border border-gray-300 text-xs font-medium">
                  {choice.label}
                </span>
                <span className="text-gray-900">{choice.text}</span>
              </div>
            </button>
          )
        })}
      </div>

      {/* Feedback after submission */}
      {result && (
        <div
          className={`mt-4 rounded-xl p-4 ${
            result.is_correct
              ? 'border border-green-200 bg-green-50 text-green-700'
              : 'border border-red-200 bg-red-50 text-red-700'
          }`}
        >
          <div className="flex items-center gap-2 font-medium">
            {result.is_correct ? '✅ Correct!' : '❌ Incorrect'}
            {!result.is_correct && (
              <span className="text-sm">(Answer: {result.correct_answer})</span>
            )}
          </div>
          {result.explanation && (
            <p className="mt-2 text-sm opacity-90">{result.explanation}</p>
          )}
        </div>
      )}
    </Card>
  )
}
