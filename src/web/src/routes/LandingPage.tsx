import { Link } from 'react-router-dom';
import { Button } from '../components/ui/Button';
import { Card } from '../components/ui/Card';

export function LandingPage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-500 to-primary-700">
      {/* Hero Section */}
      <div className="max-w-4xl mx-auto px-4 py-16 text-center">
        {/* Mascot placeholder */}
        <div className="w-32 h-32 mx-auto mb-8 bg-white rounded-full flex items-center justify-center shadow-lg">
          <span className="text-6xl">🦉</span>
        </div>

        <h1 className="text-4xl md:text-5xl font-bold text-white mb-4">
          NerdQuiz
        </h1>
        <p className="text-xl text-primary-100 mb-8 max-w-2xl mx-auto">
          Gamified IT exam prep for ITPEC FE certification. Learn, practice,
          and master IT concepts with fun quizzes and progress tracking.
        </p>

        <div className="flex flex-col sm:flex-row gap-4 justify-center">
          <Link to="/quiz">
            <Button size="lg" className="w-full sm:w-auto">
              Start Quiz
            </Button>
          </Link>
          <Link to="/map">
            <Button
              variant="outline"
              size="lg"
              className="w-full sm:w-auto border-white text-white hover:bg-white/10"
            >
              Learning Map
            </Button>
          </Link>
        </div>
      </div>

      {/* Features Section */}
      <div className="bg-white py-16">
        <div className="max-w-6xl mx-auto px-4">
          <h2 className="text-3xl font-bold text-center text-gray-900 mb-12">
            Why NerdQuiz?
          </h2>

          <div className="grid md:grid-cols-3 gap-8">
            <Card className="text-center">
              <div className="w-12 h-12 mx-auto mb-4 bg-primary-100 rounded-full flex items-center justify-center">
                <span className="text-2xl">🗺️</span>
              </div>
              <h3 className="text-lg font-bold text-gray-900 mb-2">
                Learning Map
              </h3>
              <p className="text-gray-600">
                Visual skill tree with locked/unlocked topics. Master basics
                before moving to advanced concepts.
              </p>
            </Card>

            <Card className="text-center">
              <div className="w-12 h-12 mx-auto mb-4 bg-green-100 rounded-full flex items-center justify-center">
                <span className="text-2xl">📝</span>
              </div>
              <h3 className="text-lg font-bold text-gray-900 mb-2">
                Bite-sized Quizzes
              </h3>
              <p className="text-gray-600">
                5-question practice sessions with instant feedback. Learn from
                mistakes with detailed explanations.
              </p>
            </Card>

            <Card className="text-center">
              <div className="w-12 h-12 mx-auto mb-4 bg-yellow-100 rounded-full flex items-center justify-center">
                <span className="text-2xl">🏆</span>
              </div>
              <h3 className="text-lg font-bold text-gray-900 mb-2">
                Track Progress
              </h3>
              <p className="text-gray-600">
                Earn XP, maintain streaks, and watch your skills grow. Review
                wrong answers in the Mistake Garden.
              </p>
            </Card>
          </div>
        </div>
      </div>

      {/* Exam Prep Section */}
      <div className="bg-gray-50 py-16">
        <div className="max-w-4xl mx-auto px-4 text-center">
          <h2 className="text-3xl font-bold text-gray-900 mb-4">
            Ready for Exam Day?
          </h2>
          <p className="text-lg text-gray-600 mb-8">
            Practice with real ITPEC FE exam questions. Timed simulations,
            hearts system, and detailed analytics.
          </p>

          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link to="/quiz">
              <Button size="lg">Start Practice Quiz</Button>
            </Link>
            <Link to="/exam">
              <Button variant="outline" size="lg">
                Exam Simulation
              </Button>
            </Link>
          </div>
        </div>
      </div>

      {/* Footer */}
      <footer className="bg-primary-800 text-primary-100 py-8">
        <div className="max-w-4xl mx-auto px-4 text-center">
          <p className="text-sm">
            Built with ❤️ for ITPEC FE exam candidates
          </p>
        </div>
      </footer>
    </div>
  );
}
