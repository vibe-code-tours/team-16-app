import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import { useAuth } from '../hooks/useAuth'
import { useTopics } from '../hooks/useTopics'
import type { TopicWithStatus } from '../types/topic'
import { LearningMap } from './LearningMap'

vi.mock('../hooks/useAuth', () => ({ useAuth: vi.fn() }))
vi.mock('../hooks/useTopics', () => ({ useTopics: vi.fn() }))

const mockUseAuth = vi.mocked(useAuth)
const mockUseTopics = vi.mocked(useTopics)

describe('LearningMap', () => {
  beforeEach(() => {
    mockUseAuth.mockReturnValue({
      user: {
        id: 'user-1',
        email: 'ada@example.com',
        display_name: 'Ada Lovelace',
        avatar_url: null,
        role: 'user',
        total_xp: 1250,
        streak_count: 7,
        last_login_at: null,
        created_at: '2026-01-01T00:00:00Z',
        updated_at: '2026-01-01T00:00:00Z',
      },
      session: null,
      loading: false,
      signIn: vi.fn(),
      signUp: vi.fn(),
      signInWithGoogle: vi.fn(),
      signOut: vi.fn(),
      updateProfile: vi.fn(),
      refreshUser: vi.fn(),
    })
  })

  it('shows personalized progress and the protected learning path', () => {
    mockUseTopics.mockReturnValue({
      topics: [
        createTopic({ id: 'complete', status: 'completed', title: 'Algorithms' }),
        createTopic({ id: 'active', status: 'in_progress', title: 'Networks', order: 2 }),
        createTopic({ id: 'next', status: 'not_started', title: 'Databases', order: 3 }),
      ],
      loading: false,
      error: null,
    })

    renderLearningMap()

    expect(screen.getByRole('heading', { name: 'Ready for your next win, Ada?' })).toBeInTheDocument()
    expect(screen.getByText('1250')).toBeInTheDocument()
    expect(screen.getByText('7')).toBeInTheDocument()
    expect(screen.getByRole('progressbar', { name: 'Overall learning progress' })).toHaveAttribute('aria-valuenow', '33')

    expect(screen.getByText('🦉')).toHaveAttribute('aria-hidden', 'true')
    expect(screen.getByRole('link', { name: 'View full roadmap' })).toHaveAttribute('href', '#learning-path')
    expect(screen.queryByRole('heading', { name: 'Everything you need to pass' })).not.toBeInTheDocument()
  })

  it('prioritizes an in-progress topic for the continue action', () => {
    mockUseTopics.mockReturnValue({
      topics: [
        createTopic({ id: 'available', status: 'not_started', title: 'Algorithms' }),
        createTopic({ id: 'active', status: 'in_progress', title: 'Security', order: 2 }),
      ],
      loading: false,
      error: null,
    })

    renderLearningMap()

    expect(screen.getByRole('link', { name: 'Continue Security' })).toHaveAttribute('href', '/map/active')
  })

  it('falls back to the first unlocked topic when nothing is in progress', () => {
    mockUseTopics.mockReturnValue({
      topics: [
        createTopic({ id: 'done', status: 'completed', title: 'Algorithms' }),
        createTopic({ id: 'available', status: 'not_started', title: 'Databases', order: 2 }),
        createTopic({ id: 'locked', status: 'locked', title: 'Security', order: 3 }),
      ],
      loading: false,
      error: null,
    })

    renderLearningMap()

    expect(screen.getByRole('link', { name: 'Start Databases' })).toHaveAttribute('href', '/map/available')
    expect(screen.getByRole('group', { name: 'Security — locked' })).toHaveAttribute('aria-disabled', 'true')
  })

  it('celebrates a completed journey with an exam action', () => {
    mockUseTopics.mockReturnValue({
      topics: [
        createTopic({ id: 'one', status: 'completed' }),
        createTopic({ id: 'two', status: 'completed', order: 2 }),
      ],
      loading: false,
      error: null,
    })

    renderLearningMap()

    expect(screen.getByRole('progressbar', { name: 'Overall learning progress' })).toHaveAttribute('aria-valuenow', '100')
    expect(screen.getByRole('link', { name: 'Celebrate with an exam' })).toHaveAttribute('href', '/exam')
    expect(screen.getByText('You cleared the whole map!', { exact: false })).toBeInTheDocument()
  })

  it('shows an accessible loading state', () => {
    mockUseTopics.mockReturnValue({ topics: [], loading: true, error: null })

    renderLearningMap()

    expect(screen.getByRole('status', { name: 'Loading your learning journey' })).toBeInTheDocument()
    expect(screen.getByRole('status', { name: 'Loading journey progress' })).toBeInTheDocument()
    expect(screen.getByText('Finding your next stop…')).toBeInTheDocument()
  })

  it('keeps the protected roadmap action visible when topic loading fails', () => {
    mockUseTopics.mockReturnValue({ topics: [], loading: false, error: 'Network unavailable' })

    renderLearningMap()

    expect(screen.getByRole('alert')).toHaveTextContent('Network unavailable')
    expect(screen.getByRole('link', { name: 'Check your learning path' })).toHaveAttribute('href', '#learning-path')
  })

  it('offers exam practice when no topics are available', () => {
    mockUseTopics.mockReturnValue({ topics: [], loading: false, error: null })

    renderLearningMap()

    expect(screen.getByRole('heading', { name: 'Your learning path is sprouting' })).toBeInTheDocument()
    expect(screen.getAllByRole('link', { name: 'Explore exam practice' })).toHaveLength(2)
  })
})

function renderLearningMap() {
  return render(
    <MemoryRouter initialEntries={['/map']}>
      <LearningMap />
    </MemoryRouter>
  )
}

function createTopic(overrides: Partial<TopicWithStatus> = {}): TopicWithStatus {
  return {
    id: 'topic-1',
    subject: 'A',
    category: 'Technology',
    order: 1,
    title: 'Operating Systems',
    description: 'Learn the core ideas behind modern operating systems.',
    question_count: 5,
    prerequisite_topic_id: null,
    status: 'not_started',
    progress: null,
    ...overrides,
  }
}
