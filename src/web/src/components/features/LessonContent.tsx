import ReactMarkdown from 'react-markdown'
import type { Lesson, ContentBlock } from '../../hooks/useLessons'

interface LessonContentProps {
  lesson: Lesson
  onComplete: () => void
  isCompleted: boolean
}

function ContentBlockRenderer({ block }: { block: ContentBlock }) {
  switch (block.type) {
    case 'heading':
      return (
        <h3 className="text-lg font-bold text-gray-900 mt-6 mb-3">
          <ReactMarkdown>{block.content}</ReactMarkdown>
        </h3>
      )

    case 'text':
      return (
        <div className="prose prose-sm max-w-none text-gray-700 mb-4">
          <ReactMarkdown>{block.content}</ReactMarkdown>
        </div>
      )

    case 'list':
      return (
        <ul className="list-disc list-inside space-y-2 mb-4 text-gray-700">
          {block.items?.map((item, i) => (
            <li key={i}>
              <ReactMarkdown>{item}</ReactMarkdown>
            </li>
          ))}
        </ul>
      )

    case 'code':
      return (
        <div className="mb-4">
          {block.language && (
            <div className="text-xs text-gray-500 mb-1">{block.language}</div>
          )}
          <pre className="bg-gray-900 text-gray-100 rounded-lg p-4 overflow-x-auto text-sm">
            <code>{block.content}</code>
          </pre>
        </div>
      )

    case 'tip':
      return (
        <div className="bg-blue-50 border-l-4 border-blue-500 p-4 rounded-r-lg mb-4">
          <div className="flex items-start gap-2">
            <span className="text-blue-500 text-lg">💡</span>
            <div className="prose prose-sm max-w-none text-blue-800">
              <ReactMarkdown>{block.content}</ReactMarkdown>
            </div>
          </div>
        </div>
      )

    case 'warning':
      return (
        <div className="bg-amber-50 border-l-4 border-amber-500 p-4 rounded-r-lg mb-4">
          <div className="flex items-start gap-2">
            <span className="text-amber-500 text-lg">⚠️</span>
            <div className="prose prose-sm max-w-none text-amber-800">
              <ReactMarkdown>{block.content}</ReactMarkdown>
            </div>
          </div>
        </div>
      )

    case 'example':
      return (
        <div className="bg-green-50 border-l-4 border-green-500 p-4 rounded-r-lg mb-4">
          <div className="flex items-start gap-2">
            <span className="text-green-500 text-lg">📝</span>
            <div className="prose prose-sm max-w-none text-green-800">
              <ReactMarkdown>{block.content}</ReactMarkdown>
            </div>
          </div>
        </div>
      )

    default:
      return null
  }
}

export function LessonContent({ lesson, onComplete, isCompleted }: LessonContentProps) {
  return (
    <div className="bg-white rounded-2xl border border-gray-200 p-6">
      <div className="flex items-center justify-between mb-4">
        <div>
          <h2 className="text-xl font-bold text-gray-900">{lesson.title}</h2>
          <p className="text-sm text-gray-500 mt-1">
            {lesson.estimated_minutes} min · {lesson.xp_reward} XP
          </p>
        </div>
        {isCompleted && (
          <span className="px-3 py-1 bg-green-100 text-green-700 rounded-full text-sm font-medium">
            ✓ Completed
          </span>
        )}
      </div>

      {lesson.summary && (
        <p className="text-gray-600 mb-6 pb-4 border-b border-gray-100">
          {lesson.summary}
        </p>
      )}

      <div className="space-y-2">
        {lesson.content_blocks.map((block, index) => (
          <ContentBlockRenderer key={index} block={block} />
        ))}
      </div>

      {!isCompleted && (
        <div className="mt-6 pt-4 border-t border-gray-100">
          <button
            onClick={onComplete}
            className="w-full bg-purple-600 text-white py-3 rounded-lg font-medium hover:bg-purple-700 transition"
          >
            Mark as Complete · Earn {lesson.xp_reward} XP
          </button>
        </div>
      )}
    </div>
  )
}
