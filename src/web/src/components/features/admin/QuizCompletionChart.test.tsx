import { describe, it, expect, beforeAll, afterAll } from 'vitest'
import { render, screen } from '@testing-library/react'
import { QuizCompletionChart } from './QuizCompletionChart'

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

describe('QuizCompletionChart', () => {
  it('shows empty state when total is 0', () => {
    render(
      <div style={{ width: 600, height: 300 }}>
        <QuizCompletionChart completed={0} total={0} />
      </div>,
    )
    expect(screen.getByText('No quiz data yet')).toBeInTheDocument()
  })

  it('renders pie chart with data', () => {
    const { container } = render(
      <div style={{ width: 600, height: 300 }}>
        <QuizCompletionChart completed={80} total={100} />
      </div>,
    )
    expect(screen.queryByText('No quiz data yet')).not.toBeInTheDocument()
    expect(container.querySelector('.recharts-wrapper')).toBeInTheDocument()
  })
})
