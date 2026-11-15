import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { MemoryRouter, Route, Routes } from 'react-router-dom'
import { QuizPage } from './QuizPage'
import { api } from '../lib/api'

vi.mock('../lib/api', () => ({
  api: { post: vi.fn() },
}))
const mockRefreshUser = vi.fn()
vi.mock('../hooks/useAuth', () => ({
  useAuth: () => ({ refreshUser: mockRefreshUser }),
}))

const mockApiPost = vi.mocked(api.post)

const apiSession = {
  id: 'session-1',
  status: 'in_progress',
  questions: [
    {
      id: 'q1',
      subtopicId: 'sub-1',
      questionText: 'What is 2 + 2?',
      images: [],
      choices: [
        { label: 'a', text: 'Three' },
        { label: 'b', text: 'Four' },
      ],
      correctAnswer: 'b',
      explanation: 'Two plus two is four.',
    },
  ],
}

function renderQuizPage() {
  return render(
    <MemoryRouter initialEntries={['/quiz/sub-1']}>
      <Routes>
        <Route path="/quiz/:subtopicId" element={<QuizPage />} />
        <Route path="/map" element={<div>Learning map</div>} />
        <Route path="/quiz-result/:sessionId" element={<div>Quiz result</div>} />
      </Routes>
    </MemoryRouter>
  )
}

describe('QuizPage', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('shows the start screen first and returns to the map from it', () => {
    renderQuizPage()

    expect(screen.getByRole('button', { name: 'Start Quiz' })).toBeInTheDocument()
    fireEvent.click(screen.getByRole('button', { name: 'Back to Map' }))
    expect(screen.getByText('Learning map')).toBeInTheDocument()
  })

  it('runs a question through answer, explanation and results', async () => {
    mockApiPost.mockResolvedValue(apiSession)
    renderQuizPage()

    fireEvent.click(screen.getByRole('button', { name: 'Start Quiz' }))
    expect(await screen.findByText('What is 2 + 2?')).toBeInTheDocument()
    expect(screen.getByText('Question 1 of 1')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Check answer' })).toBeDisabled()

    fireEvent.click(screen.getByText('Four'))
    fireEvent.click(screen.getByRole('button', { name: 'Check answer' }))
    expect(screen.getByText('Correct!')).toBeInTheDocument()
    expect(screen.getByText('Two plus two is four.')).toBeInTheDocument()

    fireEvent.click(screen.getByRole('button', { name: 'See results' }))
    expect(screen.getByText('Quiz result')).toBeInTheDocument()
    expect(mockRefreshUser).toHaveBeenCalled()
  })

  it('tells the user when the answer is wrong', async () => {
    mockApiPost.mockResolvedValue(apiSession)
    renderQuizPage()

    fireEvent.click(screen.getByRole('button', { name: 'Start Quiz' }))
    fireEvent.click(await screen.findByText('Three'))
    fireEvent.click(screen.getByRole('button', { name: 'Check answer' }))

    expect(screen.getByText('Not quite.')).toBeInTheDocument()
  })

  it('shows an error message when the quiz fails to load', async () => {
    mockApiPost.mockRejectedValue(new Error('Server unavailable'))
    renderQuizPage()

    fireEvent.click(screen.getByRole('button', { name: 'Start Quiz' }))

    expect(await screen.findByText("Couldn't load quiz: Server unavailable")).toBeInTheDocument()
  })

  it('shows an empty state when the subtopic has no questions', async () => {
    mockApiPost.mockResolvedValue({ ...apiSession, questions: [] })
    renderQuizPage()

    fireEvent.click(screen.getByRole('button', { name: 'Start Quiz' }))

    expect(await screen.findByText('No quiz available yet')).toBeInTheDocument()
  })
})
