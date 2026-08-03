-- Existing deployments should enforce the same immutable-answer invariants as JPA.
CREATE UNIQUE INDEX IF NOT EXISTS uq_exam_answers_session_question
  ON public.exam_answers (exam_session_id, question_id);
CREATE UNIQUE INDEX IF NOT EXISTS uq_exam_answers_session_sequence
  ON public.exam_answers (exam_session_id, sequence_number);
