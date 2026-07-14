import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import { ExamTimer } from '../ExamTimer'

describe('ExamTimer', () => {
  it('displays time in MM:SS format', () => {
    render(<ExamTimer timeRemaining={90} />)
    expect(screen.getByText('01:30')).toBeInTheDocument()
  })

  it('displays zero time', () => {
    render(<ExamTimer timeRemaining={0} />)
    expect(screen.getByText('00:00')).toBeInTheDocument()
  })

  it('applies amber color when under 5 minutes', () => {
    render(<ExamTimer timeRemaining={240} />)
    const timer = screen.getByText('04:00')
    expect(timer.className).toContain('text-amber-600')
  })

  it('applies red color when under 1 minute', () => {
    render(<ExamTimer timeRemaining={30} />)
    const timer = screen.getByText('00:30')
    expect(timer.className).toContain('text-red-600')
  })
})
