-- Atomic XP increment for the calling user.
-- Uses auth.uid() so a caller can only add XP to their own profile.

CREATE OR REPLACE FUNCTION public.increment_user_xp(delta INTEGER)
RETURNS INTEGER AS $$
DECLARE
  new_total INTEGER;
  caller UUID;
BEGIN
  caller := auth.uid();
  IF caller IS NULL THEN
    RAISE EXCEPTION 'not authenticated';
  END IF;
  IF delta < 0 THEN
    RAISE EXCEPTION 'delta must be non-negative';
  END IF;

  UPDATE public.user_profiles
  SET total_xp = COALESCE(total_xp, 0) + delta
  WHERE id = caller
  RETURNING total_xp INTO new_total;

  RETURN new_total;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION public.increment_user_xp(INTEGER) TO authenticated;
