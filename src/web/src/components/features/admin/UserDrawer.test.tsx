import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { UserDrawer } from './UserDrawer'
import { useAdminUserDetail } from '../../../hooks/useAdminUserDetail'

vi.mock('../../../hooks/useAdminUserDetail', () => ({
  useAdminUserDetail: vi.fn(),
}))

const mockUseAdminUserDetail = vi.mocked(useAdminUserDetail)

const mockUser = {
  id: 'user-1',
  displayName: 'Aung Myo',
  email: 'aung@example.com',
  avatarUrl: null,
  role: 'user' as const,
  status: 'active' as const,
  totalXp: 2450,
  streakCount: 12,
  lastLoginAt: new Date(Date.now() - 3600000).toISOString(),
  createdAt: '2026-01-15T00:00:00Z',
  longestStreak: 20,
  totalQuizzes: 87,
  completedQuizzes: 80,
  avgQuizScore: 78.5,
  totalExams: 5,
  completedExams: 5,
  avgExamScore: 72.0,
  examPassRate: 60,
  recentActivity: [
    {
      type: 'quiz' as const,
      topicName: 'Technology',
      score: 80,
      completedAt: new Date().toISOString(),
    },
  ],
}

function renderDrawer(overrides: { userId?: string | null; onClose?: () => void; onUserUpdated?: () => void } = {}) {
  const onClose = overrides.onClose ?? vi.fn()
  const onUserUpdated = overrides.onUserUpdated ?? vi.fn()
  return {
    onClose,
    onUserUpdated,
    ...render(
      <UserDrawer
        userId={overrides.userId ?? null}
        onClose={onClose}
        onUserUpdated={onUserUpdated}
      />
    ),
  }
}

describe('UserDrawer', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('returns null when userId is null', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: null,
      loading: false,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    const { container } = renderDrawer({ userId: null })
    expect(container.innerHTML).toBe('')
  })

  it('shows loading spinner while fetching', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: null,
      loading: true,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    renderDrawer({ userId: 'user-1' })
    const spinner = document.querySelector('.animate-spin')
    expect(spinner).toBeInTheDocument()
  })

  it('shows error state with close button', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: null,
      loading: false,
      error: 'Not found',
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    renderDrawer({ userId: 'user-1' })
    expect(screen.getByText('Not found')).toBeInTheDocument()
    expect(screen.getByText('Close')).toBeInTheDocument()
  })

  it('renders user header with name and email', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: mockUser,
      loading: false,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    renderDrawer({ userId: 'user-1' })
    expect(screen.getByText('Aung Myo')).toBeInTheDocument()
    expect(screen.getByText('aung@example.com')).toBeInTheDocument()
  })

  it('shows overview tab by default', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: mockUser,
      loading: false,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    renderDrawer({ userId: 'user-1' })
    expect(screen.getByText('Total XP')).toBeInTheDocument()
  })

  it('switches to activity tab', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: mockUser,
      loading: false,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    renderDrawer({ userId: 'user-1' })
    fireEvent.click(screen.getByText('Activity'))
    expect(screen.getByText('Technology')).toBeInTheDocument()
  })

  it('switches to performance tab', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: mockUser,
      loading: false,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    renderDrawer({ userId: 'user-1' })
    fireEvent.click(screen.getByText('Performance'))
    expect(screen.getByText('Quiz Performance')).toBeInTheDocument()
  })

  it('shows deactivate confirmation', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: mockUser,
      loading: false,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    renderDrawer({ userId: 'user-1' })
    fireEvent.click(screen.getByText('Deactivate'))
    expect(screen.getByText('Deactivate this user? They will not be able to log in.')).toBeInTheDocument()
  })

  it('hides deactivate button for admin users', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: { ...mockUser, role: 'admin' },
      loading: false,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    renderDrawer({ userId: 'user-1' })
    expect(screen.queryByText('Deactivate')).not.toBeInTheDocument()
  })

  it('backdrop click calls onClose', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: mockUser,
      loading: false,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    const { onClose } = renderDrawer({ userId: 'user-1', onClose: vi.fn() })

    const backdrop = document.querySelector('.fixed.inset-0.z-40')
    expect(backdrop).toBeInTheDocument()
    fireEvent.click(backdrop!)
    expect(onClose).toHaveBeenCalledTimes(1)
  })

  it('X button calls onClose', () => {
    mockUseAdminUserDetail.mockReturnValue({
      user: mockUser,
      loading: false,
      error: null,
      refetch: vi.fn(),
      updateRole: vi.fn(),
      deactivate: vi.fn(),
      resetStreak: vi.fn(),
    })

    const { onClose } = renderDrawer({ userId: 'user-1', onClose: vi.fn() })

    const xButton = document.querySelector('button.rounded-lg.p-1')
    expect(xButton).toBeInTheDocument()
    fireEvent.click(xButton!)
    expect(onClose).toHaveBeenCalledTimes(1)
  })
})
