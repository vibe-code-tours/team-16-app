import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { UserCard } from './UserCard'
import type { AdminUserSummary } from '../../../types'

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

function renderCard(
  user: AdminUserSummary = mockUser,
  onSelectUser = vi.fn(),
) {
  return {
    onSelectUser,
    ...render(
      <UserCard user={user} onSelectUser={onSelectUser} />,
    ),
  }
}

describe('UserCard', () => {
  it('renders user name and email', () => {
    renderCard()
    expect(screen.getByText('Aung Myo')).toBeInTheDocument()
    expect(screen.getByText('aung@example.com')).toBeInTheDocument()
  })

  it('shows role badge', () => {
    renderCard()
    expect(screen.getByText('user')).toBeInTheDocument()
  })

  it('shows XP and streak', () => {
    renderCard()
    expect(screen.getByText(/XP:\s*2,?450/)).toBeInTheDocument()
    expect(screen.getByText(/Streak:\s*12d/)).toBeInTheDocument()
  })

  it('shows avatar fallback when no URL', () => {
    renderCard()
    const avatarCircle = screen.getByText('A', { selector: 'div' })
    expect(avatarCircle).toBeInTheDocument()
    expect(avatarCircle.className).toContain('rounded-full')
    expect(screen.queryByRole('img')).not.toBeInTheDocument()
  })

  it('calls onSelectUser when clicked', () => {
    const { onSelectUser } = renderCard()
    fireEvent.click(screen.getByText('Aung Myo').closest('div[class*="cursor-pointer"]')!)
    expect(onSelectUser).toHaveBeenCalledWith('user-1')
  })
})
