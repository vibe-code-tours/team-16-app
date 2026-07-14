import { Card } from '../../ui/Card'
import { Button } from '../../ui/Button'
import { Badge } from '../../ui/Badge'
import type { ExamResult } from '../../../types/Exam'

interface ExamResultScreenProps {
  result: ExamResult
  onTryAgain: () => void
}

export function ExamResultScreen({ result, onTryAgain }: ExamResultScreenProps) {
  const percentage = Math.round(result.scorePercentage)

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
              {result.correctAnswers}/{result.totalQuestions}
            </div>
            <div className="text-sm text-gray-600">Correct</div>
          </div>
          <div className="rounded-xl bg-amber-50 p-4">
            <div className="text-3xl font-bold text-amber-600">{result.xpEarned}</div>
            <div className="text-sm text-gray-600">XP Earned</div>
          </div>
          <div className="rounded-xl bg-red-50 p-4">
            <div className="text-3xl font-bold text-red-600">{result.heartsRemaining}</div>
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
              key={answer.questionId}
              className={`rounded-xl border p-4 ${
                answer.isCorrect
                  ? 'border-green-200 bg-green-50'
                  : 'border-red-200 bg-red-50'
              }`}
            >
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <span className="font-bold text-gray-900">
                      Q{answer.questionNumber}
                    </span>
                    {answer.isCorrect ? (
                      <Badge variant="success">✓ Correct</Badge>
                    ) : (
                      <Badge variant="error">✗ Incorrect</Badge>
                    )}
                  </div>
                  <p className="mt-1 text-sm text-gray-700 line-clamp-2">
                    {answer.questionText}
                  </p>
                  {!answer.isCorrect && (
                    <div className="mt-2 text-sm">
                      <span className="text-red-600">Your answer: {answer.userAnswer}</span>
                      <span className="mx-2 text-gray-400">|</span>
                      <span className="text-green-600">Correct: {answer.correctAnswer}</span>
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
