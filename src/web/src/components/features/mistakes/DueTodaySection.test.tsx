import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import { DueTodaySection } from './DueTodaySection'
import type { Mistake } from '../../../types/Mistake'

function buildMistake(id: string, questionText: string): Mistake {
  return {
    id,
    questionId: `question-${id}`,
    subtopicId: 'subtopic-1',
    subtopicName: 'Binary',
    topicName: 'Technology',
    questionText,
    correctAnswer: 'b',
    choices: [
      { label: 'a', text: 'One' },
      { label: 'b', text: 'Ten' },
    ],
    explanation: 'Binary 10 equals decimal 2.',
    lastUserAnswer: 'a',
    lastMissedAt: '2026-11-01T00:00:00Z',
  }
}

describe('DueTodaySection', () => {
  it('shows the due count and a card per due mistake', () => {
    render(
      <DueTodaySection
        mistakes={[buildMistake('1', 'First due question'), buildMistake('2', 'Second due question')]}
        onReviewed={vi.fn()}
        onMissed={vi.fn()}
      />
    )

    expect(screen.getByRole('heading', { name: 'Due today (2)' })).toBeInTheDocument()
    expect(screen.getByText('First due question')).toBeInTheDocument()
    expect(screen.getByText('Second due question')).toBeInTheDocument()
  })

  it('shows a helpful message when nothing is due', () => {
    render(<DueTodaySection mistakes={[]} onReviewed={vi.fn()} onMissed={vi.fn()} />)

    expect(screen.getByRole('heading', { name: 'Due today (0)' })).toBeInTheDocument()
    expect(screen.getByText(/Nothing due right now/)).toBeInTheDocument()
  })

  it('reports a correct retry as reviewed and a wrong retry as missed', async () => {
    const handleReviewed = vi.fn().mockResolvedValue(undefined)
    const handleMissed = vi.fn().mockResolvedValue(undefined)
    render(
      <DueTodaySection
        mistakes={[buildMistake('1', 'First due question')]}
        onReviewed={handleReviewed}
        onMissed={handleMissed}
      />
    )

    fireEvent.click(screen.getByRole('button', { name: 'Try again' }))
    fireEvent.click(screen.getByText('One'))
    fireEvent.click(screen.getByRole('button', { name: 'Check answer' }))
    await waitFor(() => expect(handleMissed).toHaveBeenCalledWith('question-1', 'a'))

    fireEvent.click(screen.getByRole('button', { name: 'Try again' }))
    fireEvent.click(screen.getByText('Ten'))
    fireEvent.click(screen.getByRole('button', { name: 'Check answer' }))
    await waitFor(() => expect(handleReviewed).toHaveBeenCalledWith('1'))
  })
})
