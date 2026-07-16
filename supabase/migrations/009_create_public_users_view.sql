CREATE OR REPLACE VIEW public.users AS
  SELECT id, email, created_at, raw_user_meta_data
  FROM auth.users;
