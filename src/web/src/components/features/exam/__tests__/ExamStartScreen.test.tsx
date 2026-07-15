import { describe, it, expect, vi } from 'vitest'
import { render, screen } from '@testing-library/react'
import { ExamStartScreen } from '../ExamStartScreen'
import type { ExamSummary } from '../../../../types/Exam'

const mockExams: ExamSummary[] = [
  {
    id: '1',
    examSession: '2021-april',
    subject: 'A',
    title: '2021 April FE Subject A',
    questionCount: 60,
    timeLimitMinutes: 150,
    initialHearts: 5,
  },
  {
    id: '2',
    examSession: '2021-april',
    subject: 'B',
    title: '2021 April FE Subject B',
    questionCount: 8,
    timeLimitMinutes: 150,
    initialHearts: 5,
  },
]

describe('ExamStartScreen', () => {
  it('renders exam cards', () => {
    render(
      <ExamStartScreen exams={mockExams} isLoading={false} onStart={vi.fn()} />
    )

    expect(screen.getByText('2021 april')).toBeInTheDocument()
    expect(screen.getByText('Subject A')).toBeInTheDocument()
    expect(screen.getByText('Subject B')).toBeInTheDocument()
  })

  it('shows question count and time limit', () => {
    render(
      <ExamStartScreen exams={mockExams} isLoading={false} onStart={vi.fn()} />
    )

    expect(screen.getByText(/60 questions/)).toBeInTheDocument()
    expect(screen.getAllByText(/150 min/).length).toBeGreaterThan(0)
  })

  it('shows Subject B format note', () => {
    render(
      <ExamStartScreen exams={mockExams} isLoading={false} onStart={vi.fn()} />
    )

    expect(screen.getByText(/Subject B format/)).toBeInTheDocument()
  })

  it('shows loading spinner when loading', () => {
    const { container } = render(
      <ExamStartScreen exams={[]} isLoading={true} onStart={vi.fn()} />
    )

    const spinner = container.querySelector('.animate-spin')
    expect(spinner).toBeInTheDocument()
  })

  it('shows empty state when no exams', () => {
    render(
      <ExamStartScreen exams={[]} isLoading={false} onStart={vi.fn()} />
    )

    expect(screen.getByText('No exams available yet.')).toBeInTheDocument()
  })
})
