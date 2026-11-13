import ReactMarkdown from 'react-markdown';
import type { Choice } from '../../types/Quiz';

interface ExplanationBoxProps {
  explanation?: string | null;
  is_correct: boolean;
  /** Shown in place of the explanation when the question has none. */
  correctChoice?: Choice;
}

export function ExplanationBox({ explanation, is_correct, correctChoice }: ExplanationBoxProps) {
  if (!explanation && !correctChoice) return null;

  return (
    <div
      role="status"
      className={`
        p-4 rounded-lg border-l-4 ${
          is_correct
            ? 'bg-green-50 dark:bg-green-900/30 border-green-500'
            : 'bg-red-50 dark:bg-red-900/30 border-red-500'
        }
      `}
    >
      <div className="flex items-start gap-3">
        <span className="text-xl" aria-hidden="true">{is_correct ? '✓' : '✗'}</span>
        <div className="flex-1">
          <h4
            className={`font-medium mb-2 ${
              is_correct ? 'text-green-800 dark:text-green-300' : 'text-red-800 dark:text-red-300'
            }`}
          >
            {is_correct ? 'Correct!' : 'Not quite.'}
          </h4>
          {explanation ? (
            <div className="prose prose-sm max-w-none text-gray-700 dark:text-gray-300">
              <ReactMarkdown>{explanation}</ReactMarkdown>
            </div>
          ) : (
            correctChoice && (
              <p className="text-sm text-gray-700 dark:text-gray-300">
                Correct answer:{' '}
                <span className="font-bold uppercase">{correctChoice.label}.</span>{' '}
                <span className="whitespace-pre-line">{correctChoice.text}</span>
              </p>
            )
          )}
        </div>
      </div>
    </div>
  );
}
