import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import type { ReactElement } from 'react'
import { NextGoalCard } from './NextGoalCard'
import type { Achievement } from '../../../types/Achievement'

const GOAL: Achievement = {
  id: 'quiz-10',
  title: 'Quiz Regular',
  description: 'Complete 10 quizzes',
  icon: '📚',
  unlocked: false,
  progress: 8,
  target: 10,
}

function renderWithRouter(ui: ReactElement) {
  return render(<MemoryRouter>{ui}</MemoryRouter>)
}

describe('NextGoalCard', () => {
  it('renders the closest locked achievement with its progress', () => {
    renderWithRouter(<NextGoalCard goal={GOAL} hasAchievements loading={false} error={null} />)

    expect(screen.getByRole('heading', { name: 'Quiz Regular' })).toBeInTheDocument()
    expect(screen.getByText(/2 more to unlock/)).toBeInTheDocument()
    expect(screen.getByText('8 of 10')).toBeInTheDocument()
    expect(screen.getByText('80%')).toBeInTheDocument()
    const progress = screen.getByRole('progressbar', { name: 'Quiz Regular achievement progress' })
    expect(progress).toHaveAttribute('aria-valuenow', '8')
  })

  it('celebrates when every achievement is unlocked', () => {
    renderWithRouter(<NextGoalCard goal={null} hasAchievements loading={false} error={null} />)

    expect(screen.getByRole('heading', { name: 'All badges unlocked' })).toBeInTheDocument()
    expect(screen.queryByRole('progressbar')).not.toBeInTheDocument()
  })

  it('prompts a first quiz when there are no achievements', () => {
    renderWithRouter(<NextGoalCard goal={null} hasAchievements={false} loading={false} error={null} />)

    expect(screen.getByRole('heading', { name: 'Your first badge awaits' })).toBeInTheDocument()
  })

  it('shows a loading placeholder while fetching', () => {
    renderWithRouter(<NextGoalCard goal={null} hasAchievements={false} loading error={null} />)

    expect(screen.getByTestId('next-goal-loading')).toBeInTheDocument()
  })

  it('shows an unavailable message on error', () => {
    renderWithRouter(
      <NextGoalCard goal={null} hasAchievements={false} loading={false} error="API error 500" />,
    )

    expect(screen.getByRole('heading', { name: 'Next goal unavailable' })).toBeInTheDocument()
  })

  it('links to the quizzes page', () => {
    renderWithRouter(<NextGoalCard goal={GOAL} hasAchievements loading={false} error={null} />)

    expect(screen.getByRole('link', { name: /Continue learning/ })).toHaveAttribute('href', '/quizzes')
  })
})
