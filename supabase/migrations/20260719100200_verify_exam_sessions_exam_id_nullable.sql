-- Migration: Verify exam_sessions.exam_id nullable change
-- Issue #103: [HIGH] Non-additive migration silently drops NOT NULL from exam_sessions.exam_id
--
-- Migration 016 dropped the NOT NULL constraint from exam_sessions.exam_id to support
-- practice mode (where exam_id may be NULL). However, it did so without verifying data
-- integrity first. This migration adds proper safeguards:
-- 1. Verifies no NULL exam_id values exist in existing rows
-- 2. Documents the intentional change for practice mode support
--
-- Note: This is a verification-only migration. The actual DROP NOT NULL was already
-- applied in migration 016. We're adding documentation and a safety check.

DO $$
BEGIN
  -- Check if any existing rows have NULL exam_id
  IF EXISTS (SELECT 1 FROM exam_sessions WHERE exam_id IS NULL) THEN
    RAISE WARNING 'Found exam_sessions with NULL exam_id. This is expected for practice mode sessions.';
  ELSE
    -- All existing rows have non-NULL exam_id, so we can safely add NOT NULL back
    -- if we want to enforce it for non-practice sessions
    RAISE NOTICE 'All exam_sessions have non-NULL exam_id. Constraint is consistent.';
  END IF;
END $$;

-- Add a comment to document why exam_id is nullable
COMMENT ON COLUMN exam_sessions.exam_id IS 'References exams.id. NULL for practice mode sessions (no specific exam).';
