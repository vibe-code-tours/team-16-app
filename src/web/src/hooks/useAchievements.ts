import { useCallback, useEffect, useMemo, useState } from 'react'
import { api } from '../lib/api'
import { selectNextGoal } from '../lib/achievementProgress'
import type { Achievement } from '../types/Achievement'

const API_ME_ACHIEVEMENTS = '/api/v1/me/achievements'

interface UseAchievementsResult {
  achievements: Achievement[]
  unlockedCount: number
  nextGoal: Achievement | null
  loading: boolean
  error: string | null
  refetch: () => void
}

export function useAchievements(): UseAchievementsResult {
  const [achievements, setAchievements] = useState<Achievement[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [fetchTrigger, setFetchTrigger] = useState(0)

  const refetch = useCallback(() => {
    setFetchTrigger((prev) => prev + 1)
  }, [])

  useEffect(() => {
    let cancelled = false

    async function loadAchievements() {
      setLoading(true)
      setError(null)
      try {
        const fetched = await api.get<Achievement[]>(API_ME_ACHIEVEMENTS)
        if (!cancelled) setAchievements(fetched ?? [])
      } catch (err) {
        if (!cancelled) {
          setError(err instanceof Error ? err.message : 'Failed to load achievements')
        }
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    loadAchievements()

    return () => {
      cancelled = true
    }
  }, [fetchTrigger])

  const unlockedCount = useMemo(
    () => achievements.filter((achievement) => achievement.unlocked).length,
    [achievements],
  )
  const nextGoal = useMemo(() => selectNextGoal(achievements), [achievements])

  return { achievements, unlockedCount, nextGoal, loading, error, refetch }
}
