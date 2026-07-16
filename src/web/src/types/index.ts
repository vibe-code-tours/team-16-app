export interface UserProfile {
  id: string
  email: string | null
  display_name: string | null
  avatar_url: string | null
  role: 'admin' | 'user'
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

export interface TopicEngagement {
  topicName: string
  quizCount: number
  avgScore: number
}

export interface DailyActiveUsers {
  date: string
  activeUsers: number
}

export interface AdminStats {
  totalUsers: number
  activeToday: number
  activeThisWeek: number
  totalQuizAttempts: number
  totalExamAttempts: number
  totalQuizSessions: number
  totalExamSessions: number
  avgQuizScore: number
  avgExamScore: number
  examPassRate: number
  quizCompletionRate: number
  topicEngagement: TopicEngagement[]
  dailyActiveUsers: DailyActiveUsers[]
}

export interface AdminUserSummary {
  id: string
  displayName: string | null
  email: string
  avatarUrl: string | null
  role: 'admin' | 'user' | 'deactivated'
  status: 'active' | 'inactive'
  totalXp: number
  streakCount: number
  lastLoginAt: string | null
  createdAt: string
}

export interface RecentActivity {
  type: 'quiz' | 'exam'
  topicName: string
  score: number
  completedAt: string
}

export interface AdminUserDetail extends AdminUserSummary {
  longestStreak: number
  totalQuizzes: number
  completedQuizzes: number
  avgQuizScore: number
  totalExams: number
  completedExams: number
  avgExamScore: number
  examPassRate: number
  recentActivity: RecentActivity[]
}

export interface AdminUserListResponse {
  users: AdminUserSummary[]
  total: number
  page: number
  pageSize: number
}

export interface UserFilters {
  search: string
  role: string
  filter: string
  sort: string
  order: 'asc' | 'desc'
  page: number
}
