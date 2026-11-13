import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { Header } from './Header'

const mockUseAuth = vi.fn()

vi.mock('../../hooks/useAuth', () => ({
  useAuth: () => mockUseAuth(),
}))

vi.mock('../ui/ThemeToggle', () => ({
  ThemeToggle: () => null,
}))

function renderHeader() {
  return render(
    <MemoryRouter>
      <Header onMenuToggle={vi.fn()} />
    </MemoryRouter>
  )
}

function mockUser(overrides: Record<string, unknown>) {
  mockUseAuth.mockReturnValue({
    user: { display_name: 'Ada', role: 'user', total_xp: 0, streak_count: 0, ...overrides },
    signOut: vi.fn(),
  })
}

describe('Header level badge', () => {
  it('shows level 1 for a new user with 0 XP', () => {
    mockUser({ total_xp: 0 })
    renderHeader()

    expect(screen.getByText('Lv 1')).toBeInTheDocument()
  })

  it('shows the level derived from total XP next to the XP count', () => {
    mockUser({ total_xp: 600 })
    renderHeader()

    expect(screen.getByText('Lv 3')).toBeInTheDocument()
    expect(screen.getByText('⚡ 600')).toBeInTheDocument()
  })

  it('hides the level for admin users', () => {
    mockUser({ role: 'admin', total_xp: 600 })
    renderHeader()

    expect(screen.queryByText(/^Lv /)).not.toBeInTheDocument()
  })
})
