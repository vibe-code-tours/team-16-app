export interface UserProfile {
  id: string
  email: string | null
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
  signUp: (email: string, password: string) => Promise<{ error?: string; session: import('@supabase/supabase-js').Session | null }>
  signInWithGoogle: () => Promise<{ error?: string }>
  signOut: () => Promise<void>
  updateProfile: (updates: { display_name?: string }) => Promise<{ error?: string }>
  refreshUser: () => Promise<void>
}

export interface Topic {
  id: string
  title: string
  description: string | null
  created_at: string
  updated_at: string
}

export interface Lesson {
  id: string
  topic_id: string
  content: string
  created_at: string
  updated_at: string
}

export interface Quiz {
  id: string
  topic_id: string
  lesson_id: string | null
  created_at: string
  updated_at: string
}

export interface QuestionChoice {
  label: string
  text: string
}

export interface QuizQuestion {
  id: string
  subtopic_id: string
  question_text: string
  choices: QuestionChoice[]
  correct_answer: string
  explanation: string | null
}
