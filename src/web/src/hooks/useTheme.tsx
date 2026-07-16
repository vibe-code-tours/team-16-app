import { useState, useEffect, useCallback, createContext, useContext, type ReactNode } from 'react'

type Theme = 'light' | 'dark'

interface ThemeContextType {
  theme: Theme
  toggleTheme: () => void
}

const ThemeContext = createContext<ThemeContextType | null>(null)

const STORAGE_KEY = 'nerdquiz-theme'

function getInitialTheme(): Theme {
  if (typeof window === 'undefined') return 'light'

  const stored = localStorage.getItem(STORAGE_KEY)
  if (stored === 'light' || stored === 'dark') return stored

  if (typeof window.matchMedia === 'function') {
    return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
  }

  return 'light'
}

export function ThemeProvider({ children }: { children: ReactNode }) {
  const [theme, setTheme] = useState<Theme>(getInitialTheme)

  useEffect(() => {
    const root = document.documentElement
    if (theme === 'dark') {
      root.classList.add('dark')
    } else {
      root.classList.remove('dark')
    }
    localStorage.setItem(STORAGE_KEY, theme)
  }, [theme])

  // Listen for system preference changes when no explicit choice has been made
  useEffect(() => {
    const stored = localStorage.getItem(STORAGE_KEY)
    if (stored) return // User has an explicit preference — don't override

    if (typeof window.matchMedia !== 'function') return

    const mq = window.matchMedia('(prefers-color-scheme: dark)')
    function handleChange(e: MediaQueryListEvent) {
      setTheme(e.matches ? 'dark' : 'light')
    }
    mq.addEventListener('change', handleChange)
    return () => mq.removeEventListener('change', handleChange)
  }, [])

  const toggleTheme = useCallback(() => {
    setTheme((prev) => (prev === 'light' ? 'dark' : 'light'))
  }, [])

  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  )
}

export function useTheme(): ThemeContextType {
  const context = useContext(ThemeContext)
  if (!context) {
    throw new Error('useTheme must be used within a ThemeProvider')
  }
  return context
}
