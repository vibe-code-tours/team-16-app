-- Add admin role column to user_profiles
-- Valid values: 'admin' | 'user', default 'user'

ALTER TABLE public.user_profiles
  ADD COLUMN role TEXT NOT NULL DEFAULT 'user'
  CHECK (role IN ('admin', 'user'));

-- Admin can read all user profiles (for stats and user management)
CREATE POLICY "Admins can view all profiles"
  ON public.user_profiles
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.user_profiles up
      WHERE up.id = auth.uid() AND up.role = 'admin'
    )
  );

-- After migration, promote the first admin:
-- UPDATE public.user_profiles SET role = 'admin' WHERE id = '<your-user-id>';
