import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from './useAuth.tsx'
import type {
  Topic,
  TopicCategory,
  TopicProgress,
  TopicWithStatus,
} from '../types/topic'

const VALID_CATEGORIES: readonly TopicCategory[] = [
  'Technology',
  'Security',
  'Management',
  'Strategy',
  'Business',
]

interface SubtopicRow {
  id: string
  name: string
  description: string | null
  display_order: number
  topics: { name: string; display_order: number } | null
}

interface QuestionCountRow {
  subtopic_id: string
  count: number
}

interface MasteryRow {
  subtopic_id: string
  questions_seen: number
  questions_correct: number
  mastery_score: number
  last_practiced_at: string | null
}

function isValidCategory(name: string): name is TopicCategory {
  return (VALID_CATEGORIES as readonly string[]).includes(name)
}

function chainPrerequisites(topics: Topic[]): Topic[] {
  const byCategory = new Map<TopicCategory, Topic[]>()
  for (const t of topics) {
    const list = byCategory.get(t.category) ?? []
    list.push(t)
    byCategory.set(t.category, list)
  }
  for (const list of byCategory.values()) {
    list.sort((a, b) => a.order - b.order)
    for (let i = 1; i < list.length; i++) {
      list[i] = { ...list[i], prerequisite_topic_id: list[i - 1].id }
    }
  }
  return Array.from(byCategory.values()).flat()
}

function toProgress(row: MasteryRow, questionCount: number): TopicProgress {
  const answered = row.questions_seen
  const correct = row.questions_correct
  const status =
    questionCount > 0 && answered >= questionCount
      ? 'completed'
      : answered > 0
        ? 'in_progress'
        : 'not_started'
  return {
    topic_id: row.subtopic_id,
    status,
    questions_answered: answered,
    questions_correct: correct,
    last_attempted_at: row.last_practiced_at,
  }
}

function joinTopicsAndProgress(
  topics: Topic[],
  progress: TopicProgress[]
): TopicWithStatus[] {
  const progressById = new Map(progress.map((p) => [p.topic_id, p]))

  return topics.map((topic) => {
    const topicProgress = progressById.get(topic.id) ?? null

    if (topicProgress) {
      return { ...topic, status: topicProgress.status, progress: topicProgress }
    }

    const prereqProgress = topic.prerequisite_topic_id
      ? progressById.get(topic.prerequisite_topic_id)
      : null

    const unlocked =
      topic.prerequisite_topic_id === null ||
      prereqProgress?.status === 'completed'

    return {
      ...topic,
      status: unlocked ? 'not_started' : 'locked',
      progress: null,
    }
  })
}

interface UseTopicsResult {
  topics: TopicWithStatus[]
  loading: boolean
  error: string | null
}

export function useTopics(): UseTopicsResult {
  const { user } = useAuth()
  const [topics, setTopics] = useState<TopicWithStatus[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    let cancelled = false

    async function load() {
      setLoading(true)
      setError(null)

      const subtopicsResult = await supabase
        .from('subtopics')
        .select(
          'id, name, description, display_order, topics!inner(name, display_order)'
        )
        .eq('published', true)
        .eq('topics.published', true)
        .order('display_order', { ascending: true })

      if (cancelled) return
      if (subtopicsResult.error) {
        setError(subtopicsResult.error.message)
        setLoading(false)
        return
      }

      const rows = (subtopicsResult.data ?? []) as unknown as SubtopicRow[]

      const questionCountsResult = await supabase
        .from('questions')
        .select('subtopic_id')
        .eq('published', true)
        .not('subtopic_id', 'is', null)

      if (cancelled) return
      if (questionCountsResult.error) {
        setError(questionCountsResult.error.message)
        setLoading(false)
        return
      }

      const questionCountBySubtopic = new Map<string, number>()
      for (const q of questionCountsResult.data ?? []) {
        const id = (q as QuestionCountRow).subtopic_id
        if (!id) continue
        questionCountBySubtopic.set(id, (questionCountBySubtopic.get(id) ?? 0) + 1)
      }

      const baseTopics: Topic[] = []
      for (const row of rows) {
        const categoryName = row.topics?.name ?? ''
        if (!isValidCategory(categoryName)) continue
        baseTopics.push({
          id: row.id,
          subject: 'A',
          category: categoryName,
          order: row.display_order,
          title: row.name,
          description: row.description ?? 'Lessons coming soon.',
          question_count: questionCountBySubtopic.get(row.id) ?? 0,
          prerequisite_topic_id: null,
        })
      }

      const chained = chainPrerequisites(baseTopics)

      let progress: TopicProgress[] = []
      if (user?.id) {
        const masteryResult = await supabase
          .from('user_subtopic_mastery')
          .select(
            'subtopic_id, questions_seen, questions_correct, mastery_score, last_practiced_at'
          )
          .eq('user_id', user.id)

        if (cancelled) return
        if (masteryResult.error) {
          setError(masteryResult.error.message)
          setLoading(false)
          return
        }

        const questionCountById = new Map(
          chained.map((t) => [t.id, t.question_count])
        )
        progress = (masteryResult.data ?? []).map((row) =>
          toProgress(row as MasteryRow, questionCountById.get((row as MasteryRow).subtopic_id) ?? 0)
        )
      }

      setTopics(joinTopicsAndProgress(chained, progress))
      setLoading(false)
    }

    load().catch((e) => {
      if (cancelled) return
      setError(e instanceof Error ? e.message : 'Failed to load topics')
      setLoading(false)
    })

    return () => {
      cancelled = true
    }
  }, [user?.id])

  return { topics, loading, error }
}
