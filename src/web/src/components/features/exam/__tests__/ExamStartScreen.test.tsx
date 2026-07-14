import { describe, it, expect, vi } from 'vitest'
import { render, screen } from '@testing-library/react'
import { ExamStartScreen } from '../ExamStartScreen'
import type { ExamSummary } from '../../../../types/Exam'

const mockExams: ExamSummary[] = [
  {
    id: '1',
    exam_session: '2021-april',
    subject: 'A',
    title: '2021 April FE Subject A',
    question_count: 60,
    time_limit_minutes: 150,
    initial_hearts: 5,
  },
  {
    id: '2',
    exam_session: '2021-april',
    subject: 'B',
    title: '2021 April FE Subject B',
    question_count: 8,
    time_limit_minutes: 150,
    initial_hearts: 5,
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
