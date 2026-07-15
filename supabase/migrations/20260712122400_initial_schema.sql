-- NerdQuiz complete initial schema
-- Run once against a new Supabase project.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

-- ---------- Profiles and curriculum ----------

CREATE TABLE profiles (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  avatar_url TEXT,
  timezone TEXT NOT NULL DEFAULT 'UTC',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE topics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  description TEXT,
  icon_url TEXT,
  display_order INT NOT NULL DEFAULT 0,
  published BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE subtopics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  topic_id UUID NOT NULL REFERENCES topics(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  slug TEXT NOT NULL,
  description TEXT,
  icon_url TEXT,
  display_order INT NOT NULL DEFAULT 0,
  published BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (topic_id, slug)
);

CREATE TABLE lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subtopic_id UUID NOT NULL REFERENCES subtopics(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  slug TEXT NOT NULL,
  summary TEXT,
  content_blocks JSONB NOT NULL DEFAULT '[]'::jsonb,
  estimated_minutes INT NOT NULL DEFAULT 3 CHECK (estimated_minutes > 0),
  xp_reward INT NOT NULL DEFAULT 0 CHECK (xp_reward >= 0),
  display_order INT NOT NULL DEFAULT 0,
  published BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (subtopic_id, slug)
);

CREATE TABLE lesson_prerequisites (
  lesson_id UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  prerequisite_lesson_id UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  PRIMARY KEY (lesson_id, prerequisite_lesson_id),
  CHECK (lesson_id <> prerequisite_lesson_id)
);

CREATE TABLE user_lesson_progress (
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  lesson_id UUID NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'locked'
    CHECK (status IN ('locked', 'unlocked', 'in_progress', 'completed')),
  started_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, lesson_id)
);

-- ---------- Question bank and original sources ----------

CREATE TABLE questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subtopic_id UUID REFERENCES subtopics(id) ON DELETE SET NULL,
  exam_session TEXT NOT NULL,
  subject TEXT NOT NULL CHECK (subject IN ('A', 'B')),
  question_number INT NOT NULL CHECK (question_number > 0),
  question_text TEXT NOT NULL,
  content_blocks JSONB NOT NULL DEFAULT '[]'::jsonb,
  images JSONB NOT NULL DEFAULT '[]'::jsonb,
  choices JSONB NOT NULL,
  correct_answer TEXT NOT NULL,
  answer_key JSONB NOT NULL DEFAULT '{}'::jsonb,
  explanation TEXT,
  difficulty TEXT NOT NULL DEFAULT 'medium'
    CHECK (difficulty IN ('easy', 'medium', 'hard')),
  difficulty_score NUMERIC(4,3) NOT NULL DEFAULT 0.500
    CHECK (difficulty_score BETWEEN 0 AND 1),
  times_answered INT NOT NULL DEFAULT 0 CHECK (times_answered >= 0),
  times_correct INT NOT NULL DEFAULT 0 CHECK (times_correct >= 0),
  source_file TEXT,
  source_citation TEXT,
  source_pages INT[] NOT NULL DEFAULT '{}',
  extraction_method TEXT NOT NULL DEFAULT 'native_text',
  extraction_version TEXT,
  source_text TEXT,
  ref_doc JSONB NOT NULL DEFAULT '{}'::jsonb,
  published BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (exam_session, subject, question_number),
  CHECK (times_correct <= times_answered)
);

CREATE TABLE question_subtopics (
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  subtopic_id UUID NOT NULL REFERENCES subtopics(id) ON DELETE CASCADE,
  is_primary BOOLEAN NOT NULL DEFAULT false,
  confidence NUMERIC(4,3) CHECK (confidence BETWEEN 0 AND 1),
  classification_source TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (question_id, subtopic_id)
);

CREATE UNIQUE INDEX uq_question_primary_subtopic
  ON question_subtopics(question_id) WHERE is_primary;

-- ---------- Five-question and adaptive quizzes ----------

CREATE TABLE quiz_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  subtopic_id UUID REFERENCES subtopics(id) ON DELETE SET NULL,
  lesson_id UUID REFERENCES lessons(id) ON DELETE SET NULL,
  quiz_type TEXT NOT NULL DEFAULT 'practice'
    CHECK (quiz_type IN ('practice', 'lesson', 'mistake_review', 'adaptive')),
  question_count INT NOT NULL DEFAULT 5 CHECK (question_count > 0),
  completed_question_count INT NOT NULL DEFAULT 0 CHECK (completed_question_count >= 0),
  target_difficulty NUMERIC(4,3) CHECK (target_difficulty BETWEEN 0 AND 1),
  score INT NOT NULL DEFAULT 0 CHECK (score >= 0),
  xp_earned INT NOT NULL DEFAULT 0 CHECK (xp_earned >= 0),
  started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at TIMESTAMPTZ,
  status TEXT NOT NULL DEFAULT 'in_progress'
    CHECK (status IN ('in_progress', 'completed', 'abandoned'))
);

CREATE TABLE quiz_session_questions (
  quiz_session_id UUID NOT NULL REFERENCES quiz_sessions(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES questions(id),
  sequence_number INT NOT NULL CHECK (sequence_number > 0),
  PRIMARY KEY (quiz_session_id, sequence_number),
  UNIQUE (quiz_session_id, question_id)
);

CREATE TABLE quiz_answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  quiz_session_id UUID NOT NULL REFERENCES quiz_sessions(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES questions(id),
  sequence_number INT CHECK (sequence_number > 0),
  user_answer TEXT,
  is_correct BOOLEAN NOT NULL DEFAULT false,
  response_time_ms INT CHECK (response_time_ms >= 0),
  difficulty_at_answer NUMERIC(4,3) CHECK (difficulty_at_answer BETWEEN 0 AND 1),
  answered_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (quiz_session_id, question_id)
);

-- ---------- Real exam simulation ----------

CREATE TABLE exams (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_session TEXT NOT NULL,
  subject TEXT NOT NULL CHECK (subject IN ('A', 'B')),
  title TEXT NOT NULL,
  question_count INT NOT NULL CHECK (question_count > 0),
  time_limit_minutes INT NOT NULL CHECK (time_limit_minutes > 0),
  initial_hearts INT NOT NULL DEFAULT 5 CHECK (initial_hearts >= 0),
  published BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (exam_session, subject)
);

CREATE TABLE exam_questions (
  exam_id UUID NOT NULL REFERENCES exams(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES questions(id),
  sequence_number INT NOT NULL CHECK (sequence_number > 0),
  PRIMARY KEY (exam_id, sequence_number),
  UNIQUE (exam_id, question_id)
);

CREATE TABLE exam_sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  exam_id UUID NOT NULL REFERENCES exams(id),
  total_questions INT NOT NULL CHECK (total_questions > 0),
  correct_answers INT NOT NULL DEFAULT 0 CHECK (correct_answers >= 0),
  score_percentage NUMERIC(5,2) CHECK (score_percentage BETWEEN 0 AND 100),
  initial_hearts INT NOT NULL CHECK (initial_hearts >= 0),
  hearts_remaining INT NOT NULL CHECK (hearts_remaining >= 0),
  time_limit_minutes INT NOT NULL CHECK (time_limit_minutes > 0),
  started_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at TIMESTAMPTZ NOT NULL,
  completed_at TIMESTAMPTZ,
  status TEXT NOT NULL DEFAULT 'in_progress'
    CHECK (status IN ('in_progress', 'completed', 'expired', 'abandoned')),
  CHECK (hearts_remaining <= initial_hearts),
  CHECK (correct_answers <= total_questions)
);

CREATE TABLE exam_answers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_session_id UUID NOT NULL REFERENCES exam_sessions(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES questions(id),
  sequence_number INT NOT NULL CHECK (sequence_number > 0),
  user_answer TEXT,
  is_correct BOOLEAN NOT NULL DEFAULT false,
  response_time_ms INT CHECK (response_time_ms >= 0),
  answered_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (exam_session_id, question_id),
  UNIQUE (exam_session_id, sequence_number)
);

CREATE TABLE exam_heart_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  exam_session_id UUID NOT NULL REFERENCES exam_sessions(id) ON DELETE CASCADE,
  question_id UUID REFERENCES questions(id),
  delta INT NOT NULL CHECK (delta <> 0),
  reason TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ---------- Motivation, mastery, and weak points ----------

CREATE TABLE user_stats (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  total_xp INT NOT NULL DEFAULT 0 CHECK (total_xp >= 0),
  current_streak INT NOT NULL DEFAULT 0 CHECK (current_streak >= 0),
  longest_streak INT NOT NULL DEFAULT 0 CHECK (longest_streak >= 0),
  last_active_date DATE,
  quizzes_completed INT NOT NULL DEFAULT 0 CHECK (quizzes_completed >= 0),
  exams_completed INT NOT NULL DEFAULT 0 CHECK (exams_completed >= 0),
  total_questions_answered INT NOT NULL DEFAULT 0 CHECK (total_questions_answered >= 0),
  total_correct INT NOT NULL DEFAULT 0 CHECK (total_correct >= 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK (current_streak <= longest_streak OR longest_streak = 0),
  CHECK (total_correct <= total_questions_answered)
);

CREATE TABLE xp_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  amount INT NOT NULL,
  event_type TEXT NOT NULL,
  source_id UUID,
  idempotency_key TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (user_id, idempotency_key)
);

CREATE TABLE user_daily_activity (
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  activity_date DATE NOT NULL,
  questions_answered INT NOT NULL DEFAULT 0 CHECK (questions_answered >= 0),
  xp_earned INT NOT NULL DEFAULT 0 CHECK (xp_earned >= 0),
  PRIMARY KEY (user_id, activity_date)
);

CREATE TABLE user_subtopic_mastery (
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  subtopic_id UUID NOT NULL REFERENCES subtopics(id) ON DELETE CASCADE,
  mastery_score NUMERIC(5,4) NOT NULL DEFAULT 0 CHECK (mastery_score BETWEEN 0 AND 1),
  ability_score NUMERIC(6,3) NOT NULL DEFAULT 0,
  questions_seen INT NOT NULL DEFAULT 0 CHECK (questions_seen >= 0),
  questions_correct INT NOT NULL DEFAULT 0 CHECK (questions_correct >= 0),
  last_practiced_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (user_id, subtopic_id),
  CHECK (questions_correct <= questions_seen)
);

-- ---------- Mistake Garden ----------

CREATE TABLE mistakes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
  source TEXT NOT NULL CHECK (source IN ('quiz', 'exam', 'flashcard', 'review')),
  source_session_id UUID,
  last_user_answer TEXT,
  mistake_count INT NOT NULL DEFAULT 1 CHECK (mistake_count > 0),
  review_count INT NOT NULL DEFAULT 0 CHECK (review_count >= 0),
  first_missed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_missed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_reviewed_at TIMESTAMPTZ,
  next_review_at TIMESTAMPTZ,
  resolved_at TIMESTAMPTZ,
  UNIQUE (user_id, question_id)
);

CREATE TABLE mistake_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  mistake_id UUID NOT NULL REFERENCES mistakes(id) ON DELETE CASCADE,
  user_answer TEXT,
  is_correct BOOLEAN NOT NULL,
  confidence INT CHECK (confidence BETWEEN 1 AND 5),
  reviewed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ---------- Flashcards and spaced repetition ----------

CREATE TABLE flashcards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  subtopic_id UUID NOT NULL REFERENCES subtopics(id) ON DELETE CASCADE,
  source_question_id UUID REFERENCES questions(id) ON DELETE SET NULL,
  front_blocks JSONB NOT NULL,
  back_blocks JSONB NOT NULL,
  published BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE user_flashcard_state (
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  flashcard_id UUID NOT NULL REFERENCES flashcards(id) ON DELETE CASCADE,
  due_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  interval_days NUMERIC(8,2) NOT NULL DEFAULT 0 CHECK (interval_days >= 0),
  ease_factor NUMERIC(4,2) NOT NULL DEFAULT 2.50 CHECK (ease_factor > 0),
  repetitions INT NOT NULL DEFAULT 0 CHECK (repetitions >= 0),
  last_rating INT CHECK (last_rating BETWEEN 1 AND 4),
  last_reviewed_at TIMESTAMPTZ,
  PRIMARY KEY (user_id, flashcard_id)
);

CREATE TABLE flashcard_reviews (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  flashcard_id UUID NOT NULL REFERENCES flashcards(id) ON DELETE CASCADE,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 4),
  previous_interval_days NUMERIC(8,2),
  next_interval_days NUMERIC(8,2),
  reviewed_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ---------- Indexes ----------

CREATE INDEX idx_subtopics_topic ON subtopics(topic_id, display_order);
CREATE INDEX idx_lessons_subtopic ON lessons(subtopic_id, display_order);
CREATE INDEX idx_questions_exam ON questions(exam_session, subject, question_number);
CREATE INDEX idx_questions_subtopic ON questions(subtopic_id);
CREATE INDEX idx_questions_difficulty ON questions(difficulty_score);
CREATE INDEX idx_question_subtopics_subtopic ON question_subtopics(subtopic_id);
CREATE INDEX idx_quiz_sessions_user ON quiz_sessions(user_id, started_at DESC);
CREATE INDEX idx_quiz_answers_session ON quiz_answers(quiz_session_id);
CREATE INDEX idx_exam_sessions_user ON exam_sessions(user_id, started_at DESC);
CREATE INDEX idx_exam_answers_session ON exam_answers(exam_session_id);
CREATE INDEX idx_xp_events_user ON xp_events(user_id, created_at DESC);
CREATE INDEX idx_daily_activity_user ON user_daily_activity(user_id, activity_date DESC);
CREATE INDEX idx_mastery_weak_points ON user_subtopic_mastery(user_id, mastery_score);
CREATE INDEX idx_mistakes_review_queue ON mistakes(user_id, resolved_at, next_review_at);
CREATE INDEX idx_flashcards_subtopic ON flashcards(subtopic_id);
CREATE INDEX idx_flashcard_due ON user_flashcard_state(user_id, due_at);

-- ---------- Updated-at triggers ----------

CREATE TRIGGER profiles_updated_at BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER topics_updated_at BEFORE UPDATE ON topics
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER subtopics_updated_at BEFORE UPDATE ON subtopics
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER lessons_updated_at BEFORE UPDATE ON lessons
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER lesson_progress_updated_at BEFORE UPDATE ON user_lesson_progress
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER questions_updated_at BEFORE UPDATE ON questions
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER exams_updated_at BEFORE UPDATE ON exams
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER user_stats_updated_at BEFORE UPDATE ON user_stats
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER mastery_updated_at BEFORE UPDATE ON user_subtopic_mastery
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER flashcards_updated_at BEFORE UPDATE ON flashcards
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ---------- Row-level security ----------

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE topics ENABLE ROW LEVEL SECURITY;
ALTER TABLE subtopics ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE lesson_prerequisites ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_lesson_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE question_subtopics ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_session_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE exams ENABLE ROW LEVEL SECURITY;
ALTER TABLE exam_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE exam_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE exam_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE exam_heart_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE xp_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_daily_activity ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_subtopic_mastery ENABLE ROW LEVEL SECURITY;
ALTER TABLE mistakes ENABLE ROW LEVEL SECURITY;
ALTER TABLE mistake_reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE flashcards ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_flashcard_state ENABLE ROW LEVEL SECURITY;
ALTER TABLE flashcard_reviews ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public topics" ON topics FOR SELECT USING (published);
CREATE POLICY "Public subtopics" ON subtopics FOR SELECT USING (published);
CREATE POLICY "Public lessons" ON lessons FOR SELECT USING (published);
CREATE POLICY "Public lesson prerequisites" ON lesson_prerequisites FOR SELECT USING (true);
CREATE POLICY "Public questions" ON questions FOR SELECT USING (published);
CREATE POLICY "Public question classifications" ON question_subtopics FOR SELECT USING (true);
CREATE POLICY "Public exams" ON exams FOR SELECT USING (published);
CREATE POLICY "Public exam questions" ON exam_questions FOR SELECT USING (true);
CREATE POLICY "Public flashcards" ON flashcards FOR SELECT USING (published);

CREATE POLICY "Own profile" ON profiles FOR ALL
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Own lesson progress" ON user_lesson_progress FOR ALL
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Own quiz sessions" ON quiz_sessions FOR ALL
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Own quiz question list" ON quiz_session_questions FOR ALL
  USING (EXISTS (SELECT 1 FROM quiz_sessions s WHERE s.id = quiz_session_id AND s.user_id = auth.uid()))
  WITH CHECK (EXISTS (SELECT 1 FROM quiz_sessions s WHERE s.id = quiz_session_id AND s.user_id = auth.uid()));
CREATE POLICY "Own quiz answers" ON quiz_answers FOR ALL
  USING (EXISTS (SELECT 1 FROM quiz_sessions s WHERE s.id = quiz_session_id AND s.user_id = auth.uid()))
  WITH CHECK (EXISTS (SELECT 1 FROM quiz_sessions s WHERE s.id = quiz_session_id AND s.user_id = auth.uid()));
CREATE POLICY "Own exam sessions" ON exam_sessions FOR ALL
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Own exam answers" ON exam_answers FOR ALL
  USING (EXISTS (SELECT 1 FROM exam_sessions s WHERE s.id = exam_session_id AND s.user_id = auth.uid()))
  WITH CHECK (EXISTS (SELECT 1 FROM exam_sessions s WHERE s.id = exam_session_id AND s.user_id = auth.uid()));
CREATE POLICY "Own heart events" ON exam_heart_events FOR SELECT
  USING (EXISTS (SELECT 1 FROM exam_sessions s WHERE s.id = exam_session_id AND s.user_id = auth.uid()));
CREATE POLICY "Own stats" ON user_stats FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Own XP events" ON xp_events FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Own daily activity" ON user_daily_activity FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Own mastery" ON user_subtopic_mastery FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Own mistakes" ON mistakes FOR ALL
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Own mistake reviews" ON mistake_reviews FOR ALL
  USING (EXISTS (SELECT 1 FROM mistakes m WHERE m.id = mistake_id AND m.user_id = auth.uid()))
  WITH CHECK (EXISTS (SELECT 1 FROM mistakes m WHERE m.id = mistake_id AND m.user_id = auth.uid()));
CREATE POLICY "Own flashcard state" ON user_flashcard_state FOR ALL
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Own flashcard reviews" ON flashcard_reviews FOR ALL
  USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- ---------- Storage ----------

INSERT INTO storage.buckets (id, name, public) VALUES
  ('question-images', 'question-images', true),
  ('exam-reference-docs', 'exam-reference-docs', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Public question images" ON storage.objects FOR SELECT
  USING (bucket_id = 'question-images');
CREATE POLICY "Public exam reference documents" ON storage.objects FOR SELECT
  USING (bucket_id = 'exam-reference-docs');
CREATE POLICY "Service role manages question images" ON storage.objects FOR ALL
  USING (bucket_id = 'question-images' AND auth.role() = 'service_role')
  WITH CHECK (bucket_id = 'question-images' AND auth.role() = 'service_role');
CREATE POLICY "Service role manages reference documents" ON storage.objects FOR ALL
  USING (bucket_id = 'exam-reference-docs' AND auth.role() = 'service_role')
  WITH CHECK (bucket_id = 'exam-reference-docs' AND auth.role() = 'service_role');

-- ---------- Initial curriculum ----------

INSERT INTO topics (name, slug, description, display_order) VALUES
  ('Technology', 'technology', 'IT infrastructure, databases, networks, and programming', 1),
  ('Security', 'security', 'Information security, cryptography, and network security', 2),
  ('Management', 'management', 'Project management, quality assurance, and development processes', 3),
  ('Strategy', 'strategy', 'Business strategy, intellectual property, and IT governance', 4),
  ('Business', 'business', 'Business operations, finance, and procurement', 5);

INSERT INTO subtopics (topic_id, name, slug, display_order) VALUES
  ((SELECT id FROM topics WHERE slug = 'technology'), 'Computer Architecture', 'computer-architecture', 1),
  ((SELECT id FROM topics WHERE slug = 'technology'), 'Data Structures', 'data-structures', 2),
  ((SELECT id FROM topics WHERE slug = 'technology'), 'Algorithms', 'algorithms', 3),
  ((SELECT id FROM topics WHERE slug = 'technology'), 'Databases', 'databases', 4),
  ((SELECT id FROM topics WHERE slug = 'technology'), 'Networking', 'networking', 5),
  ((SELECT id FROM topics WHERE slug = 'technology'), 'Operating Systems', 'operating-systems', 6),
  ((SELECT id FROM topics WHERE slug = 'technology'), 'Software Development', 'software-development', 7),
  ((SELECT id FROM topics WHERE slug = 'security'), 'Cryptography', 'cryptography', 1),
  ((SELECT id FROM topics WHERE slug = 'security'), 'Network Security', 'network-security', 2),
  ((SELECT id FROM topics WHERE slug = 'security'), 'Access Control', 'access-control', 3),
  ((SELECT id FROM topics WHERE slug = 'security'), 'Security Threats', 'security-threats', 4),
  ((SELECT id FROM topics WHERE slug = 'management'), 'Project Management', 'project-management', 1),
  ((SELECT id FROM topics WHERE slug = 'management'), 'Quality Assurance', 'quality-assurance', 2),
  ((SELECT id FROM topics WHERE slug = 'management'), 'Development Processes', 'development-processes', 3),
  ((SELECT id FROM topics WHERE slug = 'strategy'), 'Intellectual Property', 'intellectual-property', 1),
  ((SELECT id FROM topics WHERE slug = 'strategy'), 'IT Governance', 'it-governance', 2),
  ((SELECT id FROM topics WHERE slug = 'strategy'), 'Business Strategy', 'business-strategy', 3),
  ((SELECT id FROM topics WHERE slug = 'business'), 'Finance', 'finance', 1),
  ((SELECT id FROM topics WHERE slug = 'business'), 'Procurement', 'procurement', 2),
  ((SELECT id FROM topics WHERE slug = 'business'), 'Business Operations', 'business-operations', 3);
