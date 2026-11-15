import { render, screen } from '@testing-library/react'
import { describe, expect, it } from 'vitest'
import { Celebration } from './Celebration'

describe('Celebration', () => {
  it('renders decorative confetti hidden from assistive tech', () => {
    render(<Celebration />)

    const celebration = screen.getByTestId('celebration')
    expect(celebration).toHaveAttribute('aria-hidden', 'true')
    expect(celebration).toHaveClass('celebration-confetti')
    expect(celebration.querySelectorAll('.confetti-piece').length).toBeGreaterThan(0)
  })
})
