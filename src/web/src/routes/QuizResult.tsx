import { useEffect, useState } from 'react';
import { useLocation, useNavigate, useParams, Link } from 'react-router-dom';
import { Card } from '../components/ui/Card';
import { Button } from '../components/ui/Button';
import { Badge } from '../components/ui/Badge';
import { api } from '../lib/api';
import type { QuizResultApi } from '../types';
import type { QuizResult as QuizResultType } from '../types/Quiz';

/** Map backend camelCase response to the snake_case shape the component expects. */
function mapApiResult(apiResult: QuizResultApi): QuizResultType {
  return {
    session_id: apiResult.sessionId,
    total_questions: apiResult.totalQuestions,
    correct_answers: apiResult.correctAnswers,
    score_percentage: apiResult.scorePercentage,
    xp_earned: apiResult.xpEarned,
    answers: apiResult.answers.map((a) => ({
      question: {
        id: a.question.id,
        exam_session: a.question.examSession,
        subject: a.question.subject,
        question_number: a.question.questionNumber,
        topic_category: '',
        difficulty: a.question.difficulty as 'easy' | 'medium' | 'hard',
        question_text: a.question.questionText,
        images: a.question.images as { url: string; alt: string }[],
        choices: a.question.choices,
        correct_answer: a.question.correctAnswer,
        explanation: a.question.explanation ?? undefined,
      },
      user_answer: a.userAnswer,
      is_correct: a.isCorrect,
    })),
  };
}

export function QuizResult() {
  const { sessionId } = useParams<{ sessionId: string }>();
  const location = useLocation();
  const navigate = useNavigate();

  // location.state holds results passed immediately after quiz completion
  const initialState = location.state?.result as QuizResultType | undefined;

  const [result, setResult] = useState<QuizResultType | null>(initialState ?? null);
  const [loading, setLoading] = useState(!initialState);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!sessionId || result) return;

    let cancelled = false;
    setLoading(true);

    api
      .get<QuizResultApi>(`/api/v1/quizzes/${sessionId}/result`)
      .then((data) => {
        if (!cancelled) setResult(mapApiResult(data));
      })
      .catch((err) => {
        if (!cancelled) setError(err instanceof Error ? err.message : 'Failed to load results');
      })
      .finally(() => {
        if (!cancelled) setLoading(false);
      });

    return () => {
      cancelled = true;
    };
  }, [sessionId, result]);

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-purple-600" />
      </div>
    );
  }

  if (error || !result) {
    return (
      <div className="min-h-screen bg-gray-50 flex items-center justify-center">
        <Card className="text-center p-8">
          <h2 className="text-xl font-bold mb-4">No results found</h2>
          <p className="text-gray-600 mb-4">
            {error || 'Please complete a quiz first.'}
          </p>
          <Link to="/quizzes">
            <Button>Start Quiz</Button>
          </Link>
        </Card>
      </div>
    );
  }

  const getScoreColor = (percentage: number) => {
    if (percentage >= 80) return 'text-green-600';
    if (percentage >= 60) return 'text-yellow-600';
    return 'text-red-600';
  };

  const getScoreMessage = (percentage: number) => {
    if (percentage >= 90) return 'Excellent!';
    if (percentage >= 80) return 'Great job!';
    if (percentage >= 70) return 'Good work!';
    if (percentage >= 60) return 'Not bad!';
    return 'Keep practicing!';
  };

  return (
    <div className="min-h-screen bg-gray-50 py-8 px-4">
      <div className="max-w-2xl mx-auto">
        {/* Score Header */}
        <Card className="mb-6 text-center">
          <div className="py-6">
            <h1 className="text-3xl font-bold text-gray-900 mb-2">
              Quiz Complete!
            </h1>
            <p className="text-xl text-gray-600 mb-6">
              {getScoreMessage(result.score_percentage)}
            </p>

            <div className="flex justify-center items-center gap-8 mb-6">
              <div>
                <div
                  className={`text-5xl font-bold ${getScoreColor(
                    result.score_percentage
                  )}`}
                >
                  {result.score_percentage}%
                </div>
                <div className="text-sm text-gray-500">Score</div>
              </div>
              <div className="w-px h-16 bg-gray-200" />
              <div>
                <div className="text-5xl font-bold text-primary-600">
                  +{result.xp_earned}
                </div>
                <div className="text-sm text-gray-500">XP Earned</div>
              </div>
            </div>

            <div className="flex justify-center gap-4">
              <Badge variant="success">
                {result.correct_answers} Correct
              </Badge>
              <Badge variant="error">
                {result.total_questions - result.correct_answers} Incorrect
              </Badge>
            </div>
          </div>
        </Card>

        {/* Answer Review */}
        <h2 className="text-lg font-bold text-gray-900 mb-4">Review Answers</h2>
        <div className="space-y-4">
          {result.answers.map((item) => (
            <Card
              key={item.question.id}
              className={`border-l-4 ${
                item.is_correct ? 'border-l-green-500' : 'border-l-red-500'
              }`}
            >
              <div className="flex items-start justify-between mb-2">
                <span className="font-medium text-gray-700">
                  Q{item.question.question_number}
                </span>
                <Badge variant={item.is_correct ? 'success' : 'error'}>
                  {item.is_correct ? 'Correct' : 'Incorrect'}
                </Badge>
              </div>

              <p className="text-sm text-gray-600 mb-3 line-clamp-2">
                {item.question.question_text}
              </p>

              <div className="text-sm space-y-1">
                <div>
                  <span className="text-gray-500">Your answer:</span>{' '}
                  <span
                    className={
                      item.is_correct ? 'text-green-600' : 'text-red-600'
                    }
                  >
                    {item.user_answer}){' '}
                    {item.question.choices.find(
                      (c) => c.label === item.user_answer
                    )?.text || ''}
                  </span>
                </div>
                {!item.is_correct && (
                  <div>
                    <span className="text-gray-500">Correct answer:</span>{' '}
                    <span className="text-green-600">
                      {item.question.correct_answer}){' '}
                      {item.question.choices.find(
                        (c) => c.label === item.question.correct_answer
                      )?.text || ''}
                    </span>
                  </div>
                )}
                {item.question.explanation && (
                  <div className="mt-2 p-2 bg-gray-50 rounded text-gray-600">
                    <span className="font-medium">Explanation:</span>{' '}
                    {item.question.explanation}
                  </div>
                )}
              </div>
            </Card>
          ))}
        </div>

        {/* Actions */}
        <div className="mt-8 flex gap-4">
          <Button
            variant="outline"
            onClick={() => navigate('/quizzes')}
            className="flex-1"
          >
            Try Again
          </Button>
          <Button onClick={() => navigate('/map')} className="flex-1">
            Back to Learning Map
          </Button>
        </div>
      </div>
    </div>
  );
}
