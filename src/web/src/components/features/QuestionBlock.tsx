import ReactMarkdown from 'react-markdown';
import type { Question } from '../../types/Quiz';

interface QuestionBlockProps {
  question: Question;
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
