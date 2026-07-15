-- Function to update user streak on login
-- Checks if last login was yesterday (consecutive) or earlier (reset streak)

CREATE OR REPLACE FUNCTION public.update_user_streak(user_id UUID)
RETURNS INTEGER AS $$
DECLARE
  last_login TIMESTAMPTZ;
  current_streak INTEGER;
  yesterday DATE;
  last_login_date DATE;
  new_streak INTEGER;
BEGIN
  -- Get current streak and last login
  SELECT streak_count, last_login_at 
  INTO current_streak, last_login
  FROM public.user_profiles
  WHERE id = user_id;

  -- Initialize defaults if null
  current_streak := COALESCE(current_streak, 0);
  last_login := COALESCE(last_login, now() - interval '1 year');

  yesterday := CURRENT_DATE - interval '1 day';
  last_login_date := last_login::date;

  -- Calculate new streak
  IF last_login_date = CURRENT_DATE THEN
    -- Already logged in today, keep streak
    new_streak := current_streak;
  ELSIF last_login_date = yesterday THEN
    -- Consecutive day login, increment streak
    new_streak := current_streak + 1;
  ELSE
    -- Streak broken, start new streak
    new_streak := 1;
  END IF;

  -- Update the profile
  UPDATE public.user_profiles
  SET streak_count = new_streak,
      last_login_at = now()
  WHERE id = user_id;

  RETURN new_streak;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION public.update_user_streak(UUID) TO authenticated;
