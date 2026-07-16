import { Badge } from '../../ui/Badge'
import { timeAgo } from '../../../lib/timeAgo'
import type { AdminUserSummary } from '../../../types'

interface UserCardProps {
  user: AdminUserSummary
  onSelectUser: (userId: string) => void
}

export function UserCard({ user, onSelectUser }: UserCardProps) {
  return (
    <div
      onClick={() => onSelectUser(user.id)}
      className="cursor-pointer rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-4 shadow-sm transition-colors hover:bg-gray-50 dark:hover:bg-gray-700/50"
    >
      <div className="flex items-start justify-between">
        <div className="flex items-center gap-3">
          {user.avatarUrl ? (
            <img src={user.avatarUrl} alt="" className="h-10 w-10 rounded-full" />
          ) : (
            <div className="flex h-10 w-10 items-center justify-center rounded-full bg-purple-100 dark:bg-purple-900/30 text-sm font-medium text-purple-700 dark:text-purple-400">
              {(user.displayName || user.email).charAt(0).toUpperCase()}
            </div>
          )}
          <div>
            <p className="font-medium text-gray-900 dark:text-gray-100">{user.displayName || 'Unnamed'}</p>
            <p className="text-sm text-gray-500 dark:text-gray-400">{user.email}</p>
          </div>
        </div>
        <Badge variant={user.role === 'admin' ? 'info' : user.role === 'deactivated' ? 'error' : 'default'}>
          {user.role}
        </Badge>
      </div>

      <div className="mt-3 flex items-center gap-4 text-sm">
        <span className={`inline-flex items-center gap-1.5 ${user.status === 'active' ? 'text-green-700 dark:text-green-400' : 'text-gray-500 dark:text-gray-400'}`}>
          <span className={`h-1.5 w-1.5 rounded-full ${user.status === 'active' ? 'bg-green-500' : 'bg-gray-400 dark:bg-gray-500'}`} />
          {timeAgo(user.lastLoginAt)}
        </span>
        <span className="text-gray-700 dark:text-gray-300">XP: {(user.totalXp ?? 0).toLocaleString()}</span>
        <span className="text-gray-700 dark:text-gray-300">Streak: {user.streakCount ?? 0}d</span>
      </div>
    </div>
  )
}
