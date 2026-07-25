import { describe, it, expect, vi } from 'vitest'
import { render, screen } from '@testing-library/react'
import { ExamStartScreen } from '../ExamStartScreen'

describe('ExamStartScreen', () => {
  it('renders start screen with title', () => {
    render(
      <ExamStartScreen isLoading={false} onStart={vi.fn()} />
    )

    expect(screen.getByText('Exam Simulation')).toBeInTheDocument()
    expect(screen.getByText('60 questions • 60 minutes')).toBeInTheDocument()
  })

  it('shows difficulty selection buttons', () => {
    render(
      <ExamStartScreen isLoading={false} onStart={vi.fn()} />
    )

    expect(screen.getByText('All')).toBeInTheDocument()
    expect(screen.getByText('Easy')).toBeInTheDocument()
    expect(screen.getByText('Medium')).toBeInTheDocument()
    expect(screen.getByText('Hard')).toBeInTheDocument()
  })

  it('shows start button', () => {
    render(
      <ExamStartScreen isLoading={false} onStart={vi.fn()} />
    )

    expect(screen.getByText('Start Exam')).toBeInTheDocument()
  })

  it('disables start button when loading', () => {
    render(
      <ExamStartScreen isLoading={true} isStarting={true} onStart={vi.fn()} />
    )

    expect(screen.getByText('Starting...')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: /starting/i })).toBeDisabled()
  })
})
