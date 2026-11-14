import { useCallback, useMemo, useState } from 'react'
import { Celebration } from '../ui/Celebration'
import { LevelUpDialog } from './LevelUpDialog'
import { getLevelUp } from '../../lib/levelUp'

interface ResultCelebrationsProps {
  /** True when the result earns confetti (perfect quiz, passed exam). */
  showConfetti: boolean
  /** The user's total XP before this session; undefined skips the level-up check. */
  previousTotalXp?: number
  xpEarned: number
}

/** Confetti and level-up dialog shown on top of a quiz or exam result screen. */
export function ResultCelebrations({ showConfetti, previousTotalXp, xpEarned }: ResultCelebrationsProps) {
  const newLevel = useMemo(() => getLevelUp(previousTotalXp, xpEarned), [previousTotalXp, xpEarned])
  const [levelUpDismissed, setLevelUpDismissed] = useState(false)
  const handleCloseLevelUp = useCallback(() => setLevelUpDismissed(true), [])

  return (
    <>
      {showConfetti && <Celebration />}
      {newLevel !== null && (
        <LevelUpDialog open={!levelUpDismissed} level={newLevel} onClose={handleCloseLevelUp} />
      )}
    </>
  )
}
