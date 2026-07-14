export interface ExamSummary {
  id: string
  exam_session: string
  subject: string
  title: string
  question_count: number
  time_limit_minutes: number
  initial_hearts: number
}

export interface ExamQuestion {
  id: string
  question_number: number
  question_text: string
  images: { url: string; alt: string }[]
  choices: { label: string; text: string }[]
  difficulty: 'easy' | 'medium' | 'hard'
  is_required: boolean
}

export interface ExamSession {
  session_id: string
  exam_session: string
  subject: string
  title: string
  questions: ExamQuestion[]
  total_questions: number
  hearts_remaining: number
  initial_hearts: number
  time_limit_minutes: number
  expires_at: string
  status: string
}

export interface ExamAnswerResult {
  question_id: string
  user_answer: string | null
  is_correct: boolean
  correct_answer: string
  explanation: string | null
  hearts_remaining: number
  exam_complete: boolean
}

export interface ExamAnswerDetail {
  question_id: string
  question_number: number
  question_text: string
  user_answer: string
  correct_answer: string
  is_correct: boolean
  explanation: string | null
}

export interface ExamResult {
  session_id: string
  total_questions: number
  answered_questions: number
  correct_answers: number
  score_percentage: number
  xp_earned: number
  passed: boolean
  hearts_remaining: number
  answers: ExamAnswerDetail[]
}
