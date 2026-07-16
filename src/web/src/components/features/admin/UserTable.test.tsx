import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { UserTable } from './UserTable'
import type { AdminUserSummary, UserFilters } from '../../../types'

const mockUser: AdminUserSummary = {
  id: 'user-1',
  displayName: 'Aung Myo',
  email: 'aung@example.com',
  avatarUrl: null,
  role: 'user',
  status: 'active',
  totalXp: 2450,
  streakCount: 12,
  lastLoginAt: new Date(Date.now() - 3600000).toISOString(),
  createdAt: '2026-01-15T00:00:00Z',
}

const defaultFilters: UserFilters = {
  search: '',
  role: '',
  filter: '',
  sort: 'last_login_at',
  order: 'desc',
  page: 1,
}

function renderTable(
  users: AdminUserSummary[] = [mockUser],
  filters: UserFilters = defaultFilters,
  onSort = vi.fn(),
  onSelectUser = vi.fn(),
) {
  return {
    onSort,
    onSelectUser,
    ...render(
      <UserTable
        users={users}
        filters={filters}
        onSort={onSort}
        onSelectUser={onSelectUser}
      />,
    ),
  }
}

describe('UserTable', () => {
  it('renders users in rows', () => {
    renderTable()
    expect(screen.getByText('Aung Myo')).toBeInTheDocument()
    expect(screen.getByText('aung@example.com')).toBeInTheDocument()
  })

  it('shows avatar fallback with first letter', () => {
    renderTable()
    const avatarCircle = screen.getByText('A', { selector: 'div' })
    expect(avatarCircle).toBeInTheDocument()
    expect(avatarCircle.className).toContain('rounded-full')
  })

  it('shows avatar image when URL present', () => {
    const userWithAvatar = {
      ...mockUser,
      avatarUrl: 'http://example.com/avatar.jpg',
    }
    const { container } = renderTable([userWithAvatar])
    const img = container.querySelector('img')
    expect(img).toBeInTheDocument()
    expect(img).toHaveAttribute('src', 'http://example.com/avatar.jpg')
  })

  it('shows Unnamed when displayName is null', () => {
    const userNoName = { ...mockUser, displayName: null }
    renderTable([userNoName])
    expect(screen.getByText('Unnamed')).toBeInTheDocument()
    expect(screen.getByText('aung@example.com')).toBeInTheDocument()
    const avatarCircle = screen.getByText('A', { selector: 'div' })
    expect(avatarCircle).toBeInTheDocument()
  })

  it('shows role badge with correct variant', () => {
    renderTable()
    const badge = screen.getByText('user')
    expect(badge).toBeInTheDocument()
    expect(badge.tagName).toBe('SPAN')
  })

  it('shows active status indicator', () => {
    renderTable()
    expect(screen.getByText('Active')).toBeInTheDocument()
  })

  it('shows inactive status indicator', () => {
    const inactiveUser = { ...mockUser, status: 'inactive' as const }
    renderTable([inactiveUser])
    expect(screen.getByText('Inactive')).toBeInTheDocument()
  })

  it('calls onSelectUser when row clicked', () => {
    const { onSelectUser } = renderTable()
    const row = screen.getByText('Aung Myo').closest('tr')!
    fireEvent.click(row)
    expect(onSelectUser).toHaveBeenCalledWith('user-1')
  })

  it('calls onSort when header clicked', () => {
    const { onSort } = renderTable()
    fireEvent.click(screen.getByText('Last Active'))
    expect(onSort).toHaveBeenCalled()
  })

  it('renders empty table when users is empty', () => {
    renderTable([])
    expect(screen.getByText('User')).toBeInTheDocument()
    expect(screen.getByText('Role')).toBeInTheDocument()
    expect(screen.getByText('Status')).toBeInTheDocument()
    expect(screen.queryByText('Aung Myo')).not.toBeInTheDocument()
    const rows = document.querySelectorAll('tbody tr')
    expect(rows).toHaveLength(0)
  })
})
