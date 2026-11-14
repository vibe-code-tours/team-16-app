import { render, screen, fireEvent } from '@testing-library/react'
import { MemoryRouter, Route, Routes } from 'react-router-dom'
import { describe, expect, it, vi } from 'vitest'
import { XP_PER_LEVEL } from '../lib/levelProgress'
import type { QuizResult as QuizResultType } from '../types/Quiz'
import { QuizResult } from './QuizResult'

vi.mock('../lib/api', () => ({ api: { get: vi.fn() } }))

function createResult(correctAnswers: number, xpEarned = 50): QuizResultType {
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

function renderQuizResult(state: { result: QuizResultType; previousTotalXp?: number }) {
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
    renderQuizResult({ result: createResult(5) })

    expect(screen.getByTestId('celebration')).toBeInTheDocument()
  })

  it('shows no confetti below 100%', () => {
    renderQuizResult({ result: createResult(4) })

    expect(screen.queryByTestId('celebration')).not.toBeInTheDocument()
  })

  it('shows the level-up dialog when the earned XP crosses a level boundary', () => {
    renderQuizResult({ result: createResult(4, 50), previousTotalXp: XP_PER_LEVEL - 10 })

    expect(screen.getByRole('dialog', { name: 'Level up!' })).toBeInTheDocument()
    expect(screen.getByText(/You reached level 2/)).toBeInTheDocument()
  })

  it('shows no level-up dialog when the level is unchanged', () => {
    renderQuizResult({ result: createResult(5, 50), previousTotalXp: 0 })

    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })

  it('shows no level-up dialog when the starting XP is unknown', () => {
    renderQuizResult({ result: createResult(5, XP_PER_LEVEL * 2) })

    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })

  it('dismisses the level-up dialog with Escape', () => {
    renderQuizResult({ result: createResult(4, 50), previousTotalXp: XP_PER_LEVEL - 10 })

    fireEvent.keyDown(document, { key: 'Escape' })
    expect(screen.queryByRole('dialog')).not.toBeInTheDocument()
  })
})
