import { getLevelProgress, XP_PER_LEVEL } from './levelProgress'

describe('getLevelProgress', () => {
  it('starts at level 1 with no progress for 0 XP', () => {
    expect(getLevelProgress(0)).toEqual({
      level: 1,
      currentXp: 0,
      remainingXp: XP_PER_LEVEL,
      xpPerLevel: XP_PER_LEVEL,
      percent: 0,
    })
  })

  it('treats negative XP as 0', () => {
    expect(getLevelProgress(-50).level).toBe(1)
    expect(getLevelProgress(-50).currentXp).toBe(0)
  })

  it('stays on level 1 one XP below the boundary', () => {
    const progress = getLevelProgress(XP_PER_LEVEL - 1)
    expect(progress.level).toBe(1)
    expect(progress.remainingXp).toBe(1)
  })

  it('reaches level 2 exactly at the boundary', () => {
    expect(getLevelProgress(XP_PER_LEVEL)).toEqual({
      level: 2,
      currentXp: 0,
      remainingXp: XP_PER_LEVEL,
      xpPerLevel: XP_PER_LEVEL,
      percent: 0,
    })
  })

  it('reports mid-level progress', () => {
    expect(getLevelProgress(XP_PER_LEVEL * 2 + 125)).toEqual({
      level: 3,
      currentXp: 125,
      remainingXp: 125,
      xpPerLevel: XP_PER_LEVEL,
      percent: 50,
    })
  })
})
