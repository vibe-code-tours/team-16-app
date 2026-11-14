import { fireEvent, render, screen, waitFor } from '@testing-library/react'
import { MemoryRouter, Route, Routes } from 'react-router-dom'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import { useAuth } from '../hooks/useAuth'
import { useLessons, type Lesson } from '../hooks/useLessons'
import { TopicDetail } from './TopicDetail'

vi.mock('../hooks/useAuth', () => ({ useAuth: vi.fn() }))
vi.mock('../hooks/useLessons', () => ({ useLessons: vi.fn() }))

const mockUseAuth = vi.mocked(useAuth)
const mockUseLessons = vi.mocked(useLessons)

const lesson: Lesson = {
  id: 'lesson-1',
  subtopic_id: 'topic-1',
  title: 'Binary Numbers',
  slug: 'binary-numbers',
  summary: null,
  content_blocks: [],
  estimated_minutes: 5,
  xp_reward: 15,
  display_order: 1,
  published: true,
  status: 'unlocked',
}

describe('TopicDetail', () => {
  const refreshUser = vi.fn()
  const completeLesson = vi.fn()

  beforeEach(() => {
    refreshUser.mockReset().mockResolvedValue(undefined)
    completeLesson.mockReset()
    mockUseAuth.mockReturnValue({
      user: null,
      session: null,
      loading: false,
      signIn: vi.fn(),
      signUp: vi.fn(),
      signInWithGoogle: vi.fn(),
      signOut: vi.fn(),
      updateProfile: vi.fn(),
      refreshUser,
    })
    mockUseLessons.mockReturnValue({
      lessons: [lesson],
      progress: [{ lesson_id: lesson.id, status: 'unlocked', started_at: null, completed_at: null }],
      loading: false,
      error: null,
      completeLesson,
      refetch: vi.fn(),
    })
  })

  it('refreshes the user XP after a lesson is completed', async () => {
    completeLesson.mockResolvedValue(true)
    renderTopicDetail()

    fireEvent.click(screen.getByRole('button', { name: /Binary Numbers/ }))
    fireEvent.click(screen.getByRole('button', { name: 'Mark as Complete · Earn 15 XP' }))

    await waitFor(() => expect(refreshUser).toHaveBeenCalledTimes(1))
    expect(completeLesson).toHaveBeenCalledWith('lesson-1')
  })

  it('does not refresh the user XP when completion fails', async () => {
    completeLesson.mockResolvedValue(false)
    renderTopicDetail()

    fireEvent.click(screen.getByRole('button', { name: /Binary Numbers/ }))
    fireEvent.click(screen.getByRole('button', { name: 'Mark as Complete · Earn 15 XP' }))

    await waitFor(() => expect(completeLesson).toHaveBeenCalledWith('lesson-1'))
    expect(refreshUser).not.toHaveBeenCalled()
  })
})

function renderTopicDetail() {
  return render(
    <MemoryRouter initialEntries={['/topics/topic-1']}>
      <Routes>
        <Route path="/topics/:topicId" element={<TopicDetail />} />
      </Routes>
    </MemoryRouter>,
  )
}
