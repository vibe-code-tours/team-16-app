import { useState, useEffect, useCallback, createContext, useContext, type ReactNode } from 'react'
import type { Session } from '@supabase/supabase-js'
import { supabase } from '../lib/supabase'
import type { UserProfile, AuthContextType } from '../types'

const AuthContext = createContext<AuthContextType | null>(null)

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<UserProfile | null>(null)
  const [session, setSession] = useState<Session | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    // Get initial session
    supabase.auth.getSession().then(({ data: { session: initialSession } }) => {
      setSession(initialSession)
      if (initialSession?.user) {
        fetchUserProfile(initialSession.user.id)
      } else {
        setLoading(false)
      }
    })

    // Listen for auth state changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (_event, newSession) => {
        setSession(newSession)
        if (newSession?.user) {
          await fetchUserProfile(newSession.user.id)
        } else {
          setUser(null)
          setLoading(false)
        }
      },
    )

    return () => subscription.unsubscribe()
  }, [])

  async function fetchUserProfile(userId: string) {
    try {
      const { data, error } = await supabase
        .from('user_profiles')
        .select('*')
        .eq('id', userId)
        .single()

      if (error) {
        // Profile doesn't exist yet — create it
        const { data: newProfile, error: insertError } = await supabase
          .from('user_profiles')
          .insert({ id: userId })
          .select()
          .single()

        if (insertError) {
          console.error('Failed to create user profile:', insertError.message)
          setUser(null)
        } else {
          setUser(newProfile)
        }
      } else {
        // Update last_login_at
        await supabase
          .from('user_profiles')
          .update({ last_login_at: new Date().toISOString() })
          .eq('id', userId)

        setUser(data)
      }
    } catch {
      setUser(null)
    } finally {
      setLoading(false)
    }
  }

  const signIn = useCallback(async (email: string, password: string) => {
    const { error } = await supabase.auth.signInWithPassword({ email, password })
    return { error: error?.message }
  }, [])

  const signUp = useCallback(async (email: string, password: string) => {
    const { error } = await supabase.auth.signUp({ email, password })
    return { error: error?.message }
  }, [])

  const signInWithGoogle = useCallback(async () => {
    const { error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: {
        redirectTo: `${window.location.origin}/map`,
      },
    })
    return { error: error?.message }
  }, [])

  const signOut = useCallback(async () => {
    await supabase.auth.signOut()
    setUser(null)
    setSession(null)
  }, [])

  return (
    <AuthContext.Provider
      value={{ user, session, loading, signIn, signUp, signInWithGoogle, signOut }}
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
