import { describe, it, expect, vi, beforeEach } from 'vitest'
import { renderHook, waitFor, act } from '@testing-library/react'
import { useAdminUsers } from './useAdminUsers'
import { api } from '../lib/api'

vi.mock('../lib/api', () => ({
  api: { get: vi.fn(), patch: vi.fn(), post: vi.fn() },
}))

const mockApiGet = vi.mocked(api.get)

const emptyResponse = { users: [], total: 0, page: 1, pageSize: 25 }

describe('useAdminUsers', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    mockApiGet.mockResolvedValue(emptyResponse)
  })

  it('returns default filters on mount', () => {
    const { result } = renderHook(() => useAdminUsers())

    expect(result.current.filters.search).toBe('')
    expect(result.current.filters.page).toBe(1)
    expect(result.current.filters.sort).toBe('last_login_at')
  })

  it('fetches users on mount with default params', async () => {
    const { result } = renderHook(() => useAdminUsers())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(result.current.data).toEqual(emptyResponse)
    expect(mockApiGet).toHaveBeenCalledTimes(1)
  })

  it('updateFilters merges partial updates', async () => {
    const { result } = renderHook(() => useAdminUsers())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    act(() => {
      result.current.updateFilters({ search: 'test' })
    })

    await waitFor(() => {
      expect(result.current.filters.search).toBe('test')
    })

    expect(result.current.filters.page).toBe(1)
  })

  it('resets page to 1 when search changes', async () => {
    const { result } = renderHook(() => useAdminUsers())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    act(() => {
      result.current.updateFilters({ page: 3 })
    })

    await waitFor(() => {
      expect(result.current.filters.page).toBe(3)
    })

    act(() => {
      result.current.updateFilters({ search: 'x' })
    })

    await waitFor(() => {
      expect(result.current.filters.page).toBe(1)
    })
  })

  it('preserves page when sort changes', async () => {
    const { result } = renderHook(() => useAdminUsers())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    act(() => {
      result.current.updateFilters({ page: 3 })
    })

    await waitFor(() => {
      expect(result.current.filters.page).toBe(3)
    })

    act(() => {
      result.current.updateFilters({ sort: 'email' })
    })

    await waitFor(() => {
      expect(result.current.filters.sort).toBe('email')
    })

    expect(result.current.filters.page).toBe(3)
  })

  it('builds correct URL params', async () => {
    const { result } = renderHook(() => useAdminUsers())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    act(() => {
      result.current.updateFilters({ search: 'alice' })
    })

    await waitFor(() => {
      const lastCall = mockApiGet.mock.calls[mockApiGet.mock.calls.length - 1][0]
      expect(lastCall).toContain('search=alice')
    })
  })

  it('omits empty params from URL', async () => {
    const { result } = renderHook(() => useAdminUsers())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    const lastCall = mockApiGet.mock.calls[mockApiGet.mock.calls.length - 1][0]
    expect(lastCall).not.toContain('search=')
    expect(lastCall).not.toContain('role=')
    expect(lastCall).not.toContain('filter=')
  })

  it('sets error on API failure', async () => {
    mockApiGet.mockRejectedValue(new Error('Request failed'))

    const { result } = renderHook(() => useAdminUsers())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(result.current.error).toBe('Request failed')
    expect(result.current.data).toBeNull()
  })

  it('refetch re-fetches with current filters', async () => {
    const { result } = renderHook(() => useAdminUsers())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(mockApiGet).toHaveBeenCalledTimes(1)

    await act(async () => {
      await result.current.refetch()
    })

    expect(mockApiGet).toHaveBeenCalledTimes(2)
  })

  it('updateFilters with only page preserves other filters', async () => {
    const { result } = renderHook(() => useAdminUsers())

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    act(() => {
      result.current.updateFilters({ search: 'alice', sort: 'email' })
    })

    await waitFor(() => {
      expect(result.current.filters.search).toBe('alice')
      expect(result.current.filters.sort).toBe('email')
    })

    act(() => {
      result.current.updateFilters({ page: 2 })
    })

    await waitFor(() => {
      expect(result.current.filters.page).toBe(2)
    })

    expect(result.current.filters.search).toBe('alice')
    expect(result.current.filters.sort).toBe('email')
  })
})
