import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/react'
import { LessonContent } from './LessonContent'
import type { ContentBlock, Lesson } from '../../hooks/useLessons'

function buildLesson(contentBlocks: unknown[]): Lesson {
  return {
    id: 'lesson-1',
    subtopic_id: 'subtopic-1',
    title: 'What is a CPU?',
    slug: 'what-is-a-cpu',
    summary: null,
    // Cast on purpose: these tests feed raw API JSON, including malformed blocks.
    content_blocks: contentBlocks as ContentBlock[],
    estimated_minutes: 5,
    xp_reward: 10,
    display_order: 1,
    published: true,
    status: 'unlocked',
  }
}

const checkBlock = {
  type: 'check',
  question: 'Which CPU unit performs arithmetic?',
  choices: ['Control Unit', 'ALU'],
  answer: 1,
  explanation: 'The ALU handles arithmetic and logic.',
}

describe('LessonContent', () => {
  it('renders a check block inline with the other lesson blocks', () => {
    const lesson = buildLesson([{ type: 'text', content: 'The CPU runs programs.' }, checkBlock])
    render(<LessonContent lesson={lesson} onComplete={vi.fn()} isCompleted={false} />)

    expect(screen.getByText('The CPU runs programs.')).toBeInTheDocument()
    expect(screen.getByText('Which CPU unit performs arithmetic?')).toBeInTheDocument()
  })

  it('still renders and can be completed when blocks are unknown or malformed', () => {
    const onComplete = vi.fn()
    const lesson = buildLesson([
      { type: 'text', content: 'The CPU runs programs.' },
      { type: 'video', url: 'https://example.com' },
      { type: 'check', question: 'Broken?', choices: 'yes', answer: 7 },
      { type: 'list', items: 'not-an-array' },
      null,
    ])
    render(<LessonContent lesson={lesson} onComplete={onComplete} isCompleted={false} />)

    expect(screen.getByText('The CPU runs programs.')).toBeInTheDocument()
    expect(screen.queryByText('Broken?')).not.toBeInTheDocument()

    fireEvent.click(screen.getByRole('button', { name: /Mark as Complete/ }))
    expect(onComplete).toHaveBeenCalledOnce()
  })

  it('does not require answering the check block before completing', () => {
    const onComplete = vi.fn()
    render(<LessonContent lesson={buildLesson([checkBlock])} onComplete={onComplete} isCompleted={false} />)

    fireEvent.click(screen.getByRole('button', { name: /Mark as Complete/ }))

    expect(onComplete).toHaveBeenCalledOnce()
  })
})
