-- Security fix: drop the public.users view that exposed auth.users data
-- without RLS. The view leaked email addresses and raw_user_meta_data
-- (OAuth tokens, full names, avatars) to any anonymous request.
-- All application code uses user_profiles (RLS-protected) instead.
DROP VIEW IF EXISTS public.users;

-- Fix: drop the original restrictive trigger that blocks ALL updates to
-- total_xp/streak_count unconditionally. The newer restrict_profile_columns
-- trigger (from 20260716013000) already allows postgres/service_role to
-- modify these columns. Having both triggers causes 500 errors on any
-- Hibernate UPDATE to user_profiles because Hibernate includes all mapped
-- columns in the SET clause.
DROP TRIGGER IF EXISTS restrict_user_profiles_gamification_columns ON public.user_profiles;
