-- Function to assign difficulty based on question metadata
-- Rules:
-- - Questions with explanation = easier (students can learn from it)
-- - Questions with images = harder (need to interpret visual data)
-- - Question number position affects difficulty (later questions often harder)

CREATE OR REPLACE FUNCTION public.assign_question_difficulty()
RETURNS TRIGGER AS $$
DECLARE
  score NUMERIC(4,3) := 0.500;
  q_num INT;
  has_explanation BOOLEAN;
  has_images BOOLEAN;
BEGIN
  -- Get question number
  q_num := NEW.question_number;
  
  -- Check if has explanation
  has_explanation := NEW.explanation IS NOT NULL AND LENGTH(NEW.explanation) > 10;
  
  -- Check if has images
  has_images := NEW.images IS NOT NULL AND NEW.images != '[]' AND NEW.images != 'null';
  
  -- Base score from question number (1-60 range)
  -- Later questions tend to be harder
  score := 0.3 + (q_num::NUMERIC / 60.0) * 0.4;
  
  -- Adjust for explanation (easier if has explanation)
  IF has_explanation THEN
    score := score - 0.1;
  END IF;
  
  -- Adjust for images (harder if has images)
  IF has_images THEN
    score := score + 0.15;
  END IF;
  
  -- Clamp between 0 and 1
  score := GREATEST(0, LEAST(1, score));
  
  -- Assign difficulty label based on score
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

-- Trigger to auto-assign difficulty on insert/update
CREATE OR REPLACE TRIGGER set_question_difficulty
  BEFORE INSERT OR UPDATE ON public.questions
  FOR EACH ROW
  EXECUTE FUNCTION public.assign_question_difficulty();

-- Update existing questions with difficulty
UPDATE public.questions SET question_number = question_number;
