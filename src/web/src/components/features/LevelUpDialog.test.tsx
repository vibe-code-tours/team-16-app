import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import { describe, expect, it, vi } from 'vitest'
import { LevelUpDialog } from './LevelUpDialog'

describe('LevelUpDialog', () => {
  it('renders nothing when closed', () => {
    render(<LevelUpDialog open={false} level={3} onClose={vi.fn()} />)

    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })

  it('announces the new level in a labelled modal dialog', () => {
    render(<LevelUpDialog open level={3} onClose={vi.fn()} />)

    const dialog = screen.getByRole('dialog', { name: 'Level up!' })
    expect(dialog).toHaveAttribute('aria-modal', 'true')
    expect(screen.getByText(/You reached level 3/)).toBeInTheDocument()
  })

  it('moves focus into the dialog and keeps it there on Tab', async () => {
    render(<LevelUpDialog open level={2} onClose={vi.fn()} />)

    const button = screen.getByRole('button', { name: 'Keep going' })
    await waitFor(() => expect(button).toHaveFocus())

    fireEvent.keyDown(document, { key: 'Tab' })
    expect(button).toHaveFocus()

    fireEvent.keyDown(document, { key: 'Tab', shiftKey: true })
    expect(button).toHaveFocus()
  })

  it('closes when Escape is pressed', () => {
    const handleClose = vi.fn()
    render(<LevelUpDialog open level={2} onClose={handleClose} />)

    fireEvent.keyDown(document, { key: 'Escape' })
    expect(handleClose).toHaveBeenCalledTimes(1)
  })

  it('closes when the button is clicked', () => {
    const handleClose = vi.fn()
    render(<LevelUpDialog open level={2} onClose={handleClose} />)

    fireEvent.click(screen.getByRole('button', { name: 'Keep going' }))
    expect(handleClose).toHaveBeenCalledTimes(1)
  })
})
