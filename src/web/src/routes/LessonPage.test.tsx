import { render, screen, fireEvent } from '@testing-library/react'
import { MemoryRouter, Route, Routes } from 'react-router-dom'
import { beforeEach, describe, expect, it, vi } from 'vitest'
import { api } from '../lib/api'
import { LessonPage } from './LessonPage'

vi.mock('../lib/api', () => ({ api: { get: vi.fn(), post: vi.fn() } }))

const mockGet = vi.mocked(api.get)

function mockLesson(contentBlocks: unknown[]) {
  mockGet.mockImplementation(async (path: string) => {
    if (path.startsWith('/api/v1/lessons/')) {
      return {
        id: 'lesson-1',
        subtopic_id: 'subtopic-1',
        topic_id: 'topic-1',
        subtopic_name: 'Computer Architecture',
        title: 'What is a CPU?',
        content_blocks: contentBlocks,
        summary: null,
      }
    }
    return [{ id: 'lesson-1', title: 'What is a CPU?', display_order: 1 }]
  })
}

function renderPage() {
  render(
    <MemoryRouter initialEntries={['/lesson/lesson-1']}>
      <Routes>
        <Route path="/lesson/:lessonId" element={<LessonPage />} />
      </Routes>
    </MemoryRouter>,
  )
}

describe('LessonPage', () => {
  beforeEach(() => {
    mockGet.mockReset()
  })

  it('renders a check block and gives feedback when a choice is picked', async () => {
    mockLesson([
      {
        type: 'check',
        question: 'Which CPU unit performs arithmetic?',
        choices: ['Control Unit', 'ALU'],
        answer: 1,
        explanation: 'The ALU handles arithmetic and logic.',
      },
    ])
    renderPage()

    fireEvent.click(await screen.findByRole('button', { name: 'Control Unit' }))

    expect(screen.getByText('Not quite. The answer is: ALU')).toBeInTheDocument()
    expect(screen.getByText('The ALU handles arithmetic and logic.')).toBeInTheDocument()
  })

  it('keeps rendering the lesson when blocks are unknown or malformed', async () => {
    mockLesson([
      { type: 'text', content: 'The CPU runs programs.' },
      { type: 'video', url: 'https://example.com' },
      { type: 'check', question: 'Broken?', choices: [], answer: 0 },
      { type: 'list', items: 'not-an-array' },
      null,
    ])
    renderPage()

    expect(await screen.findByText('The CPU runs programs.')).toBeInTheDocument()
    expect(screen.queryByText('Broken?')).not.toBeInTheDocument()
    expect(screen.getByRole('button', { name: "I've read it!" })).toBeInTheDocument()
  })
})
