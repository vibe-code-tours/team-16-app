import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { describe, expect, it } from 'vitest'
import { LandingPage } from './LandingPage'

describe('LandingPage', () => {
  it('shows public motivation, primary actions, and all six learning features', () => {
    render(
      <MemoryRouter initialEntries={['/']}>
        <LandingPage />
      </MemoryRouter>
    )

    expect(screen.getByRole('heading', { name: 'NerdQuiz' })).toBeInTheDocument()
    expect(screen.getByRole('link', { name: 'Start learning free' })).toHaveAttribute('href', '/register')
    expect(screen.getByRole('link', { name: 'Continue your journey' })).toHaveAttribute('href', '/login')
    expect(screen.getByRole('progressbar', { name: 'Sample learning loop progress' })).toHaveAttribute('aria-valuenow', '68')
    expect(screen.getByText('🦉')).toHaveAttribute('aria-hidden', 'true')

    expect(screen.getByRole('link', { name: /Bite-sized lessons/ })).toHaveAttribute('href', '/register')
    expect(screen.getByRole('link', { name: /Practice quizzes/ })).toHaveAttribute('href', '/register')
    expect(screen.getByRole('link', { name: /Learning-map progress/ })).toHaveAttribute('href', '/register')
    expect(screen.getByRole('link', { name: /Mistake Garden review/ })).toHaveAttribute('href', '/register')
    expect(screen.getByRole('link', { name: /Exam simulation/ })).toHaveAttribute('href', '/register')
    expect(screen.getByRole('link', { name: /XP, streaks, and profile achievements/ })).toHaveAttribute('href', '/register')
  })
})
