import { describe, it, expect, vi, beforeEach } from 'vitest'
import { renderHook, waitFor, act } from '@testing-library/react'
import { useAchievements } from './useAchievements'
import { api } from '../lib/api'
import type { Achievement } from '../types/Achievement'

vi.mock('../lib/api', () => ({
  api: { get: vi.fn() },
}))

const mockApiGet = vi.mocked(api.get)

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

describe('useAchievements', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('starts in a loading state', () => {
    mockApiGet.mockReturnValue(new Promise(() => {}))

    const { result } = renderHook(() => useAchievements())

    expect(result.current.loading).toBe(true)
    expect(result.current.achievements).toEqual([])
  })

  it('loads achievements and derives the unlocked count and next goal', async () => {
    mockApiGet.mockResolvedValue(ACHIEVEMENTS)

    const { result } = renderHook(() => useAchievements())

    await waitFor(() => expect(result.current.loading).toBe(false))

    expect(mockApiGet).toHaveBeenCalledWith('/api/v1/me/achievements')
    expect(result.current.achievements).toHaveLength(3)
    expect(result.current.unlockedCount).toBe(1)
    expect(result.current.nextGoal?.id).toBe('quiz-10')
    expect(result.current.error).toBeNull()
  })

  it('exposes the error message when the request fails', async () => {
    mockApiGet.mockRejectedValue(new Error('API error 500'))

    const { result } = renderHook(() => useAchievements())

    await waitFor(() => expect(result.current.loading).toBe(false))

    expect(result.current.error).toBe('API error 500')
    expect(result.current.nextGoal).toBeNull()
  })

  it('falls back to a generic message for non-Error failures', async () => {
    mockApiGet.mockRejectedValue('boom')

    const { result } = renderHook(() => useAchievements())

    await waitFor(() => expect(result.current.loading).toBe(false))

    expect(result.current.error).toBe('Failed to load achievements')
  })

  it('refetch calls the API again', async () => {
    mockApiGet.mockResolvedValue(ACHIEVEMENTS)

    const { result } = renderHook(() => useAchievements())
    await waitFor(() => expect(result.current.loading).toBe(false))

    act(() => {
      result.current.refetch()
    })

    await waitFor(() => expect(mockApiGet).toHaveBeenCalledTimes(2))
  })
})
