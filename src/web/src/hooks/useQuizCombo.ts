import { useCallback, useState } from 'react'

/** Mirrors XP_PER_CORRECT_ANSWER in the backend QuizService. */
export const XP_PER_CORRECT_ANSWER = 10

/** The combo counter is only shown once the streak reaches this length. */
export const MIN_COMBO_TO_SHOW = 2

/**
 * Tracks consecutive correct answers within one quiz session.
 * A correct answer extends the combo; a wrong answer resets it to zero.
 */
export function useQuizCombo() {
  const [combo, setCombo] = useState(0)

  const recordAnswer = useCallback((isCorrect: boolean) => {
    setCombo((current) => (isCorrect ? current + 1 : 0))
  }, [])

  return { combo, recordAnswer }
}
