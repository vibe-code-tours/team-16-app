interface QuizStartScreenProps {
  onStart: () => void
  onBack: () => void
}

export function QuizStartScreen({ onStart, onBack }: QuizStartScreenProps) {
  return (
    <div className="flex min-h-screen items-center justify-center bg-gray-50 dark:bg-gray-900 px-4">
      <div className="w-full max-w-md rounded-2xl border border-gray-200 bg-white p-8 text-center shadow-sm dark:border-gray-700 dark:bg-gray-800">
        <div className="mb-4 text-5xl">📝</div>
        <h2 className="mb-2 text-2xl font-bold text-gray-900 dark:text-gray-100">Quiz Practice</h2>
        <p className="mb-6 text-gray-500 dark:text-gray-400">Test your knowledge with 5 questions</p>

        <div className="space-y-3">
          <button
            onClick={onStart}
            className="w-full rounded-lg bg-purple-600 px-4 py-3 font-bold text-white transition-colors hover:bg-purple-700"
          >
            Start Quiz
          </button>
          <button
            onClick={onBack}
            className="w-full rounded-lg border border-gray-300 px-4 py-3 font-medium text-gray-700 transition-colors hover:bg-gray-50 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700"
          >
            Back to Map
          </button>
        </div>
      </div>
    </div>
  )
}
