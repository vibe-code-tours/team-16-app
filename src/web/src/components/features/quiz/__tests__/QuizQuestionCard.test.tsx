import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { QuizQuestionCard } from '../QuizQuestionCard'
import type { QuizQuestion } from '../../../../types'

const question: QuizQuestion = {
  id: 'q1',
  subtopic_id: 'sub-1',
  question_text: 'Which circuit is a half adder?',
  images: ['2022-october-a-q20-figure1.webp'],
  choices: [
    { label: 'a', text: 'First circuit' },
    { label: 'b', text: '', image: '2022-october-a-q20-choice-b.webp' },
  ],
  correct_answer: 'b',
  explanation: null,
}

describe('QuizQuestionCard', () => {
  it('shows the question text, its figure and every choice', () => {
    render(<QuizQuestionCard question={question} selectedLabel={null} isAnswered={false} onSelect={vi.fn()} />)

    expect(screen.getByRole('heading', { name: 'Which circuit is a half adder?' })).toBeInTheDocument()
    expect(screen.getByRole('img', { name: 'Question figure 1' })).toHaveAttribute(
      'src',
      '/question-images/2022-october-a-q20-figure1.webp'
    )
    expect(screen.getByText('First circuit')).toBeInTheDocument()
    expect(screen.getByRole('img', { name: 'Choice b' })).toHaveAttribute(
      'src',
      '/question-images/2022-october-a-q20-choice-b.webp'
    )
  })

  it('renders no figure area when the question has no images', () => {
    render(
      <QuizQuestionCard
        question={{ ...question, images: undefined, choices: [{ label: 'a', text: 'Only choice' }] }}
        selectedLabel={null}
        isAnswered={false}
        onSelect={vi.fn()}
      />
    )

    expect(screen.queryByRole('img')).not.toBeInTheDocument()
  })

  it('reports the chosen label when a choice is clicked', () => {
    const handleSelect = vi.fn()
    render(<QuizQuestionCard question={question} selectedLabel={null} isAnswered={false} onSelect={handleSelect} />)

    fireEvent.click(screen.getByRole('img', { name: 'Choice b' }))

    expect(handleSelect).toHaveBeenCalledWith('b')
  })

  it('locks the choices once the question is answered', () => {
    const handleSelect = vi.fn()
    render(<QuizQuestionCard question={question} selectedLabel="a" isAnswered={true} onSelect={handleSelect} />)

    const buttons = screen.getAllByRole('button')
    buttons.forEach((button) => expect(button).toBeDisabled())
    fireEvent.click(buttons[1])
    expect(handleSelect).not.toHaveBeenCalled()
  })
})
