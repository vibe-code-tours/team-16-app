import type { Achievement } from '../types/Achievement'

/** Progress toward an achievement as a whole percentage in [0, 100]. */
export function achievementPercent(achievement: Achievement): number {
  if (achievement.target <= 0) return achievement.unlocked ? 100 : 0
  const ratio = achievement.progress / achievement.target
  return Math.min(100, Math.max(0, Math.round(ratio * 100)))
}

/**
 * Picks the locked achievement closest to unlocking (highest progress ratio).
 * Ties keep catalogue order. Returns null when everything is unlocked.
 */
export function selectNextGoal(achievements: Achievement[]): Achievement | null {
  let best: Achievement | null = null
  let bestRatio = -1
  for (const achievement of achievements) {
    if (achievement.unlocked || achievement.target <= 0) continue
    const ratio = achievement.progress / achievement.target
    if (ratio > bestRatio) {
      best = achievement
      bestRatio = ratio
    }
  }
  return best
}
