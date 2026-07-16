import { describe, it, expect, vi, beforeEach } from 'vitest'
import { renderHook, waitFor, act } from '@testing-library/react'
import { useAdminUserDetail } from './useAdminUserDetail'
import { api } from '../lib/api'

vi.mock('../lib/api', () => ({
  api: {
    get: vi.fn(),
    patch: vi.fn(),
    post: vi.fn(),
  },
}))

const mockApiGet = vi.mocked(api.get)
const mockApiPatch = vi.mocked(api.patch)
const mockApiPost = vi.mocked(api.post)

const mockUser = {
  id: 'user-1',
  displayName: 'Test User',
  email: 'test@example.com',
  avatarUrl: null,
  role: 'user' as const,
  status: 'active' as const,
  totalXp: 500,
  streakCount: 3,
  longestStreak: 7,
  lastLoginAt: '2026-07-15T10:00:00Z',
  createdAt: '2026-01-01T00:00:00Z',
  totalQuizzes: 20,
  completedQuizzes: 18,
  avgQuizScore: 78.5,
  totalExams: 5,
  completedExams: 4,
  avgExamScore: 72.0,
  examPassRate: 0.75,
  recentActivity: [],
}

describe('useAdminUserDetail', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    mockApiGet.mockResolvedValue(mockUser)
  })

  it('does not fetch when userId is null', () => {
    renderHook(() => useAdminUserDetail(null))

    expect(mockApiGet).not.toHaveBeenCalled()
  })

  it('fetches user when userId is provided', async () => {
    const { result } = renderHook(() => useAdminUserDetail('user-1'))

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(mockApiGet).toHaveBeenCalledTimes(1)
    expect(mockApiGet).toHaveBeenCalledWith('/api/v1/admin/users/user-1')
    expect(result.current.user).toEqual(mockUser)
    expect(result.current.error).toBeNull()
  })

  it('updateRole calls PATCH then refetches', async () => {
    mockApiPatch.mockResolvedValue(undefined)
    mockApiGet.mockResolvedValue({ ...mockUser, role: 'admin' })

    const { result } = renderHook(() => useAdminUserDetail('user-1'))

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(mockApiGet).toHaveBeenCalledTimes(1)

    await act(async () => {
      await result.current.updateRole('admin')
    })

    expect(mockApiPatch).toHaveBeenCalledWith('/api/v1/admin/users/user-1/role', { role: 'admin' })
    expect(mockApiGet).toHaveBeenCalledTimes(2)
  })

  it('deactivate calls POST then refetches', async () => {
    mockApiPost.mockResolvedValue(undefined)
    mockApiGet.mockResolvedValue({ ...mockUser, status: 'inactive' })

    const { result } = renderHook(() => useAdminUserDetail('user-1'))

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(mockApiGet).toHaveBeenCalledTimes(1)

    await act(async () => {
      await result.current.deactivate()
    })

    expect(mockApiPost).toHaveBeenCalledWith('/api/v1/admin/users/user-1/deactivate')
    expect(mockApiGet).toHaveBeenCalledTimes(2)
  })

  it('resetStreak calls POST then refetches', async () => {
    mockApiPost.mockResolvedValue(undefined)
    mockApiGet.mockResolvedValue({ ...mockUser, streakCount: 0 })

    const { result } = renderHook(() => useAdminUserDetail('user-1'))

    await waitFor(() => {
      expect(result.current.loading).toBe(false)
    })

    expect(mockApiGet).toHaveBeenCalledTimes(1)

    await act(async () => {
      await result.current.resetStreak()
    })

    expect(mockApiPost).toHaveBeenCalledWith('/api/v1/admin/users/user-1/reset-streak')
    expect(mockApiGet).toHaveBeenCalledTimes(2)
  })

  it('actions do nothing when userId is null', async () => {
    mockApiPatch.mockResolvedValue(undefined)
    mockApiPost.mockResolvedValue(undefined)

    const { result } = renderHook(() => useAdminUserDetail(null))

    await act(async () => {
      await result.current.updateRole('admin')
    })

    await act(async () => {
      await result.current.deactivate()
    })

    await act(async () => {
      await result.current.resetStreak()
    })

    expect(mockApiGet).not.toHaveBeenCalled()
    expect(mockApiPatch).not.toHaveBeenCalled()
    expect(mockApiPost).not.toHaveBeenCalled()
  })
})
