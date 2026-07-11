import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { ProgressBar } from './ProgressBar';

describe('ProgressBar', () => {
  it('renders current and total', () => {
    render(<ProgressBar current={3} total={10} />);
    expect(screen.getByText('Question 3 of 10')).toBeInTheDocument();
  });

  it('renders percentage', () => {
    render(<ProgressBar current={5} total={10} />);
    expect(screen.getByText('50%')).toBeInTheDocument();
  });

  it('hides label when showLabel is false', () => {
    render(<ProgressBar current={3} total={10} showLabel={false} />);
    expect(screen.queryByText('Question 3 of 10')).not.toBeInTheDocument();
  });

  it('calculates percentage correctly', () => {
    render(<ProgressBar current={1} total={3} />);
    expect(screen.getByText('33%')).toBeInTheDocument();
  });
});
