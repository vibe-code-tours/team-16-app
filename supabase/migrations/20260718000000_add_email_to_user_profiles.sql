-- Add email column to user_profiles (missing from original schema)
-- JPA entity requires it but no prior migration added it, causing
-- INSERT/UPDATE failures that cascade into 403 responses.

ALTER TABLE public.user_profiles
  ADD COLUMN IF NOT EXISTS email TEXT NOT NULL DEFAULT '';
