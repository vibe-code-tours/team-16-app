import { Card } from '../../ui/Card'
import { Button } from '../../ui/Button'
import { Badge } from '../../ui/Badge'
import type { ExamSummary } from '../../../types/Exam'

interface ExamStartScreenProps {
  exams: ExamSummary[]
  isLoading: boolean
  isStarting?: boolean
  onStart: (examSession: string, subject: string) => void
}

export function ExamStartScreen({ exams, isLoading, isStarting = false, onStart }: ExamStartScreenProps) {
  // Group exams by session
  const sessions = exams.reduce<Record<string, ExamSummary[]>>((acc, exam) => {
    if (!acc[exam.examSession]) acc[exam.examSession] = []
    acc[exam.examSession].push(exam)
    return acc
  }, {})

  if (isLoading && exams.length === 0) {
    return (
      <div className="flex items-center justify-center py-12">
        <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-purple-600" />
      </div>
    )
  }

  if (exams.length === 0) {
    return (
      <Card className="text-center">
        <p className="text-gray-500">No exams available yet.</p>
      </Card>
    )
  }

  return (
    <div className="space-y-6">
      <div className="text-center">
        <h2 className="text-2xl font-bold text-gray-900">Select an Exam</h2>
        <p className="mt-2 text-gray-600">
          Choose an exam session and subject to begin the simulation.
        </p>
      </div>

      {Object.entries(sessions).map(([session, sessionExams]) => (
        <div key={session} className="space-y-3">
          <h3 className="text-lg font-semibold text-gray-900 capitalize">
            {session.replace('-', ' ')}
          </h3>
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
            {sessionExams.map((exam) => (
              <Card key={exam.id} className="hover:shadow-md transition-shadow">
                <div className="flex items-start justify-between">
                  <div>
                    <div className="flex items-center gap-2">
                      <h4 className="font-bold text-gray-900">Subject {exam.subject}</h4>
                      <Badge variant={exam.subject === 'A' ? 'info' : 'warning'}>
                        {exam.subject === 'A' ? 'Morning' : 'Afternoon'}
                      </Badge>
                    </div>
                    <p className="mt-1 text-sm text-gray-600">{exam.title}</p>
                  </div>
                </div>

                <div className="mt-4 flex items-center gap-4 text-sm text-gray-500">
                  <span>📝 {exam.questionCount} questions</span>
                  <span>⏱ {exam.timeLimitMinutes} min</span>
                  <span>❤️ {exam.initialHearts} hearts</span>
                </div>

                {exam.subject === 'B' && (
                  <div className="mt-3 rounded-lg bg-amber-50 p-3 text-xs text-amber-700">
                    <strong>Subject B format:</strong> Q1 compulsory, Q2–Q5 select 2 of 4, Q6
                    compulsory, Q7–Q8 select 1 of 2.
                  </div>
                )}

                <Button
                  className="mt-4 w-full"
                  disabled={isStarting}
                  onClick={() => onStart(exam.examSession, exam.subject)}
                >
                  {isStarting ? 'Starting...' : 'Start Exam'}
                </Button>
              </Card>
            ))}
          </div>
        </div>
      ))}
    </div>
  )
}
