import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
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

      const { data: lessonsData, error: lessonsError } = await supabase
        .from('lessons')
        .select('*')
        .eq('subtopic_id', subtopicId)
        .eq('published', true)
        .order('display_order', { ascending: true })

      if (cancelled) return
      if (lessonsError) {
        setError(lessonsError.message)
        setLoading(false)
        return
      }

      setLessons(lessonsData ?? [])

      if (user?.id && lessonsData && lessonsData.length > 0) {
        const lessonIds = lessonsData.map((l) => l.id)
        const { data: progressData } = await supabase
          .from('user_lesson_progress')
          .select('*')
          .eq('user_id', user.id)
          .in('lesson_id', lessonIds)

        if (!cancelled) {
          setProgress(progressData ?? [])
        }
      }

      setLoading(false)
    }

    load()

    return () => {
      cancelled = true
    }
  }, [subtopicId, user?.id])

  const completeLesson = async (lessonId: string) => {
    if (!user?.id) return

    const existing = progress.find((p) => p.lesson_id === lessonId)

    if (existing) {
      const { error } = await supabase
        .from('user_lesson_progress')
        .update({
          status: 'completed',
          completed_at: new Date().toISOString(),
        })
        .eq('user_id', user.id)
        .eq('lesson_id', lessonId)

      if (!error) {
        setProgress((prev) =>
          prev.map((p) =>
            p.lesson_id === lessonId
              ? { ...p, status: 'completed', completed_at: new Date().toISOString() }
              : p
          )
        )
      }
    } else {
      const { error } = await supabase.from('user_lesson_progress').insert({
        user_id: user.id,
        lesson_id: lessonId,
        status: 'completed',
        started_at: new Date().toISOString(),
        completed_at: new Date().toISOString(),
      })

      if (!error) {
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
    }
  }

  return { lessons, progress, loading, error, completeLesson }
}
