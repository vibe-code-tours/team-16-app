import type { Choice } from './Quiz'

export interface Mistake {
  id: string
  questionId: string
  subtopicId: string | null
  subtopicName: string | null
  topicName: string | null
  questionText: string | null
  correctAnswer: string | null
  choices: Choice[]
  explanation: string | null
  lastUserAnswer: string | null
  lastMissedAt: string
}
