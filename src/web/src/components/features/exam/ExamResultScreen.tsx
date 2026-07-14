import { Card } from '../../ui/Card'
import { Button } from '../../ui/Button'
import { Badge } from '../../ui/Badge'
import type { ExamResult } from '../../../types/Exam'

interface ExamResultScreenProps {
  result: ExamResult
  onTryAgain: () => void
}

export function ExamResultScreen({ result, onTryAgain }: ExamResultScreenProps) {
  const percentage = Math.round(result.score_percentage)

  return (
    <div className="space-y-6">
      {/* Score card */}
      <Card padding="lg" className="text-center">
        <div className="mb-4">
          {result.passed ? (
            <span className="text-5xl">🏆</span>
          ) : (
            <span className="text-5xl">📚</span>
          )}
        </div>
        <h2 className="text-3xl font-bold text-gray-900">
          {result.passed ? 'Congratulations!' : 'Keep Studying!'}
        </h2>
        <p className="mt-2 text-gray-600">
          {result.passed
            ? 'You passed the exam simulation!'
            : 'You didn\'t pass this time, but every attempt helps you learn.'}
        </p>

        <div className="mt-6 grid grid-cols-2 gap-4 sm:grid-cols-4">
          <div className="rounded-xl bg-purple-50 p-4">
            <div className="text-3xl font-bold text-purple-600">{percentage}%</div>
            <div className="text-sm text-gray-600">Score</div>
          </div>
          <div className="rounded-xl bg-green-50 p-4">
            <div className="text-3xl font-bold text-green-600">
              {result.correct_answers}/{result.total_questions}
            </div>
            <div className="text-sm text-gray-600">Correct</div>
          </div>
          <div className="rounded-xl bg-amber-50 p-4">
            <div className="text-3xl font-bold text-amber-600">{result.xp_earned}</div>
            <div className="text-sm text-gray-600">XP Earned</div>
          </div>
          <div className="rounded-xl bg-red-50 p-4">
            <div className="text-3xl font-bold text-red-600">{result.hearts_remaining}</div>
            <div className="text-sm text-gray-600">Hearts Left</div>
          </div>
        </div>
      </Card>

      {/* Answer breakdown */}
      <Card padding="lg">
        <h3 className="mb-4 text-lg font-bold text-gray-900">Answer Review</h3>
        <div className="space-y-3">
          {result.answers.map((answer) => (
            <div
              key={answer.question_id}
              className={`rounded-xl border p-4 ${
                answer.is_correct
                  ? 'border-green-200 bg-green-50'
                  : 'border-red-200 bg-red-50'
              }`}
            >
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <span className="font-bold text-gray-900">
                      Q{answer.question_number}
                    </span>
                    {answer.is_correct ? (
                      <Badge variant="success">✓ Correct</Badge>
                    ) : (
                      <Badge variant="error">✗ Incorrect</Badge>
                    )}
                  </div>
                  <p className="mt-1 text-sm text-gray-700 line-clamp-2">
                    {answer.question_text}
                  </p>
                  {!answer.is_correct && (
                    <div className="mt-2 text-sm">
                      <span className="text-red-600">Your answer: {answer.user_answer}</span>
                      <span className="mx-2 text-gray-400">|</span>
                      <span className="text-green-600">Correct: {answer.correct_answer}</span>
                    </div>
                  )}
                  {answer.explanation && (
                    <p className="mt-2 text-sm text-gray-600 italic">
                      {answer.explanation}
                    </p>
                  )}
                </div>
              </div>
            </div>
          ))}
        </div>
      </Card>

      {/* Actions */}
      <div className="flex justify-center gap-4">
        <Button size="lg" onClick={onTryAgain}>
          Try Another Exam
        </Button>
      </div>
    </div>
  )
}
