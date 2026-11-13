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

  it('shows question figures served from the question-images folder', () => {
    render(
      <ExamQuestionCard
        question={{ ...mockQuestion, images: ['2021-april-a-q08-figure1.webp'] }}
        selectedAnswer={null}
        isSubmitted={false}
        result={null}
        onSelect={vi.fn()}
      />
    )

    expect(screen.getByRole('img', { name: 'Question figure 1' })).toHaveAttribute(
      'src',
      '/question-images/2021-april-a-q08-figure1.webp'
    )
  })

  it('shows a drawing for choices that have an image and still lets the user pick it', () => {
    const handleSelect = vi.fn()
    const choices = ['a', 'b', 'c', 'd'].map((label) => ({
      label,
      text: '',
      image: `2022-october-a-q20-choice-${label}.webp`,
    }))
    render(
      <ExamQuestionCard
        question={{ ...mockQuestion, choices }}
        selectedAnswer={null}
        isSubmitted={false}
        result={null}
        onSelect={handleSelect}
      />
    )

    const choiceImage = screen.getByRole('img', { name: 'Choice c' })
    expect(choiceImage).toHaveAttribute('src', '/question-images/2022-october-a-q20-choice-c.webp')
    fireEvent.click(choiceImage)
    expect(handleSelect).toHaveBeenCalledWith('c')
  })

  it('acknowledges submission without disclosing correctness', () => {
    render(
      <ExamQuestionCard
        question={mockQuestion}
        selectedAnswer="b"
        isSubmitted={true}
        result={{
          answerId: 'answer-1',
          questionId: 'q1',
          userAnswer: 'b',
        }}
        onSelect={vi.fn()}
      />
    )

    expect(screen.getByText('Answer recorded')).toBeInTheDocument()
    expect(screen.getByText(/shown after you finish/i)).toBeInTheDocument()
    expect(screen.queryByText(/Correct!/i)).not.toBeInTheDocument()
    expect(screen.queryByText(/Incorrect/i)).not.toBeInTheDocument()
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

})
