-- Add is_active column to user_profiles (AUTH-02: account deactivation support)
-- Default true: all existing users remain active

ALTER TABLE public.user_profiles
  ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT true;

-- Seed the first admin user (AUTH-06: founder admin bootstrap)
-- Replace <FOUNDER_UUID> with the actual founder user ID before applying
INSERT INTO public.user_profiles (id, role, is_active)
VALUES ('<FOUNDER_UUID>', 'admin', true)
ON CONFLICT (id) DO UPDATE SET role = 'admin', is_active = true;
