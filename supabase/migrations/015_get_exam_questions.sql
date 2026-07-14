-- Return a random set of usable Subject-A questions for the exam simulation.
-- Filters out questions with empty choices or a non-single-letter correct_answer
-- (those are complex ITPEC B-style questions with sub-parts).

CREATE OR REPLACE FUNCTION public.get_exam_questions(
  question_count INTEGER DEFAULT 60,
  difficulty_filter TEXT DEFAULT NULL
)
RETURNS SETOF public.questions AS $$
  SELECT *
  FROM public.questions
  WHERE subject = 'A'
    AND published = true
    AND jsonb_array_length(choices) > 0
    AND correct_answer ~ '^[a-z]$'
    AND (difficulty_filter IS NULL OR difficulty = difficulty_filter)
  ORDER BY random()
  LIMIT question_count;
$$ LANGUAGE sql STABLE;

GRANT EXECUTE ON FUNCTION public.get_exam_questions(INTEGER, TEXT) TO anon, authenticated;
