-- Hibernate's ddl-auto: update may create FK constraints referencing a public "users" table.
-- This view maps public.users to auth.users so those FK constraints resolve correctly.
CREATE OR REPLACE VIEW public.users AS
  SELECT id, email, created_at, raw_user_meta_data
  FROM auth.users;
