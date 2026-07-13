import ReactMarkdown from 'react-markdown';
import type { Question, ContentBlock } from '../../types/Quiz';

interface QuestionBlockProps {
  question: Question;
}

function ContentBlockRenderer({ block }: { block: ContentBlock }) {
  switch (block.type) {
    case 'text':
    case 'markdown':
      return (
        <div className="prose prose-sm max-w-none">
          <ReactMarkdown>{block.text || ''}</ReactMarkdown>
        </div>
      );
    case 'code':
      return (
        <pre className="bg-gray-100 p-3 rounded-lg overflow-x-auto text-sm">
          <code className={block.language ? `language-${block.language}` : ''}>
            {block.text}
          </code>
        </pre>
      );
    case 'table':
      if (!block.headers || !block.rows) return null;
      return (
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-200 border">
            <thead className="bg-gray-50">
              <tr>
                {block.headers.map((header, i) => (
                  <th
                    key={i}
                    className="px-4 py-2 text-left text-sm font-medium text-gray-700 border"
                  >
                    {header}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {block.rows.map((row, rowIdx) => (
                <tr key={rowIdx} className="bg-white">
                  {row.map((cell, cellIdx) => (
                    <td
                      key={cellIdx}
                      className="px-4 py-2 text-sm text-gray-900 border"
                    >
                      {cell}
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      );
    default:
      return null;
  }
}

export function QuestionBlock({ question }: QuestionBlockProps) {
  return (
    <div className="space-y-4">
      {/* Question number and difficulty */}
      <div className="flex items-center gap-2">
        <span className="text-sm font-medium text-gray-500">
          Question {question.question_number}
        </span>
        <span
          className={`text-xs px-2 py-0.5 rounded-full ${
            question.difficulty === 'easy'
              ? 'bg-green-100 text-green-700'
              : question.difficulty === 'medium'
              ? 'bg-yellow-100 text-yellow-700'
              : 'bg-red-100 text-red-700'
          }`}
        >
          {question.difficulty}
        </span>
        <span className="text-xs px-2 py-0.5 rounded-full bg-blue-100 text-blue-700">
          {question.topic_category}
        </span>
      </div>

      {/* Question text with markdown support */}
      <div className="prose prose-sm max-w-none">
        <ReactMarkdown>{question.question_text}</ReactMarkdown>
      </div>

      {/* Content blocks if present */}
      {question.content_blocks && question.content_blocks.length > 0 && (
        <div className="space-y-3">
          {question.content_blocks.map((block, idx) => (
            <ContentBlockRenderer key={idx} block={block} />
          ))}
        </div>
      )}

      {/* Images if present */}
      {question.images && question.images.length > 0 && (
        <div className="flex flex-wrap gap-4 my-4">
          {question.images.map((img, idx) => (
            <figure key={idx} className="flex flex-col items-center">
              <img
                src={img.url}
                alt={img.alt}
                className="max-w-full h-auto rounded-lg border border-gray-200"
                loading="lazy"
              />
              {img.alt && (
                <figcaption className="text-xs text-gray-500 mt-1 text-center">
                  {img.alt}
                </figcaption>
              )}
            </figure>
          ))}
        </div>
      )}
    </div>
  );
}
