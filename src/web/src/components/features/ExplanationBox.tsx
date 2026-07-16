import ReactMarkdown from 'react-markdown';

interface ExplanationBoxProps {
  explanation: string;
  is_correct: boolean;
}

export function ExplanationBox({ explanation, is_correct }: ExplanationBoxProps) {
  if (!explanation) return null;

  return (
    <div
      className={`
        p-4 rounded-lg border-l-4 ${
          is_correct
            ? 'bg-green-50 dark:bg-green-900/30 border-green-500'
            : 'bg-red-50 dark:bg-red-900/30 border-red-500'
        }
      `}
    >
      <div className="flex items-start gap-3">
        <span className="text-xl">{is_correct ? '✓' : '✗'}</span>
        <div className="flex-1">
          <h4
            className={`font-medium mb-2 ${
              is_correct ? 'text-green-800 dark:text-green-300' : 'text-red-800 dark:text-red-300'
            }`}
          >
            {is_correct ? 'Correct!' : 'Incorrect'}
          </h4>
          <div className="prose prose-sm max-w-none text-gray-700 dark:text-gray-300">
            <ReactMarkdown>{explanation}</ReactMarkdown>
          </div>
        </div>
      </div>
    </div>
  );
}
