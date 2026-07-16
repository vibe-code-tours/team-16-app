import { ChevronUp, ChevronDown } from 'lucide-react'
import { Badge } from '../../ui/Badge'
import { timeAgo } from '../../../lib/timeAgo'
import type { AdminUserSummary, UserFilters } from '../../../types'

interface UserTableProps {
  users: AdminUserSummary[]
  filters: UserFilters
  onSort: (sort: string) => void
  onSelectUser: (userId: string) => void
}

function SortHeader({ label, sortKey, currentSort, currentOrder, onSort }: {
  label: string
  sortKey: string
  currentSort: string
  currentOrder: string
  onSort: (sort: string) => void
}) {
  const isActive = currentSort === sortKey
  return (
    <th
      className="cursor-pointer select-none px-4 py-3 text-left text-xs font-medium text-gray-500 hover:text-gray-700"
      onClick={() => onSort(sortKey)}
    >
      <span className="inline-flex items-center gap-1">
        {label}
        {isActive && (
          currentOrder === 'asc'
            ? <ChevronUp className="h-3 w-3" />
            : <ChevronDown className="h-3 w-3" />
        )}
      </span>
    </th>
  )
}

export function UserTable({ users, filters, onSort, onSelectUser }: UserTableProps) {
  const toggleOrder = (sortKey: string) => {
    if (filters.sort === sortKey) {
      onSort(filters.order === 'asc' ? 'desc' : 'asc')
    } else {
      onSort('desc')
    }
  }

  return (
    <div className="overflow-x-auto rounded-xl border border-gray-200 bg-white shadow-sm">
      <table className="w-full text-left text-sm">
        <thead>
          <tr className="border-b border-gray-100 bg-gray-50">
            <th className="px-4 py-3 text-xs font-medium text-gray-500">User</th>
            <th className="px-4 py-3 text-xs font-medium text-gray-500">Role</th>
            <th className="px-4 py-3 text-xs font-medium text-gray-500">Status</th>
            <SortHeader label="Last Active" sortKey="last_login_at" currentSort={filters.sort} currentOrder={filters.order} onSort={toggleOrder} />
            <SortHeader label="XP" sortKey="total_xp" currentSort={filters.sort} currentOrder={filters.order} onSort={toggleOrder} />
            <SortHeader label="Streak" sortKey="streak_count" currentSort={filters.sort} currentOrder={filters.order} onSort={toggleOrder} />
            <SortHeader label="Joined" sortKey="created_at" currentSort={filters.sort} currentOrder={filters.order} onSort={toggleOrder} />
          </tr>
        </thead>
        <tbody>
          {users.map((user) => (
            <tr
              key={user.id}
              onClick={() => onSelectUser(user.id)}
              className="cursor-pointer border-b border-gray-50 transition-colors hover:bg-gray-50 last:border-0"
            >
              <td className="px-4 py-3">
                <div className="flex items-center gap-3">
                  {user.avatarUrl ? (
                    <img src={user.avatarUrl} alt="" className="h-8 w-8 rounded-full" />
                  ) : (
                    <div className="flex h-8 w-8 items-center justify-center rounded-full bg-purple-100 text-sm font-medium text-purple-700">
                      {(user.displayName || user.email).charAt(0).toUpperCase()}
                    </div>
                  )}
                  <div>
                    <p className="font-medium text-gray-900">{user.displayName || 'Unnamed'}</p>
                    <p className="text-xs text-gray-500">{user.email}</p>
                  </div>
                </div>
              </td>
              <td className="px-4 py-3">
                <Badge variant={user.role === 'admin' ? 'info' : user.role === 'deactivated' ? 'error' : 'default'}>
                  {user.role}
                </Badge>
              </td>
              <td className="px-4 py-3">
                <span className={`inline-flex items-center gap-1.5 text-xs font-medium ${user.status === 'active' ? 'text-green-700' : 'text-gray-500'}`}>
                  <span className={`h-1.5 w-1.5 rounded-full ${user.status === 'active' ? 'bg-green-500' : 'bg-gray-400'}`} />
                  {user.status === 'active' ? 'Active' : 'Inactive'}
                </span>
              </td>
              <td className="px-4 py-3 text-gray-700">{timeAgo(user.lastLoginAt)}</td>
              <td className="px-4 py-3 font-medium text-gray-900">{(user.totalXp ?? 0).toLocaleString()}</td>
              <td className="px-4 py-3 text-gray-700">{user.streakCount ?? 0}d</td>
              <td className="px-4 py-3 text-gray-700">{new Date(user.createdAt).toLocaleDateString()}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}
