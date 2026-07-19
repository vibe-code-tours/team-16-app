-- Migration: Drop duplicate mistakes table
-- Issue #101: [CRITICAL] Duplicate mistake-tracking tables with divergent schemas
--
-- The initial schema (001) created a `mistakes` table and `mistake_reviews` table,
-- while migration 005 created a `user_mistakes` table. Both serve the same purpose
-- but have different schemas. The backend only uses `user_mistakes`, so we drop the
-- unused `mistakes` and `mistake_reviews` tables.

-- Drop RLS policies first
DROP POLICY IF EXISTS "Own mistake reviews" ON mistake_reviews;
DROP POLICY IF EXISTS "Own mistakes" ON mistakes;

-- Drop dependent tables first (mistake_reviews references mistakes)
DROP TABLE IF EXISTS mistake_reviews;

-- Drop the table
DROP TABLE IF EXISTS mistakes;

-- Drop the index that referenced the old mistakes table
DROP INDEX IF EXISTS idx_mistakes_review_queue;
