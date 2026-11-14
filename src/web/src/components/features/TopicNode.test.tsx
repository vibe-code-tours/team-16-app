import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { TopicNode } from './TopicNode'
import type { TopicProgress, TopicWithStatus } from '../../types/topic'

function buildTopic(overrides: Partial<TopicWithStatus> = {}): TopicWithStatus {
  return {
    id: 'sub-1',
    subject: 'A',
    category: 'Technology',
    order: 1,
    title: 'Number Systems',
    description: 'Binary and hex',
    question_count: 20,
    prerequisite_topic_id: null,
    status: 'not_started',
    progress: null,
    ...overrides,
  }
}

function buildProgress(overrides: Partial<TopicProgress> = {}): TopicProgress {
  return {
    topic_id: 'sub-1',
    status: 'in_progress',
    questions_answered: 10,
    questions_correct: 8,
    mastery_score: 0.8,
    last_attempted_at: null,
    ...overrides,
  }
}

function renderNode(topic: TopicWithStatus) {
  return render(
    <MemoryRouter>
      <TopicNode topic={topic} stepNumber={1} />
    </MemoryRouter>
  )
}

describe('TopicNode', () => {
  it('shows the question count when there is no progress yet', () => {
    renderNode(buildTopic())
    expect(screen.getByText('20 questions')).toBeInTheDocument()
    expect(screen.queryByRole('img', { name: /Mastery/ })).not.toBeInTheDocument()
  })

  it('shows correct out of answered questions for an in-progress topic', () => {
    renderNode(buildTopic({ status: 'in_progress', progress: buildProgress() }))
    expect(screen.getByText('8 / 10 correct')).toBeInTheDocument()
  })

  it('shows real counts with the cleared label for a completed topic', () => {
    renderNode(buildTopic({
      status: 'completed',
      progress: buildProgress({ status: 'completed', questions_answered: 12, questions_correct: 11 }),
    }))
    expect(screen.getByText('11 / 12 correct · Cleared')).toBeInTheDocument()
  })

  it('falls back to the question count when lessons are done but no questions answered', () => {
    renderNode(buildTopic({
      status: 'completed',
      progress: buildProgress({ status: 'completed', questions_answered: 0, questions_correct: 0, mastery_score: 0 }),
    }))
    expect(screen.getByText('20 questions · Cleared')).toBeInTheDocument()
  })

  it.each([
    [0.95, 3],
    [0.75, 2],
    [0.5, 1],
    [0.2, 0],
  ])('renders stars for mastery score %s as %s of 3', (score, stars) => {
    renderNode(buildTopic({ status: 'in_progress', progress: buildProgress({ mastery_score: score }) }))
    expect(screen.getByRole('img', { name: `Mastery: ${stars} of 3 stars` })).toBeInTheDocument()
  })

  it('renders zero stars until at least 5 questions are answered', () => {
    renderNode(buildTopic({
      status: 'in_progress',
      progress: buildProgress({ questions_answered: 4, questions_correct: 4, mastery_score: 1 }),
    }))
    expect(screen.getByRole('img', { name: 'Mastery: 0 of 3 stars' })).toBeInTheDocument()
  })

  it('hides stats and stars on a locked topic', () => {
    renderNode(buildTopic({ status: 'locked', progress: buildProgress() }))
    expect(screen.getByText('Locked — clear the previous stop to unlock')).toBeInTheDocument()
    expect(screen.queryByRole('img', { name: /Mastery/ })).not.toBeInTheDocument()
  })
})
