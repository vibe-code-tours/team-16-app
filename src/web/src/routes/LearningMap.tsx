import { useAuth } from '../hooks/useAuth.tsx'

export function LearningMap() {
  const { user, signOut } = useAuth()

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-4">
          <h1 className="text-xl font-bold text-purple-600">NerdQuiz</h1>
          <div className="flex items-center gap-4">
            <span className="text-sm text-gray-500">
              {user?.display_name || user?.id?.slice(0, 8)}
            </span>
            <button
              onClick={signOut}
              className="rounded-md border border-gray-300 px-3 py-1.5 text-sm text-gray-700 hover:bg-gray-50"
            >
              Sign out
            </button>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-4xl px-4 py-8">
        <h2 className="mb-4 text-2xl font-bold text-gray-900">Learning Map</h2>
        <p className="text-gray-500">
          Your study topics will appear here. This is a placeholder — the full learning
          map feature is coming soon.
        </p>

        <div className="mt-8 rounded-xl border border-gray-200 bg-white p-6">
          <h3 className="mb-2 font-semibold text-gray-900">Your Progress</h3>
          <div className="flex gap-6 text-sm text-gray-500">
            <div>
              <span className="block text-2xl font-bold text-purple-600">{user?.total_xp ?? 0}</span>
              XP earned
            </div>
            <div>
              <span className="block text-2xl font-bold text-orange-500">{user?.streak_count ?? 0}</span>
              Day streak
            </div>
          </div>
        </div>
      </main>
    </div>
  )
}
