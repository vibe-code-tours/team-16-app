import { useState, useEffect, useCallback } from 'react'
import { api } from '../lib/api'
import type { Mistake } from '../types/Mistake'

export const API_MISTAKES = '/api/v1/me/mistakes'

interface UseMistakesResult {
  mistakes: Mistake[]
  loading: boolean
  error: string | null
  clearedCount: number
  refetch: () => Promise<void>
  markReviewed: (mistakeId: string) => Promise<void>
}

/** Loads the user's open mistakes and tracks how many were cleared this session. */
export function useMistakes(): UseMistakesResult {
  const [mistakes, setMistakes] = useState<Mistake[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [clearedCount, setClearedCount] = useState(0)

  const refetch = useCallback(async () => {
    setLoading(true)
    setError(null)
    try {
      const openMistakes = await api.get<Mistake[]>(API_MISTAKES)
      setMistakes(openMistakes)
    } catch (requestError) {
      setError(requestError instanceof Error ? requestError.message : 'Failed to load mistakes')
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    refetch()
  }, [refetch])

  const markReviewed = useCallback(async (mistakeId: string) => {
    setError(null)
    try {
      await api.put(`${API_MISTAKES}/${mistakeId}/review`)
      setMistakes((previous) => previous.filter((mistake) => mistake.id !== mistakeId))
      setClearedCount((previous) => previous + 1)
    } catch (requestError) {
      setError(requestError instanceof Error ? requestError.message : 'Failed to review mistake')
    }
  }, [])

  return { mistakes, loading, error, clearedCount, refetch, markReviewed }
}
