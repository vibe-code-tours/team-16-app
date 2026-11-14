import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import { MistakeRetryCard } from './MistakeRetryCard'
import type { Mistake } from '../../../types/Mistake'

const mistake: Mistake = {
  id: 'mistake-1',
  questionId: 'question-1',
  subtopicId: 'subtopic-1',
  subtopicName: 'Binary',
  topicName: 'Technology',
  questionText: 'What is 1 + 1 in binary?',
  correctAnswer: 'b',
  choices: [
    { label: 'a', text: 'One' },
    { label: 'b', text: 'Ten' },
    { label: 'c', text: 'Eleven' },
  ],
  explanation: 'Binary 10 equals decimal 2.',
  lastUserAnswer: 'c',
  lastMissedAt: '2026-11-01T00:00:00Z',
}

describe('MistakeRetryCard', () => {
  it('hides the correct answer and explanation in try-again mode', () => {
    render(<MistakeRetryCard mistake={mistake} onReviewed={vi.fn()} />)

    fireEvent.click(screen.getByRole('button', { name: 'Try again' }))

    expect(screen.queryByText('Correct Answer')).not.toBeInTheDocument()
    expect(screen.queryByText('Binary 10 equals decimal 2.')).not.toBeInTheDocument()
    expect(screen.getByText('One')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Check answer' })).toBeDisabled()
  })

  it('marks the mistake reviewed when the retry is correct', async () => {
    const handleReviewed = vi.fn().mockResolvedValue(undefined)
    render(<MistakeRetryCard mistake={mistake} onReviewed={handleReviewed} />)

    fireEvent.click(screen.getByRole('button', { name: 'Try again' }))
    fireEvent.click(screen.getByText('Ten'))
    fireEvent.click(screen.getByRole('button', { name: 'Check answer' }))

    await waitFor(() => expect(handleReviewed).toHaveBeenCalledWith('mistake-1'))
  })

  it('keeps the mistake and shows the explanation when the retry is wrong', () => {
    const handleReviewed = vi.fn()
    render(<MistakeRetryCard mistake={mistake} onReviewed={handleReviewed} />)

    fireEvent.click(screen.getByRole('button', { name: 'Try again' }))
    fireEvent.click(screen.getByText('One'))
    fireEvent.click(screen.getByRole('button', { name: 'Check answer' }))

    expect(handleReviewed).not.toHaveBeenCalled()
    expect(screen.getByRole('status')).toHaveTextContent('stays in your garden')
    expect(screen.getByText('Binary 10 equals decimal 2.')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Try again' })).toBeInTheDocument()
  })
})
