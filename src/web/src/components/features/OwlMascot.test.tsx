import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import { OwlMascot, type OwlMood } from './OwlMascot'

describe('OwlMascot', () => {
  it('defaults to the idle mood', () => {
    render(<OwlMascot />)
    expect(screen.getByTestId('owl-mascot')).toHaveAttribute('data-mood', 'idle')
  })

  it.each<[OwlMood, string]>([
    ['idle', 'motion-safe:animate-owl-idle'],
    ['happy', 'motion-safe:animate-owl-happy'],
    ['encouraging', 'motion-safe:animate-owl-encouraging'],
  ])('renders the %s mood with its reduced-motion-safe animation', (mood, animation) => {
    render(<OwlMascot mood={mood} />)

    expect(screen.getByTestId('owl-mascot')).toHaveAttribute('data-mood', mood)
    expect(screen.getByTestId('owl-mascot-emoji')).toHaveClass(animation)
  })

  it('hides the decorative owl emoji from assistive technology', () => {
    render(<OwlMascot mood="happy" />)
    expect(screen.getByText('🦉')).toHaveAttribute('aria-hidden', 'true')
  })

  it('hides the mood accent emoji from assistive technology', () => {
    render(<OwlMascot mood="happy" />)
    expect(screen.getByText('✨')).toHaveAttribute('aria-hidden', 'true')
  })

  it('shows no accent emoji when idle', () => {
    render(<OwlMascot mood="idle" />)
    expect(screen.queryByText('✨')).not.toBeInTheDocument()
    expect(screen.queryByText('💪')).not.toBeInTheDocument()
  })

  it('renders the message as readable text', () => {
    render(<OwlMascot mood="encouraging" message="You can do this!" />)

    const message = screen.getByText('You can do this!')
    expect(message).toBeVisible()
    expect(message).not.toHaveAttribute('aria-hidden')
  })

  it('renders no speech bubble without a message', () => {
    render(<OwlMascot mood="happy" />)
    expect(screen.getByTestId('owl-mascot').querySelector('p')).toBeNull()
  })
})
