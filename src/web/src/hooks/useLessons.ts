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
        // Fetch lessons from backend API
        const lessonsData = await api.get<Lesson[]>(`/api/v1/lessons?subtopicId=${subtopicId}`)

        if (cancelled) return

        setLessons(lessonsData ?? [])

        // Fetch user's lesson progress if logged in
        if (user?.id && lessonsData && lessonsData.length > 0) {
          try {
            const progressData = await api.get<LessonProgress[]>(
              `/api/v1/me/lessons/progress?lessonIds=${lessonsData.map(l => l.id).join(',')}`
            )
            if (!cancelled) {
              setProgress(progressData ?? [])
            }
          } catch {
            // Progress fetch failed, continue without progress
            if (!cancelled) {
              setProgress([])
            }
          }
        }
      } catch (err) {
        if (!cancelled) {
          setError(err instanceof Error ? err.message : 'Failed to load lessons')
        }
      } finally {
        if (!cancelled) {
          setLoading(false)
        }
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
      await api.post(`/api/v1/me/lessons/${lessonId}/progress/complete`)

      // Update local state
      const existing = progress.find((p) => p.lesson_id === lessonId)
      if (existing) {
        setProgress((prev) =>
          prev.map((p) =>
            p.lesson_id === lessonId
              ? { ...p, status: 'completed', completed_at: new Date().toISOString() }
              : p
          )
        )
      } else {
        setProgress((prev) => [
          ...prev,
          {
            lesson_id: lessonId,
            status: 'completed',
            started_at: new Date().toISOString(),
            completed_at: new Date().toISOString(),
          },
        ])
      }
    } catch (err) {
      console.error('Failed to complete lesson:', err)
    }
  }

  return { lessons, progress, loading, error, completeLesson }
}
