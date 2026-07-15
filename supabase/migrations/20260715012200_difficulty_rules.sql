-- Assign easy/medium/hard difficulty based on question metadata.
-- Rules:
--  - Later question numbers score harder (base curve).
--  - Explanation present → easier (learnable).
--  - Images present → harder (needs visual interpretation).

CREATE OR REPLACE FUNCTION public.assign_question_difficulty()
RETURNS TRIGGER AS $$
DECLARE
  score NUMERIC(4,3) := 0.500;
  q_num INT;
  has_explanation BOOLEAN;
  has_images BOOLEAN;
BEGIN
  q_num := NEW.question_number;
  has_explanation := NEW.explanation IS NOT NULL AND LENGTH(NEW.explanation) > 10;
  has_images := NEW.images IS NOT NULL AND NEW.images::text <> '[]' AND NEW.images::text <> 'null';

  score := 0.3 + (q_num::NUMERIC / 60.0) * 0.4;

  IF has_explanation THEN
    score := score - 0.1;
  END IF;

  IF has_images THEN
    score := score + 0.15;
  END IF;

  score := GREATEST(0, LEAST(1, score));

  NEW.difficulty_score := score;

  IF score < 0.33 THEN
    NEW.difficulty := 'easy';
  ELSIF score < 0.66 THEN
    NEW.difficulty := 'medium';
  ELSE
    NEW.difficulty := 'hard';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER set_question_difficulty
  BEFORE INSERT OR UPDATE ON public.questions
  FOR EACH ROW
  EXECUTE FUNCTION public.assign_question_difficulty();

-- Backfill difficulty on existing rows by firing the trigger.
UPDATE public.questions SET question_number = question_number;
