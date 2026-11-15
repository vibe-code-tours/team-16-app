import { fireEvent, render, screen } from '@testing-library/react'
import { MemoryRouter, Route, Routes, useParams } from 'react-router-dom'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import { api } from '../lib/api'
import { XP_PER_LEVEL } from '../lib/levelProgress'
import type { QuizResultApi } from '../types'
import type { QuizResult as QuizResultType } from '../types/Quiz'
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

function buildResult(scorePercentage: number): QuizResultType {
  return {
    session_id: 'session-1',
    total_questions: 5,
    correct_answers: Math.round((scorePercentage / 100) * 5),
    score_percentage: scorePercentage,
    xp_earned: 40,
    answers: [],
  };
}

function renderWithResultState(result: QuizResultType) {
  render(
    <MemoryRouter initialEntries={[{ pathname: '/quiz/session-1/result', state: { result } }]}>
      <Routes>
        <Route path="/quiz/:sessionId/result" element={<QuizResult />} />
      </Routes>
    </MemoryRouter>
  );
}

describe('QuizResult owl mascot', () => {
  it('shows a happy owl at 80% or more', () => {
    renderWithResultState(buildResult(80));

    expect(screen.getByTestId('owl-mascot')).toHaveAttribute('data-mood', 'happy');
    expect(screen.getByText('Hoo-ray! You really know this topic.')).toBeInTheDocument();
  });

  it('shows an encouraging owl below 80%', () => {
    renderWithResultState(buildResult(60));

    expect(screen.getByTestId('owl-mascot')).toHaveAttribute('data-mood', 'encouraging');
    expect(
      screen.getByText('Every mistake is a lesson. Review them and try again!')
    ).toBeInTheDocument();
  });
});

function createCelebrationResult(correctAnswers: number, xpEarned = 50): QuizResultType {
  const totalQuestions = 5
  return {
    session_id: 'session-1',
    total_questions: totalQuestions,
    correct_answers: correctAnswers,
    score_percentage: Math.round((correctAnswers / totalQuestions) * 100),
    xp_earned: xpEarned,
    answers: [],
  }
}

function renderWithCelebrationState(state: { result: QuizResultType; previousTotalXp?: number }) {
  return render(
    <MemoryRouter initialEntries={[{ pathname: '/quiz-result/session-1', state }]}>
      <Routes>
        <Route path="/quiz-result/:sessionId?" element={<QuizResult />} />
      </Routes>
    </MemoryRouter>
  )
}

describe('QuizResult celebrations', () => {
  it('shows confetti for a 100% score', () => {
    renderWithCelebrationState({ result: createCelebrationResult(5) })

    expect(screen.getByTestId('celebration')).toBeInTheDocument()
  })

  it('shows no confetti below 100%', () => {
    renderWithCelebrationState({ result: createCelebrationResult(4) })

    expect(screen.queryByTestId('celebration')).not.toBeInTheDocument()
  })

  it('shows the level-up dialog when the earned XP crosses a level boundary', () => {
    renderWithCelebrationState({ result: createCelebrationResult(4, 50), previousTotalXp: XP_PER_LEVEL - 10 })

    expect(screen.getByRole('dialog', { name: 'Level up!' })).toBeInTheDocument()
    expect(screen.getByText(/You reached level 2/)).toBeInTheDocument()
  })

  it('shows no level-up dialog when the level is unchanged', () => {
    renderWithCelebrationState({ result: createCelebrationResult(5, 50), previousTotalXp: 0 })

    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })

  it('shows no level-up dialog when the starting XP is unknown', () => {
    renderWithCelebrationState({ result: createCelebrationResult(5, XP_PER_LEVEL * 2) })

    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })

  it('dismisses the level-up dialog with Escape', () => {
    renderWithCelebrationState({ result: createCelebrationResult(4, 50), previousTotalXp: XP_PER_LEVEL - 10 })

    fireEvent.keyDown(document, { key: 'Escape' })
    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })
})
