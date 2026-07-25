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
        <h2 className="text-3xl font-bold text-gray-900 dark:text-gray-100">
          {result.passed ? 'Congratulations!' : 'Keep Studying!'}
        </h2>
        <p className="mt-2 text-gray-600 dark:text-gray-400">
          {result.passed
            ? 'You passed the exam simulation!'
            : "You didn't pass this time, but every attempt helps you learn."}
        </p>

        <div className="mt-6 grid grid-cols-3 gap-4 sm:grid-cols-3">
          <div className="rounded-xl bg-purple-50 dark:bg-purple-900/30 p-4">
            <div className="text-3xl font-bold text-purple-600 dark:text-purple-400">{percentage}%</div>
            <div className="text-sm text-gray-600 dark:text-gray-400">Score</div>
          </div>
          <div className="rounded-xl bg-green-50 dark:bg-green-900/30 p-4">
            <div className="text-3xl font-bold text-green-600 dark:text-green-400">
              {result.correctAnswers}/{result.totalQuestions}
            </div>
            <div className="text-sm text-gray-600 dark:text-gray-400">Correct</div>
          </div>
          <div className="rounded-xl bg-amber-50 dark:bg-amber-900/30 p-4">
            <div className="text-3xl font-bold text-amber-600 dark:text-amber-400">{result.xpEarned}</div>
            <div className="text-sm text-gray-600 dark:text-gray-400">XP Earned</div>
          </div>
        </div>
      </Card>

      {/* Answer breakdown */}
      <Card padding="lg">
        <h3 className="mb-4 text-lg font-bold text-gray-900 dark:text-gray-100">Answer Review</h3>
        <div className="space-y-3">
          {result.answers.map((answer) => (
            <div
              key={answer.questionId}
              className={`rounded-xl border p-4 ${
                answer.isCorrect
                  ? 'border-green-200 dark:border-green-800 bg-green-50 dark:bg-green-900/30'
                  : 'border-red-200 dark:border-red-800 bg-red-50 dark:bg-red-900/30'
              }`}
            >
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <span className="font-bold text-gray-900 dark:text-gray-100">
                      Q{answer.questionNumber}
                    </span>
                    {answer.isCorrect ? (
                      <Badge variant="success">✓ Correct</Badge>
                    ) : (
                      <Badge variant="error">✗ Incorrect</Badge>
                    )}
                  </div>
                  <p className="mt-1 text-sm text-gray-700 dark:text-gray-300 line-clamp-2">
                    {answer.questionText}
                  </p>
                  {!answer.isCorrect && (
                    <div className="mt-2 text-sm">
                      <span className="text-red-600 dark:text-red-400">Your answer: {answer.userAnswer}</span>
                      <span className="mx-2 text-gray-400 dark:text-gray-500">|</span>
                      <span className="text-green-600 dark:text-green-400">Correct: {answer.correctAnswer}</span>
                    </div>
                  )}
                  {answer.explanation && (
                    <p className="mt-2 text-sm text-gray-600 dark:text-gray-400 italic">
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
        <Button size="lg" onClick={onTryAgain} aria-label="Take Another Exam">
          Take Another Exam
        </Button>
      </div>
    </div>
  )
}
