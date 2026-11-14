import { getLevelProgress } from './levelProgress'

/**
 * Returns the new level when the XP earned in a session moves the user past a level
 * boundary, or null when the level is unchanged or the starting XP is unknown.
 */
export function getLevelUp(previousTotalXp: number | undefined, xpEarned: number): number | null {
  if (previousTotalXp === undefined || xpEarned <= 0) return null

  const levelBefore = getLevelProgress(previousTotalXp).level
  const levelAfter = getLevelProgress(previousTotalXp + xpEarned).level

  return levelAfter > levelBefore ? levelAfter : null
}
