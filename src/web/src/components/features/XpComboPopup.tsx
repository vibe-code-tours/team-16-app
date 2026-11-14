import { MIN_COMBO_TO_SHOW } from '../../hooks/useQuizCombo'

interface XpComboPopupProps {
  /** True right after a correct answer; the live region stays mounted either way. */
  visible: boolean
  xp: number
  combo: number
}

/**
 * "+XP" float and combo counter shown after a correct quiz answer.
 * The aria-live region is always rendered so screen readers announce new content.
 */
export function XpComboPopup({ visible, xp, combo }: XpComboPopupProps) {
  return (
    <div aria-live="polite" className="pointer-events-none flex items-center gap-2">
      {visible && (
        <>
          <span className="quiz-xp-float rounded-full bg-amber-100 px-3 py-1 text-sm font-bold text-amber-700 dark:bg-amber-900/40 dark:text-amber-300">
            +{xp} XP
          </span>
          {combo >= MIN_COMBO_TO_SHOW && (
            <span className="quiz-combo-pop rounded-full bg-orange-100 px-3 py-1 text-sm font-bold text-orange-700 dark:bg-orange-900/40 dark:text-orange-300">
              <span aria-hidden="true">🔥 </span>
              {combo} in a row
            </span>
          )}
        </>
      )}
    </div>
  )
}
