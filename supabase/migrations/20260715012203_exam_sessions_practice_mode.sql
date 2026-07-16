ALTER TABLE public.exam_sessions ALTER COLUMN exam_id DROP NOT NULL;
CREATE POLICY "Insert own heart events"
  ON public.exam_heart_events
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.exam_sessions es
      WHERE es.id = exam_session_id AND es.user_id = auth.uid()
    )
  );
