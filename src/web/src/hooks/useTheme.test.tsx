import { fireEvent, render, screen } from '@testing-library/react'
import { afterEach, describe, expect, it, vi } from 'vitest'
import { ThemeProvider, useTheme } from './useTheme'

function ThemeConsumer() {
  const { theme, setTheme } = useTheme()
  return <button onClick={() => setTheme('dark')}>{theme}</button>
}

describe('ThemeProvider storage handling', () => {
  afterEach(() => vi.restoreAllMocks())

  it('falls back to system theme when reading storage throws', () => {
    vi.spyOn(Storage.prototype, 'getItem').mockImplementation(() => {
      throw new DOMException('Storage unavailable')
    })
    render(<ThemeProvider><ThemeConsumer /></ThemeProvider>)
    expect(screen.getByRole('button')).toHaveTextContent('system')
  })

  it('changes the current theme when writing storage throws', () => {
    vi.spyOn(Storage.prototype, 'setItem').mockImplementation(() => {
      throw new DOMException('Storage unavailable')
    })
    render(<ThemeProvider><ThemeConsumer /></ThemeProvider>)
    fireEvent.click(screen.getByRole('button'))
    expect(screen.getByRole('button')).toHaveTextContent('dark')
  })
})
