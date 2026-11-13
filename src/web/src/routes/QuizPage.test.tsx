import { fireEvent, render, screen } from '@testing-library/react'
import { MemoryRouter, Route, Routes } from 'react-router-dom'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import { api } from '../lib/api'
import { useAuth } from '../hooks/useAuth'
import { QuizPage } from './QuizPage'

vi.mock('../lib/api', () => ({ api: { post: vi.fn() } }))
vi.mock('../hooks/useAuth', () => ({ useAuth: vi.fn() }))

const mockPost = vi.mocked(api.post)
const mockUseAuth = vi.mocked(useAuth)

const CHOICES = [
  { label: 'a', text: 'Linear search' },
  { label: 'b', text: 'Binary search' },
]

function sessionWith(explanation: string | null) {
  return {
    id: 'session-1',
    status: 'in_progress',
    questions: [
      {
        id: 'q-1',
        subtopicId: 'sub-1',
        questionText: 'Which search is **fastest** on sorted data?',
        choices: CHOICES,
        correctAnswer: 'b',
        explanation,
      },
    ],
  }
}

async function startQuizAndAnswer(explanation: string | null, choiceText: string) {
  mockPost.mockImplementation((path: string) =>
    Promise.resolve(path === '/api/v1/quizzes/start' ? sessionWith(explanation) : {})
  )
  render(
    <MemoryRouter initialEntries={['/quiz/sub-1']}>
      <Routes>
        <Route path="/quiz/:subtopicId" element={<QuizPage />} />
      </Routes>
    </MemoryRouter>
  )
  fireEvent.click(screen.getByRole('button', { name: 'Start Quiz' }))
  fireEvent.click(await screen.findByText(choiceText))
  fireEvent.click(screen.getByRole('button', { name: 'Check answer' }))
}

describe('QuizPage', () => {
  beforeEach(() => {
    mockPost.mockReset()
    mockUseAuth.mockReturnValue({ refreshUser: vi.fn() } as unknown as ReturnType<typeof useAuth>)
  })

  it('renders question text as markdown', async () => {
    await startQuizAndAnswer(null, 'Binary search')
    expect(screen.getByText('fastest').tagName).toBe('STRONG')
  })

  it('shows "Not quite." with the correct answer when there is no explanation', async () => {
    await startQuizAndAnswer(null, 'Linear search')

    const banner = screen.getByRole('status')
    expect(banner).toHaveTextContent('Not quite.')
    expect(banner).toHaveTextContent('Correct answer: b. Binary search')
  })

  it('shows "Correct!" with the correct answer when there is no explanation', async () => {
    await startQuizAndAnswer(null, 'Binary search')

    const banner = screen.getByRole('status')
    expect(banner).toHaveTextContent('Correct!')
    expect(banner).toHaveTextContent('Correct answer: b. Binary search')
  })

  it('shows the explanation when the question has one', async () => {
    await startQuizAndAnswer('It halves the search space each step.', 'Linear search')

    const banner = screen.getByRole('status')
    expect(banner).toHaveTextContent('Not quite.')
    expect(banner).toHaveTextContent('It halves the search space each step.')
    expect(banner).not.toHaveTextContent('Correct answer:')
  })

  it('records the answer and offers the results page on the last question', async () => {
    await startQuizAndAnswer(null, 'Binary search')

    expect(mockPost).toHaveBeenCalledWith('/api/v1/quizzes/session-1/answers', {
      questionId: 'q-1',
      answer: 'b',
    })
    expect(screen.getByRole('button', { name: 'See results' })).toBeInTheDocument()
  })
})
