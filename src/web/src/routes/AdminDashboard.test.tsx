import { describe, it, expect, vi, beforeEach } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { AdminDashboard } from './AdminDashboard'
import { useAdminStats } from '../hooks/useAdminStats'

vi.mock('../hooks/useAdminStats', () => ({
  useAdminStats: vi.fn(),
}))

vi.mock('../components/features/admin/ActiveUsersChart', () => ({
  ActiveUsersChart: () => <div data-testid="active-users-chart" />,
}))

vi.mock('../components/features/admin/TopicQuizChart', () => ({
  TopicQuizChart: () => <div data-testid="topic-quiz-chart" />,
}))

vi.mock('../components/features/admin/TopicScoreChart', () => ({
  TopicScoreChart: () => <div data-testid="topic-score-chart" />,
}))

vi.mock('../components/features/admin/QuizCompletionChart', () => ({
  QuizCompletionChart: () => <div data-testid="quiz-completion-chart" />,
}))

vi.mock('../components/features/admin/ExamPassChart', () => ({
  ExamPassChart: () => <div data-testid="exam-pass-chart" />,
}))

const mockUseAdminStats = vi.mocked(useAdminStats)

const mockStats = {
  totalUsers: 10,
  activeToday: 3,
  activeThisWeek: 7,
  totalQuizAttempts: 150,
  totalExamAttempts: 25,
  totalQuizSessions: 200,
  totalExamSessions: 30,
  avgQuizScore: 72.5,
  avgExamScore: 65.3,
  examPassRate: 60,
  quizCompletionRate: 80,
  topicEngagement: [
    { topicName: 'Technology', quizCount: 50, avgScore: 75.0 },
    { topicName: 'Security', quizCount: 30, avgScore: 68.5 },
  ],
  dailyActiveUsers: [
    { date: '2026-07-01', activeUsers: 5 },
    { date: '2026-07-02', activeUsers: 8 },
  ],
}

describe('AdminDashboard', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('shows loading spinner when loading', () => {
    mockUseAdminStats.mockReturnValue({
      stats: null,
      loading: true,
      error: null,
      refetch: vi.fn(),
    })

    const { container } = render(<AdminDashboard />)
    expect(container.querySelector('.animate-spin')).toBeInTheDocument()
  })

  it('shows error message and retry button on error', () => {
    mockUseAdminStats.mockReturnValue({
      stats: null,
      loading: false,
      error: 'Network error',
      refetch: vi.fn(),
    })

    render(<AdminDashboard />)

    expect(screen.getByText('Network error')).toBeInTheDocument()
    expect(screen.getByRole('button', { name: 'Retry' })).toBeInTheDocument()
  })

  it('retry button calls refetch', () => {
    const refetch = vi.fn()
    mockUseAdminStats.mockReturnValue({
      stats: null,
      loading: false,
      error: 'Network error',
      refetch,
    })

    render(<AdminDashboard />)

    fireEvent.click(screen.getByRole('button', { name: 'Retry' }))
    expect(refetch).toHaveBeenCalledTimes(1)
  })

  it('shows no-data message when stats is null', () => {
    mockUseAdminStats.mockReturnValue({
      stats: null,
      loading: false,
      error: null,
      refetch: vi.fn(),
    })

    render(<AdminDashboard />)
    expect(screen.getByText('No data available')).toBeInTheDocument()
  })

  it('renders all 8 stat cards', () => {
    mockUseAdminStats.mockReturnValue({
      stats: mockStats,
      loading: false,
      error: null,
      refetch: vi.fn(),
    })

    render(<AdminDashboard />)

    expect(screen.getByText('Total Users')).toBeInTheDocument()
    expect(screen.getByText('Active Today')).toBeInTheDocument()
    expect(screen.getByText('Active This Week')).toBeInTheDocument()
    expect(screen.getByText('Quiz Attempts')).toBeInTheDocument()
    expect(screen.getByText('Exam Attempts')).toBeInTheDocument()
    expect(screen.getByText('Avg Quiz Score')).toBeInTheDocument()
    expect(screen.getByText('Avg Exam Score')).toBeInTheDocument()
    expect(screen.getAllByText('Exam Pass Rate').length).toBeGreaterThanOrEqual(1)
  })

  it('formats avgQuizScore with 1 decimal', () => {
    mockUseAdminStats.mockReturnValue({
      stats: mockStats,
      loading: false,
      error: null,
      refetch: vi.fn(),
    })

    render(<AdminDashboard />)
    expect(screen.getByText('72.5%')).toBeInTheDocument()
  })

  it('renders chart sections', () => {
    mockUseAdminStats.mockReturnValue({
      stats: mockStats,
      loading: false,
      error: null,
      refetch: vi.fn(),
    })

    render(<AdminDashboard />)

    expect(screen.getByText(/Daily Active Users/)).toBeInTheDocument()
    expect(screen.getByText('Quiz Count by Topic')).toBeInTheDocument()
  })
})
