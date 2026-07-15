export interface TopicMastery {
  topicId: string
  topicName: string
  topicSlug: string
  masteryScore: number
  questionsSeen: number
  questionsCorrect: number
}

export interface SubtopicMastery {
  subtopicId: string
  topicId: string
  subtopicName: string
  subtopicSlug: string
  masteryScore: number
  questionsSeen: number
  questionsCorrect: number
}

export interface WeakPointAnalysis {
  topics: TopicMastery[]
  subtopics: SubtopicMastery[]
}
