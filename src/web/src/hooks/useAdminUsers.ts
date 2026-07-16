import { useState, useEffect, useCallback } from 'react'
import { api } from '../lib/api'
import type { AdminUserListResponse, UserFilters } from '../types'

const DEFAULT_FILTERS: UserFilters = {
  search: '',
  role: '',
  filter: '',
  sort: 'last_login_at',
  order: 'desc',
  page: 1,
}

export function useAdminUsers() {
  const [filters, setFilters] = useState<UserFilters>(DEFAULT_FILTERS)
  const [data, setData] = useState<AdminUserListResponse | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  const fetchUsers = useCallback(async (currentFilters: UserFilters) => {
    setLoading(true)
    setError(null)
    try {
      const params = new URLSearchParams()
      params.set('page', String(currentFilters.page))
      params.set('pageSize', '25')
      if (currentFilters.search) params.set('search', currentFilters.search)
      if (currentFilters.role) params.set('role', currentFilters.role)
      if (currentFilters.filter) params.set('filter', currentFilters.filter)
      params.set('sort', currentFilters.sort)
      params.set('order', currentFilters.order)

      const result = await api.get<AdminUserListResponse>(`/api/v1/admin/users?${params.toString()}`)
      setData(result)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load users')
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    fetchUsers(filters)
  }, [filters, fetchUsers])

  const updateFilters = useCallback((updates: Partial<UserFilters>) => {
    setFilters((prev) => ({ ...prev, ...updates, page: updates.page ?? (updates.search || updates.role || updates.filter ? 1 : prev.page) }))
  }, [])

  return { data, loading, error, filters, updateFilters, refetch: () => fetchUsers(filters) }
}
