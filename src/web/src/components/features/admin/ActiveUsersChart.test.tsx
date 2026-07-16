import { describe, it, expect, beforeAll, afterAll } from 'vitest'
import { render, screen } from '@testing-library/react'
import { ActiveUsersChart } from './ActiveUsersChart'

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

describe('ActiveUsersChart', () => {
  it('shows empty state when data is empty', () => {
    render(
      <div style={{ width: 600, height: 300 }}>
        <ActiveUsersChart data={[]} />
      </div>,
    )
    expect(screen.getByText('No activity data yet')).toBeInTheDocument()
  })

  it('renders chart with data', () => {
    const { container } = render(
      <div style={{ width: 600, height: 300 }}>
        <ActiveUsersChart data={[{ date: '2026-07-01', activeUsers: 5 }]} />
      </div>,
    )
    expect(screen.queryByText('No activity data yet')).not.toBeInTheDocument()
    expect(container.querySelector('.recharts-wrapper')).toBeInTheDocument()
  })
})
