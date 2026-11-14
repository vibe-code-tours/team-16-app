import { useState } from 'react'
import ReactMarkdown from 'react-markdown'
import { cn } from '../../lib/cn'
import { parseLessonCheck } from '../../lib/parseLessonCheck'

interface LessonCheckBlockProps {
  /** Raw block from `content_blocks`; malformed blocks render nothing. */
  block: unknown
}

function choiceClassName(index: number, selected: number | null, answer: number): string {
  if (selected === null) {
    return 'border-gray-200 dark:border-gray-700 hover:border-purple-400 hover:bg-purple-50 dark:hover:bg-purple-900/20'
  }
  if (index === answer) return 'border-green-500 bg-green-50 dark:bg-green-900/30'
  if (index === selected) return 'border-red-500 bg-red-50 dark:bg-red-900/30'
  return 'border-gray-200 dark:border-gray-700 opacity-75'
}

/**
 * Inline one-question checkpoint inside a lesson. Gives immediate feedback,
 * does not block lesson completion and awards no XP.
 */
export function LessonCheckBlock({ block }: LessonCheckBlockProps) {
  const [selected, setSelected] = useState<number | null>(null)
  const check = parseLessonCheck(block)
  if (!check) return null

  const isAnswered = selected !== null
  const isCorrect = selected === check.answer
  const handleSelectChoice = (index: number) => setSelected(index)
  const handleTryAgain = () => setSelected(null)

  return (
    <section
      aria-label="Quick check"
      className="my-6 rounded-xl border-2 border-purple-200 dark:border-purple-800 bg-purple-50/50 dark:bg-purple-900/10 p-5"
    >
      <p className="text-xs font-bold uppercase tracking-wide text-purple-600 dark:text-purple-400 mb-2">
        Quick check
      </p>
      <div className="prose prose-sm max-w-none font-medium text-gray-900 dark:text-gray-100 mb-4 wrap-break-word">
        <ReactMarkdown>{check.question}</ReactMarkdown>
      </div>

      <div className="space-y-2">
        {check.choices.map((choice, index) => (
          <button
            key={choice}
            type="button"
            onClick={() => handleSelectChoice(index)}
            disabled={isAnswered}
            aria-pressed={selected === index}
            className={cn(
              'w-full text-left rounded-lg border-2 px-4 py-3 text-gray-800 dark:text-gray-200 transition-colors',
              isAnswered ? 'cursor-default' : 'cursor-pointer',
              choiceClassName(index, selected, check.answer),
            )}
          >
            {choice}
          </button>
        ))}
      </div>

      {isAnswered && (
        <div role="status" className="mt-4">
          <p
            className={cn(
              'font-bold',
              isCorrect ? 'text-green-700 dark:text-green-400' : 'text-red-700 dark:text-red-400',
            )}
          >
            {isCorrect ? 'Correct!' : `Not quite. The answer is: ${check.choices[check.answer]}`}
          </p>
          {check.explanation && (
            <div className="prose prose-sm max-w-none mt-2 text-gray-700 dark:text-gray-300 wrap-break-word">
              <ReactMarkdown>{check.explanation}</ReactMarkdown>
            </div>
          )}
          <button
            type="button"
            onClick={handleTryAgain}
            className="mt-3 text-sm font-medium text-purple-600 hover:text-purple-800 dark:text-purple-400"
          >
            Try again
          </button>
        </div>
      )}
    </section>
  )
}
