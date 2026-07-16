import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen } from '@testing-library/react'
import { AdminUsers } from './AdminUsers'
import { useAdminUsers } from '../hooks/useAdminUsers'

vi.mock('../hooks/useAdminUsers', () => ({
  useAdminUsers: vi.fn(),
}))

vi.mock('../components/features/admin/UserFilters', () => ({
  UserFilters: () => <div data-testid="user-filters" />,
}))

vi.mock('../components/features/admin/UserTable', () => ({
  UserTable: () => <div data-testid="user-table" />,
}))

vi.mock('../components/features/admin/UserCard', () => ({
  UserCard: () => <div data-testid="user-card" />,
}))

vi.mock('../components/features/admin/UserPagination', () => ({
  UserPagination: () => <div data-testid="user-pagination" />,
}))

vi.mock('../components/features/admin/UserDrawer', () => ({
  UserDrawer: () => <div data-testid="user-drawer" />,
}))

const mockUseAdminUsers = vi.mocked(useAdminUsers)

const defaultMock = {
  data: { users: [], total: 0, page: 1, pageSize: 25 },
  loading: false,
  error: null,
  filters: {
    search: '',
    role: '',
    filter: '',
    sort: 'last_login_at',
    order: 'desc' as const,
    page: 1,
  },
  updateFilters: vi.fn(),
  refetch: vi.fn(),
}

const mockUsers = [
  {
    id: 'user-1',
    displayName: 'Alice',
    email: 'alice@example.com',
    avatarUrl: null,
    role: 'user' as const,
    status: 'active' as const,
    totalXp: 100,
    streakCount: 3,
    lastLoginAt: '2026-07-15T00:00:00Z',
    createdAt: '2026-01-01T00:00:00Z',
  },
  {
    id: 'user-2',
    displayName: 'Bob',
    email: 'bob@example.com',
    avatarUrl: null,
    role: 'admin' as const,
    status: 'active' as const,
    totalXp: 500,
    streakCount: 10,
    lastLoginAt: '2026-07-14T00:00:00Z',
    createdAt: '2026-02-01T00:00:00Z',
  },
]

describe('AdminUsers', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('shows loading spinner on initial load', () => {
    mockUseAdminUsers.mockReturnValue({
      ...defaultMock,
      data: null,
      loading: true,
    })

    const { container } = render(<AdminUsers />)
    expect(container.querySelector('.animate-spin')).toBeInTheDocument()
  })

  it('shows error with retry button', () => {
    mockUseAdminUsers.mockReturnValue({
      ...defaultMock,
      error: 'Failed to load',
    })

    render(<AdminUsers />)

    expect(screen.getByText('Failed to load')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Retry' })).toBeInTheDocument()
  })

  it('renders filters and pagination', () => {
    mockUseAdminUsers.mockReturnValue({
      ...defaultMock,
      data: {
        users: [mockUsers[0]],
        total: 1,
        page: 1,
        pageSize: 25,
      },
    })

    render(<AdminUsers />)

    expect(screen.getByRole('heading', { name: 'Users' })).toBeInTheDocument()
    expect(screen.getByTestId('user-filters')).toBeInTheDocument()
    expect(screen.getByTestId('user-pagination')).toBeInTheDocument()
  })

  it('shows empty message when no users', () => {
    mockUseAdminUsers.mockReturnValue({
      ...defaultMock,
      data: { users: [], total: 0, page: 1, pageSize: 25 },
    })

    render(<AdminUsers />)

    expect(screen.getByText('No users found')).toBeInTheDocument()
  })

  it('renders user list when data available', () => {
    mockUseAdminUsers.mockReturnValue({
      ...defaultMock,
      data: { users: mockUsers, total: 2, page: 1, pageSize: 25 },
    })

    render(<AdminUsers />)

    expect(screen.getByRole('heading', { name: 'Users' })).toBeInTheDocument()
    expect(screen.getByTestId('user-table')).toBeInTheDocument()
    expect(screen.getAllByTestId('user-card')).toHaveLength(2)
  })
})
