import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { ExamQuestionCard } from '../ExamQuestionCard'
import type { ExamQuestion } from '../../../../types/Exam'

const mockQuestion: ExamQuestion = {
  id: 'q1',
  questionNumber: 1,
  questionText: 'What is 2 + 2?',
  images: [],
  choices: [
    { label: 'a', text: '3' },
    { label: 'b', text: '4' },
    { label: 'c', text: '5' },
    { label: 'd', text: '6' },
  ],
  difficulty: 'easy',
  isRequired: true,
}

describe('ExamQuestionCard', () => {
  it('renders question text and choices', () => {
    render(
      <ExamQuestionCard
        question={mockQuestion}
        selectedAnswer={null}
        isSubmitted={false}
        result={null}
        onSelect={vi.fn()}
      />
    )

    expect(screen.getByText('What is 2 + 2?')).toBeInTheDocument()
    expect(screen.getByText('3')).toBeInTheDocument()
    expect(screen.getByText('4')).toBeInTheDocument()
    expect(screen.getByText('5')).toBeInTheDocument()
    expect(screen.getByText('6')).toBeInTheDocument()
  })

  it('calls onSelect when choice clicked', () => {
    const handleSelect = vi.fn()
    render(
      <ExamQuestionCard
        question={mockQuestion}
        selectedAnswer={null}
        isSubmitted={false}
        result={null}
        onSelect={handleSelect}
      />
    )

    fireEvent.click(screen.getByText('4'))
    expect(handleSelect).toHaveBeenCalledWith('b')
  })

  it('does not call onSelect when submitted', () => {
    const handleSelect = vi.fn()
    render(
      <ExamQuestionCard
        question={mockQuestion}
        selectedAnswer="b"
        isSubmitted={true}
        result={null}
        onSelect={handleSelect}
      />
    )

    fireEvent.click(screen.getByText('4'))
    expect(handleSelect).not.toHaveBeenCalled()
  })

  it('shows correct feedback when answer is correct', () => {
    render(
      <ExamQuestionCard
        question={mockQuestion}
        selectedAnswer="b"
        isSubmitted={true}
        result={{
          questionId: 'q1',
          userAnswer: 'b',
          isCorrect: true,
          correctAnswer: 'b',
          explanation: 'Basic arithmetic',
          heartsRemaining: 5,
          examComplete: false,
        }}
        onSelect={vi.fn()}
      />
    )

    expect(screen.getByText('✅ Correct!')).toBeInTheDocument()
  })

  it('shows incorrect feedback when answer is wrong', () => {
    render(
      <ExamQuestionCard
        question={mockQuestion}
        selectedAnswer="a"
        isSubmitted={true}
        result={{
          questionId: 'q1',
          userAnswer: 'a',
          isCorrect: false,
          correctAnswer: 'b',
          explanation: 'Basic arithmetic',
          heartsRemaining: 4,
          examComplete: false,
        }}
        onSelect={vi.fn()}
      />
    )

    expect(screen.getByText('❌ Incorrect')).toBeInTheDocument()
    expect(screen.getByText('(Answer: b)')).toBeInTheDocument()
  })

  it('shows Optional badge for optional questions', () => {
    render(
      <ExamQuestionCard
        question={{ ...mockQuestion, isRequired: false }}
        selectedAnswer={null}
        isSubmitted={false}
        result={null}
        onSelect={vi.fn()}
      />
    )

    expect(screen.getByText('Optional')).toBeInTheDocument()
  })

  it('shows explanation when provided', () => {
    render(
      <ExamQuestionCard
        question={mockQuestion}
        selectedAnswer="b"
        isSubmitted={true}
        result={{
          questionId: 'q1',
          userAnswer: 'b',
          isCorrect: true,
          correctAnswer: 'b',
          explanation: '2 + 2 = 4',
          heartsRemaining: 5,
          examComplete: false,
        }}
        onSelect={vi.fn()}
      />
    )

    expect(screen.getByText('2 + 2 = 4')).toBeInTheDocument()
  })
})
