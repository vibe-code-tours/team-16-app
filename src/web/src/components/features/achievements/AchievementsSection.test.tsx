import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { AchievementsSection } from './AchievementsSection'
import type { Achievement } from '../../../types/Achievement'

const ACHIEVEMENTS: Achievement[] = [
  {
    id: 'first-quiz',
    title: 'First Steps',
    description: 'Complete your first quiz',
    icon: '🎯',
    unlocked: true,
    progress: 1,
    target: 1,
  },
  {
    id: 'quiz-10',
    title: 'Quiz Regular',
    description: 'Complete 10 quizzes',
    icon: '📚',
    unlocked: false,
    progress: 4,
    target: 10,
  },
]

describe('AchievementsSection', () => {
  it('renders unlocked and locked badges with the real unlocked count', () => {
    render(
      <AchievementsSection
        achievements={ACHIEVEMENTS}
        unlockedCount={1}
        loading={false}
        error={null}
        onRetry={vi.fn()}
      />,
    )

    expect(screen.getByText('1 of 2 unlocked')).toBeInTheDocument()
    expect(screen.getByRole('article', { name: 'First Steps, unlocked' })).toBeInTheDocument()
    expect(screen.getByRole('article', { name: 'Quiz Regular, locked' })).toBeInTheDocument()
  })

  it('shows progress only for locked badges', () => {
    render(
      <AchievementsSection
        achievements={ACHIEVEMENTS}
        unlockedCount={1}
        loading={false}
        error={null}
        onRetry={vi.fn()}
      />,
    )

    const progress = screen.getByRole('progressbar', { name: 'Quiz Regular progress' })
    expect(progress).toHaveAttribute('aria-valuenow', '4')
    expect(progress).toHaveAttribute('aria-valuemax', '10')
    expect(screen.getByText('4 / 10')).toBeInTheDocument()
    expect(screen.queryByRole('progressbar', { name: 'First Steps progress' })).not.toBeInTheDocument()
  })

  it('shows a loading skeleton while fetching', () => {
    render(
      <AchievementsSection achievements={[]} unlockedCount={0} loading error={null} onRetry={vi.fn()} />,
    )

    expect(screen.getByTestId('achievements-loading')).toBeInTheDocument()
    expect(screen.queryByText(/unlocked$/)).not.toBeInTheDocument()
  })

  it('shows an error with a retry button that calls onRetry', () => {
    const onRetry = vi.fn()
    render(
      <AchievementsSection
        achievements={[]}
        unlockedCount={0}
        loading={false}
        error="API error 500"
        onRetry={onRetry}
      />,
    )

    expect(screen.getByRole('alert')).toHaveTextContent("couldn't load your achievements")
    fireEvent.click(screen.getByRole('button', { name: 'Try again' }))
    expect(onRetry).toHaveBeenCalledTimes(1)
  })

  it('shows an empty message when there are no achievements', () => {
    render(
      <AchievementsSection
        achievements={[]}
        unlockedCount={0}
        loading={false}
        error={null}
        onRetry={vi.fn()}
      />,
    )

    expect(screen.getByText(/No achievements yet/)).toBeInTheDocument()
  })
})
