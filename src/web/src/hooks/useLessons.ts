import { useEffect, useState } from 'react'
import { api } from '../lib/api'
import { useAuth } from './useAuth'

export interface Lesson {
  id: string
  subtopic_id: string
  title: string
  slug: string
  summary: string | null
  content_blocks: ContentBlock[]
  estimated_minutes: number
  xp_reward: number
  display_order: number
  published: boolean
  status: 'locked' | 'unlocked' | 'in_progress' | 'completed'
}

export interface ContentBlock {
  type: 'text' | 'heading' | 'list' | 'code' | 'tip' | 'warning' | 'example'
  content: string
  items?: string[]
  language?: string
}

export interface LessonProgress {
  lesson_id: string
  status: 'locked' | 'unlocked' | 'in_progress' | 'completed'
  started_at: string | null
  completed_at: string | null
}

interface UseLessonsResult {
  lessons: Lesson[]
  progress: LessonProgress[]
  loading: boolean
  error: string | null
  completeLesson: (lessonId: string) => Promise<void>
}

export function useLessons(subtopicId: string | undefined): UseLessonsResult {
  const { user } = useAuth()
  const [lessons, setLessons] = useState<Lesson[]>([])
  const [progress, setProgress] = useState<LessonProgress[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    if (!subtopicId) {
      setLoading(false)
      return
    }

    let cancelled = false

    async function load() {
      setLoading(true)
      setError(null)

      try {
        const data = await api.get<Lesson[]>(`/api/v1/subtopics/${subtopicId}/lessons`)
        if (cancelled) return
        setLessons(data)
        setProgress(
          data.map((l) => ({
            lesson_id: l.id,
            status: l.status,
            started_at: null,
            completed_at: null,
          }))
        )
      } catch (e) {
        if (cancelled) return
        setError(e instanceof Error ? e.message : 'Failed to load lessons')
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    load()

    return () => {
      cancelled = true
    }
  }, [subtopicId, user?.id])

  const completeLesson = async (lessonId: string) => {
    if (!user?.id) return
    try {
      await api.post<void>(`/api/v1/lessons/${lessonId}/complete`)
      const completedAt = new Date().toISOString()
      setProgress((prev) => {
        const existing = prev.find((p) => p.lesson_id === lessonId)
        if (existing) {
          return prev.map((p) =>
            p.lesson_id === lessonId
              ? { ...p, status: 'completed', completed_at: completedAt }
              : p
          )
        }
        return [
          ...prev,
          { lesson_id: lessonId, status: 'completed', started_at: completedAt, completed_at: completedAt },
        ]
      })
    } catch (e) {
      console.error('Failed to complete lesson:', e)
    }
  }

  return { lessons, progress, loading, error, completeLesson }
}
