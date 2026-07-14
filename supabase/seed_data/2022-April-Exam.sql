-- NerdQuiz seed: 2022 April FE Subjects A and B
-- Generated from the original ITPEC question and answer PDFs.
BEGIN;

INSERT INTO questions (
  exam_session,
  subject,
  question_number,
  question_text,
  content_blocks,
  images,
  choices,
  correct_answer,
  answer_key,
  explanation,
  difficulty,
  difficulty_score,
  source_file,
  source_citation,
  source_pages,
  extraction_method,
  extraction_version,
  source_text,
  ref_doc,
  published
) VALUES
(
  '2022-april',
  'A',
  1,
  'Q1. For logical variables A and B, which of the following is equivalent to the NOR operation on
 A and B? Here, ܣ + ܤ , ܣ ・ܤ , and ܣare OR, AND, and NOT operations on the
 corresponding variables, respectively.',
  '[{"type":"text","page":3,"bbox":[65.22,68.76,530.12,82.21],"text":"Q1. For logical variables A and B, which of the following is equivalent to the NOR operation on"},{"type":"text","page":3,"bbox":[65.22,85.16,477.49,136.64],"text":"A and B? Here, ܣ+ ܤ, ܣ・ܤ, and ܣ̅ are OR, AND, and NOT operations on the\ncorresponding variables, respectively."},{"type":"text","page":3,"bbox":[65.22,137.94,518.46,172.21],"text":"a) ܣ̅・ሺܣ+ ܤതሻ\nb) ܣ̅・ሺܣ̅ + ܤതሻ\nc)\nB ・ሺܣ+ ܤതሻ\nd) ܤത・ሺܣ̅ + ܤതሻ"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"ܣ̅・ሺܣ + ܤതሻ"},{"label":"b","text":"ܣ̅・ሺܣ+ ܤതሻ"},{"label":"c","text":"B ・ሺܣ + ܤതሻ"},{"label":"d","text":"ܤത・ሺܣ+ ܤതሻ"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q1)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q1. For logical variables A and B, which of the following is equivalent to the NOR operation on
 A and B? Here, ܣ + ܤ , ܣ ・ܤ , and ܣare OR, AND, and NOT operations on the
 corresponding variables, respectively.

 a) ܣ̅・ሺܣ + ܤതሻ b) ܣ̅・ሺܣ+ ܤതሻ c) B ・ሺܣ + ܤതሻ d) ܤത・ሺܣ+ ܤതሻ',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  2,
  'Q2. For non-negative integer A, which of the following has the same value as (A mod 32) + 64?
 Here, mod, +, AND, and OR are remainder-after-division, arithmetic addition, bitwiseAND, and bitwise-OR operators, respectively.',
  '[{"type":"text","page":3,"bbox":[65.22,175.74,527.41,207.19],"text":"Q2. For non-negative integer A, which of the following has the same value as (A mod 32) + 64?"},{"type":"text","page":3,"bbox":[85.74,211.85,502.64,243.13],"text":"Here, mod, +, AND, and OR are remainder-after-division, arithmetic addition, bitwise-\nAND, and bitwise-OR operators, respectively."},{"type":"text","page":3,"bbox":[84.12,266.93,424.53,316.21],"text":"a) (A AND 31) OR 64\nb) (A AND 32) OR 32\nc) (A OR 31) AND 64\nd) (A OR 64) AND 32"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"(A AND 31) OR 64"},{"label":"b","text":"(A AND 32) OR 32"},{"label":"c","text":"(A OR 31) AND 64"},{"label":"d","text":"(A OR 64) AND 32"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q2)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q2. For non-negative integer A, which of the following has the same value as (A mod 32) + 64?
 Here, mod, +, AND, and OR are remainder-after-division, arithmetic addition, bitwiseAND, and bitwise-OR operators, respectively.

 a) (A AND 31) OR 64 b) (A AND 32) OR 32
 c) (A OR 31) AND 64 d) (A OR 64) AND 32',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  3,
  'Q3. Which of the following is an appropriate explanation of normal distribution?',
  '[{"type":"text","page":3,"bbox":[65.22,319.74,457.19,351.19],"text":"Q3. Which of the following is an appropriate explanation of normal distribution?"},{"type":"text","page":3,"bbox":[84.12,356.93,499.08,424.21],"text":"a) A continuous, bathtub-shaped distribution that is used to express the failure rate\nb) A continuous, bell-shaped distribution that is symmetric about its mean\nc) A discrete distribution that expresses the probability of an event occurring a given"},{"type":"text","page":3,"bbox":[84.12,428.93,462.0,460.21],"text":"number of times in a fixed interval\nd) A discrete distribution where all events have the same probability to occur"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A continuous, bathtub-shaped distribution that is used to express the failure rate"},{"label":"b","text":"A continuous, bell-shaped distribution that is symmetric about its mean"},{"label":"c","text":"A discrete distribution that expresses the probability of an event occurring a given\n number of times in a fixed interval"},{"label":"d","text":"A discrete distribution where all events have the same probability to occur"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q3)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q3. Which of the following is an appropriate explanation of normal distribution?

 a) A continuous, bathtub-shaped distribution that is used to express the failure rate
 b) A continuous, bell-shaped distribution that is symmetric about its mean
 c) A discrete distribution that expresses the probability of an event occurring a given
 number of times in a fixed interval
 d) A discrete distribution where all events have the same probability to occur',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  4,
  'Q4. Which of the following is an expression in reverse Polish notation that has the same value
 as the expression below when evaluated? Here, numbers are given as decimals, and the
 symbols − and × are subtraction and multiplication operators, respectively.

 3 4 − 5 ×',
  '[{"type":"text","page":3,"bbox":[65.22,483.28,525.92,514.21],"text":"Q4.  Which of the following is an expression in reverse Polish notation that has the same value"},{"type":"text","page":3,"bbox":[65.22,518.93,507.0,567.13],"text":"as the expression below when evaluated? Here, numbers are given as decimals, and the\nsymbols − and × are subtraction and multiplication operators, respectively."},{"type":"text","page":3,"bbox":[65.22,571.31,187.8,600.61],"text":"3  4  −  5  ×"},{"type":"text","page":3,"bbox":[84.12,604.91,410.04,636.19],"text":"a) 3  4  5  ×  −\nb) 4  5  −  3  ×\nc) 5  3  4  −  ×\nd) 5  4  3  −  ×"},{"type":"code","page":3,"bbox":[65.22,794.63,311.58,807.97],"text":"– 3 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"3 4 5 × −"},{"label":"b","text":"4 5 − 3 ×"},{"label":"c","text":"5 3 4 − ×"},{"label":"d","text":"5 4 3 − ×\n\n – 3 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q4)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q4. Which of the following is an expression in reverse Polish notation that has the same value
 as the expression below when evaluated? Here, numbers are given as decimals, and the
 symbols − and × are subtraction and multiplication operators, respectively.

 3 4 − 5 ×

 a) 3 4 5 × − b) 4 5 − 3 ×
 c) 5 3 4 − × d) 5 4 3 − ×

 – 3 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  5,
  'Q5. The table below shows state transition for character string inspection. During the inspection,
 if the state changes to E, the string under inspection is rejected. Which of the following is
 rejected in this inspection? Here, state A is the initial state, strings are inspected from left to
 right, and symbol △ indicates a blank character.

 Character

 Blank Number Sign Radix point Other

 A A B C D E
 state B A B E D E

 C E B E D E Current
 D A E E E E',
  '[{"type":"text","page":4,"bbox":[65.22,68.76,532.48,82.21],"text":"Q5.  The table below shows state transition for character string inspection. During the inspection,"},{"type":"text","page":4,"bbox":[85.2,86.93,527.95,154.21],"text":"if the state changes to E, the string under inspection is rejected. Which of the following is\nrejected in this inspection? Here, state A is the initial state, strings are inspected from left to\nright, and symbol △ indicates a blank character."},{"type":"table","page":4,"bbox":[106.98,155.58,487.92,296.28],"rows":[[null,null,"Character",null,null,null,null],[null,null,"Blank","Number","Sign","Radix point","Other"],["Current state","A","A","B","C","D","E"],[null,"B","A","B","E","D","E"],[null,"C","E","B","E","D","E"],[null,"D","A","E","E","E","E"]]},{"type":"text","page":4,"bbox":[126.54,160.19,359.16,174.37],"text":"Character"},{"type":"text","page":4,"bbox":[126.54,183.65,474.24,197.83],"text":"Blank\nNumber\nSign\nRadix point\nOther"},{"type":"text","page":4,"bbox":[157.5,207.77,463.39,221.05],"text":"A\nA\nB\nC\nD\nE"},{"type":"text","page":4,"bbox":[119.51,214.74,133.57,280.26],"text":"Current state"},{"type":"text","page":4,"bbox":[157.5,231.23,463.39,244.51],"text":"B\nA\nB\nE\nD\nE"},{"type":"text","page":4,"bbox":[157.14,254.69,463.39,267.97],"text":"C\nE\nB\nE\nD\nE"},{"type":"text","page":4,"bbox":[156.84,278.09,463.39,291.37],"text":"D\nA\nE\nE\nE\nE"},{"type":"text","page":4,"bbox":[84.12,300.35,475.8,331.7],"text":"a) +0010\nb) −1\nc) 12.2\nd) 9.△"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"+0010"},{"label":"b","text":"−1"},{"label":"c","text":"12.2"},{"label":"d","text":"9.△"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q5)',
  ARRAY[4]::int[],
  'native_text',
  '3.0',
  'Q5. The table below shows state transition for character string inspection. During the inspection,
 if the state changes to E, the string under inspection is rejected. Which of the following is
 rejected in this inspection? Here, state A is the initial state, strings are inspected from left to
 right, and symbol △ indicates a blank character.

 Character

 Blank Number Sign Radix point Other

 A A B C D E
 state B A B E D E

 C E B E D E Current
 D A E E E E

 a) +0010 b) −1 c) 12.2 d) 9.△',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[4]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  6,
  'Q6. Which of the following is an appropriate explanation of feedback control?',
  '[{"type":"text","page":4,"bbox":[65.22,353.16,448.08,402.55],"text":"Q6. Which of the following is an appropriate explanation of feedback control?"},{"type":"text","page":4,"bbox":[65.22,408.35,488.28,510.55],"text":"a) It detects disturbance and takes a corrective action to prevent its influence.\nb) It is vulnerable to disturbance and the influence of the disturbance is amplified.\nc) It predicts disturbance and takes a corrective action accordingly.\nd) It takes a corrective action after detecting the influence of a disturbance."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It detects disturbance and takes a corrective action to prevent its influence."},{"label":"b","text":"It is vulnerable to disturbance and the influence of the disturbance is amplified."},{"label":"c","text":"It predicts disturbance and takes a corrective action accordingly."},{"label":"d","text":"It takes a corrective action after detecting the influence of a disturbance."}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q6)',
  ARRAY[4]::int[],
  'native_text',
  '3.0',
  'Q6. Which of the following is an appropriate explanation of feedback control?

 a) It detects disturbance and takes a corrective action to prevent its influence.
 b) It is vulnerable to disturbance and the influence of the disturbance is amplified.
 c) It predicts disturbance and takes a corrective action accordingly.
 d) It takes a corrective action after detecting the influence of a disturbance.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[4]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  7,
  'Q7. For two-dimensional integer array A, whose (i, j)-th element A[i, j] is 2 × i + j, what is the
 value of element A[A[1, 1] × 2, A[2, 2] + 1]?',
  '[{"type":"text","page":4,"bbox":[65.22,516.18,525.2,529.63],"text":"Q7. For two-dimensional integer array A, whose (i, j)-th element A[i, j] is 2 × i + j, what is the"},{"type":"text","page":4,"bbox":[65.22,534.35,302.49,564.55],"text":"value of element A[A[1, 1] × 2, A[2, 2] + 1]?"},{"type":"text","page":4,"bbox":[84.12,588.35,470.1,601.63],"text":"a) 12\nb) 13\nc) 18\nd) 19"},{"type":"code","page":4,"bbox":[65.22,794.63,311.58,807.97],"text":"– 4 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"12"},{"label":"b","text":"13"},{"label":"c","text":"18"},{"label":"d","text":"19\n\n – 4 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q7)',
  ARRAY[4]::int[],
  'native_text',
  '3.0',
  'Q7. For two-dimensional integer array A, whose (i, j)-th element A[i, j] is 2 × i + j, what is the
 value of element A[A[1, 1] × 2, A[2, 2] + 1]?

 a) 12 b) 13 c) 18 d) 19

 – 4 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[4]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  8,
  'Q8. For two non-negative integers x and y, which of the following is the result of the procedure
 shown in the flowchart below?

 Value of q Value of r',
  '[{"type":"text","page":5,"bbox":[65.22,68.76,527.59,82.21],"text":"Q8. For two non-negative integers x and y, which of the following is the result of the procedure"},{"type":"text","page":5,"bbox":[65.22,86.93,236.7,118.21],"text":"shown in the flowchart below?"},{"type":"table","page":5,"bbox":[85.08,299.58,334.56,416.76],"rows":[[null,"Value of q","Value of r"],["a)","Quotient of x ÷ y","Remainder of x÷ y"],["b)","Quotient of y ÷ x","Remainder of y ÷ x"],["c)","Remainder of x÷y","Quotient of x÷y"],["d)","Remainder of y÷ x","Quotient of y÷ x"]]},{"type":"text","page":5,"bbox":[139.74,304.91,304.8,318.19],"text":"Value of q\nValue of r"},{"type":"text","page":5,"bbox":[91.68,328.37,325.98,341.65],"text":"a) Quotient of x ÷ y\nRemainder of x ÷ y"},{"type":"text","page":5,"bbox":[91.32,351.83,327.0,365.11],"text":"b) Quotient of y ÷ x\nRemainder of y ÷ x"},{"type":"text","page":5,"bbox":[91.68,375.29,314.34,388.57],"text":"c) Remainder of x ÷ y\nQuotient of x ÷ y"},{"type":"text","page":5,"bbox":[91.32,398.75,315.36,412.03],"text":"d) Remainder of y ÷ x\nQuotient of y ÷ x"}]'::jsonb,
  '["2022-april-a-q08-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Quotient of x ÷ y Remainder of x ÷ y"},{"label":"b","text":"Quotient of y ÷ x Remainder of y ÷ x"},{"label":"c","text":"Remainder of x ÷ y Quotient of x ÷ y"},{"label":"d","text":"Remainder of y ÷ x Quotient of y ÷ x"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q8)',
  ARRAY[5]::int[],
  'native_text',
  '3.0',
  'Q8. For two non-negative integers x and y, which of the following is the result of the procedure
 shown in the flowchart below?

 Value of q Value of r

 a) Quotient of x ÷ y Remainder of x ÷ y

 b) Quotient of y ÷ x Remainder of y ÷ x

 c) Remainder of x ÷ y Quotient of x ÷ y

 d) Remainder of y ÷ x Quotient of y ÷ x',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[5]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  9,
  'Q9. Which of the following is an appropriate description of a binary search?',
  '[{"type":"text","page":5,"bbox":[65.22,456.72,437.88,488.17],"text":"Q9. Which of the following is an appropriate description of a binary search?"},{"type":"text","page":5,"bbox":[84.12,492.89,357.05,506.17],"text":"a) A binary search is always faster than a linear search."},{"type":"text","page":5,"bbox":[84.12,510.89,525.36,560.17],"text":"b) In a binary search, searching starts from the beginning of the data.\nc) The data upon which the binary search is to be performed must be sorted.\nd) The number of comparisons that need to be performed during the search is proportional"},{"type":"text","page":5,"bbox":[65.22,564.89,328.8,595.09],"text":"to log2N, where N is the number of data items."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A binary search is always faster than a linear search."},{"label":"b","text":"In a binary search, searching starts from the beginning of the data."},{"label":"c","text":"The data upon which the binary search is to be performed must be sorted."},{"label":"d","text":"The number of comparisons that need to be performed during the search is proportional\n to log2N, where N is the number of data items."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q9)',
  ARRAY[5]::int[],
  'native_text',
  '3.0',
  'Q9. Which of the following is an appropriate description of a binary search?

 a) A binary search is always faster than a linear search.
 b) In a binary search, searching starts from the beginning of the data.
 c) The data upon which the binary search is to be performed must be sorted.
 d) The number of comparisons that need to be performed during the search is proportional
 to log2N, where N is the number of data items.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[5]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  10,
  'Q10. When the Bubble sort algorithm is used, how many exchange operations are required to
 sort the numbers in ascending order?

 9, 2, 13, 21, 3, 0',
  '[{"type":"text","page":5,"bbox":[65.22,600.89,531.42,650.17],"text":"Q10.\nWhen the Bubble sort algorithm is used, how many exchange operations are required to\nsort the numbers in ascending order?"},{"type":"text","page":5,"bbox":[65.22,671.33,195.78,702.19],"text":"9, 2, 13, 21, 3, 0"},{"type":"text","page":5,"bbox":[65.22,706.91,470.1,755.11],"text":"a) 7\nb) 8\nc) 9\nd) 10"},{"type":"code","page":5,"bbox":[65.22,794.63,311.58,807.97],"text":"– 5 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"7"},{"label":"b","text":"8"},{"label":"c","text":"9"},{"label":"d","text":"10\n\n – 5 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q10)',
  ARRAY[5]::int[],
  'native_text',
  '3.0',
  'Q10. When the Bubble sort algorithm is used, how many exchange operations are required to
 sort the numbers in ascending order?

 9, 2, 13, 21, 3, 0

 a) 7 b) 8 c) 9 d) 10

 – 5 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[5]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  11,
  'Q11. Which of the following is the average cycles per instruction (CPI) of a computer that
 can execute 1 billion instructions per second at a clock rate of 2.4 GHz?',
  '[{"type":"text","page":6,"bbox":[65.22,68.76,517.48,116.59],"text":"Q11.\nWhich of the following is the average cycles per instruction (CPI) of a computer that\ncan execute 1 billion instructions per second at a clock rate of 2.4 GHz?"},{"type":"text","page":6,"bbox":[65.22,130.91,470.1,162.13],"text":"a) 0.04\nb) 0.12\nc) 2.4\nd) 25"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0.04"},{"label":"b","text":"0.12"},{"label":"c","text":"2.4"},{"label":"d","text":"25"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q11)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q11. Which of the following is the average cycles per instruction (CPI) of a computer that
 can execute 1 billion instructions per second at a clock rate of 2.4 GHz?

 a) 0.04 b) 0.12 c) 2.4 d) 25',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  12,
  'Q12. What is the approximate average access time in milliseconds (ms) of a magnetic disk
 with the specifications shown in the table below? Approximate average access time is the
 sum of average seek time, track-to-track seek time, and average rotational delay. Here, the
 controller overhead can be ignored.

 Average seek time 7.5 ms
 Track to track seek time 1.2 ms
 Rotational speed 7,200 rpm',
  '[{"type":"text","page":6,"bbox":[65.22,166.74,522.23,269.11],"text":"Q12.\nWhat is the approximate average access time in milliseconds (ms) of a magnetic disk\nwith the specifications shown in the table below? Approximate average access time is the\nsum of average seek time, track-to-track seek time, and average rotational delay. Here, the\ncontroller overhead can be ignored."},{"type":"table","page":6,"bbox":[92.22,271.44,380.22,326.94],"rows":[["Average seek time","7.5 ms"],["Track to track seek time","1.2 ms"],["Rotational speed","7,200 rpm"]]},{"type":"text","page":6,"bbox":[119.58,274.31,327.18,287.59],"text":"Average seek time\n7.5 ms"},{"type":"text","page":6,"bbox":[106.2,292.85,327.13,306.13],"text":"Track to track seek time\n1.2 ms"},{"type":"text","page":6,"bbox":[124.02,311.33,335.88,324.61],"text":"Rotational speed\n7,200 rpm"},{"type":"text","page":6,"bbox":[84.12,348.89,473.1,362.17],"text":"a) 11.67\nb) 12.87\nc) 15.83\nd) 25."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"11.67"},{"label":"b","text":"12.87"},{"label":"c","text":"15.83"},{"label":"d","text":"25."}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q12)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q12. What is the approximate average access time in milliseconds (ms) of a magnetic disk
 with the specifications shown in the table below? Approximate average access time is the
 sum of average seek time, track-to-track seek time, and average rotational delay. Here, the
 controller overhead can be ignored.

 Average seek time 7.5 ms
 Track to track seek time 1.2 ms
 Rotational speed 7,200 rpm

 a) 11.67 b) 12.87 c) 15.83 d) 25.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  13,
  'Q13. Which of the following is the list that contains A through D sorted starting with the
 shortest effective access time of the main memory?

 Cache memory Main memory

 Does the system
 Access time Hit rate Access time
 have cache
 (nanoseconds) (%) (nanoseconds)
 memory? (yes/no)

 A No - - 15
 B No - - 30
 C Yes 20 60 70
 D Yes 10 90 80',
  '[{"type":"text","page":6,"bbox":[65.22,385.24,508.54,452.11],"text":"Q13.\nWhich of the following is the list that contains A through D sorted starting with the\nshortest effective access time of the main memory?"},{"type":"table","page":6,"bbox":[113.22,453.54,481.8,609.0],"rows":[[null,"Cache memory",null,null,"Main memory"],[null,"Does the system\nhave cache\nmemory? (yes/no)","Access time\n(nanoseconds)","Hit rate\n(%)","Access time\n(nanoseconds)"],["A","No","-","-","15"],["B","No","-","-","30"],["C","Yes","20","60","70"],["D","Yes","10","90","80"]]},{"type":"text","page":6,"bbox":[130.74,457.67,470.38,470.95],"text":"Cache memory\nMain memory"},{"type":"text","page":6,"bbox":[157.26,479.93,238.99,493.21],"text":"Does the system"},{"type":"text","page":6,"bbox":[250.62,488.93,322.92,520.21],"text":"Access time\n(nanoseconds)"},{"type":"text","page":6,"bbox":[337.14,488.93,376.47,502.21],"text":"Hit rate"},{"type":"text","page":6,"bbox":[398.52,488.93,470.82,520.21],"text":"Access time\n(nanoseconds)"},{"type":"text","page":6,"bbox":[152.82,497.93,243.5,529.21],"text":"have cache\nmemory? (yes/no)"},{"type":"text","page":6,"bbox":[346.26,506.93,367.26,520.21],"text":"(%)"},{"type":"text","page":6,"bbox":[127.26,538.13,442.22,551.41],"text":"A\nNo\n-\n-\n15"},{"type":"text","page":6,"bbox":[127.26,556.91,442.22,570.19],"text":"B\nNo\n-\n-\n30"},{"type":"text","page":6,"bbox":[126.9,575.63,442.2,588.91],"text":"C\nYes\n20\n60\n70"},{"type":"text","page":6,"bbox":[126.6,594.41,442.2,607.69],"text":"D\nYes\n10\n90\n80"},{"type":"text","page":6,"bbox":[84.12,631.13,379.8,662.41],"text":"a) A, B, C, D\nb) A, D, B, C\nc) C, D, A, B\nd) D, C, A, B"},{"type":"code","page":6,"bbox":[65.22,794.63,311.58,807.97],"text":"– 6 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A, B, C, D"},{"label":"b","text":"A, D, B, C"},{"label":"c","text":"C, D, A, B"},{"label":"d","text":"D, C, A, B\n\n – 6 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q13)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q13. Which of the following is the list that contains A through D sorted starting with the
 shortest effective access time of the main memory?

 Cache memory Main memory

 Does the system
 Access time Hit rate Access time
 have cache
 (nanoseconds) (%) (nanoseconds)
 memory? (yes/no)

 A No - - 15
 B No - - 30
 C Yes 20 60 70
 D Yes 10 90 80

 a) A, B, C, D b) A, D, B, C
 c) C, D, A, B d) D, C, A, B

 – 6 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  14,
  'Q14. A 12-point character is to be displayed on a 96-dpi display in bitmap. How many dots
 is the height of a square font? Here, 1 point is 1/72 inch.',
  '[{"type":"text","page":7,"bbox":[65.22,68.76,522.11,136.21],"text":"Q14.\nA 12-point character is to be displayed on a 96-dpi display in bitmap. How many dots\nis the height of a square font? Here, 1 point is 1/72 inch.\n\na) 8\nb) 9\nc) 12\nd) 16"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"8"},{"label":"b","text":"9"},{"label":"c","text":"12"},{"label":"d","text":"16"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q14)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q14. A 12-point character is to be displayed on a 96-dpi display in bitmap. How many dots
 is the height of a square font? Here, 1 point is 1/72 inch.

 a) 8 b) 9 c) 12 d) 16',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  15,
  'Q15. Which of the following is a characteristic of an HA (High Availability) cluster
 configuration based on a hot standby method when it is compared to a load distribution
 cluster configuration that uses a load balancer?',
  '[{"type":"text","page":7,"bbox":[65.22,158.93,507.28,244.21],"text":"Q15.\nWhich of the following is a characteristic of an HA (High Availability) cluster\nconfiguration based on a hot standby method when it is compared to a load distribution\ncluster configuration that uses a load balancer?"},{"type":"text","page":7,"bbox":[84.12,248.93,524.74,262.21],"text":"a) A server that has the same specifications is necessary as the secondary server, but since"},{"type":"text","page":7,"bbox":[84.12,266.93,528.08,316.21],"text":"the secondary server takes over the processes in the event of the failure of the primary\nserver, the throughput can be maintained even in the event of a failure.\nb) Given that processes are distributed to other operational servers in the event of a failure,"},{"type":"text","page":7,"bbox":[84.12,320.93,500.35,352.21],"text":"the load on the servers in operation increases, and the throughput decreases.\nc) Given that processes can be distributed uniformly, server machines can be utilized"},{"type":"text","page":7,"bbox":[84.12,356.93,521.64,406.21],"text":"effectively, and expandability is ensured, even if the amount of processing increases in\nthe future.\nd) Given that processes must be consistent among multiple servers in operation, it is"},{"type":"text","page":7,"bbox":[91.98,410.93,248.08,442.21],"text":"necessary to share a database."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A server that has the same specifications is necessary as the secondary server, but since\n the secondary server takes over the processes in the event of the failure of the primary\n server, the throughput can be maintained even in the event of a failure."},{"label":"b","text":"Given that processes are distributed to other operational servers in the event of a failure,\n the load on the servers in operation increases, and the throughput decreases."},{"label":"c","text":"Given that processes can be distributed uniformly, server machines can be utilized\n effectively, and expandability is ensured, even if the amount of processing increases in\n the future."},{"label":"d","text":"Given that processes must be consistent among multiple servers in operation, it is\n necessary to share a database."}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q15)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q15. Which of the following is a characteristic of an HA (High Availability) cluster
 configuration based on a hot standby method when it is compared to a load distribution
 cluster configuration that uses a load balancer?

 a) A server that has the same specifications is necessary as the secondary server, but since
 the secondary server takes over the processes in the event of the failure of the primary
 server, the throughput can be maintained even in the event of a failure.
 b) Given that processes are distributed to other operational servers in the event of a failure,
 the load on the servers in operation increases, and the throughput decreases.
 c) Given that processes can be distributed uniformly, server machines can be utilized
 effectively, and expandability is ensured, even if the amount of processing increases in
 the future.
 d) Given that processes must be consistent among multiple servers in operation, it is
 necessary to share a database.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  16,
  'Q16. Which of the following is the system configuration that has the highest availability? Here,
 when systems are connected in parallel, the systems are considered to be operational if at least
 one (1) of them is operating.',
  '[{"type":"text","page":7,"bbox":[65.22,446.93,533.16,513.13],"text":"Q16.\nWhich of the following is the system configuration that has the highest availability? Here,\nwhen systems are connected in parallel, the systems are considered to be operational if at least\none (1) of them is operating."},{"type":"text","page":7,"bbox":[84.12,536.93,523.68,604.21],"text":"a) A single system with an availability of 99%\nb) Four (4) identical systems, each with an availability of 70%, are connected in parallel.\nc) Three (3) identical systems, each with an availability of 80%, are connected in parallel.\nd) Two (2) identical systems, each with an availability of 90%, are connected in parallel."},{"type":"code","page":7,"bbox":[65.22,794.63,311.58,807.97],"text":"– 7 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A single system with an availability of 99%"},{"label":"b","text":"Four (4) identical systems, each with an availability of 70%, are connected in parallel."},{"label":"c","text":"Three (3) identical systems, each with an availability of 80%, are connected in parallel."},{"label":"d","text":"Two (2) identical systems, each with an availability of 90%, are connected in parallel.\n\n – 7 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q16)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q16. Which of the following is the system configuration that has the highest availability? Here,
 when systems are connected in parallel, the systems are considered to be operational if at least
 one (1) of them is operating.

 a) A single system with an availability of 99%
 b) Four (4) identical systems, each with an availability of 70%, are connected in parallel.
 c) Three (3) identical systems, each with an availability of 80%, are connected in parallel.
 d) Two (2) identical systems, each with an availability of 90%, are connected in parallel.

 – 7 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  17,
  'Q17. An OS chooses a process for CPU execution based on the First-Come-First-Serve
 (FCFS) scheduling algorithm. There are four processes, P1, P2, P3, and P4, and their arrival
 times and burst times are shown in the table below. Which of the following is the
 appropriate combination of waiting times for the processes to be executed? Here, the arrival
 time is the time at which a process enters the ready queue and is ready for execution, the
 burst time is the time a process requires for CPU execution, and the waiting time is the
 period of time a process spends in the ready queue waiting for the CPU to start execution.

 Unit: milliseconds
 Process Arrival time Burst time
 P1 0 3
 P2 2 5
 P3 4 7
 P4 5 2

 P1 P2 P3 P4',
  '[{"type":"text","page":8,"bbox":[65.22,68.76,530.73,207.13],"text":"Q17.\nAn OS chooses a process for CPU execution based on the First-Come-First-Serve\n(FCFS) scheduling algorithm. There are four processes, P1, P2, P3, and P4, and their arrival\ntimes and burst times are shown in the table below. Which of the following is the\nappropriate combination of waiting times for the processes to be executed? Here, the arrival\ntime is the time at which a process enters the ready queue and is ready for execution, the\nburst time is the time a process requires for CPU execution, and the waiting time is the\nperiod of time a process spends in the ready queue waiting for the CPU to start execution."},{"type":"text","page":8,"bbox":[167.34,211.85,411.77,225.13],"text":"Unit: milliseconds"},{"type":"table","page":8,"bbox":[162.0,227.46,427.74,319.98],"rows":[["Process","Arrival time","Burst time"],["P1","0","3"],["P2","2","5"],["P3","4","7"],["P4","5","2"]]},{"type":"text","page":8,"bbox":[181.86,230.33,399.55,243.61],"text":"Process\nArrival time\nBurst time"},{"type":"text","page":8,"bbox":[193.86,248.81,377.28,262.09],"text":"P1\n0\n3"},{"type":"text","page":8,"bbox":[193.86,267.35,377.28,280.63],"text":"P2\n2\n5"},{"type":"text","page":8,"bbox":[193.86,285.83,377.28,299.11],"text":"P3\n4\n7"},{"type":"text","page":8,"bbox":[193.86,304.31,377.28,317.59],"text":"P4\n5\n2"},{"type":"table","page":8,"bbox":[93.56,338.34,326.38,431.02],"rows":[["","P1","P2","P3","P4"],["a)","0","1","4","10"],["b)","0","2","4","5"],["c)","0","3","5","7"],["d)","0","3","8","15"]]},{"type":"text","page":8,"bbox":[107.7,341.33,310.85,354.61],"text":"P1\nP2\nP3\nP4"},{"type":"text","page":8,"bbox":[103.08,359.81,310.51,373.09],"text":"a)\n0\n1\n4\n10"},{"type":"text","page":8,"bbox":[102.72,378.35,307.49,391.63],"text":"b)\n0\n2\n4\n5"},{"type":"text","page":8,"bbox":[103.08,396.83,307.51,410.11],"text":"c)\n0\n3\n5\n7"},{"type":"text","page":8,"bbox":[102.72,415.31,310.49,428.59],"text":"d)\n0\n3\n8\n15"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0 1 4 10"},{"label":"b","text":"0 2 4 5"},{"label":"c","text":"0 3 5 7"},{"label":"d","text":"0 3 8 15"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q17)',
  ARRAY[8]::int[],
  'native_text',
  '3.0',
  'Q17. An OS chooses a process for CPU execution based on the First-Come-First-Serve
 (FCFS) scheduling algorithm. There are four processes, P1, P2, P3, and P4, and their arrival
 times and burst times are shown in the table below. Which of the following is the
 appropriate combination of waiting times for the processes to be executed? Here, the arrival
 time is the time at which a process enters the ready queue and is ready for execution, the
 burst time is the time a process requires for CPU execution, and the waiting time is the
 period of time a process spends in the ready queue waiting for the CPU to start execution.

 Unit: milliseconds
 Process Arrival time Burst time
 P1 0 3
 P2 2 5
 P3 4 7
 P4 5 2

 P1 P2 P3 P4
 a) 0 1 4 10
 b) 0 2 4 5
 c) 0 3 5 7
 d) 0 3 8 15',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[8]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  18,
  'Q18. Which of the following is an appropriate reason for using a real-time OS in an
 embedded system?',
  '[{"type":"text","page":8,"bbox":[65.22,452.76,521.01,538.21],"text":"Q18.\nWhich of the following is an appropriate reason for using a real-time OS in an\nembedded system?\n\na) A graphical user interface is provided from an ease-of-use perspective with a real-time"},{"type":"text","page":8,"bbox":[84.12,542.93,514.98,610.21],"text":"OS.\nb) A real-time OS guarantees the highest levels of system security and reliability.\nc) No data is lost even if an application program hangs up with a real-time OS.\nd) With a real-time OS, there is a mechanism available to respond within a limited time."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A graphical user interface is provided from an ease-of-use perspective with a real-time\n OS."},{"label":"b","text":"A real-time OS guarantees the highest levels of system security and reliability."},{"label":"c","text":"No data is lost even if an application program hangs up with a real-time OS."},{"label":"d","text":"With a real-time OS, there is a mechanism available to respond within a limited time."}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q18)',
  ARRAY[8]::int[],
  'native_text',
  '3.0',
  'Q18. Which of the following is an appropriate reason for using a real-time OS in an
 embedded system?

 a) A graphical user interface is provided from an ease-of-use perspective with a real-time
 OS.
 b) A real-time OS guarantees the highest levels of system security and reliability.
 c) No data is lost even if an application program hangs up with a real-time OS.
 d) With a real-time OS, there is a mechanism available to respond within a limited time.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[8]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  19,
  'Q19. Which of the following is software that can be used without charge but has restrictions
 on modification and redistribution?',
  '[{"type":"text","page":8,"bbox":[65.22,633.28,526.09,700.15],"text":"Q19.\nWhich of the following is software that can be used without charge but has restrictions\non modification and redistribution?"},{"type":"text","page":8,"bbox":[65.22,704.93,414.78,772.21],"text":"a) Freeware\nb) Package software\nc) Public domain software\nd) Shareware"},{"type":"code","page":8,"bbox":[65.22,794.63,311.58,807.97],"text":"– 8 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Freeware"},{"label":"b","text":"Package software"},{"label":"c","text":"Public domain software"},{"label":"d","text":"Shareware\n\n – 8 –"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q19)',
  ARRAY[8]::int[],
  'native_text',
  '3.0',
  'Q19. Which of the following is software that can be used without charge but has restrictions
 on modification and redistribution?

 a) Freeware b) Package software
 c) Public domain software d) Shareware

 – 8 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[8]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  20,
  'Q20. Which of the following is an appropriate explanation of the function of an actuator?',
  '[{"type":"text","page":9,"bbox":[65.22,67.74,512.4,81.19],"text":"Q20.\nWhich of the following is an appropriate explanation of the function of an actuator?"},{"type":"text","page":9,"bbox":[84.12,104.93,516.28,118.21],"text":"a) It changes an analog electrical signal into a digital electrical signal, which a computer"},{"type":"text","page":9,"bbox":[102.12,122.93,163.74,136.21],"text":"can process."},{"type":"text","page":9,"bbox":[84.12,140.93,537.54,154.21],"text":"b) It changes an electrical control signal that a computer supplies into a mechanical motion."},{"type":"text","page":9,"bbox":[84.12,158.93,448.98,172.21],"text":"c) It identifies a physical quantity and changes it into an electrical signal."},{"type":"text","page":9,"bbox":[84.12,176.93,516.08,190.21],"text":"d) It is used in devices such as keyboards or touch panels to enter data into a computer."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It changes an analog electrical signal into a digital electrical signal, which a computer\n can process."},{"label":"b","text":"It changes an electrical control signal that a computer supplies into a mechanical motion."},{"label":"c","text":"It identifies a physical quantity and changes it into an electrical signal."},{"label":"d","text":"It is used in devices such as keyboards or touch panels to enter data into a computer."}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q20)',
  ARRAY[9]::int[],
  'native_text',
  '3.0',
  'Q20. Which of the following is an appropriate explanation of the function of an actuator?

 a) It changes an analog electrical signal into a digital electrical signal, which a computer
 can process.
 b) It changes an electrical control signal that a computer supplies into a mechanical motion.
 c) It identifies a physical quantity and changes it into an electrical signal.
 d) It is used in devices such as keyboards or touch panels to enter data into a computer.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[9]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  21,
  'Q21. Which of the following is the Exclusive-NOR logic function that is implemented with
 two-input NOR gates?',
  '[{"type":"text","page":9,"bbox":[65.22,230.76,522.75,244.21],"text":"Q21.\nWhich of the following is the Exclusive-NOR logic function that is implemented with"},{"type":"text","page":9,"bbox":[85.74,248.93,196.71,262.21],"text":"two-input NOR gates?"},{"type":"text","page":9,"bbox":[73.98,283.37,514.62,296.65],"text":"a)\n\nb)"},{"type":"text","page":9,"bbox":[73.98,388.25,343.08,401.53],"text":"c)\n\nd)"},{"type":"code","page":9,"bbox":[65.22,794.63,311.58,807.97],"text":"– 9 –"}]'::jsonb,
  '["2022-april-a-q21-figure1.webp"]'::jsonb,
  '[{"label":"a","text":""},{"label":"b","text":""},{"label":"c","text":""},{"label":"d","text":"– 9 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q21)',
  ARRAY[9]::int[],
  'native_text',
  '3.0',
  'Q21. Which of the following is the Exclusive-NOR logic function that is implemented with
 two-input NOR gates?

 a) b)

 c) d)

 – 9 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[9]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  22,
  'Q22. A paper tape reader used as a computer input device reads a tape with five rows of
 holes as shown below. A hole punched in the tape indicates logic 1, and no hole indicates
 logic 0. As each hole pattern passes under the photocells, the pattern is translated into logic
 signals as a variable: A, B, C, D, or E. A valid pattern on the tape has at least one hole, and
 an invalid pattern has no hole or all five holes punched. Which of the following is a logical
 expression that has logic 1 when a valid pattern is being read and logic 0 when an invalid
 pattern is being read? Here, + represents logical OR, ∙ represents logical AND, and ܣ
 represents the negation of A in the logic expression. In the figure, • represents a punched
 hole on the tape.',
  '[{"type":"text","page":10,"bbox":[65.22,68.76,527.04,227.23],"text":"Q22.\nA paper tape reader used as a computer input device reads a tape with five rows of\nholes as shown below. A hole punched in the tape indicates logic 1, and no hole indicates\nlogic 0. As each hole pattern passes under the photocells, the pattern is translated into logic\nsignals as a variable: A, B, C, D, or E. A valid pattern on the tape has at least one hole, and\nan invalid pattern has no hole or all five holes punched. Which of the following is a logical\nexpression that has logic 1 when a valid pattern is being read and logic 0 when an invalid\npattern is being read? Here, + represents logical OR, ∙ represents logical AND, and ܣ\nrepresents the negation of A in the logic expression. In the figure, • represents a punched\nhole on the tape."},{"type":"text","page":10,"bbox":[65.22,389.82,328.33,477.13],"text":"a) (ܣ⋅ܤ⋅ܥ⋅ܦ⋅ܧ\nതതതതതതതതതതതതതതതതതതത) + (ܣ⋅ܤ⋅ܥ⋅ܦ⋅ܧ)\nb) (ܣ+ ܤ+ ܥ+ ܦ+ ܧ) ⋅(ܣ̅ + ܤത+ ܥ̅ + ܦഥ+ ܧ)\nc) (ܣ̅ ⋅ܤത⋅ܥ̅ ⋅ܦഥ⋅ܧത) + (ܣ+ ܤ+ ܥ+ ܦ+ ܧ\nതതതതതതതതതതതതതതതതതതതതതതതത)\nd) (ܣ⋅ܤ⋅ܥ⋅ܦ⋅ܧ) + (ܣ̅ ⋅ܤത⋅ܥ̅ ⋅ܦഥ⋅ܧത )\nതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതത"}]'::jsonb,
  '["2022-april-a-q22-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"(ܣതതതതതതതതതതതതതതതതതതത)⋅ ܤ ⋅ ܥ ⋅ ܦ ⋅ ܧ + ( ܣ ⋅ ܤ ⋅ ܥ ⋅ ܦ ⋅ ܧ )"},{"label":"b","text":"(ܣ + ܤ + ܥ + ܦ + ܧ ) ⋅(ܣ+ ܤത+ ܥ+ ܦഥ+ ܧ )"},{"label":"c","text":"(ܣ⋅ ܤത⋅ ܥ⋅ ܦഥ⋅ ܧത) + (തതതതതതതതതതതതതതതതതതതതതതതത)ܣ + ܤ + ܥ + ܦ + ܧ\n തതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതത"},{"label":"d","text":"( ܣ ⋅ ܤ ⋅ ܥ ⋅ ܦ ⋅ ܧ ) + ( ܣ⋅ ܤത⋅ ܥ⋅ ܦഥ⋅ ܧത )"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q22)',
  ARRAY[10]::int[],
  'native_text',
  '3.0',
  'Q22. A paper tape reader used as a computer input device reads a tape with five rows of
 holes as shown below. A hole punched in the tape indicates logic 1, and no hole indicates
 logic 0. As each hole pattern passes under the photocells, the pattern is translated into logic
 signals as a variable: A, B, C, D, or E. A valid pattern on the tape has at least one hole, and
 an invalid pattern has no hole or all five holes punched. Which of the following is a logical
 expression that has logic 1 when a valid pattern is being read and logic 0 when an invalid
 pattern is being read? Here, + represents logical OR, ∙ represents logical AND, and ܣ
 represents the negation of A in the logic expression. In the figure, • represents a punched
 hole on the tape.

 a) (ܣതതതതതതതതതതതതതതതതതതത)⋅ ܤ ⋅ ܥ ⋅ ܦ ⋅ ܧ + ( ܣ ⋅ ܤ ⋅ ܥ ⋅ ܦ ⋅ ܧ )
 b) (ܣ + ܤ + ܥ + ܦ + ܧ ) ⋅(ܣ+ ܤത+ ܥ+ ܦഥ+ ܧ )
 c) (ܣ⋅ ܤത⋅ ܥ⋅ ܦഥ⋅ ܧത) + (തതതതതതതതതതതതതതതതതതതതതതതത)ܣ + ܤ + ܥ + ܦ + ܧ
 തതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതതത d) ( ܣ ⋅ ܤ ⋅ ܥ ⋅ ܦ ⋅ ܧ ) + ( ܣ⋅ ܤത⋅ ܥ⋅ ܦഥ⋅ ܧത )',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  23,
  'Q23. When ordering data is entered in the format shown below, which of the following is
 appropriate to check whether the order date is on a business day that is the same as or prior
 to the entering date?

 Ordering data

 Form number Order date Product code Quantity Customer code
 (Characters) (Characters) (Characters) (Number) (Characters)',
  '[{"type":"text","page":10,"bbox":[65.22,482.93,525.34,567.06],"text":"Q23.\nWhen ordering data is entered in the format shown below, which of the following is\nappropriate to check whether the order date is on a business day that is the same as or prior\nto the entering date?"},{"type":"text","page":10,"bbox":[100.62,571.8,170.26,586.21],"text":"Ordering data"},{"type":"table","page":10,"bbox":[106.5,587.58,501.96,632.34],"rows":[["Form number\n(Characters)","Order date\n(Characters)","Product code\n(Characters)","Quantity\n(Number)","Customer code\n(Characters)"]]},{"type":"text","page":10,"bbox":[110.46,595.67,179.08,626.95],"text":"Form number\n(Characters)"},{"type":"text","page":10,"bbox":[194.04,595.67,256.24,626.95],"text":"Order date\n(Characters)"},{"type":"text","page":10,"bbox":[266.4,595.67,332.43,626.95],"text":"Product code\n(Characters)"},{"type":"text","page":10,"bbox":[344.34,595.67,394.6,626.95],"text":"Quantity\n(Number)"},{"type":"text","page":10,"bbox":[420.9,595.67,496.15,626.95],"text":"Customer code\n(Characters)"},{"type":"text","page":10,"bbox":[65.22,654.41,407.51,720.61],"text":"a) Duplication check\nb) Format check\nc) Logical check\nd) Sequence check"},{"type":"code","page":10,"bbox":[65.22,794.63,314.58,807.97],"text":"– 10 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Duplication check"},{"label":"b","text":"Format check"},{"label":"c","text":"Logical check"},{"label":"d","text":"Sequence check\n\n – 10 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q23)',
  ARRAY[10]::int[],
  'native_text',
  '3.0',
  'Q23. When ordering data is entered in the format shown below, which of the following is
 appropriate to check whether the order date is on a business day that is the same as or prior
 to the entering date?

 Ordering data

 Form number Order date Product code Quantity Customer code
 (Characters) (Characters) (Characters) (Number) (Characters)

 a) Duplication check b) Format check
 c) Logical check d) Sequence check

 – 10 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  24,
  'Q24. Which of the following is the appropriate explanation of attributes in the relational
 model?',
  '[{"type":"text","page":11,"bbox":[65.22,68.76,513.35,190.21],"text":"Q24.\nWhich of the following is the appropriate explanation of attributes in the relational\nmodel?\n\na) It is possible to define attributes that have no name.\nb) The domains of definition for attributes within a relation must not overlap.\nc) The same name can be given to two (2) or more attributes in a relation.\nd) There is no meaning in the order of attributes within a relation, and the relation is the"},{"type":"text","page":11,"bbox":[65.22,194.93,268.71,226.21],"text":"same even if the order is changed."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is possible to define attributes that have no name."},{"label":"b","text":"The domains of definition for attributes within a relation must not overlap."},{"label":"c","text":"The same name can be given to two (2) or more attributes in a relation."},{"label":"d","text":"There is no meaning in the order of attributes within a relation, and the relation is the\n same even if the order is changed."}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q24)',
  ARRAY[11]::int[],
  'native_text',
  '3.0',
  'Q24. Which of the following is the appropriate explanation of attributes in the relational
 model?

 a) It is possible to define attributes that have no name.
 b) The domains of definition for attributes within a relation must not overlap.
 c) The same name can be given to two (2) or more attributes in a relation.
 d) There is no meaning in the order of attributes within a relation, and the relation is the
 same even if the order is changed.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[11]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  25,
  'Q25. When an ER diagram is translated into a set of tables in a relational database, which of
 the following is an appropriate method to translate a many-to-many relationship between
 two entities?',
  '[{"type":"text","page":11,"bbox":[65.22,230.76,526.49,316.21],"text":"Q25.\nWhen an ER diagram is translated into a set of tables in a relational database, which of\nthe following is an appropriate method to translate a many-to-many relationship between\ntwo entities?"},{"type":"text","page":11,"bbox":[84.12,320.93,532.4,352.21],"text":"a) Combine two entities and create a single table.\nb) Create a table for each entity and import the primary key from a table of smaller size to a"},{"type":"text","page":11,"bbox":[84.12,356.93,531.45,388.21],"text":"table of larger size.\nc) Create a table for each entity and import the primary key from one table to another table,"},{"type":"text","page":11,"bbox":[84.12,392.93,515.69,424.21],"text":"and vice versa.\nd) Create a table for each entity and then create a new table and import the primary keys"},{"type":"text","page":11,"bbox":[65.22,428.93,272.74,459.13],"text":"from both entities to the new table."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Combine two entities and create a single table."},{"label":"b","text":"Create a table for each entity and import the primary key from a table of smaller size to a\n table of larger size."},{"label":"c","text":"Create a table for each entity and import the primary key from one table to another table,\n and vice versa."},{"label":"d","text":"Create a table for each entity and then create a new table and import the primary keys\n from both entities to the new table."}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q25)',
  ARRAY[11]::int[],
  'native_text',
  '3.0',
  'Q25. When an ER diagram is translated into a set of tables in a relational database, which of
 the following is an appropriate method to translate a many-to-many relationship between
 two entities?

 a) Combine two entities and create a single table.
 b) Create a table for each entity and import the primary key from a table of smaller size to a
 table of larger size.
 c) Create a table for each entity and import the primary key from one table to another table,
 and vice versa.
 d) Create a table for each entity and then create a new table and import the primary keys
 from both entities to the new table.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[11]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  26,
  'Q26. Which of the following is a clause that is inserted into blank A of the SQL statement that
 calculates the average scores for each class and each subject from the “MidtermTest” table,
 and displays them in ascending order of class and subject?

 MidtermTest (Class, Subject, StudentNumber, Name, Score)

 [SQL statement]

 SELECT Class, Subject, AVG(Score) AS AverageScore

 FROM MidtermTest
 A',
  '[{"type":"text","page":11,"bbox":[65.22,464.93,533.17,531.13],"text":"Q26.\nWhich of the following is a clause that is inserted into blank A of the SQL statement that\ncalculates the average scores for each class and each subject from the “MidtermTest” table,\nand displays them in ascending order of class and subject?"},{"type":"text","page":11,"bbox":[117.3,554.93,410.7,568.21],"text":"MidtermTest (Class, Subject, StudentNumber, Name, Score)"},{"type":"text","page":11,"bbox":[107.22,581.93,194.39,595.21],"text":"[SQL statement]"},{"type":"text","page":11,"bbox":[117.3,602.71,418.79,612.73],"text":"SELECT Class, Subject, AVG(Score) AS AverageScore"},{"type":"text","page":11,"bbox":[117.3,620.71,219.84,630.73],"text":"FROM MidtermTest"},{"type":"text","page":11,"bbox":[91.98,634.7,418.67,721.21],"text":"A\n\n\na) GROUP BY Class, Subject ORDER BY Class, AVG(Score)\nb) GROUP BY Class, Subject ORDER BY Class, Subject\nc) GROUP BY Class, Subject, StudentNumber"},{"type":"text","page":11,"bbox":[130.32,728.71,359.45,738.73],"text":"ORDER BY Class, Subject, AverageScore"},{"type":"text","page":11,"bbox":[91.98,743.93,292.09,757.21],"text":"d) GROUP BY Class, AverageScore"},{"type":"text","page":11,"bbox":[132.12,761.76,358.36,775.15],"text":"ORDER BY Class, Subject, AverageScore"},{"type":"code","page":11,"bbox":[65.22,794.63,317.4,807.97],"text":"– 11 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"GROUP BY Class, Subject ORDER BY Class, AVG(Score)"},{"label":"b","text":"GROUP BY Class, Subject ORDER BY Class, Subject"},{"label":"c","text":"GROUP BY Class, Subject, StudentNumber\n\n ORDER BY Class, Subject, AverageScore"},{"label":"d","text":"GROUP BY Class, AverageScore\n\n ORDER BY Class, Subject, AverageScore\n\n – 11 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q26)',
  ARRAY[11]::int[],
  'native_text',
  '3.0',
  'Q26. Which of the following is a clause that is inserted into blank A of the SQL statement that
 calculates the average scores for each class and each subject from the “MidtermTest” table,
 and displays them in ascending order of class and subject?

 MidtermTest (Class, Subject, StudentNumber, Name, Score)

 [SQL statement]

 SELECT Class, Subject, AVG(Score) AS AverageScore

 FROM MidtermTest
 A

 a) GROUP BY Class, Subject ORDER BY Class, AVG(Score)
 b) GROUP BY Class, Subject ORDER BY Class, Subject
 c) GROUP BY Class, Subject, StudentNumber

 ORDER BY Class, Subject, AverageScore
 d) GROUP BY Class, AverageScore

 ORDER BY Class, Subject, AverageScore

 – 11 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[11]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  27,
  'Q27. The tables “Flight” and “City” are created as shown below. Which of the following is
 the SQL to output the flight code, its origin city name, and its destination city name from
 those tables?

 Flight: (FlightCode, OriginCityID, DestinationCityID)

 City: (CityID, CityName)',
  '[{"type":"text","page":12,"bbox":[65.22,68.76,521.03,134.53],"text":"Q27.\nThe tables “Flight” and “City” are created as shown below. Which of the following is\nthe SQL to output the flight code, its origin city name, and its destination city name from\nthose tables?"},{"type":"text","page":12,"bbox":[82.32,139.73,424.27,150.23],"text":"Flight: (FlightCode, OriginCityID, DestinationCityID)"},{"type":"text","page":12,"bbox":[82.32,155.75,246.94,166.25],"text":"City:  (CityID, CityName)"},{"type":"table","page":12,"bbox":[95.77,185.34,505.37,443.54],"rows":[["a)","SELECT FlightCode, City.CityName, City.CityName\nFROM Flight, City\nWHERE Flight.OriginCityID = City.CityID AND\nFlight. DestinationCityID = City.CityID"],["b)","SELECT FlightCode, OriginCityID, DestinationCityID\nFROM Flight, City\nWHERE Flight.OriginCityID = City.CityID AND\nFlight.DestinationCityID = City.CityID"],["c)","SELECT FlightCode, c1.CityName, c2.CityName\nFROM Flight, City c1, City c2\nWHERE Flight.OriginCityID = c1.CityID AND\nFlight.DestinationCityID = c2.CityID"],["d)","SELECT f1.FlightCode, c1.CityName, c2.CityName\nFROM Flight f1, Flight f2, City c1, City c2\nWHERE f1.OriginCityID = c1.CityID AND\nf2.DestinationCityID = c2.CityID"]]},{"type":"text","page":12,"bbox":[101.22,188.6,440.67,200.86],"text":"a)\nSELECT FlightCode, City.CityName, City.CityName"},{"type":"text","page":12,"bbox":[132.72,206.21,263.34,216.71],"text":"FROM\nFlight, City"},{"type":"text","page":12,"bbox":[132.72,222.23,426.92,232.73],"text":"WHERE\nFlight.OriginCityID = City.CityID AND"},{"type":"text","page":12,"bbox":[132.72,238.25,434.28,248.75],"text":"Flight. DestinationCityID = City.CityID"},{"type":"text","page":12,"bbox":[101.22,253.1,459.65,265.36],"text":"b)\nSELECT FlightCode, OriginCityID, DestinationCityID"},{"type":"text","page":12,"bbox":[132.72,270.71,263.34,281.21],"text":"FROM\nFlight, City"},{"type":"text","page":12,"bbox":[132.72,286.73,426.92,297.23],"text":"WHERE\nFlight.OriginCityID = City.CityID AND"},{"type":"text","page":12,"bbox":[132.72,302.75,427.97,313.25],"text":"Flight.DestinationCityID = City.CityID"},{"type":"text","page":12,"bbox":[101.22,317.6,420.56,329.86],"text":"c)\nSELECT FlightCode, c1.CityName, c2.CityName"},{"type":"text","page":12,"bbox":[132.72,335.21,339.37,345.71],"text":"FROM\nFlight, City c1, City c2"},{"type":"text","page":12,"bbox":[132.72,351.23,414.25,361.73],"text":"WHERE\nFlight.OriginCityID = c1.CityID AND"},{"type":"text","page":12,"bbox":[132.72,367.25,415.3,377.75],"text":"Flight.DestinationCityID = c2.CityID"},{"type":"text","page":12,"bbox":[101.22,382.1,439.59,394.36],"text":"d)\nSELECT f1.FlightCode, c1.CityName, c2.CityName"},{"type":"text","page":12,"bbox":[132.72,399.71,428.0,410.21],"text":"FROM\nFlight f1, Flight f2, City c1, City c2"},{"type":"text","page":12,"bbox":[132.72,415.73,388.91,426.23],"text":"WHERE\nf1.OriginCityID = c1.CityID AND"},{"type":"text","page":12,"bbox":[132.72,431.75,389.96,442.25],"text":"f2.DestinationCityID = c2.CityID"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"SELECT FlightCode, City.CityName, City.CityName\n\n FROM Flight, City\n\n WHERE Flight.OriginCityID = City.CityID AND\n\n Flight. DestinationCityID = City.CityID"},{"label":"b","text":"SELECT FlightCode, OriginCityID, DestinationCityID\n\n FROM Flight, City\n\n WHERE Flight.OriginCityID = City.CityID AND\n\n Flight.DestinationCityID = City.CityID"},{"label":"c","text":"SELECT FlightCode, c1.CityName, c2.CityName\n\n FROM Flight, City c1, City c2\n\n WHERE Flight.OriginCityID = c1.CityID AND\n\n Flight.DestinationCityID = c2.CityID"},{"label":"d","text":"SELECT f1.FlightCode, c1.CityName, c2.CityName\n\n FROM Flight f1, Flight f2, City c1, City c2\n\n WHERE f1.OriginCityID = c1.CityID AND\n\n f2.DestinationCityID = c2.CityID"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q27)',
  ARRAY[12]::int[],
  'native_text',
  '3.0',
  'Q27. The tables “Flight” and “City” are created as shown below. Which of the following is
 the SQL to output the flight code, its origin city name, and its destination city name from
 those tables?

 Flight: (FlightCode, OriginCityID, DestinationCityID)

 City: (CityID, CityName)

 a) SELECT FlightCode, City.CityName, City.CityName

 FROM Flight, City

 WHERE Flight.OriginCityID = City.CityID AND

 Flight. DestinationCityID = City.CityID
 b) SELECT FlightCode, OriginCityID, DestinationCityID

 FROM Flight, City

 WHERE Flight.OriginCityID = City.CityID AND

 Flight.DestinationCityID = City.CityID
 c) SELECT FlightCode, c1.CityName, c2.CityName

 FROM Flight, City c1, City c2

 WHERE Flight.OriginCityID = c1.CityID AND

 Flight.DestinationCityID = c2.CityID
 d) SELECT f1.FlightCode, c1.CityName, c2.CityName

 FROM Flight f1, Flight f2, City c1, City c2

 WHERE f1.OriginCityID = c1.CityID AND

 f2.DestinationCityID = c2.CityID',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[12]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  28,
  'Q28. For the description of the lock granularity of an RDBMS below, which of the following
 is an appropriate combination of A and B?

 Each pair of transactions that are processed in parallel updates multiple rows in a single table.

 When a row-level lock and a table-level lock are compared, lock contention is more likely to
 occur when an A -level lock is used. More RDBMS memory area is required when
 a B -level lock is used in order to manage the lock while transactions are being

 processed.

 A B',
  '[{"type":"text","page":12,"bbox":[65.22,483.24,531.14,496.69],"text":"Q28.\nFor the description of the lock granularity of an RDBMS below, which of the following"},{"type":"text","page":12,"bbox":[85.74,501.41,291.0,514.69],"text":"is an appropriate combination of A and B?"},{"type":"text","page":12,"bbox":[85.38,539.09,533.17,552.37],"text":"Each pair of transactions that are processed in parallel updates multiple rows in a single table."},{"type":"text","page":12,"bbox":[85.38,559.13,533.13,572.41],"text":"When a row-level lock and a table-level lock are compared, lock contention is more likely to"},{"type":"text","page":12,"bbox":[85.38,579.11,533.1,592.39],"text":"occur when an\n -level lock is used. More RDBMS memory area is required when"},{"type":"text","page":12,"bbox":[183.72,579.65,194.04,592.93],"text":"A"},{"type":"text","page":12,"bbox":[85.38,599.09,533.21,612.37],"text":"a\n -level lock is used in order to manage the lock while transactions are being"},{"type":"text","page":12,"bbox":[119.4,599.15,129.72,612.43],"text":"B"},{"type":"text","page":12,"bbox":[85.38,619.13,138.72,632.41],"text":"processed."},{"type":"table","page":12,"bbox":[85.2,656.04,219.06,751.86],"rows":[[null,"A","B"],["a)","row","row"],["b)","row","table"],["c)","table","row"],["d)","table","table"]]},{"type":"text","page":12,"bbox":[97.68,658.73,198.53,672.01],"text":"A\nB"},{"type":"text","page":12,"bbox":[93.42,678.18,203.12,690.33],"text":"a)\nrow\nrow"},{"type":"text","page":12,"bbox":[93.06,697.56,205.22,709.71],"text":"b)\nrow\ntable"},{"type":"text","page":12,"bbox":[93.42,717.0,203.13,729.15],"text":"c)\ntable\nrow"},{"type":"text","page":12,"bbox":[93.06,736.38,205.22,748.53],"text":"d)\ntable\ntable"},{"type":"code","page":12,"bbox":[65.22,794.63,314.58,807.97],"text":"– 12 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"row row"},{"label":"b","text":"row table"},{"label":"c","text":"table row"},{"label":"d","text":"table table\n\n – 12 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q28)',
  ARRAY[12]::int[],
  'native_text',
  '3.0',
  'Q28. For the description of the lock granularity of an RDBMS below, which of the following
 is an appropriate combination of A and B?

 Each pair of transactions that are processed in parallel updates multiple rows in a single table.

 When a row-level lock and a table-level lock are compared, lock contention is more likely to
 occur when an A -level lock is used. More RDBMS memory area is required when
 a B -level lock is used in order to manage the lock while transactions are being

 processed.

 A B

 a) row row

 b) row table

 c) table row

 d) table table

 – 12 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[12]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  29,
  'Q29. When a storage location is calculated from a key value, which of the following is the
 method that can produce the same calculation results from different key values?',
  '[{"type":"text","page":13,"bbox":[65.22,68.76,517.57,172.15],"text":"Q29.\nWhen a storage location is calculated from a key value, which of the following is the\nmethod that can produce the same calculation results from different key values?\n\na) B+ tree index\nb) Bitmap index\nc) Hash index\nd) Inverted index"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"B+ tree index"},{"label":"b","text":"Bitmap index"},{"label":"c","text":"Hash index"},{"label":"d","text":"Inverted index"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q29)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q29. When a storage location is calculated from a key value, which of the following is the
 method that can produce the same calculation results from different key values?

 a) B+ tree index b) Bitmap index
 c) Hash index d) Inverted index',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  30,
  'Q30. Multiple PCs are connected to the Internet with FTTH. The WAN interface of device A
 has a single global IP address allocated to it. Which of the following is the function of
 device A that enables these PCs to connect to the Internet by sharing the global IP address?

 User’s facilities

 PC
 Optical fiber cable (FTTH)
 … Hub Device A ONU
 PC',
  '[{"type":"text","page":13,"bbox":[65.22,176.93,529.68,244.21],"text":"Q30.\nMultiple PCs are connected to the Internet with FTTH. The WAN interface of device A\nhas a single global IP address allocated to it. Which of the following is the function of\ndevice A that enables these PCs to connect to the Internet by sharing the global IP address?"},{"type":"text","page":13,"bbox":[246.6,271.62,320.88,284.07],"text":"User’s facilities"},{"type":"text","page":13,"bbox":[139.44,290.82,153.48,303.27],"text":"PC"},{"type":"text","page":13,"bbox":[187.32,299.76,456.87,320.01],"text":"Device A\nOptical fiber cable (FTTH)\nHub\nONU"},{"type":"text","page":13,"bbox":[139.89,308.4,152.34,319.65],"text":"…"},{"type":"text","page":13,"bbox":[139.56,324.72,153.6,337.17],"text":"PC"},{"type":"text","page":13,"bbox":[84.12,356.93,443.73,406.21],"text":"a) DHCP\nb) NAPT (IP masquerade)\nc) Packet filtering\nd) PPPoE"}]'::jsonb,
  '["2022-april-a-q30-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"DHCP"},{"label":"b","text":"NAPT (IP masquerade)"},{"label":"c","text":"Packet filtering"},{"label":"d","text":"PPPoE"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q30)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q30. Multiple PCs are connected to the Internet with FTTH. The WAN interface of device A
 has a single global IP address allocated to it. Which of the following is the function of
 device A that enables these PCs to connect to the Internet by sharing the global IP address?

 User’s facilities

 PC
 Optical fiber cable (FTTH)
 … Hub Device A ONU
 PC

 a) DHCP b) NAPT (IP masquerade)
 c) Packet filtering d) PPPoE',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  31,
  'Q31. Audio data of 2.4 Mbytes encoded at 192 kbit/s is to be downloaded and played back
 without interruptions over a network with a communication speed of 128 kbit/s. What is the
 minimum number of seconds required as the data buffering time before the start of
 playback?',
  '[{"type":"text","page":13,"bbox":[65.22,446.76,529.67,532.21],"text":"Q31.\nAudio data of 2.4 Mbytes encoded at 192 kbit/s is to be downloaded and played back\nwithout interruptions over a network with a communication speed of 128 kbit/s. What is the\nminimum number of seconds required as the data buffering time before the start of\nplayback?"},{"type":"text","page":13,"bbox":[65.22,536.93,476.1,567.13],"text":"a) 50\nb) 100\nc) 150\nd) 250"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"50"},{"label":"b","text":"100"},{"label":"c","text":"150"},{"label":"d","text":"250"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q31)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q31. Audio data of 2.4 Mbytes encoded at 192 kbit/s is to be downloaded and played back
 without interruptions over a network with a communication speed of 128 kbit/s. What is the
 minimum number of seconds required as the data buffering time before the start of
 playback?

 a) 50 b) 100 c) 150 d) 250',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  32,
  'Q32. There exists a system that connects a head office to a factory via a leased line and sends
 form data. The size of each form is 2,000 bytes, and header data totaling 400 bytes is
 attached to every two (2) forms to be sent through this system. On average, 100,000 forms
 per hour are generated. When the line speed is 1 Mbit/s, what is the line’s utilization rate in
 percentage?',
  '[{"type":"text","page":13,"bbox":[65.22,572.93,531.68,712.21],"text":"Q32.\nThere exists a system that connects a head office to a factory via a leased line and sends\nform data. The size of each form is 2,000 bytes, and header data totaling 400 bytes is\nattached to every two (2) forms to be sent through this system. On average, 100,000 forms\nper hour are generated. When the line speed is 1 Mbit/s, what is the line’s utilization rate in\npercentage?\n\na) 6.1\nb) 44\nc) 49\nd) 53"},{"type":"code","page":13,"bbox":[65.22,794.63,314.58,807.97],"text":"– 13 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"6.1"},{"label":"b","text":"44"},{"label":"c","text":"49"},{"label":"d","text":"53\n\n – 13 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q32)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q32. There exists a system that connects a head office to a factory via a leased line and sends
 form data. The size of each form is 2,000 bytes, and header data totaling 400 bytes is
 attached to every two (2) forms to be sent through this system. On average, 100,000 forms
 per hour are generated. When the line speed is 1 Mbit/s, what is the line’s utilization rate in
 percentage?

 a) 6.1 b) 44 c) 49 d) 53

 – 13 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  33,
  'Q33. In IPv4, what is the maximum number of IP addresses that can be assigned to hosts in
 the network of 172.16.64.0/23? Here, the decimal number after the slash (/) is the number of
 bits used for the network prefix.',
  '[{"type":"text","page":14,"bbox":[65.22,67.74,533.15,117.13],"text":"Q33.\nIn IPv4, what is the maximum number of IP addresses that can be assigned to hosts in\nthe network of 172.16.64.0/23? Here, the decimal number after the slash (/) is the number of\nbits used for the network prefix."},{"type":"text","page":14,"bbox":[84.12,140.93,476.1,154.21],"text":"a) 254\nb) 256\nc) 510\nd) 512"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"254"},{"label":"b","text":"256"},{"label":"c","text":"510"},{"label":"d","text":"512"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q33)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q33. In IPv4, what is the maximum number of IP addresses that can be assigned to hosts in
 the network of 172.16.64.0/23? Here, the decimal number after the slash (/) is the number of
 bits used for the network prefix.

 a) 254 b) 256 c) 510 d) 512',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  34,
  'Q34. Which of the following is the broadcast address of the network with the address
 192.168.128.0/26? Here, the decimal number after the slash (/) is the number of bits used for
 the network prefix.',
  '[{"type":"text","page":14,"bbox":[65.22,175.74,533.16,243.13],"text":"Q34.\nWhich of the following is the broadcast address of the network with the address\n192.168.128.0/26? Here, the decimal number after the slash (/) is the number of bits used for\nthe network prefix."},{"type":"text","page":14,"bbox":[84.12,266.93,412.09,298.28],"text":"a) 192.168.128.63\nb) 192.168.128.127\nc) 192.168.128.252\nd) 192.168.128.255"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"192.168.128.63"},{"label":"b","text":"192.168.128.127"},{"label":"c","text":"192.168.128.252"},{"label":"d","text":"192.168.128.255"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q34)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q34. Which of the following is the broadcast address of the network with the address
 192.168.128.0/26? Here, the decimal number after the slash (/) is the number of bits used for
 the network prefix.

 a) 192.168.128.63 b) 192.168.128.127
 c) 192.168.128.252 d) 192.168.128.255',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  35,
  'Q35. Which of the following is an Internet standard that is used to convert IP addresses to the
 corresponding MAC addresses?',
  '[{"type":"text","page":14,"bbox":[65.22,338.76,532.81,388.15],"text":"Q35.\nWhich of the following is an Internet standard that is used to convert IP addresses to the\ncorresponding MAC addresses?"},{"type":"text","page":14,"bbox":[65.22,392.93,476.72,424.15],"text":"a) ARP\nb) ICMP\nc) RARP\nd) RIP"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"ARP"},{"label":"b","text":"ICMP"},{"label":"c","text":"RARP"},{"label":"d","text":"RIP"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q35)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q35. Which of the following is an Internet standard that is used to convert IP addresses to the
 corresponding MAC addresses?

 a) ARP b) ICMP c) RARP d) RIP',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  36,
  'Q36. Which of the following is a direct result of SQL injection to a company’s web server?',
  '[{"type":"text","page":14,"bbox":[65.22,428.76,521.68,459.19],"text":"Q36.\nWhich of the following is a direct result of SQL injection to a company’s web server?"},{"type":"text","page":14,"bbox":[84.12,482.93,531.39,514.21],"text":"a) Data packets to and from the web server are modified.\nb) Data that is on the web server but is not accessible via the web application is retrieved or"},{"type":"text","page":14,"bbox":[84.12,518.93,433.02,568.21],"text":"modified.\nc) Every key stroke a user makes in the network is captured.\nd) The IP headers of packets in the network are captured and modified."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Data packets to and from the web server are modified."},{"label":"b","text":"Data that is on the web server but is not accessible via the web application is retrieved or\n modified."},{"label":"c","text":"Every key stroke a user makes in the network is captured."},{"label":"d","text":"The IP headers of packets in the network are captured and modified."}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q36)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q36. Which of the following is a direct result of SQL injection to a company’s web server?

 a) Data packets to and from the web server are modified.
 b) Data that is on the web server but is not accessible via the web application is retrieved or
 modified.
 c) Every key stroke a user makes in the network is captured.
 d) The IP headers of packets in the network are captured and modified.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  37,
  'Q37. Which of the following is a program that is designed to block access to a computer or
 encrypt most of the data on that computer until a sum of money is paid?',
  '[{"type":"text","page":14,"bbox":[65.22,591.28,520.81,640.21],"text":"Q37.\nWhich of the following is a program that is designed to block access to a computer or\nencrypt most of the data on that computer until a sum of money is paid?"},{"type":"text","page":14,"bbox":[84.12,662.93,500.11,676.21],"text":"a) Adware\nb) Ransomware\nc) Rootkit\nd) Spyware"},{"type":"code","page":14,"bbox":[65.22,794.63,314.58,807.97],"text":"– 14 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Adware"},{"label":"b","text":"Ransomware"},{"label":"c","text":"Rootkit"},{"label":"d","text":"Spyware\n\n – 14 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q37)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q37. Which of the following is a program that is designed to block access to a computer or
 encrypt most of the data on that computer until a sum of money is paid?

 a) Adware b) Ransomware c) Rootkit d) Spyware

 – 14 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  38,
  'Q38. In a PKI system, which of the following is an algorithm that creates a key pair?',
  '[{"type":"text","page":15,"bbox":[65.22,67.74,490.84,81.19],"text":"Q38.\nIn a PKI system, which of the following is an algorithm that creates a key pair?"},{"type":"text","page":15,"bbox":[65.22,104.93,453.87,154.15],"text":"a) Hashing algorithm\nb) Key generation algorithm\nc) Signature verification algorithm\nd) Signing algorithm"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Hashing algorithm"},{"label":"b","text":"Key generation algorithm"},{"label":"c","text":"Signature verification algorithm"},{"label":"d","text":"Signing algorithm"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q38)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q38. In a PKI system, which of the following is an algorithm that creates a key pair?

 a) Hashing algorithm b) Key generation algorithm
 c) Signature verification algorithm d) Signing algorithm',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  39,
  'Q39. Which of the following is an appropriate description of a command and control (C&C)
 server?',
  '[{"type":"text","page":15,"bbox":[65.22,158.76,527.11,208.21],"text":"Q39.\nWhich of the following is an appropriate description of a command and control (C&C)\nserver?"},{"type":"text","page":15,"bbox":[84.12,230.93,529.92,244.21],"text":"a) A computer controlled and used by an attacker to send commands to other compromised"},{"type":"text","page":15,"bbox":[84.12,248.93,519.64,280.21],"text":"computers\nb) A computer on a cloud service used to securely control the movement of data between"},{"type":"text","page":15,"bbox":[84.12,284.93,480.66,316.21],"text":"on-premise storage and cloud storage using encrypted communication\nc) A computer used to control the authentication of all users and computers in an"},{"type":"text","page":15,"bbox":[84.12,320.93,525.1,352.21],"text":"organization\nd) A computer used to control the distribution of processing among different computers in"},{"type":"text","page":15,"bbox":[102.12,356.93,525.04,388.21],"text":"a high-performance computing environment, so that processing is not affected by cyber\nattacks"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A computer controlled and used by an attacker to send commands to other compromised\n computers"},{"label":"b","text":"A computer on a cloud service used to securely control the movement of data between\n on-premise storage and cloud storage using encrypted communication"},{"label":"c","text":"A computer used to control the authentication of all users and computers in an\n organization"},{"label":"d","text":"A computer used to control the distribution of processing among different computers in\n a high-performance computing environment, so that processing is not affected by cyber\n attacks"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q39)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q39. Which of the following is an appropriate description of a command and control (C&C)
 server?

 a) A computer controlled and used by an attacker to send commands to other compromised
 computers
 b) A computer on a cloud service used to securely control the movement of data between
 on-premise storage and cloud storage using encrypted communication
 c) A computer used to control the authentication of all users and computers in an
 organization
 d) A computer used to control the distribution of processing among different computers in
 a high-performance computing environment, so that processing is not affected by cyber
 attacks',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  40,
  'Q40. Which of the following is an appropriate description of an advanced persistent threat
 (APT)?',
  '[{"type":"text","page":15,"bbox":[65.22,428.76,516.82,478.21],"text":"Q40.\nWhich of the following is an appropriate description of an advanced persistent threat\n(APT)?"},{"type":"text","page":15,"bbox":[84.12,482.93,526.92,514.21],"text":"a) It is a malware attack that keeps recreating malicious files even after repeated deletions.\nb) It is an attack that uses sophisticated techniques and goes undetected over a long time,"},{"type":"text","page":15,"bbox":[84.12,518.93,529.65,550.21],"text":"e.g., months or years.\nc) It is an attack using malware in computer BIOS, affecting multiple operating systems on"},{"type":"text","page":15,"bbox":[84.12,554.93,523.42,586.21],"text":"a computer that allows multi-booting.\nd) It is an attack using malware that disables all of a company’s computers and is difficult"},{"type":"text","page":15,"bbox":[102.12,590.93,149.11,604.21],"text":"to delete."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is a malware attack that keeps recreating malicious files even after repeated deletions."},{"label":"b","text":"It is an attack that uses sophisticated techniques and goes undetected over a long time,\n e.g., months or years."},{"label":"c","text":"It is an attack using malware in computer BIOS, affecting multiple operating systems on\n a computer that allows multi-booting."},{"label":"d","text":"It is an attack using malware that disables all of a company’s computers and is difficult\n to delete."}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q40)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q40. Which of the following is an appropriate description of an advanced persistent threat
 (APT)?

 a) It is a malware attack that keeps recreating malicious files even after repeated deletions.
 b) It is an attack that uses sophisticated techniques and goes undetected over a long time,
 e.g., months or years.
 c) It is an attack using malware in computer BIOS, affecting multiple operating systems on
 a computer that allows multi-booting.
 d) It is an attack using malware that disables all of a company’s computers and is difficult
 to delete.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  41,
  'Q41. Which of the following is an appropriate description of footprinting in computer security?',
  '[{"type":"text","page":15,"bbox":[65.22,643.74,533.44,657.19],"text":"Q41.\nWhich of the following is an appropriate description of footprinting in computer security?"},{"type":"text","page":15,"bbox":[84.12,680.93,528.36,748.21],"text":"a) Digital forensic analysis to find the hacker after a hacking incident\nb) Gathering information about an organization and its systems in preparation for an attack\nc) Listing all affected files in the system in order to assess the impact of an attack\nd) Setting up an intrusion detection system in order to detect when an attacker breaks into"},{"type":"text","page":15,"bbox":[102.12,752.93,201.75,766.21],"text":"the internal network"},{"type":"code","page":15,"bbox":[65.22,794.63,314.58,807.97],"text":"– 15 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Digital forensic analysis to find the hacker after a hacking incident"},{"label":"b","text":"Gathering information about an organization and its systems in preparation for an attack"},{"label":"c","text":"Listing all affected files in the system in order to assess the impact of an attack"},{"label":"d","text":"Setting up an intrusion detection system in order to detect when an attacker breaks into\n the internal network\n\n – 15 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q41)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q41. Which of the following is an appropriate description of footprinting in computer security?

 a) Digital forensic analysis to find the hacker after a hacking incident
 b) Gathering information about an organization and its systems in preparation for an attack
 c) Listing all affected files in the system in order to assess the impact of an attack
 d) Setting up an intrusion detection system in order to detect when an attacker breaks into
 the internal network

 – 15 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  42,
  'Q42. Which of the following is an appropriate combination of definitions I through IV for
 authenticity and reliability in ISO/IEC 27000:2018 (Information security management
 systems – Overview and vocabulary)?

 [Definitions]
 I Property of consistent intended behavior and results
 II Property that an entity is what it claims to be
 III Property of being accessible and usable on demand by an authorized entity
 IV Property that information is not made available or disclosed to unauthorized individuals,
 entities, or processes

 Authenticity Reliability',
  '[{"type":"text","page":16,"bbox":[65.22,67.74,515.57,117.13],"text":"Q42.\nWhich of the following is an appropriate combination of definitions I through IV for\nauthenticity and reliability in ISO/IEC 27000:2018 (Information security management\nsystems – Overview and vocabulary)?"},{"type":"text","page":16,"bbox":[85.08,144.53,529.65,229.09],"text":"[Definitions]\nI\nProperty of consistent intended behavior and results\nII Property that an entity is what it claims to be\nIII Property of being accessible and usable on demand by an authorized entity\nIV Property that information is not made available or disclosed to unauthorized individuals,"},{"type":"text","page":16,"bbox":[102.06,233.81,204.66,247.09],"text":"entities, or processes"},{"type":"table","page":16,"bbox":[80.22,267.54,233.34,371.28],"rows":[[null,"Authenticity","Reliability"],["a)","I","III"],["b)","II","I"],["c)","II","IV"],["d)","IV","I"]]},{"type":"text","page":16,"bbox":[90.6,271.37,230.91,284.65],"text":"Authenticity Reliability"},{"type":"text","page":16,"bbox":[85.98,292.13,211.52,305.41],"text":"a)\nI\nIII"},{"type":"text","page":16,"bbox":[85.62,312.83,207.55,326.11],"text":"b)\nII\nI"},{"type":"text","page":16,"bbox":[85.98,333.59,211.86,346.87],"text":"c)\nII\nIV"},{"type":"text","page":16,"bbox":[85.62,354.35,207.55,367.63],"text":"d)\nIV\nI"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"I III"},{"label":"b","text":"II I"},{"label":"c","text":"II IV"},{"label":"d","text":"IV I"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q42)',
  ARRAY[16]::int[],
  'native_text',
  '3.0',
  'Q42. Which of the following is an appropriate combination of definitions I through IV for
 authenticity and reliability in ISO/IEC 27000:2018 (Information security management
 systems – Overview and vocabulary)?

 [Definitions]
 I Property of consistent intended behavior and results
 II Property that an entity is what it claims to be
 III Property of being accessible and usable on demand by an authorized entity
 IV Property that information is not made available or disclosed to unauthorized individuals,
 entities, or processes

 Authenticity Reliability

 a) I III

 b) II I

 c) II IV

 d) IV I',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[16]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  43,
  'Q43. When a mirror port is prepared to allow a LAN analyzer to be used for measurement in
 order to investigate the cause of a network failure, which of the following is a point to
 consider?',
  '[{"type":"text","page":16,"bbox":[65.22,393.41,528.78,477.37],"text":"Q43.\nWhen a mirror port is prepared to allow a LAN analyzer to be used for measurement in\norder to investigate the cause of a network failure, which of the following is a point to\nconsider?"},{"type":"text","page":16,"bbox":[84.12,483.41,491.98,496.69],"text":"a) In preparation for a failure, it is necessary to inform network users of the storage"},{"type":"text","page":16,"bbox":[84.12,501.41,532.37,532.69],"text":"location and usage method about the LAN analyzer.\nb) Since LAN cables must be temporarily disconnected during measurement, it is necessary"},{"type":"text","page":16,"bbox":[84.12,537.41,503.45,568.69],"text":"to give network users advance notice of the measurement date and time.\nc) Since the LAN analyzer can display the packets that pass through the network, it is"},{"type":"text","page":16,"bbox":[84.12,573.41,527.68,604.69],"text":"necessary to pay attention to misuse or abuse, such as wiretapping.\nd) Since the LAN analyzer disposes of packets, it is necessary to restrict the use of the non-"},{"type":"text","page":16,"bbox":[65.22,609.41,289.84,658.63],"text":"target computers during measurement."},{"type":"code","page":16,"bbox":[65.22,794.63,314.58,807.97],"text":"– 16 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"In preparation for a failure, it is necessary to inform network users of the storage\n location and usage method about the LAN analyzer."},{"label":"b","text":"Since LAN cables must be temporarily disconnected during measurement, it is necessary\n to give network users advance notice of the measurement date and time."},{"label":"c","text":"Since the LAN analyzer can display the packets that pass through the network, it is\n necessary to pay attention to misuse or abuse, such as wiretapping."},{"label":"d","text":"Since the LAN analyzer disposes of packets, it is necessary to restrict the use of the nontarget computers during measurement.\n\n – 16 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q43)',
  ARRAY[16]::int[],
  'native_text',
  '3.0',
  'Q43. When a mirror port is prepared to allow a LAN analyzer to be used for measurement in
 order to investigate the cause of a network failure, which of the following is a point to
 consider?

 a) In preparation for a failure, it is necessary to inform network users of the storage
 location and usage method about the LAN analyzer.
 b) Since LAN cables must be temporarily disconnected during measurement, it is necessary
 to give network users advance notice of the measurement date and time.
 c) Since the LAN analyzer can display the packets that pass through the network, it is
 necessary to pay attention to misuse or abuse, such as wiretapping.
 d) Since the LAN analyzer disposes of packets, it is necessary to restrict the use of the nontarget computers during measurement.

 – 16 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[16]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  44,
  'Q44. There is a network that is divided into three (3) segments, namely an external segment,
 a DMZ, and an internal segment, by one (1) firewall. In this network, a service for users is
 published on the Internet using a system comprising a web server and a database server that
 contains critical data. Which of the following is the most appropriate server installation
 method for protecting critical data from unauthorized access via the Internet? Here, the web
 server performs front end processing for the database server, and the firewall allows only a
 specific protocol for communication between the external segment and the DMZ as well as
 between the DMZ and the internal segment. Direct communication between the external
 segment and the internal segment is not allowed.',
  '[{"type":"text","page":17,"bbox":[65.22,68.76,532.48,298.21],"text":"Q44.\nThere is a network that is divided into three (3) segments, namely an external segment,\na DMZ, and an internal segment, by one (1) firewall. In this network, a service for users is\npublished on the Internet using a system comprising a web server and a database server that\ncontains critical data. Which of the following is the most appropriate server installation\nmethod for protecting critical data from unauthorized access via the Internet? Here, the web\nserver performs front end processing for the database server, and the firewall allows only a\nspecific protocol for communication between the external segment and the DMZ as well as\nbetween the DMZ and the internal segment. Direct communication between the external\nsegment and the internal segment is not allowed.\n\na) The web server and the database server are installed in the DMZ.\nb) The web server and the database server are installed in the internal segment.\nc) The web server is installed in the DMZ and the database server is installed in the internal"},{"type":"text","page":17,"bbox":[84.12,302.93,530.05,334.21],"text":"segment.\nd) The web server is installed in the external segment and the database server is installed in"},{"type":"text","page":17,"bbox":[65.22,338.93,152.47,370.15],"text":"the DMZ."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"The web server and the database server are installed in the DMZ."},{"label":"b","text":"The web server and the database server are installed in the internal segment."},{"label":"c","text":"The web server is installed in the DMZ and the database server is installed in the internal\n segment."},{"label":"d","text":"The web server is installed in the external segment and the database server is installed in\n the DMZ."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q44)',
  ARRAY[17]::int[],
  'native_text',
  '3.0',
  'Q44. There is a network that is divided into three (3) segments, namely an external segment,
 a DMZ, and an internal segment, by one (1) firewall. In this network, a service for users is
 published on the Internet using a system comprising a web server and a database server that
 contains critical data. Which of the following is the most appropriate server installation
 method for protecting critical data from unauthorized access via the Internet? Here, the web
 server performs front end processing for the database server, and the firewall allows only a
 specific protocol for communication between the external segment and the DMZ as well as
 between the DMZ and the internal segment. Direct communication between the external
 segment and the internal segment is not allowed.

 a) The web server and the database server are installed in the DMZ.
 b) The web server and the database server are installed in the internal segment.
 c) The web server is installed in the DMZ and the database server is installed in the internal
 segment.
 d) The web server is installed in the external segment and the database server is installed in
 the DMZ.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[17]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  45,
  'Q45. Which of the following is a system or network that is intentionally made vulnerable in
 order to investigate the behavior of an intruder or malware?',
  '[{"type":"text","page":17,"bbox":[65.22,374.76,524.21,460.21],"text":"Q45.\nWhich of the following is a system or network that is intentionally made vulnerable in\norder to investigate the behavior of an intruder or malware?\n\na) Botnet\nb) DMZ\nc) Honey pot\nd) SIEM"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Botnet"},{"label":"b","text":"DMZ"},{"label":"c","text":"Honey pot"},{"label":"d","text":"SIEM"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q45)',
  ARRAY[17]::int[],
  'native_text',
  '3.0',
  'Q45. Which of the following is a system or network that is intentionally made vulnerable in
 order to investigate the behavior of an intruder or malware?

 a) Botnet b) DMZ c) Honey pot d) SIEM',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[17]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  46,
  'Q46. Among UML 2.x (including 2.0 and later versions) diagrams, which of the following is
 the most appropriate diagram that gives a graphic overview of the actors involved in a
 system, the different functions those actors need to perform, and how these different
 functions interact?',
  '[{"type":"text","page":17,"bbox":[65.22,500.76,533.11,586.21],"text":"Q46.\nAmong UML 2.x (including 2.0 and later versions) diagrams, which of the following is\nthe most appropriate diagram that gives a graphic overview of the actors involved in a\nsystem, the different functions those actors need to perform, and how these different\nfunctions interact?"},{"type":"text","page":17,"bbox":[84.12,590.93,450.1,622.21],"text":"a) Activity diagram\nb) Communication diagram\nc) Interaction overview diagram\nd) Use case diagram"},{"type":"code","page":17,"bbox":[65.22,794.63,314.58,807.97],"text":"– 17 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Activity diagram"},{"label":"b","text":"Communication diagram"},{"label":"c","text":"Interaction overview diagram"},{"label":"d","text":"Use case diagram\n\n – 17 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q46)',
  ARRAY[17]::int[],
  'native_text',
  '3.0',
  'Q46. Among UML 2.x (including 2.0 and later versions) diagrams, which of the following is
 the most appropriate diagram that gives a graphic overview of the actors involved in a
 system, the different functions those actors need to perform, and how these different
 functions interact?

 a) Activity diagram b) Communication diagram
 c) Interaction overview diagram d) Use case diagram

 – 17 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[17]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  47,
  'Q47. Which of the following is an appropriate explanation of encapsulation in object
 orientation?',
  '[{"type":"text","page":18,"bbox":[65.22,68.76,533.12,118.21],"text":"Q47.\nWhich of the following is an appropriate explanation of encapsulation in object\norientation?"},{"type":"text","page":18,"bbox":[84.12,122.93,489.02,154.21],"text":"a) Abstraction and grouping of several objects that have common properties\nb) Bundling of data and the procedures operating on the data as a single object and"},{"type":"text","page":18,"bbox":[84.12,158.93,508.62,208.21],"text":"concealment of their implementation inside the object\nc) Creation of a base class by extracting the properties that are common among classes\nd) Inheritance of the properties of a base class by a subclass"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Abstraction and grouping of several objects that have common properties"},{"label":"b","text":"Bundling of data and the procedures operating on the data as a single object and\n concealment of their implementation inside the object"},{"label":"c","text":"Creation of a base class by extracting the properties that are common among classes"},{"label":"d","text":"Inheritance of the properties of a base class by a subclass"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q47)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q47. Which of the following is an appropriate explanation of encapsulation in object
 orientation?

 a) Abstraction and grouping of several objects that have common properties
 b) Bundling of data and the procedures operating on the data as a single object and
 concealment of their implementation inside the object
 c) Creation of a base class by extracting the properties that are common among classes
 d) Inheritance of the properties of a base class by a subclass',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  48,
  'Q48. Which of the following is a technique that embeds logical expressions that hold true for
 the relations or conditions between variables at specific points in the execution of a program
 and verifies the validity of the program?',
  '[{"type":"text","page":18,"bbox":[65.22,248.76,531.92,370.21],"text":"Q48.\nWhich of the following is a technique that embeds logical expressions that hold true for\nthe relations or conditions between variables at specific points in the execution of a program\nand verifies the validity of the program?\n\na) Assertion check\nb) Code trace\nc) Snapshot dump\nd) Test coverage analysis"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Assertion check"},{"label":"b","text":"Code trace"},{"label":"c","text":"Snapshot dump"},{"label":"d","text":"Test coverage analysis"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q48)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q48. Which of the following is a technique that embeds logical expressions that hold true for
 the relations or conditions between variables at specific points in the execution of a program
 and verifies the validity of the program?

 a) Assertion check b) Code trace
 c) Snapshot dump d) Test coverage analysis',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  49,
  'Q49. Which of the following is an appropriate test type that is conducted to ensure that the
 interfaces and linkages between different software parts work properly?',
  '[{"type":"text","page":18,"bbox":[65.22,392.76,518.49,442.21],"text":"Q49.\nWhich of the following is an appropriate test type that is conducted to ensure that the\ninterfaces and linkages between different software parts work properly?"},{"type":"text","page":18,"bbox":[65.22,446.93,411.52,496.21],"text":"a) Acceptance test\nb) Functional test\nc) Integration test\nd) Performance test"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Acceptance test"},{"label":"b","text":"Functional test"},{"label":"c","text":"Integration test"},{"label":"d","text":"Performance test"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q49)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q49. Which of the following is an appropriate test type that is conducted to ensure that the
 interfaces and linkages between different software parts work properly?

 a) Acceptance test b) Functional test
 c) Integration test d) Performance test',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  50,
  'Q50. Which of the following is a software development model that repeats the development
 processes from requirements analysis to implementation?

 a) Prototyping model b) Relational model
 c) Spiral model c) Waterfall model',
  '[{"type":"text","page":18,"bbox":[65.22,500.93,524.74,622.21],"text":"Q50.\nWhich of the following is a software development model that repeats the development\nprocesses from requirements analysis to implementation?\n\na) Prototyping model\nb) Relational model\nc) Spiral model\nc) Waterfall model"}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q50)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q50. Which of the following is a software development model that repeats the development
 processes from requirements analysis to implementation?

 a) Prototyping model b) Relational model
 c) Spiral model c) Waterfall model',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  51,
  'Q51. The software reengineering process can be divided into four sub-processes: program
 modularization, program structure improvement, reverse engineering, and source code
 translation. Which of the following is a process that focuses on functional analysis and
 information extraction?',
  '[{"type":"text","page":18,"bbox":[65.22,644.76,533.11,712.21],"text":"Q51.\nThe software reengineering process can be divided into four sub-processes: program\nmodularization, program structure improvement, reverse engineering, and source code\ntranslation. Which of the following is a process that focuses on functional analysis and\ninformation extraction?"},{"type":"text","page":18,"bbox":[84.12,734.93,483.8,766.21],"text":"a) Program modularization\nb) Program structure improvement\nc) Reverse engineering\nd) Source code translation"},{"type":"code","page":18,"bbox":[65.22,794.63,314.58,807.97],"text":"– 18 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Program modularization"},{"label":"b","text":"Program structure improvement"},{"label":"c","text":"Reverse engineering"},{"label":"d","text":"Source code translation\n\n – 18 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q51)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q51. The software reengineering process can be divided into four sub-processes: program
 modularization, program structure improvement, reverse engineering, and source code
 translation. Which of the following is a process that focuses on functional analysis and
 information extraction?

 a) Program modularization b) Program structure improvement
 c) Reverse engineering d) Source code translation

 – 18 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  52,
  'Q52. Which of the following is an appropriate tool that implements a deliverable-oriented
 decomposition of a project into smaller components?',
  '[{"type":"text","page":19,"bbox":[65.22,68.76,515.23,118.21],"text":"Q52.\nWhich of the following is an appropriate tool that implements a deliverable-oriented\ndecomposition of a project into smaller components?"},{"type":"text","page":19,"bbox":[84.12,122.93,345.39,190.21],"text":"a) Critical path method (CPM)\nb) Gantt chart (Gantt)\nc) Program evaluation and review technique (PERT)\nd) Work breakdown structure (WBS)"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Critical path method (CPM)"},{"label":"b","text":"Gantt chart (Gantt)"},{"label":"c","text":"Program evaluation and review technique (PERT)"},{"label":"d","text":"Work breakdown structure (WBS)"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q52)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q52. Which of the following is an appropriate tool that implements a deliverable-oriented
 decomposition of a project into smaller components?

 a) Critical path method (CPM)
 b) Gantt chart (Gantt)
 c) Program evaluation and review technique (PERT)
 d) Work breakdown structure (WBS)',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  53,
  'Q53. Which of the following is an appropriate description of scope management?',
  '[{"type":"text","page":19,"bbox":[65.22,212.93,474.77,244.21],"text":"Q53.\nWhich of the following is an appropriate description of scope management?"},{"type":"text","page":19,"bbox":[84.12,266.93,474.51,280.21],"text":"a) The process of determining and documenting a list of all project goals, tasks,"},{"type":"text","page":19,"bbox":[84.12,284.93,529.64,316.21],"text":"deliverables, deadlines, and budgets as a part of the planning process\nb) The process of identifying, analyzing, and responding to any risk that arises over the life"},{"type":"text","page":19,"bbox":[84.12,320.93,510.65,370.21],"text":"cycle of a project to help the project remain on track and achieve its goal\nc) The process of planning, estimating, budgeting, and controlling project costs\nd) The process of wisely managing the amount of time allocated to a project in order to"},{"type":"text","page":19,"bbox":[102.12,374.93,487.37,406.21],"text":"meet the scheduled delivery date and conclude all work by or before the project\ncompletion date"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"The process of determining and documenting a list of all project goals, tasks,\n deliverables, deadlines, and budgets as a part of the planning process"},{"label":"b","text":"The process of identifying, analyzing, and responding to any risk that arises over the life\n cycle of a project to help the project remain on track and achieve its goal"},{"label":"c","text":"The process of planning, estimating, budgeting, and controlling project costs"},{"label":"d","text":"The process of wisely managing the amount of time allocated to a project in order to\n meet the scheduled delivery date and conclude all work by or before the project\n completion date"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q53)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q53. Which of the following is an appropriate description of scope management?

 a) The process of determining and documenting a list of all project goals, tasks,
 deliverables, deadlines, and budgets as a part of the planning process
 b) The process of identifying, analyzing, and responding to any risk that arises over the life
 cycle of a project to help the project remain on track and achieve its goal
 c) The process of planning, estimating, budgeting, and controlling project costs
 d) The process of wisely managing the amount of time allocated to a project in order to
 meet the scheduled delivery date and conclude all work by or before the project
 completion date',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  54,
  'Q54. When the triangular distribution formula in the three-point estimation technique is used,
 which of the following is the expected duration in days required for an activity? The
 estimates are as shown below.

 Conditions – Estimates for the duration of the activity
 Case 1: Two (2) days – if an experienced employee is assigned to this activity
 Case 2: Four (4) days – if an average employee is assigned to this activity
 Case 3: Twelve (12) days – if an inexperienced employee is assigned to this activity',
  '[{"type":"text","page":19,"bbox":[65.22,446.76,532.75,496.21],"text":"Q54.\nWhen the triangular distribution formula in the three-point estimation technique is used,\nwhich of the following is the expected duration in days required for an activity? The\nestimates are as shown below."},{"type":"text","page":19,"bbox":[87.72,517.37,355.43,530.65],"text":"Conditions – Estimates for the duration of the activity"},{"type":"text","page":19,"bbox":[87.72,536.33,476.6,549.61],"text":"Case 1: Two (2) days – if an experienced employee is assigned to this activity"},{"type":"text","page":19,"bbox":[87.72,555.35,456.65,568.63],"text":"Case 2: Four (4) days – if an average employee is assigned to this activity"},{"type":"text","page":19,"bbox":[65.22,574.85,505.94,606.13],"text":"Case 3: Twelve (12) days – if an inexperienced employee is assigned to this activity"},{"type":"text","page":19,"bbox":[65.22,611.93,464.1,661.21],"text":"a) 4\nb) 5\nc) 6\nd) 7"},{"type":"code","page":19,"bbox":[65.22,794.63,314.58,807.97],"text":"– 19 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"4"},{"label":"b","text":"5"},{"label":"c","text":"6"},{"label":"d","text":"7\n\n – 19 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q54)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q54. When the triangular distribution formula in the three-point estimation technique is used,
 which of the following is the expected duration in days required for an activity? The
 estimates are as shown below.

 Conditions – Estimates for the duration of the activity
 Case 1: Two (2) days – if an experienced employee is assigned to this activity
 Case 2: Four (4) days – if an average employee is assigned to this activity
 Case 3: Twelve (12) days – if an inexperienced employee is assigned to this activity

 a) 4 b) 5 c) 6 d) 7

 – 19 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  55,
  'Q55. The arrow diagram below shows a project’s activities and milestones. Which of the
 following is the minimum project completion time in days?

 E
 11 A G
 3 8
 D I
 7 4 4 C
 B H
 8 6
 F
 7 Legend

 Activity
 name

 Number of
 days required

 : Dummy activity',
  '[{"type":"text","page":20,"bbox":[65.22,67.74,533.18,117.3],"text":"Q55.\nThe arrow diagram below shows a project’s activities and milestones. Which of the\nfollowing is the minimum project completion time in days?"},{"type":"text","page":20,"bbox":[249.42,142.65,353.29,176.28],"text":"E\n11\nG"},{"type":"text","page":20,"bbox":[157.62,163.77,164.59,177.0],"text":"A"},{"type":"text","page":20,"bbox":[346.32,177.39,352.02,190.62],"text":"8"},{"type":"text","page":20,"bbox":[158.22,178.11,163.92,191.34],"text":"3"},{"type":"text","page":20,"bbox":[233.16,191.25,249.97,204.48],"text":"D"},{"type":"text","page":20,"bbox":[414.72,196.41,420.42,223.98],"text":"I\n4"},{"type":"text","page":20,"bbox":[238.74,205.59,244.44,218.82],"text":"7"},{"type":"text","page":20,"bbox":[196.2,215.31,215.2,228.54],"text":"4  C"},{"type":"text","page":20,"bbox":[146.76,231.03,165.13,244.26],"text":"B"},{"type":"text","page":20,"bbox":[345.06,231.03,353.29,244.26],"text":"H"},{"type":"text","page":20,"bbox":[153.12,245.37,158.82,258.6],"text":"8"},{"type":"text","page":20,"bbox":[346.32,245.37,352.02,258.6],"text":"6"},{"type":"text","page":20,"bbox":[251.64,255.69,258.61,268.92],"text":"F"},{"type":"text","page":20,"bbox":[252.3,270.03,258.0,283.26],"text":"7"},{"type":"text","page":20,"bbox":[388.38,271.77,422.58,285.0],"text":"Legend"},{"type":"text","page":20,"bbox":[449.16,294.23,485.2,304.98],"text":"Activity"},{"type":"text","page":20,"bbox":[455.58,304.19,476.07,314.94],"text":"name"},{"type":"text","page":20,"bbox":[442.74,321.95,496.36,342.66],"text":"Number of\ndays required"},{"type":"text","page":20,"bbox":[443.58,352.19,512.93,362.94],"text":": Dummy activity"},{"type":"text","page":20,"bbox":[84.12,392.93,470.1,406.21],"text":"a) 20\nb) 24\nc) 25\nd) 26"}]'::jsonb,
  '["2022-april-a-q55-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"20"},{"label":"b","text":"24"},{"label":"c","text":"25"},{"label":"d","text":"26"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q55)',
  ARRAY[20]::int[],
  'native_text',
  '3.0',
  'Q55. The arrow diagram below shows a project’s activities and milestones. Which of the
 following is the minimum project completion time in days?

 E
 11 A G
 3 8
 D I
 7 4 4 C
 B H
 8 6
 F
 7 Legend

 Activity
 name

 Number of
 days required

 : Dummy activity

 a) 20 b) 24 c) 25 d) 26',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[20]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  56,
  'Q56. IT services are provided under the conditions in the SLA shown below. What is the
 maximum number of hours of downtime in a month that can satisfy the SLA?

 [Conditions in the SLA]
 The number of business days per month is 30.
 The service hours are from 7 AM to 11 PM on business days.
 The agreed availability is 99% or more.
 Maintenance time can be ignored.',
  '[{"type":"text","page":20,"bbox":[65.22,446.76,533.05,496.21],"text":"Q56.\nIT services are provided under the conditions in the SLA shown below. What is the\nmaximum number of hours of downtime in a month that can satisfy the SLA?"},{"type":"text","page":20,"bbox":[110.7,500.93,408.55,586.21],"text":"[Conditions in the SLA]\nThe number of business days per month is 30.\nThe service hours are from 7 AM to 11 PM on business days.\nThe agreed availability is 99% or more.\nMaintenance time can be ignored."},{"type":"text","page":20,"bbox":[84.12,608.93,473.1,622.21],"text":"a) 1.2\nb) 3.0\nc) 4.8\nd) 7.2"},{"type":"code","page":20,"bbox":[65.22,794.63,314.58,807.97],"text":"– 20 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"1.2"},{"label":"b","text":"3.0"},{"label":"c","text":"4.8"},{"label":"d","text":"7.2\n\n – 20 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q56)',
  ARRAY[20]::int[],
  'native_text',
  '3.0',
  'Q56. IT services are provided under the conditions in the SLA shown below. What is the
 maximum number of hours of downtime in a month that can satisfy the SLA?

 [Conditions in the SLA]
 The number of business days per month is 30.
 The service hours are from 7 AM to 11 PM on business days.
 The agreed availability is 99% or more.
 Maintenance time can be ignored.

 a) 1.2 b) 3.0 c) 4.8 d) 7.2

 – 20 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[20]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  57,
  'Q57. In the capacity management process of IT service management, which of the following
 is an appropriate precaution to observe when the utilization of an online system’s capacity is
 monitored?',
  '[{"type":"text","page":21,"bbox":[65.22,68.76,532.7,154.21],"text":"Q57.\nIn the capacity management process of IT service management, which of the following\nis an appropriate precaution to observe when the utilization of an online system’s capacity is\nmonitored?\n\na) Focus only on the maximum value of performance data in each time interval and check"},{"type":"text","page":21,"bbox":[84.12,158.93,524.71,190.21],"text":"deviation from the management limit.\nb) Measure the performance during offline hours to avoid a decline in service level during"},{"type":"text","page":21,"bbox":[84.12,194.93,512.45,226.21],"text":"online hours.\nc) Monitor multiple measurement items such as response time and CPU utilization on a"},{"type":"text","page":21,"bbox":[65.22,230.93,372.32,280.15],"text":"regular basis.\nd) Record incidents concerning capacity and performance."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Focus only on the maximum value of performance data in each time interval and check\n deviation from the management limit."},{"label":"b","text":"Measure the performance during offline hours to avoid a decline in service level during\n online hours."},{"label":"c","text":"Monitor multiple measurement items such as response time and CPU utilization on a\n regular basis."},{"label":"d","text":"Record incidents concerning capacity and performance."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q57)',
  ARRAY[21]::int[],
  'native_text',
  '3.0',
  'Q57. In the capacity management process of IT service management, which of the following
 is an appropriate precaution to observe when the utilization of an online system’s capacity is
 monitored?

 a) Focus only on the maximum value of performance data in each time interval and check
 deviation from the management limit.
 b) Measure the performance during offline hours to avoid a decline in service level during
 online hours.
 c) Monitor multiple measurement items such as response time and CPU utilization on a
 regular basis.
 d) Record incidents concerning capacity and performance.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[21]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  58,
  'Q58. In IT service management, which of the following is the most appropriate functional
 organization that provides a single point of contact and tries to rapidly restore normal service
 operations to users?',
  '[{"type":"text","page":21,"bbox":[65.22,284.76,533.18,406.21],"text":"Q58.\nIn IT service management, which of the following is the most appropriate functional\norganization that provides a single point of contact and tries to rapidly restore normal service\noperations to users?\n\na) Service desk\nb) Service management\nc) Service provider\nd) Supplier"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Service desk"},{"label":"b","text":"Service management"},{"label":"c","text":"Service provider"},{"label":"d","text":"Supplier"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q58)',
  ARRAY[21]::int[],
  'native_text',
  '3.0',
  'Q58. In IT service management, which of the following is the most appropriate functional
 organization that provides a single point of contact and tries to rapidly restore normal service
 operations to users?

 a) Service desk b) Service management
 c) Service provider d) Supplier',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[21]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  59,
  'Q59. Which of the following is an appropriate description of a checkpoint during the audit of
 a control for reducing the risk of system trouble regarding the application of a software
 patch?',
  '[{"type":"text","page":21,"bbox":[65.22,446.76,533.15,532.21],"text":"Q59.\nWhich of the following is an appropriate description of a checkpoint during the audit of\na control for reducing the risk of system trouble regarding the application of a software\npatch?\n\na) A database administrator is appointed and master data management procedures are"},{"type":"text","page":21,"bbox":[84.12,536.93,502.29,604.21],"text":"specified.\nb) Capacity planning procedures are set out.\nc) Hardware maintenance records are created and managed by system administrators.\nd) The system’s operation status is properly checked before commencing full-time"},{"type":"text","page":21,"bbox":[65.22,608.93,158.05,658.21],"text":"operations."},{"type":"code","page":21,"bbox":[65.22,794.63,314.58,807.97],"text":"– 21 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A database administrator is appointed and master data management procedures are\n specified."},{"label":"b","text":"Capacity planning procedures are set out."},{"label":"c","text":"Hardware maintenance records are created and managed by system administrators."},{"label":"d","text":"The system’s operation status is properly checked before commencing full-time\n operations.\n\n – 21 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q59)',
  ARRAY[21]::int[],
  'native_text',
  '3.0',
  'Q59. Which of the following is an appropriate description of a checkpoint during the audit of
 a control for reducing the risk of system trouble regarding the application of a software
 patch?

 a) A database administrator is appointed and master data management procedures are
 specified.
 b) Capacity planning procedures are set out.
 c) Hardware maintenance records are created and managed by system administrators.
 d) The system’s operation status is properly checked before commencing full-time
 operations.

 – 21 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[21]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'A',
  60,
  'Q60. Which of the following is subject to system audits that evaluate and verify internal
 controls related to IT?

 a) Methods for ensuring accuracy when the sales department inputs into and updates the
 database
 b) The process by which the business planning department leads the creation of a mid-term
 business plan
 c) The results of employee personnel evaluations led by the personnel department
 d) The status of production equipment review conducted by the manufacturing department
 for the purpose of reducing defects

Q61. Which of the following is an explanation of enterprise architecture (EA)?

 a) It is a technique to abstract and express business processes with the four (4) basic
 elements of data flow, process, file, and data sources and absorption.
 b) It is a technique to analyze each business operation and information system through the
 four (4) systems of business, data, application, and technology, and reexamine it from
 the viewpoint of total optimization.
 c) It is a technique to analyze or design a system by using schematic diagrams such as a
 class diagram, and it is developed by integrating and standardizing various methods that
 support an object-oriented design.
 d) It is a technique to clarify the data structure and the relationship between data items by
 expressing the conceptual data model with entities and relationships.

Q62. When a workflow system is used for business improvement, which of the following is
 an appropriate effect that can be expected?

 a) Improved processing speed for office procedures, from document submission to
 approval
 b) The provision of a standard protocol used for data exchange between a company and its
 customers
 c) The provision of services such as a discount according to the amount of the customer’s
 purchase
 d) Warehouse automation of shipping and receipt of stocked products

 – 22 –

Q63. In computerization investment planning, which of the following is an explanation of
 ROI as an evaluation index for investment value?

 a) ROI is a measure that indicates market competitiveness in the event that a project is not
 implemented.
 b) ROI is a measure that is calculated by dividing the profit generated through factors such
 as sales increase and cost reduction by the investment amount.
 c) ROI is a measure that is calculated by subtracting the current value of cash outflow from
 the current value of cash inflow.
 d) ROI is a measure that is obtained by comparing some parameters, such as the sales to
 investment ratio and the amount of investment per employee, with that of other
 companies.

Q64. Which of the following is a description that corresponds to CSR procurement?

 a) Choosing the product with the lowest price to minimize costs
 b) Having multiple suppliers to avoid situations in which procurement is impossible, such
 as after a disaster
 c) Indicating procurement standards that consider the environment, human rights, etc., and
 requesting that suppliers comply with these
 d) Using EDI to purchase goods in order to perform prompt and accurate procurement

Q65. Which of the following is an explanation of the core competence?

 a) Corporate activities that comply with laws, various regulations, and social norms for
 managing business
 b) The business domain decided from the viewpoint of the market, technology, and
 products (or services)
 c) The overall business and system optimization methods for achieving the purpose of
 organizational activities
 d) The predominant abilities in the company’s business area, which competitors cannot
 imitate

 – 23 –

Q66. Companies are classified on the basis of their competitive position in the market.
 There are typically four types: leader, challenger, follower, and nicher. Which of the
 following is the most appropriate characteristic of a leader’s strategy?

 a) Applying a differentiation strategy to all aspects of products, services, advertising, price
 and distribution channels or indirectly attacking the competitor’s weaknesses or the gaps
 in the competitor’s market coverage
 b) Capturing a specific market that high-ranking companies do not target and concentrating
 management resources in order to secure and maintain predominance in the market
 c) Determining the challenger company’s real ability in the market and prioritize securing
 stable profits over expanding the market share by doing as the leader company does
 d) Proposing a new product and its usage method to consumers in order to increase the total
 demand while maintaining or expanding the market share

Q67. Which of the following is an explanation of the introduction stage of the product life
 cycle?

 a) It is the stage at which companies sell products to early adopters. Companies adopt
 strategies to enhance product recognition.
 b) It is the stage at which growth in demand slows. Companies try to maintain their market
 share and secure profits through various means, such as improving product quality.
 c) It is the stage at which sales and profit gradually decline. Companies refrain from
 making additional investments and consider withdrawing from the market.
 d) It is the stage at which sales increase rapidly. The market becomes active and
 competition intensifies because of new market participants.

Q68. Which of the following is the purpose of CRM?

 a) Acquisition of customer loyalty and maximization of customer lifetime value
 b) Ascertainment of the sales information for each product at the time of sales
 c) Determination of the order quantity and order timing of material requirred for
 manufacturing
 d) Reduction in loss of sales opportunities due to inventory shortage

 – 24 –

Q69. Which of the following is the appropriate description of process innovation?

 a) Development of an innovative new product on the basis of an original and high
 technology
 b) Development of innovative manufacturing procedures that improve the quality of a
 product
 c) Outsourcing manufacturing to another company that has a semiconductor manufacturing
 process
 b) Wide adoption after passing the competition, resulting in the establishment of a de facto
 standard

Q70. Basic elements and examples of devices and services when the IoT is used in a
 factory’s equipment maintenance tasks are compiled as shown below. When a) through d)
 correspond to any one of A through D, which of the following corresponds to A?

 Basic element Example of device and service
 Data collection A
 Data transmission B
 Data analysis C
 Data utilization D

 a) Abnormal value judgment tool
 b) Display for work instructions
 c) Temperature sensor for equipment
 d) Wireless communication within the factory

 – 25 –

Q71. The figure below shows the work procedure for MRP (Material Requirements
 Planning), a technique pertaining to a production management system. Which of the
 following is a necessary piece of information for calculating the net requirements to be
 inserted into A in the figure below?

 Calculation of net Calculation Calculation requirements Master Arrangement Arrangement of the order of gross schedule (Calculation of plan instructions requirements quantity the shortage)

 A

 a) Bill of materials (configuration and requirements of each component in the final
 product)
 b) Inventory status (inventory amount, residual orders, in-process quantity)
 c) Ordering policy (lot organization method, ordering method, safety stock)
 d) Standard schedule (completion period, number of days of lead time)

Q72. Which of the following is an appropriate description of an RFID system?

 a) Multiple RF Tags that are within range communicate with each other, and create a mesh
 network.
 b) RF readers/writers generate an electromagnetic field that charges the RF tags within
 range to allow transmission of information.
 c) RF tags process unique positioning information by using multiple satellites, allowing for
 item tracking by longitude and latitude coordinates.
 d) RF tag transmission does not provide error correcting codes but still acquires high
 reliability through a wired connection.

 – 26 –

Q73. Among the IoT application examples, which of the following is an explanation of
 HEMS?

 a) Connecting energy devices such as solar power generators, consumer electronic devices,
 and sensors, etc., to a household communication network in order to visualize the energy
 used and optimally control consumption
 b) Fully utilizing information communication technology and environment technology in
 order to visualize the energy urban infrastructure uses, including public facilities such as
 street-lamps and the transportation system, and optimally controlling consumption
 c) Measuring data such as vehicular condition, road status, etc., with the sensors installed
 in the vehicle and saving and analyzing the data via a network in order to support
 efficient driving
 d) Regularly measuring vibrations, temperature, sound, etc., with the sensors installed in
 factory machines, analyzing the degraded condition of the machines on the basis of the
 collected data, and replacing parts at the appropriate time

Q74. Which of the following is a case using deep learning in order to improve the
 performance of an in-car device?

 a) An accelerometer detects the collision of the vehicle against a wall and causes the air
 bag to inflate, thus protecting the passenger from injury.
 b) By acquiring and processing numerous images, the driver assistance system can more
 reliably distinguish between a pedestrian and a vehicle.
 c) By installing equipment that automatically performs idling stops, the fuel efficiency
 improves as compared with a very experienced driver operating a vehicle.
 d) The navigation system updates the software via a mobile phone line and refreshes the
 map.

 – 27 –

Q75. Which of the following is an explanation of accountability at the executive managerial
 level?

 a) A company has a responsibility to explain the content and performance of business
 activities to shareholders and other interested parties.
 b) A company quantifies the cost of environmental maintenance and its effects and
 announces them periodically as financial information.
 c) Investors and analysts must be provided with accurate information that is necessary for
 investment decisions in a timely manner and on an ongoing basis.
 d) Rules, manuals, and verification systems are established on the basis of corporate ethics,
 and corporate management is performed in accordance with the relevant laws.

Q76. Which of the following can secure employment and create employment opportunities
 across an entire society by shortening work hours per employee?

 a) Cafeteria plan b) Free agent system
 c) Work sharing d) Work-life balance

Q77. Products A, B, C, and D are to be introduced to the market. The table below shows the
 expected profit for each product with three (3) sales forecasts (High, Medium, and Low)
 that are estimated to occur in accordance with the probability in the table. Which of the
 following is the product that is expected to make the highest profit according to the
 expected value principle?

 High Medium Low
 Product Profit Probability Profit Probability Profit Probability
 ($) (%) ($) (%) ($) (%)
 A 100,000 75 20,000 20 -40,000 5
 B 130,000 60 30,000 30 -20,000 10
 C 150,000 50 40,000 30 -20,000 20
 D 100,000 70 10,000 20 -50,000 10

 a) A b) B c) C d) D

 – 28 –

Q78. A company sells two products, A and B, and makes a profit of 40 dollars and 30 dollars
 per unit on them respectively. They are produced through a common production process and
 are sold in two different markets. The production process has a total capacity of 3,000
 person-hours. Pruduct A’s production time is 3 person-hours that is three times longer than
 that of product B. Having surveyed the market, company officials feel that the maximum
 number of units of product A that can be sold is 8,000, while for product B the maximum
 number of units is 1,200. Subject to these limitations, products can be sold in any
 combination. When the linear programming model is applied, which of the following is the
 formulation result that obtains the production amount that maximizes the company’s total
 profit? Here, the number of units of products A and B are x and y, respectively.

 a) Objective function 40x+30y → to be maximized
 Constraints 3x+9y ≤ 3,000
 x ≥ 8,000
 y ≥ 1,200
 x ≥0, y ≥0

 b) Objective function 40x+30y → to be maximized
 Constraints 3x+9y ≤ 3,000
 x ≤ 8,000
 y ≤ 1,200
 x ≥ 0, y ≥0

 c) Objective function 40x+30y → to be maximized
 Constraints 3x+y ≤ 3,000
 x ≥ 8,000
 y ≥ 1,200
 x ≥0, y ≥0

 d) Objective function 40x+30y → to be maximized
 Constraints 3x+y ≤ 3,000
 x ≤ 8,000
 y ≤ 1,200
 x ≥ 0, y ≥0

 – 29 –

Q79. In financial statements, which of the following shows the company’s assets, liabilities,
 and net assets at a certain point in time and indicates the company’s financial situation?

 a) Balance sheet b) Statement of cash flows
 c) Statement of changes in equity d) Statement of profit or loss

Q80. Which of the following is an action that is taken in order to improve the cash flow?',
  '[{"type":"text","page":22,"bbox":[65.22,68.76,515.56,136.21],"text":"Q60.\nWhich of the following is subject to system audits that evaluate and verify internal\ncontrols related to IT?\n\na) Methods for ensuring accuracy when the sales department inputs into and updates the"},{"type":"text","page":22,"bbox":[84.12,140.93,529.32,172.21],"text":"database\nb) The process by which the business planning department leads the creation of a mid-term"},{"type":"text","page":22,"bbox":[84.12,176.93,526.3,226.21],"text":"business plan\nc) The results of employee personnel evaluations led by the personnel department\nd) The status of production equipment review conducted by the manufacturing department"},{"type":"text","page":22,"bbox":[102.12,230.93,272.74,244.21],"text":"for the purpose of reducing defects"},{"type":"text","page":22,"bbox":[65.22,266.93,462.04,297.19],"text":"Q61.\nWhich of the following is an explanation of enterprise architecture (EA)?"},{"type":"text","page":22,"bbox":[84.12,302.93,495.73,334.21],"text":"a) It is a technique to abstract and express business processes with the four (4) basic"},{"type":"text","page":22,"bbox":[84.12,338.93,524.71,370.21],"text":"elements of data flow, process, file, and data sources and absorption.\nb) It is a technique to analyze each business operation and information system through the"},{"type":"text","page":22,"bbox":[84.12,374.93,517.14,424.21],"text":"four (4) systems of business, data, application, and technology, and reexamine it from\nthe viewpoint of total optimization.\nc) It is a technique to analyze or design a system by using schematic diagrams such as a"},{"type":"text","page":22,"bbox":[84.12,428.93,527.98,478.21],"text":"class diagram, and it is developed by integrating and standardizing various methods that\nsupport an object-oriented design.\nd) It is a technique to clarify the data structure and the relationship between data items by"},{"type":"text","page":22,"bbox":[65.22,482.93,523.56,604.21],"text":"expressing the conceptual data model with entities and relationships.\n\n\nQ62.\nWhen a workflow system is used for business improvement, which of the following is\nan appropriate effect that can be expected?\n\na) Improved processing speed for office procedures, from document submission to"},{"type":"text","page":22,"bbox":[84.12,608.93,526.24,640.21],"text":"approval\nb) The provision of a standard protocol used for data exchange between a company and its"},{"type":"text","page":22,"bbox":[84.12,644.93,522.3,676.21],"text":"customers\nc) The provision of services such as a discount according to the amount of the customer’s"},{"type":"text","page":22,"bbox":[65.22,680.93,432.43,747.13],"text":"purchase\nd) Warehouse automation of shipping and receipt of stocked products"},{"type":"code","page":22,"bbox":[65.22,794.63,314.58,807.97],"text":"– 22 –"},{"type":"text","page":23,"bbox":[65.22,68.76,525.38,136.21],"text":"Q63.\nIn computerization investment planning, which of the following is an explanation of\nROI as an evaluation index for investment value?\n\na) ROI is a measure that indicates market competitiveness in the event that a project is not"},{"type":"text","page":23,"bbox":[84.12,140.93,527.73,172.21],"text":"implemented.\nb) ROI is a measure that is calculated by dividing the profit generated through factors such"},{"type":"text","page":23,"bbox":[84.12,176.93,530.69,208.21],"text":"as sales increase and cost reduction by the investment amount.\nc) ROI is a measure that is calculated by subtracting the current value of cash outflow from"},{"type":"text","page":23,"bbox":[84.12,212.93,515.09,244.21],"text":"the current value of cash inflow.\nd) ROI is a measure that is obtained by comparing some parameters, such as the sales to"},{"type":"text","page":23,"bbox":[102.12,248.93,485.32,280.21],"text":"investment ratio and the amount of investment per employee, with that of other\ncompanies."},{"type":"text","page":23,"bbox":[65.22,302.93,487.12,333.19],"text":"Q64.\nWhich of the following is a description that corresponds to CSR procurement?"},{"type":"text","page":23,"bbox":[84.12,338.93,523.02,388.21],"text":"a) Choosing the product with the lowest price to minimize costs\nb) Having multiple suppliers to avoid situations in which procurement is impossible, such"},{"type":"text","page":23,"bbox":[84.12,392.93,526.95,424.21],"text":"as after a disaster\nc) Indicating procurement standards that consider the environment, human rights, etc., and"},{"type":"text","page":23,"bbox":[65.22,428.93,505.68,513.19],"text":"requesting that suppliers comply with these\nd) Using EDI to purchase goods in order to perform prompt and accurate procurement\n\n\nQ65.\nWhich of the following is an explanation of the core competence?"},{"type":"text","page":23,"bbox":[84.12,536.76,510.7,550.21],"text":"a) Corporate activities that comply with laws, various regulations, and social norms for"},{"type":"text","page":23,"bbox":[84.12,554.93,491.32,586.21],"text":"managing business\nb) The business domain decided from the viewpoint of the market, technology, and"},{"type":"text","page":23,"bbox":[84.12,590.93,506.12,622.21],"text":"products (or services)\nc) The overall business and system optimization methods for achieving the purpose of"},{"type":"text","page":23,"bbox":[84.12,626.93,510.83,658.21],"text":"organizational activities\nd) The predominant abilities in the company’s business area, which competitors cannot"},{"type":"text","page":23,"bbox":[102.12,662.93,138.4,676.21],"text":"imitate"},{"type":"code","page":23,"bbox":[65.22,794.63,314.58,807.97],"text":"– 23 –"},{"type":"text","page":24,"bbox":[65.22,68.76,504.45,136.21],"text":"Q66.\nCompanies are classified on the basis of their competitive position in the market.\nThere are typically four types: leader, challenger, follower, and nicher. Which of the\nfollowing is the most appropriate characteristic of a leader’s strategy?"},{"type":"text","page":24,"bbox":[84.12,140.76,527.64,154.21],"text":"a) Applying a differentiation strategy to all aspects of products, services, advertising, price"},{"type":"text","page":24,"bbox":[84.12,158.93,530.72,208.21],"text":"and distribution channels or indirectly attacking the competitor’s weaknesses or the gaps\nin the competitor’s market coverage\nb) Capturing a specific market that high-ranking companies do not target and concentrating"},{"type":"text","page":24,"bbox":[84.12,212.93,524.01,244.21],"text":"management resources in order to secure and maintain predominance in the market\nc) Determining the challenger company’s real ability in the market and prioritize securing"},{"type":"text","page":24,"bbox":[84.12,248.93,532.71,280.21],"text":"stable profits over expanding the market share by doing as the leader company does\nd) Proposing a new product and its usage method to consumers in order to increase the total"},{"type":"text","page":24,"bbox":[65.22,284.93,516.02,388.21],"text":"demand while maintaining or expanding the market share\n\n\nQ67.\nWhich of the following is an explanation of the introduction stage of the product life\ncycle?"},{"type":"text","page":24,"bbox":[84.12,392.93,503.67,406.21],"text":"a) It is the stage at which companies sell products to early adopters. Companies adopt"},{"type":"text","page":24,"bbox":[84.12,410.93,528.45,442.21],"text":"strategies to enhance product recognition.\nb) It is the stage at which growth in demand slows. Companies try to maintain their market"},{"type":"text","page":24,"bbox":[84.12,446.93,504.05,478.21],"text":"share and secure profits through various means, such as improving product quality.\nc) It is the stage at which sales and profit gradually decline. Companies refrain from"},{"type":"text","page":24,"bbox":[84.12,482.93,476.46,514.21],"text":"making additional investments and consider withdrawing from the market.\nd) It is the stage at which sales increase rapidly. The market becomes active and"},{"type":"text","page":24,"bbox":[102.12,518.93,389.93,532.21],"text":"competition intensifies because of new market participants."},{"type":"text","page":24,"bbox":[65.22,554.93,340.19,604.21],"text":"Q68.\nWhich of the following is the purpose of CRM?"},{"type":"text","page":24,"bbox":[84.12,608.93,478.08,658.21],"text":"a) Acquisition of customer loyalty and maximization of customer lifetime value\nb) Ascertainment of the sales information for each product at the time of sales\nc) Determination of the order quantity and order timing of material requirred for"},{"type":"text","page":24,"bbox":[65.22,662.93,419.52,730.21],"text":"manufacturing\nd) Reduction in loss of sales opportunities due to inventory shortage"},{"type":"code","page":24,"bbox":[65.22,794.63,314.58,807.97],"text":"– 24 –"},{"type":"text","page":25,"bbox":[65.22,68.76,484.49,82.21],"text":"Q69.\nWhich of the following is the appropriate description of process innovation?"},{"type":"text","page":25,"bbox":[84.12,104.93,485.29,118.21],"text":"a) Development of an innovative new product on the basis of an original and high"},{"type":"text","page":25,"bbox":[84.12,122.93,504.47,154.21],"text":"technology\nb) Development of innovative manufacturing procedures that improve the quality of a"},{"type":"text","page":25,"bbox":[84.12,158.93,530.69,190.21],"text":"product\nc) Outsourcing manufacturing to another company that has a semiconductor manufacturing"},{"type":"text","page":25,"bbox":[84.12,194.93,527.74,226.21],"text":"process\nb) Wide adoption after passing the competition, resulting in the establishment of a de facto"},{"type":"text","page":25,"bbox":[84.12,230.93,145.8,262.21],"text":"standard"},{"type":"text","page":25,"bbox":[65.22,284.76,520.93,352.21],"text":"Q70.\nBasic elements and examples of devices and services when the IoT is used in a\nfactory’s equipment maintenance tasks are compiled as shown below. When a) through d)\ncorrespond to any one of A through D, which of the following corresponds to A?"},{"type":"table","page":25,"bbox":[152.52,353.46,442.8,447.42],"rows":[["Basic element","Example of device and service"],["Data collection","A"],["Data transmission","B"],["Data analysis","C"],["Data utilization","D"]]},{"type":"text","page":25,"bbox":[171.24,357.65,426.83,370.93],"text":"Basic element\nExample of device and service"},{"type":"text","page":25,"bbox":[157.98,376.43,356.82,389.71],"text":"Data collection\nA"},{"type":"text","page":25,"bbox":[157.98,395.15,356.82,408.43],"text":"Data transmission\nB"},{"type":"text","page":25,"bbox":[157.98,413.93,357.18,427.21],"text":"Data analysis\nC"},{"type":"text","page":25,"bbox":[157.98,432.65,357.48,445.93],"text":"Data utilization\nD"},{"type":"text","page":25,"bbox":[65.22,451.43,319.02,589.63],"text":"a) Abnormal value judgment tool\nb) Display for work instructions\nc) Temperature sensor for equipment\nd) Wireless communication within the factory"},{"type":"code","page":25,"bbox":[65.22,794.63,314.58,807.97],"text":"– 25 –"},{"type":"text","page":26,"bbox":[65.22,68.76,505.72,153.13],"text":"Q71.\nThe figure below shows the work procedure for MRP (Material Requirements\nPlanning), a technique pertaining to a production management system. Which of the\nfollowing is a necessary piece of information for calculating the net requirements to be\ninserted into A in the figure below?"},{"type":"text","page":26,"bbox":[242.1,184.35,308.68,194.15],"text":"Calculation of net"},{"type":"text","page":26,"bbox":[327.48,187.77,371.58,206.39],"text":"Calculation\nof the order"},{"type":"text","page":26,"bbox":[177.78,188.61,221.12,198.41],"text":"Calculation"},{"type":"text","page":26,"bbox":[117.9,193.17,149.55,211.85],"text":"Master\nschedule"},{"type":"text","page":26,"bbox":[247.2,193.17,303.27,211.85],"text":"requirements\n(Calculation of"},{"type":"text","page":26,"bbox":[392.46,193.29,439.84,203.09],"text":"Arrangement"},{"type":"text","page":26,"bbox":[461.4,193.65,508.77,203.45],"text":"Arrangement"},{"type":"text","page":26,"bbox":[175.02,197.49,221.9,216.11],"text":"of gross\nrequirements"},{"type":"text","page":26,"bbox":[408.42,202.11,424.13,211.91],"text":"plan"},{"type":"text","page":26,"bbox":[464.16,202.47,505.76,212.27],"text":"instructions"},{"type":"text","page":26,"bbox":[333.72,205.47,362.87,215.27],"text":"quantity"},{"type":"text","page":26,"bbox":[250.92,210.87,297.53,220.67],"text":"the shortage)"},{"type":"text","page":26,"bbox":[271.26,238.83,276.74,248.63],"text":"A"},{"type":"text","page":26,"bbox":[84.12,284.93,490.06,298.21],"text":"a) Bill of materials (configuration and requirements of each component in the final"},{"type":"text","page":26,"bbox":[84.12,302.93,467.64,370.21],"text":"product)\nb) Inventory status (inventory amount, residual orders, in-process quantity)\nc) Ordering policy (lot organization method, ordering method, safety stock)\nd) Standard schedule (completion period, number of days of lead time)"},{"type":"text","page":26,"bbox":[65.22,409.74,461.13,423.19],"text":"Q72.\nWhich of the following is an appropriate description of an RFID system?"},{"type":"text","page":26,"bbox":[84.12,446.93,528.62,460.21],"text":"a) Multiple RF Tags that are within range communicate with each other, and create a mesh"},{"type":"text","page":26,"bbox":[84.12,464.93,508.7,496.21],"text":"network.\nb) RF readers/writers generate an electromagnetic field that charges the RF tags within"},{"type":"text","page":26,"bbox":[84.12,500.93,530.47,532.21],"text":"range to allow transmission of information.\nc) RF tags process unique positioning information by using multiple satellites, allowing for"},{"type":"text","page":26,"bbox":[84.12,536.93,499.12,568.21],"text":"item tracking by longitude and latitude coordinates.\nd) RF tag transmission does not provide error correcting codes but still acquires high"},{"type":"text","page":26,"bbox":[102.12,572.93,295.45,586.21],"text":"reliability through a wired connection."},{"type":"code","page":26,"bbox":[65.22,794.63,314.58,807.97],"text":"– 26 –"},{"type":"text","page":27,"bbox":[65.22,68.76,533.1,136.21],"text":"Q73.\nAmong the IoT application examples, which of the following is an explanation of\nHEMS?\n\na) Connecting energy devices such as solar power generators, consumer electronic devices,"},{"type":"text","page":27,"bbox":[84.12,140.93,531.67,190.21],"text":"and sensors, etc., to a household communication network in order to visualize the energy\nused and optimally control consumption\nb) Fully utilizing information communication technology and environment technology in"},{"type":"text","page":27,"bbox":[84.12,194.93,530.06,244.21],"text":"order to visualize the energy urban infrastructure uses, including public facilities such as\nstreet-lamps and the transportation system, and optimally controlling consumption\nc) Measuring data such as vehicular condition, road status, etc., with the sensors installed"},{"type":"text","page":27,"bbox":[84.12,248.93,516.73,298.21],"text":"in the vehicle and saving and analyzing the data via a network in order to support\nefficient driving\nd) Regularly measuring vibrations, temperature, sound, etc., with the sensors installed in"},{"type":"text","page":27,"bbox":[65.22,302.93,522.3,352.21],"text":"factory machines, analyzing the degraded condition of the machines on the basis of the\ncollected data, and replacing parts at the appropriate time"},{"type":"text","page":27,"bbox":[65.22,374.76,476.15,406.21],"text":"Q74.\nWhich of the following is a case using deep learning in order to improve the\nperformance of an in-car device?"},{"type":"text","page":27,"bbox":[84.12,410.93,513.73,442.21],"text":"a) An accelerometer detects the collision of the vehicle against a wall and causes the air"},{"type":"text","page":27,"bbox":[84.12,446.93,516.4,478.21],"text":"bag to inflate, thus protecting the passenger from injury.\nb) By acquiring and processing numerous images, the driver assistance system can more"},{"type":"text","page":27,"bbox":[84.12,482.93,508.11,514.21],"text":"reliably distinguish between a pedestrian and a vehicle.\nc) By installing equipment that automatically performs idling stops, the fuel efficiency"},{"type":"text","page":27,"bbox":[84.12,518.93,515.31,550.21],"text":"improves as compared with a very experienced driver operating a vehicle.\nd) The navigation system updates the software via a mobile phone line and refreshes the"},{"type":"text","page":27,"bbox":[102.12,554.93,128.76,568.21],"text":"map."},{"type":"code","page":27,"bbox":[65.22,794.63,314.58,807.97],"text":"– 27 –"},{"type":"text","page":28,"bbox":[65.22,68.76,525.48,136.21],"text":"Q75.\nWhich of the following is an explanation of accountability at the executive managerial\nlevel?\n\na) A company has a responsibility to explain the content and performance of business"},{"type":"text","page":28,"bbox":[84.12,140.93,489.95,172.21],"text":"activities to shareholders and other interested parties.\nb) A company quantifies the cost of environmental maintenance and its effects and"},{"type":"text","page":28,"bbox":[84.12,176.93,523.03,208.21],"text":"announces them periodically as financial information.\nc) Investors and analysts must be provided with accurate information that is necessary for"},{"type":"text","page":28,"bbox":[84.12,212.93,530.04,244.21],"text":"investment decisions in a timely manner and on an ongoing basis.\nd) Rules, manuals, and verification systems are established on the basis of corporate ethics,"},{"type":"text","page":28,"bbox":[102.12,248.93,485.94,262.21],"text":"and corporate management is performed in accordance with the relevant laws."},{"type":"text","page":28,"bbox":[65.22,284.93,525.79,442.21],"text":"Q76.\nWhich of the following can secure employment and create employment opportunities\nacross an entire society by shortening work hours per employee?\n\na) Cafeteria plan\nb) Free agent system\nc) Work sharing\nd) Work-life balance\n\n\nQ77.   Products A, B, C, and D are to be introduced to the market. The table below shows the"},{"type":"text","page":28,"bbox":[65.22,446.93,512.9,531.13],"text":"expected profit for each product with three (3) sales forecasts (High, Medium, and Low)\nthat are estimated to occur in accordance with the probability in the table. Which of the\nfollowing is the product that is expected to make the highest profit according to the\nexpected value principle?"},{"type":"table","page":28,"bbox":[77.79,533.34,514.89,662.49],"rows":[["Product","High",null,"Medium",null,"Low",null],[null,"Profit\n($)","Probability\n(%)","Profit\n($)","Probability\n(%)","Profit\n($)","Probability\n(%)"],["A","100,000","75","20,000","20","-40,000","5"],["B","130,000","60","30,000","30","-20,000","10"],["C","150,000","50","40,000","30","-20,000","20"],["D","100,000","70","10,000","20","-50,000","10"]]},{"type":"text","page":28,"bbox":[178.92,536.33,463.59,549.61],"text":"High\nMedium\nLow"},{"type":"text","page":28,"bbox":[83.34,554.57,123.63,567.85],"text":"Product"},{"type":"text","page":28,"bbox":[145.14,554.81,175.5,568.09],"text":"Profit"},{"type":"text","page":28,"bbox":[196.92,554.81,253.27,568.09],"text":"Probability"},{"type":"text","page":28,"bbox":[274.2,554.81,304.56,568.09],"text":"Profit"},{"type":"text","page":28,"bbox":[325.5,554.81,381.85,568.09],"text":"Probability"},{"type":"text","page":28,"bbox":[403.74,554.81,434.1,568.09],"text":"Profit"},{"type":"text","page":28,"bbox":[456.12,554.81,512.47,568.09],"text":"Probability"},{"type":"text","page":28,"bbox":[151.86,572.81,168.82,586.09],"text":"($)"},{"type":"text","page":28,"bbox":[214.56,572.81,235.56,586.09],"text":"(%)"},{"type":"text","page":28,"bbox":[280.86,572.81,297.82,586.09],"text":"($)"},{"type":"text","page":28,"bbox":[343.14,572.81,364.14,586.09],"text":"(%)"},{"type":"text","page":28,"bbox":[410.46,572.81,427.42,586.09],"text":"($)"},{"type":"text","page":28,"bbox":[473.76,572.81,494.76,586.09],"text":"(%)"},{"type":"text","page":28,"bbox":[83.22,591.35,488.77,604.63],"text":"A\n100,000\n75\n20,000\n20\n-40,000\n5"},{"type":"text","page":28,"bbox":[83.22,609.83,491.77,623.11],"text":"B\n130,000\n60\n30,000\n30\n-20,000\n10"},{"type":"text","page":28,"bbox":[83.22,628.31,491.77,641.59],"text":"C\n150,000\n50\n40,000\n30\n-20,000\n20"},{"type":"text","page":28,"bbox":[83.22,646.85,491.77,660.13],"text":"D\n100,000\n70\n10,000\n20\n-50,000\n10"},{"type":"text","page":28,"bbox":[65.22,684.41,466.74,715.69],"text":"a) A\nb) B\nc) C\nd) D"},{"type":"code","page":28,"bbox":[65.22,794.63,314.58,807.97],"text":"– 28 –"},{"type":"text","page":29,"bbox":[65.22,68.76,532.61,262.21],"text":"Q78.\nA company sells two products, A and B, and makes a profit of 40 dollars and 30 dollars\nper unit on them respectively. They are produced through a common production process and\nare sold in two different markets. The production process has a total capacity of 3,000\nperson-hours. Pruduct A’s production time is 3 person-hours that is three times longer than\nthat of product B. Having surveyed the market, company officials feel that the maximum\nnumber of units of product A that can be sold is 8,000, while for product B the maximum\nnumber of units is 1,200. Subject to these limitations, products can be sold in any\ncombination. When the linear programming model is applied, which of the following is the\nformulation result that obtains the production amount that maximizes the company’s total\nprofit? Here, the number of units of products A and B are x and y, respectively."},{"type":"text","page":29,"bbox":[125.64,265.31,405.25,280.21],"text":"a)\nObjective function  40x+30y → to be maximized"},{"type":"text","page":29,"bbox":[125.64,283.31,332.16,299.59],"text":"Constraints  3x+9y ≤ 3,000"},{"type":"text","page":29,"bbox":[125.64,302.93,405.16,388.21],"text":"x ≥ 8,000\n\n\ny ≥ 1,200\n\n\nx ≥0,  y ≥0\n\n\n\nb)\nObjective function  40x+30y → to be maximized"},{"type":"text","page":29,"bbox":[125.64,391.31,329.4,406.21],"text":"Constraints  3x+9y ≤ 3,000"},{"type":"text","page":29,"bbox":[125.64,410.93,405.16,496.21],"text":"x ≤ 8,000\n\n\ny ≤ 1,200\n\n\nx ≥ 0,  y ≥0\n\n\n\nc)\nObjective function  40x+30y → to be maximized"},{"type":"text","page":29,"bbox":[125.64,499.31,323.4,514.21],"text":"Constraints  3x+y ≤ 3,000"},{"type":"text","page":29,"bbox":[125.64,518.93,405.25,604.21],"text":"x ≥ 8,000\n\n\ny ≥ 1,200\n\n\nx ≥0,  y ≥0\n\n\n\nd)\nObjective function  40x+30y → to be maximized"},{"type":"text","page":29,"bbox":[125.64,607.31,326.64,622.21],"text":"Constraints  3x+y ≤  3,000"},{"type":"text","page":29,"bbox":[97.8,626.93,336.0,694.15],"text":"x ≤ 8,000\n\n\ny ≤ 1,200\n\n\nx ≥ 0,  y ≥0"},{"type":"code","page":29,"bbox":[65.22,794.63,314.58,807.97],"text":"– 29 –"},{"type":"text","page":30,"bbox":[65.22,68.76,525.55,118.21],"text":"Q79.\nIn financial statements, which of the following shows the company’s assets, liabilities,\nand net assets at a certain point in time and indicates the company’s financial situation?"},{"type":"text","page":30,"bbox":[65.22,122.93,509.33,207.19],"text":"a) Balance sheet\nb) Statement of cash flows\nc) Statement of changes in equity\nd) Statement of profit or loss\n\n\nQ80.\nWhich of the following is an action that is taken in order to improve the cash flow?"},{"type":"text","page":30,"bbox":[65.22,212.93,426.29,334.21],"text":"a) Pay the notes payable on a shorter timeline.\nb) Receive payment on the notes receivable on a longer timeline.\nc) Shorten the time period for collecting accounts receivable.\nd) Shorten the time period for making payments on accounts payable."},{"type":"code","page":30,"bbox":[65.22,794.63,314.58,807.97],"text":"– 30 –"}]'::jsonb,
  '["2022-april-a-q60-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Pay the notes payable on a shorter timeline."},{"label":"b","text":"Receive payment on the notes receivable on a longer timeline."},{"label":"c","text":"Shorten the time period for collecting accounts receivable."},{"label":"d","text":"Shorten the time period for making payments on accounts payable.\n\n – 30 –"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-A, Q60)',
  ARRAY[22,23,24,25,26,27,28,29,30]::int[],
  'native_text',
  '3.0',
  'Q60. Which of the following is subject to system audits that evaluate and verify internal
 controls related to IT?

 a) Methods for ensuring accuracy when the sales department inputs into and updates the
 database
 b) The process by which the business planning department leads the creation of a mid-term
 business plan
 c) The results of employee personnel evaluations led by the personnel department
 d) The status of production equipment review conducted by the manufacturing department
 for the purpose of reducing defects

Q61. Which of the following is an explanation of enterprise architecture (EA)?

 a) It is a technique to abstract and express business processes with the four (4) basic
 elements of data flow, process, file, and data sources and absorption.
 b) It is a technique to analyze each business operation and information system through the
 four (4) systems of business, data, application, and technology, and reexamine it from
 the viewpoint of total optimization.
 c) It is a technique to analyze or design a system by using schematic diagrams such as a
 class diagram, and it is developed by integrating and standardizing various methods that
 support an object-oriented design.
 d) It is a technique to clarify the data structure and the relationship between data items by
 expressing the conceptual data model with entities and relationships.

Q62. When a workflow system is used for business improvement, which of the following is
 an appropriate effect that can be expected?

 a) Improved processing speed for office procedures, from document submission to
 approval
 b) The provision of a standard protocol used for data exchange between a company and its
 customers
 c) The provision of services such as a discount according to the amount of the customer’s
 purchase
 d) Warehouse automation of shipping and receipt of stocked products

 – 22 –

Q63. In computerization investment planning, which of the following is an explanation of
 ROI as an evaluation index for investment value?

 a) ROI is a measure that indicates market competitiveness in the event that a project is not
 implemented.
 b) ROI is a measure that is calculated by dividing the profit generated through factors such
 as sales increase and cost reduction by the investment amount.
 c) ROI is a measure that is calculated by subtracting the current value of cash outflow from
 the current value of cash inflow.
 d) ROI is a measure that is obtained by comparing some parameters, such as the sales to
 investment ratio and the amount of investment per employee, with that of other
 companies.

Q64. Which of the following is a description that corresponds to CSR procurement?

 a) Choosing the product with the lowest price to minimize costs
 b) Having multiple suppliers to avoid situations in which procurement is impossible, such
 as after a disaster
 c) Indicating procurement standards that consider the environment, human rights, etc., and
 requesting that suppliers comply with these
 d) Using EDI to purchase goods in order to perform prompt and accurate procurement

Q65. Which of the following is an explanation of the core competence?

 a) Corporate activities that comply with laws, various regulations, and social norms for
 managing business
 b) The business domain decided from the viewpoint of the market, technology, and
 products (or services)
 c) The overall business and system optimization methods for achieving the purpose of
 organizational activities
 d) The predominant abilities in the company’s business area, which competitors cannot
 imitate

 – 23 –

Q66. Companies are classified on the basis of their competitive position in the market.
 There are typically four types: leader, challenger, follower, and nicher. Which of the
 following is the most appropriate characteristic of a leader’s strategy?

 a) Applying a differentiation strategy to all aspects of products, services, advertising, price
 and distribution channels or indirectly attacking the competitor’s weaknesses or the gaps
 in the competitor’s market coverage
 b) Capturing a specific market that high-ranking companies do not target and concentrating
 management resources in order to secure and maintain predominance in the market
 c) Determining the challenger company’s real ability in the market and prioritize securing
 stable profits over expanding the market share by doing as the leader company does
 d) Proposing a new product and its usage method to consumers in order to increase the total
 demand while maintaining or expanding the market share

Q67. Which of the following is an explanation of the introduction stage of the product life
 cycle?

 a) It is the stage at which companies sell products to early adopters. Companies adopt
 strategies to enhance product recognition.
 b) It is the stage at which growth in demand slows. Companies try to maintain their market
 share and secure profits through various means, such as improving product quality.
 c) It is the stage at which sales and profit gradually decline. Companies refrain from
 making additional investments and consider withdrawing from the market.
 d) It is the stage at which sales increase rapidly. The market becomes active and
 competition intensifies because of new market participants.

Q68. Which of the following is the purpose of CRM?

 a) Acquisition of customer loyalty and maximization of customer lifetime value
 b) Ascertainment of the sales information for each product at the time of sales
 c) Determination of the order quantity and order timing of material requirred for
 manufacturing
 d) Reduction in loss of sales opportunities due to inventory shortage

 – 24 –

Q69. Which of the following is the appropriate description of process innovation?

 a) Development of an innovative new product on the basis of an original and high
 technology
 b) Development of innovative manufacturing procedures that improve the quality of a
 product
 c) Outsourcing manufacturing to another company that has a semiconductor manufacturing
 process
 b) Wide adoption after passing the competition, resulting in the establishment of a de facto
 standard

Q70. Basic elements and examples of devices and services when the IoT is used in a
 factory’s equipment maintenance tasks are compiled as shown below. When a) through d)
 correspond to any one of A through D, which of the following corresponds to A?

 Basic element Example of device and service
 Data collection A
 Data transmission B
 Data analysis C
 Data utilization D

 a) Abnormal value judgment tool
 b) Display for work instructions
 c) Temperature sensor for equipment
 d) Wireless communication within the factory

 – 25 –

Q71. The figure below shows the work procedure for MRP (Material Requirements
 Planning), a technique pertaining to a production management system. Which of the
 following is a necessary piece of information for calculating the net requirements to be
 inserted into A in the figure below?

 Calculation of net Calculation Calculation requirements Master Arrangement Arrangement of the order of gross schedule (Calculation of plan instructions requirements quantity the shortage)

 A

 a) Bill of materials (configuration and requirements of each component in the final
 product)
 b) Inventory status (inventory amount, residual orders, in-process quantity)
 c) Ordering policy (lot organization method, ordering method, safety stock)
 d) Standard schedule (completion period, number of days of lead time)

Q72. Which of the following is an appropriate description of an RFID system?

 a) Multiple RF Tags that are within range communicate with each other, and create a mesh
 network.
 b) RF readers/writers generate an electromagnetic field that charges the RF tags within
 range to allow transmission of information.
 c) RF tags process unique positioning information by using multiple satellites, allowing for
 item tracking by longitude and latitude coordinates.
 d) RF tag transmission does not provide error correcting codes but still acquires high
 reliability through a wired connection.

 – 26 –

Q73. Among the IoT application examples, which of the following is an explanation of
 HEMS?

 a) Connecting energy devices such as solar power generators, consumer electronic devices,
 and sensors, etc., to a household communication network in order to visualize the energy
 used and optimally control consumption
 b) Fully utilizing information communication technology and environment technology in
 order to visualize the energy urban infrastructure uses, including public facilities such as
 street-lamps and the transportation system, and optimally controlling consumption
 c) Measuring data such as vehicular condition, road status, etc., with the sensors installed
 in the vehicle and saving and analyzing the data via a network in order to support
 efficient driving
 d) Regularly measuring vibrations, temperature, sound, etc., with the sensors installed in
 factory machines, analyzing the degraded condition of the machines on the basis of the
 collected data, and replacing parts at the appropriate time

Q74. Which of the following is a case using deep learning in order to improve the
 performance of an in-car device?

 a) An accelerometer detects the collision of the vehicle against a wall and causes the air
 bag to inflate, thus protecting the passenger from injury.
 b) By acquiring and processing numerous images, the driver assistance system can more
 reliably distinguish between a pedestrian and a vehicle.
 c) By installing equipment that automatically performs idling stops, the fuel efficiency
 improves as compared with a very experienced driver operating a vehicle.
 d) The navigation system updates the software via a mobile phone line and refreshes the
 map.

 – 27 –

Q75. Which of the following is an explanation of accountability at the executive managerial
 level?

 a) A company has a responsibility to explain the content and performance of business
 activities to shareholders and other interested parties.
 b) A company quantifies the cost of environmental maintenance and its effects and
 announces them periodically as financial information.
 c) Investors and analysts must be provided with accurate information that is necessary for
 investment decisions in a timely manner and on an ongoing basis.
 d) Rules, manuals, and verification systems are established on the basis of corporate ethics,
 and corporate management is performed in accordance with the relevant laws.

Q76. Which of the following can secure employment and create employment opportunities
 across an entire society by shortening work hours per employee?

 a) Cafeteria plan b) Free agent system
 c) Work sharing d) Work-life balance

Q77. Products A, B, C, and D are to be introduced to the market. The table below shows the
 expected profit for each product with three (3) sales forecasts (High, Medium, and Low)
 that are estimated to occur in accordance with the probability in the table. Which of the
 following is the product that is expected to make the highest profit according to the
 expected value principle?

 High Medium Low
 Product Profit Probability Profit Probability Profit Probability
 ($) (%) ($) (%) ($) (%)
 A 100,000 75 20,000 20 -40,000 5
 B 130,000 60 30,000 30 -20,000 10
 C 150,000 50 40,000 30 -20,000 20
 D 100,000 70 10,000 20 -50,000 10

 a) A b) B c) C d) D

 – 28 –

Q78. A company sells two products, A and B, and makes a profit of 40 dollars and 30 dollars
 per unit on them respectively. They are produced through a common production process and
 are sold in two different markets. The production process has a total capacity of 3,000
 person-hours. Pruduct A’s production time is 3 person-hours that is three times longer than
 that of product B. Having surveyed the market, company officials feel that the maximum
 number of units of product A that can be sold is 8,000, while for product B the maximum
 number of units is 1,200. Subject to these limitations, products can be sold in any
 combination. When the linear programming model is applied, which of the following is the
 formulation result that obtains the production amount that maximizes the company’s total
 profit? Here, the number of units of products A and B are x and y, respectively.

 a) Objective function 40x+30y → to be maximized
 Constraints 3x+9y ≤ 3,000
 x ≥ 8,000
 y ≥ 1,200
 x ≥0, y ≥0

 b) Objective function 40x+30y → to be maximized
 Constraints 3x+9y ≤ 3,000
 x ≤ 8,000
 y ≤ 1,200
 x ≥ 0, y ≥0

 c) Objective function 40x+30y → to be maximized
 Constraints 3x+y ≤ 3,000
 x ≥ 8,000
 y ≥ 1,200
 x ≥0, y ≥0

 d) Objective function 40x+30y → to be maximized
 Constraints 3x+y ≤ 3,000
 x ≤ 8,000
 y ≤ 1,200
 x ≥ 0, y ≥0

 – 29 –

Q79. In financial statements, which of the following shows the company’s assets, liabilities,
 and net assets at a certain point in time and indicates the company’s financial situation?

 a) Balance sheet b) Statement of cash flows
 c) Statement of changes in equity d) Statement of profit or loss

Q80. Which of the following is an action that is taken in order to improve the cash flow?

 a) Pay the notes payable on a shorter timeline.
 b) Receive payment on the notes receivable on a longer timeline.
 c) Shorten the time period for collecting accounts receivable.
 d) Shorten the time period for making payments on accounts payable.

 – 30 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/a/questions.pdf","pages":[22,23,24,25,26,27,28,29,30]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'B',
  1,
  'Q1. Read the following description of risk assessment of information assets, and then answer
 Subquestions 1 through 4.

Company R is a medium-sized system integrator (SI) vendor with 100 employees. Prior to
 beginning a project, Company R conducts risk assessment of the information assets to be
 used in the project according to the internal procedures, as shown in Figure 1. The company
 recently decided to conduct a risk assessment for the newly launched Project P.

Preparation for risk Risk analysis and Risk identification assessment evaluation
 - Understanding the - Identification of information assets - Calculation of target project - Quantification of information risk values
 asset values
 - Understanding the - Quantification of threats and - Risk evaluation
 target system vulnerabilities

Figure 1. Company R’s risk assessment procedures

[Description of Project P (excerpt)]
 (1) The project involves developing a purchasing system to be used by the customer.
 (2) The test data used during development will be provided by the customer.
 (3) Project members will receive the customer’s USB storage devices (hereinafter, USB
 storage) containing the customer test data from the customer, take the USB storage to
 Company R, copy the customer test data to the development server, and then delete the
 data from the USB storage.
 (4) Travel from Company R to the customer’s office takes 90 minutes by train.
 (5) The programs will be developed on development PCs, and uploaded to the development
 server as appropriate.

[Company R’s development environment (excerpt)]
 (1) The development server and development PCs are used in program development.
 (2) The development server is located in a locked server room.
 (3) The development server is placed on controlled access, and can be accessed only by
 project members and system administrators.
 (4) Development PCs are loaned from the systems department to project members at the
 start of a project, and are returned when the project is completed.

- 3 -

[Company R’s development standards (excerpt)]
 (1) During development, project members download the necessary portions of customers
 test data from the development server to their own development PCs, and delete the data
 when no longer needed.
 (2) After completion of a project, the project manager deletes the customer test data from
 the development server and confirms that the customer test data has been deleted from
 all development PCs.

[Company R’s risk value calculation method]
 Company R calculates the risk value of each information asset using the following formula.

Risk value = Value of information asset × Threat × Vulnerability

Here, “value of information asset” refers to the degree of impact if the information asset is
 damaged. The degree of impact is evaluated considering three perspectives: Confidentiality
 (C) , Integrity (I) , and Availability (A) , each given a value from 1 to 3. For “threat”, the
 degree of possibility of occurrence is evaluated with a value from 1 to 3. For “vulnerability”,
 the degree to which damage manifests when a threat occurs is evaluated with a value from
 1 to 3. For the values 1 to 3, 3 is large and 1 is small.
 If the risk values calculated for C, I, and A are all 12 or less, the risk is accepted; otherwise,
 additional measures are implemented to counter the risk.

[Risk identification]
 (1) Identification of information assets
 Company R identifies the information assets handled in Project P. The results are shown
 in Table 1.

Table 1. Results of identification of information assets

No. Information asset Creation or acquisition Storage location Disposal

3 In-development Uploaded to the Development server Delete when
 programs on the development server by project is
 development server project members completed
 4 Customer test data Received by customer’s Customer’s USB
 USB storage, copied to storage, development
 the development server server, and development
 PCs

Note: Shaded part is not shown. “ ” indicates omission.

- 4 -

(2) Quantification of information asset values
 For each information asset in Table 1, the evaluated values of C, I, and A, and the
 reasoning behind the evaluation are shown in Table 2.

Table 2. Values of information assets and reasoning behind evaluation

No. Information asset C I A Reasoning behind evaluation of values

3 In-development 3 3 3 (i) There will be an impact on the progress of
 programs on the the project if the in-development programs are
 development unusable
 server (ii) Customers’ trust would be lost if the
 information were leaked out of the company
 (iii) If program versions are not controlled, there
 will be an impact on the progress of the project
 owing to inconsistency
 4 Customer test data 3 2 1

Note: Shaded part is not shown. “ ” indicates omission.

(3) Quantification of threats
 Table 3 shows the contents and values of threats related to the information asset no. 4
 (customer test data), which is one of the information assets in Table 2.

Table 3. Contents and values of threats related to information asset no. 4

No. Threat Threat content Value
 ID
 4 T1 Customer’s USB storage containing the customer test data is lost on 3
 the way to Company R
 T2 Development server is accessed without authorization from outside 1
 the company, and the customer test data is stolen
 T3 Customer test data are destroyed or leaked due to viral infection 2
 T4 Customer test data is leaked from the customer’s USB storage after 3
 the data is copied to the development server
 T5 Customer test data that are no longer needed are leaked from 2
 development PCs after the completion of testing
 T6 Customer test data are copied to a portable storage from the 1
 development server by a project member or system administrator and
 are taken out of the server room
 T7 Customer test data are destroyed on the development server 1

- 5 -

(4) Quantification of vulnerabilities to threats
 Table 4 shows the measures to mitigate the vulnerability and the value of vulnerability
 for each threat in Table 3. The value of vulnerability is 1 if two or more measures have
 been taken by systems, rules, or operations; the value is 2 if only one measure has been
 taken, and it is 3 if no measures have been taken.

Table 4. Measures to mitigate vulnerabilities and values of vulnerabilities
 for the threats in Table 3

Threat VulnerMeasures to mitigate vulnerability Value
 ID ability ID
 • Having customer encrypt the customer test data when it is
 T1 V1 2
 saved to the customer’s USB storage
 T2 V2 • No measures against the vulnerability 3
 • Installing anti-virus software on the development server and
 development PCs, and automatically updating virus definition
 T3 V3 files 1
 • Performing virus scan on the customer’s USB storage before
 copying the customer test data to the development server
 • Project manager confirming that the customer test data have
 T4 V4 2
 been deleted from the customer’s USB storage
 • Project manager confirming that the customer test data have
 T5 V5 2
 been deleted from the development PCs
 • Performing physical access controls using employee ID
 T6 V6 badges 1
 • Installing monitoring cameras in the server room
 T7 V7 • No measures against the vulnerability 3

[Risk analysis and evaluation]
 The risk analysis and evaluation are conducted with respect to the information asset no. 4
 (customer test data) based on Tables 2 to 4. Table 5 shows the calculated risk values.

- 6 -

Table 5. Risk values of information asset no.4
 Values of
 information Threat Vulnerability Risk values
 No. asset
 Threat Vulnerability Risk C I A Value Value C I A ID ID value ID
 T1 3 V1 2 R1 18 12 6
 T2 1 V2 3 R2 9 6 3
 T3 2 V3 1 R3
 4 3 2 1 T4 3 V4 2 R4
 T5 2 V5 2 R5 A
 T6 1 V6 1 R6 B
 T7 1 V7 3 R7
 Note: Shaded parts are not shown.

The project manager of Project P creates an action plan for the risks based on the results of
 the risk analysis and evaluation. After this, the company takes measures against the risks.

Subquestion 1
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Table 5.

Answer group for A and B
 a) 1 b) 3 c) 6 d) 8
 e) 9 f) 12 g) 18

Subquestion 2
 In table 2, (ii) and (iii) are the reasoning behind the evaluation when the value of information
 assets has been evaluated in terms of either C, I, or A. From the answer group below, select
 the appropriate combination of C, I, and A that corresponds to (ii) and (iii).

Answer group
 (ii) (iii)
 a) A C
 b) A I
 c) C A
 d) C I
 e) I A
 f) I C

- 7 -

Subquestion 3
 From the answer group below, select the correct number of threats for which additional
 measures against the risks are required owing to the risk analysis and evaluation related to
 the information asset no. 4 (customer test data).

Answer group:
 a) 1 b) 2 c) 3 d) 4

Subquestion 4
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the following description related to the occurrence of, and response to, a
 security incident in Company R.

The systems department received a report that the customer test data for Project P were
 stored on a development PC used in Project Q, which was launched after the completion of
 Project P. Investigations revealed that the PC was used as a development PC in Project P,
 and after being returned to the systems department, it was loaned by the systems department
 to members of Project Q. To address the risk of leakage of customer test data, Company R
 decided to add the following two measures:
 o ***C***
 o ***D***',
  '[{"type":"prompt","text":"Q1. Read the following description of risk assessment of information assets, and then answer\n Subquestions 1 through 4."},{"type":"context","text":"Company R is a medium-sized system integrator (SI) vendor with 100 employees. Prior to\n beginning a project, Company R conducts risk assessment of the information assets to be\n used in the project according to the internal procedures, as shown in Figure 1. The company\n recently decided to conduct a risk assessment for the newly launched Project P.\n\nPreparation for risk Risk analysis and Risk identification assessment evaluation\n - Understanding the - Identification of information assets - Calculation of target project - Quantification of information risk values\n asset values\n - Understanding the - Quantification of threats and - Risk evaluation\n target system vulnerabilities\n\nFigure 1. Company R’s risk assessment procedures\n\n[Description of Project P (excerpt)]\n (1) The project involves developing a purchasing system to be used by the customer.\n (2) The test data used during development will be provided by the customer.\n (3) Project members will receive the customer’s USB storage devices (hereinafter, USB\n storage) containing the customer test data from the customer, take the USB storage to\n Company R, copy the customer test data to the development server, and then delete the\n data from the USB storage.\n (4) Travel from Company R to the customer’s office takes 90 minutes by train.\n (5) The programs will be developed on development PCs, and uploaded to the development\n server as appropriate.\n\n[Company R’s development environment (excerpt)]\n (1) The development server and development PCs are used in program development.\n (2) The development server is located in a locked server room.\n (3) The development server is placed on controlled access, and can be accessed only by\n project members and system administrators.\n (4) Development PCs are loaned from the systems department to project members at the\n start of a project, and are returned when the project is completed.\n\n- 3 -\n\n[Company R’s development standards (excerpt)]\n (1) During development, project members download the necessary portions of customers\n test data from the development server to their own development PCs, and delete the data\n when no longer needed.\n (2) After completion of a project, the project manager deletes the customer test data from\n the development server and confirms that the customer test data has been deleted from\n all development PCs.\n\n[Company R’s risk value calculation method]\n Company R calculates the risk value of each information asset using the following formula.\n\nRisk value = Value of information asset × Threat × Vulnerability\n\nHere, “value of information asset” refers to the degree of impact if the information asset is\n damaged. The degree of impact is evaluated considering three perspectives: Confidentiality\n (C) , Integrity (I) , and Availability (A) , each given a value from 1 to 3. For “threat”, the\n degree of possibility of occurrence is evaluated with a value from 1 to 3. For “vulnerability”,\n the degree to which damage manifests when a threat occurs is evaluated with a value from\n 1 to 3. For the values 1 to 3, 3 is large and 1 is small.\n If the risk values calculated for C, I, and A are all 12 or less, the risk is accepted; otherwise,\n additional measures are implemented to counter the risk.\n\n[Risk identification]\n (1) Identification of information assets\n Company R identifies the information assets handled in Project P. The results are shown\n in Table 1.\n\nTable 1. Results of identification of information assets\n\nNo. Information asset Creation or acquisition Storage location Disposal\n\n3 In-development Uploaded to the Development server Delete when\n programs on the development server by project is\n development server project members completed\n 4 Customer test data Received by customer’s Customer’s USB\n USB storage, copied to storage, development\n the development server server, and development\n PCs\n\nNote: Shaded part is not shown. “ ” indicates omission.\n\n- 4 -\n\n(2) Quantification of information asset values\n For each information asset in Table 1, the evaluated values of C, I, and A, and the\n reasoning behind the evaluation are shown in Table 2.\n\nTable 2. Values of information assets and reasoning behind evaluation\n\nNo. Information asset C I A Reasoning behind evaluation of values\n\n3 In-development 3 3 3 (i) There will be an impact on the progress of\n programs on the the project if the in-development programs are\n development unusable\n server (ii) Customers’ trust would be lost if the\n information were leaked out of the company\n (iii) If program versions are not controlled, there\n will be an impact on the progress of the project\n owing to inconsistency\n 4 Customer test data 3 2 1\n\nNote: Shaded part is not shown. “ ” indicates omission.\n\n(3) Quantification of threats\n Table 3 shows the contents and values of threats related to the information asset no. 4\n (customer test data), which is one of the information assets in Table 2.\n\nTable 3. Contents and values of threats related to information asset no. 4\n\nNo. Threat Threat content Value\n ID\n 4 T1 Customer’s USB storage containing the customer test data is lost on 3\n the way to Company R\n T2 Development server is accessed without authorization from outside 1\n the company, and the customer test data is stolen\n T3 Customer test data are destroyed or leaked due to viral infection 2\n T4 Customer test data is leaked from the customer’s USB storage after 3\n the data is copied to the development server\n T5 Customer test data that are no longer needed are leaked from 2\n development PCs after the completion of testing\n T6 Customer test data are copied to a portable storage from the 1\n development server by a project member or system administrator and\n are taken out of the server room\n T7 Customer test data are destroyed on the development server 1\n\n- 5 -\n\n(4) Quantification of vulnerabilities to threats\n Table 4 shows the measures to mitigate the vulnerability and the value of vulnerability\n for each threat in Table 3. The value of vulnerability is 1 if two or more measures have\n been taken by systems, rules, or operations; the value is 2 if only one measure has been\n taken, and it is 3 if no measures have been taken.\n\nTable 4. Measures to mitigate vulnerabilities and values of vulnerabilities\n for the threats in Table 3\n\nThreat VulnerMeasures to mitigate vulnerability Value\n ID ability ID\n • Having customer encrypt the customer test data when it is\n T1 V1 2\n saved to the customer’s USB storage\n T2 V2 • No measures against the vulnerability 3\n • Installing anti-virus software on the development server and\n development PCs, and automatically updating virus definition\n T3 V3 files 1\n • Performing virus scan on the customer’s USB storage before\n copying the customer test data to the development server\n • Project manager confirming that the customer test data have\n T4 V4 2\n been deleted from the customer’s USB storage\n • Project manager confirming that the customer test data have\n T5 V5 2\n been deleted from the development PCs\n • Performing physical access controls using employee ID\n T6 V6 badges 1\n • Installing monitoring cameras in the server room\n T7 V7 • No measures against the vulnerability 3\n\n[Risk analysis and evaluation]\n The risk analysis and evaluation are conducted with respect to the information asset no. 4\n (customer test data) based on Tables 2 to 4. Table 5 shows the calculated risk values.\n\n- 6 -\n\nTable 5. Risk values of information asset no.4\n Values of\n information Threat Vulnerability Risk values\n No. asset\n Threat Vulnerability Risk C I A Value Value C I A ID ID value ID\n T1 3 V1 2 R1 18 12 6\n T2 1 V2 3 R2 9 6 3\n T3 2 V3 1 R3\n 4 3 2 1 T4 3 V4 2 R4\n T5 2 V5 2 R5 A\n T6 1 V6 1 R6 B\n T7 1 V7 3 R7\n Note: Shaded parts are not shown.\n\nThe project manager of Project P creates an action plan for the risks based on the results of\n the risk analysis and evaluation. After this, the company takes measures against the risks.\n\nSubquestion 1\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in Table 5.\n\nAnswer group for A and B\n a) 1 b) 3 c) 6 d) 8\n e) 9 f) 12 g) 18\n\nSubquestion 2\n In table 2, (ii) and (iii) are the reasoning behind the evaluation when the value of information\n assets has been evaluated in terms of either C, I, or A. From the answer group below, select\n the appropriate combination of C, I, and A that corresponds to (ii) and (iii).\n\nAnswer group\n (ii) (iii)\n a) A C\n b) A I\n c) C A\n d) C I\n e) I A\n f) I C\n\n- 7 -\n\nSubquestion 3\n From the answer group below, select the correct number of threats for which additional\n measures against the risks are required owing to the risk analysis and evaluation related to\n the information asset no. 4 (customer test data).\n\nAnswer group:\n a) 1 b) 2 c) 3 d) 4\n\nSubquestion 4\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in the following description related to the occurrence of, and response to, a\n security incident in Company R.\n\nThe systems department received a report that the customer test data for Project P were\n stored on a development PC used in Project Q, which was launched after the completion of\n Project P. Investigations revealed that the PC was used as a development PC in Project P,\n and after being returned to the systems department, it was loaned by the systems department\n to members of Project Q. To address the risk of leakage of customer test data, Company R\n decided to add the following two measures:\n o ***C***\n o ***D***"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A development server will be newly prepared for each project."},{"label":"b","text":"A user will enter the download date, deletion date, and person in charge in an\n administration log when downloading / deleting customer test data to / from development PCs for use."},{"label":"c","text":"A warning message will be displayed when customer test data are saved to\n development PCs."},{"label":"d","text":"Project members will be given read-only access to customer test data on the\n development server."},{"label":"e","text":"The systems department will add processes to completely erase all data from returned\n development PCs."},{"label":"f","text":"The systems department will regularly check the development server’s access logs.\n\n - 8 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "d"}, {"subquestion": 1, "blank": "B", "answer": "a"}, {"subquestion": 2, "blank": null, "answer": "d"}, {"subquestion": 3, "blank": null, "answer": "b"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"d"},{"subquestion":1,"blank":"B","answer":"a"},{"subquestion":2,"blank":null,"answer":"d"},{"subquestion":3,"blank":null,"answer":"b"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-B, Q1)',
  ARRAY[3,4,5,6,7,8]::int[],
  'native_text',
  '3.0',
  'Q1. Read the following description of risk assessment of information assets, and then answer
 Subquestions 1 through 4.

 Company R is a medium-sized system integrator (SI) vendor with 100 employees. Prior to
 beginning a project, Company R conducts risk assessment of the information assets to be
 used in the project according to the internal procedures, as shown in Figure 1. The company
 recently decided to conduct a risk assessment for the newly launched Project P.

 Preparation for risk Risk analysis and Risk identification assessment evaluation
 - Understanding the - Identification of information assets - Calculation of target project - Quantification of information risk values
 asset values
 - Understanding the - Quantification of threats and - Risk evaluation
 target system vulnerabilities

 Figure 1. Company R’s risk assessment procedures

 [Description of Project P (excerpt)]
 (1) The project involves developing a purchasing system to be used by the customer.
 (2) The test data used during development will be provided by the customer.
 (3) Project members will receive the customer’s USB storage devices (hereinafter, USB
 storage) containing the customer test data from the customer, take the USB storage to
 Company R, copy the customer test data to the development server, and then delete the
 data from the USB storage.
 (4) Travel from Company R to the customer’s office takes 90 minutes by train.
 (5) The programs will be developed on development PCs, and uploaded to the development
 server as appropriate.

 [Company R’s development environment (excerpt)]
 (1) The development server and development PCs are used in program development.
 (2) The development server is located in a locked server room.
 (3) The development server is placed on controlled access, and can be accessed only by
 project members and system administrators.
 (4) Development PCs are loaned from the systems department to project members at the
 start of a project, and are returned when the project is completed.

 - 3 -

[Company R’s development standards (excerpt)]
 (1) During development, project members download the necessary portions of customers
 test data from the development server to their own development PCs, and delete the data
 when no longer needed.
 (2) After completion of a project, the project manager deletes the customer test data from
 the development server and confirms that the customer test data has been deleted from
 all development PCs.

 [Company R’s risk value calculation method]
 Company R calculates the risk value of each information asset using the following formula.

 Risk value = Value of information asset × Threat × Vulnerability

 Here, “value of information asset” refers to the degree of impact if the information asset is
 damaged. The degree of impact is evaluated considering three perspectives: Confidentiality
 (C) , Integrity (I) , and Availability (A) , each given a value from 1 to 3. For “threat”, the
 degree of possibility of occurrence is evaluated with a value from 1 to 3. For “vulnerability”,
 the degree to which damage manifests when a threat occurs is evaluated with a value from
 1 to 3. For the values 1 to 3, 3 is large and 1 is small.
 If the risk values calculated for C, I, and A are all 12 or less, the risk is accepted; otherwise,
 additional measures are implemented to counter the risk.

 [Risk identification]
 (1) Identification of information assets
 Company R identifies the information assets handled in Project P. The results are shown
 in Table 1.

 Table 1. Results of identification of information assets

No. Information asset Creation or acquisition Storage location Disposal

 3 In-development Uploaded to the Development server Delete when
 programs on the development server by project is
 development server project members completed
 4 Customer test data Received by customer’s Customer’s USB
 USB storage, copied to storage, development
 the development server server, and development
 PCs

 Note: Shaded part is not shown. “ ” indicates omission.

 - 4 -

(2) Quantification of information asset values
 For each information asset in Table 1, the evaluated values of C, I, and A, and the
 reasoning behind the evaluation are shown in Table 2.

 Table 2. Values of information assets and reasoning behind evaluation

No. Information asset C I A Reasoning behind evaluation of values

 3 In-development 3 3 3 (i) There will be an impact on the progress of
 programs on the the project if the in-development programs are
 development unusable
 server (ii) Customers’ trust would be lost if the
 information were leaked out of the company
 (iii) If program versions are not controlled, there
 will be an impact on the progress of the project
 owing to inconsistency
 4 Customer test data 3 2 1

 Note: Shaded part is not shown. “ ” indicates omission.

 (3) Quantification of threats
 Table 3 shows the contents and values of threats related to the information asset no. 4
 (customer test data), which is one of the information assets in Table 2.

 Table 3. Contents and values of threats related to information asset no. 4

No. Threat Threat content Value
 ID
 4 T1 Customer’s USB storage containing the customer test data is lost on 3
 the way to Company R
 T2 Development server is accessed without authorization from outside 1
 the company, and the customer test data is stolen
 T3 Customer test data are destroyed or leaked due to viral infection 2
 T4 Customer test data is leaked from the customer’s USB storage after 3
 the data is copied to the development server
 T5 Customer test data that are no longer needed are leaked from 2
 development PCs after the completion of testing
 T6 Customer test data are copied to a portable storage from the 1
 development server by a project member or system administrator and
 are taken out of the server room
 T7 Customer test data are destroyed on the development server 1

 - 5 -

(4) Quantification of vulnerabilities to threats
 Table 4 shows the measures to mitigate the vulnerability and the value of vulnerability
 for each threat in Table 3. The value of vulnerability is 1 if two or more measures have
 been taken by systems, rules, or operations; the value is 2 if only one measure has been
 taken, and it is 3 if no measures have been taken.

 Table 4. Measures to mitigate vulnerabilities and values of vulnerabilities
 for the threats in Table 3

Threat VulnerMeasures to mitigate vulnerability Value
 ID ability ID
 • Having customer encrypt the customer test data when it is
 T1 V1 2
 saved to the customer’s USB storage
 T2 V2 • No measures against the vulnerability 3
 • Installing anti-virus software on the development server and
 development PCs, and automatically updating virus definition
 T3 V3 files 1
 • Performing virus scan on the customer’s USB storage before
 copying the customer test data to the development server
 • Project manager confirming that the customer test data have
 T4 V4 2
 been deleted from the customer’s USB storage
 • Project manager confirming that the customer test data have
 T5 V5 2
 been deleted from the development PCs
 • Performing physical access controls using employee ID
 T6 V6 badges 1
 • Installing monitoring cameras in the server room
 T7 V7 • No measures against the vulnerability 3

 [Risk analysis and evaluation]
 The risk analysis and evaluation are conducted with respect to the information asset no. 4
 (customer test data) based on Tables 2 to 4. Table 5 shows the calculated risk values.

 - 6 -

Table 5. Risk values of information asset no.4
 Values of
 information Threat Vulnerability Risk values
 No. asset
 Threat Vulnerability Risk C I A Value Value C I A ID ID value ID
 T1 3 V1 2 R1 18 12 6
 T2 1 V2 3 R2 9 6 3
 T3 2 V3 1 R3
 4 3 2 1 T4 3 V4 2 R4
 T5 2 V5 2 R5 A
 T6 1 V6 1 R6 B
 T7 1 V7 3 R7
 Note: Shaded parts are not shown.

 The project manager of Project P creates an action plan for the risks based on the results of
 the risk analysis and evaluation. After this, the company takes measures against the risks.

Subquestion 1
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Table 5.

 Answer group for A and B
 a) 1 b) 3 c) 6 d) 8
 e) 9 f) 12 g) 18

Subquestion 2
 In table 2, (ii) and (iii) are the reasoning behind the evaluation when the value of information
 assets has been evaluated in terms of either C, I, or A. From the answer group below, select
 the appropriate combination of C, I, and A that corresponds to (ii) and (iii).

 Answer group
 (ii) (iii)
 a) A C
 b) A I
 c) C A
 d) C I
 e) I A
 f) I C

 - 7 -

Subquestion 3
 From the answer group below, select the correct number of threats for which additional
 measures against the risks are required owing to the risk analysis and evaluation related to
 the information asset no. 4 (customer test data).

 Answer group:
 a) 1 b) 2 c) 3 d) 4

Subquestion 4
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the following description related to the occurrence of, and response to, a
 security incident in Company R.

 The systems department received a report that the customer test data for Project P were
 stored on a development PC used in Project Q, which was launched after the completion of
 Project P. Investigations revealed that the PC was used as a development PC in Project P,
 and after being returned to the systems department, it was loaned by the systems department
 to members of Project Q. To address the risk of leakage of customer test data, Company R
 decided to add the following two measures:
 o _____C_____
 o _____D_____

 Answer group for C and D
 a) A development server will be newly prepared for each project.
 b) A user will enter the download date, deletion date, and person in charge in an
 administration log when downloading / deleting customer test data to / from development PCs for use.
 c) A warning message will be displayed when customer test data are saved to
 development PCs.
 d) Project members will be given read-only access to customer test data on the
 development server.
 e) The systems department will add processes to completely erase all data from returned
 development PCs.
 f) The systems department will regularly check the development server’s access logs.

 - 8 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/b/questions.pdf","pages":[3,4,5,6,7,8]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'B',
  2,
  'Q2. Read the following description of a language processing system, and then answer
 Subquestions 1 through 3.

A language processing system is a software that reads a source program written in a
 programming language (hereinafter, a language), analyzes the source program according to
 the syntax and semantics of the language, and converts the source program to an object
 program in suitable format for execution, or simply executes it by itself.

An interpreter is a kind of language processing system that reads, analyzes, and executes a
 source program at a time. A source program developed for an interpreter is executable on
 any computer where the interpreter is executable. However, this may be a disadvantage of
 the interpreter method because a source program must be analyzed each time before its
 execution. On typical interpreters, deep and complex analysis extends the total execution
 time of a source program. Most interpreters run a source program sequentially as it is written.

A compiler is another kind of language processing system that reads and analyzes a source
 program, and outputs an object program that consists of machine-readable instructions. The
 object program is executable on the computer, which equips the specific instruction set with
 the compiler execution results at different times. This may be an advantage of the compiler
 method when compared with the interpreter method, because it ***A***.

Subquestion 1
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the above description.

Answer group for A
 a) allows programmers to check the cause of an error during execution
 b) allows programmers to modify the source program and run it immediately
 c) can execute the source program while checking it interactively
 d) can optimize the executable program for the target computer

- 9 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following description.

There is another method that uses a computer virtually constructed by software, called a
 virtual machine. As with the compiler method, the language processing system in this
 method outputs an executable program; however, it consists of instructions dedicated for use
 by the virtual machine, called intermediate code. Figure 1 shows an example of the
 conversion of a source program into intermediate code and its execution with the virtual
 machine.

Computer X Computer Y

(2)
 Source program Run

Intermediate code
 Compiler (1) Virtual machine

Distribute
 Intermediate code intermediate
 Computer Z code
 (2) Run (2) Run

Intermediate code
 Intermediate code
 Virtual machine
 Virtual machine

(1) Convert a source program into intermediate code runnable on a virtual machine.
 (2) Execute intermediate code on a virtual machine.

Figure 1 Example of running a program on a virtual machine

By implementing a virtual machine for various operating systems (OSs) or hardware, it is
 possible to distribute a program that ***B***.

Answer group for B
 a) is independent of any specific OS or hardware
 b) depends on a specific OS and hardware
 c) maximizes the performance of specific hardware
 d) reduces memory usage on certain hardware

- 10 -

Subquestion 3
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

Some virtual machines collect information about what processes or functions are frequently
 executed (hereinafter referred to as profile information) and feeds that information back to
 the intermediate-code execution. Dynamic compilation is a method employed to compile a
 part of an intermediate code to a native code for subsequent execution based on the profile
 information. This method is used in practical language processing systems such as the Java
 JIT (Just-In-Time) compiler. Figure 2 shows an example of the method.

(1)
 Intermediate code

Main program Function F

Run

Intermediate code (2) Intermediate code

Main program Function F

(3)
 (5) (4)
 Run
 Profile information

Native code
 Dynamic compiler
 Function F

(1) The main program and function F are distributed in the form of intermediate code.
 (2) At first, function F is called in the form of intermediate code.
 (3) The decision whether to compile function F dynamically or not is made based on the
 profile information.
 (4) If function F is determined to be compiled, the dynamic compiler starts compilation.
 (5) After the compilation, function F is called in the form of the native code.

Figure 2 Process flow showing application of the dynamic compilation method

When adapting a specific system to dynamic compilation, it is necessary to consider certain
 overheads, which are the startup time and compilation time of the dynamic compiler, in
 addition to the execution time of the program.

- 11 -

Consider the total execution time when function F shown in Figure 2 is executed with and
without the dynamic compilation method under the following conditions:
(1) The total execution time of function F consists of the following times only.
 - Execution time of the intermediate-code instructions
 - Execution time of the native-code instructions
 - Startup time of the dynamic compiler
 - Compilation time of the dynamic compiler
(2) Function F before the dynamic compilation consists of 400 intermediate-code
 instructions. Because function F contains a loop structure, 2,000 intermediate-code
 instructions are executed once it is called.
(3) Function F after the dynamic compilation also consists of 400 native-code instructions.
 In addition, 2,000 native-code instructions are executed once it is called.
(4) An intermediate-code instruction takes 0.5 μs (microseconds) to execute whereas a
 native-code instruction takes 0.01 μs.
(5) The dynamic compiler starts compiling function F at the beginning of its 101st call. It
 takes 100 ms (milliseconds) to start up the dynamic compiler and 100 ms to compile
 1,000 intermediate-code instructions to native-code instructions of the same number.
 The execution of function F of intermediate-code stops during the dynamic compilation
 and resumes function F of native-code after the compilation is finished.

When function F is called from the main program 200 times,
 - total execution time of function F for the first 100 calls: 100 ms
 - execution time for the dynamic compilation: ***C*** ms
 - total execution time of function F for the last 100 calls: ***D*** ms
The dynamic compilation consumes a considerable amount of time. Therefore, there is a
tradeoff with respect to the time at which the dynamic compilation is started.
Consequently, invocation of the dynamic compiler before the first call of function F reduces
the total execution time when function F is called more than ***E*** times.

Answer group for C and D
 a) 1 b) 2 c) 10 d) 20
 e) 40 f) 100 g) 140',
  '[{"type":"prompt","text":"Q2. Read the following description of a language processing system, and then answer\n Subquestions 1 through 3."},{"type":"context","text":"A language processing system is a software that reads a source program written in a\n programming language (hereinafter, a language), analyzes the source program according to\n the syntax and semantics of the language, and converts the source program to an object\n program in suitable format for execution, or simply executes it by itself.\n\nAn interpreter is a kind of language processing system that reads, analyzes, and executes a\n source program at a time. A source program developed for an interpreter is executable on\n any computer where the interpreter is executable. However, this may be a disadvantage of\n the interpreter method because a source program must be analyzed each time before its\n execution. On typical interpreters, deep and complex analysis extends the total execution\n time of a source program. Most interpreters run a source program sequentially as it is written.\n\nA compiler is another kind of language processing system that reads and analyzes a source\n program, and outputs an object program that consists of machine-readable instructions. The\n object program is executable on the computer, which equips the specific instruction set with\n the compiler execution results at different times. This may be an advantage of the compiler\n method when compared with the interpreter method, because it ***A***.\n\nSubquestion 1\n From the answer group below, select the correct answer to be inserted in the blank _______\n in the above description.\n\nAnswer group for A\n a) allows programmers to check the cause of an error during execution\n b) allows programmers to modify the source program and run it immediately\n c) can execute the source program while checking it interactively\n d) can optimize the executable program for the target computer\n\n- 9 -\n\nSubquestion 2\n From the answer group below, select the correct answer to be inserted in the blank _______\n in the following description.\n\nThere is another method that uses a computer virtually constructed by software, called a\n virtual machine. As with the compiler method, the language processing system in this\n method outputs an executable program; however, it consists of instructions dedicated for use\n by the virtual machine, called intermediate code. Figure 1 shows an example of the\n conversion of a source program into intermediate code and its execution with the virtual\n machine.\n\nComputer X Computer Y\n\n(2)\n Source program Run\n\nIntermediate code\n Compiler (1) Virtual machine\n\nDistribute\n Intermediate code intermediate\n Computer Z code\n (2) Run (2) Run\n\nIntermediate code\n Intermediate code\n Virtual machine\n Virtual machine\n\n(1) Convert a source program into intermediate code runnable on a virtual machine.\n (2) Execute intermediate code on a virtual machine.\n\nFigure 1 Example of running a program on a virtual machine\n\nBy implementing a virtual machine for various operating systems (OSs) or hardware, it is\n possible to distribute a program that ***B***.\n\nAnswer group for B\n a) is independent of any specific OS or hardware\n b) depends on a specific OS and hardware\n c) maximizes the performance of specific hardware\n d) reduces memory usage on certain hardware\n\n- 10 -\n\nSubquestion 3\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following description.\n\nSome virtual machines collect information about what processes or functions are frequently\n executed (hereinafter referred to as profile information) and feeds that information back to\n the intermediate-code execution. Dynamic compilation is a method employed to compile a\n part of an intermediate code to a native code for subsequent execution based on the profile\n information. This method is used in practical language processing systems such as the Java\n JIT (Just-In-Time) compiler. Figure 2 shows an example of the method.\n\n(1)\n Intermediate code\n\nMain program Function F\n\nRun\n\nIntermediate code (2) Intermediate code\n\nMain program Function F\n\n(3)\n (5) (4)\n Run\n Profile information\n\nNative code\n Dynamic compiler\n Function F\n\n(1) The main program and function F are distributed in the form of intermediate code.\n (2) At first, function F is called in the form of intermediate code.\n (3) The decision whether to compile function F dynamically or not is made based on the\n profile information.\n (4) If function F is determined to be compiled, the dynamic compiler starts compilation.\n (5) After the compilation, function F is called in the form of the native code.\n\nFigure 2 Process flow showing application of the dynamic compilation method\n\nWhen adapting a specific system to dynamic compilation, it is necessary to consider certain\n overheads, which are the startup time and compilation time of the dynamic compiler, in\n addition to the execution time of the program.\n\n- 11 -\n\nConsider the total execution time when function F shown in Figure 2 is executed with and\nwithout the dynamic compilation method under the following conditions:\n(1) The total execution time of function F consists of the following times only.\n - Execution time of the intermediate-code instructions\n - Execution time of the native-code instructions\n - Startup time of the dynamic compiler\n - Compilation time of the dynamic compiler\n(2) Function F before the dynamic compilation consists of 400 intermediate-code\n instructions. Because function F contains a loop structure, 2,000 intermediate-code\n instructions are executed once it is called.\n(3) Function F after the dynamic compilation also consists of 400 native-code instructions.\n In addition, 2,000 native-code instructions are executed once it is called.\n(4) An intermediate-code instruction takes 0.5 μs (microseconds) to execute whereas a\n native-code instruction takes 0.01 μs.\n(5) The dynamic compiler starts compiling function F at the beginning of its 101st call. It\n takes 100 ms (milliseconds) to start up the dynamic compiler and 100 ms to compile\n 1,000 intermediate-code instructions to native-code instructions of the same number.\n The execution of function F of intermediate-code stops during the dynamic compilation\n and resumes function F of native-code after the compilation is finished.\n\nWhen function F is called from the main program 200 times,\n - total execution time of function F for the first 100 calls: 100 ms\n - execution time for the dynamic compilation: ***C*** ms\n - total execution time of function F for the last 100 calls: ***D*** ms\nThe dynamic compilation consumes a considerable amount of time. Therefore, there is a\ntradeoff with respect to the time at which the dynamic compilation is started.\nConsequently, invocation of the dynamic compiler before the first call of function F reduces\nthe total execution time when function F is called more than ***E*** times.\n\nAnswer group for C and D\n a) 1 b) 2 c) 10 d) 20\n e) 40 f) 100 g) 140"}]'::jsonb,
  '["2022-april-b-q02-figure1.webp","2022-april-b-q02-figure2.webp"]'::jsonb,
  '[{"label":"a","text":"40"},{"label":"b","text":"102"},{"label":"c","text":"142"},{"label":"d","text":"175\n\n - 12 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "d"}, {"subquestion": 2, "blank": "B", "answer": "a"}, {"subquestion": 3, "blank": "C", "answer": "g"}, {"subquestion": 3, "blank": "D", "answer": "b"}, {"subquestion": 3, "blank": "E", "answer": "c"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"d"},{"subquestion":2,"blank":"B","answer":"a"},{"subquestion":3,"blank":"C","answer":"g"},{"subquestion":3,"blank":"D","answer":"b"},{"subquestion":3,"blank":"E","answer":"c"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-B, Q2)',
  ARRAY[9,10,11,12]::int[],
  'native_text',
  '3.0',
  'Q2. Read the following description of a language processing system, and then answer
 Subquestions 1 through 3.

 A language processing system is a software that reads a source program written in a
 programming language (hereinafter, a language), analyzes the source program according to
 the syntax and semantics of the language, and converts the source program to an object
 program in suitable format for execution, or simply executes it by itself.

 An interpreter is a kind of language processing system that reads, analyzes, and executes a
 source program at a time. A source program developed for an interpreter is executable on
 any computer where the interpreter is executable. However, this may be a disadvantage of
 the interpreter method because a source program must be analyzed each time before its
 execution. On typical interpreters, deep and complex analysis extends the total execution
 time of a source program. Most interpreters run a source program sequentially as it is written.

 A compiler is another kind of language processing system that reads and analyzes a source
 program, and outputs an object program that consists of machine-readable instructions. The
 object program is executable on the computer, which equips the specific instruction set with
 the compiler execution results at different times. This may be an advantage of the compiler
 method when compared with the interpreter method, because it ___A___.

Subquestion 1
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the above description.

 Answer group for A
 a) allows programmers to check the cause of an error during execution
 b) allows programmers to modify the source program and run it immediately
 c) can execute the source program while checking it interactively
 d) can optimize the executable program for the target computer

 - 9 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following description.

 There is another method that uses a computer virtually constructed by software, called a
 virtual machine. As with the compiler method, the language processing system in this
 method outputs an executable program; however, it consists of instructions dedicated for use
 by the virtual machine, called intermediate code. Figure 1 shows an example of the
 conversion of a source program into intermediate code and its execution with the virtual
 machine.

 Computer X Computer Y

 (2)
 Source program Run

 Intermediate code
 Compiler (1) Virtual machine

 Distribute
 Intermediate code intermediate
 Computer Z code
 (2) Run (2) Run

 Intermediate code
 Intermediate code
 Virtual machine
 Virtual machine

 (1) Convert a source program into intermediate code runnable on a virtual machine.
 (2) Execute intermediate code on a virtual machine.

 Figure 1 Example of running a program on a virtual machine

 By implementing a virtual machine for various operating systems (OSs) or hardware, it is
 possible to distribute a program that ___B___.

 Answer group for B
 a) is independent of any specific OS or hardware
 b) depends on a specific OS and hardware
 c) maximizes the performance of specific hardware
 d) reduces memory usage on certain hardware

 - 10 -

Subquestion 3
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

 Some virtual machines collect information about what processes or functions are frequently
 executed (hereinafter referred to as profile information) and feeds that information back to
 the intermediate-code execution. Dynamic compilation is a method employed to compile a
 part of an intermediate code to a native code for subsequent execution based on the profile
 information. This method is used in practical language processing systems such as the Java
 JIT (Just-In-Time) compiler. Figure 2 shows an example of the method.

 (1)
 Intermediate code

 Main program Function F

 Run

 Intermediate code (2) Intermediate code

 Main program Function F

 (3)
 (5) (4)
 Run
 Profile information

 Native code
 Dynamic compiler
 Function F

 (1) The main program and function F are distributed in the form of intermediate code.
 (2) At first, function F is called in the form of intermediate code.
 (3) The decision whether to compile function F dynamically or not is made based on the
 profile information.
 (4) If function F is determined to be compiled, the dynamic compiler starts compilation.
 (5) After the compilation, function F is called in the form of the native code.

 Figure 2 Process flow showing application of the dynamic compilation method

 When adapting a specific system to dynamic compilation, it is necessary to consider certain
 overheads, which are the startup time and compilation time of the dynamic compiler, in
 addition to the execution time of the program.

 - 11 -

Consider the total execution time when function F shown in Figure 2 is executed with and
without the dynamic compilation method under the following conditions:
(1) The total execution time of function F consists of the following times only.
 - Execution time of the intermediate-code instructions
 - Execution time of the native-code instructions
 - Startup time of the dynamic compiler
 - Compilation time of the dynamic compiler
(2) Function F before the dynamic compilation consists of 400 intermediate-code
 instructions. Because function F contains a loop structure, 2,000 intermediate-code
 instructions are executed once it is called.
(3) Function F after the dynamic compilation also consists of 400 native-code instructions.
 In addition, 2,000 native-code instructions are executed once it is called.
(4) An intermediate-code instruction takes 0.5 μs (microseconds) to execute whereas a
 native-code instruction takes 0.01 μs.
(5) The dynamic compiler starts compiling function F at the beginning of its 101st call. It
 takes 100 ms (milliseconds) to start up the dynamic compiler and 100 ms to compile
 1,000 intermediate-code instructions to native-code instructions of the same number.
 The execution of function F of intermediate-code stops during the dynamic compilation
 and resumes function F of native-code after the compilation is finished.

When function F is called from the main program 200 times,
 - total execution time of function F for the first 100 calls: 100 ms
 - execution time for the dynamic compilation: ___C___ ms
 - total execution time of function F for the last 100 calls: ___D___ ms
The dynamic compilation consumes a considerable amount of time. Therefore, there is a
tradeoff with respect to the time at which the dynamic compilation is started.
Consequently, invocation of the dynamic compiler before the first call of function F reduces
the total execution time when function F is called more than ___E___ times.

Answer group for C and D
 a) 1 b) 2 c) 10 d) 20
 e) 40 f) 100 g) 140

Answer group for E
 a) 40 b) 102 c) 142 d) 175

 - 12 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/b/questions.pdf","pages":[9,10,11,12]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'B',
  3,
  'Q3. Read the following description of a relational database schema, and then answer
 Subquestions 1 through 3.

Company U has operated five large-scale shopping centers in the country since 2010. The
 customer support division of Company U issues various credit and loan cards for local
 customers, such as credit cards valid worldwide, credit cards valid only in the shopping
 centers, and prepaid discount cards valid only for restaurants in the shopping centers.
 When a customer wants to receive a card, he/she comes to one of the shopping centers, and
 submits an application for account registration. A customer can make an application for
 multiple types of cards. During the first account registration, customer registration is also
 carried out. Therefore, each registered customer has at least one account.
 For each account, an employee from the customer support division is assigned.
 Company U uses a relational database to manage shopping center operations. The relational
 database is composed of the following tables:

Branch table
 BranchID BranchName BranchAddress

Employee table
 EmpID EmpName Title AssignedBranchID SuperiorEmpID

Customer table
 CustID CustName CustAddress

Account table
 AcctID CustID OpenDate BranchID EmpID LoanBalance

Transaction table
 TransID TransDate TransType Amount AcctID
 Note: Underline indicates the primary key and dotted-line indicates the foreign key.

- 13 -

Subquestion 1
 From the answer group below, select the correct answer to be inserted in the blank _______
 in Figure 1.

An entity relationship diagram (ERD) is a data modeling technique that graphically
 illustrates an information system’s entities and the relationships among those entities. The
 elements of an ERD are as follows: Entities, Relationships and Attributes.

Figure 1 shows the ERD, and Table 1 shows the list of cardinality of the relationship.

manages

Employee has Transaction

works Branch has

has

has

has Account A has

Customer

Figure 1 Entity Relationship Diagram

Table 1 List of cardinality of relationship

Termination point Cardinality Existence Description
 One Mandatory Must exist, one and only one
 One Optional May exist, one, or none
 Many Mandatory Must exist, one or more
 Many Optional May exist, one or more or none

Answer group for A
 a) b) c) d)

- 14 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the SQL statement SQL1.

The following SQL statement SQL1 outputs employees with the names of their superiors. If
 an employee has no superior, it displays “(none)” in the SuperiorName field.

Note: The function ISNULL(expression, replacement) returns the value of replacement when
 the value of expression is NULL.
 LEFT OUTER JOIN returns all records from the left table, and the matched records
 from the right table. The result is NULL from the right side, if there is no match.

-- SQL1 --
 SELECT E.EmpID, E.EmpName, E.Title,
 ISNULL(S.EmpName, ''(none)'') AS SuperiorName

FROM Employee E
 LEFT OUTER JOIN ***B*** S
 ON ***C***

When the SQL statement SQL1 is executed with the following sample data:

Employee table

EmpID EmpName Title AssignedBranchID SuperiorEmpID
 1001 Alice Receptionist 20 1003
 1002 Bob Loan manager 10 NULL
 1003 Charlie Loan examiner 10 1002
 1004 Don Receptionist 30 1003

From the sample data shown above, SQL1 outputs the following result:

EmpID EmpName Title SuperiorName
 1001 Alice Receptionist Charlie
 1002 Bob Loan manager (none)
 1003 Charlie Loan examiner Bob
 1004 Don Receptionist Charlie

Answer group for B and C
 a) Account b) Customer
 c) E.EmpID = S.EmpID d) E.EmpID = S.SuperiorEmpID
 e) Employee f) S.EmpID = E.SuperiorEmpID
 g) S.SuperiorEmpID IS NOT NULL

- 15 -

Subquestion 3
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the SQL statement SQL2.

Mr. C, an IT engineer trainee, is creating an SQL statement SQL2. The purpose of SQL2 is
 to output account IDs that were registered before 2020 and never used in 2020 and 2021. It
 is assumed that the Trans2Years table contains all transactions in 2020 and 2021 extracted
 from the Transaction table.
 To test the program, Mr. C provides the following sample data:

Account table

AcctID CustID OpenDate BranchID EmpID LoanBalance
 50001 3001 2016-08-26 20 1001 2534
 50002 3002 2017-04-27 30 1004 0
 50003 3001 2018-01-02 20 1001 2117
 50004 3002 2019-09-19 30 1004 0
 50005 3001 2020-04-16 20 1001 679
 50006 3002 2021-01-10 30 1004 0

Trans2Years table

TransID TransDate TransType Amount AcctID
 700001 2020-01-24 Restaurant 59 50003
 700002 2020-04-21 Cashing 230 50005
 700003 2020-05-09 Revolving 781 50001
 700004 2021-01-19 Cashing 640 50001
 700005 2021-06-07 Restaurant 62 50005
 700006 2021-09-04 Revolving 862 50003

From the sample data shown above, SQL2 should output the following result:

AcctID
 50002
 50004

- 16 -

The SQL statement SQL2 is as follows. At the moment, SQL2 is incomplete and contains
error(s).
Note: The function YEAR(date) returns the four-digit year of the date as a number.

Line No.
 1 -- SQL2 --
 2 SELECT A.AcctID
 3 FROM Account A
 4 WHERE EXISTS(SELECT *
 5 FROM Trans2Years T
 6 WHERE A.AcctID = T.AcctID)
 7 AND YEAR(OpenDate) < 2020

If SQL2 shown above is executed, it outputs ***D***.
To output the correct result, SQL2 should be changed. Concretely, ***E***.

Answer group for D
 a) 2 rows of account IDs: 50001 and 50003
 b) 3 rows of account IDs: 50001, 50003 and 50005
 c) 3 rows of account IDs: 50002, 50004 and 50006
 d) 4 rows of account IDs: 50001, 50001, 50003 and 50003
 e) 4 rows of account IDs: 50002, 50002, 50004 and 50004',
  '[{"type":"prompt","text":"Q3. Read the following description of a relational database schema, and then answer\n Subquestions 1 through 3."},{"type":"context","text":"Company U has operated five large-scale shopping centers in the country since 2010. The\n customer support division of Company U issues various credit and loan cards for local\n customers, such as credit cards valid worldwide, credit cards valid only in the shopping\n centers, and prepaid discount cards valid only for restaurants in the shopping centers.\n When a customer wants to receive a card, he/she comes to one of the shopping centers, and\n submits an application for account registration. A customer can make an application for\n multiple types of cards. During the first account registration, customer registration is also\n carried out. Therefore, each registered customer has at least one account.\n For each account, an employee from the customer support division is assigned.\n Company U uses a relational database to manage shopping center operations. The relational\n database is composed of the following tables:\n\nBranch table\n BranchID BranchName BranchAddress\n\nEmployee table\n EmpID EmpName Title AssignedBranchID SuperiorEmpID\n\nCustomer table\n CustID CustName CustAddress\n\nAccount table\n AcctID CustID OpenDate BranchID EmpID LoanBalance\n\nTransaction table\n TransID TransDate TransType Amount AcctID\n Note: Underline indicates the primary key and dotted-line indicates the foreign key.\n\n- 13 -\n\nSubquestion 1\n From the answer group below, select the correct answer to be inserted in the blank _______\n in Figure 1.\n\nAn entity relationship diagram (ERD) is a data modeling technique that graphically\n illustrates an information system’s entities and the relationships among those entities. The\n elements of an ERD are as follows: Entities, Relationships and Attributes.\n\nFigure 1 shows the ERD, and Table 1 shows the list of cardinality of the relationship.\n\nmanages\n\nEmployee has Transaction\n\nworks Branch has\n\nhas\n\nhas\n\nhas Account A has\n\nCustomer\n\nFigure 1 Entity Relationship Diagram\n\nTable 1 List of cardinality of relationship\n\nTermination point Cardinality Existence Description\n One Mandatory Must exist, one and only one\n One Optional May exist, one, or none\n Many Mandatory Must exist, one or more\n Many Optional May exist, one or more or none\n\nAnswer group for A\n a) b) c) d)\n\n- 14 -\n\nSubquestion 2\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in the SQL statement SQL1.\n\nThe following SQL statement SQL1 outputs employees with the names of their superiors. If\n an employee has no superior, it displays “(none)” in the SuperiorName field.\n\nNote: The function ISNULL(expression, replacement) returns the value of replacement when\n the value of expression is NULL.\n LEFT OUTER JOIN returns all records from the left table, and the matched records\n from the right table. The result is NULL from the right side, if there is no match.\n\n-- SQL1 --\n SELECT E.EmpID, E.EmpName, E.Title,\n ISNULL(S.EmpName, ''(none)'') AS SuperiorName\n\nFROM Employee E\n LEFT OUTER JOIN ***B*** S\n ON ***C***\n\nWhen the SQL statement SQL1 is executed with the following sample data:\n\nEmployee table\n\nEmpID EmpName Title AssignedBranchID SuperiorEmpID\n 1001 Alice Receptionist 20 1003\n 1002 Bob Loan manager 10 NULL\n 1003 Charlie Loan examiner 10 1002\n 1004 Don Receptionist 30 1003\n\nFrom the sample data shown above, SQL1 outputs the following result:\n\nEmpID EmpName Title SuperiorName\n 1001 Alice Receptionist Charlie\n 1002 Bob Loan manager (none)\n 1003 Charlie Loan examiner Bob\n 1004 Don Receptionist Charlie\n\nAnswer group for B and C\n a) Account b) Customer\n c) E.EmpID = S.EmpID d) E.EmpID = S.SuperiorEmpID\n e) Employee f) S.EmpID = E.SuperiorEmpID\n g) S.SuperiorEmpID IS NOT NULL\n\n- 15 -\n\nSubquestion 3\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in the SQL statement SQL2.\n\nMr. C, an IT engineer trainee, is creating an SQL statement SQL2. The purpose of SQL2 is\n to output account IDs that were registered before 2020 and never used in 2020 and 2021. It\n is assumed that the Trans2Years table contains all transactions in 2020 and 2021 extracted\n from the Transaction table.\n To test the program, Mr. C provides the following sample data:\n\nAccount table\n\nAcctID CustID OpenDate BranchID EmpID LoanBalance\n 50001 3001 2016-08-26 20 1001 2534\n 50002 3002 2017-04-27 30 1004 0\n 50003 3001 2018-01-02 20 1001 2117\n 50004 3002 2019-09-19 30 1004 0\n 50005 3001 2020-04-16 20 1001 679\n 50006 3002 2021-01-10 30 1004 0\n\nTrans2Years table\n\nTransID TransDate TransType Amount AcctID\n 700001 2020-01-24 Restaurant 59 50003\n 700002 2020-04-21 Cashing 230 50005\n 700003 2020-05-09 Revolving 781 50001\n 700004 2021-01-19 Cashing 640 50001\n 700005 2021-06-07 Restaurant 62 50005\n 700006 2021-09-04 Revolving 862 50003\n\nFrom the sample data shown above, SQL2 should output the following result:\n\nAcctID\n 50002\n 50004\n\n- 16 -\n\nThe SQL statement SQL2 is as follows. At the moment, SQL2 is incomplete and contains\nerror(s).\nNote: The function YEAR(date) returns the four-digit year of the date as a number.\n\nLine No.\n 1 -- SQL2 --\n 2 SELECT A.AcctID\n 3 FROM Account A\n 4 WHERE EXISTS(SELECT *\n 5 FROM Trans2Years T\n 6 WHERE A.AcctID = T.AcctID)\n 7 AND YEAR(OpenDate) < 2020\n\nIf SQL2 shown above is executed, it outputs ***D***.\nTo output the correct result, SQL2 should be changed. Concretely, ***E***.\n\nAnswer group for D\n a) 2 rows of account IDs: 50001 and 50003\n b) 3 rows of account IDs: 50001, 50003 and 50005\n c) 3 rows of account IDs: 50002, 50004 and 50006\n d) 4 rows of account IDs: 50001, 50001, 50003 and 50003\n e) 4 rows of account IDs: 50002, 50002, 50004 and 50004"}]'::jsonb,
  '["2022-april-b-q03-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"change “Account A” to “Trans2Years T” on line 3, and\n change “Trans2Years T” to “Account A” on line 5"},{"label":"b","text":"change “EXISTS” to “IN” on line 4"},{"label":"c","text":"change “EXISTS” to “IN” on line 4,\n change “Account A” to “Trans2Years T” on line 3, and\n change “Trans2Years T” to “Account A” on line 5"},{"label":"d","text":"change “EXISTS” to “NOT EXISTS” on line 4"},{"label":"e","text":"change “EXISTS” to “NOT EXISTS” on line 4,\n change “Account A” to “Trans2Years T” on line 3, and\n change “Trans2Years T” to “Account A” on line 5\n\n - 17 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "c"}, {"subquestion": 2, "blank": "B", "answer": "e"}, {"subquestion": 2, "blank": "C", "answer": "f"}, {"subquestion": 3, "blank": "D", "answer": "a"}, {"subquestion": 3, "blank": "E", "answer": "d"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"c"},{"subquestion":2,"blank":"B","answer":"e"},{"subquestion":2,"blank":"C","answer":"f"},{"subquestion":3,"blank":"D","answer":"a"},{"subquestion":3,"blank":"E","answer":"d"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-B, Q3)',
  ARRAY[13,14,15,16,17]::int[],
  'native_text',
  '3.0',
  'Q3. Read the following description of a relational database schema, and then answer
 Subquestions 1 through 3.

 Company U has operated five large-scale shopping centers in the country since 2010. The
 customer support division of Company U issues various credit and loan cards for local
 customers, such as credit cards valid worldwide, credit cards valid only in the shopping
 centers, and prepaid discount cards valid only for restaurants in the shopping centers.
 When a customer wants to receive a card, he/she comes to one of the shopping centers, and
 submits an application for account registration. A customer can make an application for
 multiple types of cards. During the first account registration, customer registration is also
 carried out. Therefore, each registered customer has at least one account.
 For each account, an employee from the customer support division is assigned.
 Company U uses a relational database to manage shopping center operations. The relational
 database is composed of the following tables:

 Branch table
 BranchID BranchName BranchAddress

 Employee table
 EmpID EmpName Title AssignedBranchID SuperiorEmpID

 Customer table
 CustID CustName CustAddress

 Account table
 AcctID CustID OpenDate BranchID EmpID LoanBalance

 Transaction table
 TransID TransDate TransType Amount AcctID
 Note: Underline indicates the primary key and dotted-line indicates the foreign key.

 - 13 -

Subquestion 1
 From the answer group below, select the correct answer to be inserted in the blank _______
 in Figure 1.

 An entity relationship diagram (ERD) is a data modeling technique that graphically
 illustrates an information system’s entities and the relationships among those entities. The
 elements of an ERD are as follows: Entities, Relationships and Attributes.

 Figure 1 shows the ERD, and Table 1 shows the list of cardinality of the relationship.

 manages

 Employee has Transaction

 works Branch has

 has

 has

 has Account A has

 Customer

 Figure 1 Entity Relationship Diagram

 Table 1 List of cardinality of relationship

 Termination point Cardinality Existence Description
 One Mandatory Must exist, one and only one
 One Optional May exist, one, or none
 Many Mandatory Must exist, one or more
 Many Optional May exist, one or more or none

 Answer group for A
 a) b) c) d)

 - 14 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the SQL statement SQL1.

 The following SQL statement SQL1 outputs employees with the names of their superiors. If
 an employee has no superior, it displays “(none)” in the SuperiorName field.

 Note: The function ISNULL(expression, replacement) returns the value of replacement when
 the value of expression is NULL.
 LEFT OUTER JOIN returns all records from the left table, and the matched records
 from the right table. The result is NULL from the right side, if there is no match.

 -- SQL1 --
 SELECT E.EmpID, E.EmpName, E.Title,
 ISNULL(S.EmpName, ''(none)'') AS SuperiorName

 FROM Employee E
 LEFT OUTER JOIN ___B___ S
 ON ___C___

 When the SQL statement SQL1 is executed with the following sample data:

 Employee table

 EmpID EmpName Title AssignedBranchID SuperiorEmpID
 1001 Alice Receptionist 20 1003
 1002 Bob Loan manager 10 NULL
 1003 Charlie Loan examiner 10 1002
 1004 Don Receptionist 30 1003

 From the sample data shown above, SQL1 outputs the following result:

 EmpID EmpName Title SuperiorName
 1001 Alice Receptionist Charlie
 1002 Bob Loan manager (none)
 1003 Charlie Loan examiner Bob
 1004 Don Receptionist Charlie

 Answer group for B and C
 a) Account b) Customer
 c) E.EmpID = S.EmpID d) E.EmpID = S.SuperiorEmpID
 e) Employee f) S.EmpID = E.SuperiorEmpID
 g) S.SuperiorEmpID IS NOT NULL

 - 15 -

Subquestion 3
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the SQL statement SQL2.

 Mr. C, an IT engineer trainee, is creating an SQL statement SQL2. The purpose of SQL2 is
 to output account IDs that were registered before 2020 and never used in 2020 and 2021. It
 is assumed that the Trans2Years table contains all transactions in 2020 and 2021 extracted
 from the Transaction table.
 To test the program, Mr. C provides the following sample data:

 Account table

 AcctID CustID OpenDate BranchID EmpID LoanBalance
 50001 3001 2016-08-26 20 1001 2534
 50002 3002 2017-04-27 30 1004 0
 50003 3001 2018-01-02 20 1001 2117
 50004 3002 2019-09-19 30 1004 0
 50005 3001 2020-04-16 20 1001 679
 50006 3002 2021-01-10 30 1004 0

 Trans2Years table

 TransID TransDate TransType Amount AcctID
 700001 2020-01-24 Restaurant 59 50003
 700002 2020-04-21 Cashing 230 50005
 700003 2020-05-09 Revolving 781 50001
 700004 2021-01-19 Cashing 640 50001
 700005 2021-06-07 Restaurant 62 50005
 700006 2021-09-04 Revolving 862 50003

 From the sample data shown above, SQL2 should output the following result:

 AcctID
 50002
 50004

 - 16 -

The SQL statement SQL2 is as follows. At the moment, SQL2 is incomplete and contains
error(s).
Note: The function YEAR(date) returns the four-digit year of the date as a number.

 Line No.
 1 -- SQL2 --
 2 SELECT A.AcctID
 3 FROM Account A
 4 WHERE EXISTS(SELECT *
 5 FROM Trans2Years T
 6 WHERE A.AcctID = T.AcctID)
 7 AND YEAR(OpenDate) < 2020

If SQL2 shown above is executed, it outputs _____D_____.
To output the correct result, SQL2 should be changed. Concretely, _____E_____.

Answer group for D
 a) 2 rows of account IDs: 50001 and 50003
 b) 3 rows of account IDs: 50001, 50003 and 50005
 c) 3 rows of account IDs: 50002, 50004 and 50006
 d) 4 rows of account IDs: 50001, 50001, 50003 and 50003
 e) 4 rows of account IDs: 50002, 50002, 50004 and 50004

Answer group for E
 a) change “Account A” to “Trans2Years T” on line 3, and
 change “Trans2Years T” to “Account A” on line 5

 b) change “EXISTS” to “IN” on line 4

 c) change “EXISTS” to “IN” on line 4,
 change “Account A” to “Trans2Years T” on line 3, and
 change “Trans2Years T” to “Account A” on line 5

 d) change “EXISTS” to “NOT EXISTS” on line 4

 e) change “EXISTS” to “NOT EXISTS” on line 4,
 change “Account A” to “Trans2Years T” on line 3, and
 change “Trans2Years T” to “Account A” on line 5

 - 17 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/b/questions.pdf","pages":[13,14,15,16,17]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'B',
  4,
  'Q4. Read the following description of the establishment and termination process of TCP
 connections, and then answer Subquestions 1 and 2.

TCP (Transmission Control Protocol) is a transport layer protocol in the TCP/IP suite. It
 provides reliable data transmission using a connection-oriented mechanism to transport data
 for various application layer protocols over an IP (Internet Protocol) network.

[TCP connection establishment process]
 The connection must be established initially before the actual data transmission can take
 place. Figure 1 shows the TCP connection establishment process, which is called a threeway handshake.

client server

[1]

[2]

[3]

Figure 1 TCP connection establishment process

[1] First, the client establishes a connection by sending to the server a packet with the SYN
 flag set to 1. This packet contains the initial sequence number, which is a random
 number n set at the client side in the sequence number (SeqNo) field of the packet. It
 also supplies a maximum segment size (MSS) value and a TCP receive window (RWIN)
 value. MSS is the TCP option that specifies the largest segment size that the client will
 accept. RWIN is the size of the buffer for the incoming data.
 [2] Then, the server replies with a packet with both SYN and ACK flags set to 1. This
 packet includes the server generated arbitrary sequence number m and the
 acknowledgment number (AckNo) set to n + 1 to follow up the sequence number in the
 first SYN request. The server also supplies its own MSS and RWIN values to advertise
 its capacity.
 [3] Finally, the client replies with another packet with the ACK flag set to 1. Here, the value
 of AckNo is set to m + 1 in accordance with the server’s sequence number.

- 18 -

At this point, three-way handshake is complete and the connection is established. The MSS
that both parties can handle is known by both parties, and a smaller number will be used to
ensure that both sides are able to handle it. Both parties also know each other’s receiving
buffer capacity (RWIN) and will be able to send data within the limitation. Although the
party establishing the connection here is designated as the client, both parties can equally
send and receive data in subsequent transmissions until the connection is terminated. The
four-way handshake TCP connection termination process is shown later.

[Sequence number and Acknowledgment number]
TCP uses sequence numbers and acknowledgment numbers to ensure reliable
communication. Figure 2 shows how the server sends a total of 30 bytes of data to the client,
divided into 10 and 20 bytes.

client server

[4]

[5]

[6]

[7]

Figure 2 Sequence numbers and Acknowledgment numbers

[4] The server sends 10 bytes of data to the client. The sequence number p indicates the
 current sequence of the data, which started from the initial sequence number n in step
 [1] and increased continuously with each data packet previously sent during the
 connection. The acknowledgment number q is also the value response to the latest
 sequence number from the client in the same fashion.
[5] The client acknowledges the data by sending a packet with the ACK flag set along with
 the acknowledgment number p + 10. It also indicates that the client expects p + 10 as the
 sequence number of the next packet from the server.
[6] The server sends 20 bytes of data to the client. The sequence number is p + 10. The
 acknowledgment number is maintained as q because the server has not received any
 data from the client.

- 19 -

[7] The client acknowledges the data again by sending a packet with the ACK flag set along
 with the acknowledgment number p + 30.

Packets with data consume sequence numbers according to their data length, as described
earlier. Note that packets with the SYN or FIN flag also consume sequence number by 1 as
seen in steps [1] through [3] and steps [8] through [11]; however, packets with only an ACK
flag do not consume sequence number.

[TCP connection termination process]
Figure 3 shows the termination process of a TCP connection.
 client server

[8]

[9]

[10]

[11]

Figure 3 TCP connection termination process

Although it is illustrated here that the termination request is initiated from the server side,
either side can send a packet with the FIN flag set to 1 to request a connection termination
if it has no more data to send. Figure 3 indicates that the client acknowledges the termination
request from the server side. However, if the client has more data to send, the communication
continues as represented by the dashed lines.

The overall process can be described as follows:
[8] The server sends a FIN flagged packet to notify the client that it wishes to terminate the
 connection. The sequence number is r and the acknowledgment number is s.

- 20 -

[9] The client acknowledges the termination request by sending a packet with the ACK flag
 set along with the acknowledgment number r + 1. At this point, the connection is half
 closed and the server will not be able to send data. However, the client can continue to
 send data segments as needed, and the server will respond with the corresponding
 acknowledgment numbers accordingly.
[10] Once the client finishes sending all its data, it also sends back to the server a packet
 with the FIN flag set along with its current sequence number t and the acknowledgment
 number r + 1. Note that the acknowledgment number remains the same. This is because
 there are no more data segments from the server side because it is already half closed.
[11] To finalize the termination process, the server sends back to the client the final ACK
 packet with the acknowledgment number t + 1.

To illustrate the working of these processes, consider a client connecting to a Daytime server
to obtain the current date and time value.
(1) The client initiates the connection from its TCP port number 55133 to the server by
 sending a SYN packet with SeqNo = 20, MSS = 1460, and RWIN = 65535.
(2) The server responds with a SYN/ACK packet with SeqNo = 10, AckNo = 21, MSS =
 1240, and RWIN = 8192.
(3) The client completes the three-way handshake process by sending an ACK packet with
 AckNo = 11.
(4) At this point, the TCP connection is established and both parties know each other’s
 capabilities, and will be able to perform data transmission accordingly. The segment size
 of the subsequent transmission is agreed upon and set to ***A*** bytes.
(5) The server sends back to the client a date and time value which is 22 bytes long along
 with SeqNo =11.
(6) After the client receives the data, it responds with an ACK packet that has an
 acknowledgment number equals to the server’s SeqNo plus the size of the data, which
 increases the AckNo to 33.
(7) In this case, the server starts the connection termination process once it receives the
 acknowledgment from the client. Thus, a FIN packet is sent from the server with SeqNo
 = ***B*** and AckNo = 21.
(8) The client responds with a/an ***C*** packet with AckNo = 34. Then, because the
 daytime operation is completed, the client also sends a/an ***D*** packet to the
 server with SeqNo = ***E*** and AckNo = 34.
(9) The server completes the four-way handshake termination process by sending an ACK
 packet with AckNo = 22.

- 21 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above description.

Answer group for A
 a) 1240 b) 1460 c) 8192
 d) 55133 e) 65535

Answer group for B and E
 a) 11 b) 12 c) 21
 d) 22 e) 33 f) 34

Answer group for C and D
 a) ACK b) FIN c) SYN d) SYN/ACK

Subquestion 2
 During the connection establishment process, it is possible that malicious clients may keep
 sending SYN packets to the server without supplying ACK packets to complete the threeway handshake. Without the acknowledgment from the client, these requests will remain in
 the incoming connection queue of the server until it times out. This is called SYN flooding
 and it may prevent the server from responding to legitimate SYN requests.
 From the answer group below, select the appropriate characteristic or the cause of concern
 regarding SYN flooding.',
  '[{"type":"prompt","text":"Q4. Read the following description of the establishment and termination process of TCP\n connections, and then answer Subquestions 1 and 2."},{"type":"context","text":"TCP (Transmission Control Protocol) is a transport layer protocol in the TCP/IP suite. It\n provides reliable data transmission using a connection-oriented mechanism to transport data\n for various application layer protocols over an IP (Internet Protocol) network.\n\n[TCP connection establishment process]\n The connection must be established initially before the actual data transmission can take\n place. Figure 1 shows the TCP connection establishment process, which is called a threeway handshake.\n\nclient server\n\n[1]\n\n[2]\n\n[3]\n\nFigure 1 TCP connection establishment process\n\n[1] First, the client establishes a connection by sending to the server a packet with the SYN\n flag set to 1. This packet contains the initial sequence number, which is a random\n number n set at the client side in the sequence number (SeqNo) field of the packet. It\n also supplies a maximum segment size (MSS) value and a TCP receive window (RWIN)\n value. MSS is the TCP option that specifies the largest segment size that the client will\n accept. RWIN is the size of the buffer for the incoming data.\n [2] Then, the server replies with a packet with both SYN and ACK flags set to 1. This\n packet includes the server generated arbitrary sequence number m and the\n acknowledgment number (AckNo) set to n + 1 to follow up the sequence number in the\n first SYN request. The server also supplies its own MSS and RWIN values to advertise\n its capacity.\n [3] Finally, the client replies with another packet with the ACK flag set to 1. Here, the value\n of AckNo is set to m + 1 in accordance with the server’s sequence number.\n\n- 18 -\n\nAt this point, three-way handshake is complete and the connection is established. The MSS\nthat both parties can handle is known by both parties, and a smaller number will be used to\nensure that both sides are able to handle it. Both parties also know each other’s receiving\nbuffer capacity (RWIN) and will be able to send data within the limitation. Although the\nparty establishing the connection here is designated as the client, both parties can equally\nsend and receive data in subsequent transmissions until the connection is terminated. The\nfour-way handshake TCP connection termination process is shown later.\n\n[Sequence number and Acknowledgment number]\nTCP uses sequence numbers and acknowledgment numbers to ensure reliable\ncommunication. Figure 2 shows how the server sends a total of 30 bytes of data to the client,\ndivided into 10 and 20 bytes.\n\nclient server\n\n[4]\n\n[5]\n\n[6]\n\n[7]\n\nFigure 2 Sequence numbers and Acknowledgment numbers\n\n[4] The server sends 10 bytes of data to the client. The sequence number p indicates the\n current sequence of the data, which started from the initial sequence number n in step\n [1] and increased continuously with each data packet previously sent during the\n connection. The acknowledgment number q is also the value response to the latest\n sequence number from the client in the same fashion.\n[5] The client acknowledges the data by sending a packet with the ACK flag set along with\n the acknowledgment number p + 10. It also indicates that the client expects p + 10 as the\n sequence number of the next packet from the server.\n[6] The server sends 20 bytes of data to the client. The sequence number is p + 10. The\n acknowledgment number is maintained as q because the server has not received any\n data from the client.\n\n- 19 -\n\n[7] The client acknowledges the data again by sending a packet with the ACK flag set along\n with the acknowledgment number p + 30.\n\nPackets with data consume sequence numbers according to their data length, as described\nearlier. Note that packets with the SYN or FIN flag also consume sequence number by 1 as\nseen in steps [1] through [3] and steps [8] through [11]; however, packets with only an ACK\nflag do not consume sequence number.\n\n[TCP connection termination process]\nFigure 3 shows the termination process of a TCP connection.\n client server\n\n[8]\n\n[9]\n\n[10]\n\n[11]\n\nFigure 3 TCP connection termination process\n\nAlthough it is illustrated here that the termination request is initiated from the server side,\neither side can send a packet with the FIN flag set to 1 to request a connection termination\nif it has no more data to send. Figure 3 indicates that the client acknowledges the termination\nrequest from the server side. However, if the client has more data to send, the communication\ncontinues as represented by the dashed lines.\n\nThe overall process can be described as follows:\n[8] The server sends a FIN flagged packet to notify the client that it wishes to terminate the\n connection. The sequence number is r and the acknowledgment number is s.\n\n- 20 -\n\n[9] The client acknowledges the termination request by sending a packet with the ACK flag\n set along with the acknowledgment number r + 1. At this point, the connection is half\n closed and the server will not be able to send data. However, the client can continue to\n send data segments as needed, and the server will respond with the corresponding\n acknowledgment numbers accordingly.\n[10] Once the client finishes sending all its data, it also sends back to the server a packet\n with the FIN flag set along with its current sequence number t and the acknowledgment\n number r + 1. Note that the acknowledgment number remains the same. This is because\n there are no more data segments from the server side because it is already half closed.\n[11] To finalize the termination process, the server sends back to the client the final ACK\n packet with the acknowledgment number t + 1.\n\nTo illustrate the working of these processes, consider a client connecting to a Daytime server\nto obtain the current date and time value.\n(1) The client initiates the connection from its TCP port number 55133 to the server by\n sending a SYN packet with SeqNo = 20, MSS = 1460, and RWIN = 65535.\n(2) The server responds with a SYN/ACK packet with SeqNo = 10, AckNo = 21, MSS =\n 1240, and RWIN = 8192.\n(3) The client completes the three-way handshake process by sending an ACK packet with\n AckNo = 11.\n(4) At this point, the TCP connection is established and both parties know each other’s\n capabilities, and will be able to perform data transmission accordingly. The segment size\n of the subsequent transmission is agreed upon and set to ***A*** bytes.\n(5) The server sends back to the client a date and time value which is 22 bytes long along\n with SeqNo =11.\n(6) After the client receives the data, it responds with an ACK packet that has an\n acknowledgment number equals to the server’s SeqNo plus the size of the data, which\n increases the AckNo to 33.\n(7) In this case, the server starts the connection termination process once it receives the\n acknowledgment from the client. Thus, a FIN packet is sent from the server with SeqNo\n = ***B*** and AckNo = 21.\n(8) The client responds with a/an ***C*** packet with AckNo = 34. Then, because the\n daytime operation is completed, the client also sends a/an ***D*** packet to the\n server with SeqNo = ***E*** and AckNo = 34.\n(9) The server completes the four-way handshake termination process by sending an ACK\n packet with AckNo = 22.\n\n- 21 -\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the above description.\n\nAnswer group for A\n a) 1240 b) 1460 c) 8192\n d) 55133 e) 65535\n\nAnswer group for B and E\n a) 11 b) 12 c) 21\n d) 22 e) 33 f) 34\n\nAnswer group for C and D\n a) ACK b) FIN c) SYN d) SYN/ACK\n\nSubquestion 2\n During the connection establishment process, it is possible that malicious clients may keep\n sending SYN packets to the server without supplying ACK packets to complete the threeway handshake. Without the acknowledgment from the client, these requests will remain in\n the incoming connection queue of the server until it times out. This is called SYN flooding\n and it may prevent the server from responding to legitimate SYN requests.\n From the answer group below, select the appropriate characteristic or the cause of concern\n regarding SYN flooding."}]'::jsonb,
  '["2022-april-b-q04-figure1.webp","2022-april-b-q04-figure2.webp","2022-april-b-q04-figure3.webp"]'::jsonb,
  '[{"label":"a","text":"During a SYN flooding attack, the server under attack is unable to initiate an outgoing\n TCP connection to another host because its outgoing connection queue is already\n overwhelmed with large numbers of incoming SYN requests."},{"label":"b","text":"It is possible to reduce the effects of SYN flooding by increasing the timeout value\n that controls how long the system should wait for an ACK as this method helps to\n improve the stability of legitimate clients with slower links."},{"label":"c","text":"Owing to the connection-oriented nature of TCP, SYN flooding will potentially\n prevent new clients from connecting to the server rather than disconnecting already\n established connections."},{"label":"d","text":"To stop an ongoing SYN flooding attack, the server’s administrator must restore the\n system from a backup because the system may be damaged owing to the\n overwhelming number of unsuccessful three-way handshake attempts.\n\n - 22 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "a"}, {"subquestion": 1, "blank": "B", "answer": "e"}, {"subquestion": 1, "blank": "C", "answer": "a"}, {"subquestion": 1, "blank": "D", "answer": "b"}, {"subquestion": 1, "blank": "E", "answer": "c"}, {"subquestion": 2, "blank": "F", "answer": "c"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"a"},{"subquestion":1,"blank":"B","answer":"e"},{"subquestion":1,"blank":"C","answer":"a"},{"subquestion":1,"blank":"D","answer":"b"},{"subquestion":1,"blank":"E","answer":"c"},{"subquestion":2,"blank":"F","answer":"c"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-B, Q4)',
  ARRAY[18,19,20,21,22]::int[],
  'native_text',
  '3.0',
  'Q4. Read the following description of the establishment and termination process of TCP
 connections, and then answer Subquestions 1 and 2.

 TCP (Transmission Control Protocol) is a transport layer protocol in the TCP/IP suite. It
 provides reliable data transmission using a connection-oriented mechanism to transport data
 for various application layer protocols over an IP (Internet Protocol) network.

 [TCP connection establishment process]
 The connection must be established initially before the actual data transmission can take
 place. Figure 1 shows the TCP connection establishment process, which is called a threeway handshake.

 client server

 [1]

 [2]

 [3]

 Figure 1 TCP connection establishment process

 [1] First, the client establishes a connection by sending to the server a packet with the SYN
 flag set to 1. This packet contains the initial sequence number, which is a random
 number n set at the client side in the sequence number (SeqNo) field of the packet. It
 also supplies a maximum segment size (MSS) value and a TCP receive window (RWIN)
 value. MSS is the TCP option that specifies the largest segment size that the client will
 accept. RWIN is the size of the buffer for the incoming data.
 [2] Then, the server replies with a packet with both SYN and ACK flags set to 1. This
 packet includes the server generated arbitrary sequence number m and the
 acknowledgment number (AckNo) set to n + 1 to follow up the sequence number in the
 first SYN request. The server also supplies its own MSS and RWIN values to advertise
 its capacity.
 [3] Finally, the client replies with another packet with the ACK flag set to 1. Here, the value
 of AckNo is set to m + 1 in accordance with the server’s sequence number.

 - 18 -

At this point, three-way handshake is complete and the connection is established. The MSS
that both parties can handle is known by both parties, and a smaller number will be used to
ensure that both sides are able to handle it. Both parties also know each other’s receiving
buffer capacity (RWIN) and will be able to send data within the limitation. Although the
party establishing the connection here is designated as the client, both parties can equally
send and receive data in subsequent transmissions until the connection is terminated. The
four-way handshake TCP connection termination process is shown later.

[Sequence number and Acknowledgment number]
TCP uses sequence numbers and acknowledgment numbers to ensure reliable
communication. Figure 2 shows how the server sends a total of 30 bytes of data to the client,
divided into 10 and 20 bytes.

 client server

 [4]

 [5]

 [6]

 [7]

 Figure 2 Sequence numbers and Acknowledgment numbers

[4] The server sends 10 bytes of data to the client. The sequence number p indicates the
 current sequence of the data, which started from the initial sequence number n in step
 [1] and increased continuously with each data packet previously sent during the
 connection. The acknowledgment number q is also the value response to the latest
 sequence number from the client in the same fashion.
[5] The client acknowledges the data by sending a packet with the ACK flag set along with
 the acknowledgment number p + 10. It also indicates that the client expects p + 10 as the
 sequence number of the next packet from the server.
[6] The server sends 20 bytes of data to the client. The sequence number is p + 10. The
 acknowledgment number is maintained as q because the server has not received any
 data from the client.

 - 19 -

[7] The client acknowledges the data again by sending a packet with the ACK flag set along
 with the acknowledgment number p + 30.

Packets with data consume sequence numbers according to their data length, as described
earlier. Note that packets with the SYN or FIN flag also consume sequence number by 1 as
seen in steps [1] through [3] and steps [8] through [11]; however, packets with only an ACK
flag do not consume sequence number.

[TCP connection termination process]
Figure 3 shows the termination process of a TCP connection.
 client server

 [8]

 [9]

 [10]

 [11]

 Figure 3 TCP connection termination process

Although it is illustrated here that the termination request is initiated from the server side,
either side can send a packet with the FIN flag set to 1 to request a connection termination
if it has no more data to send. Figure 3 indicates that the client acknowledges the termination
request from the server side. However, if the client has more data to send, the communication
continues as represented by the dashed lines.

The overall process can be described as follows:
[8] The server sends a FIN flagged packet to notify the client that it wishes to terminate the
 connection. The sequence number is r and the acknowledgment number is s.

 - 20 -

[9] The client acknowledges the termination request by sending a packet with the ACK flag
 set along with the acknowledgment number r + 1. At this point, the connection is half
 closed and the server will not be able to send data. However, the client can continue to
 send data segments as needed, and the server will respond with the corresponding
 acknowledgment numbers accordingly.
[10] Once the client finishes sending all its data, it also sends back to the server a packet
 with the FIN flag set along with its current sequence number t and the acknowledgment
 number r + 1. Note that the acknowledgment number remains the same. This is because
 there are no more data segments from the server side because it is already half closed.
[11] To finalize the termination process, the server sends back to the client the final ACK
 packet with the acknowledgment number t + 1.

To illustrate the working of these processes, consider a client connecting to a Daytime server
to obtain the current date and time value.
(1) The client initiates the connection from its TCP port number 55133 to the server by
 sending a SYN packet with SeqNo = 20, MSS = 1460, and RWIN = 65535.
(2) The server responds with a SYN/ACK packet with SeqNo = 10, AckNo = 21, MSS =
 1240, and RWIN = 8192.
(3) The client completes the three-way handshake process by sending an ACK packet with
 AckNo = 11.
(4) At this point, the TCP connection is established and both parties know each other’s
 capabilities, and will be able to perform data transmission accordingly. The segment size
 of the subsequent transmission is agreed upon and set to ___A___ bytes.
(5) The server sends back to the client a date and time value which is 22 bytes long along
 with SeqNo =11.
(6) After the client receives the data, it responds with an ACK packet that has an
 acknowledgment number equals to the server’s SeqNo plus the size of the data, which
 increases the AckNo to 33.
(7) In this case, the server starts the connection termination process once it receives the
 acknowledgment from the client. Thus, a FIN packet is sent from the server with SeqNo
 = ___B___ and AckNo = 21.
(8) The client responds with a/an ___C___ packet with AckNo = 34. Then, because the
 daytime operation is completed, the client also sends a/an ___D___ packet to the
 server with SeqNo = ___E___ and AckNo = 34.
(9) The server completes the four-way handshake termination process by sending an ACK
 packet with AckNo = 22.

 - 21 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above description.

 Answer group for A
 a) 1240 b) 1460 c) 8192
 d) 55133 e) 65535

 Answer group for B and E
 a) 11 b) 12 c) 21
 d) 22 e) 33 f) 34

 Answer group for C and D
 a) ACK b) FIN c) SYN d) SYN/ACK

Subquestion 2
 During the connection establishment process, it is possible that malicious clients may keep
 sending SYN packets to the server without supplying ACK packets to complete the threeway handshake. Without the acknowledgment from the client, these requests will remain in
 the incoming connection queue of the server until it times out. This is called SYN flooding
 and it may prevent the server from responding to legitimate SYN requests.
 From the answer group below, select the appropriate characteristic or the cause of concern
 regarding SYN flooding.

 Answer group
 a) During a SYN flooding attack, the server under attack is unable to initiate an outgoing
 TCP connection to another host because its outgoing connection queue is already
 overwhelmed with large numbers of incoming SYN requests.
 b) It is possible to reduce the effects of SYN flooding by increasing the timeout value
 that controls how long the system should wait for an ACK as this method helps to
 improve the stability of legitimate clients with slower links.
 c) Owing to the connection-oriented nature of TCP, SYN flooding will potentially
 prevent new clients from connecting to the server rather than disconnecting already
 established connections.
 d) To stop an ongoing SYN flooding attack, the server’s administrator must restore the
 system from a backup because the system may be damaged owing to the
 overwhelming number of unsuccessful three-way handshake attempts.

 - 22 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/b/questions.pdf","pages":[18,19,20,21,22]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'B',
  5,
  'Q5. Read the following description of an information system in a university, and then answer
 Subquestions 1 through 3.

Student Event Calendar (hereinafter, SEC) is a system that brings students closer to events
 and extra-curricular activities taking place at University W. The system provides information
 about all the events taking place at University W in an intuitive form that allows students to
 track events quickly. With SEC, students have opportunities to write comments and provide
 feedback on events so that the university can collect data and improve the quality of future
 events.

The system has four types of users:
 o Students: Students who are studying in University W and who desire to join the events in
 University W to improve their general skills or to expand their human network.
 o Organizers: A subset of the students who are leaders of some clubs in University W. They
 can represent their clubs and make decisions regarding the organization of some events.
 An Organizer creates event information, updates it, and submits it to a Manager. After
 the event ends, the Organizer reports the execution result of the event.
 o Managers: Staff members of the personal development department of University W.
 Managers review event information and either approve or reject it. Approved event
 information is public and open to the students. Rejected event information is sent to the
 Organizer who can update it and resubmit it to the Manager.
 Managers can keep track of all event information in order to gain insight about the
 activities associated with all events during a given period.
 o Administrators: Staff members of the personal development department of University W.
 Administrators manage users on the SEC system. When a student becomes the leader
 of a club, the Administrator grants the Organizer the authority to organize events.

Figure 1 shows the use case diagram of the SEC system that focuses on the main functions.
 Table 1 shows the description of use cases that are used in Figure 1. Some use cases are used
 for multiple types of users, and others are used for only a specific type of user.

- 23 -

A Student Administrator

B C Manager
 Notify
 Organizer

Note: Shaded parts are not shown.

Figure 1 Use case diagram of SEC system

Table 1 Use case description

Use case Description
 Create information Creates information about an event.
 Report result After the event, the Organizer reports results, issues, etc.
 Review information Reviews the event information.
 Set authority for the Organizer Sets the authority to organize events.
 Update information Updates the event information.
 View events Views detailed information of the events in University W.

Subquestion 1
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Figure 1.

Answer group for A through C
 a) Create information
 b) Report result
 c) Review information
 d) Set authority for the Organizer
 e) Update information
 f) View events

- 24 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Figure 2.

The process of organizing an event is as follows:
 (1) An Organizer creates event information by filling out the form with event information
 that contains the organization plan and inputs the form into the SEC system.
 (2) The SEC system verifies the information systematically by checking the database for
 reasonableness in terms of the budget and availability of equipment to determine
 whether the required equipment is needed by other similar events that overlap with the
 time period. After the information is verified, the SEC system sends the information to
 a specific Manager.
 (3) The Manager reviews the event information and decides to approve or reject the event.
 If the Manager approves the event information, the event is published. If the event is
 rejected, comments and recommendations on the organization plan are sent back to the
 Organizer so that the Organizer can identify the problems in the organization plan. After
 that, the Organizer updates the event information and resubmits it.
 (4) The Organizer can modify the information whenever the need arises even after it has
 been published. The updated information must be reviewed by the Manager.
 (5) After the event is over, the Organizer reports the result of the event to the Manager.

Figure 2 shows the activity diagram of publicizing an event. It starts from the Organizer
 when he/she begins to create an event. The SEC system is responsible for managing the
 database and controlling the communication between the Organizer and Manager.

- 25 -

Organizer SEC System Manager

Create event D

No
 OK

Yes

Send information Review information

Reject
 Update information Result

Approve
 Receive notification E

Send report Publish report

Figure 2 Activity diagram of publicizing an event

Answer group for D and E
 a) Publish information
 b) Remove information
 c) Review information into the database
 d) Send information to Organizer
 e) Update information
 f) Verify information

- 26 -

Subquestion 3
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Figure 3. Here, the answers to be inserted in F1 and F2 should be selected as
 the correct combination from the answer group for F.

Figure 3 shows the event information state chart from the event planning to the event end.
 In Figure 3, a rectangular indicates a state and an arrow indicates a state transition.

create
 remove Creation
 submit reject

First Review
 approve

Published
 update finish event (to the state F1 )
 remove Update
 submit reject

Update Review

approve (to the state F2 )

Waiting for report
 report result

Figure 3 Event information state chart',
  '[{"type":"prompt","text":"Q5. Read the following description of an information system in a university, and then answer\n Subquestions 1 through 3."},{"type":"context","text":"Student Event Calendar (hereinafter, SEC) is a system that brings students closer to events\n and extra-curricular activities taking place at University W. The system provides information\n about all the events taking place at University W in an intuitive form that allows students to\n track events quickly. With SEC, students have opportunities to write comments and provide\n feedback on events so that the university can collect data and improve the quality of future\n events.\n\nThe system has four types of users:\n o Students: Students who are studying in University W and who desire to join the events in\n University W to improve their general skills or to expand their human network.\n o Organizers: A subset of the students who are leaders of some clubs in University W. They\n can represent their clubs and make decisions regarding the organization of some events.\n An Organizer creates event information, updates it, and submits it to a Manager. After\n the event ends, the Organizer reports the execution result of the event.\n o Managers: Staff members of the personal development department of University W.\n Managers review event information and either approve or reject it. Approved event\n information is public and open to the students. Rejected event information is sent to the\n Organizer who can update it and resubmit it to the Manager.\n Managers can keep track of all event information in order to gain insight about the\n activities associated with all events during a given period.\n o Administrators: Staff members of the personal development department of University W.\n Administrators manage users on the SEC system. When a student becomes the leader\n of a club, the Administrator grants the Organizer the authority to organize events.\n\nFigure 1 shows the use case diagram of the SEC system that focuses on the main functions.\n Table 1 shows the description of use cases that are used in Figure 1. Some use cases are used\n for multiple types of users, and others are used for only a specific type of user.\n\n- 23 -\n\nA Student Administrator\n\nB C Manager\n Notify\n Organizer\n\nNote: Shaded parts are not shown.\n\nFigure 1 Use case diagram of SEC system\n\nTable 1 Use case description\n\nUse case Description\n Create information Creates information about an event.\n Report result After the event, the Organizer reports results, issues, etc.\n Review information Reviews the event information.\n Set authority for the Organizer Sets the authority to organize events.\n Update information Updates the event information.\n View events Views detailed information of the events in University W.\n\nSubquestion 1\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in Figure 1.\n\nAnswer group for A through C\n a) Create information\n b) Report result\n c) Review information\n d) Set authority for the Organizer\n e) Update information\n f) View events\n\n- 24 -\n\nSubquestion 2\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in Figure 2.\n\nThe process of organizing an event is as follows:\n (1) An Organizer creates event information by filling out the form with event information\n that contains the organization plan and inputs the form into the SEC system.\n (2) The SEC system verifies the information systematically by checking the database for\n reasonableness in terms of the budget and availability of equipment to determine\n whether the required equipment is needed by other similar events that overlap with the\n time period. After the information is verified, the SEC system sends the information to\n a specific Manager.\n (3) The Manager reviews the event information and decides to approve or reject the event.\n If the Manager approves the event information, the event is published. If the event is\n rejected, comments and recommendations on the organization plan are sent back to the\n Organizer so that the Organizer can identify the problems in the organization plan. After\n that, the Organizer updates the event information and resubmits it.\n (4) The Organizer can modify the information whenever the need arises even after it has\n been published. The updated information must be reviewed by the Manager.\n (5) After the event is over, the Organizer reports the result of the event to the Manager.\n\nFigure 2 shows the activity diagram of publicizing an event. It starts from the Organizer\n when he/she begins to create an event. The SEC system is responsible for managing the\n database and controlling the communication between the Organizer and Manager.\n\n- 25 -\n\nOrganizer SEC System Manager\n\nCreate event D\n\nNo\n OK\n\nYes\n\nSend information Review information\n\nReject\n Update information Result\n\nApprove\n Receive notification E\n\nSend report Publish report\n\nFigure 2 Activity diagram of publicizing an event\n\nAnswer group for D and E\n a) Publish information\n b) Remove information\n c) Review information into the database\n d) Send information to Organizer\n e) Update information\n f) Verify information\n\n- 26 -\n\nSubquestion 3\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in Figure 3. Here, the answers to be inserted in F1 and F2 should be selected as\n the correct combination from the answer group for F.\n\nFigure 3 shows the event information state chart from the event planning to the event end.\n In Figure 3, a rectangular indicates a state and an arrow indicates a state transition.\n\ncreate\n remove Creation\n submit reject\n\nFirst Review\n approve\n\nPublished\n update finish event (to the state F1 )\n remove Update\n submit reject\n\nUpdate Review\n\napprove (to the state F2 )\n\nWaiting for report\n report result\n\nFigure 3 Event information state chart"}]'::jsonb,
  '["2022-april-b-q05-figure1.webp","2022-april-b-q05-figure2.webp","2022-april-b-q05-figure3.webp"]'::jsonb,
  '[{"label":"a","text":"Waiting for report Published"},{"label":"b","text":"Waiting for report Update"},{"label":"c","text":"Waiting for report Waiting for report"},{"label":"d","text":"Published"},{"label":"e","text":"Update"},{"label":"f","text":"Waiting for report\n\n - 27 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "d"}, {"subquestion": 1, "blank": "B", "answer": "e"}, {"subquestion": 1, "blank": "C", "answer": "c"}, {"subquestion": 2, "blank": "D", "answer": "f"}, {"subquestion": 2, "blank": "E", "answer": "a"}, {"subquestion": 3, "blank": "F", "answer": "a"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"d"},{"subquestion":1,"blank":"B","answer":"e"},{"subquestion":1,"blank":"C","answer":"c"},{"subquestion":2,"blank":"D","answer":"f"},{"subquestion":2,"blank":"E","answer":"a"},{"subquestion":3,"blank":"F","answer":"a"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-B, Q5)',
  ARRAY[23,24,25,26,27]::int[],
  'native_text',
  '3.0',
  'Q5. Read the following description of an information system in a university, and then answer
 Subquestions 1 through 3.

 Student Event Calendar (hereinafter, SEC) is a system that brings students closer to events
 and extra-curricular activities taking place at University W. The system provides information
 about all the events taking place at University W in an intuitive form that allows students to
 track events quickly. With SEC, students have opportunities to write comments and provide
 feedback on events so that the university can collect data and improve the quality of future
 events.

 The system has four types of users:
 o Students: Students who are studying in University W and who desire to join the events in
 University W to improve their general skills or to expand their human network.
 o Organizers: A subset of the students who are leaders of some clubs in University W. They
 can represent their clubs and make decisions regarding the organization of some events.
 An Organizer creates event information, updates it, and submits it to a Manager. After
 the event ends, the Organizer reports the execution result of the event.
 o Managers: Staff members of the personal development department of University W.
 Managers review event information and either approve or reject it. Approved event
 information is public and open to the students. Rejected event information is sent to the
 Organizer who can update it and resubmit it to the Manager.
 Managers can keep track of all event information in order to gain insight about the
 activities associated with all events during a given period.
 o Administrators: Staff members of the personal development department of University W.
 Administrators manage users on the SEC system. When a student becomes the leader
 of a club, the Administrator grants the Organizer the authority to organize events.

 Figure 1 shows the use case diagram of the SEC system that focuses on the main functions.
 Table 1 shows the description of use cases that are used in Figure 1. Some use cases are used
 for multiple types of users, and others are used for only a specific type of user.

 - 23 -

A Student Administrator

 B C Manager
 Notify
 Organizer

 Note: Shaded parts are not shown.

 Figure 1 Use case diagram of SEC system

 Table 1 Use case description

 Use case Description
 Create information Creates information about an event.
 Report result After the event, the Organizer reports results, issues, etc.
 Review information Reviews the event information.
 Set authority for the Organizer Sets the authority to organize events.
 Update information Updates the event information.
 View events Views detailed information of the events in University W.

Subquestion 1
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Figure 1.

 Answer group for A through C
 a) Create information
 b) Report result
 c) Review information
 d) Set authority for the Organizer
 e) Update information
 f) View events

 - 24 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Figure 2.

 The process of organizing an event is as follows:
 (1) An Organizer creates event information by filling out the form with event information
 that contains the organization plan and inputs the form into the SEC system.
 (2) The SEC system verifies the information systematically by checking the database for
 reasonableness in terms of the budget and availability of equipment to determine
 whether the required equipment is needed by other similar events that overlap with the
 time period. After the information is verified, the SEC system sends the information to
 a specific Manager.
 (3) The Manager reviews the event information and decides to approve or reject the event.
 If the Manager approves the event information, the event is published. If the event is
 rejected, comments and recommendations on the organization plan are sent back to the
 Organizer so that the Organizer can identify the problems in the organization plan. After
 that, the Organizer updates the event information and resubmits it.
 (4) The Organizer can modify the information whenever the need arises even after it has
 been published. The updated information must be reviewed by the Manager.
 (5) After the event is over, the Organizer reports the result of the event to the Manager.

 Figure 2 shows the activity diagram of publicizing an event. It starts from the Organizer
 when he/she begins to create an event. The SEC system is responsible for managing the
 database and controlling the communication between the Organizer and Manager.

 - 25 -

Organizer SEC System Manager

 Create event D

 No
 OK

 Yes

 Send information Review information

 Reject
 Update information Result

 Approve
 Receive notification E

 Send report Publish report

 Figure 2 Activity diagram of publicizing an event

Answer group for D and E
 a) Publish information
 b) Remove information
 c) Review information into the database
 d) Send information to Organizer
 e) Update information
 f) Verify information

 - 26 -

Subquestion 3
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Figure 3. Here, the answers to be inserted in F1 and F2 should be selected as
 the correct combination from the answer group for F.

 Figure 3 shows the event information state chart from the event planning to the event end.
 In Figure 3, a rectangular indicates a state and an arrow indicates a state transition.

 create
 remove Creation
 submit reject

 First Review
 approve

 Published
 update finish event (to the state F1 )
 remove Update
 submit reject

 Update Review

 approve (to the state F2 )

 Waiting for report
 report result

 Figure 3 Event information state chart

 Answer group for F

 F1 F2
 a) Waiting for report Published
 b) Waiting for report Update
 c) Waiting for report Waiting for report
 d) Published
 e) Update
 f) Waiting for report

 - 27 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/b/questions.pdf","pages":[23,24,25,26,27]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'B',
  6,
  'Q6. Read the following description of bit processing programs, and then answer Subquestions
 1 and 2.

The function BitTest tests the bit values of the bits in an 8-bit data selected by a mask, and
 the function BitCount counts the number of bits whose values are 1’s in an 8-bit data.

In this question, the following additional pseudo-language notations are used:
 o The operators “&” and “|” obtain the logical product and logical sum, respectively, for
 each pair of bits in the corresponding bit positions of two 8-bit binary-type data, and
 obtain an 8-bit binary-type result.
 o The notation ''....''B such as ''1''B and ''11111110’B expresses a binary-type constant.
 o The selection processes (IF / ELSE) are coded without using curly braces { } in
 accordance with the language specifications of C and Java.

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description and Program 1.

[Description of the function BitTest]
 The function BitTest tests the bit values of the bits in an 8-bit data selected by a mask and
 returns the result.
 The function BitTest is declared as follows:

FUNCTION: BitTest(8-bit Binary: Data, 8-bit Binary: Mask)
 The argument Data contains an 8-bit data to be tested, and the argument Mask contains an
 8-bit mask. The bits of the Mask are made to have a one-to-one correspondence with the bits
 of the Data. A mask bit of 1 indicates that the corresponding bit in Data is to be tested. When
 a mask bit is 0, the corresponding bit in Data is ignored. Here, in Mask, there is at least one
 bit whose value is 1.

The function BitTest returns the following return value:

Return value 0: All tested bits are 0’s
 1: Tested bits mixed 0’s and 1’s
 2: All tested bits are 1’s

- 28 -

For example, in Example 1 in Figure 1, the 2 bits (bit numbers 5 and 1) of Mask are 1’s; thus,
the values of the 2 bits (bit numbers 5 and 1) of Data are tested. Because 0 and 1 are both
included in these, the return value is 1. In Example 2, the 2 bits (bit numbers 6 and 2) of
Mask are 1’s; thus, the values of the 2 bits (bit numbers 6 and 2) of Data are tested. Because
both are 1’s, the return value is 2.

(Example 1) (Example 2)

Bit number 7 6 5 4 3 2 1 0 Bit number 7 6 5 4 3 2 1 0
 Data 1 1 0 0 0 1 1 0 Data 1 1 0 0 0 1 1 0
 | | | |
 Mask 0 0 1 0 0 0 1 0 Mask 0 1 0 0 0 1 0 0

Return value 1 Return value 2

Figure 1 Examples of the BitTest operation

[Program 1]

FUNCTION: BitTest(8-bit Binary: Data, 8-bit Binary: Mask) {
 INT: Rv /* return value */

IF (***A*** )
 Rv ← 2;
 ELSE
 IF (***B*** )
 Rv ← 0;
 ELSE
 Rv ← 1;
 return Rv; /* returns Rv as the return value */
 }

Based on the definition of the return value, the function BitTest ***C*** when Mask has
only one bit whose value is 1, and the function BitTest ***D*** when the contents of
Data and Mask are identical.

Program 1 presumes that Mask contains at least one bit whose value is 1.
To improve the usability, the specification of Program 1 is to be changed so that it can accept
the case where all the bits in Mask have value 0. In this case, Program 1 returns 0 as the
return value. To achieve this, the following change proposals, (1) to (3), are made. Note that
change proposal (1) makes no change to Program 1. Here, the correct answers are assumed
to be inserted in blanks ***A*** and ***B***.

- 29 -

Change proposal (1) Change proposal (2) Change proposal (3)
 (no change)

IF (***A***) IF (***B***) Rv ← 1;
 Rv ← 2; Rv ← 0; IF (***B***)
 ELSE ELSE Rv ← 0;
 IF (***B*** ) IF (***A***) IF (***A***)
 Rv ← 0; Rv ← 2; Rv ← 2;
 ELSE ELSE return Rv;
 Rv ← 1; Rv ← 1;
 return Rv; return Rv;

Of these change proposals, the one that operates correctly is ***E***.

Answer group for A and B
 a) (Data & Mask) = ''00000000''B b) (Data & Mask) = Data
 c) (Data & Mask) = Mask d) (Data | Mask) = ''00000000''B
 e) (Data | Mask) = Mask

Answer group for C and D
 a) always returns the return value 0 b) never returns the return value 0
 c) always returns the return value 1 d) never returns the return value 1
 e) always returns the return value 2 f) never returns the return value 2

Answer group for E
 a) Change proposal (1) b) Change proposal (2)
 c) Change proposal (3)

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

[Description of the function BitCount]
 The function BitCount counts the number of bits whose values are 1 in an 8-bit data and
 returns the result.
 The function BitCount is declared as follows:

FUNCTION: BitCount(8-bit Binary: Data)
 The argument Data contains an 8-bit data to be checked.

- 30 -

Two programs are provided: Program 2, which uses a basic algorithm, and Program 3, which
uses an efficient algorithm.
For Programs 2 and 3, the processing time of each line is shown. It indicates the required
time in a certain time unit to execute that line of process once. For a line on which the
processing time is not shown, its processing time can be ignored.
In Program 3, the operator “-” performs subtraction by treating both operands as 8-bit
unsigned integers.

[Program 2]
Processing
 time
 FUNCTION: BitCount(8-bit Binary: Data) {
 8-bit Binary: Work
 INT: Count, Loop

1 Work ← Data;
 1 Count ← 0;
 4 FOR (Loop ← 0; Loop < 8; Loop ← Loop + 1) {
 3 IF (Rightmost bit of Work is ''1''B) /*** α ***/
 1 Count ← Count + 1;
 1 Shift Work one bit to the right logically;
 }
 2 return Count; /* returns Count as the return value */
 }

[Program 3]
Processing
 time
 FUNCTION: BitCount(8-bit Binary: Data) {
 8-bit Binary: Work
 INT: Count

1 Work ← Data;
 1 Count ← 0;
 2 WHILE (Work ≠ ''00000000''B) {
 1 Count ← Count + 1;
 3 Work ← Work & (Work - 1); /*** β ***/
 }
 2 return Count; /* returns Count as the return value */
 }

- 31 -

With respect to Program 2, the IF statement on the line marked /*** α ***/ can be rewritten
by using logical expressions such as:
 IF ((Work & ''00000001''B) = ''00000001''B),
 IF ((***F***) = Work), and
 IF ((***G***) ≠ Work).

The processing efficiency of Programs 2 and 3 is considered. Table 1 shows the results of
the comparison of the processing times of Programs 2 and 3.

Table 1 Comparison of the processing times of Programs 2 and 3

Minimum Maximum
 Program 2 72 80
 Program 3 ***H*** 54

With respect to Program 3, an efficient algorithm is used to update the value of Work on the
line marked /*** β ***/.
Assume that Program 3 is called and the argument Data contains ''01100110''B. Immediately
after the first execution of the line marked /*** β ***/, the value of Work becomes
''***I*** ''B.
By carrying out the process of bit replacement in this manner, the number of times the
process on the line marked /*** β ***/ is executed is the same as the number of bits that
have value 1 in the data to be checked.

Answer group for F and G
 a) Work & ''00000001''B b) Work & ''11111110''B
 c) Work | ''00000001''B d) Work | ''11111110''B

Answer group for H
 a) 6 b) 10 c) 20 d) 22',
  '[{"type":"prompt","text":"Q6. Read the following description of bit processing programs, and then answer Subquestions\n 1 and 2."},{"type":"context","text":"The function BitTest tests the bit values of the bits in an 8-bit data selected by a mask, and\n the function BitCount counts the number of bits whose values are 1’s in an 8-bit data.\n\nIn this question, the following additional pseudo-language notations are used:\n o The operators “&” and “|” obtain the logical product and logical sum, respectively, for\n each pair of bits in the corresponding bit positions of two 8-bit binary-type data, and\n obtain an 8-bit binary-type result.\n o The notation ''....''B such as ''1''B and ''11111110’B expresses a binary-type constant.\n o The selection processes (IF / ELSE) are coded without using curly braces { } in\n accordance with the language specifications of C and Java.\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following description and Program 1.\n\n[Description of the function BitTest]\n The function BitTest tests the bit values of the bits in an 8-bit data selected by a mask and\n returns the result.\n The function BitTest is declared as follows:\n\nFUNCTION: BitTest(8-bit Binary: Data, 8-bit Binary: Mask)\n The argument Data contains an 8-bit data to be tested, and the argument Mask contains an\n 8-bit mask. The bits of the Mask are made to have a one-to-one correspondence with the bits\n of the Data. A mask bit of 1 indicates that the corresponding bit in Data is to be tested. When\n a mask bit is 0, the corresponding bit in Data is ignored. Here, in Mask, there is at least one\n bit whose value is 1.\n\nThe function BitTest returns the following return value:\n\nReturn value 0: All tested bits are 0’s\n 1: Tested bits mixed 0’s and 1’s\n 2: All tested bits are 1’s\n\n- 28 -\n\nFor example, in Example 1 in Figure 1, the 2 bits (bit numbers 5 and 1) of Mask are 1’s; thus,\nthe values of the 2 bits (bit numbers 5 and 1) of Data are tested. Because 0 and 1 are both\nincluded in these, the return value is 1. In Example 2, the 2 bits (bit numbers 6 and 2) of\nMask are 1’s; thus, the values of the 2 bits (bit numbers 6 and 2) of Data are tested. Because\nboth are 1’s, the return value is 2.\n\n(Example 1) (Example 2)\n\nBit number 7 6 5 4 3 2 1 0 Bit number 7 6 5 4 3 2 1 0\n Data 1 1 0 0 0 1 1 0 Data 1 1 0 0 0 1 1 0\n | | | |\n Mask 0 0 1 0 0 0 1 0 Mask 0 1 0 0 0 1 0 0\n\nReturn value 1 Return value 2\n\nFigure 1 Examples of the BitTest operation\n\n[Program 1]\n\nFUNCTION: BitTest(8-bit Binary: Data, 8-bit Binary: Mask) {\n INT: Rv /* return value */\n\nIF (***A*** )\n Rv ← 2;\n ELSE\n IF (***B*** )\n Rv ← 0;\n ELSE\n Rv ← 1;\n return Rv; /* returns Rv as the return value */\n }\n\nBased on the definition of the return value, the function BitTest ***C*** when Mask has\nonly one bit whose value is 1, and the function BitTest ***D*** when the contents of\nData and Mask are identical.\n\nProgram 1 presumes that Mask contains at least one bit whose value is 1.\nTo improve the usability, the specification of Program 1 is to be changed so that it can accept\nthe case where all the bits in Mask have value 0. In this case, Program 1 returns 0 as the\nreturn value. To achieve this, the following change proposals, (1) to (3), are made. Note that\nchange proposal (1) makes no change to Program 1. Here, the correct answers are assumed\nto be inserted in blanks ***A*** and ***B***.\n\n- 29 -\n\nChange proposal (1) Change proposal (2) Change proposal (3)\n (no change)\n\nIF (***A***) IF (***B***) Rv ← 1;\n Rv ← 2; Rv ← 0; IF (***B***)\n ELSE ELSE Rv ← 0;\n IF (***B*** ) IF (***A***) IF (***A***)\n Rv ← 0; Rv ← 2; Rv ← 2;\n ELSE ELSE return Rv;\n Rv ← 1; Rv ← 1;\n return Rv; return Rv;\n\nOf these change proposals, the one that operates correctly is ***E***.\n\nAnswer group for A and B\n a) (Data & Mask) = ''00000000''B b) (Data & Mask) = Data\n c) (Data & Mask) = Mask d) (Data | Mask) = ''00000000''B\n e) (Data | Mask) = Mask\n\nAnswer group for C and D\n a) always returns the return value 0 b) never returns the return value 0\n c) always returns the return value 1 d) never returns the return value 1\n e) always returns the return value 2 f) never returns the return value 2\n\nAnswer group for E\n a) Change proposal (1) b) Change proposal (2)\n c) Change proposal (3)\n\nSubquestion 2\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following description.\n\n[Description of the function BitCount]\n The function BitCount counts the number of bits whose values are 1 in an 8-bit data and\n returns the result.\n The function BitCount is declared as follows:\n\nFUNCTION: BitCount(8-bit Binary: Data)\n The argument Data contains an 8-bit data to be checked.\n\n- 30 -\n\nTwo programs are provided: Program 2, which uses a basic algorithm, and Program 3, which\nuses an efficient algorithm.\nFor Programs 2 and 3, the processing time of each line is shown. It indicates the required\ntime in a certain time unit to execute that line of process once. For a line on which the\nprocessing time is not shown, its processing time can be ignored.\nIn Program 3, the operator “-” performs subtraction by treating both operands as 8-bit\nunsigned integers.\n\n[Program 2]\nProcessing\n time\n FUNCTION: BitCount(8-bit Binary: Data) {\n 8-bit Binary: Work\n INT: Count, Loop\n\n1 Work ← Data;\n 1 Count ← 0;\n 4 FOR (Loop ← 0; Loop < 8; Loop ← Loop + 1) {\n 3 IF (Rightmost bit of Work is ''1''B) /*** α ***/\n 1 Count ← Count + 1;\n 1 Shift Work one bit to the right logically;\n }\n 2 return Count; /* returns Count as the return value */\n }\n\n[Program 3]\nProcessing\n time\n FUNCTION: BitCount(8-bit Binary: Data) {\n 8-bit Binary: Work\n INT: Count\n\n1 Work ← Data;\n 1 Count ← 0;\n 2 WHILE (Work ≠ ''00000000''B) {\n 1 Count ← Count + 1;\n 3 Work ← Work & (Work - 1); /*** β ***/\n }\n 2 return Count; /* returns Count as the return value */\n }\n\n- 31 -\n\nWith respect to Program 2, the IF statement on the line marked /*** α ***/ can be rewritten\nby using logical expressions such as:\n IF ((Work & ''00000001''B) = ''00000001''B),\n IF ((***F***) = Work), and\n IF ((***G***) ≠ Work).\n\nThe processing efficiency of Programs 2 and 3 is considered. Table 1 shows the results of\nthe comparison of the processing times of Programs 2 and 3.\n\nTable 1 Comparison of the processing times of Programs 2 and 3\n\nMinimum Maximum\n Program 2 72 80\n Program 3 ***H*** 54\n\nWith respect to Program 3, an efficient algorithm is used to update the value of Work on the\nline marked /*** β ***/.\nAssume that Program 3 is called and the argument Data contains ''01100110''B. Immediately\nafter the first execution of the line marked /*** β ***/, the value of Work becomes\n''***I*** ''B.\nBy carrying out the process of bit replacement in this manner, the number of times the\nprocess on the line marked /*** β ***/ is executed is the same as the number of bits that\nhave value 1 in the data to be checked.\n\nAnswer group for F and G\n a) Work & ''00000001''B b) Work & ''11111110''B\n c) Work | ''00000001''B d) Work | ''11111110''B\n\nAnswer group for H\n a) 6 b) 10 c) 20 d) 22"}]'::jsonb,
  '["2022-april-b-q06-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"00010011"},{"label":"b","text":"00100110"},{"label":"c","text":"00110010"},{"label":"d","text":"01100100\n\n - 32 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "c"}, {"subquestion": 1, "blank": "B", "answer": "a"}, {"subquestion": 1, "blank": "C", "answer": "d"}, {"subquestion": 1, "blank": "D", "answer": "e"}, {"subquestion": 1, "blank": "E", "answer": "b"}, {"subquestion": 2, "blank": "F", "answer": "c"}, {"subquestion": 2, "blank": "G", "answer": "b"}, {"subquestion": 2, "blank": "H", "answer": "a"}, {"subquestion": 2, "blank": "I", "answer": "d"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"c"},{"subquestion":1,"blank":"B","answer":"a"},{"subquestion":1,"blank":"C","answer":"d"},{"subquestion":1,"blank":"D","answer":"e"},{"subquestion":1,"blank":"E","answer":"b"},{"subquestion":2,"blank":"F","answer":"c"},{"subquestion":2,"blank":"G","answer":"b"},{"subquestion":2,"blank":"H","answer":"a"},{"subquestion":2,"blank":"I","answer":"d"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-B, Q6)',
  ARRAY[28,29,30,31,32]::int[],
  'native_text',
  '3.0',
  'Q6. Read the following description of bit processing programs, and then answer Subquestions
 1 and 2.

 The function BitTest tests the bit values of the bits in an 8-bit data selected by a mask, and
 the function BitCount counts the number of bits whose values are 1’s in an 8-bit data.

 In this question, the following additional pseudo-language notations are used:
 o The operators “&” and “|” obtain the logical product and logical sum, respectively, for
 each pair of bits in the corresponding bit positions of two 8-bit binary-type data, and
 obtain an 8-bit binary-type result.
 o The notation ''....''B such as ''1''B and ''11111110’B expresses a binary-type constant.
 o The selection processes (IF / ELSE) are coded without using curly braces { } in
 accordance with the language specifications of C and Java.

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description and Program 1.

 [Description of the function BitTest]
 The function BitTest tests the bit values of the bits in an 8-bit data selected by a mask and
 returns the result.
 The function BitTest is declared as follows:

 FUNCTION: BitTest(8-bit Binary: Data, 8-bit Binary: Mask)
 The argument Data contains an 8-bit data to be tested, and the argument Mask contains an
 8-bit mask. The bits of the Mask are made to have a one-to-one correspondence with the bits
 of the Data. A mask bit of 1 indicates that the corresponding bit in Data is to be tested. When
 a mask bit is 0, the corresponding bit in Data is ignored. Here, in Mask, there is at least one
 bit whose value is 1.

 The function BitTest returns the following return value:

 Return value 0: All tested bits are 0’s
 1: Tested bits mixed 0’s and 1’s
 2: All tested bits are 1’s

 - 28 -

For example, in Example 1 in Figure 1, the 2 bits (bit numbers 5 and 1) of Mask are 1’s; thus,
the values of the 2 bits (bit numbers 5 and 1) of Data are tested. Because 0 and 1 are both
included in these, the return value is 1. In Example 2, the 2 bits (bit numbers 6 and 2) of
Mask are 1’s; thus, the values of the 2 bits (bit numbers 6 and 2) of Data are tested. Because
both are 1’s, the return value is 2.

 (Example 1) (Example 2)

 Bit number 7 6 5 4 3 2 1 0 Bit number 7 6 5 4 3 2 1 0
 Data 1 1 0 0 0 1 1 0 Data 1 1 0 0 0 1 1 0
 | | | |
 Mask 0 0 1 0 0 0 1 0 Mask 0 1 0 0 0 1 0 0

 Return value 1 Return value 2

 Figure 1 Examples of the BitTest operation

[Program 1]

 FUNCTION: BitTest(8-bit Binary: Data, 8-bit Binary: Mask) {
 INT: Rv /* return value */

 IF (___A___ )
 Rv ← 2;
 ELSE
 IF (___B___ )
 Rv ← 0;
 ELSE
 Rv ← 1;
 return Rv; /* returns Rv as the return value */
 }

Based on the definition of the return value, the function BitTest ___C___ when Mask has
only one bit whose value is 1, and the function BitTest ___D___ when the contents of
Data and Mask are identical.

Program 1 presumes that Mask contains at least one bit whose value is 1.
To improve the usability, the specification of Program 1 is to be changed so that it can accept
the case where all the bits in Mask have value 0. In this case, Program 1 returns 0 as the
return value. To achieve this, the following change proposals, (1) to (3), are made. Note that
change proposal (1) makes no change to Program 1. Here, the correct answers are assumed
to be inserted in blanks ___A___ and ___B___.

 - 29 -

Change proposal (1) Change proposal (2) Change proposal (3)
 (no change)

 IF (___A___) IF (___B___) Rv ← 1;
 Rv ← 2; Rv ← 0; IF (___B___)
 ELSE ELSE Rv ← 0;
 IF (___B___ ) IF (___A___) IF (___A___)
 Rv ← 0; Rv ← 2; Rv ← 2;
 ELSE ELSE return Rv;
 Rv ← 1; Rv ← 1;
 return Rv; return Rv;

 Of these change proposals, the one that operates correctly is ___E___.

 Answer group for A and B
 a) (Data & Mask) = ''00000000''B b) (Data & Mask) = Data
 c) (Data & Mask) = Mask d) (Data | Mask) = ''00000000''B
 e) (Data | Mask) = Mask

 Answer group for C and D
 a) always returns the return value 0 b) never returns the return value 0
 c) always returns the return value 1 d) never returns the return value 1
 e) always returns the return value 2 f) never returns the return value 2

 Answer group for E
 a) Change proposal (1) b) Change proposal (2)
 c) Change proposal (3)

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

 [Description of the function BitCount]
 The function BitCount counts the number of bits whose values are 1 in an 8-bit data and
 returns the result.
 The function BitCount is declared as follows:

 FUNCTION: BitCount(8-bit Binary: Data)
 The argument Data contains an 8-bit data to be checked.

 - 30 -

Two programs are provided: Program 2, which uses a basic algorithm, and Program 3, which
uses an efficient algorithm.
For Programs 2 and 3, the processing time of each line is shown. It indicates the required
time in a certain time unit to execute that line of process once. For a line on which the
processing time is not shown, its processing time can be ignored.
In Program 3, the operator “-” performs subtraction by treating both operands as 8-bit
unsigned integers.

[Program 2]
Processing
 time
 FUNCTION: BitCount(8-bit Binary: Data) {
 8-bit Binary: Work
 INT: Count, Loop

 1 Work ← Data;
 1 Count ← 0;
 4 FOR (Loop ← 0; Loop < 8; Loop ← Loop + 1) {
 3 IF (Rightmost bit of Work is ''1''B) /*** α ***/
 1 Count ← Count + 1;
 1 Shift Work one bit to the right logically;
 }
 2 return Count; /* returns Count as the return value */
 }

[Program 3]
Processing
 time
 FUNCTION: BitCount(8-bit Binary: Data) {
 8-bit Binary: Work
 INT: Count

 1 Work ← Data;
 1 Count ← 0;
 2 WHILE (Work ≠ ''00000000''B) {
 1 Count ← Count + 1;
 3 Work ← Work & (Work - 1); /*** β ***/
 }
 2 return Count; /* returns Count as the return value */
 }

 - 31 -

With respect to Program 2, the IF statement on the line marked /*** α ***/ can be rewritten
by using logical expressions such as:
 IF ((Work & ''00000001''B) = ''00000001''B),
 IF ((___F___) = Work), and
 IF ((___G___) ≠ Work).

The processing efficiency of Programs 2 and 3 is considered. Table 1 shows the results of
the comparison of the processing times of Programs 2 and 3.

 Table 1 Comparison of the processing times of Programs 2 and 3

 Minimum Maximum
 Program 2 72 80
 Program 3 ___H___ 54

With respect to Program 3, an efficient algorithm is used to update the value of Work on the
line marked /*** β ***/.
Assume that Program 3 is called and the argument Data contains ''01100110''B. Immediately
after the first execution of the line marked /*** β ***/, the value of Work becomes
''___I___ ''B.
By carrying out the process of bit replacement in this manner, the number of times the
process on the line marked /*** β ***/ is executed is the same as the number of bits that
have value 1 in the data to be checked.

Answer group for F and G
 a) Work & ''00000001''B b) Work & ''11111110''B
 c) Work | ''00000001''B d) Work | ''11111110''B

Answer group for H
 a) 6 b) 10 c) 20 d) 22

Answer group for I
 a) 00010011 b) 00100110 c) 00110010 d) 01100100

 - 32 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/b/questions.pdf","pages":[28,29,30,31,32]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'B',
  7,
  'Q7. Read the following description of a C program, and then answer Subquestions 1 through
 3.

The “Pillow Passing Game” is a classic party game that involves players, chairs, music and
 a pillow in which the pillow is passed from one player to another. In this game, all players
 are seated on chairs arranged in a loop. While the music is playing, the players pass the
 pillow to the next player. When the music stops, the player who holds the pillow will be
 eliminated from the game with his/her chair; the elimination is repeated until only one player
 remains. The last player is considered as the winner.

[Program Description]
 The game can be simulated by a linear circular linked list and random numbers. The list
 represents the players of the game seated on the looped chairs. Each node of the list holds a
 unique integer number (ranges from 1 to the number of players) that identifies a player. A
 random number simulates how many times the pillow is passed among the players while the
 music is playing.

At the beginning of the program, it receives a positive integer number num_players (≤ 100)
 as the total number of players from the standard input. The program then creates a linear
 circular linked list consisting of num_players of nodes. If num_players is 1, the winner
 will always be the only player. Otherwise, the program sets a pointer has_pillow to the first
 node in the list and then moves has_pillow in the forward direction by rd times where rd
 takes a random integer number that ranges from 1 to MAX_NUM_PASSES. When has_pillow
 has finished moving, the node pointed to by has_pillow is deleted from the list.
 has_pillow is then reset to point to the next node of the deleted one and moves randomly
 again. This process is repeated until the time when only one node remains.

Figures 1 through 5 illustrate an example of the program execution for num_players = 4.
 The program first creates a linear circular linked list of 4 nodes. Figure 1 illustrates the initial
 status of the list. Here, the pointer players points to the representative node of the list.

- 33 -

has_pillow

players

1 2 3 4

Figure 1 Initial status of the list

Assume that a random number 2 is generated and set to rd at the first elimination process.
The pointer has_pillow is moved forward by 2 nodes as in Figure 2.

has_pillow

players

1 2 3 4

Figure 2 Movement of has_pillow

After the node pointed to by has_pillow is deleted from the list, has_pillow is set to the
node immediately after the deleted node and the list appears as in Figure 3.

has_pillow

players

1 2 4

Figure 3 Status of the list at the end of the first elimination

Assume that 6 is set to rd at the second elimination process. The 6th player starting at player
4 is player 4 itself. Figure 4 illustrates the list after player 4 is deleted.

has_pillow

players

1 2

Figure 4 Status of the list at the end of the second elimination

- 34 -

Similarly, assume that 8 is set to rd at the third elimination process. Figure 5 illustrates the
list after player 1 is deleted.

has_pillow

players

2

Figure 5 Status of the list at the end of the third elimination

At this point, the program stops the elimination process. The winner is player 2.
For the example shown above, the program outputs the following result:

How many players:= 4

Current LinkedList:= 1 2 3 4
 Pass = 1
 Random Number:= 2

Current LinkedList:= 1 2 4
 Pass = 2
 Random Number:= 6

Current LinkedList:= 1 2
 Pass = 3
 Random Number:= 8

Current LinkedList:= 2
 Winner = 2

Tables 1 and 2 show the descriptions of user defined functions and standard library functions
used in the program.

Table 1 User defined functions used in the program

Function Name Description
 player_t *Setup(int num_players) Creates new linear circular linked list holding
 num_players nodes. Returns a pointer to the
 representative node of the list.
 int PlayGame(player_t *players) Determines the winner of the game with
 given linear circular linked list players.
 Returns the number identifying the winning
 player.
 void Display(player_t *players) Displays information of current linear
 circular linked list players.

- 35 -

Table 2 Standard library functions used in the program

Function Name Description
 void *malloc(size_t size) Allocates size bytes of memory block
 dynamically. Returns a pointer that points to that
 memory.
 void free(void *ptr) Deallocates the memory block pointed to by ptr,
 which was previously allocated by malloc.
 void srand(unsigned int seed) Sets the starting point for generating a series of
 pseudo-random numbers.
 int rand(void) Returns an integer pseudo-random number from 0
 to 215-1 (or 231-1; environment-dependent).
 time_t time(time_t *timer) Returns an integer number that represents the
 current time in seconds. If timer is not NULL, the
 return value is also stored in the variable timer.
 Note: Functions printf() and scanf() are not shown.',
  '[{"type":"prompt","text":"Q7. Read the following description of a C program, and then answer Subquestions 1 through\n 3."},{"type":"context","text":"The “Pillow Passing Game” is a classic party game that involves players, chairs, music and\n a pillow in which the pillow is passed from one player to another. In this game, all players\n are seated on chairs arranged in a loop. While the music is playing, the players pass the\n pillow to the next player. When the music stops, the player who holds the pillow will be\n eliminated from the game with his/her chair; the elimination is repeated until only one player\n remains. The last player is considered as the winner.\n\n[Program Description]\n The game can be simulated by a linear circular linked list and random numbers. The list\n represents the players of the game seated on the looped chairs. Each node of the list holds a\n unique integer number (ranges from 1 to the number of players) that identifies a player. A\n random number simulates how many times the pillow is passed among the players while the\n music is playing.\n\nAt the beginning of the program, it receives a positive integer number num_players (≤ 100)\n as the total number of players from the standard input. The program then creates a linear\n circular linked list consisting of num_players of nodes. If num_players is 1, the winner\n will always be the only player. Otherwise, the program sets a pointer has_pillow to the first\n node in the list and then moves has_pillow in the forward direction by rd times where rd\n takes a random integer number that ranges from 1 to MAX_NUM_PASSES. When has_pillow\n has finished moving, the node pointed to by has_pillow is deleted from the list.\n has_pillow is then reset to point to the next node of the deleted one and moves randomly\n again. This process is repeated until the time when only one node remains.\n\nFigures 1 through 5 illustrate an example of the program execution for num_players = 4.\n The program first creates a linear circular linked list of 4 nodes. Figure 1 illustrates the initial\n status of the list. Here, the pointer players points to the representative node of the list.\n\n- 33 -\n\nhas_pillow\n\nplayers\n\n1 2 3 4\n\nFigure 1 Initial status of the list\n\nAssume that a random number 2 is generated and set to rd at the first elimination process.\nThe pointer has_pillow is moved forward by 2 nodes as in Figure 2.\n\nhas_pillow\n\nplayers\n\n1 2 3 4\n\nFigure 2 Movement of has_pillow\n\nAfter the node pointed to by has_pillow is deleted from the list, has_pillow is set to the\nnode immediately after the deleted node and the list appears as in Figure 3.\n\nhas_pillow\n\nplayers\n\n1 2 4\n\nFigure 3 Status of the list at the end of the first elimination\n\nAssume that 6 is set to rd at the second elimination process. The 6th player starting at player\n4 is player 4 itself. Figure 4 illustrates the list after player 4 is deleted.\n\nhas_pillow\n\nplayers\n\n1 2\n\nFigure 4 Status of the list at the end of the second elimination\n\n- 34 -\n\nSimilarly, assume that 8 is set to rd at the third elimination process. Figure 5 illustrates the\nlist after player 1 is deleted.\n\nhas_pillow\n\nplayers\n\n2\n\nFigure 5 Status of the list at the end of the third elimination\n\nAt this point, the program stops the elimination process. The winner is player 2.\nFor the example shown above, the program outputs the following result:\n\nHow many players:= 4\n\nCurrent LinkedList:= 1 2 3 4\n Pass = 1\n Random Number:= 2\n\nCurrent LinkedList:= 1 2 4\n Pass = 2\n Random Number:= 6\n\nCurrent LinkedList:= 1 2\n Pass = 3\n Random Number:= 8\n\nCurrent LinkedList:= 2\n Winner = 2\n\nTables 1 and 2 show the descriptions of user defined functions and standard library functions\nused in the program.\n\nTable 1 User defined functions used in the program\n\nFunction Name Description\n player_t *Setup(int num_players) Creates new linear circular linked list holding\n num_players nodes. Returns a pointer to the\n representative node of the list.\n int PlayGame(player_t *players) Determines the winner of the game with\n given linear circular linked list players.\n Returns the number identifying the winning\n player.\n void Display(player_t *players) Displays information of current linear\n circular linked list players.\n\n- 35 -\n\nTable 2 Standard library functions used in the program\n\nFunction Name Description\n void *malloc(size_t size) Allocates size bytes of memory block\n dynamically. Returns a pointer that points to that\n memory.\n void free(void *ptr) Deallocates the memory block pointed to by ptr,\n which was previously allocated by malloc.\n void srand(unsigned int seed) Sets the starting point for generating a series of\n pseudo-random numbers.\n int rand(void) Returns an integer pseudo-random number from 0\n to 215-1 (or 231-1; environment-dependent).\n time_t time(time_t *timer) Returns an integer number that represents the\n current time in seconds. If timer is not NULL, the\n return value is also stored in the variable timer.\n Note: Functions printf() and scanf() are not shown."},{"type":"code","language":"itpec-pseudocode","text":"if (has_pillow == players) {\n         players = has_pillow->next;     /*** β ***/\n      }\n      free(has_pillow);\n      has_pillow = p->next;              /*** γ ***/\n      printf(\"\\nPass = %d\", pass);\n      printf(\"\\nRandom Number:= %d\", rd);\n      printf(\"\\n\");\n      Display(players);\n      pass++;\n   }\n   return players->number;\n}"}]'::jsonb,
  '["2022-april-b-q07-figure1.webp","2022-april-b-q07-figure2.webp","2022-april-b-q07-figure3.webp","2022-april-b-q07-figure4.webp","2022-april-b-q07-figure5.webp"]'::jsonb,
  '[{"label":"a","text":"has_pillow = p"},{"label":"b","text":"has_pillow = players"},{"label":"c","text":"players = has_pillow"},{"label":"d","text":"players = p\n\n - 39 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "d"}, {"subquestion": 1, "blank": "B", "answer": "b"}, {"subquestion": 1, "blank": "C", "answer": "d"}, {"subquestion": 1, "blank": "D", "answer": "d"}, {"subquestion": 1, "blank": "E", "answer": "d"}, {"subquestion": 2, "blank": "F", "answer": "d"}, {"subquestion": 3, "blank": "G", "answer": "c"}, {"subquestion": 3, "blank": "H", "answer": "a"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"d"},{"subquestion":1,"blank":"B","answer":"b"},{"subquestion":1,"blank":"C","answer":"d"},{"subquestion":1,"blank":"D","answer":"d"},{"subquestion":1,"blank":"E","answer":"d"},{"subquestion":2,"blank":"F","answer":"d"},{"subquestion":3,"blank":"G","answer":"c"},{"subquestion":3,"blank":"H","answer":"a"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-B, Q7)',
  ARRAY[33,34,35,36,37,38,39]::int[],
  'native_text',
  '3.0',
  'Q7. Read the following description of a C program, and then answer Subquestions 1 through
 3.

 The “Pillow Passing Game” is a classic party game that involves players, chairs, music and
 a pillow in which the pillow is passed from one player to another. In this game, all players
 are seated on chairs arranged in a loop. While the music is playing, the players pass the
 pillow to the next player. When the music stops, the player who holds the pillow will be
 eliminated from the game with his/her chair; the elimination is repeated until only one player
 remains. The last player is considered as the winner.

 [Program Description]
 The game can be simulated by a linear circular linked list and random numbers. The list
 represents the players of the game seated on the looped chairs. Each node of the list holds a
 unique integer number (ranges from 1 to the number of players) that identifies a player. A
 random number simulates how many times the pillow is passed among the players while the
 music is playing.

 At the beginning of the program, it receives a positive integer number num_players (≤ 100)
 as the total number of players from the standard input. The program then creates a linear
 circular linked list consisting of num_players of nodes. If num_players is 1, the winner
 will always be the only player. Otherwise, the program sets a pointer has_pillow to the first
 node in the list and then moves has_pillow in the forward direction by rd times where rd
 takes a random integer number that ranges from 1 to MAX_NUM_PASSES. When has_pillow
 has finished moving, the node pointed to by has_pillow is deleted from the list.
 has_pillow is then reset to point to the next node of the deleted one and moves randomly
 again. This process is repeated until the time when only one node remains.

 Figures 1 through 5 illustrate an example of the program execution for num_players = 4.
 The program first creates a linear circular linked list of 4 nodes. Figure 1 illustrates the initial
 status of the list. Here, the pointer players points to the representative node of the list.

 - 33 -

has_pillow

 players

 1 2 3 4

 Figure 1 Initial status of the list

Assume that a random number 2 is generated and set to rd at the first elimination process.
The pointer has_pillow is moved forward by 2 nodes as in Figure 2.

 has_pillow

 players

 1 2 3 4

 Figure 2 Movement of has_pillow

After the node pointed to by has_pillow is deleted from the list, has_pillow is set to the
node immediately after the deleted node and the list appears as in Figure 3.

 has_pillow

 players

 1 2 4

 Figure 3 Status of the list at the end of the first elimination

Assume that 6 is set to rd at the second elimination process. The 6th player starting at player
4 is player 4 itself. Figure 4 illustrates the list after player 4 is deleted.

 has_pillow

 players

 1 2

 Figure 4 Status of the list at the end of the second elimination

 - 34 -

Similarly, assume that 8 is set to rd at the third elimination process. Figure 5 illustrates the
list after player 1 is deleted.

 has_pillow

 players

 2

 Figure 5 Status of the list at the end of the third elimination

At this point, the program stops the elimination process. The winner is player 2.
For the example shown above, the program outputs the following result:

 How many players:= 4

 Current LinkedList:= 1 2 3 4
 Pass = 1
 Random Number:= 2

 Current LinkedList:= 1 2 4
 Pass = 2
 Random Number:= 6

 Current LinkedList:= 1 2
 Pass = 3
 Random Number:= 8

 Current LinkedList:= 2
 Winner = 2

Tables 1 and 2 show the descriptions of user defined functions and standard library functions
used in the program.

 Table 1 User defined functions used in the program

 Function Name Description
 player_t *Setup(int num_players) Creates new linear circular linked list holding
 num_players nodes. Returns a pointer to the
 representative node of the list.
 int PlayGame(player_t *players) Determines the winner of the game with
 given linear circular linked list players.
 Returns the number identifying the winning
 player.
 void Display(player_t *players) Displays information of current linear
 circular linked list players.

 - 35 -

Table 2 Standard library functions used in the program

 Function Name Description
 void *malloc(size_t size) Allocates size bytes of memory block
 dynamically. Returns a pointer that points to that
 memory.
 void free(void *ptr) Deallocates the memory block pointed to by ptr,
 which was previously allocated by malloc.
 void srand(unsigned int seed) Sets the starting point for generating a series of
 pseudo-random numbers.
 int rand(void) Returns an integer pseudo-random number from 0
 to 215-1 (or 231-1; environment-dependent).
 time_t time(time_t *timer) Returns an integer number that represents the
 current time in seconds. If timer is not NULL, the
 return value is also stored in the variable timer.
 Note: Functions printf() and scanf() are not shown.

[Program]

 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>

 #define MAX_NUM_PASSES 10

 struct player {
 int number;
 struct player *next;
 };
 typedef struct player player_t;

 player_t *Setup(int num_players);
 int PlayGame(player_t *players);
 void Display(player_t *players);

 int main() {
 int win, num_players;
 player_t *players;

 printf("How many players:= ");
 scanf("%d", &num_players);
 players = Setup(num_players);
 Display(players);
 win = PlayGame(players);
 printf("\nWinner = %d\n", ____A____ );
 return 0;
 }

 - 36 -

player_t *Setup(int num_players) {
 player_t *temp, *prev, *players = NULL;
 int i;

 for (i = 1; i <= num_players; i++) {
 temp = (player_t *)malloc(sizeof(player_t));
 if (players == NULL) {
 players = temp;
 prev = temp;
 }
 temp->number = ____B____;
 temp->next = players;
 prev->next = temp;
 prev = temp;
 }
 return players;
}

int PlayGame(player_t *players) {
 player_t *p, *has_pillow;
 int rd, pass, i;

 srand(time(NULL));
 pass = 1;
 has_pillow = players;
 while (____C____ ) {
 rd = rand() % (MAX_NUM_PASSES - 1) + 1;

 for (i = 0; i < rd; i++) {
 p = has_pillow;
 has_pillow = has_pillow->next; /*** α ***/
 }
 ____D____;
 if (has_pillow == players) {
 players = has_pillow->next; /*** β ***/
 }
 free(has_pillow);
 has_pillow = p->next; /*** γ ***/
 printf("\nPass = %d", pass);
 printf("\nRandom Number:= %d", rd);
 printf("\n");
 Display(players);
 pass++;
 }
 return players->number;
}

 - 37 -

void Display(player_t *players) {
 player_t *temp;

 printf("\nCurrent LinkedList:= ");
 temp = players;
 do {
 printf("%d ", temp->number);
 ____E____;
 } while (temp != players);
 }

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the program.

 Answer group for A
 a) num_players b) players
 c) players->number d) win
 e) win->number

 Answer group for B
 a) ++i b) i
 c) i + 1 d) i - 1

 Answer group for C
 a) has_pillow != players
 b) p->next != players->next
 c) players->next != has_pillow->next
 d) players->next != players

 Answer group for D
 a) p = p->next b) p = p->next->next
 c) p->next = has_pillow d) p->next = has_pillow->next

 Answer group for E
 a) players = players->next b) players = temp
 c) temp = players d) temp = temp->next

 - 38 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following description.

 Suppose the program created the linear circular linked list as shown in Figure 6 for
 num_players = 5. Given a series of random numbers 4, 2, 1, and 2 set to the variable rd in
 this order, the function PlayGame returns ___F___.

 has_pillow

 players

 1 2 3 4 5

 Figure 6 Linear circular linked list for num_players = 5

 Answer group for F
 a) 1 b) 2 c) 3 d) 4 e) 5

Subquestion 3
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

 The program will be modified according to the following specification change:

 Once a player is eliminated from the game, the pillow is passed again from the player
 who is seated immediately before the eliminated player. To apply this change to the
 program, the assignment statement on the line marked ___G___ should be replaced by
 the following line:

 ____H____ ;

 Answer group for G
 a) /*** α ***/ b) /*** β ***/ c) /*** γ ***/

 Answer group for H
 a) has_pillow = p b) has_pillow = players
 c) players = has_pillow d) players = p

 - 39 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/b/questions.pdf","pages":[33,34,35,36,37,38,39]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2022-april',
  'B',
  8,
  'Q8 Read the following description of Java programs, and then answer Subquestions 1
 through 3.

[Program Description]
 This program is a prototype implementation of a spell checker. The spell checker checks if
 the given words are spelled correctly. To cross match, this program utilizes a pre-populated
 dictionary called WordDictionary. Given a word, the spell checker tries to find and suggest
 related words.

The WordDictionary class (Program 1) represents a dictionary with pre-populated English
 words. The class has the following members.
 (1) The dictWords field is a String array containing pre-populated known words. All
 words are in lowercase and are sorted in ascending order.
 (2) The contains method looks up the given word to determine whether the dictionary
 contains the word.
 (3) The getIterable method returns an Iterable to return an Iterator that iterates
 over the words in dictWords. In Iterator, the hasNext method returns true if the
 iteration has more elements, and the next method returns the next element in the
 iteration.

[Program 1]

import java.util.Iterator;
 import java.util.Locale;
 import java.util.NoSuchElementException;

final class WordDictionary {
 private static final String[] dictWords = {
 "about", "because", "could", "food", "is", "other", "people",
 "their", "there", "think", "to", "which", "would"
 };

private WordDictionary() {
 }

- 40 -

static boolean contains(String word) {
 String lowerCaseWord = word.toLowerCase(Locale.ENGLISH);
 for (String element : dictWords) {
 if (***A***) {
 return true;
 }
 }
 return false;
 }

static Iterable<String> getIterable() {
 // Note that the default remove() implementation throws
 // an UnsupportedOperationException.
 return () -> new Iterator<String>() {
 private int index;

@Override
 public boolean hasNext() {
 return ***B*** ;
 }

@Override
 public String next() {
 if (hasNext()) {
 return dictWords[***C*** ];
 }
 throw new NoSuchElementException();
 }
 };
 }
 }

The EditDistance class (Program 2) calculates related words to suggest for spell checking
using the edit distance based on the Wagner–Fischer algorithm.

An edit distance indicates the number of insertions, deletions, and/or substitutions of
characters needed to transform one word into another. If a character needs to be inserted or
deleted, it is treated as a cost or edit distance of one unit. If a character is substituted, it is
treated as a cost or edit distance of two units as a substitution can be considered as one
deletion and one insertion of a character. The algorithm compares both strings starting with
an empty string to the full-length string, and always chooses the minimum edit distance
(cost) from the three possible operations (an insertion, a deletion, or a substitution) at the
point. The intermediate edit distances are recorded in a matrix.

- 41 -

There are three situations or operations while transforming a string to another string. The
following are examples of the operations.
(1) Insertion: The edit distance from “cat” to “cats” is 1 because an insertion of the character
 ‘s’ is required.
(2) Deletion: The edit distance from “boot” to “bot” is 1 because a deletion of a character
 ‘o’ is required.
(3) Substitution: The edit distance from “let” to “lot” is 2 because a substitution of the
 character ‘e’ with the character ‘o’ is required.

The class has the following members:
(1) The getSubstitutionCost method returns an edit distance (cost) of 2 if two characters
 are different, which means that it requires a substitution, or 0 (zero) otherwise.
(2) The getDistance method calculates the edit distance between the two words, baseWord
 that has been given when instantiating this class and the word given by the dictWord
 parameter, based on the Wagner–Fischer algorithm.

The SpellChecker class (Program 3) suggests alternative words if any. The class has the
following members:
(1) The THRESHOLD field is an integer constant to denote the acceptable edit distance to
 enable very close words to be suggested based on their edit distance of 2.
(2) The suggestWords method finds out the words within the edit distance of THRESHOLD
 in the dictionary and suggests those words. If no close words are found, it returns an
 empty Set.

The Tester01 class (Program 4) tests the words suggested by SpellChecker and generates
the following output for the given input, “thier”:

other there their

[Program 2]

import java.util.Locale;

class EditDistance {
 private final String baseWord;

EditDistance(String baseWord) {
 this.baseWord = baseWord.toLowerCase(Locale.ENGLISH);
 }

private int getSubstitutionCost(char a, char b) {
 return a ***D*** b ? 0 : 2;
 }

- 42 -

int getDistance(String dictWord) {
 int[][] d
 = new int[baseWord.length() + 1][dictWord.length() + 1];

for (int i = 0; i < d.length; ++i) {
 for (int j = 0; j < d[0].length; ++j) {
 if (i == 0) {
 d[0][j] = j;
 } else if (j == 0) {
 d[i][0] = i;
 } else {
 int cost = getSubstitutionCost(baseWord.charAt(i - 1),
 dictWord.charAt(j - 1));
 // Calculate costs of the three different operations
 int substitution = cost + d[i - 1][j - 1];
 int deletion = d[i - 1][j] + 1;
 int insertion = d[i][j - 1] + 1;
 // Choose the cheapest one, and note down the value
 d[i][j] = Math.min(substitution,
 Math.min(deletion, insertion));
 }
 }
 }
 return d[d.length - 1][d[0].length - 1];
 }
 }

[Program 3]

import java.util.HashSet;
 import java.util.Set;

// Location 2

final class SpellChecker {
 private static final int THRESHOLD = 2;

private SpellChecker() {
 }

- 43 -

static Set<String> suggestWords(String word) {
 EditDistance editDistance = new EditDistance(word);
 Set<String> suggestedWords = new HashSet<>();
 for (String dictWord : WordDictionary.getIterable()) {
 if (editDistance.getDistance(dictWord) <= THRESHOLD) {
 suggestedWords.add(dictWord);
 }
 }
 return suggestedWords;
 }

// Location 3
 }

[Program 4]

import java.util.Set;

public class Tester01 {
 public static void main(String[] args) {
 Set<String> suggestedWords = SpellChecker.suggestWords("thier");
 if (!suggestedWords.isEmpty()) {
 for (String suggested : suggestedWords) {
 System.out.print(suggested + " ");
 }
 System.out.println();
 } else {
 System.out.println("no suggestions");
 }
 }
 }

Subquestion 1
 From the answer groups below, select the correct answer to be inserted into each blank
 _______ in the programs above.

Answer group for A
 a) !element.equals(lowerCaseWord) b) element != lowerCaseWord
 c) element == lowerCaseWord d) element.equals(lowerCaseWord)

Answer group for B
 a) dictWords[index] != null b) index < dictWords.length
 c) index <= dictWords.length d) index == dictWords.length
 e) index > dictWords.length f) index >= dictWords.length

- 44 -

Answer group for C
 a) --index b) ++index c) index
 d) index-- e) index++

Answer group for D
 a) != b) < c) <=
 d) == e) > f) >=

Subquestion 2
 From the answer groups below, select the correct answer to be inserted into each blank
 _______ in the following program.

SpellChecker (Program 3) has been modified so that if a word is present in the dictionary,
 then it remains unchanged in the output. If related words are found, they are shown as
 alternatives in parentheses in addition to the original word, e.g.,
 OriginalWord(/alternative1/alternative2/…). If none are found, the output is a
 question mark in parentheses, e.g., OriginalWord(?).

The Tester02 class (Program 5) tests the implementation of the modified SpellChecker
 and generates the following output for the given input, “Beacaus theer API-key is abt
 to expire”: (Note that the following output is wrapped owing to the paper width, and that
 the actual output is shown in a single line.)

Beacaus(/because) theer(/other/there/their) API-key(?) is abt(/about)

to expire(?)

Here, suggested words were found and shown in parentheses for the words “Beacaus”,
 “theer”, and “abt” which were absent in the dictionary. Each suggestion is separated by a
 slash character (“/”). However, the words “API-key” and “expire” did not generate any
 suggestions; they are therefore followed by a question mark. The words “is” and “to” were
 found in the dictionary; hence, they remained unchanged in the output. To facilitate the
 modification, the following lines have been inserted at the locations marked by “Location
 2” and “Location 3” as a comment in Program 3.

- 45 -

// Location 2
 import java.util.Scanner;
 // Location 3
 static String checkSentence(String sentence) {
 // Scanner breaks `sentence’ into tokens delimited by
 // whitespace and iterates over tokens.
 Scanner scanner = new Scanner(sentence);
 StringBuilder suggestions = new StringBuilder();
 while (scanner.hasNext()) {
 String word = scanner.next();
 suggestions.append(word);
 if (!WordDictionary.contains(word)) {
 suggestions.append(***E***);
 Set<String> suggestedWords = suggestWords(word);
 if (suggestedWords.isEmpty()) {
 suggestions.append(***F***);
 } else {
 for (String suggestedWord : suggestedWords) {
 suggestions.append(***G***).append(suggestedWord);
 }
 }
 suggestions.append(")");
 }
 if (scanner.hasNext()) {
 suggestions.append(" ");
 }
 }
 return suggestions.toString();
 }

[Program 5]

public class Tester02 {
 public static void main(String[] args) {
 System.out.println(SpellChecker.checkSentence(
 "Beacaus theer API-key is abt to expire"));
 }
 }

Answer group for E through G
 a) "(" b) ")" c) "/"
 d) "?" e) scanner.next() f) word

- 46 -

Subquestion 3
 From the answer groups below, select the correct answer to be inserted into each blank
 _______ in the method implementation.

If the dictWords field in the WordDictionary class contains more words, there will be the
 need for a faster search mechanism than the current linear search in the contains method.
 The following is another implementation of the same method with the binary search.

The following compareTo method returns 0 if the argument string is equal to this string, a
 value less than 0 if this string is lexicographically less than the string argument, and a value
 greater than 0 if this string is lexicographically greater than the string argument.

static boolean contains(String word) {
 String lowerCaseWord = word.toLowerCase(Locale.ENGLISH);
 int low = 0;
 int high = dictWords.length - 1;
 while (low <= high) {
 int mid = (low + high) / 2;
 int comp = dictWords[mid].compareTo(lowerCaseWord);
 if (comp < 0) {
 low = ***H***;
 } else if (comp > 0) {
 high = ***I***;
 } else {
 return true;
 }
 }
 return false;
 }',
  '[{"type":"prompt","text":"Q8 Read the following description of Java programs, and then answer Subquestions 1\n through 3."},{"type":"context","text":"[Program Description]\n This program is a prototype implementation of a spell checker. The spell checker checks if\n the given words are spelled correctly. To cross match, this program utilizes a pre-populated\n dictionary called WordDictionary. Given a word, the spell checker tries to find and suggest\n related words.\n\nThe WordDictionary class (Program 1) represents a dictionary with pre-populated English\n words. The class has the following members.\n (1) The dictWords field is a String array containing pre-populated known words. All\n words are in lowercase and are sorted in ascending order.\n (2) The contains method looks up the given word to determine whether the dictionary\n contains the word.\n (3) The getIterable method returns an Iterable to return an Iterator that iterates\n over the words in dictWords. In Iterator, the hasNext method returns true if the\n iteration has more elements, and the next method returns the next element in the\n iteration.\n\n[Program 1]\n\nimport java.util.Iterator;\n import java.util.Locale;\n import java.util.NoSuchElementException;\n\nfinal class WordDictionary {\n private static final String[] dictWords = {\n \"about\", \"because\", \"could\", \"food\", \"is\", \"other\", \"people\",\n \"their\", \"there\", \"think\", \"to\", \"which\", \"would\"\n };\n\nprivate WordDictionary() {\n }\n\n- 40 -\n\nstatic boolean contains(String word) {\n String lowerCaseWord = word.toLowerCase(Locale.ENGLISH);\n for (String element : dictWords) {\n if (***A***) {\n return true;\n }\n }\n return false;\n }\n\nstatic Iterable<String> getIterable() {\n // Note that the default remove() implementation throws\n // an UnsupportedOperationException.\n return () -> new Iterator<String>() {\n private int index;\n\n@Override\n public boolean hasNext() {\n return ***B*** ;\n }\n\n@Override\n public String next() {\n if (hasNext()) {\n return dictWords[***C*** ];\n }\n throw new NoSuchElementException();\n }\n };\n }\n }\n\nThe EditDistance class (Program 2) calculates related words to suggest for spell checking\nusing the edit distance based on the Wagner–Fischer algorithm.\n\nAn edit distance indicates the number of insertions, deletions, and/or substitutions of\ncharacters needed to transform one word into another. If a character needs to be inserted or\ndeleted, it is treated as a cost or edit distance of one unit. If a character is substituted, it is\ntreated as a cost or edit distance of two units as a substitution can be considered as one\ndeletion and one insertion of a character. The algorithm compares both strings starting with\nan empty string to the full-length string, and always chooses the minimum edit distance\n(cost) from the three possible operations (an insertion, a deletion, or a substitution) at the\npoint. The intermediate edit distances are recorded in a matrix.\n\n- 41 -\n\nThere are three situations or operations while transforming a string to another string. The\nfollowing are examples of the operations.\n(1) Insertion: The edit distance from “cat” to “cats” is 1 because an insertion of the character\n ‘s’ is required.\n(2) Deletion: The edit distance from “boot” to “bot” is 1 because a deletion of a character\n ‘o’ is required.\n(3) Substitution: The edit distance from “let” to “lot” is 2 because a substitution of the\n character ‘e’ with the character ‘o’ is required.\n\nThe class has the following members:\n(1) The getSubstitutionCost method returns an edit distance (cost) of 2 if two characters\n are different, which means that it requires a substitution, or 0 (zero) otherwise.\n(2) The getDistance method calculates the edit distance between the two words, baseWord\n that has been given when instantiating this class and the word given by the dictWord\n parameter, based on the Wagner–Fischer algorithm.\n\nThe SpellChecker class (Program 3) suggests alternative words if any. The class has the\nfollowing members:\n(1) The THRESHOLD field is an integer constant to denote the acceptable edit distance to\n enable very close words to be suggested based on their edit distance of 2.\n(2) The suggestWords method finds out the words within the edit distance of THRESHOLD\n in the dictionary and suggests those words. If no close words are found, it returns an\n empty Set.\n\nThe Tester01 class (Program 4) tests the words suggested by SpellChecker and generates\nthe following output for the given input, “thier”:\n\nother there their\n\n[Program 2]\n\nimport java.util.Locale;\n\nclass EditDistance {\n private final String baseWord;\n\nEditDistance(String baseWord) {\n this.baseWord = baseWord.toLowerCase(Locale.ENGLISH);\n }\n\nprivate int getSubstitutionCost(char a, char b) {\n return a ***D*** b ? 0 : 2;\n }\n\n- 42 -\n\nint getDistance(String dictWord) {\n int[][] d\n = new int[baseWord.length() + 1][dictWord.length() + 1];\n\nfor (int i = 0; i < d.length; ++i) {\n for (int j = 0; j < d[0].length; ++j) {\n if (i == 0) {\n d[0][j] = j;\n } else if (j == 0) {\n d[i][0] = i;\n } else {\n int cost = getSubstitutionCost(baseWord.charAt(i - 1),\n dictWord.charAt(j - 1));\n // Calculate costs of the three different operations\n int substitution = cost + d[i - 1][j - 1];\n int deletion = d[i - 1][j] + 1;\n int insertion = d[i][j - 1] + 1;\n // Choose the cheapest one, and note down the value\n d[i][j] = Math.min(substitution,\n Math.min(deletion, insertion));\n }\n }\n }\n return d[d.length - 1][d[0].length - 1];\n }\n }\n\n[Program 3]\n\nimport java.util.HashSet;\n import java.util.Set;\n\n// Location 2\n\nfinal class SpellChecker {\n private static final int THRESHOLD = 2;\n\nprivate SpellChecker() {\n }\n\n- 43 -\n\nstatic Set<String> suggestWords(String word) {\n EditDistance editDistance = new EditDistance(word);\n Set<String> suggestedWords = new HashSet<>();\n for (String dictWord : WordDictionary.getIterable()) {\n if (editDistance.getDistance(dictWord) <= THRESHOLD) {\n suggestedWords.add(dictWord);\n }\n }\n return suggestedWords;\n }\n\n// Location 3\n }\n\n[Program 4]\n\nimport java.util.Set;\n\npublic class Tester01 {\n public static void main(String[] args) {\n Set<String> suggestedWords = SpellChecker.suggestWords(\"thier\");\n if (!suggestedWords.isEmpty()) {\n for (String suggested : suggestedWords) {\n System.out.print(suggested + \" \");\n }\n System.out.println();\n } else {\n System.out.println(\"no suggestions\");\n }\n }\n }\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted into each blank\n _______ in the programs above.\n\nAnswer group for A\n a) !element.equals(lowerCaseWord) b) element != lowerCaseWord\n c) element == lowerCaseWord d) element.equals(lowerCaseWord)\n\nAnswer group for B\n a) dictWords[index] != null b) index < dictWords.length\n c) index <= dictWords.length d) index == dictWords.length\n e) index > dictWords.length f) index >= dictWords.length\n\n- 44 -\n\nAnswer group for C\n a) --index b) ++index c) index\n d) index-- e) index++\n\nAnswer group for D\n a) != b) < c) <=\n d) == e) > f) >=\n\nSubquestion 2\n From the answer groups below, select the correct answer to be inserted into each blank\n _______ in the following program.\n\nSpellChecker (Program 3) has been modified so that if a word is present in the dictionary,\n then it remains unchanged in the output. If related words are found, they are shown as\n alternatives in parentheses in addition to the original word, e.g.,\n OriginalWord(/alternative1/alternative2/…). If none are found, the output is a\n question mark in parentheses, e.g., OriginalWord(?).\n\nThe Tester02 class (Program 5) tests the implementation of the modified SpellChecker\n and generates the following output for the given input, “Beacaus theer API-key is abt\n to expire”: (Note that the following output is wrapped owing to the paper width, and that\n the actual output is shown in a single line.)\n\nBeacaus(/because) theer(/other/there/their) API-key(?) is abt(/about)\n\nto expire(?)\n\nHere, suggested words were found and shown in parentheses for the words “Beacaus”,\n “theer”, and “abt” which were absent in the dictionary. Each suggestion is separated by a\n slash character (“/”). However, the words “API-key” and “expire” did not generate any\n suggestions; they are therefore followed by a question mark. The words “is” and “to” were\n found in the dictionary; hence, they remained unchanged in the output. To facilitate the\n modification, the following lines have been inserted at the locations marked by “Location\n 2” and “Location 3” as a comment in Program 3.\n\n- 45 -\n\n// Location 2\n import java.util.Scanner;\n // Location 3\n static String checkSentence(String sentence) {\n // Scanner breaks `sentence’ into tokens delimited by\n // whitespace and iterates over tokens.\n Scanner scanner = new Scanner(sentence);\n StringBuilder suggestions = new StringBuilder();\n while (scanner.hasNext()) {\n String word = scanner.next();\n suggestions.append(word);\n if (!WordDictionary.contains(word)) {\n suggestions.append(***E***);\n Set<String> suggestedWords = suggestWords(word);\n if (suggestedWords.isEmpty()) {\n suggestions.append(***F***);\n } else {\n for (String suggestedWord : suggestedWords) {\n suggestions.append(***G***).append(suggestedWord);\n }\n }\n suggestions.append(\")\");\n }\n if (scanner.hasNext()) {\n suggestions.append(\" \");\n }\n }\n return suggestions.toString();\n }\n\n[Program 5]\n\npublic class Tester02 {\n public static void main(String[] args) {\n System.out.println(SpellChecker.checkSentence(\n \"Beacaus theer API-key is abt to expire\"));\n }\n }\n\nAnswer group for E through G\n a) \"(\" b) \")\" c) \"/\"\n d) \"?\" e) scanner.next() f) word\n\n- 46 -\n\nSubquestion 3\n From the answer groups below, select the correct answer to be inserted into each blank\n _______ in the method implementation.\n\nIf the dictWords field in the WordDictionary class contains more words, there will be the\n need for a faster search mechanism than the current linear search in the contains method.\n The following is another implementation of the same method with the binary search.\n\nThe following compareTo method returns 0 if the argument string is equal to this string, a\n value less than 0 if this string is lexicographically less than the string argument, and a value\n greater than 0 if this string is lexicographically greater than the string argument.\n\nstatic boolean contains(String word) {\n String lowerCaseWord = word.toLowerCase(Locale.ENGLISH);\n int low = 0;\n int high = dictWords.length - 1;\n while (low <= high) {\n int mid = (low + high) / 2;\n int comp = dictWords[mid].compareTo(lowerCaseWord);\n if (comp < 0) {\n low = ***H***;\n } else if (comp > 0) {\n high = ***I***;\n } else {\n return true;\n }\n }\n return false;\n }"}]'::jsonb,
  '["2022-april-b-q08-figure1.webp","2022-april-b-q08-figure2.webp"]'::jsonb,
  '[{"label":"a","text":"high - mid"},{"label":"b","text":"low + mid"},{"label":"c","text":"mid"},{"label":"d","text":"mid + 1"},{"label":"e","text":"mid - 1\n\n_ _\nCompany names and product names appearing in the test questions are trademarks or registered\ntrademarks of their respective companies. Note that the ® and ™ symbols are not used within the text.\n\n - 47 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "d"}, {"subquestion": 1, "blank": "B", "answer": "b"}, {"subquestion": 1, "blank": "C", "answer": "e"}, {"subquestion": 1, "blank": "D", "answer": "d"}, {"subquestion": 2, "blank": "E", "answer": "a"}, {"subquestion": 2, "blank": "F", "answer": "d"}, {"subquestion": 2, "blank": "G", "answer": "c"}, {"subquestion": 3, "blank": "H", "answer": "d"}, {"subquestion": 3, "blank": "I", "answer": "e"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"d"},{"subquestion":1,"blank":"B","answer":"b"},{"subquestion":1,"blank":"C","answer":"e"},{"subquestion":1,"blank":"D","answer":"d"},{"subquestion":2,"blank":"E","answer":"a"},{"subquestion":2,"blank":"F","answer":"d"},{"subquestion":2,"blank":"G","answer":"c"},{"subquestion":3,"blank":"H","answer":"d"},{"subquestion":3,"blank":"I","answer":"e"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2022S, FE, Subject-B, Q8)',
  ARRAY[40,41,42,43,44,45,46,47]::int[],
  'native_text',
  '3.0',
  'Q8 Read the following description of Java programs, and then answer Subquestions 1
 through 3.

 [Program Description]
 This program is a prototype implementation of a spell checker. The spell checker checks if
 the given words are spelled correctly. To cross match, this program utilizes a pre-populated
 dictionary called WordDictionary. Given a word, the spell checker tries to find and suggest
 related words.

 The WordDictionary class (Program 1) represents a dictionary with pre-populated English
 words. The class has the following members.
 (1) The dictWords field is a String array containing pre-populated known words. All
 words are in lowercase and are sorted in ascending order.
 (2) The contains method looks up the given word to determine whether the dictionary
 contains the word.
 (3) The getIterable method returns an Iterable to return an Iterator that iterates
 over the words in dictWords. In Iterator, the hasNext method returns true if the
 iteration has more elements, and the next method returns the next element in the
 iteration.

 [Program 1]

 import java.util.Iterator;
 import java.util.Locale;
 import java.util.NoSuchElementException;

 final class WordDictionary {
 private static final String[] dictWords = {
 "about", "because", "could", "food", "is", "other", "people",
 "their", "there", "think", "to", "which", "would"
 };

 private WordDictionary() {
 }

 - 40 -

static boolean contains(String word) {
 String lowerCaseWord = word.toLowerCase(Locale.ENGLISH);
 for (String element : dictWords) {
 if (___A___) {
 return true;
 }
 }
 return false;
 }

 static Iterable<String> getIterable() {
 // Note that the default remove() implementation throws
 // an UnsupportedOperationException.
 return () -> new Iterator<String>() {
 private int index;

 @Override
 public boolean hasNext() {
 return ___B___ ;
 }

 @Override
 public String next() {
 if (hasNext()) {
 return dictWords[___C___ ];
 }
 throw new NoSuchElementException();
 }
 };
 }
 }

The EditDistance class (Program 2) calculates related words to suggest for spell checking
using the edit distance based on the Wagner–Fischer algorithm.

An edit distance indicates the number of insertions, deletions, and/or substitutions of
characters needed to transform one word into another. If a character needs to be inserted or
deleted, it is treated as a cost or edit distance of one unit. If a character is substituted, it is
treated as a cost or edit distance of two units as a substitution can be considered as one
deletion and one insertion of a character. The algorithm compares both strings starting with
an empty string to the full-length string, and always chooses the minimum edit distance
(cost) from the three possible operations (an insertion, a deletion, or a substitution) at the
point. The intermediate edit distances are recorded in a matrix.

 - 41 -

There are three situations or operations while transforming a string to another string. The
following are examples of the operations.
(1) Insertion: The edit distance from “cat” to “cats” is 1 because an insertion of the character
 ‘s’ is required.
(2) Deletion: The edit distance from “boot” to “bot” is 1 because a deletion of a character
 ‘o’ is required.
(3) Substitution: The edit distance from “let” to “lot” is 2 because a substitution of the
 character ‘e’ with the character ‘o’ is required.

The class has the following members:
(1) The getSubstitutionCost method returns an edit distance (cost) of 2 if two characters
 are different, which means that it requires a substitution, or 0 (zero) otherwise.
(2) The getDistance method calculates the edit distance between the two words, baseWord
 that has been given when instantiating this class and the word given by the dictWord
 parameter, based on the Wagner–Fischer algorithm.

The SpellChecker class (Program 3) suggests alternative words if any. The class has the
following members:
(1) The THRESHOLD field is an integer constant to denote the acceptable edit distance to
 enable very close words to be suggested based on their edit distance of 2.
(2) The suggestWords method finds out the words within the edit distance of THRESHOLD
 in the dictionary and suggests those words. If no close words are found, it returns an
 empty Set.

The Tester01 class (Program 4) tests the words suggested by SpellChecker and generates
the following output for the given input, “thier”:

 other there their

[Program 2]

 import java.util.Locale;

 class EditDistance {
 private final String baseWord;

 EditDistance(String baseWord) {
 this.baseWord = baseWord.toLowerCase(Locale.ENGLISH);
 }

 private int getSubstitutionCost(char a, char b) {
 return a ___D___ b ? 0 : 2;
 }

 - 42 -

int getDistance(String dictWord) {
 int[][] d
 = new int[baseWord.length() + 1][dictWord.length() + 1];

 for (int i = 0; i < d.length; ++i) {
 for (int j = 0; j < d[0].length; ++j) {
 if (i == 0) {
 d[0][j] = j;
 } else if (j == 0) {
 d[i][0] = i;
 } else {
 int cost = getSubstitutionCost(baseWord.charAt(i - 1),
 dictWord.charAt(j - 1));
 // Calculate costs of the three different operations
 int substitution = cost + d[i - 1][j - 1];
 int deletion = d[i - 1][j] + 1;
 int insertion = d[i][j - 1] + 1;
 // Choose the cheapest one, and note down the value
 d[i][j] = Math.min(substitution,
 Math.min(deletion, insertion));
 }
 }
 }
 return d[d.length - 1][d[0].length - 1];
 }
 }

[Program 3]

 import java.util.HashSet;
 import java.util.Set;

 // Location 2

 final class SpellChecker {
 private static final int THRESHOLD = 2;

 private SpellChecker() {
 }

 - 43 -

static Set<String> suggestWords(String word) {
 EditDistance editDistance = new EditDistance(word);
 Set<String> suggestedWords = new HashSet<>();
 for (String dictWord : WordDictionary.getIterable()) {
 if (editDistance.getDistance(dictWord) <= THRESHOLD) {
 suggestedWords.add(dictWord);
 }
 }
 return suggestedWords;
 }

 // Location 3
 }

 [Program 4]

 import java.util.Set;

 public class Tester01 {
 public static void main(String[] args) {
 Set<String> suggestedWords = SpellChecker.suggestWords("thier");
 if (!suggestedWords.isEmpty()) {
 for (String suggested : suggestedWords) {
 System.out.print(suggested + " ");
 }
 System.out.println();
 } else {
 System.out.println("no suggestions");
 }
 }
 }

Subquestion 1
 From the answer groups below, select the correct answer to be inserted into each blank
 _______ in the programs above.

 Answer group for A
 a) !element.equals(lowerCaseWord) b) element != lowerCaseWord
 c) element == lowerCaseWord d) element.equals(lowerCaseWord)

 Answer group for B
 a) dictWords[index] != null b) index < dictWords.length
 c) index <= dictWords.length d) index == dictWords.length
 e) index > dictWords.length f) index >= dictWords.length

 - 44 -

Answer group for C
 a) --index b) ++index c) index
 d) index-- e) index++

 Answer group for D
 a) != b) < c) <=
 d) == e) > f) >=

Subquestion 2
 From the answer groups below, select the correct answer to be inserted into each blank
 _______ in the following program.

 SpellChecker (Program 3) has been modified so that if a word is present in the dictionary,
 then it remains unchanged in the output. If related words are found, they are shown as
 alternatives in parentheses in addition to the original word, e.g.,
 OriginalWord(/alternative1/alternative2/…). If none are found, the output is a
 question mark in parentheses, e.g., OriginalWord(?).

 The Tester02 class (Program 5) tests the implementation of the modified SpellChecker
 and generates the following output for the given input, “Beacaus theer API-key is abt
 to expire”: (Note that the following output is wrapped owing to the paper width, and that
 the actual output is shown in a single line.)

 Beacaus(/because) theer(/other/there/their) API-key(?) is abt(/about)

 to expire(?)

 Here, suggested words were found and shown in parentheses for the words “Beacaus”,
 “theer”, and “abt” which were absent in the dictionary. Each suggestion is separated by a
 slash character (“/”). However, the words “API-key” and “expire” did not generate any
 suggestions; they are therefore followed by a question mark. The words “is” and “to” were
 found in the dictionary; hence, they remained unchanged in the output. To facilitate the
 modification, the following lines have been inserted at the locations marked by “Location
 2” and “Location 3” as a comment in Program 3.

 - 45 -

// Location 2
 import java.util.Scanner;
 // Location 3
 static String checkSentence(String sentence) {
 // Scanner breaks `sentence’ into tokens delimited by
 // whitespace and iterates over tokens.
 Scanner scanner = new Scanner(sentence);
 StringBuilder suggestions = new StringBuilder();
 while (scanner.hasNext()) {
 String word = scanner.next();
 suggestions.append(word);
 if (!WordDictionary.contains(word)) {
 suggestions.append(___E___);
 Set<String> suggestedWords = suggestWords(word);
 if (suggestedWords.isEmpty()) {
 suggestions.append(___F___);
 } else {
 for (String suggestedWord : suggestedWords) {
 suggestions.append(___G___).append(suggestedWord);
 }
 }
 suggestions.append(")");
 }
 if (scanner.hasNext()) {
 suggestions.append(" ");
 }
 }
 return suggestions.toString();
 }

[Program 5]

 public class Tester02 {
 public static void main(String[] args) {
 System.out.println(SpellChecker.checkSentence(
 "Beacaus theer API-key is abt to expire"));
 }
 }

Answer group for E through G
 a) "(" b) ")" c) "/"
 d) "?" e) scanner.next() f) word

 - 46 -

Subquestion 3
 From the answer groups below, select the correct answer to be inserted into each blank
 _______ in the method implementation.

 If the dictWords field in the WordDictionary class contains more words, there will be the
 need for a faster search mechanism than the current linear search in the contains method.
 The following is another implementation of the same method with the binary search.

 The following compareTo method returns 0 if the argument string is equal to this string, a
 value less than 0 if this string is lexicographically less than the string argument, and a value
 greater than 0 if this string is lexicographically greater than the string argument.

 static boolean contains(String word) {
 String lowerCaseWord = word.toLowerCase(Locale.ENGLISH);
 int low = 0;
 int high = dictWords.length - 1;
 while (low <= high) {
 int mid = (low + high) / 2;
 int comp = dictWords[mid].compareTo(lowerCaseWord);
 if (comp < 0) {
 low = ___H___;
 } else if (comp > 0) {
 high = ___I___;
 } else {
 return true;
 }
 }
 return false;
 }

 Answer group for H and I
 a) high - mid b) low + mid c) mid
 d) mid + 1 e) mid - 1

_ _
Company names and product names appearing in the test questions are trademarks or registered
trademarks of their respective companies. Note that the ® and ™ symbols are not used within the text.

 - 47 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2022-april/b/questions.pdf","pages":[40,41,42,43,44,45,46,47]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2022-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
)
ON CONFLICT (exam_session, subject, question_number) DO UPDATE SET
  question_text = EXCLUDED.question_text,
  content_blocks = EXCLUDED.content_blocks,
  images = EXCLUDED.images,
  choices = EXCLUDED.choices,
  correct_answer = EXCLUDED.correct_answer,
  answer_key = EXCLUDED.answer_key,
  source_citation = EXCLUDED.source_citation,
  source_pages = EXCLUDED.source_pages,
  source_text = EXCLUDED.source_text,
  ref_doc = EXCLUDED.ref_doc,
  extraction_method = EXCLUDED.extraction_method,
  extraction_version = EXCLUDED.extraction_version,
  updated_at = now();

INSERT INTO exams (exam_session, subject, title, question_count, time_limit_minutes, initial_hearts, published)
VALUES ('2022-april', 'A', '2022 April FE Subject A', 60, 150, 5, true)
ON CONFLICT (exam_session, subject) DO UPDATE SET
  title = EXCLUDED.title, question_count = EXCLUDED.question_count,
  time_limit_minutes = EXCLUDED.time_limit_minutes, published = EXCLUDED.published;

DELETE FROM exam_questions
WHERE exam_id = (SELECT id FROM exams WHERE exam_session = '2022-april' AND subject = 'A');
INSERT INTO exam_questions (exam_id, question_id, sequence_number)
SELECT e.id, q.id, q.question_number
FROM exams e
JOIN questions q ON q.exam_session = e.exam_session AND q.subject = e.subject
WHERE e.exam_session = '2022-april' AND e.subject = 'A'
ORDER BY q.question_number;

INSERT INTO exams (exam_session, subject, title, question_count, time_limit_minutes, initial_hearts, published)
VALUES ('2022-april', 'B', '2022 April FE Subject B', 8, 150, 5, true)
ON CONFLICT (exam_session, subject) DO UPDATE SET
  title = EXCLUDED.title, question_count = EXCLUDED.question_count,
  time_limit_minutes = EXCLUDED.time_limit_minutes, published = EXCLUDED.published;

DELETE FROM exam_questions
WHERE exam_id = (SELECT id FROM exams WHERE exam_session = '2022-april' AND subject = 'B');
INSERT INTO exam_questions (exam_id, question_id, sequence_number)
SELECT e.id, q.id, q.question_number
FROM exams e
JOIN questions q ON q.exam_session = e.exam_session AND q.subject = e.subject
WHERE e.exam_session = '2022-april' AND e.subject = 'B'
ORDER BY q.question_number;

COMMIT;
