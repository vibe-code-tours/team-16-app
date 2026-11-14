import { describe, it, expect } from 'vitest'
import { achievementPercent, selectNextGoal } from './achievementProgress'
import type { Achievement } from '../types/Achievement'

function makeAchievement(overrides: Partial<Achievement>): Achievement {
  return {
    id: 'first-quiz',
    title: 'First Steps',
    description: 'Complete your first quiz',
    icon: '🎯',
    unlocked: false,
    progress: 0,
    target: 1,
    ...overrides,
  }
}

const ACHIEVEMENTS: Achievement[] = [
  makeAchievement({ id: 'first-quiz', unlocked: true, progress: 1, target: 1 }),
  makeAchievement({ id: 'quiz-10', title: 'Quiz Regular', progress: 8, target: 10 }),
  makeAchievement({ id: 'streak-7', title: 'On Fire', progress: 2, target: 7 }),
]

describe('selectNextGoal', () => {
  it('returns the locked achievement with the highest progress ratio', () => {
    expect(selectNextGoal(ACHIEVEMENTS)?.id).toBe('quiz-10')
  })

  it('keeps catalogue order on ties', () => {
    const tied = [
      makeAchievement({ id: 'a', progress: 0, target: 5 }),
      makeAchievement({ id: 'b', progress: 0, target: 3 }),
    ]
    expect(selectNextGoal(tied)?.id).toBe('a')
  })

  it('returns null when every achievement is unlocked', () => {
    const allUnlocked = [makeAchievement({ unlocked: true, progress: 1, target: 1 })]
    expect(selectNextGoal(allUnlocked)).toBeNull()
  })

  it('returns null for an empty list', () => {
    expect(selectNextGoal([])).toBeNull()
  })
})

describe('achievementPercent', () => {
  it('rounds progress to a whole percentage', () => {
    expect(achievementPercent(makeAchievement({ progress: 2, target: 7 }))).toBe(29)
  })

  it('handles a zero target without dividing by zero', () => {
    expect(achievementPercent(makeAchievement({ progress: 0, target: 0 }))).toBe(0)
  })
})
