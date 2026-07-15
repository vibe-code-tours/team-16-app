import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { ExamResultScreen } from '../ExamResultScreen'
import type { ExamResult } from '../../../../types/Exam'

const mockResult: ExamResult = {
  sessionId: 'session-1',
  totalQuestions: 60,
  answeredQuestions: 60,
  correctAnswers: 50,
  scorePercentage: 83.33,
  xpEarned: 500,
  passed: true,
  heartsRemaining: 3,
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

    fireEvent.click(screen.getByText('Try Another Exam'))
    expect(handleTryAgain).toHaveBeenCalledTimes(1)
  })
})
