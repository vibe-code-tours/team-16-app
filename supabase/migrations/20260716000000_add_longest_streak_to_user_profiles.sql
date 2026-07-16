-- Add longest_streak column to user_profiles to track user's longest streak
ALTER TABLE user_profiles ADD COLUMN longest_streak INT NOT NULL DEFAULT 0 CHECK (longest_streak >= 0);

-- Add check constraint to ensure longest_streak >= current streak
ALTER TABLE user_profiles ADD CONSTRAINT check_streak_order
  CHECK (streak_count <= longest_streak OR longest_streak = 0);
