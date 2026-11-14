import { useState, useEffect, useCallback } from 'react'
import { api } from '../lib/api'
import type { Mistake } from '../types/Mistake'

export const API_MISTAKES = '/api/v1/me/mistakes'
export const API_DUE_MISTAKES = `${API_MISTAKES}/due`
/** Records a wrong answer; on an existing mistake it resets the review interval to 1 day. */
export const API_RECORD_MISTAKE = '/api/v1/mistakes'

interface UseMistakesResult {
  mistakes: Mistake[]
  dueMistakes: Mistake[]
  loading: boolean
  error: string | null
  clearedCount: number
  refetch: () => Promise<void>
  markReviewed: (mistakeId: string) => Promise<void>
  recordMiss: (questionId: string, selectedLabel: string) => Promise<void>
}

/** Loads the user's mistakes plus the ones due for spaced review, and tracks how many were cleared this session. */
export function useMistakes(): UseMistakesResult {
  const [mistakes, setMistakes] = useState<Mistake[]>([])
  const [dueMistakes, setDueMistakes] = useState<Mistake[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [clearedCount, setClearedCount] = useState(0)

  const refetch = useCallback(async () => {
    setLoading(true)
    setError(null)
    try {
      const [openMistakes, dueNow] = await Promise.all([
        api.get<Mistake[]>(API_MISTAKES),
        api.get<Mistake[]>(API_DUE_MISTAKES),
      ])
      setMistakes(openMistakes)
      setDueMistakes(dueNow)
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
      const isOther = (mistake: Mistake) => mistake.id !== mistakeId
      setMistakes((previous) => previous.filter(isOther))
      setDueMistakes((previous) => previous.filter(isOther))
      setClearedCount((previous) => previous + 1)
    } catch (requestError) {
      setError(requestError instanceof Error ? requestError.message : 'Failed to review mistake')
    }
  }, [])

  // The card stays on screen after a miss so the explanation remains visible;
  // the reset schedule takes effect on the next load.
  const recordMiss = useCallback(async (questionId: string, selectedLabel: string) => {
    setError(null)
    try {
      await api.post(API_RECORD_MISTAKE, { questionId, selectedLabel })
    } catch (requestError) {
      setError(requestError instanceof Error ? requestError.message : 'Failed to save your retry')
    }
  }, [])

  return { mistakes, dueMistakes, loading, error, clearedCount, refetch, markReviewed, recordMiss }
}
