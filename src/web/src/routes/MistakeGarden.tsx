import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../hooks/useAuth.tsx'
import { supabase } from '../lib/supabase'
import type { QuestionChoice } from '../types'

interface MistakeRow {
  id: string
  last_missed_at: string
  last_user_answer: string | null
  resolved_at: string | null
  questions: {
    id: string
    question_text: string
    choices: QuestionChoice[]
    correct_answer: string
    explanation: string | null
  } | null
}

function choiceText(choices: QuestionChoice[] | null | undefined, label: string | null): string {
  if (!label || !choices) return 'N/A'
  const found = choices.find((c) => c.label === label)
  return found ? `${label.toUpperCase()}. ${found.text}` : label
}

export function MistakeGarden() {
  const { user } = useAuth()
  const navigate = useNavigate()
  const [mistakes, setMistakes] = useState<MistakeRow[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    let cancelled = false

    async function load() {
      setLoading(true)
      const { data, error } = await supabase
        .from('mistakes')
        .select(
          'id, last_missed_at, last_user_answer, resolved_at, questions:question_id (id, question_text, choices, correct_answer, explanation)'
        )
        .eq('user_id', user!.id)
        .is('resolved_at', null)
        .order('last_missed_at', { ascending: false })

      if (cancelled) return
      if (error) {
        console.error('Error fetching mistakes:', error.message)
        setMistakes([])
      } else {
        setMistakes((data ?? []) as unknown as MistakeRow[])
      }
      setLoading(false)
    }

    load()
    return () => {
      cancelled = true
    }
  }, [user])

  const markResolved = async (mistakeId: string) => {
    await supabase.from('mistakes').update({ resolved_at: new Date().toISOString() }).eq('id', mistakeId)
    setMistakes((prev) => prev.filter((m) => m.id !== mistakeId))
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <header className="border-b border-gray-200 bg-white">
        <div className="mx-auto flex max-w-4xl items-center justify-between px-4 py-4">
          <button
            onClick={() => navigate('/map')}
            className="flex items-center gap-2 font-medium text-purple-600 hover:text-purple-800"
          >
            ← Back to Map
          </button>
          <h1 className="text-xl font-bold text-gray-900">Mistake Garden</h1>
        </div>
      </header>

      <main className="mx-auto max-w-4xl px-4 py-8">
        <div className="mb-8 text-center">
          <h2 className="mb-2 text-3xl font-bold text-gray-900">Your Mistake Garden</h2>
          <p className="text-gray-500">
            Every mistake is a seed for growth. Review your wrong answers to master the material.
          </p>
        </div>

        {loading ? (
          <div className="flex justify-center py-12">
            <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-purple-600" />
          </div>
        ) : mistakes.length === 0 ? (
          <div className="rounded-2xl border border-dashed border-gray-300 bg-white py-20 text-center">
            <div className="mb-4 text-5xl">🌱</div>
            <h3 className="mb-2 text-xl font-semibold text-gray-900">Your garden is empty!</h3>
            <p className="text-gray-500">You haven't made any mistakes yet. Keep studying!</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 gap-6">
            {mistakes.map((mistake) => (
              <div
                key={mistake.id}
                className="rounded-2xl border border-gray-200 bg-white p-6 shadow-sm"
              >
                <div className="mb-4 flex items-start justify-between">
                  <div className="text-sm text-gray-400">
                    {new Date(mistake.last_missed_at).toLocaleDateString()}
                  </div>
                  <button
                    onClick={() => markResolved(mistake.id)}
                    className="rounded bg-green-50 px-2 py-1 text-xs font-medium text-green-600 hover:text-green-700"
                  >
                    Mark as Reviewed
                  </button>
                </div>

                <div className="mb-4">
                  <p className="mb-1 text-sm font-medium text-gray-500">Question</p>
                  <p className="whitespace-pre-line text-base text-gray-900">
                    {mistake.questions?.question_text ?? '(question unavailable)'}
                  </p>
                </div>

                <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                  <div className="rounded-xl border border-red-100 bg-red-50 p-4">
                    <p className="mb-1 text-xs font-bold uppercase text-red-600">Your answer</p>
                    <p className="text-gray-700">
                      {choiceText(mistake.questions?.choices, mistake.last_user_answer)}
                    </p>
                  </div>
                  <div className="rounded-xl border border-green-100 bg-green-50 p-4">
                    <p className="mb-1 text-xs font-bold uppercase text-green-600">Correct answer</p>
                    <p className="text-gray-700">
                      {choiceText(mistake.questions?.choices, mistake.questions?.correct_answer ?? null)}
                    </p>
                  </div>
                </div>

                {mistake.questions?.explanation ? (
                  <div className="mt-4 rounded-xl bg-gray-50 p-4">
                    <p className="mb-1 text-xs font-bold uppercase text-gray-600">Explanation</p>
                    <p className="text-sm text-gray-700">{mistake.questions.explanation}</p>
                  </div>
                ) : null}
              </div>
            ))}
          </div>
        )}
      </main>
    </div>
  )
}
