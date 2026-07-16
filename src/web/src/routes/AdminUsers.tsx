import { useState } from 'react'
import { Users } from 'lucide-react'
import { useAdminUsers } from '../hooks/useAdminUsers'
import { UserFilters } from '../components/features/admin/UserFilters'
import { UserTable } from '../components/features/admin/UserTable'
import { UserCard } from '../components/features/admin/UserCard'
import { UserPagination } from '../components/features/admin/UserPagination'
import { UserDrawer } from '../components/features/admin/UserDrawer'

export function AdminUsers() {
  const { data, loading, error, filters, updateFilters, refetch } = useAdminUsers()
  const [selectedUserId, setSelectedUserId] = useState<string | null>(null)

  if (loading && !data) {
    return (
      <div className="flex min-h-[50vh] items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-purple-500 border-t-transparent" />
      </div>
    )
  }

  if (error) {
    return (
      <div className="flex min-h-[50vh] flex-col items-center justify-center gap-4">
        <p className="text-red-600">{error}</p>
        <button
          onClick={refetch}
          className="rounded-lg bg-purple-600 px-4 py-2 text-sm font-medium text-white hover:bg-purple-700"
        >
          Retry
        </button>
      </div>
    )
  }

  const users = data?.users ?? []
  const total = data?.total ?? 0

  return (
    <div className="space-y-6">
      <div className="flex items-center gap-3">
        <Users className="h-6 w-6 text-purple-600" />
        <h1 className="text-2xl font-bold text-gray-900 dark:text-gray-100">Users</h1>
      </div>

      <UserFilters filters={filters} onFilterChange={updateFilters} />

      {/* Desktop table */}
      <div className="hidden md:block">
        <UserTable
          users={users}
          filters={filters}
          onSort={(sort) => updateFilters({ sort, order: filters.sort === sort && filters.order === 'desc' ? 'asc' : 'desc' })}
          onSelectUser={setSelectedUserId}
        />
      </div>

      {/* Mobile cards */}
      <div className="space-y-3 md:hidden">
        {users.length === 0 ? (
          <div className="rounded-xl border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-8 text-center text-gray-500 dark:text-gray-400">
            No users found
          </div>
        ) : (
          users.map((user) => (
            <UserCard key={user.id} user={user} onSelectUser={setSelectedUserId} />
          ))
        )}
      </div>

      <UserPagination
        page={filters.page}
        pageSize={25}
        total={total}
        onPageChange={(page) => updateFilters({ page })}
      />

      <UserDrawer
        userId={selectedUserId}
        onClose={() => setSelectedUserId(null)}
        onUserUpdated={refetch}
      />
    </div>
  )
}
