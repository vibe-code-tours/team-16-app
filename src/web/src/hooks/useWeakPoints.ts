import { useEffect, useState, useCallback } from 'react'
import { api } from '../lib/api'
import { useAuth } from './useAuth.tsx'
import type { WeakPointAnalysis } from '../types/WeakPoint'

interface UseWeakPointsResult {
  data: WeakPointAnalysis | null
  loading: boolean
  error: string | null
  refetch: () => void
}

export function useWeakPoints(): UseWeakPointsResult {
  const { user } = useAuth()
  const [data, setData] = useState<WeakPointAnalysis | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [fetchTrigger, setFetchTrigger] = useState(0)

  const refetch = useCallback(() => {
    setFetchTrigger((prev) => prev + 1)
  }, [])

  useEffect(() => {
    let cancelled = false

    async function load() {
      setLoading(true)
      setError(null)
      try {
        const fetched = await api.get<WeakPointAnalysis>('/api/v1/me/weak-points')
        if (cancelled) return
        setData(fetched)
      } catch (e) {
        if (cancelled) return
        setError(e instanceof Error ? e.message : 'Failed to load weak point analysis')
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    load()

    return () => {
      cancelled = true
    }
  }, [user?.id, fetchTrigger])

  return { data, loading, error, refetch }
}
