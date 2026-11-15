-- Spaced review for the Mistake Garden (issue #315).
--
-- A mistake is no longer seen once and forgotten: each one carries a review
-- schedule. A correct review moves the interval up the ladder 1 -> 3 -> 7 -> 14
-- days (capped at 14); a wrong answer resets it to 1 day. The schedule itself is
-- computed in MistakeService; the database only stores it.
--
-- Existing RLS policies on user_mistakes are unchanged.

ALTER TABLE public.user_mistakes
    ADD COLUMN review_count INT NOT NULL DEFAULT 0,
    ADD COLUMN interval_days INT NOT NULL DEFAULT 1,
    ADD COLUMN next_review_at TIMESTAMPTZ DEFAULT (now() + INTERVAL '1 day');

ALTER TABLE public.user_mistakes
    ADD CONSTRAINT chk_user_mistakes_review_count_non_negative CHECK (review_count >= 0),
    ADD CONSTRAINT chk_user_mistakes_interval_days_positive CHECK (interval_days > 0);

-- Backfill: existing mistakes become due one day after they were last missed,
-- so anything older than a day shows up in "Due today" straight away.
UPDATE public.user_mistakes
SET next_review_at = COALESCE(created_at, now()) + INTERVAL '1 day';

-- Serves GET /api/v1/me/mistakes/due (user_id = ? AND next_review_at <= now()).
CREATE INDEX idx_user_mistakes_user_next_review
    ON public.user_mistakes (user_id, next_review_at);
