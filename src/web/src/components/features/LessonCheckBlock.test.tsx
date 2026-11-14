import { describe, it, expect } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { LessonCheckBlock } from './LessonCheckBlock'

const validBlock = {
  type: 'check',
  question: 'Which CPU unit performs arithmetic?',
  choices: ['Control Unit', 'ALU', 'Cache'],
  answer: 1,
  explanation: 'The ALU handles arithmetic and logic.',
}

describe('LessonCheckBlock', () => {
  it('renders the question and every choice before an answer is picked', () => {
    render(<LessonCheckBlock block={validBlock} />)

    expect(screen.getByText('Which CPU unit performs arithmetic?')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Control Unit' })).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'ALU' })).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Cache' })).toBeInTheDocument()
    expect(screen.queryByRole('status')).not.toBeInTheDocument()
  })

  it('shows correct feedback and the explanation when the right choice is picked', () => {
    render(<LessonCheckBlock block={validBlock} />)

    fireEvent.click(screen.getByRole('button', { name: 'ALU' }))

    expect(screen.getByText('Correct!')).toBeInTheDocument()
    expect(screen.getByText('The ALU handles arithmetic and logic.')).toBeInTheDocument()
  })

  it('shows the right answer and the explanation when a wrong choice is picked', () => {
    render(<LessonCheckBlock block={validBlock} />)

    fireEvent.click(screen.getByRole('button', { name: 'Cache' }))

    expect(screen.getByText('Not quite. The answer is: ALU')).toBeInTheDocument()
    expect(screen.getByText('The ALU handles arithmetic and logic.')).toBeInTheDocument()
    expect(screen.queryByText('Correct!')).not.toBeInTheDocument()
  })

  it('locks the choices after answering and lets the learner try again', () => {
    render(<LessonCheckBlock block={validBlock} />)

    fireEvent.click(screen.getByRole('button', { name: 'Cache' }))
    expect(screen.getByRole('button', { name: 'ALU' })).toBeDisabled()

    fireEvent.click(screen.getByRole('button', { name: 'Try again' }))
    expect(screen.getByRole('button', { name: 'ALU' })).toBeEnabled()
    expect(screen.queryByRole('status')).not.toBeInTheDocument()
  })

  it('omits the explanation when the block has none', () => {
    const { explanation: _omitted, ...withoutExplanation } = validBlock
    render(<LessonCheckBlock block={withoutExplanation} />)

    fireEvent.click(screen.getByRole('button', { name: 'ALU' }))

    expect(screen.getByText('Correct!')).toBeInTheDocument()
    expect(screen.queryByText('The ALU handles arithmetic and logic.')).not.toBeInTheDocument()
  })

  it.each([
    ['null', null],
    ['a string', 'check'],
    ['a missing question', { ...validBlock, question: '' }],
    ['non-array choices', { ...validBlock, choices: 'ALU' }],
    ['a single choice', { ...validBlock, choices: ['ALU'], answer: 0 }],
    ['a non-string choice', { ...validBlock, choices: ['ALU', 42] }],
    ['duplicate choices', { ...validBlock, choices: ['ALU', 'ALU'], answer: 0 }],
    ['an out-of-range answer', { ...validBlock, answer: 3 }],
    ['a negative answer', { ...validBlock, answer: -1 }],
    ['a non-integer answer', { ...validBlock, answer: '1' }],
  ])('renders nothing for a malformed block with %s', (_label, block) => {
    const { container } = render(<LessonCheckBlock block={block} />)

    expect(container).toBeEmptyDOMElement()
  })
})
