import { useState, useCallback } from 'react';
import { api } from '../lib/api';
import type { Question, QuizResult } from '../types/Quiz';

interface QuizSessionResponse {
  id: string;
  questions: Question[];
  currentIndex: number;
}

interface QuizAnswerResponse {
  correct: boolean;
  correct_answer: string;
}

interface UseQuizReturn {
  session: QuizSessionResponse | null;
  currentQuestion: Question | null;
  currentIndex: number;
  answers: Record<number, { selected: string | null; submitted: boolean }>;
  isLoading: boolean;
  error: string | null;
  startQuiz: (subtopicId?: string, questionCount?: number) => Promise<void>;
  selectAnswer: (label: string) => void;
  submitAnswer: () => Promise<QuizAnswerResponse | null>;
  nextQuestion: () => void;
  getResult: () => Promise<QuizResult | null>;
}

export function useQuiz(): UseQuizReturn {
  const [session, setSession] = useState<QuizSessionResponse | null>(null);
  const [answers, setAnswers] = useState<Record<number, { selected: string | null; submitted: boolean }>>({});
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const currentQuestion = session?.questions[session.currentIndex] || null;
  const currentIndex = session?.currentIndex || 0;

  const startQuiz = useCallback(async (subtopicId?: string, questionCount: number = 5) => {
    setIsLoading(true);
    setError(null);
    try {
      const newSession = await api.post<QuizSessionResponse>('/api/v1/quizzes/start', { subtopicId, questionCount });
      setSession(newSession);
      setAnswers({});
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to start quiz');
    } finally {
      setIsLoading(false);
    }
  }, []);

  const selectAnswer = useCallback((label: string) => {
    if (answers[currentIndex]?.submitted) return;
    setAnswers((prev) => ({
      ...prev,
      [currentIndex]: { selected: label, submitted: false },
    }));
  }, [currentIndex, answers]);

  const submitAnswer = useCallback(async (): Promise<QuizAnswerResponse | null> => {
    if (!session || !currentQuestion || !answers[currentIndex]?.selected) return null;

    setIsLoading(true);
    setError(null);
    try {
      const response = await api.post<QuizAnswerResponse>('/api/v1/quizzes/submit', {
        sessionId: session.id,
        questionId: currentQuestion.id,
        selected: answers[currentIndex].selected,
      });

      setAnswers((prev) => ({
        ...prev,
        [currentIndex]: { ...prev[currentIndex], submitted: true },
      }));

      return response;
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to submit answer');
      return null;
    } finally {
      setIsLoading(false);
    }
  }, [session, currentQuestion, currentIndex, answers]);

  const nextQuestion = useCallback(() => {
    if (!session) return;

    const nextIndex = session.currentIndex + 1;
    if (nextIndex >= session.questions.length) {
      // Quiz complete
      return;
    }

    setSession((prev) => prev ? { ...prev, currentIndex: nextIndex } : null);
  }, [session]);

  const getResult = useCallback(async (): Promise<QuizResult | null> => {
    if (!session) return null;

    setIsLoading(true);
    setError(null);
    try {
      return await api.get<QuizResult>(`/api/v1/quizzes/${session.id}/result`);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to get result');
      return null;
    } finally {
      setIsLoading(false);
    }
  }, [session]);

  return {
    session,
    currentQuestion,
    currentIndex,
    answers,
    isLoading,
    error,
    startQuiz,
    selectAnswer,
    submitAnswer,
    nextQuestion,
    getResult,
  };
}
