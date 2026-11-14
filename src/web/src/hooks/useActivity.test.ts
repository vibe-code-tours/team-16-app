import { describe, it, expect, vi, beforeEach } from 'vitest'
import { renderHook, waitFor, act } from '@testing-library/react'
import { useActivity } from './useActivity'
import { api } from '../lib/api'

vi.mock('../lib/api', () => ({
  api: { get: vi.fn() },
}))

const mockApiGet = vi.mocked(api.get)

const ACTIVITY = [
  { date: '2026-11-13', questionsAnswered: 0, xpEarned: 0 },
  { date: '2026-11-14', questionsAnswered: 5, xpEarned: 50 },
]

describe('useActivity', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('starts in the loading state', () => {
    mockApiGet.mockReturnValue(new Promise(() => {}))

    const { result } = renderHook(() => useActivity(7))

    expect(result.current.loading).toBe(true)
    expect(result.current.activity).toEqual([])
  })

  it('requests the given number of days and returns the activity', async () => {
    mockApiGet.mockResolvedValue(ACTIVITY)

    const { result } = renderHook(() => useActivity(7))

    await waitFor(() => expect(result.current.loading).toBe(false))
    expect(mockApiGet).toHaveBeenCalledWith('/api/v1/me/activity?days=7')
    expect(result.current.activity).toEqual(ACTIVITY)
    expect(result.current.error).toBeNull()
  })

  it('sets the error message when the request fails', async () => {
    mockApiGet.mockRejectedValue(new Error('API error 500: boom'))

    const { result } = renderHook(() => useActivity(7))

    await waitFor(() => expect(result.current.loading).toBe(false))
    expect(result.current.error).toBe('API error 500: boom')
    expect(result.current.activity).toEqual([])
  })

  it('uses a fallback message for non-Error failures', async () => {
    mockApiGet.mockRejectedValue('offline')

    const { result } = renderHook(() => useActivity(7))

    await waitFor(() => expect(result.current.loading).toBe(false))
    expect(result.current.error).toBe('Failed to load activity')
  })

  it('refetch calls the API again', async () => {
    mockApiGet.mockResolvedValue(ACTIVITY)

    const { result } = renderHook(() => useActivity(7))
    await waitFor(() => expect(result.current.loading).toBe(false))
    expect(mockApiGet).toHaveBeenCalledTimes(1)

    act(() => result.current.refetch())

    await waitFor(() => expect(mockApiGet).toHaveBeenCalledTimes(2))
  })
})
