import { Navigate } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth.tsx'

interface StudentRouteProps {
  children: React.ReactNode
}

/**
 * Route guard that only allows non-admin users (students).
 * Admin users are redirected to /admin dashboard.
 */
export function StudentRoute({ children }: StudentRouteProps) {
  const { user, loading } = useAuth()

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-4 border-purple-500 border-t-transparent" />
      </div>
    )
  }

  // Admin users should not access student pages
  if (user?.role === 'admin') {
    return <Navigate to="/admin" replace />
  }

  return <>{children}</>
}
