import type { Choice } from '../../types/Quiz';

interface ChoiceListProps {
  choices: Choice[];
  selectedAnswer: string | null;
  onSelect: (label: string) => void;
  disabled?: boolean;
  showCorrect?: boolean;
  correctAnswer?: string;
}

export function ChoiceList({
  choices,
  selectedAnswer,
  onSelect,
  disabled = false,
  showCorrect = false,
  correctAnswer,
}: ChoiceListProps) {
  return (
    <div className="space-y-2">
      {choices.map((choice) => {
        const isSelected = selectedAnswer === choice.label;
        const isCorrect = showCorrect && choice.label === correctAnswer;
        const isWrong = showCorrect && isSelected && choice.label !== correctAnswer;

        return (
          <button
            key={choice.label}
            onClick={() => onSelect(choice.label)}
            disabled={disabled}
            className={`
              w-full text-left p-4 rounded-lg border-2 transition-all
              ${
                isSelected
                  ? 'border-primary-500 bg-primary-50'
                  : 'border-gray-200 dark:border-gray-700 hover:border-gray-300 dark:hover:border-gray-600 hover:bg-gray-50 dark:hover:bg-gray-700'
              }
              ${isCorrect ? 'border-green-500 bg-green-50 dark:bg-green-900/30' : ''}
              ${isWrong ? 'border-red-500 bg-red-50 dark:bg-red-900/30' : ''}
              ${disabled ? 'cursor-not-allowed opacity-75' : 'cursor-pointer'}
            `}
          >
            <div className="flex items-start gap-3">
              {/* Radio circle */}
              <div
                className={`
                  mt-0.5 w-5 h-5 rounded-full border-2 flex-shrink-0 flex items-center justify-center
                  ${
                    isSelected
                      ? 'border-primary-500 bg-primary-500'
                      : isCorrect
                      ? 'border-green-500 bg-green-500'
                      : 'border-gray-300 dark:border-gray-600'
                  }
                `}
              >
                {(isSelected || isCorrect) && (
                  <div className="w-2 h-2 rounded-full bg-white" />
                )}
              </div>

              {/* Choice label and text */}
              <div className="flex-1">
                <span className="font-medium text-gray-700 dark:text-gray-300 uppercase">
                  {choice.label})
                </span>{' '}
                <span className="text-gray-800 dark:text-gray-200">{choice.text}</span>
              </div>

              {/* Correct/Wrong indicator */}
              {showCorrect && isCorrect && (
                <span className="text-green-600 text-sm font-medium">✓</span>
              )}
              {isWrong && (
                <span className="text-red-600 text-sm font-medium">✗</span>
              )}
            </div>
          </button>
        );
      })}
    </div>
  );
}
