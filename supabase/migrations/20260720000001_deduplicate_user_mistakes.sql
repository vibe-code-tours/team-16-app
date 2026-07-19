-- Prevent duplicate mistake records for the same user + question.
-- Before inserting, the service will upsert: update selected_label and created_at
-- if the user already got this question wrong.

-- Remove existing duplicates, keeping only the most recent record per user+question.
DELETE FROM public.user_mistakes um
USING (
    SELECT DISTINCT ON (user_id, question_id) id
    FROM public.user_mistakes
    ORDER BY user_id, question_id, created_at DESC
) kept
WHERE um.id != kept.id;

-- Add the unique constraint.
ALTER TABLE public.user_mistakes
    ADD CONSTRAINT uq_user_mistakes_user_question UNIQUE (user_id, question_id);
