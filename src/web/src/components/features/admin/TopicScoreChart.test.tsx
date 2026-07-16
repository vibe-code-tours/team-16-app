import { describe, it, expect, beforeAll, afterAll } from 'vitest'
import { render, screen } from '@testing-library/react'
import { TopicScoreChart } from './TopicScoreChart'

class MockResizeObserver {
  private callback: ResizeObserverCallback
  constructor(callback: ResizeObserverCallback) {
    this.callback = callback
  }
  observe(target: Element) {
    this.callback(
      [{ target, contentRect: { width: 600, height: 300 } as DOMRectReadOnly } as ResizeObserverEntry],
      this as unknown as ResizeObserver,
    )
  }
  unobserve() {}
  disconnect() {}
}

beforeAll(() => {
  globalThis.ResizeObserver = MockResizeObserver as unknown as typeof ResizeObserver
})

afterAll(() => {
  delete (globalThis as Record<string, unknown>).ResizeObserver
})

describe('TopicScoreChart', () => {
  it('shows empty state when data is empty', () => {
    render(
      <div style={{ width: 600, height: 300 }}>
        <TopicScoreChart data={[]} />
      </div>,
    )
    expect(screen.getByText('No score data yet')).toBeInTheDocument()
  })

  it('renders chart with data', () => {
    const { container } = render(
      <div style={{ width: 600, height: 300 }}>
        <TopicScoreChart data={[{ topicName: 'Security', quizCount: 30, avgScore: 68.5 }]} />
      </div>,
    )
    expect(screen.queryByText('No score data yet')).not.toBeInTheDocument()
    expect(container.querySelector('.recharts-wrapper')).toBeInTheDocument()
  })
})
