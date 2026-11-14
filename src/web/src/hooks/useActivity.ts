import { useCallback, useEffect, useState } from 'react'
import { api } from '../lib/api'
import type { DailyActivity } from '../types/Activity'

const API_ME_ACTIVITY = '/api/v1/me/activity'
const DEFAULT_ACTIVITY_DAYS = 7

interface UseActivityResult {
  /** One entry per day, oldest first; the last entry is today (server date). */
  activity: DailyActivity[]
  /** Today's entry, or null until loaded. */
  today: DailyActivity | null
  loading: boolean
  error: string | null
  refetch: () => void
}

/** Loads the signed-in user's daily activity for the last `days` days. */
export function useActivity(days: number = DEFAULT_ACTIVITY_DAYS): UseActivityResult {
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

  // The server returns days oldest first using its own date, so the last entry is "today"
  // without comparing against the browser's clock or timezone.
  const today = activity.length > 0 ? activity[activity.length - 1] : null

  return { activity, today, loading, error, refetch }
}
