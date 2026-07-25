import { useState } from 'react'
import { Card } from '../../ui/Card'
import { Button } from '../../ui/Button'

interface ExamStartScreenProps {
  isLoading: boolean
  isStarting?: boolean
  onStart: (questionCount: number, difficulty: string | null) => void
}

type Difficulty = 'all' | 'easy' | 'medium' | 'hard'

export function ExamStartScreen({ isLoading, isStarting = false, onStart }: ExamStartScreenProps) {
  const [difficulty, setDifficulty] = useState<Difficulty>('all')

  return (
    <div className="flex items-center justify-center py-12">
      <div className="w-full max-w-md rounded-2xl border border-gray-200 bg-white p-8 shadow-sm">
        <div className="mb-6 text-center">
          <div className="mb-4 text-5xl">📝</div>
          <h1 className="mb-2 text-2xl font-bold text-gray-900">Exam Simulation</h1>
          <p className="text-gray-500">60 questions • 60 minutes</p>
        </div>

        <div className="mb-6">
          <label className="mb-2 block text-sm font-medium text-gray-700">
            Select Difficulty
          </label>
          <div className="grid grid-cols-2 gap-2">
            {(['all', 'easy', 'medium', 'hard'] as Difficulty[]).map((d) => (
              <button
                key={d}
                onClick={() => setDifficulty(d)}
                className={`rounded-lg border-2 px-4 py-2 transition-all ${
                  difficulty === d
                    ? 'border-purple-500 bg-purple-50 text-purple-700'
                    : 'border-gray-200 text-gray-600 hover:border-gray-300'
                }`}
              >
                {d.charAt(0).toUpperCase() + d.slice(1)}
              </button>
            ))}
          </div>
        </div>

        <div className="space-y-3">
          <Button
            size="lg"
            className="w-full"
            disabled={isLoading || isStarting === true}
            onClick={() => onStart(60, difficulty)}
          >
            {isStarting ? 'Starting...' : 'Start Exam'}
          </Button>
        </div>

        <div className="mt-4 space-y-2 text-sm text-gray-500">
          <p className="text-center">
            Answer questions during a countdown timer. View results and
            detailed feedback when the timer expires or you finish early.
          </p>
        </div>
      </div>
    </div>
  )
}
