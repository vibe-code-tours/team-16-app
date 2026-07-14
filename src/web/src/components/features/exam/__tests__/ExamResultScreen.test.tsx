import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { ExamResultScreen } from '../ExamResultScreen'
import type { ExamResult } from '../../../../types/Exam'

const mockResult: ExamResult = {
  session_id: 'session-1',
  total_questions: 60,
  answered_questions: 60,
  correct_answers: 50,
  score_percentage: 83.33,
  xp_earned: 500,
  passed: true,
  hearts_remaining: 3,
  answers: [
    {
      question_id: 'q1',
      question_number: 1,
      question_text: 'What is 2 + 2?',
      user_answer: 'b',
      correct_answer: 'b',
      is_correct: true,
      explanation: 'Basic arithmetic',
    },
    {
      question_id: 'q2',
      question_number: 2,
      question_text: 'What is 3 + 3?',
      user_answer: 'a',
      correct_answer: 'b',
      is_correct: false,
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
    const failedResult = { ...mockResult, passed: false, score_percentage: 50 }
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
