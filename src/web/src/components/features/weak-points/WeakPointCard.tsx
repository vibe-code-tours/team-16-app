import { Card } from '../../ui/Card'
import { Badge } from '../../ui/Badge'
import type { TopicMastery, SubtopicMastery } from '../../../types/WeakPoint'

interface WeakPointCardProps {
  topic: TopicMastery
  subtopics: SubtopicMastery[]
}

function getMasteryBadgeVariant(score: number): 'error' | 'warning' | 'success' | 'info' {
  if (score < 0.4) return 'error'
  if (score < 0.7) return 'warning'
  return 'success'
}

function getMasteryLabel(score: number): string {
  if (score < 0.4) return 'Weak'
  if (score < 0.7) return 'Developing'
  return 'Strong'
}

export function WeakPointCard({ topic, subtopics }: WeakPointCardProps) {
  const percentage = Math.round(topic.masteryScore * 100)
  const topicSubtopics = subtopics.filter((s) => s.topicId === topic.topicId)

  return (
    <Card padding="lg">
      <div className="flex items-start justify-between mb-3">
        <div>
          <h3 className="text-lg font-semibold text-gray-900">{topic.topicName}</h3>
          <p className="text-sm text-gray-500">
            {topic.questionsSeen} questions answered
          </p>
        </div>
        <Badge variant={getMasteryBadgeVariant(topic.masteryScore)}>
          {getMasteryLabel(topic.masteryScore)}
        </Badge>
      </div>

      {/* Progress bar */}
      <div className="mb-4">
        <div className="flex items-center justify-between mb-1">
          <span className="text-sm font-medium text-gray-700">Mastery</span>
          <span className="text-sm font-bold text-gray-900">{percentage}%</span>
        </div>
        <div className="w-full h-2.5 bg-gray-100 rounded-full overflow-hidden">
          <div
            className={`h-full rounded-full transition-all duration-500 ${
              topic.masteryScore < 0.4
                ? 'bg-red-500'
                : topic.masteryScore < 0.7
                  ? 'bg-yellow-500'
                  : 'bg-green-500'
            }`}
            style={{ width: `${percentage}%` }}
          />
        </div>
      </div>

      {/* Subtopic breakdown */}
      {topicSubtopics.length > 0 && (
        <div className="border-t border-gray-100 pt-3">
          <p className="text-xs font-bold text-gray-400 uppercase mb-2">Subtopics</p>
          <div className="space-y-2">
            {topicSubtopics.map((sub) => (
              <div key={sub.subtopicId} className="flex items-center justify-between">
                <span className="text-sm text-gray-600">{sub.subtopicName}</span>
                <div className="flex items-center gap-2">
                  <span className="text-xs text-gray-400">
                    {sub.questionsCorrect}/{sub.questionsSeen}
                  </span>
                  <div className="w-16 h-1.5 bg-gray-100 rounded-full overflow-hidden">
                    <div
                      className={`h-full rounded-full ${
                        sub.masteryScore < 0.4
                          ? 'bg-red-400'
                          : sub.masteryScore < 0.7
                            ? 'bg-yellow-400'
                            : 'bg-green-400'
                      }`}
                      style={{ width: `${Math.round(sub.masteryScore * 100)}%` }}
                    />
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </Card>
  )
}
