import { Link } from 'react-router-dom'

export function LandingPage() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center px-4">
      <div className="max-w-lg text-center">
        <div className="mb-6 text-6xl">🦉</div>
        <h1 className="mb-4 text-5xl font-bold text-gray-900">
          NerdQuiz
        </h1>
        <p className="mb-8 text-lg text-gray-500">
          Gamified IT exam prep for ITPEC FE certification.
          Learn topics, practice quizzes, track your progress.
        </p>

        <div className="flex flex-col gap-3 sm:flex-row sm:justify-center">
          <Link
            to="/register"
            className="rounded-lg bg-purple-600 px-6 py-3 text-white font-medium hover:bg-purple-700"
          >
            Get started — it's free
          </Link>
          <Link
            to="/login"
            className="rounded-lg border border-gray-300 px-6 py-3 text-gray-700 font-medium hover:bg-gray-50"
          >
            Sign in
          </Link>
        </div>
      </div>
    </div>
  )
}
