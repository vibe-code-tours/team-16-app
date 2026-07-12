import { useState, useCallback, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { QuestionBlock } from '../components/features/QuestionBlock';
import { ChoiceList } from '../components/features/ChoiceList';
import { ExplanationBox } from '../components/features/ExplanationBox';
import { ProgressBar } from '../components/features/ProgressBar';
import { Button } from '../components/ui/Button';
import { Card } from '../components/ui/Card';
import { SAMPLE_QUESTIONS } from '../data/sampleQuestions';
import type { Question, QuizResult } from '../types/Quiz';

interface AnswerState {
  selected: string | null;
  submitted: boolean;
}

export function QuizSession() {
  const navigate = useNavigate();
  const [questions] = useState<Question[]>(SAMPLE_QUESTIONS);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState<Record<number, AnswerState>>({});
  const [showExplanation, setShowExplanation] = useState(false);

  const currentQuestion = questions[currentIndex];
  const currentAnswer = answers[currentIndex];
  const isLastQuestion = currentIndex === questions.length - 1;

  const score = useMemo(
    () =>
      Object.entries(answers).filter(
        ([idx, ans]) =>
          ans.submitted && ans.selected === questions[parseInt(idx)].correct_answer
      ).length,
    [answers, questions]
  );

  const submittedCount = useMemo(
    () => Object.values(answers).filter((a) => a.submitted).length,
    [answers]
  );

  const handleSelectAnswer = useCallback(
    (label: string) => {
      if (currentAnswer?.submitted) return;
      setAnswers((prev) => ({
        ...prev,
        [currentIndex]: { selected: label, submitted: false },
      }));
    },
    [currentIndex, currentAnswer]
  );

  const handleSubmitAnswer = useCallback(() => {
    if (!currentAnswer?.selected) return;
    setAnswers((prev) => ({
      ...prev,
      [currentIndex]: { ...prev[currentIndex], submitted: true },
    }));
    setShowExplanation(true);
  }, [currentIndex, currentAnswer]);

  const handleNextQuestion = useCallback(() => {
    setShowExplanation(false);
    if (isLastQuestion) {
      const result: QuizResult = {
        session_id: 'demo',
        total_questions: questions.length,
        correct_answers: score,
        score_percentage: Math.round((score / questions.length) * 100),
        xp_earned: score * 10,
        answers: Object.entries(answers)
          .filter(([_, ans]) => ans.submitted)
          .map(([idx, ans]) => ({
            question: questions[parseInt(idx)],
            user_answer: ans.selected!,
            is_correct:
              ans.selected === questions[parseInt(idx)].correct_answer,
          })),
      };

      // Navigate to results
      navigate('/quiz-result', { state: { result } });
    } else {
      setCurrentIndex((prev) => prev + 1);
    }
  }, [currentIndex, isLastQuestion, answers, questions, navigate, score]);

  return (
    <div className="min-h-screen bg-gray-50 py-8 px-4">
      <div className="max-w-2xl mx-auto">
        {/* Header */}
        <div className="mb-6">
          <div className="flex items-center justify-between mb-4">
            <h1 className="text-2xl font-bold text-gray-900">Quiz Practice</h1>
            <div className="flex items-center gap-4 text-sm text-gray-600">
              <span>Score: {score} / {submittedCount}</span>
              <span>XP: {score * 10}</span>
            </div>
          </div>
          <ProgressBar
            current={currentIndex + 1}
            total={questions.length}
          />
        </div>

        {/* Question Card */}
        <Card className="mb-6">
          <QuestionBlock question={currentQuestion} />
        </Card>

        {/* Choices */}
        <Card className="mb-6">
          <ChoiceList
            choices={currentQuestion.choices}
            selectedAnswer={currentAnswer?.selected || null}
            onSelect={handleSelectAnswer}
            disabled={currentAnswer?.submitted}
            showCorrect={currentAnswer?.submitted || false}
            correctAnswer={currentQuestion.correct_answer}
          />
        </Card>

        {/* Explanation */}
        {showExplanation && currentAnswer?.submitted && (
          <div className="mb-6">
            <ExplanationBox
              explanation={currentQuestion.explanation || ''}
              is_correct={currentAnswer.selected === currentQuestion.correct_answer}
            />
          </div>
        )}

        {/* Action Buttons */}
        <div className="flex gap-4">
          {!currentAnswer?.submitted ? (
            <>
              <Button
                variant="outline"
                onClick={handleNextQuestion}
                className="flex-1"
              >
                Skip
              </Button>
              <Button
                onClick={handleSubmitAnswer}
                disabled={!currentAnswer?.selected}
                className="flex-1"
              >
                Check Answer
              </Button>
            </>
          ) : (
            <Button onClick={handleNextQuestion} className="w-full">
              {isLastQuestion ? 'See Results' : 'Next Question'}
            </Button>
          )}
        </div>
      </div>
    </div>
  );
}
