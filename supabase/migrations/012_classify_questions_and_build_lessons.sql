WITH subtopic_ids AS (
  SELECT slug, id FROM public.subtopics
),
classifications(subject, question_numbers, subtopic_slug) AS (
  VALUES
    ('A', ARRAY[2,6,11,12,13,14,15,16,20,21,22,23], 'computer-architecture'),
    ('A', ARRAY[7,8],                              'data-structures'),
    ('B', ARRAY[8],                                'data-structures'),
    ('A', ARRAY[3,4,5,9],                          'algorithms'),
    ('B', ARRAY[6,7],                              'algorithms'),
    ('A', ARRAY[25,26,27,28,29],                   'databases'),
    ('B', ARRAY[3],                                'databases'),
    ('A', ARRAY[30,31,32,33],                      'networking'),
    ('B', ARRAY[4],                                'networking'),
    ('A', ARRAY[17,18],                            'operating-systems'),
    ('B', ARRAY[2],                                'operating-systems'),
    ('A', ARRAY[10,19,24,45,46,47,48],             'software-development'),
    ('B', ARRAY[5],                                'software-development'),
    ('A', ARRAY[38],                               'cryptography'),
    ('A', ARRAY[41,42,43,44],                      'network-security'),
    ('A', ARRAY[37,39],                            'access-control'),
    ('A', ARRAY[34,35,36,40],                      'security-threats'),
    ('B', ARRAY[1],                                'security-threats'),
    ('A', ARRAY[51,52,53,54],                      'project-management'),
    ('A', ARRAY[49,56,59],                         'quality-assurance'),
    ('A', ARRAY[55,57,58],                         'development-processes'),
    ('A', ARRAY[50],                               'intellectual-property'),
    ('A', ARRAY[60],                               'it-governance')
)
UPDATE public.questions AS q
SET subtopic_id = s.id
FROM classifications c
JOIN subtopic_ids s ON s.slug = c.subtopic_slug
WHERE q.exam_session = '2021-october'
  AND q.published = TRUE
  AND q.subtopic_id IS NULL
  AND q.subject = c.subject
  AND q.question_number = ANY(c.question_numbers);
WITH subtopic_ids AS (
  SELECT slug, id FROM public.subtopics
),
classifications(subject, question_numbers, subtopic_slug) AS (
  VALUES
    ('A', ARRAY[2,6,11,12,13,14,15,16,20,21,22,23], 'computer-architecture'),
    ('A', ARRAY[7,8],                              'data-structures'),
    ('B', ARRAY[8],                                'data-structures'),
    ('A', ARRAY[3,4,5,9],                          'algorithms'),
    ('B', ARRAY[6,7],                              'algorithms'),
    ('A', ARRAY[25,26,27,28,29],                   'databases'),
    ('B', ARRAY[3],                                'databases'),
    ('A', ARRAY[30,31,32,33],                      'networking'),
    ('B', ARRAY[4],                                'networking'),
    ('A', ARRAY[17,18],                            'operating-systems'),
    ('B', ARRAY[2],                                'operating-systems'),
    ('A', ARRAY[10,19,24,45,46,47,48],             'software-development'),
    ('B', ARRAY[5],                                'software-development'),
    ('A', ARRAY[38],                               'cryptography'),
    ('A', ARRAY[41,42,43,44],                      'network-security'),
    ('A', ARRAY[37,39],                            'access-control'),
    ('A', ARRAY[34,35,36,40],                      'security-threats'),
    ('B', ARRAY[1],                                'security-threats'),
    ('A', ARRAY[51,52,53,54],                      'project-management'),
    ('A', ARRAY[49,56,59],                         'quality-assurance'),
    ('A', ARRAY[55,57,58],                         'development-processes'),
    ('A', ARRAY[50],                               'intellectual-property'),
    ('A', ARRAY[60],                               'it-governance')
)
UPDATE public.questions AS q
SET subtopic_id = s.id
FROM classifications c
JOIN subtopic_ids s ON s.slug = c.subtopic_slug
WHERE q.exam_session = '2022-april'
  AND q.published = TRUE
  AND q.subtopic_id IS NULL
  AND q.subject = c.subject
  AND q.question_number = ANY(c.question_numbers);
INSERT INTO question_subtopics (question_id, subtopic_id, is_primary, confidence, classification_source)
SELECT
  q.id,
  q.subtopic_id,
  true,
  0.8,
  'rule-based'
FROM questions q
WHERE q.subtopic_id IS NOT NULL
  AND q.published = TRUE
ON CONFLICT (question_id, subtopic_id) DO NOTHING;
DO $$
DECLARE
  subtopic_rec RECORD;
  lesson_rec RECORD;
  question_rec RECORD;
  content JSONB;
  q_num INT;
  choice_rec RECORD;
  items JSONB;
BEGIN
  FOR subtopic_rec IN
    SELECT s.id, s.slug, s.name
    FROM subtopics s
    WHERE EXISTS (
      SELECT 1 FROM question_subtopics qs
      WHERE qs.subtopic_id = s.id
    )
  LOOP
    SELECT l.id INTO lesson_rec
    FROM lessons l
    WHERE l.subtopic_id = subtopic_rec.id
      AND l.content_blocks = '[]'::jsonb
    ORDER BY l.display_order
    LIMIT 1;
    IF lesson_rec IS NULL THEN
      CONTINUE;
    END IF;
    content := jsonb_build_array(
      jsonb_build_object('type', 'heading', 'content', 'Past Exam Questions'),
      jsonb_build_object('type', 'text', 'content',
        'Test your understanding with these questions from past ITPEC FE exams.')
    );
    q_num := 0;
    FOR question_rec IN
      SELECT q.question_text, q.choices, q.correct_answer
      FROM questions q
      JOIN question_subtopics qs ON qs.question_id = q.id
      WHERE qs.subtopic_id = subtopic_rec.id
        AND qs.is_primary = TRUE
      ORDER BY q.exam_session, q.question_number
      LIMIT 5
    LOOP
      q_num := q_num + 1;
      items := '[]'::jsonb;
      FOR choice_rec IN
        SELECT elem->>'label' AS label, elem->>'text' AS text
        FROM jsonb_array_elements(question_rec.choices) elem
      LOOP
        items := items || jsonb_build_array(choice_rec.label || ') ' || choice_rec.text);
      END LOOP;
      content := content || jsonb_build_array(
        jsonb_build_object('type', 'heading', 'content', 'Question ' || q_num),
        jsonb_build_object('type', 'text', 'content', question_rec.question_text),
        jsonb_build_object('type', 'list', 'items', items),
        jsonb_build_object('type', 'text', 'content',
          '**Answer:** ' || question_rec.correct_answer)
      );
    END LOOP;
    UPDATE lessons
    SET content_blocks = content
    WHERE id = lesson_rec.id;
  END LOOP;
END $$;
