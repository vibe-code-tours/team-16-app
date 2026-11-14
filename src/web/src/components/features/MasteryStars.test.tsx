import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import { MasteryStars } from './MasteryStars'
import { getMasteryStars } from '../../lib/masteryStars'

describe('getMasteryStars', () => {
  it.each([
    [0.95, 10, 3],
    [0.9, 10, 3],
    [0.89, 10, 2],
    [0.7, 10, 2],
    [0.69, 10, 1],
    [0.4, 10, 1],
    [0.39, 10, 0],
    [0, 10, 0],
  ])('score %s with %s questions seen gives %s stars', (score, seen, expected) => {
    expect(getMasteryStars(score, seen)).toBe(expected)
  })

  it('gives no stars before 5 questions have been answered', () => {
    expect(getMasteryStars(1, 4)).toBe(0)
    expect(getMasteryStars(1, 5)).toBe(3)
  })
})

describe('MasteryStars', () => {
  it('labels the star count for screen readers', () => {
    render(<MasteryStars masteryScore={0.75} questionsSeen={8} />)
    expect(screen.getByRole('img', { name: 'Mastery: 2 of 3 stars' })).toBeInTheDocument()
  })

  it('shows zero stars when too few questions were answered', () => {
    render(<MasteryStars masteryScore={1} questionsSeen={2} />)
    expect(screen.getByRole('img', { name: 'Mastery: 0 of 3 stars' })).toBeInTheDocument()
  })
})
