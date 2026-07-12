import { useState } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth'

export function UserProfile() {
  const { user, session, signOut, updateProfile } = useAuth()
  const [editingName, setEditingName] = useState(false)
  const [displayName, setDisplayName] = useState(user?.display_name ?? '')
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const email = session?.user?.email ?? null
  const memberSince = user?.created_at
    ? new Date(user.created_at).toLocaleDateString()
    : null

  async function handleSaveName() {
    if (!displayName.trim()) {
      setError('Display name cannot be empty')
      return
    }
    setSaving(true)
    setError(null)
    const { error: updateError } = await updateProfile({ display_name: displayName.trim() })
    if (updateError) {
      setError(updateError)
    } else {
      setEditingName(false)
    }
    setSaving(false)
  }

  function handleCancelEdit() {
    setDisplayName(user?.display_name ?? '')
    setEditingName(false)
    setError(null)
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-2xl items-center gap-3 px-4 py-3">
          <Link
            to="/map"
            className="text-sm text-purple-600 hover:text-purple-700"
          >
            ← Back to map
          </Link>
        </div>
      </header>

      <main className="mx-auto max-w-2xl px-4 py-8">
        <h1 className="mb-6 text-2xl font-bold text-gray-900">Profile</h1>

        {/* Avatar + Name section */}
        <section className="rounded-xl border border-gray-200 bg-white p-6">
          <div className="flex items-center gap-4">
            <div className="relative h-16 w-16 shrink-0">
              {user?.avatar_url && user.avatar_url.startsWith('http') ? (
                <img
                  src={user.avatar_url}
                  alt="Avatar"
                  className="h-16 w-16 rounded-full object-cover"
                  onError={(e) => {
                    e.currentTarget.style.display = 'none'
                    e.currentTarget.nextElementSibling?.classList.remove('hidden')
                  }}
                />
              ) : null}
              <div className={`flex h-16 w-16 items-center justify-center rounded-full bg-gray-200 ${user?.avatar_url && user.avatar_url.startsWith('http') ? 'hidden' : ''}`}>
                <svg className="h-10 w-10 text-gray-400" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                </svg>
              </div>
            </div>

            <div className="flex-1">
              {editingName ? (
                <div className="flex items-center gap-2">
                  <input
                    type="text"
                    value={displayName}
                    onChange={(e) => setDisplayName(e.target.value)}
                    className="flex-1 rounded-md border border-gray-300 px-3 py-1.5 text-sm focus:border-purple-500 focus:outline-none focus:ring-1 focus:ring-purple-500"
                    placeholder="Enter display name"
                    autoFocus
                  />
                  <button
                    onClick={handleSaveName}
                    disabled={saving}
                    className="rounded-md bg-purple-600 px-3 py-1.5 text-sm font-medium text-white hover:bg-purple-700 disabled:opacity-50"
                  >
                    {saving ? 'Saving...' : 'Save'}
                  </button>
                  <button
                    onClick={handleCancelEdit}
                    className="rounded-md border border-gray-300 px-3 py-1.5 text-sm text-gray-700 hover:bg-gray-50"
                  >
                    Cancel
                  </button>
                </div>
              ) : (
                <div className="flex items-center gap-2">
                  <h2 className="text-lg font-semibold text-gray-900">
                    {user?.display_name || 'No name set'}
                  </h2>
                  <button
                    onClick={() => setEditingName(true)}
                    className="text-sm text-purple-600 hover:text-purple-700"
                  >
                    Edit
                  </button>
                </div>
              )}
              {error && (
                <p className="mt-1 text-sm text-red-600">{error}</p>
              )}
            </div>
          </div>
        </section>

        {/* Account info */}
        <section className="mt-4 rounded-xl border border-gray-200 bg-white p-6">
          <h3 className="mb-4 text-sm font-semibold uppercase tracking-wider text-gray-500">
            Account
          </h3>
          <dl className="space-y-3">
            <div className="flex justify-between">
              <dt className="text-sm text-gray-500">Email</dt>
              <dd className="text-sm font-medium text-gray-900">{email ?? '—'}</dd>
            </div>
            <div className="flex justify-between">
              <dt className="text-sm text-gray-500">Member since</dt>
              <dd className="text-sm font-medium text-gray-900">{memberSince ?? '—'}</dd>
            </div>
          </dl>
        </section>

        {/* Stats */}
        <section className="mt-4 rounded-xl border border-gray-200 bg-white p-6">
          <h3 className="mb-4 text-sm font-semibold uppercase tracking-wider text-gray-500">
            Stats
          </h3>
          <div className="grid grid-cols-2 gap-4">
            <div className="text-center">
              <div className="text-2xl font-bold text-purple-600">
                {user?.total_xp ?? 0}
              </div>
              <div className="text-sm text-gray-500">Total XP</div>
            </div>
            <div className="text-center">
              <div className="text-2xl font-bold text-orange-500">
                {user?.streak_count ?? 0}
              </div>
              <div className="text-sm text-gray-500">Day Streak</div>
            </div>
          </div>
        </section>

        {/* Sign out */}
        <div className="mt-6">
          <button
            onClick={signOut}
            className="w-full rounded-xl border border-gray-300 bg-white py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-50"
          >
            Sign out
          </button>
        </div>
      </main>
    </div>
  )
}
