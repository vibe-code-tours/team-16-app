import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { ExplanationBox } from './ExplanationBox';

describe('ExplanationBox', () => {
  it('renders correct explanation', () => {
    render(
      <ExplanationBox explanation="This is correct!" is_correct={true} />
    );

    expect(screen.getByText('Correct!')).toBeInTheDocument();
    expect(screen.getByText('This is correct!')).toBeInTheDocument();
  });

  it('renders incorrect explanation', () => {
    render(
      <ExplanationBox explanation="This is wrong." is_correct={false} />
    );

    expect(screen.getByText('Incorrect')).toBeInTheDocument();
    expect(screen.getByText('This is wrong.')).toBeInTheDocument();
  });

  it('returns null when no explanation', () => {
    const { container } = render(
      <ExplanationBox explanation="" is_correct={true} />
    );

    expect(container.firstChild).toBeNull();
  });

  it('applies green styling for correct', () => {
    const { container } = render(
      <ExplanationBox explanation="Correct!" is_correct={true} />
    );

    expect(container.firstChild).toHaveClass('bg-green-50');
  });

  it('applies red styling for incorrect', () => {
    const { container } = render(
      <ExplanationBox explanation="Wrong!" is_correct={false} />
    );

    expect(container.firstChild).toHaveClass('bg-red-50');
  });
});
