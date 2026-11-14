import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { ExamResultScreen } from '../ExamResultScreen'
import { XP_PER_LEVEL } from '../../../../lib/levelProgress'
import type { ExamResult } from '../../../../types/Exam'

const mockResult: ExamResult = {
  sessionId: 'session-1',
  totalQuestions: 60,
  correctAnswers: 50,
  scorePercentage: 83.33,
  xpEarned: 500,
  passed: true,
  status: 'completed',
  answers: [
    {
      questionId: 'q1',
      questionNumber: 1,
      questionText: 'What is 2 + 2?',
      userAnswer: 'b',
      correctAnswer: 'b',
      isCorrect: true,
      explanation: 'Basic arithmetic',
    },
    {
      questionId: 'q2',
      questionNumber: 2,
      questionText: 'What is 3 + 3?',
      userAnswer: 'a',
      correctAnswer: 'b',
      isCorrect: false,
      explanation: '3 + 3 = 6',
    },
  ],
}

describe('ExamResultScreen', () => {
  it('shows congratulations when passed', () => {
    render(<ExamResultScreen result={mockResult} onTryAgain={vi.fn()} />)

    expect(screen.getByText('🏆')).toBeInTheDocument()
    expect(screen.getByText('Congratulations!')).toBeInTheDocument()
  })

  it('shows keep studying when failed', () => {
    const failedResult = { ...mockResult, passed: false, scorePercentage: 50 }
    render(<ExamResultScreen result={failedResult} onTryAgain={vi.fn()} />)

    expect(screen.getByText('📚')).toBeInTheDocument()
    expect(screen.getByText('Keep Studying!')).toBeInTheDocument()
  })

  it('displays score percentage', () => {
    render(<ExamResultScreen result={mockResult} onTryAgain={vi.fn()} />)

    expect(screen.getByText('83%')).toBeInTheDocument()
  })

  it('displays correct answers count', () => {
    render(<ExamResultScreen result={mockResult} onTryAgain={vi.fn()} />)

    expect(screen.getByText('50/60')).toBeInTheDocument()
  })

  it('displays XP earned', () => {
    render(<ExamResultScreen result={mockResult} onTryAgain={vi.fn()} />)

    expect(screen.getByText('500')).toBeInTheDocument()
  })

  it('shows answer breakdown', () => {
    render(<ExamResultScreen result={mockResult} onTryAgain={vi.fn()} />)

    expect(screen.getByText('Q1')).toBeInTheDocument()
    expect(screen.getByText('Q2')).toBeInTheDocument()
    expect(screen.getByText('What is 2 + 2?')).toBeInTheDocument()
    expect(screen.getByText('What is 3 + 3?')).toBeInTheDocument()
  })

  it('shows correct/incorrect badges', () => {
    render(<ExamResultScreen result={mockResult} onTryAgain={vi.fn()} />)

    expect(screen.getByText('✓ Correct')).toBeInTheDocument()
    expect(screen.getByText('✗ Incorrect')).toBeInTheDocument()
  })

  it('shows explanation for answers', () => {
    render(<ExamResultScreen result={mockResult} onTryAgain={vi.fn()} />)

    expect(screen.getByText('Basic arithmetic')).toBeInTheDocument()
    expect(screen.getByText('3 + 3 = 6')).toBeInTheDocument()
  })

  it('calls onTryAgain when button clicked', () => {
    const handleTryAgain = vi.fn()
    render(<ExamResultScreen result={mockResult} onTryAgain={handleTryAgain} />)

    fireEvent.click(screen.getByText('Take Another Exam'))
    expect(handleTryAgain).toHaveBeenCalledTimes(1)
  })

  it('shows confetti when the exam is passed', () => {
    render(<ExamResultScreen result={mockResult} onTryAgain={vi.fn()} />)

    expect(screen.getByTestId('celebration')).toBeInTheDocument()
  })

  it('shows no confetti when the exam is failed', () => {
    const failedResult = { ...mockResult, passed: false, scorePercentage: 50 }
    render(<ExamResultScreen result={failedResult} onTryAgain={vi.fn()} />)

    expect(screen.queryByTestId('celebration')).not.toBeInTheDocument()
  })

  it('shows the level-up dialog when the exam XP crosses a level boundary', () => {
    render(
      <ExamResultScreen result={mockResult} previousTotalXp={XP_PER_LEVEL - 100} onTryAgain={vi.fn()} />
    )

    expect(screen.getByRole('dialog', { name: 'Level up!' })).toBeInTheDocument()
    expect(screen.getByText(/You reached level 3/)).toBeInTheDocument()
  })

  it('shows no level-up dialog when the level is unchanged', () => {
    const smallXpResult = { ...mockResult, xpEarned: 10 }
    render(<ExamResultScreen result={smallXpResult} previousTotalXp={0} onTryAgain={vi.fn()} />)

    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })

  it('closes the level-up dialog with its button', () => {
    render(
      <ExamResultScreen result={mockResult} previousTotalXp={XP_PER_LEVEL - 100} onTryAgain={vi.fn()} />
    )

    fireEvent.click(screen.getByRole('button', { name: 'Keep going' }))
    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })
})
