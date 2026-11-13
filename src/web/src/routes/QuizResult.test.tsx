import { describe, it, expect, vi } from 'vitest';
import { render, screen } from '@testing-library/react';
import { MemoryRouter, Route, Routes } from 'react-router-dom';
import { QuizResult } from './QuizResult';
import type { QuizResult as QuizResultType } from '../types/Quiz';

vi.mock('../lib/api', () => ({ api: { get: vi.fn() } }));

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

function renderWithResult(result: QuizResultType) {
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
    renderWithResult(buildResult(80));

    expect(screen.getByTestId('owl-mascot')).toHaveAttribute('data-mood', 'happy');
    expect(screen.getByText('Hoo-ray! You really know this topic.')).toBeInTheDocument();
  });

  it('shows an encouraging owl below 80%', () => {
    renderWithResult(buildResult(60));

    expect(screen.getByTestId('owl-mascot')).toHaveAttribute('data-mood', 'encouraging');
    expect(
      screen.getByText('Every mistake is a lesson. Review them and try again!')
    ).toBeInTheDocument();
  });
});
