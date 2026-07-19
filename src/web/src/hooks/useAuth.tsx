import { useState, useEffect, useCallback, createContext, useContext, type ReactNode } from 'react'
import type { Session, User } from '@supabase/supabase-js'
import { supabase } from '../lib/supabase'
import { api } from '../lib/api'
import type { UserProfile, AuthContextType } from '../types'

const AuthContext = createContext<AuthContextType | null>(null)

interface ApiUserProfile {
  id: string
  displayName: string
  avatarUrl: string | null
  email: string | null
  role: 'admin' | 'user'
  totalXp: number
  streakCount: number
  lastLoginAt: string | null
  createdAt: string
  updatedAt: string
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<UserProfile | null>(null)
  const [session, setSession] = useState<Session | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    // Get initial session
    supabase.auth.getSession().then(({ data: { session: initialSession } }) => {
      setSession(initialSession)
      if (initialSession?.user) {
        fetchUserProfile(initialSession.user)
      } else {
        setLoading(false)
      }
    })

    // Listen for auth state changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (event, newSession) => {
        setSession(newSession)
        if (newSession?.user) {
          // Only re-fetch profile on actual sign-in — TOKEN_REFRESHED just updates the session
          if (event === 'SIGNED_IN' || event === 'INITIAL_SESSION') {
            await fetchUserProfile(newSession.user)
          }
        } else {
          setUser(null)
          setLoading(false)
        }
      },
    )

    return () => subscription.unsubscribe()
  }, [])

  async function fetchUserProfile(authUser: User) {
    // Extract name from OAuth metadata, fallback to email prefix
    const oauthName = authUser.user_metadata?.full_name
      || authUser.user_metadata?.name
      || authUser.email?.split('@')[0]
      || null
    const oauthAvatar = authUser.user_metadata?.avatar_url
      || authUser.user_metadata?.picture
      || null

    try {
      // Use backend API to get or create profile
      const profile = await api.post<ApiUserProfile>('/api/v1/me/profile', {
        email: authUser.email,
        displayName: oauthName,
        avatarUrl: oauthAvatar,
      })

      // Update streak on login
      let newStreak: number | null = null
      try {
        const streak = await api.post<{ streakCount: number }>('/api/v1/me/streak')
        newStreak = streak.streakCount
      } catch (streakError) {
        console.error('Failed to update user streak:', streakError)
      }

      setUser({
        id: profile.id,
        display_name: profile.displayName,
        avatar_url: profile.avatarUrl,
        email: profile.email,
        role: profile.role,
        total_xp: profile.totalXp,
        streak_count: newStreak ?? profile.streakCount,
        last_login_at: profile.lastLoginAt,
        created_at: profile.createdAt,
        updated_at: profile.updatedAt,
      })
    } catch (error) {
      // Don't wipe out existing user on transient backend failures (e.g. during token refresh).
      // If a profile was already loaded, keep it rather than logging the user out.
      console.error('Failed to fetch user profile:', error)
    } finally {
      setLoading(false)
    }
  }

  const signIn = useCallback(async (email: string, password: string) => {
    const { error } = await supabase.auth.signInWithPassword({ email, password })
    if (error?.message === 'Invalid login credentials') {
      return { error: 'Invalid email or password. If you signed up with Google, use the Google sign-in button.' }
    }
    return { error: error?.message }
  }, [])

  const signUp = useCallback(async (email: string, password: string) => {
    // Note: Removed email existence check to prevent email enumeration attacks.
    // Supabase will return an error if the email is already registered.
    const { data, error } = await supabase.auth.signUp({ email, password })
    if (error?.message?.includes('already registered') || error?.message?.includes('already been registered')) {
      return { error: 'An account with this email already exists. Please sign in instead.', session: null }
    }
    return { error: error?.message, session: data.session }
  }, [])

  const signInWithGoogle = useCallback(async () => {
    const { error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: `${window.location.origin}/map`, // Default redirect; ProtectedRoute or admin check will handle role-based routing
      },
    })
    return { error: error?.message }
  }, [])

  const signOut = useCallback(async () => {
    await supabase.auth.signOut()
    setUser(null)
    setSession(null)
  }, [])

  const updateProfile = useCallback(async (updates: { display_name?: string }) => {
    if (!user) return { error: 'Not authenticated' }
    try {
      await api.put('/api/v1/me/profile', { displayName: updates.display_name })
      setUser({ ...user, ...updates })
      return {}
    } catch (error) {
      return { error: error instanceof Error ? error.message : 'Failed to update profile' }
    }
  }, [user])

  const refreshUser = useCallback(async () => {
    if (!user) return
    const { data, error } = await supabase
      .from('user_profiles')
      .select('*')
      .eq('id', user.id)
      .single()
    if (!error && data) setUser(data)
  }, [user])

  return (
    <AuthContext.Provider
      value={{ user, session, loading, signIn, signUp, signInWithGoogle, signOut, updateProfile, refreshUser }}
    >
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth(): AuthContextType {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return context
}
