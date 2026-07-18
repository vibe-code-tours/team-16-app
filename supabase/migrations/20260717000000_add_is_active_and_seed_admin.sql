-- Add is_active column to user_profiles (AUTH-02: account deactivation support)
-- Default true: all existing users remain active

ALTER TABLE public.user_profiles
  ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT true;

-- Admin seeding moved to supabase/scripts/seed_admin.sql
-- Run after founder user is created in Supabase Auth
