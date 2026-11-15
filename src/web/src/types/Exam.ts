export interface ExamSummary {
  id: string
  examSession: string
  subject: string
  title: string
  questionCount: number
  timeLimitMinutes: number
}

export interface ExamQuestion {
  id: string
  questionNumber: number
  questionText: string
  images: unknown[]
  choices: { label: string; text: string; image?: string }[]
  difficulty: 'easy' | 'medium' | 'hard'
  isRequired: boolean
}

export interface ExamSession {
  sessionId: string
  questions: ExamQuestion[]
  totalQuestions: number
  timeLimitMinutes: number
  expiresAt: string
  status: string
}

export interface ExamAnswerResult {
  answerId: string
  questionId: string
  userAnswer: string
}

export interface ExamAnswerDetail {
  questionId: string
  questionNumber: number
  questionText: string
  userAnswer: string
  correctAnswer: string
  isCorrect: boolean
  explanation: string | null
}

export interface ExamResult {
  sessionId: string
  totalQuestions: number
  correctAnswers: number
  scorePercentage: number
  xpEarned: number
  passed: boolean
  status: string
  answers: ExamAnswerDetail[]
}
