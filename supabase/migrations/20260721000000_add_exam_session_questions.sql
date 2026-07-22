-- Track which questions were issued in each exam session
-- Prevents submission of answers for questions not in the session

CREATE TABLE public.exam_session_questions (
    exam_session_id UUID NOT NULL REFERENCES exam_sessions(id) ON DELETE CASCADE,
    question_id UUID NOT NULL REFERENCES questions(id) ON DELETE CASCADE,
    sequence_number INTEGER NOT NULL,
    PRIMARY KEY (exam_session_id, question_id),
    UNIQUE (exam_session_id, sequence_number)
);

ALTER TABLE public.exam_session_questions ENABLE ROW LEVEL SECURITY;
