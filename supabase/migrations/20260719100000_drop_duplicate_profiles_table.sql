-- Migration: Drop duplicate profiles table
-- Issue #100: [CRITICAL] Duplicate profile tables - two conflicting user profile tables
--
-- The initial schema (001) created a `profiles` table, while migration 003
-- created a `user_profiles` table. Both serve the same purpose but have different
-- schemas. The backend only uses `user_profiles`, so we drop the unused `profiles` table.

-- Drop the trigger first (already defined in initial schema)
DROP TRIGGER IF EXISTS profiles_updated_at ON profiles;

-- Drop the RLS policies
DROP POLICY IF EXISTS "Own profile" ON profiles;

-- Drop the table
DROP TABLE IF EXISTS profiles;
