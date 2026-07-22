import { render, screen, fireEvent } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { Sidebar } from './Sidebar'

// Mock useAuth to avoid Supabase dependency
vi.mock('../../hooks/useAuth', () => ({
  useAuth: () => ({ user: null }),
}))

function renderSidebar(isOpen: boolean, onClose = vi.fn()) {
  return render(
    <MemoryRouter>
      <Sidebar isOpen={isOpen} onClose={onClose} />
    </MemoryRouter>
  )
}

describe('Sidebar mobile drawer accessibility', () => {
  it('renders dialog with aria-modal and aria-label when open', () => {
    renderSidebar(true)

    const dialog = screen.getByRole('dialog', { name: 'Navigation menu' })
    expect(dialog).toHaveAttribute('aria-modal', 'true')
  })

  it('close button has an accessible label', () => {
    renderSidebar(true)

    expect(screen.getByRole('button', { name: 'Close navigation menu' })).toBeInTheDocument()
  })

  it('closes when Escape is pressed', () => {
    const onClose = vi.fn()
    renderSidebar(true, onClose)

    fireEvent.keyDown(document, { key: 'Escape' })
    expect(onClose).toHaveBeenCalledTimes(1)
  })

  it('does not render dialog when closed', () => {
    renderSidebar(false)

    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })

  it('traps focus inside the drawer on Tab', () => {
    renderSidebar(true)

    const dialog = screen.getByRole('dialog')
    const focusable = dialog.querySelectorAll('a[href], button:not([disabled])')
    const lastFocusable = focusable[focusable.length - 1]

    // Focus the last element, then Tab — focus should wrap to the first
    lastFocusable.focus()
    fireEvent.keyDown(dialog, { key: 'Tab' })

    const firstFocusable = focusable[0]
    expect(document.activeElement).toBe(firstFocusable)
  })

  it('traps focus on Shift+Tab from first element', () => {
    renderSidebar(true)

    const dialog = screen.getByRole('dialog')
    const focusable = dialog.querySelectorAll('a[href], button:not([disabled])')
    const firstFocusable = focusable[0]
    const lastFocusable = focusable[focusable.length - 1]

    firstFocusable.focus()
    fireEvent.keyDown(dialog, { key: 'Tab', shiftKey: true })

    expect(document.activeElement).toBe(lastFocusable)
  })
})
