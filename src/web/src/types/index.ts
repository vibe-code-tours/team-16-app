export interface UserProfile {
  id: string
  display_name: string | null
  avatar_url: string | null
  total_xp: number
  streak_count: number
  last_login_at: string | null
  created_at: string
  updated_at: string
}

export interface AuthContextType {
  user: UserProfile | null
  session: import('@supabase/supabase-js').Session | null
  loading: boolean
  signIn: (email: string, password: string) => Promise<{ error?: string }>
  signUp: (email: string, password: string) => Promise<{ error?: string }>
  signInWithGoogle: () => Promise<{ error?: string }>
  signOut: () => Promise<void>
}
