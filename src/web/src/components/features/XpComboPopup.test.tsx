import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import { XpComboPopup } from './XpComboPopup'

describe('XpComboPopup', () => {
  it('shows the XP gain inside a polite live region', () => {
    render(<XpComboPopup visible xp={10} combo={1} />)

    const xpBadge = screen.getByText('+10 XP')
    expect(xpBadge.closest('[aria-live="polite"]')).not.toBeNull()
  })

  it('hides the combo counter below two in a row', () => {
    render(<XpComboPopup visible xp={10} combo={1} />)

    expect(screen.queryByText(/in a row/)).not.toBeInTheDocument()
  })

  it('shows the combo counter from two in a row', () => {
    render(<XpComboPopup visible xp={10} combo={3} />)

    expect(screen.getByText('3 in a row')).toBeInTheDocument()
  })

  it('keeps the live region mounted but empty when not visible', () => {
    const { container } = render(<XpComboPopup visible={false} xp={10} combo={3} />)

    const region = container.querySelector('[aria-live="polite"]')
    expect(region).not.toBeNull()
    expect(region).toBeEmptyDOMElement()
  })
})
