SELECT subject, count(*) AS question_count
FROM questions
WHERE exam_session = '2021-april'
GROUP BY subject
ORDER BY subject;

SELECT
  exam_session,
  subject,
  title,
  question_count,
  time_limit_minutes,
  published
FROM exams
WHERE exam_session = '2021-april'
ORDER BY subject;

SELECT
  e.subject,
  count(eq.question_id) AS mapped_questions
FROM exams e
JOIN exam_questions eq ON eq.exam_id = e.id
WHERE e.exam_session = '2021-april'
GROUP BY e.subject
ORDER BY e.subject;

SELECT question_number, images
FROM questions
WHERE exam_session = '2021-april'
  AND subject = 'A'
  AND question_number = 8;

SELECT ref_doc
FROM questions
WHERE exam_session = '2021-april'
  AND subject = 'A'
  AND question_number = 1;

-- SQL Editor: run initial schema
-- → Storage: upload question images
-- → Storage: upload original PDFs
-- → SQL Editor: run 2021 April seed
-- → SQL Editor: verify counts and mappings