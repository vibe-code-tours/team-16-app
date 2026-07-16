import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { UserFilters } from './UserFilters'
import type { UserFilters as UserFiltersType } from '../../../types'

const defaultFilters: UserFiltersType = {
  search: '',
  role: '',
  filter: '',
  sort: 'last_login_at',
  order: 'desc',
  page: 1,
}

describe('UserFilters', () => {
  let onFilterChange: (updates: Partial<UserFiltersType>) => void

  beforeEach(() => {
    vi.clearAllMocks()
    onFilterChange = vi.fn() as unknown as (updates: Partial<UserFiltersType>) => void
  })

  it('renders all filter presets', () => {
    render(<UserFilters filters={defaultFilters} onFilterChange={onFilterChange} />)

    expect(screen.getByText('All Users')).toBeInTheDocument()
    expect(screen.getByText('Active Today')).toBeInTheDocument()
    expect(screen.getByText('Inactive 30d+')).toBeInTheDocument()
    expect(screen.getByText('New (7d)')).toBeInTheDocument()
  })

  it('active filter pill is highlighted', () => {
    render(
      <UserFilters
        filters={{ ...defaultFilters, filter: 'active_today' }}
        onFilterChange={onFilterChange}
      />
    )

    const activeButton = screen.getByText('Active Today')
    expect(activeButton.className).toContain('bg-purple-600')
    expect(activeButton.className).toContain('text-white')
  })

  it('clicking filter pill calls onFilterChange', () => {
    render(<UserFilters filters={defaultFilters} onFilterChange={onFilterChange} />)

    fireEvent.click(screen.getByText('Active Today'))
    expect(onFilterChange).toHaveBeenCalledWith({ filter: 'active_today', page: 1 })
  })

  it('search input triggers onFilterChange after debounce', async () => {
    vi.useFakeTimers()

    render(<UserFilters filters={defaultFilters} onFilterChange={onFilterChange} />)

    const searchInput = screen.getByPlaceholderText('Search by name or email...')
    fireEvent.change(searchInput, { target: { value: 'aung' } })

    // Not called immediately
    expect(onFilterChange).not.toHaveBeenCalled()

    // Advance past debounce
    vi.advanceTimersByTime(300)

    expect(onFilterChange).toHaveBeenCalledWith({ search: 'aung', page: 1 })

    vi.useRealTimers()
  })

  it('role dropdown calls onFilterChange', () => {
    render(<UserFilters filters={defaultFilters} onFilterChange={onFilterChange} />)

    const select = screen.getByRole('combobox')
    fireEvent.change(select, { target: { value: 'admin' } })

    expect(onFilterChange).toHaveBeenCalledWith({ role: 'admin', page: 1 })
  })

  it('export button opens correct URL', () => {
    const openSpy = vi.spyOn(window, 'open').mockImplementation(() => null)

    render(
      <UserFilters
        filters={{ ...defaultFilters, role: 'user', filter: 'active_today' }}
        onFilterChange={onFilterChange}
      />
    )

    fireEvent.click(screen.getByText('Export CSV'))
    expect(openSpy).toHaveBeenCalledWith(
      '/api/v1/admin/users/export?role=user&filter=active_today',
      '_blank'
    )

    openSpy.mockRestore()
  })
})
