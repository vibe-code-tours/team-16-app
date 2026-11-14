import { describe, it, expect, vi, beforeEach } from 'vitest'
import { renderHook, waitFor, act } from '@testing-library/react'
import { useActivity } from './useActivity'
import { api } from '../lib/api'

vi.mock('../lib/api', () => ({
  api: { get: vi.fn() },
}))

const mockApiGet = vi.mocked(api.get)

describe('useActivity', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('starts in a loading state', () => {
    mockApiGet.mockReturnValue(new Promise(() => {}))

    const { result } = renderHook(() => useActivity())

    expect(result.current.loading).toBe(true)
    expect(result.current.today).toBeNull()
  })

  it('requests the given number of days and exposes the last entry as today', async () => {
    mockApiGet.mockResolvedValue([
      { date: '2026-11-13', questionsAnswered: 2, xpEarned: 20 },
      { date: '2026-11-14', questionsAnswered: 6, xpEarned: 60 },
    ])

    const { result } = renderHook(() => useActivity(2))

    await waitFor(() => expect(result.current.loading).toBe(false))

    expect(mockApiGet).toHaveBeenCalledWith('/api/v1/me/activity?days=2')
    expect(result.current.activity).toHaveLength(2)
    expect(result.current.today?.questionsAnswered).toBe(6)
    expect(result.current.error).toBeNull()
  })

  it('defaults to seven days', async () => {
    mockApiGet.mockResolvedValue([])

    const { result } = renderHook(() => useActivity())

    await waitFor(() => expect(result.current.loading).toBe(false))

    expect(mockApiGet).toHaveBeenCalledWith('/api/v1/me/activity?days=7')
    expect(result.current.today).toBeNull()
  })

  it('sets an error message when the request fails', async () => {
    mockApiGet.mockRejectedValue(new Error('Network error'))

    const { result } = renderHook(() => useActivity())

    await waitFor(() => expect(result.current.loading).toBe(false))

    expect(result.current.error).toBe('Network error')
    expect(result.current.activity).toEqual([])
  })

  it('uses a fallback message for non-Error failures', async () => {
    mockApiGet.mockRejectedValue('boom')

    const { result } = renderHook(() => useActivity())

    await waitFor(() => expect(result.current.loading).toBe(false))

    expect(result.current.error).toBe('Failed to load activity')
  })

  it('refetch calls the API again', async () => {
    mockApiGet.mockResolvedValue([])

    const { result } = renderHook(() => useActivity())

    await waitFor(() => expect(result.current.loading).toBe(false))
    expect(mockApiGet).toHaveBeenCalledTimes(1)

    act(() => result.current.refetch())

    await waitFor(() => expect(mockApiGet).toHaveBeenCalledTimes(2))
  })
})
