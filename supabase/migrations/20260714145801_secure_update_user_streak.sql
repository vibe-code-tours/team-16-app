-- Prevent users from directly modifying gamification columns (total_xp, streak_count).
-- These should only be updated via SECURITY DEFINER functions (e.g., increment_user_xp).
CREATE OR REPLACE FUNCTION restrict_profile_columns()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.total_xp IS DISTINCT FROM OLD.total_xp THEN
    RAISE EXCEPTION 'total_xp cannot be modified directly';
  END IF;
  IF NEW.streak_count IS DISTINCT FROM OLD.streak_count THEN
    RAISE EXCEPTION 'streak_count cannot be modified directly';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER restrict_user_profiles_gamification_columns
  BEFORE UPDATE ON public.user_profiles
  FOR EACH ROW
  EXECUTE FUNCTION restrict_profile_columns();
