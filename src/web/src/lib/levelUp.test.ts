import { getLevelUp } from './levelUp'
import { XP_PER_LEVEL } from './levelProgress'

describe('getLevelUp', () => {
  it('returns the new level when XP crosses a level boundary', () => {
    expect(getLevelUp(XP_PER_LEVEL - 10, 20)).toBe(2)
  })

  it('returns the new level when XP lands exactly on the boundary', () => {
    expect(getLevelUp(XP_PER_LEVEL - 10, 10)).toBe(2)
  })

  it('returns null when the level does not change', () => {
    expect(getLevelUp(0, XP_PER_LEVEL - 1)).toBeNull()
  })

  it('returns null when no XP was earned', () => {
    expect(getLevelUp(XP_PER_LEVEL - 1, 0)).toBeNull()
  })

  it('returns null when the starting XP is unknown', () => {
    expect(getLevelUp(undefined, XP_PER_LEVEL * 2)).toBeNull()
  })

  it('reports the final level when several levels are gained at once', () => {
    expect(getLevelUp(0, XP_PER_LEVEL * 2)).toBe(3)
  })
})
