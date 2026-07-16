import { useState, useEffect } from 'react'
import { Search, Download } from 'lucide-react'
import { Button } from '../../ui/Button'
import type { UserFilters as UserFiltersType } from '../../../types'

interface UserFiltersProps {
  filters: UserFiltersType
  onFilterChange: (updates: Partial<UserFiltersType>) => void
}

const FILTER_PRESETS = [
  { label: 'All Users', value: '' },
  { label: 'Active Today', value: 'active_today' },
  { label: 'Inactive 30d+', value: 'inactive_30d' },
  { label: 'New (7d)', value: 'new_7d' },
]

const ROLE_OPTIONS = [
  { label: 'All Roles', value: '' },
  { label: 'Admin', value: 'admin' },
  { label: 'User', value: 'user' },
  { label: 'Deactivated', value: 'deactivated' },
]

export function UserFilters({ filters, onFilterChange }: UserFiltersProps) {
  const [searchInput, setSearchInput] = useState(filters.search)

  useEffect(() => {
    const timer = setTimeout(() => {
      onFilterChange({ search: searchInput, page: 1 })
    }, 300)
    return () => clearTimeout(timer)
  }, [searchInput, onFilterChange])

  const handleExport = () => {
    const params = new URLSearchParams()
    if (filters.search) params.set('search', filters.search)
    if (filters.role) params.set('role', filters.role)
    if (filters.filter) params.set('filter', filters.filter)
    window.open(`/api/v1/admin/users/export?${params.toString()}`, '_blank')
  }

  return (
    <div className="space-y-4">
      {/* Quick filter pills */}
      <div className="flex flex-wrap gap-2">
        {FILTER_PRESETS.map((preset) => (
          <button
            key={preset.value}
            onClick={() => onFilterChange({ filter: preset.value, page: 1 })}
            className={`rounded-full px-4 py-1.5 text-sm font-medium transition-colors ${
              filters.filter === preset.value
                ? 'bg-purple-600 text-white'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            }`}
          >
            {preset.label}
          </button>
        ))}
      </div>

      {/* Search + Role + Export */}
      <div className="flex flex-col gap-3 sm:flex-row sm:items-center">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-gray-400" />
          <input
            type="text"
            placeholder="Search by name or email..."
            value={searchInput}
            onChange={(e) => setSearchInput(e.target.value)}
            className="w-full rounded-lg border border-gray-300 bg-white py-2 pl-10 pr-4 text-sm focus:border-purple-500 focus:outline-none focus:ring-1 focus:ring-purple-500"
          />
        </div>

        <select
          value={filters.role}
          onChange={(e) => onFilterChange({ role: e.target.value, page: 1 })}
          className="rounded-lg border border-gray-300 bg-white px-3 py-2 text-sm focus:border-purple-500 focus:outline-none focus:ring-1 focus:ring-purple-500"
        >
          {ROLE_OPTIONS.map((opt) => (
            <option key={opt.value} value={opt.value}>{opt.label}</option>
          ))}
        </select>

        <Button variant="outline" size="sm" onClick={handleExport}>
          <Download className="mr-1.5 h-4 w-4" />
          Export CSV
        </Button>
      </div>
    </div>
  )
}
