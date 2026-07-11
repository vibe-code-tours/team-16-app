-- 002_create_content_schema.sql

-- Topics Table
CREATE TABLE public.topics (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Lessons Table
CREATE TABLE public.lessons (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  topic_id UUID NOT NULL REFERENCES public.topics(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Quizzes Table
CREATE TABLE public.quizzes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  topic_id UUID NOT NULL REFERENCES public.topics(id) ON DELETE CASCADE,
  lesson_id UUID REFERENCES public.lessons(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Questions Table
CREATE TABLE public.questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  quiz_id UUID NOT NULL REFERENCES public.quizzes(id) ON DELETE CASCADE,
  text TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Options Table
CREATE TABLE public.options (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  question_id UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  text TEXT NOT NULL,
  is_correct BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Indexes for performance
CREATE INDEX idx_lessons_topic_id ON public.lessons(topic_id);
CREATE INDEX idx_quizzes_topic_id ON public.quizzes(topic_id);
CREATE INDEX idx_quizzes_lesson_id ON public.quizzes(lesson_id);
CREATE INDEX idx_questions_quiz_id ON public.questions(quiz_id);
CREATE INDEX idx_options_question_id ON public.options(question_id);

-- ============================================================
-- Row Level Security (RLS)
-- Content is publicly readable, but only admins (not implemented yet) 
-- should be able to write.
-- ============================================================

ALTER TABLE public.topics ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quizzes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.options ENABLE ROW LEVEL SECURITY;

-- Policies: Everyone can READ
CREATE POLICY "Anyone can view topics" ON public.topics FOR SELECT USING (true);
CREATE POLICY "Anyone can view lessons" ON public.lessons FOR SELECT USING (true);
CREATE POLICY "Anyone can view quizzes" ON public.quizzes FOR SELECT USING (true);
CREATE POLICY "Anyone can view questions" ON public.questions FOR SELECT USING (true);
CREATE POLICY "Anyone can view options" ON public.options FOR SELECT USING (true);

-- ============================================================
-- Updated_at triggers (reusing existing function if possible)
-- ============================================================

-- The function update_updated_at_column() was defined in 001_create_user_profiles.sql.
-- It is in the public schema.

CREATE TRIGGER set_topics_updated_at BEFORE UPDATE ON public.topics FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER set_lessons_updated_at BEFORE UPDATE ON public.lessons FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER set_quizzes_updated_at BEFORE UPDATE ON public.quizzes FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER set_questions_updated_at BEFORE UPDATE ON public.questions FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER set_options_updated_at BEFORE UPDATE ON public.options FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================================
-- Seed Data
-- ============================================================

DO $$
DECLARE
    v_topic_id UUID;
    v_lesson_id UUID;
    v_quiz_id UUID;
    v_q1_id UUID;
    v_q2_id UUID;
    v_q3_id UUID;
    v_q4_id UUID;
    v_q5_id UUID;
BEGIN
    -- 1. Create Topic
    INSERT INTO public.topics (title, description)
    VALUES ('Computer Architecture', 'Basics of how computers work.')
    RETURNING id INTO v_topic_id;

    -- 2. Create Lesson
    INSERT INTO public.lessons (topic_id, content)
    VALUES (v_topic_id, 'CPU (Central Processing Unit) is the brain of the computer. It performs arithmetic and logical operations. The RAM (Random Access Memory) is volatile memory used for short-term data storage. A Hard Drive (HDD) or SSD is non-volatile storage used for long-term data.')
    RETURNING id INTO v_lesson_id;

    -- 3. Create Quiz
    INSERT INTO public.quizzes (topic_id, lesson_id)
    VALUES (v_topic_id, v_lesson_id)
    RETURNING id INTO v_quiz_id;

    -- 4. Create Questions and Options
    -- Question 1
    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_id, 'What is the brain of the computer?') RETURNING id INTO v_q1_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q1_id, 'CPU', true), (v_q1_id, 'RAM', false), (v_q1_id, 'SSD', false);

    -- Question 2
    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_id, 'Which component is volatile memory?') RETURNING id INTO v_q2_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q2_id, 'HDD', false), (v_q2_id, 'SSD', false), (v_q2_id, 'RAM', true);

    -- Question 3
    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_id, 'What does CPU stand for?') RETURNING id INTO v_q3_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q3_id, 'Central Processing Unit', true), (v_q3_id, 'Computer Processing Unit', false), (v_q3_id, 'Control Processing Unit', false);

    -- Question 4
    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_id, 'Which of these is non-volatile storage?') RETURNING id INTO v_q4_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q4_id, 'RAM', false), (v_q4_id, 'SSD', true), (v_q4_id, 'Cache', false);

    -- Question 5
    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_id, 'The CPU performs what types of operations?') RETURNING id INTO v_q5_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q5_id, 'Only Arithmetic', false), (v_q5_id, 'Only Logical', false), (v_q5_id, 'Arithmetic and Logical', true);

END $$;
