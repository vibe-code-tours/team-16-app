import { useState } from 'react'
import { ChoiceList } from '../ChoiceList'
import { Button } from '../../ui/Button'
import type { Choice } from '../../../types/Quiz'
import type { Mistake } from '../../../types/Mistake'

type CardMode = 'review' | 'retry' | 'wrong'

interface MistakeRetryCardProps {
  mistake: Mistake
  /** Marks the mistake reviewed; called on a correct retry or a manual review. */
  onReviewed: (mistakeId: string) => Promise<void>
  /** Records a wrong retry, which resets the mistake's review interval. */
  onMissed: (questionId: string, selectedLabel: string) => Promise<void>
}

function getChoiceText(choices: Choice[], label: string) {
  return choices.find((choice) => choice.label === label)?.text ?? label
}

/** One mistake in the garden: read the answer, or hide it and try again. */
export function MistakeRetryCard({ mistake, onReviewed, onMissed }: MistakeRetryCardProps) {
  const [mode, setMode] = useState<CardMode>('review')
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null)
  const [submitting, setSubmitting] = useState(false)

  const handleStartRetry = () => {
    setSelectedAnswer(null)
    setMode('retry')
  }

  const handleCheckAnswer = async () => {
    if (!selectedAnswer) return
    if (selectedAnswer !== mistake.correctAnswer) {
      setMode('wrong')
      await onMissed(mistake.questionId, selectedAnswer)
      return
    }
    setSubmitting(true)
    await onReviewed(mistake.id)
    setSubmitting(false)
  }

  return (
    <div className="p-6">
      <div className="mb-4 flex items-start justify-between gap-2">
        <div className="text-sm text-gray-400 dark:text-gray-500">
          {new Date(mistake.lastMissedAt).toLocaleDateString()}
        </div>
        {mode === 'review' && (
          <div className="flex gap-2">
            <button
              onClick={handleStartRetry}
              className="rounded bg-purple-50 px-2 py-1 text-xs font-medium text-purple-600 hover:text-purple-700 dark:bg-purple-900/30 dark:text-purple-400 dark:hover:text-purple-300"
            >
              Try again
            </button>
            <button
              onClick={() => onReviewed(mistake.id)}
              className="rounded bg-green-50 px-2 py-1 text-xs font-medium text-green-600 hover:text-green-700 dark:bg-green-900/30 dark:text-green-400 dark:hover:text-green-300"
            >
              Mark as Reviewed
            </button>
          </div>
        )}
      </div>

      <div className="mb-4">
        <p className="mb-1 text-sm font-medium text-gray-500 dark:text-gray-400">Question</p>
        <p className="break-words text-lg text-gray-900 dark:text-gray-100">{mistake.questionText}</p>
      </div>

      {mode === 'review' && (
        <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
          <div className="rounded-xl border border-red-100 bg-red-50 p-4 dark:border-red-800 dark:bg-red-900/30">
            <p className="mb-1 text-xs font-bold uppercase text-red-600 dark:text-red-400">Your Answer</p>
            <p className="text-gray-700 dark:text-gray-300">
              {mistake.lastUserAnswer}. {getChoiceText(mistake.choices, mistake.lastUserAnswer ?? '')}
            </p>
          </div>
          <div className="rounded-xl border border-green-100 bg-green-50 p-4 dark:border-green-800 dark:bg-green-900/30">
            <p className="mb-1 text-xs font-bold uppercase text-green-600 dark:text-green-400">Correct Answer</p>
            <p className="text-gray-700 dark:text-gray-300">
              {mistake.correctAnswer}. {getChoiceText(mistake.choices, mistake.correctAnswer ?? '')}
            </p>
          </div>
        </div>
      )}

      {mode !== 'review' && (
        <ChoiceList
          choices={mistake.choices}
          selectedAnswer={selectedAnswer}
          onSelect={setSelectedAnswer}
          disabled={mode === 'wrong' || submitting}
          showCorrect={mode === 'wrong'}
          correctAnswer={mistake.correctAnswer ?? undefined}
        />
      )}

      {mode === 'retry' && (
        <div className="mt-4 flex gap-2">
          <Button size="sm" onClick={handleCheckAnswer} disabled={!selectedAnswer || submitting}>
            Check answer
          </Button>
          <Button size="sm" variant="outline" onClick={() => setMode('review')} disabled={submitting}>
            Cancel
          </Button>
        </div>
      )}

      {mode === 'wrong' && (
        <div className="mt-4 flex flex-wrap items-center gap-2">
          <p role="status" className="text-sm font-medium text-red-600 dark:text-red-400">
            Not quite. This one stays in your garden to keep growing.
          </p>
          <Button size="sm" variant="outline" onClick={handleStartRetry}>
            Try again
          </Button>
        </div>
      )}

      {mode !== 'retry' && mistake.explanation && (
        <div className="mt-4 rounded-lg border border-blue-100 bg-blue-50 p-3 dark:border-blue-800 dark:bg-blue-900/30">
          <p className="mb-1 text-xs font-bold uppercase text-blue-600 dark:text-blue-400">Explanation</p>
          <p className="text-sm text-blue-700 dark:text-blue-300">{mistake.explanation}</p>
        </div>
      )}
    </div>
  )
}
