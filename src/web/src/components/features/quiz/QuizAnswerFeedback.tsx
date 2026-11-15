const FEEDBACK_STYLE_CORRECT =
  'border-green-200 bg-green-50 text-green-800 dark:border-green-800 dark:bg-green-900/30 dark:text-green-400'
const FEEDBACK_STYLE_WRONG =
  'border-orange-200 bg-orange-50 text-orange-800 dark:border-orange-800 dark:bg-orange-900/30 dark:text-orange-400'

interface QuizAnswerFeedbackProps {
  isCorrect: boolean
  explanation: string
}

export function QuizAnswerFeedback({ isCorrect, explanation }: QuizAnswerFeedbackProps) {
  return (
    <div className={`mb-6 rounded-xl border p-4 text-sm ${isCorrect ? FEEDBACK_STYLE_CORRECT : FEEDBACK_STYLE_WRONG}`}>
      <p className="mb-1 font-bold">{isCorrect ? 'Correct!' : 'Not quite.'}</p>
      <p>{explanation}</p>
    </div>
  )
}
