import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { QuestionBlock } from './QuestionBlock';
import type { Question } from '../../types/Quiz';

const mockQuestion: Question = {
  id: '1',
  exam_session: '2025-october',
  subject: 'A',
  question_number: 10,
  topic_category: 'Technology',
  difficulty: 'easy',
  question_text: 'What is 2 + 2?',
  choices: [
    { label: 'a', text: '3' },
    { label: 'b', text: '4' },
  ],
  correct_answer: 'b',
};

describe('QuestionBlock', () => {
  it('renders question number', () => {
    render(<QuestionBlock question={mockQuestion} />);
    expect(screen.getByText('Question 10')).toBeInTheDocument();
  });

  it('renders difficulty badge', () => {
    render(<QuestionBlock question={mockQuestion} />);
    expect(screen.getByText('easy')).toBeInTheDocument();
  });

  it('renders topic category', () => {
    render(<QuestionBlock question={mockQuestion} />);
    expect(screen.getByText('Technology')).toBeInTheDocument();
  });

  it('renders question text', () => {
    render(<QuestionBlock question={mockQuestion} />);
    expect(screen.getByText('What is 2 + 2?')).toBeInTheDocument();
  });

  it('renders images when provided', () => {
    const questionWithImages: Question = {
      ...mockQuestion,
      images: [{ url: '/images/test.png', alt: 'Test image' }],
    };
    render(<QuestionBlock question={questionWithImages} />);

    const img = screen.getByRole('img');
    expect(img).toHaveAttribute('src', '/images/test.png');
    expect(img).toHaveAttribute('alt', 'Test image');
  });

  it('does not render images when not provided', () => {
    render(<QuestionBlock question={mockQuestion} />);
    expect(screen.queryByRole('img')).not.toBeInTheDocument();
  });
});
