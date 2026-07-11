import type { Question, QuizResult } from '../types/Quiz';

const API_BASE = import.meta.env.VITE_API_URL || '/api/v1';

async function fetchApi<T>(
  endpoint: string,
  options: RequestInit = {}
): Promise<T> {
  const response = await fetch(`${API_BASE}${endpoint}`, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...options.headers,
    },
  });

  if (!response.ok) {
    const error = await response.json().catch(() => ({ detail: 'Unknown error' }));
    throw new Error(error.detail || `API error: ${response.status}`);
  }

  return response.json();
}

// Question API
export const questionApi = {
  getRandom: (count: number = 5): Promise<Question[]> =>
    fetchApi(`/questions/random?count=${count}`),

  getBySession: (session: string, subject: string = 'A'): Promise<Question[]> =>
    fetchApi(`/questions/session/${session}?subject=${subject}`),

  getStats: (session: string, subject: string = 'A'): Promise<{ total: number }> =>
    fetchApi(`/questions/stats?examSession=${session}&subject=${subject}`),
};

// Quiz API
export interface QuizSessionResponse {
  id: string;
  questions: Question[];
  currentIndex: number;
  score: number;
  xpEarned: number;
  startedAt: string;
  completedAt: string | null;
  status: string;
}

export interface QuizAnswerResponse {
  id: string;
  quizSessionId: string;
  questionId: string;
  userAnswer: string;
  isCorrect: boolean;
  answeredAt: string;
}

export const quizApi = {
  start: (subtopicId?: string, questionCount: number = 5): Promise<QuizSessionResponse> =>
    fetchApi('/quizzes/start', {
      method: 'POST',
      body: JSON.stringify({ subtopicId, questionCount }),
    }),

  submitAnswer: (
    sessionId: string,
    questionId: string,
    answer: string
  ): Promise<QuizAnswerResponse> =>
    fetchApi(`/quizzes/${sessionId}/answers`, {
      method: 'POST',
      body: JSON.stringify({ questionId, answer }),
    }),

  getResult: (sessionId: string): Promise<QuizResult> =>
    fetchApi(`/quizzes/${sessionId}/result`),
};
