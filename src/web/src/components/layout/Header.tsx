import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../../hooks/useAuth'
import { useState } from 'react'

export function Header() {
  const { user, signOut } = useAuth()
  const navigate = useNavigate()
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false)

  const handleSignOut = async () => {
    await signOut()
    navigate('/')
  }

  return (
    <header className="sticky top-0 z-50 border-b border-gray-200 bg-white">
      <div className="flex h-16 items-center justify-between px-4 lg:px-6">
        {/* Logo */}
        <Link to="/map" className="flex items-center gap-2">
          <span className="text-2xl">🦉</span>
          <span className="text-xl font-bold text-purple-600">NerdQuiz</span>
        </Link>

        {/* Desktop Navigation */}
        <nav className="hidden md:flex items-center gap-6">
          <Link 
            to="/map" 
            className="text-sm font-medium text-gray-600 hover:text-purple-600 transition-colors"
          >
            Learning Map
          </Link>
          <Link 
            to="/exam" 
            className="text-sm font-medium text-gray-600 hover:text-purple-600 transition-colors"
          >
            Exam
          </Link>
          <Link 
            to="/mistakes" 
            className="text-sm font-medium text-gray-600 hover:text-purple-600 transition-colors"
          >
            Mistakes
          </Link>
        </nav>

        {/* User Menu */}
        <div className="flex items-center gap-4">
          {user && (
            <>
              <div className="hidden sm:flex items-center gap-2 text-sm">
                <span className="text-purple-600 font-semibold">⚡ {user.total_xp ?? 0}</span>
                <span className="text-orange-500 font-semibold">🔥 {user.streak_count ?? 0}</span>
              </div>
              <Link 
                to="/profile"
                className="flex items-center gap-2 rounded-lg px-3 py-2 text-sm text-gray-700 hover:bg-gray-100"
              >
                {user.avatar_url ? (
                  <img 
                    src={user.avatar_url} 
                    alt="" 
                    className="h-6 w-6 rounded-full"
                  />
                ) : (
                  <div className="h-6 w-6 rounded-full bg-gray-200 flex items-center justify-center">
                    <span className="text-xs text-gray-500">
                      {user.display_name?.[0] || user.email?.[0] || '?'}
                    </span>
                  </div>
                )}
                <span className="hidden sm:inline">{user.display_name || 'Profile'}</span>
              </Link>
              <button
                onClick={handleSignOut}
                className="text-sm text-gray-500 hover:text-gray-700"
              >
                Sign out
              </button>
            </>
          )}

          {/* Mobile menu button */}
          <button
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            className="md:hidden p-2 rounded-lg text-gray-600 hover:bg-gray-100"
          >
            <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              {mobileMenuOpen ? (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
              ) : (
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              )}
            </svg>
          </button>
        </div>
      </div>

      {/* Mobile Navigation */}
      {mobileMenuOpen && (
        <nav className="md:hidden border-t border-gray-200 bg-white px-4 py-3">
          <div className="flex flex-col gap-2">
            <Link 
              to="/map" 
              className="rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100"
              onClick={() => setMobileMenuOpen(false)}
            >
              Learning Map
            </Link>
            <Link 
              to="/exam" 
              className="rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100"
              onClick={() => setMobileMenuOpen(false)}
            >
              Exam
            </Link>
            <Link 
              to="/mistakes" 
              className="rounded-lg px-3 py-2 text-sm font-medium text-gray-600 hover:bg-gray-100"
              onClick={() => setMobileMenuOpen(false)}
            >
              Mistakes
            </Link>
          </div>
        </nav>
      )}
    </header>
  )
}
