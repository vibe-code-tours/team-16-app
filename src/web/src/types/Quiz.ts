export interface Choice {
  label: string;
  text: string;
}

export interface ContentBlock {
  type: 'text' | 'markdown' | 'code' | 'table';
  text?: string;           // for text/markdown/code types
  language?: string;       // for code type
  headers?: string[];      // for table type
  rows?: string[][];       // for table type
}

export interface Question {
  id: string;
  exam_session: string;
  subject: string;
  question_number: number;
  topic_category: string;
  difficulty: 'easy' | 'medium' | 'hard';
  question_text: string;
  content_blocks?: ContentBlock[];
  images?: { url: string; alt: string }[];
  choices: Choice[];
  correct_answer: string;
  explanation?: string;
}

export interface QuizSession {
  id: string;
  questions: Question[];
  current_index: number;
  answers: Record<number, string>;
  score: number;
  xp_earned: number;
  started_at: Date;
  completed_at?: Date;
  status: 'in_progress' | 'completed';
}

export interface QuizResult {
  session_id: string;
  total_questions: number;
  correct_answers: number;
  score_percentage: number;
  xp_earned: number;
  answers: {
    question: Question;
    user_answer: string;
    is_correct: boolean;
  }[];
}
