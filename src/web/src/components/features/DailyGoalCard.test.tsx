import { fireEvent, render, screen } from '@testing-library/react'
import { describe, expect, it, vi } from 'vitest'
import { DailyGoalCard } from './DailyGoalCard'

describe('DailyGoalCard', () => {
  it('shows progress toward the daily goal', () => {
    render(<DailyGoalCard questionsAnswered={4} isLoading={false} error={null} onRetry={vi.fn()} />)

    expect(screen.getByText('4 / 10 questions today')).toBeInTheDocument()
    const progress = screen.getByRole('progressbar', { name: 'Daily goal progress' })
    expect(progress).toHaveAttribute('aria-valuemin', '0')
    expect(progress).toHaveAttribute('aria-valuemax', '10')
    expect(progress).toHaveAttribute('aria-valuenow', '4')
    expect(screen.getByText("6 more to clear today's quest.")).toBeInTheDocument()
    expect(screen.queryByText('Goal complete')).not.toBeInTheDocument()
  })

  it('switches to the completed state at the goal', () => {
    render(<DailyGoalCard questionsAnswered={10} isLoading={false} error={null} onRetry={vi.fn()} />)

    expect(screen.getByText('10 / 10 questions today')).toBeInTheDocument()
    expect(screen.getByText('Goal complete')).toBeInTheDocument()
    expect(screen.getByRole('progressbar', { name: 'Daily goal progress' })).toHaveAttribute('aria-valuenow', '10')
  })

  it('caps the progress value when the goal is exceeded', () => {
    render(<DailyGoalCard questionsAnswered={14} isLoading={false} error={null} onRetry={vi.fn()} />)

    expect(screen.getByText('14 / 10 questions today')).toBeInTheDocument()
    expect(screen.getByText('Goal complete')).toBeInTheDocument()
    expect(screen.getByRole('progressbar', { name: 'Daily goal progress' })).toHaveAttribute('aria-valuenow', '10')
  })

  it('shows a loading state', () => {
    render(<DailyGoalCard questionsAnswered={0} isLoading error={null} onRetry={vi.fn()} />)

    expect(screen.getByRole('status', { name: "Loading today's goal" })).toBeInTheDocument()
    expect(screen.queryByRole('progressbar')).not.toBeInTheDocument()
  })

  it('shows an error with a retry action', () => {
    const onRetry = vi.fn()
    render(<DailyGoalCard questionsAnswered={0} isLoading={false} error="Network error" onRetry={onRetry} />)

    expect(screen.getByRole('alert')).toHaveTextContent("Couldn't load today's goal.")
    fireEvent.click(screen.getByRole('button', { name: 'Retry' }))
    expect(onRetry).toHaveBeenCalledTimes(1)
  })
})
