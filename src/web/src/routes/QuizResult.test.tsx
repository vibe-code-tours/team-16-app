import { fireEvent, render, screen } from '@testing-library/react'
import { MemoryRouter, Route, Routes, useParams } from 'react-router-dom'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import { api } from '../lib/api'
import type { QuizResultApi } from '../types'
import { QuizResult } from './QuizResult'

vi.mock('../lib/api', () => ({ api: { get: vi.fn() } }))

const mockGet = vi.mocked(api.get)

function createApiResult(subtopicId: string | undefined): QuizResultApi {
  return {
    sessionId: 'session-1',
    totalQuestions: 1,
    correctAnswers: 1,
    scorePercentage: 100,
    xpEarned: 10,
    answers: subtopicId
      ? [
          {
            question: {
              id: 'q1',
              subtopicId,
              examSession: '2025-October',
              subject: 'A',
              questionNumber: 1,
              questionText: 'What is a bit?',
              images: [],
              choices: [{ label: 'a', text: 'A binary digit' }],
              correctAnswer: 'a',
              explanation: null,
              difficulty: 'easy',
            },
            userAnswer: 'a',
            isCorrect: true,
          },
        ]
      : [],
  }
}

function QuizPageStub() {
  const { subtopicId } = useParams<{ subtopicId: string }>()
  return <p>Quiz page for {subtopicId}</p>
}

function renderQuizResult() {
  return render(
    <MemoryRouter initialEntries={['/quiz-result/session-1']}>
      <Routes>
        <Route path="/quiz-result/:sessionId?" element={<QuizResult />} />
        <Route path="/quiz/:subtopicId" element={<QuizPageStub />} />
        <Route path="/quizzes" element={<p>Quiz listing page</p>} />
      </Routes>
    </MemoryRouter>
  )
}

describe('QuizResult', () => {
  beforeEach(() => {
    mockGet.mockReset()
  })

  it('retries the same subtopic when Try Again is clicked', async () => {
    mockGet.mockResolvedValue(createApiResult('subtopic-42'))
    renderQuizResult()

    fireEvent.click(await screen.findByRole('button', { name: 'Try Again' }))

    expect(screen.getByText('Quiz page for subtopic-42')).toBeInTheDocument()
  })

  it('falls back to the quiz listing when the subtopic is unknown', async () => {
    mockGet.mockResolvedValue(createApiResult(undefined))
    renderQuizResult()

    fireEvent.click(await screen.findByRole('button', { name: 'Try Again' }))

    expect(screen.getByText('Quiz listing page')).toBeInTheDocument()
  })
})
