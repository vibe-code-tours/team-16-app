import { useState, useEffect, useCallback } from 'react'
import { api } from '../lib/api'
import type { AdminUserDetail } from '../types'

export function useAdminUserDetail(userId: string | null) {
  const [user, setUser] = useState<AdminUserDetail | null>(null)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const fetchUser = useCallback(async () => {
    if (!userId) {
      setUser(null)
      return
    }

    setLoading(true)
    setError(null)
    try {
      const data = await api.get<AdminUserDetail>(`/api/v1/admin/users/${userId}`)
      setUser(data)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load user detail')
    } finally {
      setLoading(false)
    }
  }, [userId])

  useEffect(() => {
    fetchUser()
  }, [fetchUser])

  const updateRole = useCallback(async (newRole: string) => {
    if (!userId) return
    await api.patch(`/api/v1/admin/users/${userId}/role`, { role: newRole })
    await fetchUser()
  }, [userId, fetchUser])

  const deactivate = useCallback(async () => {
    if (!userId) return
    await api.post(`/api/v1/admin/users/${userId}/deactivate`)
    await fetchUser()
  }, [userId, fetchUser])

  const resetStreak = useCallback(async () => {
    if (!userId) return
    await api.post(`/api/v1/admin/users/${userId}/reset-streak`)
    await fetchUser()
  }, [userId, fetchUser])

  return { user, loading, error, refetch: fetchUser, updateRole, deactivate, resetStreak }
}
