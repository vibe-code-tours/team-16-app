export const XP_PER_LEVEL = 250

export interface LevelProgress {
  level: number
  currentXp: number
  remainingXp: number
  xpPerLevel: number
  percent: number
}

/** Derives the user's level (starting at 1) and progress toward the next level from total XP. */
export function getLevelProgress(totalXp: number): LevelProgress {
  const safeXp = Math.max(totalXp, 0)
  const level = Math.floor(safeXp / XP_PER_LEVEL) + 1
  const currentXp = safeXp % XP_PER_LEVEL
  const remainingXp = XP_PER_LEVEL - currentXp

  return {
    level,
    currentXp,
    remainingXp,
    xpPerLevel: XP_PER_LEVEL,
    percent: Math.round((currentXp / XP_PER_LEVEL) * 100),
  }
}
