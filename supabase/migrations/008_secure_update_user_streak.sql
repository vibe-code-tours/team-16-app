-- Streak updates now go through the Spring API, which derives the user id from
-- the verified Supabase JWT. Remove the public RPC surface and keep profile
-- table access scoped to each authenticated user.

DROP FUNCTION IF EXISTS public.update_user_streak(UUID);
DROP FUNCTION IF EXISTS public.update_user_streak();

ALTER TABLE public.user_profiles
  ADD COLUMN IF NOT EXISTS email TEXT;

DROP POLICY IF EXISTS "Users can update own profile" ON public.user_profiles;

CREATE POLICY "Users can update own profile"
  ON public.user_profiles
  FOR UPDATE
  TO authenticated
  USING ((SELECT auth.uid()) = id)
  WITH CHECK ((SELECT auth.uid()) = id);

NOTIFY pgrst, 'reload schema';
