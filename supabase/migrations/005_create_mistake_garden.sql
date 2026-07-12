-- 005_create_mistake_garden.sql

-- Table to track wrong answers
CREATE TABLE public.user_mistakes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  option_id UUID NOT NULL REFERENCES public.options(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT now(),
  reviewed BOOLEAN DEFAULT false
);

-- Index for faster lookups per user
CREATE INDEX idx_user_mistakes_user_id ON public.user_mistakes(user_id);

-- Row Level Security
ALTER TABLE public.user_mistakes ENABLE ROW LEVEL SECURITY;

-- Users can only see and manage their own mistakes
CREATE POLICY "Users can view own mistakes"
  ON public.user_mistakes
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own mistakes"
  ON public.user_mistakes
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own mistakes"
  ON public.user_mistakes
  FOR UPDATE
  USING (auth.uid() = user_id);
