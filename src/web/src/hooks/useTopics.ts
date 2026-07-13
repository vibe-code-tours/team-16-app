import { useEffect, useState } from 'react'
import { api } from '../lib/api'
import { useAuth } from './useAuth.tsx'
import type { TopicCategory, TopicWithStatus } from '../types/topic'

const VALID_CATEGORIES: readonly TopicCategory[] = [
  'Technology',
  'Security',
  'Management',
  'Strategy',
  'Business',
]

function isValidCategory(name: string): name is TopicCategory {
  return (VALID_CATEGORIES as readonly string[]).includes(name)
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
      try {
        const fetched = await api.get<TopicWithStatus[]>('/api/v1/topics')
        if (cancelled) return
        setTopics(fetched.filter((t) => isValidCategory(t.category)))
      } catch (e) {
        if (cancelled) return
        setError(e instanceof Error ? e.message : 'Failed to load topics')
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    load()

    return () => {
      cancelled = true
    }
  }, [user?.id])

  return { topics, loading, error }
}
