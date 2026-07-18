-- Seed admin user for NerdQuiz
-- Run after founder user is created in Supabase Auth
--
-- Usage:
--   supabase db query --file supabase/scripts/seed_admin.sql -v founder_uuid='your-uuid-here'
--
-- Or with psql:
--   psql $DATABASE_URL -v founder_uuid='your-uuid-here' -f supabase/scripts/seed_admin.sql

INSERT INTO public.user_profiles (id, role, is_active)
VALUES (:'founder_uuid', 'admin', true)
ON CONFLICT (id) DO UPDATE SET role = 'admin', is_active = true;
