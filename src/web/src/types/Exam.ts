export interface ExamSummary {
  id: string
  examSession: string
  subject: string
  title: string
  questionCount: number
  timeLimitMinutes: number
  initialHearts: number
}

export interface ExamQuestion {
  id: string
  questionNumber: number
  questionText: string
  images: { url: string; alt: string }[]
  choices: { label: string; text: string }[]
  difficulty: 'easy' | 'medium' | 'hard'
  isRequired: boolean
}

export interface ExamSession {
  sessionId: string
  examSession: string
  subject: string
  title: string
  questions: ExamQuestion[]
  totalQuestions: number
  heartsRemaining: number
  initialHearts: number
  timeLimitMinutes: number
  expiresAt: string
  status: string
}

export interface ExamAnswerResult {
  questionId: string
  userAnswer: string | null
  isCorrect: boolean
  correctAnswer: string
  explanation: string | null
  heartsRemaining: number
  examComplete: boolean
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
  answeredQuestions: number
  correctAnswers: number
  scorePercentage: number
  xpEarned: number
  passed: boolean
  heartsRemaining: number
  answers: ExamAnswerDetail[]
}
