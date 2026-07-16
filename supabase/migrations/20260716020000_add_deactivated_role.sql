-- Add 'deactivated' to the allowed role values in user_profiles
-- This allows admins to deactivate accounts without deleting data

ALTER TABLE user_profiles DROP CONSTRAINT IF EXISTS user_profiles_role_check;

ALTER TABLE user_profiles ADD CONSTRAINT user_profiles_role_check
  CHECK (role IN ('admin', 'user', 'deactivated'));
