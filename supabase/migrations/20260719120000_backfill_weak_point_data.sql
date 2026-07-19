-- Backfill mastery for historical quiz answers. This covers sessions completed
-- before the API started updating user_subtopic_mastery for every answer.
INSERT INTO user_subtopic_mastery (
  user_id,
  subtopic_id,
  questions_seen,
  questions_correct,
  mastery_score,
  last_practiced_at,
  updated_at
)
SELECT
  qs.user_id,
  q.subtopic_id,
  COUNT(*) AS questions_seen,
  COUNT(*) FILTER (WHERE qa.is_correct) AS questions_correct,
  ROUND(COUNT(*) FILTER (WHERE qa.is_correct)::numeric / NULLIF(COUNT(*), 0)::numeric, 4) AS mastery_score,
  MAX(qa.answered_at) AS last_practiced_at,
  NOW() AS updated_at
FROM quiz_answers qa
JOIN questions q ON q.id = qa.question_id
JOIN quiz_sessions qs ON qs.id = qa.quiz_session_id
WHERE q.subtopic_id IS NOT NULL
GROUP BY qs.user_id, q.subtopic_id
ON CONFLICT (user_id, subtopic_id) DO UPDATE SET
  questions_seen = EXCLUDED.questions_seen,
  questions_correct = EXCLUDED.questions_correct,
  mastery_score = EXCLUDED.mastery_score,
  last_practiced_at = EXCLUDED.last_practiced_at,
  updated_at = NOW();

-- The lightweight learning-map quiz historically stored only wrong answers in
-- user_mistakes. Seed missing mastery rows from those records without altering
-- users who already have richer answer history for the same subtopic.
INSERT INTO user_subtopic_mastery (
  user_id,
  subtopic_id,
  questions_seen,
  questions_correct,
  mastery_score,
  last_practiced_at,
  updated_at
)
SELECT
  um.user_id,
  q.subtopic_id,
  COUNT(*) AS questions_seen,
  0 AS questions_correct,
  0 AS mastery_score,
  MAX(um.created_at) AS last_practiced_at,
  NOW() AS updated_at
FROM user_mistakes um
JOIN questions q ON q.id = um.question_id
WHERE q.subtopic_id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM user_subtopic_mastery existing
    WHERE existing.user_id = um.user_id
      AND existing.subtopic_id = q.subtopic_id
  )
GROUP BY um.user_id, q.subtopic_id
ON CONFLICT (user_id, subtopic_id) DO NOTHING;
