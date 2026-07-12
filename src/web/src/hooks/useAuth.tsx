import { useState, useEffect, useCallback, createContext, useContext, type ReactNode } from 'react'
import type { Session, User } from '@supabase/supabase-js'
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
        fetchUserProfile(initialSession.user)
      } else {
        setLoading(false)
      }
    })

    // Listen for auth state changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange(
      async (_event, newSession) => {
        setSession(newSession)
        if (newSession?.user) {
          await fetchUserProfile(newSession.user)
        } else {
          setUser(null)
          setLoading(false)
        }
      },
    )

    return () => subscription.unsubscribe()
  }, [])

  async function fetchUserProfile(authUser: User) {
    const userId = authUser.id
    // Extract name from OAuth metadata, fallback to email prefix
    const oauthName = authUser.user_metadata?.full_name
      || authUser.user_metadata?.name
      || authUser.email?.split('@')[0]
      || null
    const oauthAvatar = authUser.user_metadata?.avatar_url
      || authUser.user_metadata?.picture
      || null

    try {
      const { data, error } = await supabase
        .from('user_profiles')
        .select('*')
        .eq('id', userId)
        .single()

      if (error) {
        // Profile doesn't exist yet — create it with OAuth data
        const { data: newProfile, error: insertError } = await supabase
          .from('user_profiles')
          .insert({
            id: userId,
            display_name: oauthName,
            avatar_url: oauthAvatar,
            email: authUser.email,
          })
          .select()
          .single()

        if (insertError) {
          console.error('Failed to create user profile:', insertError.message)
          setUser(null)
        } else {
          setUser(newProfile)
        }
      } else {
        // Sync OAuth name/avatar if profile is missing them
        const updates: Record<string, unknown> = { last_login_at: new Date().toISOString() }
        if (!data.display_name && oauthName) updates.display_name = oauthName
        if (!data.avatar_url && oauthAvatar) updates.avatar_url = oauthAvatar

        if (Object.keys(updates).length > 1) {
          await supabase
            .from('user_profiles')
            .update(updates)
            .eq('id', userId)
          setUser({ ...data, ...updates })
        } else {
          await supabase
            .from('user_profiles')
            .update({ last_login_at: updates.last_login_at })
            .eq('id', userId)
          setUser(data)
        }
      }
    } catch {
      setUser(null)
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
    // Check if email already exists via RPC (bypasses RLS)
    const { data: emailExists } = await supabase
      .rpc('check_email_exists', { check_email: email })

    if (emailExists) {
      return { error: 'An account with this email already exists. If you signed up with Google, use the Google sign-in button.', session: null }
    }

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

  const updateProfile = useCallback(async (updates: { display_name?: string }) => {
    if (!user) return { error: 'Not authenticated' }
    const { error } = await supabase
      .from('user_profiles')
      .update(updates)
      .eq('id', user.id)
    if (error) return { error: error.message }
    setUser({ ...user, ...updates })
    return {}
  }, [user])

  return (
    <AuthContext.Provider
      value={{ user, session, loading, signIn, signUp, signInWithGoogle, signOut, updateProfile }}
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
