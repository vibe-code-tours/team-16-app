import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../../hooks/useAuth'
import { useState, useRef, useEffect, useCallback } from 'react'
import { ThemeToggle } from '../ui/ThemeToggle'

interface HeaderProps {
  onMenuToggle: () => void
  showSidebar?: boolean
}

export function Header({ onMenuToggle, showSidebar = true }: HeaderProps) {
  const { user, signOut } = useAuth()
  const navigate = useNavigate()
  const [dropdownOpen, setDropdownOpen] = useState(false)
  const dropdownRef = useRef<HTMLDivElement>(null)
  const menuItemsRef = useRef<(HTMLButtonElement | HTMLAnchorElement)[]>([])

  const handleSignOut = async () => {
    setDropdownOpen(false)
    await signOut()
    navigate('/')
  }

  const focusMenuItem = useCallback((index: number) => {
    const items = menuItemsRef.current
    if (items.length === 0) return
    const clampedIndex = Math.max(0, Math.min(index, items.length - 1))
    items[clampedIndex]?.focus()
  }, [])

  const handleDropdownKeyDown = useCallback((e: React.KeyboardEvent) => {
    if (!dropdownOpen) return

    const items = menuItemsRef.current
    const currentIndex = items.indexOf(document.activeElement as HTMLButtonElement | HTMLAnchorElement)

    switch (e.key) {
      case 'Escape':
        e.preventDefault()
        setDropdownOpen(false)
        break
      case 'ArrowDown':
        e.preventDefault()
        focusMenuItem(currentIndex < items.length - 1 ? currentIndex + 1 : 0)
        break
      case 'ArrowUp':
        e.preventDefault()
        focusMenuItem(currentIndex > 0 ? currentIndex - 1 : items.length - 1)
        break
      case 'Home':
        e.preventDefault()
        focusMenuItem(0)
        break
      case 'End':
        e.preventDefault()
        focusMenuItem(items.length - 1)
        break
    }
  }, [dropdownOpen, focusMenuItem])

  // Close dropdown on outside click
  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target as Node)) {
        setDropdownOpen(false)
      }
    }
    if (dropdownOpen) {
      document.addEventListener('mousedown', handleClickOutside)
      return () => document.removeEventListener('mousedown', handleClickOutside)
    }
  }, [dropdownOpen])

  return (
    <header className={`fixed top-0 z-50 inset-x-0 border-b border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 ${showSidebar ? 'lg:left-64' : ''}`}>
      <div className="flex h-16 items-center justify-between px-4 lg:px-6">
        {/* Left: Hamburger (mobile) + Logo */}
        <div className="flex items-center gap-3">
          <button
            onClick={onMenuToggle}
            aria-label="Toggle navigation menu"
            aria-expanded="false"
            aria-haspopup="true"
            className="p-2 rounded-lg text-gray-600 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 lg:hidden"
          >
            <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
            </svg>
          </button>
          <Link to="/map" className="flex items-center gap-2">
            <span className="text-2xl">🦉</span>
            <span className="text-xl font-bold text-purple-600 dark:text-purple-400">NerdQuiz</span>
          </Link>
        </div>

        {/* Right: Theme Toggle + XP + Streak + User Dropdown */}
        <div className="flex items-center gap-4">
          <ThemeToggle />

          {user && (
            <>
              {/* Hide XP and Streak for admin users */}
              {user.role !== 'admin' && (
                <div className="hidden sm:flex items-center gap-2 text-sm">
                  <span className="text-purple-600 dark:text-purple-400 font-semibold">⚡ {user.total_xp ?? 0}</span>
                  <span className="text-orange-500 dark:text-orange-400 font-semibold">🔥 {user.streak_count ?? 0}</span>
                </div>
              )}

              {/* User Dropdown */}
              <div className="relative" ref={dropdownRef}>
                <button
                  onClick={() => setDropdownOpen(!dropdownOpen)}
                  aria-label="User menu"
                  aria-expanded={dropdownOpen}
                  aria-haspopup="true"
                  className="flex items-center gap-2 rounded-lg px-3 py-2 text-sm text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700"
                >
                  {user.avatar_url ? (
                    <img
                      src={user.avatar_url}
                      alt={`${user.display_name || 'User'} avatar`}
                      className="h-6 w-6 rounded-full"
                    />
                  ) : (
                    <div className="h-6 w-6 rounded-full bg-gray-200 dark:bg-gray-600 flex items-center justify-center">
                      <span className="text-xs text-gray-500 dark:text-gray-300">
                        {user.display_name?.[0] || user.email?.[0] || '?'}
                      </span>
                    </div>
                  )}
                  <span className="hidden sm:inline">{user.display_name || 'Profile'}</span>
                  <svg
                    className={`h-4 w-4 text-gray-400 dark:text-gray-500 transition-transform ${dropdownOpen ? 'rotate-180' : ''}`}
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                  </svg>
                </button>

                {dropdownOpen && (
                  <div
                    role="menu"
                    aria-label="User menu"
                    onKeyDown={handleDropdownKeyDown}
                    className="absolute right-0 mt-1 w-48 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg shadow-lg py-1 z-50"
                  >
                    <Link
                      to="/profile"
                      role="menuitem"
                      ref={(el) => { if (el) menuItemsRef.current[0] = el }}
                      tabIndex={0}
                      className="flex items-center gap-2 px-4 py-2 text-sm text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700"
                      onClick={() => setDropdownOpen(false)}
                    >
                      <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                      </svg>
                      Profile
                    </Link>
                    <hr className="my-1 border-gray-200 dark:border-gray-700" />
                    <button
                      onClick={handleSignOut}
                      role="menuitem"
                      ref={(el) => { if (el) menuItemsRef.current[1] = el }}
                      tabIndex={-1}
                      className="flex items-center gap-2 w-full px-4 py-2 text-sm text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20"
                    >
                      <svg className="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                      </svg>
                      Sign out
                    </button>
                  </div>
                )}
              </div>
            </>
          )}
        </div>
      </div>
    </header>
  )
}
