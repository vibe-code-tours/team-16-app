import { Link } from 'react-router-dom';
import { Card } from '../components/ui/Card';
import { Badge } from '../components/ui/Badge';

interface Topic {
  id: string;
  name: string;
  icon: string;
  color: string;
  questions_count: number;
  progress: number;
  unlocked: boolean;
}

const TOPICS: Topic[] = [
  {
    id: 'technology',
    name: 'Technology',
    icon: '💻',
    color: 'bg-blue-500',
    questions_count: 45,
    progress: 0,
    unlocked: true,
  },
  {
    id: 'security',
    name: 'Security',
    icon: '🔒',
    color: 'bg-red-500',
    questions_count: 25,
    progress: 0,
    unlocked: true,
  },
  {
    id: 'management',
    name: 'Management',
    icon: '📊',
    color: 'bg-green-500',
    questions_count: 30,
    progress: 0,
    unlocked: true,
  },
  {
    id: 'strategy',
    name: 'Strategy',
    icon: '🎯',
    color: 'bg-purple-500',
    questions_count: 20,
    progress: 0,
    unlocked: false,
  },
  {
    id: 'business',
    name: 'Business',
    icon: '💼',
    color: 'bg-yellow-500',
    questions_count: 18,
    progress: 0,
    unlocked: false,
  },
];

export function LearningMap() {
  return (
    <div className="min-h-screen bg-gray-50 py-8 px-4">
      <div className="max-w-4xl mx-auto">
        {/* Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900">Learning Map</h1>
          <p className="text-gray-600 mt-2">
            Master ITPEC FE topics step by step
          </p>
        </div>

        {/* Stats Summary */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
          <Card className="text-center">
            <div className="text-2xl font-bold text-primary-600">0</div>
            <div className="text-sm text-gray-600">Total XP</div>
          </Card>
          <Card className="text-center">
            <div className="text-2xl font-bold text-yellow-500">0</div>
            <div className="text-sm text-gray-600">Day Streak</div>
          </Card>
          <Card className="text-center">
            <div className="text-2xl font-bold text-green-600">0</div>
            <div className="text-sm text-gray-600">Quizzes Done</div>
          </Card>
          <Card className="text-center">
            <div className="text-2xl font-bold text-red-500">0</div>
            <div className="text-sm text-gray-600">Mistakes</div>
          </Card>
        </div>

        {/* Topic Grid */}
        <div className="grid md:grid-cols-2 gap-4">
          {TOPICS.map((topic) => (
            <Link
              key={topic.id}
              to={topic.unlocked ? `/quiz?topic=${topic.id}` : '#'}
              className={`block ${!topic.unlocked ? 'opacity-50 cursor-not-allowed' : ''}`}
            >
              <Card
                className={`hover:shadow-md transition-shadow ${
                  !topic.unlocked ? 'pointer-events-none' : ''
                }`}
              >
                <div className="flex items-start gap-4">
                  <div
                    className={`w-12 h-12 rounded-xl ${topic.color} flex items-center justify-center text-white text-2xl flex-shrink-0`}
                  >
                    {topic.icon}
                  </div>
                  <div className="flex-1">
                    <div className="flex items-center justify-between mb-1">
                      <h3 className="font-bold text-gray-900">{topic.name}</h3>
                      {!topic.unlocked && (
                        <Badge variant="default">🔒 Locked</Badge>
                      )}
                    </div>
                    <p className="text-sm text-gray-600 mb-2">
                      {topic.questions_count} questions
                    </p>
                    {topic.unlocked && (
                      <div className="w-full h-2 bg-gray-200 rounded-full overflow-hidden">
                        <div
                          className={`h-full ${topic.color} transition-all`}
                          style={{ width: `${topic.progress}%` }}
                        />
                      </div>
                    )}
                  </div>
                </div>
              </Card>
            </Link>
          ))}
        </div>

        {/* Quick Actions */}
        <div className="mt-8 flex flex-col sm:flex-row gap-4">
          <Link to="/quiz" className="flex-1">
            <Card className="text-center hover:shadow-md transition-shadow cursor-pointer">
              <span className="text-3xl mb-2 block">📝</span>
              <h3 className="font-bold text-gray-900">Practice Quiz</h3>
              <p className="text-sm text-gray-600">5 questions, any topic</p>
            </Card>
          </Link>
          <Link to="/exam" className="flex-1">
            <Card className="text-center hover:shadow-md transition-shadow cursor-pointer">
              <span className="text-3xl mb-2 block">⏱️</span>
              <h3 className="font-bold text-gray-900">Exam Simulation</h3>
              <p className="text-sm text-gray-600">60 questions, timed</p>
            </Card>
          </Link>
          <Link to="/mistakes" className="flex-1">
            <Card className="text-center hover:shadow-md transition-shadow cursor-pointer">
              <span className="text-3xl mb-2 block">🌱</span>
              <h3 className="font-bold text-gray-900">Mistake Garden</h3>
              <p className="text-sm text-gray-600">Review wrong answers</p>
            </Card>
          </Link>
        </div>
      </div>
    </div>
  );
}
