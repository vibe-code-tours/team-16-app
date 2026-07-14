import { useState, useEffect } from 'react'
import { useAuth } from '../hooks/useAuth.tsx'
import { supabase } from '../lib/supabase'

interface Choice {
  label: string
  text: string
}

interface ItpecQuestion {
  id: string
  question_text: string
  choices: Choice[]
  correct_answer: string
  explanation: string | null
}

interface Mistake {
  id: string
  created_at: string
  selected_label: string
  questions: ItpecQuestion
}

export function MistakeGarden() {
  const { user } = useAuth()
  const [mistakes, setMistakes] = useState<Mistake[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function fetchMistakes() {
      setLoading(true)

      const { data, error } = await supabase
        .from('user_mistakes')
        .select(`
          id,
          created_at,
          selected_label,
          questions (
            id,
            question_text,
            choices,
            correct_answer,
            explanation
          )
        `)
        .eq('user_id', user?.id)
        .order('created_at', { ascending: false })

      if (error) {
        console.error('Error fetching mistakes:', error.message)
      } else {
        setMistakes(data || [])
      }
      setLoading(false)
    }

    if (user) {
      fetchMistakes()
    }
  }, [user])

  const getChoiceText = (question: ItpecQuestion, label: string) => {
    const choice = question.choices?.find((c) => c.label === label)
    return choice?.text || label
  }

  return (
    <div>
      <div className="mb-8 text-center">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">Your Mistake Garden</h1>
        <p className="text-gray-500">
          Every mistake is a seed for growth. Review your wrong answers to master the material.
        </p>
      </div>

      {loading ? (
        <div className="flex justify-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
        </div>
      ) : mistakes.length === 0 ? (
        <div className="text-center py-20 bg-white rounded-2xl border border-dashed border-gray-300">
          <div className="text-5xl mb-4">🌱</div>
          <h3 className="text-xl font-semibold text-gray-900 mb-2">Your garden is empty!</h3>
          <p className="text-gray-500">You haven't made any mistakes yet. Keep studying!</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 gap-6">
          {mistakes.map((mistake) => {
            const q = mistake.questions
            return (
              <div key={mistake.id} className="bg-white rounded-2xl border border-gray-200 p-6 shadow-sm">
                <div className="flex items-start justify-between mb-4">
                  <div className="text-sm text-gray-400">
                    {new Date(mistake.created_at).toLocaleDateString()}
                  </div>
                  <button
                    onClick={async () => {
                      await supabase.from('user_mistakes').update({ reviewed: true }).eq('id', mistake.id)
                      setMistakes((prev) => prev.filter((m) => m.id !== mistake.id))
                    }}
                    className="text-xs font-medium text-green-600 hover:text-green-700 bg-green-50 px-2 py-1 rounded"
                  >
                    Mark as Reviewed
                  </button>
                </div>

                <div className="mb-4">
                  <p className="text-sm font-medium text-gray-500 mb-1">Question</p>
                  <p className="text-lg text-gray-900">{q?.question_text}</p>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="p-4 rounded-xl bg-red-50 border border-red-100">
                    <p className="text-xs font-bold text-red-600 uppercase mb-1">Your Answer</p>
                    <p className="text-gray-700">
                      {mistake.selected_label}. {getChoiceText(q, mistake.selected_label)}
                    </p>
                  </div>
                  <div className="p-4 rounded-xl bg-green-50 border border-green-100">
                    <p className="text-xs font-bold text-green-600 uppercase mb-1">Correct Answer</p>
                    <p className="text-gray-700">
                      {q?.correct_answer}. {getChoiceText(q, q?.correct_answer || '')}
                    </p>
                  </div>
                </div>

                {q?.explanation && (
                  <div className="mt-4 p-3 rounded-lg bg-blue-50 border border-blue-100">
                    <p className="text-xs font-bold text-blue-600 uppercase mb-1">Explanation</p>
                    <p className="text-sm text-blue-700">{q.explanation}</p>
                  </div>
                )}
              </div>
            )
          })}
        </div>
      )}
    </div>
  )
}
