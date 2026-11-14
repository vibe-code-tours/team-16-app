import { describe, it, expect, vi, beforeEach } from 'vitest'
import { fireEvent, render, screen } from '@testing-library/react'
import { WeeklyActivityChart } from './WeeklyActivityChart'
import { api } from '../../lib/api'

vi.mock('../../lib/api', () => ({
  api: { get: vi.fn() },
}))

const mockApiGet = vi.mocked(api.get)

function buildWeek(xpByDay: number[]) {
  // 2026-11-08 is a Sunday, so the week runs Sun..Sat.
  return xpByDay.map((xp, offset) => ({
    date: `2026-11-${String(8 + offset).padStart(2, '0')}`,
    questionsAnswered: xp / 10,
    xpEarned: xp,
  }))
}

describe('WeeklyActivityChart', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('shows a loading state while activity is fetched', () => {
    mockApiGet.mockReturnValue(new Promise(() => {}))

    render(<WeeklyActivityChart />)

    expect(screen.getByRole('status', { name: 'Loading activity' })).toBeInTheDocument()
  })

  it('renders one bar per day with XP and questions from the API', async () => {
    mockApiGet.mockResolvedValue(buildWeek([0, 10, 0, 30, 0, 0, 50]))

    render(<WeeklyActivityChart />)

    const bars = await screen.findAllByRole('listitem')
    expect(bars).toHaveLength(7)
    expect(screen.getByRole('listitem', { name: 'Sun: 0 XP, 0 questions' })).toBeInTheDocument()
    expect(screen.getByRole('listitem', { name: 'Mon: 10 XP, 1 question' })).toBeInTheDocument()
    expect(screen.getByRole('listitem', { name: 'Sat: 50 XP, 5 questions' })).toBeInTheDocument()
    expect(screen.getByText('You answered 9 questions and earned 90 XP this week. Keep it going!')).toBeInTheDocument()
    expect(mockApiGet).toHaveBeenCalledWith('/api/v1/me/activity?days=7')
  })

  it('shows the empty state only when every day is zero', async () => {
    mockApiGet.mockResolvedValue(buildWeek([0, 0, 0, 0, 0, 0, 0]))

    render(<WeeklyActivityChart />)

    expect(await screen.findByText('No activity data yet')).toBeInTheDocument()
    expect(screen.queryAllByRole('listitem')).toHaveLength(0)
  })

  it('shows an error with a retry that refetches', async () => {
    mockApiGet.mockRejectedValueOnce(new Error('API error 500: boom'))
    mockApiGet.mockResolvedValueOnce(buildWeek([0, 0, 0, 0, 0, 0, 20]))

    render(<WeeklyActivityChart />)

    expect(await screen.findByRole('alert')).toHaveTextContent("We couldn't load your activity.")
    fireEvent.click(screen.getByRole('button', { name: 'Try again' }))

    expect(await screen.findByRole('listitem', { name: 'Sat: 20 XP, 2 questions' })).toBeInTheDocument()
    expect(mockApiGet).toHaveBeenCalledTimes(2)
  })
})
