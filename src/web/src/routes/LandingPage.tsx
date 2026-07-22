import { Link } from 'react-router-dom'
import { Badge } from '../components/ui/Badge'
import { Card } from '../components/ui/Card'

export function LandingPage() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-purple-50 via-white to-white dark:from-purple-950/30 dark:via-gray-900 dark:to-gray-900">
      <header className="fixed inset-x-0 top-0 z-50 border-b border-purple-100 dark:border-purple-900/50 bg-white/90 dark:bg-gray-800/90 backdrop-blur-sm">
        <div className="mx-auto flex max-w-6xl items-center justify-between px-4 py-4">
          <Link
            to="/"
            className="flex items-center gap-2 rounded-lg text-xl font-bold text-gray-900 dark:text-gray-100 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2"
            aria-label="NerdQuiz home"
          >
            <span aria-hidden="true">⚡</span>
            NerdQuiz
          </Link>
          <nav aria-label="Public navigation" className="flex items-center gap-2">
            <Link
              to="/login"
              className="rounded-lg px-3 py-2 text-sm font-semibold text-gray-600 dark:text-gray-400 transition-colors duration-200 hover:bg-gray-100 dark:hover:bg-gray-700 hover:text-gray-900 dark:hover:text-gray-100 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2"
            >
              Sign in
            </Link>
            <Link
              to="/register"
              className="rounded-lg bg-purple-600 px-4 py-2 text-sm font-bold text-white shadow-sm transition-colors duration-200 hover:bg-purple-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2"
            >
              Get started
            </Link>
          </nav>
        </div>
      </header>

      <main className="pt-16">
        <section className="learning-hero-enter mx-auto grid max-w-6xl gap-10 px-4 py-12 md:grid-cols-[minmax(0,1.1fr)_minmax(300px,0.9fr)] md:items-center md:py-16">
          <div>
            <Badge className="mb-4 bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-400">IT Exam Prep — Gamified</Badge>
            <h1 className="max-w-3xl text-5xl font-bold text-gray-900 dark:text-gray-100 sm:text-6xl">
              NerdQuiz
            </h1>
            <p className="mt-4 max-w-2xl text-xl text-gray-600 dark:text-gray-400">
              A focused, encouraging way to prepare for ITPEC FE certification with lessons, quizzes, review, and exam practice in one learning loop.
            </p>
            <div className="mt-8 flex flex-col gap-3 sm:flex-row">
              <Link
                to="/register"
                className="inline-flex min-h-12 items-center justify-center rounded-lg bg-purple-600 px-8 py-3 text-base font-bold text-white shadow-lg transition-all duration-200 hover:-translate-y-0.5 hover:bg-purple-700 hover:shadow-xl focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2"
              >
                Start learning free
                <span className="ml-2" aria-hidden="true">→</span>
              </Link>
              <Link
                to="/login"
                className="inline-flex min-h-12 items-center justify-center rounded-lg border-2 border-gray-300 dark:border-gray-600 px-8 py-3 text-base font-semibold text-gray-700 dark:text-gray-300 transition-colors duration-200 hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2"
              >
                Continue your journey
              </Link>
            </div>
          </div>

          <Card className="border-purple-100 dark:border-purple-900/50 bg-white/90 dark:bg-gray-800/90" padding="lg">
            <div className="flex flex-col gap-6">
              <div className="flex items-start gap-4">
                <span
                  className="learning-owl-enter flex size-20 shrink-0 items-center justify-center rounded-3xl bg-purple-50 dark:bg-purple-900/30 text-5xl shadow-sm ring-1 ring-purple-100 dark:ring-purple-800"
                  aria-hidden="true"
                >
                  🦉
                </span>
                <div>
                  <p className="text-xs font-medium uppercase tracking-widest text-gray-500 dark:text-gray-400">
                    Today&apos;s mission
                  </p>
                  <h2 className="mt-1 text-2xl font-bold text-gray-900 dark:text-gray-100">
                    Learn a little, prove it, and keep improving.
                  </h2>
                </div>
              </div>
              <div className="grid grid-cols-3 gap-3">
                <LandingStat value="2-3m" label="Lessons" />
                <LandingStat value="5Q" label="Quizzes" />
                <LandingStat value="60Q" label="Exam" />
              </div>
              <div
                className="h-3 overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700"
                role="progressbar"
                aria-label="Sample learning loop progress"
                aria-valuemin={0}
                aria-valuemax={100}
                aria-valuenow={68}
              >
                <div className="learning-progress-reveal h-full w-[70%] rounded-full bg-gradient-to-r from-purple-500 to-purple-600" />
              </div>
            </div>
          </Card>
        </section>

        <section aria-labelledby="features-heading" className="mx-auto max-w-6xl px-4 pb-16">
          <div className="mb-6 max-w-2xl">
            <Badge className="mb-2 bg-amber-100 dark:bg-amber-900/30 text-amber-700 dark:text-amber-400">Complete learning loop</Badge>
            <h2 id="features-heading" className="text-2xl font-bold text-gray-900 dark:text-gray-100">
              Everything you need to pass
            </h2>
            <p className="mt-1 text-sm text-gray-500 dark:text-gray-400">
              Each feature supports the same goal: steady ITPEC FE preparation that is easy to resume.
            </p>
          </div>

          <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {LANDING_FEATURES.map((feature) => (
              <Link
                key={feature.title}
                to={feature.href}
                className="learning-feature-enter group rounded-xl focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2"
              >
                <Card className={`h-full border-t-4 ${feature.accentClass} transition-all duration-200 group-hover:-translate-y-1 group-hover:shadow-md`} padding="lg">
                  <div className="flex h-full flex-col gap-4">
                    <div className="flex items-start justify-between gap-3">
                      <span className={`flex size-12 items-center justify-center rounded-2xl text-2xl ${feature.iconClass}`} aria-hidden="true">
                        {feature.icon}
                      </span>
                      <span className="text-gray-400 dark:text-gray-500 transition-transform duration-200 group-hover:translate-x-1 group-hover:text-purple-600" aria-hidden="true">
                        →
                      </span>
                    </div>
                    <div className="flex flex-1 flex-col gap-1">
                      <h3 className="text-lg font-bold text-gray-900 dark:text-gray-100">{feature.title}</h3>
                      <p className="text-sm leading-6 text-gray-500 dark:text-gray-400">{feature.description}</p>
                    </div>
                    <p className="text-sm font-semibold text-purple-700 dark:text-purple-400">{feature.action}</p>
                  </div>
                </Card>
              </Link>
            ))}
          </div>
        </section>
      </main>
    </div>
  )
}

function LandingStat({ value, label }: { value: string; label: string }) {
  return (
    <div className="rounded-xl border border-gray-100 dark:border-gray-700 bg-gray-50 dark:bg-gray-800 p-3 text-center">
      <p className="text-xl font-bold text-gray-900 dark:text-gray-100">{value}</p>
      <p className="text-xs font-medium text-gray-500 dark:text-gray-400">{label}</p>
    </div>
  )
}

interface LandingFeature {
  title: string
  description: string
  action: string
  href: string
  icon: string
  iconClass: string
  accentClass: string
}

const LANDING_FEATURES: LandingFeature[] = [
  {
    title: 'Bite-sized lessons',
    description: 'Build strong foundations with friendly reads designed for focused study sessions.',
    action: 'Start with lesson mode',
    href: '/register',
    icon: '📚',
    iconClass: 'bg-purple-100 dark:bg-purple-900/30',
    accentClass: 'border-t-purple-400 dark:border-t-purple-500',
  },
  {
    title: 'Practice quizzes',
    description: 'Check your understanding, get instant feedback, and earn XP as you improve.',
    action: 'Practice after each topic',
    href: '/register',
    icon: '🎯',
    iconClass: 'bg-blue-100 dark:bg-blue-900/30',
    accentClass: 'border-t-blue-400 dark:border-t-blue-500',
  },
  {
    title: 'Learning-map progress',
    description: 'See completed milestones, unlocked topics, and the next stop on your roadmap.',
    action: 'Build your roadmap',
    href: '/register',
    icon: '🗺️',
    iconClass: 'bg-emerald-100 dark:bg-emerald-900/30',
    accentClass: 'border-t-emerald-400 dark:border-t-emerald-500',
  },
  {
    title: 'Mistake Garden review',
    description: 'Turn wrong answers into growth by reviewing and clearing each saved mistake.',
    action: 'Grow from mistakes',
    href: '/register',
    icon: '🌱',
    iconClass: 'bg-green-100 dark:bg-green-900/30',
    accentClass: 'border-t-green-400 dark:border-t-green-500',
  },
  {
    title: 'Exam simulation',
    description: 'Build confidence under realistic timing, questions, and exam-day conditions.',
    action: 'Prepare for exam day',
    href: '/register',
    icon: '📝',
    iconClass: 'bg-amber-100 dark:bg-amber-900/30',
    accentClass: 'border-t-amber-400 dark:border-t-amber-500',
  },
  {
    title: 'XP, streaks, and profile achievements',
    description: 'Celebrate steady effort, watch your XP grow, and protect your study streak.',
    action: 'Track your effort',
    href: '/register',
    icon: '⚡',
    iconClass: 'bg-orange-100 dark:bg-orange-900/30',
    accentClass: 'border-t-orange-400 dark:border-t-orange-500',
  },
]
