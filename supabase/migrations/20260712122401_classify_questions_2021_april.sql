-- Classify 2021-April exam questions into subtopics
-- Idempotent: only updates questions where subtopic_id IS NULL, matched by (subject, question_number).
-- Subtopics are looked up by slug so the migration is portable across environments.

WITH subtopic_ids AS (
  SELECT slug, id FROM public.subtopics
),
classifications(subject, question_numbers, subtopic_slug) AS (
  VALUES
    -- Technology
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
    -- Security
    ('A', ARRAY[38],                               'cryptography'),
    ('A', ARRAY[41,42,43,44],                      'network-security'),
    ('A', ARRAY[37,39],                            'access-control'),
    ('A', ARRAY[34,35,36,40],                      'security-threats'),
    ('B', ARRAY[1],                                'security-threats'),
    -- Management
    ('A', ARRAY[51,52,53,54],                      'project-management'),
    ('A', ARRAY[49,56,59],                         'quality-assurance'),
    ('A', ARRAY[55,57,58],                         'development-processes'),
    -- Strategy
    ('A', ARRAY[50],                               'intellectual-property'),
    ('A', ARRAY[60],                               'it-governance')
)
UPDATE public.questions AS q
SET subtopic_id = s.id
FROM classifications c
JOIN subtopic_ids s ON s.slug = c.subtopic_slug
WHERE q.exam_session = '2021-april'
  AND q.published = TRUE
  AND q.subtopic_id IS NULL
  AND q.subject = c.subject
  AND q.question_number = ANY(c.question_numbers);

-- Subject A Q1 ("marking your answer on the answer sheet") is exam directions,
-- not educational content — intentionally left unclassified (subtopic_id NULL).
