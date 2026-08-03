-- Exam answer keys must only be revealed by the API after a session is finished.
-- Keep the RPC's public question shape deliberately narrower than `questions`.
DROP FUNCTION IF EXISTS public.get_exam_questions(INTEGER, TEXT);

CREATE FUNCTION public.get_exam_questions(
  question_count INTEGER DEFAULT 60,
  difficulty_filter TEXT DEFAULT NULL
)
RETURNS TABLE (
  id UUID,
  subtopic_id UUID,
  exam_session TEXT,
  subject TEXT,
  question_number INTEGER,
  question_text TEXT,
  images JSONB,
  choices JSONB,
  difficulty TEXT
)
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = ''
AS $$
  SELECT q.id, q.subtopic_id, q.exam_session, q.subject, q.question_number,
         q.question_text, q.images, q.choices, q.difficulty
  FROM public.questions AS q
  WHERE q.subject = 'A'
    AND q.published = true
    AND jsonb_array_length(q.choices) > 0
    AND q.correct_answer ~ '^[a-z]$'
    AND (difficulty_filter IS NULL OR q.difficulty = difficulty_filter)
  ORDER BY random()
  LIMIT LEAST(GREATEST(question_count, 1), 100);
$$;

REVOKE ALL ON FUNCTION public.get_exam_questions(INTEGER, TEXT) FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.get_exam_questions(INTEGER, TEXT) TO authenticated;
