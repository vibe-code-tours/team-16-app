CREATE TABLE public.user_mistakes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  question_id UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
  selected_label TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  reviewed BOOLEAN DEFAULT false
);
CREATE INDEX idx_user_mistakes_user_id ON public.user_mistakes(user_id);
ALTER TABLE public.user_mistakes ENABLE ROW LEVEL SECURITY;
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
