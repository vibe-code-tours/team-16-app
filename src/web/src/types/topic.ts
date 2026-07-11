export type TopicSubject = 'A' | 'B'

export type TopicCategory =
  | 'Technology'
  | 'Security'
  | 'Management'
  | 'Strategy'
  | 'Business'

export type TopicStatus =
  | 'locked'
  | 'not_started'
  | 'in_progress'
  | 'completed'

export interface Topic {
  id: string
  subject: TopicSubject
  category: TopicCategory
  order: number
  title: string
  description: string
  question_count: number
  prerequisite_topic_id: string | null
}

export interface TopicProgress {
  topic_id: string
  status: Exclude<TopicStatus, 'locked'>
  questions_answered: number
  questions_correct: number
  last_attempted_at: string | null
}

export interface TopicWithStatus extends Topic {
  status: TopicStatus
  progress: TopicProgress | null
}
