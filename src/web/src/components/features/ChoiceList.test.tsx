import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import { ChoiceList } from './ChoiceList';
import type { Choice } from '../../types/Quiz';

const mockChoices: Choice[] = [
  { label: 'a', text: 'Option A' },
  { label: 'b', text: 'Option B' },
  { label: 'c', text: 'Option C' },
  { label: 'd', text: 'Option D' },
];

describe('ChoiceList', () => {
  it('renders all choices', () => {
    render(
      <ChoiceList
        choices={mockChoices}
        selectedAnswer={null}
        onSelect={vi.fn()}
      />
    );

    expect(screen.getByText('a)')).toBeInTheDocument();
    expect(screen.getByText('b)')).toBeInTheDocument();
    expect(screen.getByText('c)')).toBeInTheDocument();
    expect(screen.getByText('d)')).toBeInTheDocument();
    expect(screen.getByText('Option A')).toBeInTheDocument();
    expect(screen.getByText('Option B')).toBeInTheDocument();
  });

  it('calls onSelect when choice clicked', () => {
    const handleSelect = vi.fn();
    render(
      <ChoiceList
        choices={mockChoices}
        selectedAnswer={null}
        onSelect={handleSelect}
      />
    );

    fireEvent.click(screen.getByText('Option A'));
    expect(handleSelect).toHaveBeenCalledWith('a');
  });

  it('does not call onSelect when disabled', () => {
    const handleSelect = vi.fn();
    render(
      <ChoiceList
        choices={mockChoices}
        selectedAnswer={null}
        onSelect={handleSelect}
        disabled
      />
    );

    fireEvent.click(screen.getByText('Option A'));
    expect(handleSelect).not.toHaveBeenCalled();
  });

  it('shows selected state', () => {
    render(
      <ChoiceList
        choices={mockChoices}
        selectedAnswer="b"
        onSelect={vi.fn()}
      />
    );

    const optionB = screen.getByText('Option B').closest('button');
    expect(optionB?.className).toContain('border-primary-500');
  });

  it('shows correct answer when showCorrect is true', () => {
    render(
      <ChoiceList
        choices={mockChoices}
        selectedAnswer="a"
        onSelect={vi.fn()}
        showCorrect
        correctAnswer="b"
      />
    );

    // Should show checkmark for correct answer
    expect(screen.getByText('✓')).toBeInTheDocument();
  });

  it('shows wrong indicator for incorrect selection', () => {
    render(
      <ChoiceList
        choices={mockChoices}
        selectedAnswer="a"
        onSelect={vi.fn()}
        showCorrect
        correctAnswer="b"
      />
    );

    // Should show X for wrong answer
    expect(screen.getByText('✗')).toBeInTheDocument();
  });
});
