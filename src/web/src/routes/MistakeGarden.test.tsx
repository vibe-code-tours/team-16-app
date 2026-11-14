import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen, fireEvent, waitFor, within } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { MistakeGarden } from './MistakeGarden'
import { api } from '../lib/api'
import type { Mistake } from '../types/Mistake'

vi.mock('../lib/api', () => ({
  api: {
    get: vi.fn(),
    put: vi.fn(),
    post: vi.fn(),
  },
}))

const mockGet = vi.mocked(api.get)
const mockPut = vi.mocked(api.put)
const mockPost = vi.mocked(api.post)

const mistakes: Mistake[] = [
  {
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
    ],
    explanation: 'Binary 10 equals decimal 2.',
    lastUserAnswer: 'a',
    lastMissedAt: '2026-11-01T00:00:00Z',
  },
  {
    id: 'mistake-2',
    questionId: 'question-2',
    subtopicId: 'subtopic-1',
    subtopicName: 'Binary',
    topicName: 'Technology',
    questionText: 'What is 2 + 2 in binary?',
    correctAnswer: 'a',
    choices: [
      { label: 'a', text: 'Hundred' },
      { label: 'b', text: 'Eleven' },
    ],
    explanation: null,
    lastUserAnswer: 'b',
    lastMissedAt: '2026-11-02T00:00:00Z',
  },
]

function renderGarden() {
  return render(
    <MemoryRouter>
      <MistakeGarden />
    </MemoryRouter>
  )
}

function retryFirstMistake(answerText: string) {
  fireEvent.click(screen.getAllByRole('button', { name: 'Try again' })[0])
  fireEvent.click(screen.getByText(answerText))
  fireEvent.click(screen.getByRole('button', { name: 'Check answer' }))
}

function mockDueMistakes(dueMistakes: Mistake[]) {
  // api.get is generic, so the path-based fake needs a cast to satisfy its Promise<T> return type.
  mockGet.mockImplementation((path: string) =>
    Promise.resolve(path === '/api/v1/me/mistakes/due' ? dueMistakes : mistakes) as never
  )
}

describe('MistakeGarden', () => {
  beforeEach(() => {
    vi.clearAllMocks()
    mockDueMistakes([])
    mockPut.mockResolvedValue(undefined)
    mockPost.mockResolvedValue(undefined)
  })

  it('shows a seedling per open mistake in the garden summary', async () => {
    renderGarden()

    expect(await screen.findByText('0 cleared this session · 2 still growing')).toBeInTheDocument()
    expect(screen.getAllByTestId('seedling')).toHaveLength(2)
    expect(screen.queryByTestId('flower')).not.toBeInTheDocument()
  })

  it('removes the mistake and grows a flower after a correct retry', async () => {
    renderGarden()
    await screen.findByText('What is 1 + 1 in binary?')

    retryFirstMistake('Ten')

    await waitFor(() => expect(screen.queryByText('What is 1 + 1 in binary?')).not.toBeInTheDocument())
    expect(mockPut).toHaveBeenCalledWith('/api/v1/me/mistakes/mistake-1/review')
    expect(screen.getByText('1 cleared this session · 1 still growing')).toBeInTheDocument()
    expect(screen.getAllByTestId('flower')).toHaveLength(1)
  })

  it('keeps the mistake after a wrong retry', async () => {
    renderGarden()
    await screen.findByText('What is 1 + 1 in binary?')

    retryFirstMistake('One')

    await waitFor(() =>
      expect(mockPost).toHaveBeenCalledWith('/api/v1/mistakes', { questionId: 'question-1', selectedLabel: 'a' })
    )
    expect(mockPut).not.toHaveBeenCalled()
    expect(screen.getByText('What is 1 + 1 in binary?')).toBeInTheDocument()
    expect(screen.getByText('Binary 10 equals decimal 2.')).toBeInTheDocument()
    expect(screen.getByText('0 cleared this session · 2 still growing')).toBeInTheDocument()
  })

  it('shows the Due today section first with the due count', async () => {
    mockDueMistakes([mistakes[1]])
    renderGarden()

    const dueSection = await screen.findByRole('region', { name: 'Due today (1)' })
    expect(within(dueSection).getByText('What is 2 + 2 in binary?')).toBeInTheDocument()
    expect(within(dueSection).queryByText('What is 1 + 1 in binary?')).not.toBeInTheDocument()
    expect(dueSection.compareDocumentPosition(screen.getByPlaceholderText('Search questions...')))
      .toBe(Node.DOCUMENT_POSITION_FOLLOWING)
  })

  it('clears a due mistake from the Due today section after a correct retry', async () => {
    mockDueMistakes([mistakes[1]])
    renderGarden()
    const dueSection = await screen.findByRole('region', { name: 'Due today (1)' })

    fireEvent.click(within(dueSection).getByRole('button', { name: 'Try again' }))
    fireEvent.click(within(dueSection).getByText('Hundred'))
    fireEvent.click(within(dueSection).getByRole('button', { name: 'Check answer' }))

    expect(await screen.findByRole('heading', { name: 'Due today (0)' })).toBeInTheDocument()
    expect(mockPut).toHaveBeenCalledWith('/api/v1/me/mistakes/mistake-2/review')
  })
})
