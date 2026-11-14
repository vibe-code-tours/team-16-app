import { useCallback, useEffect, useState } from 'react'
import { api } from '../lib/api'
import type { DailyActivity } from '../types/Activity'

const API_ME_ACTIVITY = '/api/v1/me/activity'

interface UseActivityResult {
  activity: DailyActivity[]
  loading: boolean
  error: string | null
  refetch: () => void
}

/** Loads the signed-in user's per-day activity for the last `days` days, oldest first. */
export function useActivity(days: number): UseActivityResult {
  const [activity, setActivity] = useState<DailyActivity[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [fetchTrigger, setFetchTrigger] = useState(0)

  const refetch = useCallback(() => {
    setFetchTrigger((prev) => prev + 1)
  }, [])

  useEffect(() => {
    let cancelled = false

    async function loadActivity() {
      setLoading(true)
      setError(null)
      try {
        const fetched = await api.get<DailyActivity[]>(`${API_ME_ACTIVITY}?days=${days}`)
        if (cancelled) return
        setActivity(fetched ?? [])
      } catch (e) {
        if (cancelled) return
        setError(e instanceof Error ? e.message : 'Failed to load activity')
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    loadActivity()

    return () => {
      cancelled = true
    }
  }, [days, fetchTrigger])

  return { activity, loading, error, refetch }
}
