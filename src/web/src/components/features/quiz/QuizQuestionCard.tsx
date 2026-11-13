import { toQuestionImage } from '../../../lib/questionImage'
import type { QuizQuestion } from '../../../types'

const CHOICE_STYLE_DEFAULT =
  'border-gray-200 bg-white text-gray-700 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-300'
const CHOICE_STYLE_SELECTED =
  'border-purple-600 bg-purple-50 text-purple-800 dark:border-purple-500 dark:bg-purple-900/30 dark:text-purple-300'
const CHOICE_STYLE_CORRECT =
  'border-green-500 bg-green-50 text-green-800 dark:border-green-500 dark:bg-green-900/30 dark:text-green-400'
const CHOICE_STYLE_WRONG =
  'border-red-500 bg-red-50 text-red-800 dark:border-red-500 dark:bg-red-900/30 dark:text-red-400'

interface QuizQuestionCardProps {
  question: QuizQuestion
  selectedLabel: string | null
  isAnswered: boolean
  onSelect: (label: string) => void
}

function choiceStyle(isSelected: boolean, isCorrectChoice: boolean, isAnswered: boolean): string {
  if (isAnswered && isCorrectChoice) return CHOICE_STYLE_CORRECT
  if (isAnswered && isSelected) return CHOICE_STYLE_WRONG
  if (isSelected) return CHOICE_STYLE_SELECTED
  return CHOICE_STYLE_DEFAULT
}

/** One quiz question: its text, figures and answer choices (text and/or drawing). */
export function QuizQuestionCard({ question, selectedLabel, isAnswered, onSelect }: QuizQuestionCardProps) {
  const figures = (question.images ?? []).flatMap((image, position) => {
    const figure = toQuestionImage(image, `Question figure ${position + 1}`)
    return figure ? [figure] : []
  })

  return (
    <>
      <h2 className="mb-6 whitespace-pre-line text-lg font-semibold leading-relaxed text-gray-900 dark:text-gray-100">
        {question.question_text}
      </h2>

      {figures.length > 0 && (
        <div className="mb-6 flex flex-wrap gap-3">
          {figures.map((figure) => (
            <img key={figure.src} src={figure.src} alt={figure.alt} className="max-w-full rounded-lg bg-white" />
          ))}
        </div>
      )}

      <div className="mb-8 space-y-3">
        {question.choices.map((choice) => {
          const isSelected = selectedLabel === choice.label
          const isCorrectChoice = choice.label === question.correct_answer
          const choiceFigure = toQuestionImage(choice.image, `Choice ${choice.label}`)

          return (
            <button
              key={choice.label}
              onClick={() => onSelect(choice.label)}
              disabled={isAnswered}
              className={`w-full rounded-xl border-2 p-4 text-left transition ${choiceStyle(isSelected, isCorrectChoice, isAnswered)}`}
            >
              <span className="mr-2 font-bold uppercase">{choice.label}.</span>
              <span className="whitespace-pre-line">{choice.text}</span>
              {choiceFigure && (
                <img src={choiceFigure.src} alt={choiceFigure.alt} className="mt-2 max-w-full rounded-lg bg-white" />
              )}
            </button>
          )
        })}
      </div>
    </>
  )
}
