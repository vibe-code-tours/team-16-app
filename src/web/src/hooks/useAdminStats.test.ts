import { describe, it, expect, vi, beforeEach } from 'vitest'
import { renderHook, waitFor, act } from '@testing-library/react'
import { useAdminStats } from './useAdminStats'
import { api } from '../lib/api'

vi.mock('../lib/api', () => ({
  api: { get: vi.fn() },
}))

const mockApiGet = vi.mocked(api.get)

describe('useAdminStats', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('returns loading=true on mount', () => {
    mockApiGet.mockReturnValue(new Promise(() => {}))

    const { result } = renderHook(() => useAdminStats())

    expect(result.current.loading).toBe(true)
  })

  it('fetches stats and sets data on success', async () => {
    const mockStats = {
      totalUsers: 5,
      activeToday: 3,
      activeThisWeek: 4,
      totalQuizAttempts: 100,
      totalExamAttempts: 20,
      totalQuizSessions: 50,
      totalExamSessions: 10,
      avgQuizScore: 75.5,
      avgExamScore: 68.2,
      examPassRate: 0.6,
      quizCompletionRate: 0.85,
      topicEngagement: [],
      dailyActiveUsers: [],
    }
    mockApiGet.mockResolvedValue(mockStats)

    const { result } = renderHook(() => useAdminStats())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(result.current.stats).not.toBeNull()
    expect(result.current.stats!.totalUsers).toBe(5)
    expect(result.current.error).toBeNull()
  })

  it('sets error message on API failure', async () => {
    mockApiGet.mockRejectedValue(new Error('Network error'))

    const { result } = renderHook(() => useAdminStats())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(result.current.error).toBe('Network error')
    expect(result.current.stats).toBeNull()
  })

  it('sets fallback error on non-Error failure', async () => {
    mockApiGet.mockRejectedValue('string error')

    const { result } = renderHook(() => useAdminStats())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(result.current.error).toBe('Failed to load admin stats')
  })

  it('refetch re-calls the API', async () => {
    mockApiGet.mockResolvedValue({
      totalUsers: 5,
      activeToday: 3,
      activeThisWeek: 4,
      totalQuizAttempts: 100,
      totalExamAttempts: 20,
      totalQuizSessions: 50,
      totalExamSessions: 10,
      avgQuizScore: 75.5,
      avgExamScore: 68.2,
      examPassRate: 0.6,
      quizCompletionRate: 0.85,
      topicEngagement: [],
      dailyActiveUsers: [],
    })

    const { result } = renderHook(() => useAdminStats())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(mockApiGet).toHaveBeenCalledTimes(1)

    await act(async () => {
      await result.current.refetch()
    })

    expect(mockApiGet).toHaveBeenCalledTimes(2)
  })
})
