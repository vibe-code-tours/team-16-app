import ReactMarkdown from 'react-markdown';
import type { Question } from '../../types/Quiz';

/** Question text is required; exam metadata and images are shown only when present. */
export type QuestionBlockQuestion = Pick<Question, 'question_text'> &
  Partial<Pick<Question, 'question_number' | 'difficulty' | 'topic_category' | 'images'>>;

interface QuestionBlockProps {
  question: QuestionBlockQuestion;
}

export function QuestionBlock({ question }: QuestionBlockProps) {
  const hasMetadata = Boolean(
    question.question_number || question.difficulty || question.topic_category
  );
  const imageFallbackAlt = question.question_number
    ? `Question ${question.question_number} image`
    : 'Question image';

  return (
    <div className="space-y-4">
      {/* Question number and difficulty */}
      {hasMetadata && (
        <div className="flex items-center gap-2">
          {question.question_number ? (
            <span className="text-sm font-medium text-gray-500 dark:text-gray-400">
              Question {question.question_number}
            </span>
          ) : null}
          {question.difficulty && (
            <span
              className={`text-xs px-2 py-0.5 rounded-full ${
                question.difficulty === 'easy'
                  ? 'bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400'
                  : question.difficulty === 'medium'
                  ? 'bg-yellow-100 dark:bg-yellow-900/30 text-yellow-700 dark:text-yellow-400'
                  : 'bg-red-100 dark:bg-red-900/30 text-red-700 dark:text-red-400'
              }`}
            >
              {question.difficulty}
            </span>
          )}
          {question.topic_category && (
            <span className="text-xs px-2 py-0.5 rounded-full bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-400">
              {question.topic_category}
            </span>
          )}
        </div>
      )}

      {/* Question text with markdown support; keep single line breaks from the source PDFs */}
      <div className="prose prose-sm max-w-none text-lg font-semibold leading-relaxed text-gray-900 dark:text-gray-100 [&_p]:whitespace-pre-line">
        <ReactMarkdown>{question.question_text}</ReactMarkdown>
      </div>

      {/* Images if present */}
      {question.images && question.images.length > 0 && (
        <div className="flex flex-wrap gap-4 my-4">
          {question.images.map((img, idx) => (
            <figure key={img.url || idx} className="flex flex-col items-center">
              <img
                src={img.url}
                alt={img.alt || imageFallbackAlt}
                className="max-w-full h-auto rounded-lg border border-gray-200 dark:border-gray-700"
                loading="lazy"
              />
              {img.alt && (
                <figcaption className="text-xs text-gray-500 dark:text-gray-400 mt-1 text-center">
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
