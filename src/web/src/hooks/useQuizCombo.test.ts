import { describe, it, expect } from 'vitest'
import { renderHook, act } from '@testing-library/react'
import { useQuizCombo } from './useQuizCombo'

describe('useQuizCombo', () => {
  it('starts with no combo', () => {
    const { result } = renderHook(() => useQuizCombo())

    expect(result.current.combo).toBe(0)
  })

  it('increments the combo on each correct answer', () => {
    const { result } = renderHook(() => useQuizCombo())

    act(() => result.current.recordAnswer(true))
    expect(result.current.combo).toBe(1)

    act(() => result.current.recordAnswer(true))
    expect(result.current.combo).toBe(2)

    act(() => result.current.recordAnswer(true))
    expect(result.current.combo).toBe(3)
  })

  it('resets the combo on a wrong answer', () => {
    const { result } = renderHook(() => useQuizCombo())

    act(() => result.current.recordAnswer(true))
    act(() => result.current.recordAnswer(true))
    act(() => result.current.recordAnswer(false))
    expect(result.current.combo).toBe(0)

    act(() => result.current.recordAnswer(true))
    expect(result.current.combo).toBe(1)
  })
})
