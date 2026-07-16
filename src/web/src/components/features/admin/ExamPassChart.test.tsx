import { describe, it, expect, beforeAll, afterAll } from 'vitest'
import { render, screen } from '@testing-library/react'
import { ExamPassChart } from './ExamPassChart'

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

describe('ExamPassChart', () => {
  it('shows empty state when totalAttempts is 0', () => {
    render(
      <div style={{ width: 600, height: 300 }}>
        <ExamPassChart passRate={0} totalAttempts={0} />
      </div>,
    )
    expect(screen.getByText('No exam data yet')).toBeInTheDocument()
  })

  it('renders pie chart with data', () => {
    const { container } = render(
      <div style={{ width: 600, height: 300 }}>
        <ExamPassChart passRate={60} totalAttempts={10} />
      </div>,
    )
    expect(screen.queryByText('No exam data yet')).not.toBeInTheDocument()
    expect(container.querySelector('.recharts-wrapper')).toBeInTheDocument()
  })
})
