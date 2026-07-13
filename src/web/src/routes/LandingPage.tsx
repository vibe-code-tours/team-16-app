import { Link } from 'react-router-dom'

export function LandingPage() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-50 to-white">
      {/* Hero */}
      <div className="flex min-h-screen flex-col items-center justify-center px-4 py-12">
        <div className="max-w-2xl text-center">
          {/* Mascot */}
          <div className="mb-6 text-7xl animate-bounce">🦉</div>
          
          <h1 className="mb-4 text-5xl font-bold text-gray-900 sm:text-6xl">
            NerdQuiz
          </h1>
          
          <p className="mb-4 text-xl text-gray-600">
            Gamified IT exam prep for ITPEC FE certification
          </p>
          
          <p className="mb-8 text-gray-500">
            Learn topics, practice quizzes, track your progress, and ace the exam!
          </p>

          <div className="flex flex-col gap-3 sm:flex-row sm:justify-center">
            <Link
              to="/register"
              className="rounded-lg bg-purple-600 px-8 py-4 text-lg font-bold text-white shadow-lg hover:bg-purple-700 hover:shadow-xl transition-all"
            >
              Get started — it's free
            </Link>
            <Link
              to="/login"
              className="rounded-lg border-2 border-gray-300 px-8 py-4 text-lg font-medium text-gray-700 hover:bg-gray-50 transition-all"
            >
              Sign in
            </Link>
          </div>
        </div>

        {/* Features */}
        <div className="mt-20 max-w-4xl w-full">
          <h2 className="text-center text-2xl font-bold text-gray-900 mb-8">
            Everything you need to pass
          </h2>
          
          <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
            <FeatureCard
              icon="📚"
              title="Short Lessons"
              description="2-3 minute reads before each quiz"
            />
            <FeatureCard
              icon="🎯"
              title="Practice Quizzes"
              description="5 questions per topic with instant feedback"
            />
            <FeatureCard
              icon="🏆"
              title="XP & Streaks"
              description="Earn points and track your daily progress"
            />
            <FeatureCard
              icon="🌱"
              title="Mistake Garden"
              description="Review your wrong answers to learn faster"
            />
            <FeatureCard
              icon="📝"
              title="Exam Simulation"
              description="60-question timed practice exam"
            />
            <FeatureCard
              icon="📊"
              title="Track Progress"
              description="See how far you've come"
            />
          </div>
        </div>

        {/* Footer */}
        <div className="mt-16 text-center text-sm text-gray-400">
          <p>© 2024 NerdQuiz. Built for ITPEC FE exam success.</p>
        </div>
      </div>
    </div>
  )
}

function FeatureCard({ icon, title, description }: { icon: string; title: string; description: string }) {
  return (
    <div className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm hover:shadow-md transition-shadow">
      <div className="mb-3 text-3xl">{icon}</div>
      <h3 className="mb-2 font-semibold text-gray-900">{title}</h3>
      <p className="text-sm text-gray-500">{description}</p>
    </div>
  )
}
