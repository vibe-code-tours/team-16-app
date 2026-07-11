-- NerdQuiz seed: 2021 April FE Subjects A and B
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
  '2021-april',
  'A',
  1,
  'Q1. Which of the following should be used for marking your answer on the answer
 sheet?',
  '[{"type":"text","page":1,"bbox":[107.22,539.33,200.53,552.61],"text":"[Sample Question]"},{"type":"text","page":1,"bbox":[117.72,555.18,533.08,568.63],"text":"Q1. Which of the following should be used for marking your answer on the answer"},{"type":"text","page":1,"bbox":[65.22,571.31,178.76,600.55],"text":"sheet?"},{"type":"text","page":1,"bbox":[65.22,603.35,501.46,632.59],"text":"a) Ballpoint pen\nb) Crayon\nc) Fountain pen\nd) Pencil"},{"type":"text","page":1,"bbox":[107.22,635.33,439.97,680.59],"text":"Since the correct answer is “d) Pencil”, mark the answer as below:\n\n[Sample Answer]"},{"type":"table","page":1,"bbox":[138.15,681.93,497.55,704.01],"rows":[["Q1","ウ"]]},{"type":"text","page":1,"bbox":[155.52,686.94,379.98,702.97],"text":"Q1"},{"type":"text","page":1,"bbox":[441.42,688.73,456.1,698.65],"text":"ウ"},{"type":"text","page":1,"bbox":[167.4,741.88,445.72,754.49],"text":"Do not open the exam booklet until instructed to do so."},{"type":"text","page":1,"bbox":[162.78,759.82,450.4,772.43],"text":"Inquiries about the exam questions will not be answered."},{"type":"code","page":1,"bbox":[65.22,794.63,311.58,808.39],"text":"– 1 –"},{"type":"text","page":2,"bbox":[65.22,68.76,533.07,136.21],"text":"Symbols commonly used in questions\n\nUnless otherwise noted in each question, the following notational conventions are applied as\nshown in the table."},{"type":"text","page":2,"bbox":[65.22,141.28,134.14,171.13],"text":"Logic Circuit"},{"type":"table","page":2,"bbox":[113.55,191.46,446.73,612.06],"rows":[["Graphic symbol","Explanation"],["","AND gate"],["","NAND gate"],["","OR gate"],["","NOR gate"],["","Exclusive OR (XOR) gate"],["","Exclusive NOR gate"],["","Buffer"],["","NOT gate"],["","Three-state buffer (or tri-state buffer)"],["","A small circle or “bubble” on either the\ninput or the output terminal shows inversion\nor negation of the logic state."]]},{"type":"text","page":2,"bbox":[125.04,199.55,369.53,212.83],"text":"Graphic symbol\nExplanation"},{"type":"text","page":2,"bbox":[186.42,232.13,288.82,245.59],"text":"AND gate"},{"type":"text","page":2,"bbox":[186.42,268.91,297.51,282.37],"text":"NAND gate"},{"type":"text","page":2,"bbox":[190.14,305.63,279.55,319.09],"text":"OR gate"},{"type":"text","page":2,"bbox":[190.14,342.41,288.18,355.87],"text":"NOR gate"},{"type":"text","page":2,"bbox":[190.14,379.13,372.22,392.59],"text":"Exclusive OR (XOR) gate"},{"type":"text","page":2,"bbox":[190.14,415.91,341.55,429.37],"text":"Exclusive NOR gate"},{"type":"text","page":2,"bbox":[190.14,452.63,267.96,466.09],"text":"Buffer"},{"type":"text","page":2,"bbox":[190.14,489.41,281.27,502.87],"text":"NOT gate"},{"type":"text","page":2,"bbox":[190.14,526.31,421.74,546.37],"text":"Three-state buffer (or tri-state buffer)"},{"type":"text","page":2,"bbox":[227.88,560.33,443.58,603.61],"text":"A small circle or “bubble” on either the\ninput or the output terminal shows inversion\nor negation of the logic state."},{"type":"text","page":2,"bbox":[65.22,614.99,532.84,763.81],"text":"Company names or product names mentioned in the examination questions are the trademarks or registered\ntrademarks of their respective companies or organizations. The symbol ® or ™ is not used within."},{"type":"code","page":2,"bbox":[65.22,794.63,311.58,808.39],"text":"– 2 –"}]'::jsonb,
  '["2021-april-a-q01-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Ballpoint pen"},{"label":"b","text":"Crayon"},{"label":"c","text":"Fountain pen"},{"label":"d","text":"Pencil\n\n Since the correct answer is “d) Pencil”, mark the answer as below:\n\n [Sample Answer]\n Q1 ウ\n\n Do not open the exam booklet until instructed to do so.\n\n Inquiries about the exam questions will not be answered.\n\n – 1 –\n\nSymbols commonly used in questions\n\nUnless otherwise noted in each question, the following notational conventions are applied as\nshown in the table.\n\nLogic Circuit\n\n Graphic symbol Explanation\n\n AND gate\n\n NAND gate\n\n OR gate\n\n NOR gate\n\n Exclusive OR (XOR) gate\n\n Exclusive NOR gate\n\n Buffer\n\n NOT gate\n\n Three-state buffer (or tri-state buffer)\n\n A small circle or “bubble” on either the\n input or the output terminal shows inversion\n or negation of the logic state.\n\nCompany names or product names mentioned in the examination questions are the trademarks or registered\ntrademarks of their respective companies or organizations. The symbol ® or ™ is not used within.\n\n – 2 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q1)',
  ARRAY[1,2]::int[],
  'native_text',
  '3.0',
  'Q1. Which of the following should be used for marking your answer on the answer
 sheet?

 a) Ballpoint pen b) Crayon c) Fountain pen d) Pencil

 Since the correct answer is “d) Pencil”, mark the answer as below:

 [Sample Answer]
 Q1 ウ

 Do not open the exam booklet until instructed to do so.

 Inquiries about the exam questions will not be answered.

 – 1 –

Symbols commonly used in questions

Unless otherwise noted in each question, the following notational conventions are applied as
shown in the table.

Logic Circuit

 Graphic symbol Explanation

 AND gate

 NAND gate

 OR gate

 NOR gate

 Exclusive OR (XOR) gate

 Exclusive NOR gate

 Buffer

 NOT gate

 Three-state buffer (or tri-state buffer)

 A small circle or “bubble” on either the
 input or the output terminal shows inversion
 or negation of the logic state.

Company names or product names mentioned in the examination questions are the trademarks or registered
trademarks of their respective companies or organizations. The symbol ® or ™ is not used within.

 – 2 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[1,2]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  false
),
(
  '2021-april',
  'A',
  2,
  'Q2. Which of the following is a decimal that is represented as a finite digit octal fraction?',
  '[{"type":"text","page":3,"bbox":[65.22,238.74,506.15,288.19],"text":"Q2. Which of the following is a decimal that is represented as a finite digit octal fraction?"},{"type":"text","page":3,"bbox":[65.22,292.91,473.1,324.19],"text":"a) 0.3\nb) 0.4\nc) 0.5\nd) 0.8"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0.3"},{"label":"b","text":"0.4"},{"label":"c","text":"0.5"},{"label":"d","text":"0.8"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q2)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q2. Which of the following is a decimal that is represented as a finite digit octal fraction?

 a) 0.3 b) 0.4 c) 0.5 d) 0.8',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  3,
  'Q3. The GCD (Greatest Common Divisor) of two positive integers, x0 and x1 (x0 > x1), is
 computed by the procedure below. When x0 = 175 and x1 = 77, how many times should step
 (2) of this procedure be executed before it stops? Here, “A ← B” indicates that B is substituted
 for A.

 [Procedure]
 (1) i ← 2
 (2) xi ← remainder of xi−2 divided by xi−1
 (3) if xi = 0, stop with xi−1 as the GCD
 (4) i ← i + 1
 (5) return to step (2)',
  '[{"type":"text","page":3,"bbox":[65.22,328.91,533.08,360.19],"text":"Q3. The GCD (Greatest Common Divisor) of two positive integers, x0 and x1 (x0 > x1), is"},{"type":"text","page":3,"bbox":[65.22,364.91,533.1,432.19],"text":"computed by the procedure below. When x0 = 175 and x1 = 77, how many times should step\n(2) of this procedure be executed before it stops? Here, “A ← B” indicates that B is substituted\nfor A."},{"type":"text","page":3,"bbox":[79.38,436.91,139.02,450.19],"text":"[Procedure]"},{"type":"text","page":3,"bbox":[100.62,454.91,310.5,504.19],"text":"(1)\ni ← 2\n(2)\nxi ← remainder of xi−2 divided by xi−1\n(3)\nif xi = 0, stop with xi−1 as the GCD"},{"type":"code","page":3,"bbox":[65.22,508.91,464.1,647.11],"text":"(4)\ni ← i + 1\n(5)  return to step (2)\n\n\na) 3\nb) 4\nc) 6\nd) 7"},{"type":"code","page":3,"bbox":[65.22,794.63,311.58,808.39],"text":"– 3 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"3"},{"label":"b","text":"4"},{"label":"c","text":"6"},{"label":"d","text":"7\n\n – 3 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q3)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q3. The GCD (Greatest Common Divisor) of two positive integers, x0 and x1 (x0 > x1), is
 computed by the procedure below. When x0 = 175 and x1 = 77, how many times should step
 (2) of this procedure be executed before it stops? Here, “A ← B” indicates that B is substituted
 for A.

 [Procedure]
 (1) i ← 2
 (2) xi ← remainder of xi−2 divided by xi−1
 (3) if xi = 0, stop with xi−1 as the GCD
 (4) i ← i + 1
 (5) return to step (2)

 a) 3 b) 4 c) 6 d) 7

 – 3 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  4,
  'Q4. To compare the entrance exams of the current and previous years, a company required
 many of its employees to take those exams. The correlation coefficient and the regression line
 were obtained by assigning the scores of the previous year to the x-axis and the scores of the
 current year to the y-axis. Which of the following can be derived from the results below?

 [Results]
 The correlation coefficient is 0.8.
 The slope of the regression line is 1.1.
 The y-intercept of the regression line is 10.',
  '[{"type":"text","page":4,"bbox":[65.22,67.74,533.16,135.13],"text":"Q4.\nTo compare the entrance exams of the current and previous years, a company required\nmany of its employees to take those exams. The correlation coefficient and the regression line\nwere obtained by assigning the scores of the previous year to the x-axis and the scores of the\ncurrent year to the y-axis. Which of the following can be derived from the results below?"},{"type":"text","page":4,"bbox":[79.38,159.95,125.72,173.23],"text":"[Results]"},{"type":"text","page":4,"bbox":[65.22,175.85,311.96,243.13],"text":"The correlation coefficient is 0.8.\nThe slope of the regression line is 1.1.\nThe y-intercept of the regression line is 10."},{"type":"text","page":4,"bbox":[84.12,248.93,505.0,262.21],"text":"a) From the slope and the y-intercept of the regression line, the tendency is to obtain a"},{"type":"text","page":4,"bbox":[84.12,266.93,508.62,298.21],"text":"higher score for the current year than the previous year\nb) From the slope of the regression line and the correlation coefficient, the exam of the"},{"type":"text","page":4,"bbox":[84.12,302.93,523.55,334.21],"text":"current year is of high quality.\nc) From the slope of the regression line, the average score for the current year is 1.1 times"},{"type":"text","page":4,"bbox":[84.12,338.93,526.66,370.21],"text":"that of the previous year.\nd) From the y-intercept of regression line, those who get zero for the current year can get a"},{"type":"text","page":4,"bbox":[102.12,374.93,301.41,388.21],"text":"score as high as 10 for the previous year."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"From the slope and the y-intercept of the regression line, the tendency is to obtain a\n higher score for the current year than the previous year"},{"label":"b","text":"From the slope of the regression line and the correlation coefficient, the exam of the\n current year is of high quality."},{"label":"c","text":"From the slope of the regression line, the average score for the current year is 1.1 times\n that of the previous year."},{"label":"d","text":"From the y-intercept of regression line, those who get zero for the current year can get a\n score as high as 10 for the previous year."}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q4)',
  ARRAY[4]::int[],
  'native_text',
  '3.0',
  'Q4. To compare the entrance exams of the current and previous years, a company required
 many of its employees to take those exams. The correlation coefficient and the regression line
 were obtained by assigning the scores of the previous year to the x-axis and the scores of the
 current year to the y-axis. Which of the following can be derived from the results below?

 [Results]
 The correlation coefficient is 0.8.
 The slope of the regression line is 1.1.
 The y-intercept of the regression line is 10.

 a) From the slope and the y-intercept of the regression line, the tendency is to obtain a
 higher score for the current year than the previous year
 b) From the slope of the regression line and the correlation coefficient, the exam of the
 current year is of high quality.
 c) From the slope of the regression line, the average score for the current year is 1.1 times
 that of the previous year.
 d) From the y-intercept of regression line, those who get zero for the current year can get a
 score as high as 10 for the previous year.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[4]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  5,
  'Q5. The table below is a state transition table used for character string validation. In this table,
 “A” represents the initial state, and “E” represents the failure state. Which of the following is
 a character string that fails this validation? Here, each character of a string is parsed from the
 leftmost side, and the symbol “” represents a blank character.

 Character

 Blank Number Sign Radix point Other
 A A B C D E
 Current B A B E D E
 state C E B E D E
 D A E E E E',
  '[{"type":"text","page":4,"bbox":[65.22,410.76,533.14,442.21],"text":"Q5. The table below is a state transition table used for character string validation. In this table,"},{"type":"text","page":4,"bbox":[79.32,446.93,533.14,496.21],"text":"“A” represents the initial state, and “E” represents the failure state. Which of the following is\na character string that fails this validation? Here, each character of a string is parsed from the\nleftmost side, and the symbol “” represents a blank character."},{"type":"table","page":4,"bbox":[93.6,515.58,489.48,629.52],"rows":[[null,null,"Character",null,null,null,null],[null,null,"Blank","Number","Sign","Radix point","Other"],["Current\nstate","A\nB\nC\nD","A\nA\nE\nA","B\nB\nB\nE","C\nE\nE\nE","D\nD\nD\nE","E\nE\nE\nE"]]},{"type":"text","page":4,"bbox":[93.54,518.51,356.77,532.75],"text":"Character"},{"type":"text","page":4,"bbox":[93.54,539.15,474.17,553.33],"text":"Blank\nNumber\nSign\nRadix point\nOther"},{"type":"text","page":4,"bbox":[97.98,559.55,137.71,590.83],"text":"Current"},{"type":"text","page":4,"bbox":[150.96,559.55,162.6,626.83],"text":"A\nB\nC\nD"},{"type":"text","page":4,"bbox":[199.2,559.55,209.52,626.83],"text":"A\nA\nE\nA"},{"type":"text","page":4,"bbox":[262.5,559.55,272.82,626.83],"text":"B\nB\nB\nE"},{"type":"text","page":4,"bbox":[325.92,559.55,336.9,626.83],"text":"C\nE\nE\nE"},{"type":"text","page":4,"bbox":[389.4,559.55,401.04,608.83],"text":"D\nD\nD"},{"type":"text","page":4,"bbox":[453.84,559.55,464.16,626.83],"text":"E\nE\nE\nE"},{"type":"text","page":4,"bbox":[105.36,595.55,130.32,608.83],"text":"state"},{"type":"text","page":4,"bbox":[390.06,613.55,400.38,626.83],"text":"E"},{"type":"text","page":4,"bbox":[65.22,651.59,479.1,699.79],"text":"a) +0010\nb) −1\nc) 12.2\nd) 9."},{"type":"code","page":4,"bbox":[65.22,794.63,311.58,808.39],"text":"– 4 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"+0010"},{"label":"b","text":"−1"},{"label":"c","text":"12.2"},{"label":"d","text":"9.\n\n – 4 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q5)',
  ARRAY[4]::int[],
  'native_text',
  '3.0',
  'Q5. The table below is a state transition table used for character string validation. In this table,
 “A” represents the initial state, and “E” represents the failure state. Which of the following is
 a character string that fails this validation? Here, each character of a string is parsed from the
 leftmost side, and the symbol “” represents a blank character.

 Character

 Blank Number Sign Radix point Other
 A A B C D E
 Current B A B E D E
 state C E B E D E
 D A E E E E

 a) +0010 b) −1 c) 12.2 d) 9.

 – 4 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[4]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  6,
  'Q6. Which of the following is an appropriate description of parity check (vertical parity) that
 handles transmission errors on a communication line?

 a) A parity check can correct 1-bit and 2-bit errors.
 b) A parity check can detect a 1-bit error.
 c) An odd parity check can detect a 1-bit error, but an even parity check cannot even detect
 a 1-bit error.
 d) An odd parity check can detect any odd number of bit errors, and an even parity check
 can detect any even number of bit errors.',
  '[{"type":"text","page":5,"bbox":[65.22,68.76,533.14,82.21],"text":"Q6. Which of the following is an appropriate description of parity check (vertical parity) that"},{"type":"text","page":5,"bbox":[79.32,86.93,340.95,100.21],"text":"handles transmission errors on a communication line?"},{"type":"text","page":5,"bbox":[84.12,122.93,337.37,136.21],"text":"a) A parity check can correct 1-bit and 2-bit errors."},{"type":"text","page":5,"bbox":[84.12,140.93,290.38,154.21],"text":"b) A parity check can detect a 1-bit error."},{"type":"text","page":5,"bbox":[84.12,158.93,529.96,172.21],"text":"c) An odd parity check can detect a 1-bit error, but an even parity check cannot even detect"},{"type":"text","page":5,"bbox":[102.12,176.93,165.47,190.21],"text":"a 1-bit error."},{"type":"text","page":5,"bbox":[84.12,194.93,519.96,208.21],"text":"d) An odd parity check can detect any odd number of bit errors, and an even parity check"},{"type":"text","page":5,"bbox":[102.12,212.76,302.08,226.21],"text":"can detect any even number of bit errors."}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q6)',
  ARRAY[5]::int[],
  'native_text',
  '3.0',
  'Q6. Which of the following is an appropriate description of parity check (vertical parity) that
 handles transmission errors on a communication line?

 a) A parity check can correct 1-bit and 2-bit errors.
 b) A parity check can detect a 1-bit error.
 c) An odd parity check can detect a 1-bit error, but an even parity check cannot even detect
 a 1-bit error.
 d) An odd parity check can detect any odd number of bit errors, and an even parity check
 can detect any even number of bit errors.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[5]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  7,
  'Q7. When a sequence of data, A, B, C, D, arrives in this order, which of the following is a
 possible sequence that can be produced using a single stack?',
  '[{"type":"text","page":5,"bbox":[65.22,266.76,533.1,280.21],"text":"Q7. When a sequence of data, A, B, C, D, arrives in this order, which of the following is a"},{"type":"text","page":5,"bbox":[79.33,284.93,373.31,298.21],"text":"possible sequence that can be produced using a single stack?"},{"type":"text","page":5,"bbox":[84.13,320.93,507.42,334.21],"text":"a) A, D, B, C\nb) B, D, A, C\nc) C, B, D, A\nd) D, C, A, B"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A, D, B, C"},{"label":"b","text":"B, D, A, C"},{"label":"c","text":"C, B, D, A"},{"label":"d","text":"D, C, A, B"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q7)',
  ARRAY[5]::int[],
  'native_text',
  '3.0',
  'Q7. When a sequence of data, A, B, C, D, arrives in this order, which of the following is a
 possible sequence that can be produced using a single stack?

 a) A, D, B, C b) B, D, A, C c) C, B, D, A d) D, C, A, B',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[5]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  8,
  'Q8. The in-order traversal of a binary tree is a procedure that visits all nodes of the tree. For a
 non-empty binary tree T, it performs the following operations in order.

 (1) Recursively performs the in-order traversal of the left subtree of T.
 (2) Visits the root node of T.
 (3) Recursively performs the in-order traversal of the right subtree of T.

 Which of the following is the ordered sequence of nodes when the in-order traversal is
 performed on the binary tree below?',
  '[{"type":"text","page":5,"bbox":[65.22,373.74,533.09,387.19],"text":"Q8. The in-order traversal of a binary tree is a procedure that visits all nodes of the tree. For a"},{"type":"text","page":5,"bbox":[79.32,391.85,420.82,405.13],"text":"non-empty binary tree T, it performs the following operations in order."},{"type":"text","page":5,"bbox":[84.12,428.93,425.28,442.21],"text":"(1) Recursively performs the in-order traversal of the left subtree of T."},{"type":"text","page":5,"bbox":[84.12,446.93,225.12,460.21],"text":"(2) Visits the root node of T."},{"type":"text","page":5,"bbox":[83.22,464.93,431.94,495.13],"text":"(3) Recursively performs the in-order traversal of the right subtree of T."},{"type":"text","page":5,"bbox":[86.34,499.85,533.13,513.13],"text":"Which of the following is the ordered sequence of nodes when the in-order traversal is"},{"type":"text","page":5,"bbox":[79.38,517.85,257.29,531.13],"text":"performed on the binary tree below?"},{"type":"text","page":5,"bbox":[84.12,680.93,432.45,694.21],"text":"a) 1, 2, 4, 7, 8, 5, 3, 6, 9\nb) 6, 9, 3, 1, 5, 2, 8, 4, 7"},{"type":"text","page":5,"bbox":[84.12,698.93,432.45,712.21],"text":"c) 7, 4, 8, 2, 5, 1, 3, 9, 6\nd) 7, 8, 4, 5, 2, 9, 6, 3, 1"},{"type":"code","page":5,"bbox":[65.22,794.63,311.58,808.39],"text":"– 5 –"}]'::jsonb,
  '["2021-april-a-q08-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"1, 2, 4, 7, 8, 5, 3, 6, 9"},{"label":"b","text":"6, 9, 3, 1, 5, 2, 8, 4, 7"},{"label":"c","text":"7, 4, 8, 2, 5, 1, 3, 9, 6"},{"label":"d","text":"7, 8, 4, 5, 2, 9, 6, 3, 1\n\n – 5 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q8)',
  ARRAY[5]::int[],
  'native_text',
  '3.0',
  'Q8. The in-order traversal of a binary tree is a procedure that visits all nodes of the tree. For a
 non-empty binary tree T, it performs the following operations in order.

 (1) Recursively performs the in-order traversal of the left subtree of T.
 (2) Visits the root node of T.
 (3) Recursively performs the in-order traversal of the right subtree of T.

 Which of the following is the ordered sequence of nodes when the in-order traversal is
 performed on the binary tree below?

 a) 1, 2, 4, 7, 8, 5, 3, 6, 9 b) 6, 9, 3, 1, 5, 2, 8, 4, 7
 c) 7, 4, 8, 2, 5, 1, 3, 9, 6 d) 7, 8, 4, 5, 2, 9, 6, 3, 1

 – 5 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[5]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  9,
  'Q9. Which of the following explains the objective of a recursive call?',
  '[{"type":"text","page":6,"bbox":[65.22,68.76,410.53,100.21],"text":"Q9. Which of the following explains the objective of a recursive call?"},{"type":"text","page":6,"bbox":[65.22,104.93,496.27,189.13],"text":"a) To allow a function to use itself from within its body\nb) To execute processes in an event-driven way rather than in a predetermined order\nc) To retain a function in memory for reuse after its execution\nd) To undo an execution of a process when it fails"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"To allow a function to use itself from within its body"},{"label":"b","text":"To execute processes in an event-driven way rather than in a predetermined order"},{"label":"c","text":"To retain a function in memory for reuse after its execution"},{"label":"d","text":"To undo an execution of a process when it fails"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q9)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q9. Which of the following explains the objective of a recursive call?

 a) To allow a function to use itself from within its body
 b) To execute processes in an event-driven way rather than in a predetermined order
 c) To retain a function in memory for reuse after its execution
 d) To undo an execution of a process when it fails',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  10,
  'Q10. Which of the following is a technology that provides a dynamic user interface without
 page transition using an asynchronous communication in JavaScript?',
  '[{"type":"text","page":6,"bbox":[65.22,193.74,533.19,225.19],"text":"Q10. Which of the following is a technology that provides a dynamic user interface without"},{"type":"text","page":6,"bbox":[85.2,229.68,420.64,261.13],"text":"page transition using an asynchronous communication in JavaScript?"},{"type":"text","page":6,"bbox":[93.6,265.85,460.36,279.13],"text":"a) Ajax\nb) CSS\nc) RSS\nd) SNS"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Ajax"},{"label":"b","text":"CSS"},{"label":"c","text":"RSS"},{"label":"d","text":"SNS"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q10)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q10. Which of the following is a technology that provides a dynamic user interface without
 page transition using an asynchronous communication in JavaScript?

 a) Ajax b) CSS c) RSS d) SNS',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  11,
  'Q11. Which of the following is a special register that contains the address of the next instruction
 to be fetched?',
  '[{"type":"text","page":6,"bbox":[65.22,319.74,533.13,333.19],"text":"Q11. Which of the following is a special register that contains the address of the next instruction"},{"type":"text","page":6,"bbox":[85.74,337.85,156.08,351.13],"text":"to be fetched?"},{"type":"text","page":6,"bbox":[65.22,374.93,439.15,424.15],"text":"a) Accumulator\nb) Program Counter (PC)\nc) Stack Pointer\nd) Timer"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Accumulator"},{"label":"b","text":"Program Counter (PC)"},{"label":"c","text":"Stack Pointer"},{"label":"d","text":"Timer"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q11)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q11. Which of the following is a special register that contains the address of the next instruction
 to be fetched?

 a) Accumulator b) Program Counter (PC)
 c) Stack Pointer d) Timer',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  12,
  'Q12. Which of the following is the performance of a CPU in MIPS when the instruction mix of
 the CPU is as listed in the table below? Here, the CPU does not use a pipeline architecture.

 Instruction type Instruction execution Appearance ratio
 time in μs
 Register to register
 0.1 40%
 operation
 Register from memory
 0.3 50%
 operation
 Unconditional branch
 0.6 10%
 operation',
  '[{"type":"text","page":6,"bbox":[65.22,428.76,533.08,459.19],"text":"Q12. Which of the following is the performance of a CPU in MIPS when the instruction mix of"},{"type":"text","page":6,"bbox":[85.74,463.85,525.0,477.13],"text":"the CPU is as listed in the table below? Here, the CPU does not use a pipeline architecture."},{"type":"table","page":6,"bbox":[92.22,497.46,492.72,609.84],"rows":[["Instruction type","Instruction execution\ntime in μs","Appearance ratio"],["Register to register\noperation","0.1","40%"],["Register from memory\noperation","0.3","50%"],["Unconditional branch\noperation","0.6","10%"]]},{"type":"text","page":6,"bbox":[123.0,498.23,365.71,511.51],"text":"Instruction type\nInstruction execution"},{"type":"text","page":6,"bbox":[391.62,498.23,484.28,511.51],"text":"Appearance ratio"},{"type":"text","page":6,"bbox":[283.14,512.03,336.3,525.31],"text":"time in μs"},{"type":"text","page":6,"bbox":[118.5,526.31,212.91,539.59],"text":"Register to register"},{"type":"text","page":6,"bbox":[141.54,533.21,450.48,553.39],"text":"operation\n0.1\n40%"},{"type":"text","page":6,"bbox":[109.5,554.45,221.91,567.73],"text":"Register from memory"},{"type":"text","page":6,"bbox":[141.54,561.35,450.49,581.53],"text":"operation\n0.3\n50%"},{"type":"text","page":6,"bbox":[112.02,582.53,219.4,595.81],"text":"Unconditional branch"},{"type":"text","page":6,"bbox":[141.54,589.43,450.48,609.61],"text":"operation\n0.6\n10%"},{"type":"text","page":6,"bbox":[84.12,631.79,470.1,645.07],"text":"a) 0.04\nb) 0.25\nc) 4\nd) 25"},{"type":"code","page":6,"bbox":[65.22,794.63,311.58,808.39],"text":"– 6 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0.04"},{"label":"b","text":"0.25"},{"label":"c","text":"4"},{"label":"d","text":"25\n\n – 6 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q12)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q12. Which of the following is the performance of a CPU in MIPS when the instruction mix of
 the CPU is as listed in the table below? Here, the CPU does not use a pipeline architecture.

 Instruction type Instruction execution Appearance ratio
 time in μs
 Register to register
 0.1 40%
 operation
 Register from memory
 0.3 50%
 operation
 Unconditional branch
 0.6 10%
 operation

 a) 0.04 b) 0.25 c) 4 d) 25

 – 6 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  13,
  'Q13. Which of the following is a computer system or architecture where the CPU sequentially
 reads and executes the programs that are stored in the main memory?',
  '[{"type":"text","page":7,"bbox":[65.22,67.74,533.12,81.19],"text":"Q13. Which of the following is a computer system or architecture where the CPU sequentially"},{"type":"text","page":7,"bbox":[85.74,85.85,421.0,99.13],"text":"reads and executes the programs that are stored in the main memory?"},{"type":"text","page":7,"bbox":[65.22,104.93,455.07,189.13],"text":"a) Addressing system\nb) DMA control architecture\nc) Stored program architecture\nd) Virtual memory system"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Addressing system"},{"label":"b","text":"DMA control architecture"},{"label":"c","text":"Stored program architecture"},{"label":"d","text":"Virtual memory system"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q13)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q13. Which of the following is a computer system or architecture where the CPU sequentially
 reads and executes the programs that are stored in the main memory?

 a) Addressing system b) DMA control architecture
 c) Stored program architecture d) Virtual memory system',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  14,
  'Q14. Which of the following is an appropriate description of USB 3.0?',
  '[{"type":"text","page":7,"bbox":[65.22,194.76,417.97,208.21],"text":"Q14. Which of the following is an appropriate description of USB 3.0?"},{"type":"text","page":7,"bbox":[84.12,232.91,517.67,246.19],"text":"a) It is a serial interface that adopts isochronous transmission that is suitable for audio or"},{"type":"text","page":7,"bbox":[84.12,250.91,517.41,282.19],"text":"video, and has a broadcast transmission mode.\nb) It is a serial interface that has a data transmission mode of 5 Gbit/s that is called super"},{"type":"text","page":7,"bbox":[84.12,286.91,496.4,336.19],"text":"speed.\nc) It is a serialized ATA specification that connects a PC to a peripheral device.\nd) It is an interface that uses four (4) pairs of signal lines transmitting two (2) bits of"},{"type":"text","page":7,"bbox":[102.12,340.91,452.77,354.19],"text":"information in one (1) clock and has a maximum throughput of 1 Gbit/s."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is a serial interface that adopts isochronous transmission that is suitable for audio or\n video, and has a broadcast transmission mode."},{"label":"b","text":"It is a serial interface that has a data transmission mode of 5 Gbit/s that is called super\n speed."},{"label":"c","text":"It is a serialized ATA specification that connects a PC to a peripheral device."},{"label":"d","text":"It is an interface that uses four (4) pairs of signal lines transmitting two (2) bits of\n information in one (1) clock and has a maximum throughput of 1 Gbit/s."}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q14)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q14. Which of the following is an appropriate description of USB 3.0?

 a) It is a serial interface that adopts isochronous transmission that is suitable for audio or
 video, and has a broadcast transmission mode.
 b) It is a serial interface that has a data transmission mode of 5 Gbit/s that is called super
 speed.
 c) It is a serialized ATA specification that connects a PC to a peripheral device.
 d) It is an interface that uses four (4) pairs of signal lines transmitting two (2) bits of
 information in one (1) clock and has a maximum throughput of 1 Gbit/s.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  15,
  'Q15. Which of the following is the RAID level where the entire stored data is lost when one of
 the multi-disks is damaged?',
  '[{"type":"text","page":7,"bbox":[65.22,376.91,533.17,407.17],"text":"Q15. Which of the following is the RAID level where the entire stored data is lost when one of"},{"type":"text","page":7,"bbox":[85.74,411.66,228.52,425.11],"text":"the multi-disks is damaged?"},{"type":"text","page":7,"bbox":[84.12,430.91,496.46,480.19],"text":"a) RAID 0\nb) RAID 1\nc) RAID 5\nd) RAID 6"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"RAID 0"},{"label":"b","text":"RAID 1"},{"label":"c","text":"RAID 5"},{"label":"d","text":"RAID 6"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q15)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q15. Which of the following is the RAID level where the entire stored data is lost when one of
 the multi-disks is damaged?

 a) RAID 0 b) RAID 1 c) RAID 5 d) RAID 6',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  16,
  'Q16. Which of the following is the approximate availability of a system in percentage when the
 MTBF is 30 days and the MTTR is 6 hours?',
  '[{"type":"text","page":7,"bbox":[65.22,502.74,533.1,516.19],"text":"Q16. Which of the following is the approximate availability of a system in percentage when the"},{"type":"text","page":7,"bbox":[85.74,519.78,309.24,534.19],"text":"MTBF is 30 days and the MTTR is 6 hours?"},{"type":"text","page":7,"bbox":[84.12,556.91,485.1,570.19],"text":"a) 0.83\nb) 83.33\nc) 98.36\nd) 99.17"},{"type":"code","page":7,"bbox":[65.22,794.63,311.58,808.39],"text":"– 7 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0.83"},{"label":"b","text":"83.33"},{"label":"c","text":"98.36"},{"label":"d","text":"99.17\n\n – 7 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q16)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q16. Which of the following is the approximate availability of a system in percentage when the
 MTBF is 30 days and the MTTR is 6 hours?

 a) 0.83 b) 83.33 c) 98.36 d) 99.17

 – 7 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  17,
  'Q17. In the switching procedure of processes in the multiprogramming shown in the figure
 below, which of the following is an appropriate combination of OS processing from A to C?

 State of process A OS processing State of process B

 Running
 Interrupt state

 A Ready
 state
 B
 Ready
 state C

 Running
 state

 A B C
 Restoration of the Saving of the running',
  '[{"type":"text","page":8,"bbox":[65.22,67.74,513.54,81.19],"text":"Q17. In the switching procedure of processes in the multiprogramming shown in the figure"},{"type":"text","page":8,"bbox":[85.74,85.85,529.92,99.13],"text":"below, which of the following is an appropriate combination of OS processing from A to C?"},{"type":"text","page":8,"bbox":[146.7,126.56,233.39,139.8],"text":"State of process A"},{"type":"text","page":8,"bbox":[262.5,126.56,333.04,139.8],"text":"OS processing"},{"type":"text","page":8,"bbox":[361.92,126.56,448.61,139.8],"text":"State of process B"},{"type":"text","page":8,"bbox":[196.98,147.92,242.22,161.16],"text":"Running"},{"type":"text","page":8,"bbox":[131.1,161.72,228.52,175.68],"text":"state\nInterrupt"},{"type":"text","page":8,"bbox":[293.82,191.51,301.08,203.66],"text":"A"},{"type":"text","page":8,"bbox":[417.3,196.88,451.62,210.12],"text":"Ready"},{"type":"text","page":8,"bbox":[421.62,211.04,443.74,224.28],"text":"state"},{"type":"text","page":8,"bbox":[293.82,219.83,301.08,231.98],"text":"B"},{"type":"text","page":8,"bbox":[202.08,227.72,236.41,240.96],"text":"Ready"},{"type":"text","page":8,"bbox":[206.46,242.24,228.52,255.48],"text":"state"},{"type":"text","page":8,"bbox":[293.82,248.45,301.68,260.6],"text":"C"},{"type":"text","page":8,"bbox":[411.84,276.32,457.09,289.57],"text":"Running"},{"type":"text","page":8,"bbox":[421.62,290.84,443.74,304.09],"text":"state"},{"type":"table","page":8,"bbox":[100.61,335.49,518.88,467.77],"rows":[["","A","B","C"],["a)","Restoration of the\nrunning state","Selection of the process","Saving of the running\nstate"],["b)","Saving of the running\nstate","Restoration of the\nrunning state","Selection of the process"],["c)","Saving of the running\nstate","Selection of the process","Restoration of the\nrunning state"],["d)","Selection of the\nprocess","Restoration of the\nrunning state","Saving of the running\nstate"]]},{"type":"text","page":8,"bbox":[106.32,339.65,459.66,352.93],"text":"A\nB\nC"},{"type":"text","page":8,"bbox":[106.32,355.25,503.11,382.33],"text":"a)\nRestoration of the\nrunning state\nSelection of the process\nSaving of the running\nstate"},{"type":"text","page":8,"bbox":[106.32,383.57,242.59,410.65],"text":"b)\nSaving of the running\nstate"},{"type":"text","page":8,"bbox":[264.18,383.57,512.93,410.65],"text":"Restoration of the\nrunning state\nSelection of the process"},{"type":"text","page":8,"bbox":[106.32,411.95,484.75,439.03],"text":"c)\nSaving of the running\nstate\nSelection of the process\nRestoration of the\nrunning state"},{"type":"text","page":8,"bbox":[106.32,440.27,213.49,467.35],"text":"d)\nSelection of the\nprocess"},{"type":"text","page":8,"bbox":[264.18,440.27,353.23,467.35],"text":"Restoration of the\nrunning state"},{"type":"text","page":8,"bbox":[395.7,440.27,503.11,467.35],"text":"Saving of the running\nstate"}]'::jsonb,
  '["2021-april-a-q17-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Selection of the process\n running state state\n Saving of the running Restoration of the"},{"label":"b","text":"Selection of the process\n state running state\n Saving of the running Restoration of the"},{"label":"c","text":"Selection of the process\n state running state\n Selection of the Restoration of the Saving of the running"},{"label":"d","text":"process running state state"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q17)',
  ARRAY[8]::int[],
  'native_text',
  '3.0',
  'Q17. In the switching procedure of processes in the multiprogramming shown in the figure
 below, which of the following is an appropriate combination of OS processing from A to C?

 State of process A OS processing State of process B

 Running
 Interrupt state

 A Ready
 state
 B
 Ready
 state C

 Running
 state

 A B C
 Restoration of the Saving of the running
 a) Selection of the process
 running state state
 Saving of the running Restoration of the
 b) Selection of the process
 state running state
 Saving of the running Restoration of the
 c) Selection of the process
 state running state
 Selection of the Restoration of the Saving of the running
 d)
 process running state state',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[8]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  18,
  'Q18. Among the page replacement methods in virtual memory management, which of the
 following is the LRU control method?',
  '[{"type":"text","page":8,"bbox":[65.22,489.66,533.07,520.09],"text":"Q18. Among the page replacement methods in virtual memory management, which of the"},{"type":"text","page":8,"bbox":[85.2,524.75,272.4,555.79],"text":"following is the LRU control method?"},{"type":"text","page":8,"bbox":[91.98,561.83,533.11,575.11],"text":"a) Each page is managed by appending a reference flag and a change flag, and pages"},{"type":"text","page":8,"bbox":[91.98,579.83,533.16,611.11],"text":"without reference or change are replaced with higher priority.\nb) One of the pages in main memory is randomly chosen with the same probability and"},{"type":"text","page":8,"bbox":[91.98,615.83,510.72,665.11],"text":"then replaced.\nc) The page that has been stored in the main memory for the longest time is replaced.\nd) The page that has not been referenced the longest time is replaced."},{"type":"code","page":8,"bbox":[65.22,794.63,311.58,808.39],"text":"– 8 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Each page is managed by appending a reference flag and a change flag, and pages\n without reference or change are replaced with higher priority."},{"label":"b","text":"One of the pages in main memory is randomly chosen with the same probability and\n then replaced."},{"label":"c","text":"The page that has been stored in the main memory for the longest time is replaced."},{"label":"d","text":"The page that has not been referenced the longest time is replaced.\n\n – 8 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q18)',
  ARRAY[8]::int[],
  'native_text',
  '3.0',
  'Q18. Among the page replacement methods in virtual memory management, which of the
 following is the LRU control method?

 a) Each page is managed by appending a reference flag and a change flag, and pages
 without reference or change are replaced with higher priority.
 b) One of the pages in main memory is randomly chosen with the same probability and
 then replaced.
 c) The page that has been stored in the main memory for the longest time is replaced.
 d) The page that has not been referenced the longest time is replaced.

 – 8 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[8]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  19,
  'Q19. Which of the following is an appropriate function of a linker?',
  '[{"type":"text","page":9,"bbox":[65.22,68.76,399.54,82.21],"text":"Q19. Which of the following is an appropriate function of a linker?"},{"type":"text","page":9,"bbox":[84.12,106.91,523.98,156.19],"text":"a) To load a load module to the main memory ahead of execution\nb) To monitor the execution of a program and to record the execution results for each step\nc) To perform a resolution of cross references and to create one (1) load module from"},{"type":"text","page":9,"bbox":[65.22,160.91,302.73,210.13],"text":"multiple object modules\nd) To register a created program in a library"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"To load a load module to the main memory ahead of execution"},{"label":"b","text":"To monitor the execution of a program and to record the execution results for each step"},{"label":"c","text":"To perform a resolution of cross references and to create one (1) load module from\n multiple object modules"},{"label":"d","text":"To register a created program in a library"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q19)',
  ARRAY[9]::int[],
  'native_text',
  '3.0',
  'Q19. Which of the following is an appropriate function of a linker?

 a) To load a load module to the main memory ahead of execution
 b) To monitor the execution of a program and to record the execution results for each step
 c) To perform a resolution of cross references and to create one (1) load module from
 multiple object modules
 d) To register a created program in a library',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[9]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  20,
  'Q20. Which of the following is the appropriate explanation of sequence control for controlling
 industrial devices?',
  '[{"type":"text","page":9,"bbox":[65.22,214.74,533.19,245.17],"text":"Q20. Which of the following is the appropriate explanation of sequence control for controlling"},{"type":"text","page":9,"bbox":[85.74,249.83,181.38,263.11],"text":"industrial devices?"},{"type":"text","page":9,"bbox":[84.12,268.91,521.04,318.19],"text":"a) It is based on fuzziness, such as “slightly more” or “slightly less.”\nb) It is resistant to unexpected disturbances because it continuously detects the amount of"},{"type":"text","page":9,"bbox":[84.12,322.91,522.96,354.19],"text":"control and reflects it on the control.\nc) It steps through each phase of control one after another according to a predefined order"},{"type":"text","page":9,"bbox":[84.12,358.91,519.64,390.19],"text":"or set of conditions.\nd) It takes corrective action in advance by assuming the occurrence of disturbances when"},{"type":"text","page":9,"bbox":[102.12,394.91,248.4,408.19],"text":"disturbances can be expected."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is based on fuzziness, such as “slightly more” or “slightly less.”"},{"label":"b","text":"It is resistant to unexpected disturbances because it continuously detects the amount of\n control and reflects it on the control."},{"label":"c","text":"It steps through each phase of control one after another according to a predefined order\n or set of conditions."},{"label":"d","text":"It takes corrective action in advance by assuming the occurrence of disturbances when\n disturbances can be expected."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q20)',
  ARRAY[9]::int[],
  'native_text',
  '3.0',
  'Q20. Which of the following is the appropriate explanation of sequence control for controlling
 industrial devices?

 a) It is based on fuzziness, such as “slightly more” or “slightly less.”
 b) It is resistant to unexpected disturbances because it continuously detects the amount of
 control and reflects it on the control.
 c) It steps through each phase of control one after another according to a predefined order
 or set of conditions.
 d) It takes corrective action in advance by assuming the occurrence of disturbances when
 disturbances can be expected.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[9]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  21,
  'Q21. The half adder in the diagram below adds two (2) single-digit binary numbers, x and y,
 and produces z (the first digit of the sum) and c (the carry bit) as outputs. Which of the
 following is the appropriate combination of gate devices A and B?

 A B',
  '[{"type":"text","page":9,"bbox":[65.22,447.72,533.1,461.17],"text":"Q21. The half adder in the diagram below adds two (2) single-digit binary numbers, x and y,"},{"type":"text","page":9,"bbox":[85.74,465.83,533.09,497.11],"text":"and produces z (the first digit of the sum) and c (the carry bit) as outputs. Which of the\nfollowing is the appropriate combination of gate devices A and B?"},{"type":"table","page":9,"bbox":[87.9,607.56,475.2,710.52],"rows":[[null,"A","B"],["a)","Exclusive logical sum (XOR)","Logical product (AND)"],["b)","Logical product (AND)","Logical sum (OR)"],["c)","Negative logical product (NAND)","Negative logical sum (NOR)"],["d)","Negative logical sum (NOR)","Exclusive logical sum (XOR)"]]},{"type":"text","page":9,"bbox":[100.8,611.51,391.5,624.79],"text":"A\nB"},{"type":"text","page":9,"bbox":[96.18,632.09,416.2,645.37],"text":"a)\nExclusive logical sum (XOR)\nLogical product (AND)"},{"type":"text","page":9,"bbox":[95.82,652.73,390.2,666.01],"text":"b)\nLogical product (AND)\nLogical sum (OR)"},{"type":"text","page":9,"bbox":[96.18,673.31,441.18,686.59],"text":"c)\nNegative logical product (NAND)\nNegative logical sum (NOR)"},{"type":"text","page":9,"bbox":[95.82,693.89,445.41,707.17],"text":"d)\nNegative logical sum (NOR)\nExclusive logical sum (XOR)"},{"type":"code","page":9,"bbox":[65.22,794.63,311.58,808.39],"text":"– 9 –"}]'::jsonb,
  '["2021-april-a-q21-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Exclusive logical sum (XOR) Logical product (AND)"},{"label":"b","text":"Logical product (AND) Logical sum (OR)"},{"label":"c","text":"Negative logical product (NAND) Negative logical sum (NOR)"},{"label":"d","text":"Negative logical sum (NOR) Exclusive logical sum (XOR)\n\n – 9 –"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q21)',
  ARRAY[9]::int[],
  'native_text',
  '3.0',
  'Q21. The half adder in the diagram below adds two (2) single-digit binary numbers, x and y,
 and produces z (the first digit of the sum) and c (the carry bit) as outputs. Which of the
 following is the appropriate combination of gate devices A and B?

 A B

 a) Exclusive logical sum (XOR) Logical product (AND)

 b) Logical product (AND) Logical sum (OR)

 c) Negative logical product (NAND) Negative logical sum (NOR)

 d) Negative logical sum (NOR) Exclusive logical sum (XOR)

 – 9 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[9]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  22,
  'Q22. Which of the following is not an implementation of the function F = A•B + C•D? Here,
 “•” represents the logic AND operation, and “+” represents the logic OR operation in the
 expression.',
  '[{"type":"text","page":10,"bbox":[65.22,67.74,533.1,81.19],"text":"Q22. Which of the following is not an implementation of the function F = A•B + C•D? Here,"},{"type":"text","page":10,"bbox":[85.74,85.85,533.11,99.13],"text":"“•” represents the logic AND operation, and “+” represents the logic OR operation in the"},{"type":"text","page":10,"bbox":[85.74,103.85,148.78,117.13],"text":"expression."},{"type":"text","page":10,"bbox":[84.54,139.37,444.72,152.65],"text":"a)\n\nb)"},{"type":"text","page":10,"bbox":[84.54,230.93,433.26,244.21],"text":"c)\n\nd)"}]'::jsonb,
  '["2021-april-a-q22-figure1.webp","2021-april-a-q22-figure2.webp","2021-april-a-q22-figure3.webp","2021-april-a-q22-figure4.webp"]'::jsonb,
  '[{"label":"a","text":"","image":"2021-april-a-q22-figure1.webp"},{"label":"b","text":"","image":"2021-april-a-q22-figure2.webp"},{"label":"c","text":"","image":"2021-april-a-q22-figure3.webp"},{"label":"d","text":"","image":"2021-april-a-q22-figure4.webp"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q22)',
  ARRAY[10]::int[],
  'native_text',
  '3.0',
  'Q22. Which of the following is not an implementation of the function F = A•B + C•D? Here,
 “•” represents the logic AND operation, and “+” represents the logic OR operation in the
 expression.

 a) b)

 c) d)',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  23,
  'Q23. Which of the following is an appropriate purpose of check digit?',
  '[{"type":"text","page":10,"bbox":[65.22,334.44,414.24,364.87],"text":"Q23. Which of the following is an appropriate purpose of check digit?"},{"type":"text","page":10,"bbox":[84.12,388.61,502.3,401.89],"text":"a) To detect an error that an alphabet or a symbol is contained in a numeric item field"},{"type":"text","page":10,"bbox":[84.12,406.61,459.57,419.89],"text":"b) To detect an error that the number of digits of an entered code is incorrect"},{"type":"text","page":10,"bbox":[84.12,424.61,406.24,437.89],"text":"c) To detect an error that the value of an entered code is incorrect"},{"type":"text","page":10,"bbox":[65.22,442.61,494.23,471.3],"text":"d) To detect an error that the value of an entered data is not within a specified range"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"To detect an error that an alphabet or a symbol is contained in a numeric item field"},{"label":"b","text":"To detect an error that the number of digits of an entered code is incorrect"},{"label":"c","text":"To detect an error that the value of an entered code is incorrect"},{"label":"d","text":"To detect an error that the value of an entered data is not within a specified range"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q23)',
  ARRAY[10]::int[],
  'native_text',
  '3.0',
  'Q23. Which of the following is an appropriate purpose of check digit?

 a) To detect an error that an alphabet or a symbol is contained in a numeric item field
 b) To detect an error that the number of digits of an entered code is incorrect
 c) To detect an error that the value of an entered code is incorrect
 d) To detect an error that the value of an entered data is not within a specified range',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  24,
  'Q24. Which of the following explains a drawing software?',
  '[{"type":"text","page":10,"bbox":[65.22,495.42,359.19,508.87],"text":"Q24. Which of the following explains a drawing software?"},{"type":"text","page":10,"bbox":[84.12,532.61,503.44,545.89],"text":"a) It can create a picture on a screen using the mouse as a brush that can be saved to a"},{"type":"text","page":10,"bbox":[102.12,550.61,192.74,563.89],"text":"bitmap image file."},{"type":"text","page":10,"bbox":[84.12,568.61,530.31,581.89],"text":"b) It can create a scenario-based content by editing and arranging several materials, such as"},{"type":"text","page":10,"bbox":[102.12,586.61,253.76,599.89],"text":"text, images, video, and sound."},{"type":"text","page":10,"bbox":[84.12,604.61,504.09,617.89],"text":"c) It can create a simple movie from a series of still images by gradually changing the"},{"type":"text","page":10,"bbox":[102.12,622.61,234.06,635.89],"text":"differences among images."},{"type":"text","page":10,"bbox":[84.12,640.61,525.65,653.89],"text":"d) It can create vector graphics composed of lines and curves defined mathematically with"},{"type":"text","page":10,"bbox":[65.22,658.61,430.63,688.81],"text":"geometric characteristics that can then be transformed or combined."},{"type":"code","page":10,"bbox":[65.22,794.63,314.58,808.39],"text":"– 10 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It can create a picture on a screen using the mouse as a brush that can be saved to a\n bitmap image file."},{"label":"b","text":"It can create a scenario-based content by editing and arranging several materials, such as\n text, images, video, and sound."},{"label":"c","text":"It can create a simple movie from a series of still images by gradually changing the\n differences among images."},{"label":"d","text":"It can create vector graphics composed of lines and curves defined mathematically with\n geometric characteristics that can then be transformed or combined.\n\n – 10 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q24)',
  ARRAY[10]::int[],
  'native_text',
  '3.0',
  'Q24. Which of the following explains a drawing software?

 a) It can create a picture on a screen using the mouse as a brush that can be saved to a
 bitmap image file.
 b) It can create a scenario-based content by editing and arranging several materials, such as
 text, images, video, and sound.
 c) It can create a simple movie from a series of still images by gradually changing the
 differences among images.
 d) It can create vector graphics composed of lines and curves defined mathematically with
 geometric characteristics that can then be transformed or combined.

 – 10 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  25,
  'Q25. Which of the following is an appropriate explanation of a relational database?',
  '[{"type":"text","page":11,"bbox":[65.22,67.74,480.18,81.19],"text":"Q25. Which of the following is an appropriate explanation of a relational database?"},{"type":"text","page":11,"bbox":[84.12,104.93,524.69,118.21],"text":"a) Data is represented as a table, and the tables are linked to one another using the column"},{"type":"text","page":11,"bbox":[84.12,122.93,517.36,154.21],"text":"values of these tables.\nb) Each attribute is represented as a pair of the attribute value and the storage location of"},{"type":"text","page":11,"bbox":[84.12,158.93,513.96,190.21],"text":"the record having that value and used as an index.\nc) The relationship among records is represented by a data structure using links that can"},{"type":"text","page":11,"bbox":[84.12,194.93,527.37,226.21],"text":"represent both tree and network structures.\nd) The relationship among records is represented by a data structure using pointers that are"},{"type":"text","page":11,"bbox":[65.22,230.93,294.12,262.21],"text":"limited to representing a tree structure."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Data is represented as a table, and the tables are linked to one another using the column\n values of these tables."},{"label":"b","text":"Each attribute is represented as a pair of the attribute value and the storage location of\n the record having that value and used as an index."},{"label":"c","text":"The relationship among records is represented by a data structure using links that can\n represent both tree and network structures."},{"label":"d","text":"The relationship among records is represented by a data structure using pointers that are\n limited to representing a tree structure."}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q25)',
  ARRAY[11]::int[],
  'native_text',
  '3.0',
  'Q25. Which of the following is an appropriate explanation of a relational database?

 a) Data is represented as a table, and the tables are linked to one another using the column
 values of these tables.
 b) Each attribute is represented as a pair of the attribute value and the storage location of
 the record having that value and used as an index.
 c) The relationship among records is represented by a data structure using links that can
 represent both tree and network structures.
 d) The relationship among records is represented by a data structure using pointers that are
 limited to representing a tree structure.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[11]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  26,
  'Q26. Which of the following is performed periodically to prevent a decline in the access
 efficiency of a database?',
  '[{"type":"text","page":11,"bbox":[65.22,266.93,533.14,297.19],"text":"Q26. Which of the following is performed periodically to prevent a decline in the access"},{"type":"text","page":11,"bbox":[85.74,301.85,209.67,315.13],"text":"efficiency of a database?"},{"type":"text","page":11,"bbox":[65.22,338.93,404.82,388.21],"text":"a) Backup\nb) Database dump\nc) Reorganization\nd) Rollback"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Backup"},{"label":"b","text":"Database dump"},{"label":"c","text":"Reorganization"},{"label":"d","text":"Rollback"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q26)',
  ARRAY[11]::int[],
  'native_text',
  '3.0',
  'Q26. Which of the following is performed periodically to prevent a decline in the access
 efficiency of a database?

 a) Backup b) Database dump
 c) Reorganization d) Rollback',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[11]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  27,
  'Q27. A student’s ID, name, and class ID are recorded in the Student table. Which of the
 following SQL returns records of all students whose names start with A?',
  '[{"type":"text","page":11,"bbox":[65.22,391.74,533.09,423.19],"text":"Q27. A student’s ID, name, and class ID are recorded in the Student table. Which of the"},{"type":"text","page":11,"bbox":[85.74,427.85,436.24,441.13],"text":"following SQL returns records of all students whose names start with A?"},{"type":"text","page":11,"bbox":[86.46,464.22,378.56,524.37],"text":"a)\nSELECT * FROM Student WHERE name LIKE ’%A’;\nb)\nSELECT * FROM Student WHERE name LIKE ‘%A_’;\nc)\nSELECT * FROM Student WHERE name LIKE ‘A_’;\nd)\nSELECT * FROM Student WHERE name LIKE ‘A%’;"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"SELECT * FROM Student WHERE name LIKE ’%A’;"},{"label":"b","text":"SELECT * FROM Student WHERE name LIKE ‘%A_’;"},{"label":"c","text":"SELECT * FROM Student WHERE name LIKE ‘A_’;"},{"label":"d","text":"SELECT * FROM Student WHERE name LIKE ‘A%’;"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q27)',
  ARRAY[11]::int[],
  'native_text',
  '3.0',
  'Q27. A student’s ID, name, and class ID are recorded in the Student table. Which of the
 following SQL returns records of all students whose names start with A?

 a) SELECT * FROM Student WHERE name LIKE ’%A’;
 b) SELECT * FROM Student WHERE name LIKE ‘%A_’;
 c) SELECT * FROM Student WHERE name LIKE ‘A_’;
 d) SELECT * FROM Student WHERE name LIKE ‘A%’;',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[11]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  28,
  'Q28. Among the search processes for the “Sales” table, which of the following is appropriate to
 set a hash index rather than a B+ tree index? Here, the column in which the index is set is
 shown inside <>.

 Sales (form number, sales date, product name, user ID, store number, sales amount)',
  '[{"type":"text","page":11,"bbox":[65.22,563.7,533.14,577.15],"text":"Q28. Among the search processes for the “Sales” table, which of the following is appropriate to"},{"type":"text","page":11,"bbox":[85.74,581.81,533.18,613.09],"text":"set a hash index rather than a B+ tree index? Here, the column in which the index is set is\nshown inside <>."},{"type":"text","page":11,"bbox":[85.2,636.89,511.3,668.17],"text":"Sales (form number, sales date, product name, user ID, store number, sales amount)"},{"type":"text","page":11,"bbox":[91.98,672.89,504.23,740.17],"text":"a) Searching for sales with a sales amount of 100 dollars or more. <sales amount>\nb) Searching for sales with the product name beginning with ‘DB’. <product name>\nc) Searching for sales with the sales date as the current month. <sales date>\nd) Searching for sales with the user ID as ‘1001’. <user ID>"},{"type":"code","page":11,"bbox":[65.22,794.63,317.4,808.39],"text":"– 11 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Searching for sales with a sales amount of 100 dollars or more. <sales amount>"},{"label":"b","text":"Searching for sales with the product name beginning with ‘DB’. <product name>"},{"label":"c","text":"Searching for sales with the sales date as the current month. <sales date>"},{"label":"d","text":"Searching for sales with the user ID as ‘1001’. <user ID>\n\n – 11 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q28)',
  ARRAY[11]::int[],
  'native_text',
  '3.0',
  'Q28. Among the search processes for the “Sales” table, which of the following is appropriate to
 set a hash index rather than a B+ tree index? Here, the column in which the index is set is
 shown inside <>.

 Sales (form number, sales date, product name, user ID, store number, sales amount)

 a) Searching for sales with a sales amount of 100 dollars or more. <sales amount>
 b) Searching for sales with the product name beginning with ‘DB’. <product name>
 c) Searching for sales with the sales date as the current month. <sales date>
 d) Searching for sales with the user ID as ‘1001’. <user ID>

 – 11 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[11]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  29,
  'Q29. Which of the following is the appropriate explanation of the key value store that is used in
 the processing of big data?',
  '[{"type":"text","page":12,"bbox":[65.22,67.74,533.11,81.19],"text":"Q29. Which of the following is the appropriate explanation of the key value store that is used in"},{"type":"text","page":12,"bbox":[85.74,85.85,217.41,99.13],"text":"the processing of big data?"},{"type":"text","page":12,"bbox":[84.12,104.93,509.08,136.21],"text":"a) It is represented by a two-dimensional table with rows and columns based on the set"},{"type":"text","page":12,"bbox":[84.12,140.93,503.45,172.21],"text":"theory.\nb) It represents the relationship among nodes with the three (3) elements, i.e., “node,”"},{"type":"text","page":12,"bbox":[84.12,176.93,498.65,208.21],"text":"“relationship,” and “property.”\nc) It saves the desired data together with a value that enables this data to be uniquely"},{"type":"text","page":12,"bbox":[84.12,212.93,483.6,244.21],"text":"identified as a pair.\nd) The data for one (1) case is called a “document,” and the data structure of each"},{"type":"text","page":12,"bbox":[65.22,248.93,438.75,279.13],"text":"document is unrestricted and can be changed whenever data is added."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is represented by a two-dimensional table with rows and columns based on the set\n theory."},{"label":"b","text":"It represents the relationship among nodes with the three (3) elements, i.e., “node,”\n “relationship,” and “property.”"},{"label":"c","text":"It saves the desired data together with a value that enables this data to be uniquely\n identified as a pair."},{"label":"d","text":"The data for one (1) case is called a “document,” and the data structure of each\n document is unrestricted and can be changed whenever data is added."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q29)',
  ARRAY[12]::int[],
  'native_text',
  '3.0',
  'Q29. Which of the following is the appropriate explanation of the key value store that is used in
 the processing of big data?

 a) It is represented by a two-dimensional table with rows and columns based on the set
 theory.
 b) It represents the relationship among nodes with the three (3) elements, i.e., “node,”
 “relationship,” and “property.”
 c) It saves the desired data together with a value that enables this data to be uniquely
 identified as a pair.
 d) The data for one (1) case is called a “document,” and the data structure of each
 document is unrestricted and can be changed whenever data is added.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[12]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  30,
  'Q30. Which of the following is the response time when a client and server at different locations
 communicate under the conditions below? Here, the response time is in seconds and starts
 from the moment the client sends a message until a response is received from the server. 1
 MB is 106 bytes. The propagation delay between the client and server can be ignored.

 [Conditions]

 Line speed between client and server 8 Mbit/s

 Transmission efficiency 60%

 1 MB for upstreaming and 2 MB for
 Message size
 downstreaming
 Processing time at client side Total of 0.4 s for sending and receiving
 Processing time at server side Total of 0.4 s for sending and receiving',
  '[{"type":"text","page":12,"bbox":[65.22,283.74,533.17,315.19],"text":"Q30. Which of the following is the response time when a client and server at different locations"},{"type":"text","page":12,"bbox":[85.74,319.85,533.08,369.13],"text":"communicate under the conditions below? Here, the response time is in seconds and starts\nfrom the moment the client sends a message until a response is received from the server. 1\nMB is 106 bytes. The propagation delay between the client and server can be ignored."},{"type":"text","page":12,"bbox":[100.62,391.85,374.7,405.13],"text":"[Conditions]"},{"type":"table","page":12,"bbox":[100.62,407.46,525.24,522.6],"rows":[["Line speed between client and server","8 Mbit/s"],["Transmission efficiency","60%"],["Message size","1 MB for upstreaming and 2 MB for\ndownstreaming"],["Processing time at client side","Total of 0.4 s for sending and receiving"],["Processing time at server side","Total of 0.4 s for sending and receiving"]]},{"type":"text","page":12,"bbox":[102.96,412.61,371.92,425.89],"text":"Line speed between client and server\n8 Mbit/s"},{"type":"text","page":12,"bbox":[102.96,435.35,353.6,448.63],"text":"Transmission efficiency\n60%"},{"type":"text","page":12,"bbox":[102.96,455.93,506.44,483.07],"text":"Message size\n1 MB for upstreaming and 2 MB for\ndownstreaming"},{"type":"text","page":12,"bbox":[102.96,488.39,520.04,501.67],"text":"Processing time at client side\nTotal of 0.4 s for sending and receiving"},{"type":"text","page":12,"bbox":[102.96,506.93,520.04,520.21],"text":"Processing time at server side\nTotal of 0.4 s for sending and receiving"},{"type":"text","page":12,"bbox":[84.12,544.61,473.1,557.89],"text":"a) 1.4\nb) 3.8\nc) 5.0\nd) 5.8"},{"type":"code","page":12,"bbox":[65.22,794.63,314.58,808.39],"text":"– 12 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"1.4"},{"label":"b","text":"3.8"},{"label":"c","text":"5.0"},{"label":"d","text":"5.8\n\n – 12 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q30)',
  ARRAY[12]::int[],
  'native_text',
  '3.0',
  'Q30. Which of the following is the response time when a client and server at different locations
 communicate under the conditions below? Here, the response time is in seconds and starts
 from the moment the client sends a message until a response is received from the server. 1
 MB is 106 bytes. The propagation delay between the client and server can be ignored.

 [Conditions]

 Line speed between client and server 8 Mbit/s

 Transmission efficiency 60%

 1 MB for upstreaming and 2 MB for
 Message size
 downstreaming
 Processing time at client side Total of 0.4 s for sending and receiving
 Processing time at server side Total of 0.4 s for sending and receiving

 a) 1.4 b) 3.8 c) 5.0 d) 5.8

 – 12 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[12]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  31,
  'Q31. Which of the following is an appropriate transmission operation of a node connected to a
 CSMA/CD LAN?',
  '[{"type":"text","page":13,"bbox":[65.22,67.74,533.06,81.19],"text":"Q31. Which of the following is an appropriate transmission operation of a node connected to a"},{"type":"text","page":13,"bbox":[65.22,85.85,175.71,117.13],"text":"CSMA/CD LAN?"},{"type":"text","page":13,"bbox":[84.12,122.93,530.3,136.21],"text":"a) All nodes are connected in a ring topology, where a special frame is circulated around to"},{"type":"text","page":13,"bbox":[84.12,140.93,519.86,172.21],"text":"control transmission rights. Only the node that has the special frame can transmit data.\nb) Each node is logically ordered, a transmission right is passed along in order, and only"},{"type":"text","page":13,"bbox":[84.12,176.93,505.1,208.21],"text":"the node that has received the right can transmit data.\nc) Each node waits for the medium to be idle before transmitting data. When collision"},{"type":"text","page":13,"bbox":[84.12,212.93,421.98,244.21],"text":"occurs, it waits for a random backoff time before retransmission.\nd) Only the node that has a time slot assigned can transmit data."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"All nodes are connected in a ring topology, where a special frame is circulated around to\n control transmission rights. Only the node that has the special frame can transmit data."},{"label":"b","text":"Each node is logically ordered, a transmission right is passed along in order, and only\n the node that has received the right can transmit data."},{"label":"c","text":"Each node waits for the medium to be idle before transmitting data. When collision\n occurs, it waits for a random backoff time before retransmission."},{"label":"d","text":"Only the node that has a time slot assigned can transmit data."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q31)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q31. Which of the following is an appropriate transmission operation of a node connected to a
 CSMA/CD LAN?

 a) All nodes are connected in a ring topology, where a special frame is circulated around to
 control transmission rights. Only the node that has the special frame can transmit data.
 b) Each node is logically ordered, a transmission right is passed along in order, and only
 the node that has received the right can transmit data.
 c) Each node waits for the medium to be idle before transmitting data. When collision
 occurs, it waits for a random backoff time before retransmission.
 d) Only the node that has a time slot assigned can transmit data.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  32,
  'Q32. In a TCP/IP environment, which of the following is a protocol for synchronizing the clocks
 of multiple computers with that of a time server?',
  '[{"type":"text","page":13,"bbox":[65.22,265.74,533.14,297.19],"text":"Q32. In a TCP/IP environment, which of the following is a protocol for synchronizing the clocks"},{"type":"text","page":13,"bbox":[85.2,301.85,323.37,333.13],"text":"of multiple computers with that of a time server?"},{"type":"text","page":13,"bbox":[84.12,338.93,480.18,352.21],"text":"a) FTP\nb) NNTP\nc) NTP\nd) RTP"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"FTP"},{"label":"b","text":"NNTP"},{"label":"c","text":"NTP"},{"label":"d","text":"RTP"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q32)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q32. In a TCP/IP environment, which of the following is a protocol for synchronizing the clocks
 of multiple computers with that of a time server?

 a) FTP b) NNTP c) NTP d) RTP',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  33,
  'Q33. Which of the following is an appropriate explanation of DHCP?',
  '[{"type":"text","page":13,"bbox":[65.22,375.06,411.21,423.13],"text":"Q33. Which of the following is an appropriate explanation of DHCP?"},{"type":"text","page":13,"bbox":[65.22,428.93,452.64,513.13],"text":"a) It is a protocol for accessing a directory service.\nb) It is a protocol for automatically assigning an IP address.\nc) It is a protocol for converting a private IP address to a global IP address.\nd) It is a protocol for forwarding an e-mail."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is a protocol for accessing a directory service."},{"label":"b","text":"It is a protocol for automatically assigning an IP address."},{"label":"c","text":"It is a protocol for converting a private IP address to a global IP address."},{"label":"d","text":"It is a protocol for forwarding an e-mail."}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q33)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q33. Which of the following is an appropriate explanation of DHCP?

 a) It is a protocol for accessing a directory service.
 b) It is a protocol for automatically assigning an IP address.
 c) It is a protocol for converting a private IP address to a global IP address.
 d) It is a protocol for forwarding an e-mail.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  34,
  'Q34. Which of the following is classified as a web beacon?',
  '[{"type":"text","page":13,"bbox":[65.22,517.74,368.5,567.13],"text":"Q34.\nWhich of the following is classified as a web beacon?"},{"type":"text","page":13,"bbox":[84.12,572.93,512.15,604.21],"text":"a) A potential error of an application program used for a website\nb) A technique to collect user information, such as access trends, by embedding a small"},{"type":"text","page":13,"bbox":[84.12,608.93,528.36,658.21],"text":"image in a web page\nc) A virus that is downloaded from a website that deletes image files on a PC\nd)  An abusive method of using a malicious script that is harmful to both client PC and web"},{"type":"text","page":13,"bbox":[65.22,662.93,134.46,712.15],"text":"server"},{"type":"code","page":13,"bbox":[65.22,794.63,314.58,808.39],"text":"– 13 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A potential error of an application program used for a website"},{"label":"b","text":"A technique to collect user information, such as access trends, by embedding a small\n image in a web page"},{"label":"c","text":"A virus that is downloaded from a website that deletes image files on a PC"},{"label":"d","text":"An abusive method of using a malicious script that is harmful to both client PC and web\n server\n\n – 13 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q34)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q34. Which of the following is classified as a web beacon?

 a) A potential error of an application program used for a website
 b) A technique to collect user information, such as access trends, by embedding a small
 image in a web page
 c) A virus that is downloaded from a website that deletes image files on a PC
 d) An abusive method of using a malicious script that is harmful to both client PC and web
 server

 – 13 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  35,
  'Q35. When risk treatment is classified as risk avoidance, risk reduction, risk acceptance, and
 risk sharing, which of the following risk treatments is risk avoidance?',
  '[{"type":"text","page":14,"bbox":[65.22,67.74,533.15,81.19],"text":"Q35. When risk treatment is classified as risk avoidance, risk reduction, risk acceptance, and"},{"type":"text","page":14,"bbox":[85.74,85.85,423.73,99.13],"text":"risk sharing, which of the following risk treatments is risk avoidance?"},{"type":"text","page":14,"bbox":[65.22,122.93,384.01,208.15],"text":"a) Applying appropriate controls to lower a risk\nb) Discontinuing some operations that have a risk\nc) Knowingly and objectively not taking any action on a risk\nd) Transferring a risk to other parties"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Applying appropriate controls to lower a risk"},{"label":"b","text":"Discontinuing some operations that have a risk"},{"label":"c","text":"Knowingly and objectively not taking any action on a risk"},{"label":"d","text":"Transferring a risk to other parties"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q35)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q35. When risk treatment is classified as risk avoidance, risk reduction, risk acceptance, and
 risk sharing, which of the following risk treatments is risk avoidance?

 a) Applying appropriate controls to lower a risk
 b) Discontinuing some operations that have a risk
 c) Knowingly and objectively not taking any action on a risk
 d) Transferring a risk to other parties',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  36,
  'Q36. Which of the following is installed into an in-house network or server by an intruder to
 enter through an access path other than the normal path?',
  '[{"type":"text","page":14,"bbox":[65.22,212.76,533.08,243.19],"text":"Q36. Which of the following is installed into an in-house network or server by an intruder to"},{"type":"text","page":14,"bbox":[85.2,247.85,362.58,279.13],"text":"enter through an access path other than the normal path?"},{"type":"text","page":14,"bbox":[65.22,284.93,411.78,334.21],"text":"a) Backdoor\nb) Forensic\nc) Strict routing\nd) Thin client agent"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Backdoor"},{"label":"b","text":"Forensic"},{"label":"c","text":"Strict routing"},{"label":"d","text":"Thin client agent"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q36)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q36. Which of the following is installed into an in-house network or server by an intruder to
 enter through an access path other than the normal path?

 a) Backdoor b) Forensic
 c) Strict routing d) Thin client agent',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  37,
  'Q37. Biometric authentication includes a verification method that extracts physical
 characteristics and another verification method that extracts behavioral characteristics. Which
 of the following is the method that uses behavioral characteristics?',
  '[{"type":"text","page":14,"bbox":[65.22,339.28,533.13,369.19],"text":"Q37. Biometric authentication includes a verification method that extracts physical"},{"type":"text","page":14,"bbox":[85.74,373.85,533.11,405.13],"text":"characteristics and another verification method that extracts behavioral characteristics. Which\nof the following is the method that uses behavioral characteristics?"},{"type":"text","page":14,"bbox":[84.12,410.93,508.6,442.21],"text":"a) Performing authentication by extracting characteristics from pen speed and pressure"},{"type":"text","page":14,"bbox":[84.12,446.93,527.59,478.21],"text":"when a signature is provided\nb) Performing authentication by extracting characteristics from the bifurcation angle of the"},{"type":"text","page":14,"bbox":[84.12,482.93,524.4,532.21],"text":"bifurcation point of a blood vessel or from the distance between adjacent bifurcation\npoints\nc) Performing authentication by extracting the characteristic point called minutia from the"},{"type":"text","page":14,"bbox":[84.12,536.93,530.69,568.21],"text":"pattern formed by ridges\nd) Performing authentication by extracting the characteristics of chaotic wrinkles in the eye"},{"type":"text","page":14,"bbox":[102.12,572.93,241.49,586.21],"text":"from the pupil to the outside"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Performing authentication by extracting characteristics from pen speed and pressure\n when a signature is provided"},{"label":"b","text":"Performing authentication by extracting characteristics from the bifurcation angle of the\n bifurcation point of a blood vessel or from the distance between adjacent bifurcation\n points"},{"label":"c","text":"Performing authentication by extracting the characteristic point called minutia from the\n pattern formed by ridges"},{"label":"d","text":"Performing authentication by extracting the characteristics of chaotic wrinkles in the eye\n from the pupil to the outside"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q37)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q37. Biometric authentication includes a verification method that extracts physical
 characteristics and another verification method that extracts behavioral characteristics. Which
 of the following is the method that uses behavioral characteristics?

 a) Performing authentication by extracting characteristics from pen speed and pressure
 when a signature is provided
 b) Performing authentication by extracting characteristics from the bifurcation angle of the
 bifurcation point of a blood vessel or from the distance between adjacent bifurcation
 points
 c) Performing authentication by extracting the characteristic point called minutia from the
 pattern formed by ridges
 d) Performing authentication by extracting the characteristics of chaotic wrinkles in the eye
 from the pupil to the outside',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  38,
  'Q38. Which of the following is an encryption method that can be used for encrypting data
 managed in a database using the same key for encryption and decryption?',
  '[{"type":"text","page":14,"bbox":[65.22,609.28,533.14,639.19],"text":"Q38. Which of the following is an encryption method that can be used for encrypting data"},{"type":"text","page":14,"bbox":[85.74,643.85,442.85,657.13],"text":"managed in a database using the same key for encryption and decryption?"},{"type":"text","page":14,"bbox":[84.12,662.93,504.18,694.21],"text":"a) AES\nb) PKI\nc) RSA\nd) SHA-256"},{"type":"code","page":14,"bbox":[65.22,794.63,314.58,808.39],"text":"– 14 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"AES"},{"label":"b","text":"PKI"},{"label":"c","text":"RSA"},{"label":"d","text":"SHA-256\n\n – 14 –"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q38)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q38. Which of the following is an encryption method that can be used for encrypting data
 managed in a database using the same key for encryption and decryption?

 a) AES b) PKI c) RSA d) SHA-256

 – 14 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  39,
  'Q39. A given application only has the functions of retrieving and displaying user information
 from a database that stores such information. Considering information security management,
 which of the following is the appropriate database access right assigned to an account that
 the application uses when it accesses the database? The names and scopes of rights are listed
 below.

 [The names and scopes of rights]
 Reference right: Permits a record to be selected
 Update right: Permits a record to be inserted, updated, and dropped
 Administrator right: Permits a table to be displayed, created, altered, and dropped',
  '[{"type":"text","page":15,"bbox":[65.22,67.74,533.18,189.13],"text":"Q39.\nA given application only has the functions of retrieving and displaying user information\nfrom a database that stores such information. Considering information security management,\nwhich of the following is the appropriate database access right assigned to an account that\nthe application uses when it accesses the database? The names and scopes of rights are listed\nbelow.\n\n[The names and scopes of rights]"},{"type":"text","page":15,"bbox":[85.2,193.85,523.19,261.13],"text":"Reference right:\nPermits a record to be selected\nUpdate right:\nPermits a record to be inserted, updated, and dropped\nAdministrator right:\nPermits a table to be displayed, created, altered, and dropped"},{"type":"text","page":15,"bbox":[84.12,266.93,484.34,315.13],"text":"a) Administrator right\nb) Reference right\nc) Update right\nd) Update right and reference right"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Administrator right"},{"label":"b","text":"Reference right"},{"label":"c","text":"Update right"},{"label":"d","text":"Update right and reference right"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q39)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q39. A given application only has the functions of retrieving and displaying user information
 from a database that stores such information. Considering information security management,
 which of the following is the appropriate database access right assigned to an account that
 the application uses when it accesses the database? The names and scopes of rights are listed
 below.

 [The names and scopes of rights]
 Reference right: Permits a record to be selected
 Update right: Permits a record to be inserted, updated, and dropped
 Administrator right: Permits a table to be displayed, created, altered, and dropped

 a) Administrator right b) Reference right
 c) Update right d) Update right and reference right',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  40,
  'Q40. A cybersecurity incident response plan is defined as a set of instructions to aid the
 cybersecurity team to detect, respond to, and recover from cybersecurity incidents. The
 cybersecurity incident response plan resolves issues, such as cybercrime, data loss, and
 service outages that threaten daily work. Which of the following is part of the cybersecurity
 incident response plan?',
  '[{"type":"text","page":15,"bbox":[65.22,320.93,533.11,352.21],"text":"Q40. A cybersecurity incident response plan is defined as a set of instructions to aid the"},{"type":"text","page":15,"bbox":[65.22,356.93,533.17,440.59],"text":"cybersecurity team to detect, respond to, and recover from cybersecurity incidents. The\ncybersecurity incident response plan resolves issues, such as cybercrime, data loss, and\nservice outages that threaten daily work. Which of the following is part of the cybersecurity\nincident response plan?"},{"type":"text","page":15,"bbox":[65.22,444.89,447.79,492.61],"text":"a) Attacking systems with scripts\nb) Containment\nc) Social engineering activities\nd) Stealing user credentials"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Attacking systems with scripts"},{"label":"b","text":"Containment"},{"label":"c","text":"Social engineering activities"},{"label":"d","text":"Stealing user credentials"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q40)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q40. A cybersecurity incident response plan is defined as a set of instructions to aid the
 cybersecurity team to detect, respond to, and recover from cybersecurity incidents. The
 cybersecurity incident response plan resolves issues, such as cybercrime, data loss, and
 service outages that threaten daily work. Which of the following is part of the cybersecurity
 incident response plan?

 a) Attacking systems with scripts b) Containment
 c) Social engineering activities d) Stealing user credentials',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  41,
  'Q41. Between a client and web server, which of the following is used for inspecting the data
 that is sent from the client to the web server and blocking attacks, such as SQL injections?',
  '[{"type":"text","page":15,"bbox":[65.22,496.74,533.11,527.17],"text":"Q41. Between a client and web server, which of the following is used for inspecting the data"},{"type":"text","page":15,"bbox":[85.74,531.83,521.84,545.11],"text":"that is sent from the client to the web server and blocking attacks, such as SQL injections?"},{"type":"text","page":15,"bbox":[84.12,550.91,447.74,600.19],"text":"a) Cluster configuration\nb) Load balancing function\nc) SSL-VPN function\nd) WAF"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Cluster configuration"},{"label":"b","text":"Load balancing function"},{"label":"c","text":"SSL-VPN function"},{"label":"d","text":"WAF"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q41)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q41. Between a client and web server, which of the following is used for inspecting the data
 that is sent from the client to the web server and blocking attacks, such as SQL injections?

 a) Cluster configuration b) Load balancing function
 c) SSL-VPN function d) WAF',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  42,
  'Q42. Which of the following is an appropriate description of SSH?',
  '[{"type":"text","page":15,"bbox":[65.22,639.72,398.66,653.17],"text":"Q42. Which of the following is an appropriate description of SSH?"},{"type":"text","page":15,"bbox":[84.12,676.91,463.0,744.19],"text":"a) It cannot use public key pairs, and it uses a password for authentication.\nb) It helps in securely loading web site pages over HTTPS.\nc) It provides a secure channel for server maintenance over a public network.\nd) Its use is required in the Intranet."},{"type":"code","page":15,"bbox":[65.22,794.63,314.58,808.39],"text":"– 15 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It cannot use public key pairs, and it uses a password for authentication."},{"label":"b","text":"It helps in securely loading web site pages over HTTPS."},{"label":"c","text":"It provides a secure channel for server maintenance over a public network."},{"label":"d","text":"Its use is required in the Intranet.\n\n – 15 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q42)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q42. Which of the following is an appropriate description of SSH?

 a) It cannot use public key pairs, and it uses a password for authentication.
 b) It helps in securely loading web site pages over HTTPS.
 c) It provides a secure channel for server maintenance over a public network.
 d) Its use is required in the Intranet.

 – 15 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  43,
  'Q43. Which of the following is an appropriate description concerning Sender Policy Framework
 (SPF) for email communication?',
  '[{"type":"text","page":16,"bbox":[65.22,67.85,533.0,81.13],"text":"Q43. Which of the following is an appropriate description concerning Sender Policy Framework"},{"type":"text","page":16,"bbox":[83.1,85.85,243.64,99.13],"text":"(SPF) for email communication?"},{"type":"text","page":16,"bbox":[84.12,122.93,511.33,136.21],"text":"a) It is a policy of the public relations department to designate a specific person to send"},{"type":"text","page":16,"bbox":[84.12,140.93,532.89,190.21],"text":"emails.\nb) It is an email sent from a spoofed email address without authorization.\nc) It matches the sender mail server IP address with the information from the domain server"},{"type":"text","page":16,"bbox":[84.12,194.93,524.29,226.21],"text":"and accepts or rejects email.\nd) It sends an email to the address of a specific person instead of sending them to multiple"},{"type":"text","page":16,"bbox":[65.22,230.76,184.06,262.15],"text":"email addresses."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is a policy of the public relations department to designate a specific person to send\n emails."},{"label":"b","text":"It is an email sent from a spoofed email address without authorization."},{"label":"c","text":"It matches the sender mail server IP address with the information from the domain server\n and accepts or rejects email."},{"label":"d","text":"It sends an email to the address of a specific person instead of sending them to multiple\n email addresses."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q43)',
  ARRAY[16]::int[],
  'native_text',
  '3.0',
  'Q43. Which of the following is an appropriate description concerning Sender Policy Framework
 (SPF) for email communication?

 a) It is a policy of the public relations department to designate a specific person to send
 emails.
 b) It is an email sent from a spoofed email address without authorization.
 c) It matches the sender mail server IP address with the information from the domain server
 and accepts or rejects email.
 d) It sends an email to the address of a specific person instead of sending them to multiple
 email addresses.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[16]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  44,
  'Q44. Which of the following is an appropriate explanation of OP25B for email communication?',
  '[{"type":"text","page":16,"bbox":[65.22,266.76,533.23,297.19],"text":"Q44. Which of the following is an appropriate explanation of OP25B for email communication?"},{"type":"text","page":16,"bbox":[84.12,320.93,499.68,334.21],"text":"a) Blocking communication to port 25 to reduce mass-scale delivery of spam or junk"},{"type":"text","page":16,"bbox":[84.12,338.93,514.38,370.21],"text":"emails\nb) Blocking emails that are sent to more than 25 recipients at once due to organizational"},{"type":"text","page":16,"bbox":[84.12,374.93,516.49,406.21],"text":"policy\nc) Blocking Simple Mail Transfer Protocol (SMTP) communication except those sent to"},{"type":"text","page":16,"bbox":[84.12,410.93,512.46,442.21],"text":"port 25\nd) Blocklisting email addresses that send spams by monitoring email communication to"},{"type":"text","page":16,"bbox":[65.22,446.76,139.78,478.15],"text":"port 25"},{"type":"code","page":16,"bbox":[65.22,794.63,314.58,808.39],"text":"– 16 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Blocking communication to port 25 to reduce mass-scale delivery of spam or junk\n emails"},{"label":"b","text":"Blocking emails that are sent to more than 25 recipients at once due to organizational\n policy"},{"label":"c","text":"Blocking Simple Mail Transfer Protocol (SMTP) communication except those sent to\n port 25"},{"label":"d","text":"Blocklisting email addresses that send spams by monitoring email communication to\n port 25\n\n – 16 –"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q44)',
  ARRAY[16]::int[],
  'native_text',
  '3.0',
  'Q44. Which of the following is an appropriate explanation of OP25B for email communication?

 a) Blocking communication to port 25 to reduce mass-scale delivery of spam or junk
 emails
 b) Blocking emails that are sent to more than 25 recipients at once due to organizational
 policy
 c) Blocking Simple Mail Transfer Protocol (SMTP) communication except those sent to
 port 25
 d) Blocklisting email addresses that send spams by monitoring email communication to
 port 25

 – 16 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[16]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  45,
  'Q45. Which of the following is the UML class diagram that shows a generalization relation?',
  '[{"type":"text","page":17,"bbox":[65.22,67.74,526.77,81.19],"text":"Q45. Which of the following is the UML class diagram that shows a generalization relation?"},{"type":"text","page":17,"bbox":[90.48,104.22,99.68,117.56],"text":"a)"},{"type":"text","page":17,"bbox":[257.34,104.22,267.32,117.56],"text":"b)"},{"type":"text","page":17,"bbox":[312.84,105.06,369.63,118.4],"text":"Automobile"},{"type":"text","page":17,"bbox":[132.36,105.18,189.21,118.52],"text":"Automobile"},{"type":"text","page":17,"bbox":[145.68,147.9,151.65,161.24],"text":"1"},{"type":"text","page":17,"bbox":[145.68,166.26,151.65,179.6],"text":"1"},{"type":"text","page":17,"bbox":[131.58,178.14,191.33,191.48],"text":"Automobile"},{"type":"text","page":17,"bbox":[324.96,181.98,355.82,195.32],"text":"Driver"},{"type":"text","page":17,"bbox":[135.6,192.6,187.86,205.94],"text":"inspection"},{"type":"text","page":17,"bbox":[136.26,207.12,184.18,220.46],"text":"certificate"},{"type":"text","page":17,"bbox":[260.16,263.64,370.05,277.16],"text":"Automobile\nd)"},{"type":"text","page":17,"bbox":[89.04,265.08,98.3,278.42],"text":"c)"},{"type":"text","page":17,"bbox":[132.66,265.26,189.51,278.6],"text":"Automobile"},{"type":"text","page":17,"bbox":[349.62,315.78,355.59,329.12],"text":"1"},{"type":"text","page":17,"bbox":[326.88,315.96,332.85,329.3],"text":"1"},{"type":"text","page":17,"bbox":[293.16,334.02,380.43,347.6],"text":"*\n*"},{"type":"text","page":17,"bbox":[136.2,341.7,184.22,355.04],"text":"Sports car"},{"type":"text","page":17,"bbox":[292.44,346.38,401.01,359.72],"text":"Engine\nTire"}]'::jsonb,
  '["2021-april-a-q45-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Automobile"},{"label":"b","text":"Automobile\n\n 1\n 1\n Automobile Driver\n inspection\n certificate"},{"label":"c","text":"Automobile"},{"label":"d","text":"Automobile\n\n 1 1\n * *\n Sports car Tire Engine"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q45)',
  ARRAY[17]::int[],
  'native_text',
  '3.0',
  'Q45. Which of the following is the UML class diagram that shows a generalization relation?

 a) Automobile b) Automobile

 1
 1
 Automobile Driver
 inspection
 certificate

 c) Automobile d) Automobile

 1 1
 * *
 Sports car Tire Engine',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[17]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  46,
  'Q46. The figure below shows an example of a DFD that uses one of the DFD notations and
 represents a flow of data in a system. Texts in the figure are not shown. Which of the
 following is represented by the circle “” in the DFD notation used in the example?',
  '[{"type":"text","page":17,"bbox":[65.22,428.76,533.13,442.21],"text":"Q46. The figure below shows an example of a DFD that uses one of the DFD notations and"},{"type":"text","page":17,"bbox":[65.22,446.93,532.99,495.13],"text":"represents a flow of data in a system. Texts in the figure are not shown. Which of the\nfollowing is represented by the circle “” in the DFD notation used in the example?"},{"type":"text","page":17,"bbox":[93.6,607.85,378.08,639.13],"text":"a) Activity\nb) Data flow\nc) Data store\nd) Process"},{"type":"code","page":17,"bbox":[65.22,794.63,314.58,808.39],"text":"– 17 –"}]'::jsonb,
  '["2021-april-a-q46-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Activity"},{"label":"b","text":"Data flow"},{"label":"c","text":"Data store"},{"label":"d","text":"Process\n\n – 17 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q46)',
  ARRAY[17]::int[],
  'native_text',
  '3.0',
  'Q46. The figure below shows an example of a DFD that uses one of the DFD notations and
 represents a flow of data in a system. Texts in the figure are not shown. Which of the
 following is represented by the circle “” in the DFD notation used in the example?

 a) Activity b) Data flow
 c) Data store d) Process

 – 17 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[17]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  47,
  'Q47. Which of the following is an appropriate relationship between classes and instances in
 object orientation?',
  '[{"type":"text","page":18,"bbox":[65.22,68.76,533.1,82.21],"text":"Q47. Which of the following is an appropriate relationship between classes and instances in"},{"type":"text","page":18,"bbox":[85.2,86.93,184.98,117.13],"text":"object orientation?"},{"type":"text","page":18,"bbox":[84.12,122.93,377.04,190.21],"text":"a) An instance defines the specifications of a class.\nb) An instance is created based on the definition of a class.\nc) Multiple classes correspond to a single instance.\nd) Only one (1) instance exists for a single class."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"An instance defines the specifications of a class."},{"label":"b","text":"An instance is created based on the definition of a class."},{"label":"c","text":"Multiple classes correspond to a single instance."},{"label":"d","text":"Only one (1) instance exists for a single class."}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q47)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q47. Which of the following is an appropriate relationship between classes and instances in
 object orientation?

 a) An instance defines the specifications of a class.
 b) An instance is created based on the definition of a class.
 c) Multiple classes correspond to a single instance.
 d) Only one (1) instance exists for a single class.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  48,
  'Q48. Which of the following is the weakest module coupling?',
  '[{"type":"text","page":18,"bbox":[65.22,230.76,375.68,244.21],"text":"Q48. Which of the following is the weakest module coupling?"},{"type":"text","page":18,"bbox":[65.22,248.93,495.05,352.21],"text":"a) To implement as many functions as possible with a single module\nb) To pass arguments that control another module’s logic when the module is called\nc) To pass only required data items as arguments between two (2) modules\nd) To use a global area to share data items with other modules"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"To implement as many functions as possible with a single module"},{"label":"b","text":"To pass arguments that control another module’s logic when the module is called"},{"label":"c","text":"To pass only required data items as arguments between two (2) modules"},{"label":"d","text":"To use a global area to share data items with other modules"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q48)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q48. Which of the following is the weakest module coupling?

 a) To implement as many functions as possible with a single module
 b) To pass arguments that control another module’s logic when the module is called
 c) To pass only required data items as arguments between two (2) modules
 d) To use a global area to share data items with other modules',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  49,
  'Q49. Which of the following tests verifies the interfaces between two (2) modules or
 subsystems?',
  '[{"type":"text","page":18,"bbox":[65.22,373.74,533.1,387.19],"text":"Q49. Which of the following tests verifies the interfaces between two (2) modules or"},{"type":"text","page":18,"bbox":[85.74,391.85,148.7,405.13],"text":"subsystems?"},{"type":"text","page":18,"bbox":[65.22,428.93,499.14,460.21],"text":"a) Acceptance test\nb) Integration test\nc) Operational test\nd) Unit test"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Acceptance test"},{"label":"b","text":"Integration test"},{"label":"c","text":"Operational test"},{"label":"d","text":"Unit test"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q49)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q49. Which of the following tests verifies the interfaces between two (2) modules or
 subsystems?

 a) Acceptance test b) Integration test c) Operational test d) Unit test',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  50,
  'Q50. Which of the following is an appropriate explanation of a comprehensive patent crosslicense?',
  '[{"type":"text","page":18,"bbox":[65.22,464.93,530.12,495.19],"text":"Q50. Which of the following is an appropriate explanation of a comprehensive patent cross-"},{"type":"text","page":18,"bbox":[85.74,499.85,127.36,513.13],"text":"license?"},{"type":"text","page":18,"bbox":[84.12,518.93,521.62,568.21],"text":"a) An agreement to share the necessary costs for patent registration is concluded.\nb) The source code is published free of charge on the Internet or other places, and anyone"},{"type":"text","page":18,"bbox":[84.12,572.93,526.39,604.21],"text":"may improve and redistribute the software.\nc) The use of patent rights is mutually licensed among companies in the specified fields of"},{"type":"text","page":18,"bbox":[84.12,608.93,467.98,640.21],"text":"technologies or products.\nd) To ensure that a company’s patent rights are not violated, the right to stop a"},{"type":"text","page":18,"bbox":[65.22,644.93,303.61,676.21],"text":"counterpart’s manufacturing is exercised."},{"type":"code","page":18,"bbox":[65.22,794.63,314.58,808.39],"text":"– 18 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"An agreement to share the necessary costs for patent registration is concluded."},{"label":"b","text":"The source code is published free of charge on the Internet or other places, and anyone\n may improve and redistribute the software."},{"label":"c","text":"The use of patent rights is mutually licensed among companies in the specified fields of\n technologies or products."},{"label":"d","text":"To ensure that a company’s patent rights are not violated, the right to stop a\n counterpart’s manufacturing is exercised.\n\n – 18 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q50)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q50. Which of the following is an appropriate explanation of a comprehensive patent crosslicense?

 a) An agreement to share the necessary costs for patent registration is concluded.
 b) The source code is published free of charge on the Internet or other places, and anyone
 may improve and redistribute the software.
 c) The use of patent rights is mutually licensed among companies in the specified fields of
 technologies or products.
 d) To ensure that a company’s patent rights are not violated, the right to stop a
 counterpart’s manufacturing is exercised.

 – 18 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  51,
  'Q51. Based on the definition of project management process groups in ISO 21500, which of
 the following is an activity that is to be implemented in the planning process group among
 the project management processes?',
  '[{"type":"text","page":19,"bbox":[65.22,68.76,533.14,135.13],"text":"Q51.\nBased on the definition of project management process groups in ISO 21500, which of\nthe following is an activity that is to be implemented in the planning process group among\nthe project management processes?"},{"type":"text","page":19,"bbox":[84.12,140.93,471.3,190.21],"text":"a) To define scope\nb) To develop a project charter\nc) To identify stakeholders\nd) To perform quality assurance"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"To define scope"},{"label":"b","text":"To develop a project charter"},{"label":"c","text":"To identify stakeholders"},{"label":"d","text":"To perform quality assurance"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q51)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q51. Based on the definition of project management process groups in ISO 21500, which of
 the following is an activity that is to be implemented in the planning process group among
 the project management processes?

 a) To define scope b) To develop a project charter
 c) To identify stakeholders d) To perform quality assurance',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  52,
  'Q52. In project time management, which of the following descriptions is appropriate for “slack
 time”?',
  '[{"type":"text","page":19,"bbox":[65.22,212.76,533.16,244.21],"text":"Q52. In project time management, which of the following descriptions is appropriate for “slack"},{"type":"text","page":19,"bbox":[89.34,248.93,124.34,262.21],"text":"time”?"},{"type":"text","page":19,"bbox":[84.12,284.93,503.71,298.21],"text":"a) It is the amount of time between the earliest start time and earliest finish time of an"},{"type":"text","page":19,"bbox":[84.12,302.93,512.69,334.21],"text":"activity or between the latest start time and latest finish time of an activity.\nb) It is the amount of time for which a non-critical path activity can be deferred without"},{"type":"text","page":19,"bbox":[84.12,338.93,531.79,370.21],"text":"delaying the project.\nc) It is the amount of time that an activity can be deferred without delaying the earliest start"},{"type":"text","page":19,"bbox":[84.12,374.93,520.34,406.21],"text":"time of any succeeding activity or violating a schedule constraint.\nd) It is the amount of time that an activity can be delayed past its latest start time or latest"},{"type":"text","page":19,"bbox":[65.22,410.93,159.79,442.21],"text":"finish time."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is the amount of time between the earliest start time and earliest finish time of an\n activity or between the latest start time and latest finish time of an activity."},{"label":"b","text":"It is the amount of time for which a non-critical path activity can be deferred without\n delaying the project."},{"label":"c","text":"It is the amount of time that an activity can be deferred without delaying the earliest start\n time of any succeeding activity or violating a schedule constraint."},{"label":"d","text":"It is the amount of time that an activity can be delayed past its latest start time or latest\n finish time."}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q52)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q52. In project time management, which of the following descriptions is appropriate for “slack
 time”?

 a) It is the amount of time between the earliest start time and earliest finish time of an
 activity or between the latest start time and latest finish time of an activity.
 b) It is the amount of time for which a non-critical path activity can be deferred without
 delaying the project.
 c) It is the amount of time that an activity can be deferred without delaying the earliest start
 time of any succeeding activity or violating a schedule constraint.
 d) It is the amount of time that an activity can be delayed past its latest start time or latest
 finish time.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  53,
  'Q53. When the duration for painting a house is estimated, which of the following is an
 appropriate technique that estimates the duration on the basis of the actual duration of a
 similar painting job in the past of the same house or other historical data from similar work?',
  '[{"type":"text","page":19,"bbox":[65.22,446.93,533.14,478.21],"text":"Q53. When the duration for painting a house is estimated, which of the following is an"},{"type":"text","page":19,"bbox":[65.22,482.93,533.14,532.21],"text":"appropriate technique that estimates the duration on the basis of the actual duration of a\nsimilar painting job in the past of the same house or other historical data from similar work?"},{"type":"text","page":19,"bbox":[65.22,536.93,430.15,585.13],"text":"a) Analogous estimate\nb) Parametric estimate\nc) Reserve analysis\nd) Three-point estimate"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Analogous estimate"},{"label":"b","text":"Parametric estimate"},{"label":"c","text":"Reserve analysis"},{"label":"d","text":"Three-point estimate"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q53)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q53. When the duration for painting a house is estimated, which of the following is an
 appropriate technique that estimates the duration on the basis of the actual duration of a
 similar painting job in the past of the same house or other historical data from similar work?

 a) Analogous estimate b) Parametric estimate
 c) Reserve analysis d) Three-point estimate',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  54,
  'Q54. In system development, when the relationship between person-months and the duration
 (months) is represented in the approximate expression shown below, and the total personmonth is 4096, how many months does it take?

 Duration = 2.5  person-months1/3',
  '[{"type":"text","page":19,"bbox":[65.22,590.93,533.14,675.13],"text":"Q54.\nIn system development, when the relationship between person-months and the duration\n(months) is represented in the approximate expression shown below, and the total person-\nmonth is 4096, how many months does it take?"},{"type":"text","page":19,"bbox":[109.38,678.9,276.96,693.59],"text":"Duration = 2.5  person-months1/3"},{"type":"text","page":19,"bbox":[65.22,698.93,476.1,748.21],"text":"a) 16\nb) 40\nc) 64\nd) 160"},{"type":"code","page":19,"bbox":[65.22,794.63,314.58,808.39],"text":"– 19 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"16"},{"label":"b","text":"40"},{"label":"c","text":"64"},{"label":"d","text":"160\n\n – 19 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q54)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q54. In system development, when the relationship between person-months and the duration
 (months) is represented in the approximate expression shown below, and the total personmonth is 4096, how many months does it take?

 Duration = 2.5  person-months1/3

 a) 16 b) 40 c) 64 d) 160

 – 19 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  55,
  'Q55. An IT service is provided under the conditions that are described below. What is the
 maximum downtime in hours that can satisfy the SLA during a service time period of one (1)
 month? Here, the number of business days in one (1) month is 30, and no maintenance or
 other scheduled downtime of the service is performed during the service time period.

 [Conditions of the SLA]
 - The service time period is from 8:00 AM to 10:00 PM on business days.
 - The availability should be 99.5% or more.',
  '[{"type":"text","page":20,"bbox":[65.22,67.74,533.04,81.19],"text":"Q55. An IT service is provided under the conditions that are described below. What is the"},{"type":"text","page":20,"bbox":[85.74,85.85,533.21,135.13],"text":"maximum downtime in hours that can satisfy the SLA during a service time period of one (1)\nmonth? Here, the number of business days in one (1) month is 30, and no maintenance or\nother scheduled downtime of the service is performed during the service time period."},{"type":"text","page":20,"bbox":[75.24,162.53,195.16,175.81],"text":"[Conditions of the SLA]"},{"type":"text","page":20,"bbox":[85.08,179.81,451.71,211.09],"text":"-\nThe service time period is from 8:00 AM to 10:00 PM on business days.\n-\nThe availability should be 99.5% or more."},{"type":"text","page":20,"bbox":[84.12,234.89,473.1,248.17],"text":"a) 0.3\nb) 2.1\nc) 3.0\nd) 3.6"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0.3"},{"label":"b","text":"2.1"},{"label":"c","text":"3.0"},{"label":"d","text":"3.6"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q55)',
  ARRAY[20]::int[],
  'native_text',
  '3.0',
  'Q55. An IT service is provided under the conditions that are described below. What is the
 maximum downtime in hours that can satisfy the SLA during a service time period of one (1)
 month? Here, the number of business days in one (1) month is 30, and no maintenance or
 other scheduled downtime of the service is performed during the service time period.

 [Conditions of the SLA]
 - The service time period is from 8:00 AM to 10:00 PM on business days.
 - The availability should be 99.5% or more.

 a) 0.3 b) 2.1 c) 3.0 d) 3.6',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[20]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  56,
  'Q56. Which of the following is the main purpose of a migration test for a system?',
  '[{"type":"text","page":20,"bbox":[65.22,288.72,470.23,302.17],"text":"Q56. Which of the following is the main purpose of a migration test for a system?"},{"type":"text","page":20,"bbox":[84.12,306.89,532.26,356.17],"text":"a) To confirm that a new system possesses all of the required functions\nb) To confirm that sufficient performance can be derived from the new system using a copy"},{"type":"text","page":20,"bbox":[84.12,360.89,507.76,392.17],"text":"of the actual data from the existing system\nc) To confirm the compatibility of the interface between a program of another existing"},{"type":"text","page":20,"bbox":[84.12,396.89,511.01,428.17],"text":"system and a newly developed program\nd) To confirm the switch procedure from the existing system to the new system and the"},{"type":"text","page":20,"bbox":[102.12,432.89,507.62,446.17],"text":"problems that the switch can cause from the perspective of reliability and efficiency"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"To confirm that a new system possesses all of the required functions"},{"label":"b","text":"To confirm that sufficient performance can be derived from the new system using a copy\n of the actual data from the existing system"},{"label":"c","text":"To confirm the compatibility of the interface between a program of another existing\n system and a newly developed program"},{"label":"d","text":"To confirm the switch procedure from the existing system to the new system and the\n problems that the switch can cause from the perspective of reliability and efficiency"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q56)',
  ARRAY[20]::int[],
  'native_text',
  '3.0',
  'Q56. Which of the following is the main purpose of a migration test for a system?

 a) To confirm that a new system possesses all of the required functions
 b) To confirm that sufficient performance can be derived from the new system using a copy
 of the actual data from the existing system
 c) To confirm the compatibility of the interface between a program of another existing
 system and a newly developed program
 d) To confirm the switch procedure from the existing system to the new system and the
 problems that the switch can cause from the perspective of reliability and efficiency',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[20]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  57,
  'Q57. In IT service management, which of the following is handled by incident management?',
  '[{"type":"text","page":20,"bbox":[65.22,467.7,525.9,517.09],"text":"Q57. In IT service management, which of the following is handled by incident management?"},{"type":"text","page":20,"bbox":[65.22,522.89,427.68,626.11],"text":"a) Inquiry regarding the function or usage of the IT service or system\nb) Long delay in an application response\nc) Request for providing the IT service to a new business site\nd) Request for training of recruits on the IT service"},{"type":"code","page":20,"bbox":[65.22,794.63,314.58,808.39],"text":"– 20 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Inquiry regarding the function or usage of the IT service or system"},{"label":"b","text":"Long delay in an application response"},{"label":"c","text":"Request for providing the IT service to a new business site"},{"label":"d","text":"Request for training of recruits on the IT service\n\n – 20 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q57)',
  ARRAY[20]::int[],
  'native_text',
  '3.0',
  'Q57. In IT service management, which of the following is handled by incident management?

 a) Inquiry regarding the function or usage of the IT service or system
 b) Long delay in an application response
 c) Request for providing the IT service to a new business site
 d) Request for training of recruits on the IT service

 – 20 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[20]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  58,
  'Q58. When the PDCA methodology is applied to a service management system, which of the
 following corresponds to Act?',
  '[{"type":"text","page":21,"bbox":[65.22,68.76,533.14,82.21],"text":"Q58. When the PDCA methodology is applied to a service management system, which of the"},{"type":"text","page":21,"bbox":[84.12,86.93,519.66,154.21],"text":"following corresponds to Act?\n\na) Establishing, documenting, and agreeing the service management system\nb) Implementing and operating the service management system for the design, transition,"},{"type":"text","page":21,"bbox":[84.12,158.93,507.37,190.21],"text":"delivery, and improvement of services\nc) Monitoring, measuring, and reviewing the service management system and services"},{"type":"text","page":21,"bbox":[84.12,194.93,531.29,226.21],"text":"against the policies, objectives, plans, and service requirements, and reporting the results\nd) Taking actions to continually improve the performance of the service management"},{"type":"text","page":21,"bbox":[102.12,230.93,200.41,244.21],"text":"system and services"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Establishing, documenting, and agreeing the service management system"},{"label":"b","text":"Implementing and operating the service management system for the design, transition,\n delivery, and improvement of services"},{"label":"c","text":"Monitoring, measuring, and reviewing the service management system and services\n against the policies, objectives, plans, and service requirements, and reporting the results"},{"label":"d","text":"Taking actions to continually improve the performance of the service management\n system and services"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q58)',
  ARRAY[21]::int[],
  'native_text',
  '3.0',
  'Q58. When the PDCA methodology is applied to a service management system, which of the
 following corresponds to Act?

 a) Establishing, documenting, and agreeing the service management system
 b) Implementing and operating the service management system for the design, transition,
 delivery, and improvement of services
 c) Monitoring, measuring, and reviewing the service management system and services
 against the policies, objectives, plans, and service requirements, and reporting the results
 d) Taking actions to continually improve the performance of the service management
 system and services',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[21]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  59,
  'Q59. In the system design stage, which of the following is the point to be checked during the
 audit of control for reducing the risk of non-fulfillment of user requirements?',
  '[{"type":"text","page":21,"bbox":[65.22,284.76,533.12,298.21],"text":"Q59. In the system design stage, which of the following is the point to be checked during the"},{"type":"text","page":21,"bbox":[65.22,302.93,463.23,334.21],"text":"audit of control for reducing the risk of non-fulfillment of user requirements?"},{"type":"text","page":21,"bbox":[84.12,338.93,517.28,352.21],"text":"a) All programming should be performed in accordance with the specified standards and"},{"type":"text","page":21,"bbox":[84.12,356.93,484.39,388.21],"text":"conventions.\nb) The program specifications should be created on the basis of the system design"},{"type":"text","page":21,"bbox":[84.12,392.93,512.77,424.21],"text":"documents.\nc) The test plan should be created on the basis of the system test requirements and must"},{"type":"text","page":21,"bbox":[65.22,428.93,491.61,477.13],"text":"also be approved by the responsible person of the system operations department.\nd) The user department should participate in the review of system design."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"All programming should be performed in accordance with the specified standards and\n conventions."},{"label":"b","text":"The program specifications should be created on the basis of the system design\n documents."},{"label":"c","text":"The test plan should be created on the basis of the system test requirements and must\n also be approved by the responsible person of the system operations department."},{"label":"d","text":"The user department should participate in the review of system design."}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q59)',
  ARRAY[21]::int[],
  'native_text',
  '3.0',
  'Q59. In the system design stage, which of the following is the point to be checked during the
 audit of control for reducing the risk of non-fulfillment of user requirements?

 a) All programming should be performed in accordance with the specified standards and
 conventions.
 b) The program specifications should be created on the basis of the system design
 documents.
 c) The test plan should be created on the basis of the system test requirements and must
 also be approved by the responsible person of the system operations department.
 d) The user department should participate in the review of system design.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[21]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'A',
  60,
  'Q60. When IT controls are classified into preventive controls and detective controls, which of
 the following is to be classified as a detective control?

 a) A data entry manual is created, and the persons in charge of data entry are trained.
 b) A data entry screen is designed so that operation errors are unlikely to occur.
 c) Access rights are assigned only to the person in charge of data entry.
 d) An output list resulting from data entry is cross-checked with the input form.

 – 21 –

Q61. Which of the following is an explanation of CRM?

 a) It is a business approach for significantly improving the efficiency of the entire supply
 chain through the real time exchange of information regarding production, inventory,
 procurement, sales, distribution, etc.
 b) It is a concept to optimize customer loyalty by sharing information throughout all
 customer channels within a company and improving customer satisfaction by raising the
 level of service.
 c) It is a method for improving business efficiency by planning and managing business
 resources throughout the company effectively and comprehensively.
 d) It is a method for wholesale dealers or manufacturers to increase business transactions
 with retail stores by supporting their business activities, and increasing their sales and
 profits.

Q62. Which of the following is an explanation of BPO?

 a) A company outsources all work processes of a specific department, such as management
 section or call center and its work system operation, to an external provider.
 b) A company reduces software development costs by using employees of a temporary
 employment agency with lower personnel expenses.
 c) A company rents a portion of the processing and storage capacities of servers owned by
 a telecommunications service provider and operates systems without owning its own
 servers.
 d) A company uses software functions provided by an external provider over a network
 without owning the software.

Q63. Which of the following is an appropriate description of chatbot?

 a) A software that uses image processing techniques and is employed for applications to
 describe image details to a human
 b) A software that uses natural language processing techniques and is employed for
 applications to communicate with a human
 c) A software that uses signal processing techniques and is employed for applications to
 convert a human’s voice into texts
 d) A software that uses speech processing techniques and is employed for applications to
 generate subtitles automatically for a human to read while watching videos

 – 22 –

Q64. Which of the following is a technique that performs the optimum resource allocation for
 computerization investment in each category classified by the similarities of risks and
 investment value?

 a) 3C analysis b) Benchmarking
 c) Enterprise architecture d) IT portfolio

Q65. In the verification of stakeholder requirements, which of the following indicates the ability
 to keep track of the process until the implementation of a change request?

 a) Interoperability b) Maintainability c) Traceability d) Usability

Q66. Which of the following is an explanation of core competence?

 a) The basic mindset and action guidelines behind management activities
 b) The business opportunities and threats in the environment around a company
 c) The management resources that form the source of competitive advantage over other
 companies
 d) The objectives to be achieved through the execution of a business strategy

Q67. In a product life cycle, which of the following is a stage where the withdrawal of some
 companies is observed when the demand peaks, and decision-making is necessary to
 determine whether it is possible to gain a strong foothold?

 a) Decline stage b) Growth stage
 c) Introduction stage d) Maturity stage

 – 23 –

Q68. When an IT vendor uses a “Balanced Scorecard” to promote a solution business, which of
 the following is an example of the learning and growth KPI goal? Here, “solution” means “to
 support a customer through information technology and professional services that are offered
 by experts so that the customer can achieve its management objectives.”

 a) To increase the number of customer proposals by a factor of 1.5 over that of the previous
 year by preparing an environment for reusing proposals to augment the number of
 registered solution cases
 b) To increase the sales volume in the consulting business for information strategy planning
 and system planning for it to account for 15% or more of the total sales of the company
 c) To set an average satisfaction score of 3.5 out of five (5) or more in a satisfaction
 survey of customers for whom a service is offered
 d) To train 30 employees as IT professionals in order to focus on the consulting services in
 the information strategy

Q69. Which of the following is an appropriate explanation of concurrent engineering?

 a) A new product development technique that sequentially executes processes, such as
 product design, manufacturing, and sales activities
 b) A technique that analyzes a target system and clarifies its specifications
 c) A technique that executes processes, such as product design and production planning, in
 parallel during the new product development procedure
 d) A technique that tries to figure out the optimal combination of functions and cost and to
 improve value through systematic procedures

Q70. Which of the following is the appropriate description of telemedicine?

 a) Caring for patients by using computer technologies when the physician and patients are
 physically together in a hospital
 b) Caring for patients by using electronic communication technologies when the physician
 and patients are not in the same location
 c) Caring for patients by using electronic communication technologies when the physician
 and patients are physically together at the patients’ house
 d) Caring for patients without using computer technologies when the physician and patients
 are physically together at the physician’s clinic

 – 24 –

Q71. The figure below shows the relationships among the components of product A, and the
 numbers in parentheses indicate the quantity of components necessary to produce one unit of
 the upper-level product or component. When 10 units of product A are produced, how many
 units of component C must be ordered? Here, there are presently five units of component C
 in the inventory.
 A

 B(2) C(1)

 D(1) E(1) C(1)

 a) 15 b) 20 c) 25 d) 30

Q72. The figure below shows the transaction model of an escrow service that is used in an
 Internet auction site or other similar transactions. Which of the following is the action that
 corresponds to (5) in this figure? Here, (1) through (6) indicate the sequence of transactions,
 and each of the numbers from (3) to (6) corresponds to an action in a) through d).

 Escrow service company

 (3) (2) Payment
 for purchase
 (6) (5)
 (4)
 Seller Buyer
 (1) Agreement of sale

 a) Notice of payment deposit b) Notice of product receipt
 c) Shipment of product d) Transfer of payment

 – 25 –

Q73. Which of the following is an appropriate explanation of HEMS?

 a) It is a system that connects multiple home appliances through a network to visualize the
 power and perform optimum control of power consumption.
 b) It is a system that converts the electricity produced by a solar power generation system
 and a residential-use fuel cell for the electricity to be useable in households, etc.
 c) It is a system that recycles the useful parts of home appliances discarded by general
 households and offices to reduce the amount of waste materials and promote the
 effective use of resources.
 d) It is an electric hot water supply system that generates a considerable quantity of heat
 with a relatively small amount of energy by using a heat pump.

Q74. When real-time systems are classified into hard real-time and soft real-time systems, which
 of the following is in the category of a hard real-time system?

 a) Airbag control system b) Bank ATM system
 c) Seat reservation system d) Web delivery system

Q75. Which of the following is an organizational structure of a corporation that is temporarily
 structured by specialists from each department to reach a specific goal over a limited period
 and operates independently from all other standing organizations?

 a) Company system organization b) Divisional system organization
 c) Functional organization d) Project organization

Q76. There are several quality control tools that have been used primarily for manufacturing
 and inspection departments. Which of the following is a combined graph containing a bar
 graph that shows the numeric values of individual items in descending order, and a line graph
 that shows the cumulative total of the composition ratios of these numeric values?

 a) Control chart b) Histogram
 c) Pareto chart d) Scatter diagram

 – 26 –

Q77. In a sampling inspection, which of the following can be used to ascertain the probability
 of acceptance of a lot with a certain defective ratio?

 a) Bathtub curve b) Gompertz curve
 c) Logistic curve d) OC curve

 Q78. Which of following is an expression for calculating the cost of goods sold (or cost of sales)
 of a manufacturing company?

 a) Material cost in current period + Labor cost in current period + Expense in current
 period
 b) Product inventory at beginning of period + Product manufacturing cost in current period
 − Product inventory at end of period
 c) Product inventory at beginning of period + Product manufacturing cost in current period
 − Work in process inventory at end of period
 d) Work in process inventory at beginning of period + Product manufacturing cost in
 current period − work in process inventory at end of period

Q79. The break-even point (BEP) is a level where total cost and total revenue are equal. The
 table below lists the fixed cost, variable cost per unit, price per unit, and BEP in units.
 Which of the following is a value of the price per unit?

 Fixed cost ($) 100,000
 Variable cost per unit ($) 2
 Price per unit ($)
 BEP in units 10,000

 a) 4 b) 8 c) 12 d) 16

Q80. Which of the following is the intellectual property right that does not require registration
 for protection in the World Trade Organization (WTO) member states?',
  '[{"type":"text","page":21,"bbox":[65.22,499.74,533.13,531.13],"text":"Q60.\nWhen IT controls are classified into preventive controls and detective controls, which of\nthe following is to be classified as a detective control?"},{"type":"text","page":21,"bbox":[84.12,536.93,499.9,622.21],"text":"a) A data entry manual is created, and the persons in charge of data entry are trained.\nb) A data entry screen is designed so that operation errors are unlikely to occur.\nc) Access rights are assigned only to the person in charge of data entry.\nd) An output list resulting from data entry is cross-checked with the input form."},{"type":"code","page":21,"bbox":[65.22,794.63,314.58,808.39],"text":"– 21 –"},{"type":"text","page":22,"bbox":[65.22,67.74,351.24,81.19],"text":"Q61. Which of the following is an explanation of CRM?"},{"type":"text","page":22,"bbox":[84.12,88.19,520.01,118.21],"text":"a) It is a business approach for significantly improving the efficiency of the entire supply"},{"type":"text","page":22,"bbox":[84.12,122.93,514.2,172.21],"text":"chain through the real time exchange of information regarding production, inventory,\nprocurement, sales, distribution, etc.\nb) It is a concept to optimize customer loyalty by sharing information throughout all"},{"type":"text","page":22,"bbox":[84.12,176.93,529.41,226.21],"text":"customer channels within a company and improving customer satisfaction by raising the\nlevel of service.\nc) It is a method for improving business efficiency by planning and managing business"},{"type":"text","page":22,"bbox":[84.12,230.93,518.89,262.21],"text":"resources throughout the company effectively and comprehensively.\nd) It is a method for wholesale dealers or manufacturers to increase business transactions"},{"type":"text","page":22,"bbox":[65.22,266.93,516.64,351.19],"text":"with retail stores by supporting their business activities, and increasing their sales and\nprofits.\n\n\nQ62. Which of the following is an explanation of BPO?"},{"type":"text","page":22,"bbox":[84.12,356.93,530.71,388.21],"text":"a) A company outsources all work processes of a specific department, such as management"},{"type":"text","page":22,"bbox":[84.12,392.93,508.79,424.21],"text":"section or call center and its work system operation, to an external provider.\nb) A company reduces software development costs by using employees of a temporary"},{"type":"text","page":22,"bbox":[84.12,428.93,526.44,460.21],"text":"employment agency with lower personnel expenses.\nc) A company rents a portion of the processing and storage capacities of servers owned by"},{"type":"text","page":22,"bbox":[84.12,464.93,511.71,514.21],"text":"a telecommunications service provider and operates systems without owning its own\nservers.\nd) A company uses software functions provided by an external provider over a network"},{"type":"text","page":22,"bbox":[65.22,518.93,412.24,585.19],"text":"without owning the software.\n\n\nQ63. Which of the following is an appropriate description of chatbot?"},{"type":"text","page":22,"bbox":[84.12,608.93,515.77,622.21],"text":"a) A software that uses image processing techniques and is employed for applications to"},{"type":"text","page":22,"bbox":[84.12,626.93,492.73,658.21],"text":"describe image details to a human\nb) A software that uses natural language processing techniques and is employed for"},{"type":"text","page":22,"bbox":[84.12,662.93,515.11,694.21],"text":"applications to communicate with a human\nc) A software that uses signal processing techniques and is employed for applications to"},{"type":"text","page":22,"bbox":[84.12,698.93,518.99,730.21],"text":"convert a human’s voice into texts\nd) A software that uses speech processing techniques and is employed for applications to"},{"type":"text","page":22,"bbox":[84.12,734.93,470.96,766.21],"text":"generate subtitles automatically for a human to read while watching videos"},{"type":"code","page":22,"bbox":[65.22,794.63,314.58,808.39],"text":"– 22 –"},{"type":"text","page":23,"bbox":[65.22,67.74,533.16,81.19],"text":"Q64. Which of the following is a technique that performs the optimum resource allocation for"},{"type":"text","page":23,"bbox":[85.74,85.85,533.15,117.13],"text":"computerization investment in each category classified by the similarities of risks and\ninvestment value?"},{"type":"text","page":23,"bbox":[65.22,122.93,533.18,225.19],"text":"a) 3C analysis\nb) Benchmarking\nc) Enterprise architecture\nd) IT portfolio\n\n\nQ65. In the verification of stakeholder requirements, which of the following indicates the ability"},{"type":"text","page":23,"bbox":[85.2,229.85,445.56,260.89],"text":"to keep track of the process until the implementation of a change request?"},{"type":"text","page":23,"bbox":[84.12,266.93,502.16,280.21],"text":"a) Interoperability\nb) Maintainability\nc) Traceability\nd) Usability"},{"type":"text","page":23,"bbox":[65.22,319.74,402.59,351.13],"text":"Q66. Which of the following is an explanation of core competence?"},{"type":"text","page":23,"bbox":[84.12,356.93,512.03,406.21],"text":"a) The basic mindset and action guidelines behind management activities\nb) The business opportunities and threats in the environment around a company\nc) The management resources that form the source of competitive advantage over other"},{"type":"text","page":23,"bbox":[65.22,410.93,461.47,459.13],"text":"companies\nd) The objectives to be achieved through the execution of a business strategy"},{"type":"text","page":23,"bbox":[65.22,464.93,533.1,495.19],"text":"Q67. In a product life cycle, which of the following is a stage where the withdrawal of some"},{"type":"text","page":23,"bbox":[65.22,499.85,533.11,549.13],"text":"companies is observed when the demand peaks, and decision-making is necessary to\ndetermine whether it is possible to gain a strong foothold?"},{"type":"text","page":23,"bbox":[65.22,554.93,400.09,621.13],"text":"a) Decline stage\nb) Growth stage\nc) Introduction stage\nd) Maturity stage"},{"type":"code","page":23,"bbox":[65.22,794.63,314.58,808.39],"text":"– 23 –"},{"type":"text","page":24,"bbox":[65.22,67.74,533.05,81.19],"text":"Q68. When an IT vendor uses a “Balanced Scorecard” to promote a solution business, which of"},{"type":"text","page":24,"bbox":[85.74,85.85,533.13,135.13],"text":"the following is an example of the learning and growth KPI goal? Here, “solution” means “to\nsupport a customer through information technology and professional services that are offered\nby experts so that the customer can achieve its management objectives.”"},{"type":"text","page":24,"bbox":[84.12,158.93,532.69,190.21],"text":"a) To increase the number of customer proposals by a factor of 1.5 over that of the previous"},{"type":"text","page":24,"bbox":[84.12,194.93,533.13,244.21],"text":"year by preparing an environment for reusing proposals to augment the number of\nregistered solution cases\nb) To increase the sales volume in the consulting business for information strategy planning"},{"type":"text","page":24,"bbox":[86.22,248.93,524.69,280.21],"text":"and system planning for it to account for 15% or more of the total sales of the company\nc) To set an average satisfaction score of 3.5 out of five (5) or more in a satisfaction"},{"type":"text","page":24,"bbox":[84.12,284.93,528.09,316.21],"text":"survey of customers for whom a service is offered\nd) To train 30 employees as IT professionals in order to focus on the consulting services in"},{"type":"text","page":24,"bbox":[65.22,320.93,220.47,351.13],"text":"the information strategy"},{"type":"text","page":24,"bbox":[65.22,356.76,490.01,388.21],"text":"Q69. Which of the following is an appropriate explanation of concurrent engineering?"},{"type":"text","page":24,"bbox":[84.12,410.93,507.35,424.21],"text":"a) A new product development technique that sequentially executes processes, such as"},{"type":"text","page":24,"bbox":[84.12,428.93,528.31,478.21],"text":"product design, manufacturing, and sales activities\nb) A technique that analyzes a target system and clarifies its specifications\nc) A technique that executes processes, such as product design and production planning, in"},{"type":"text","page":24,"bbox":[84.12,482.93,526.69,514.21],"text":"parallel during the new product development procedure\nd) A technique that tries to figure out the optimal combination of functions and cost and to"},{"type":"text","page":24,"bbox":[102.12,518.93,329.78,532.21],"text":"improve value through systematic procedures"},{"type":"text","page":24,"bbox":[65.22,571.74,447.58,585.19],"text":"Q70. Which of the following is the appropriate description of telemedicine?"},{"type":"text","page":24,"bbox":[84.12,608.93,525.07,622.21],"text":"a) Caring for patients by using computer technologies when the physician and patients are"},{"type":"text","page":24,"bbox":[84.12,626.93,526.36,658.21],"text":"physically together in a hospital\nb) Caring for patients by using electronic communication technologies when the physician"},{"type":"text","page":24,"bbox":[84.12,662.93,526.36,694.21],"text":"and patients are not in the same location\nc) Caring for patients by using electronic communication technologies when the physician"},{"type":"text","page":24,"bbox":[84.12,698.93,532.15,730.21],"text":"and patients are physically together at the patients’ house\nd) Caring for patients without using computer technologies when the physician and patients"},{"type":"text","page":24,"bbox":[65.22,734.93,331.18,766.21],"text":"are physically together at the physician’s clinic"},{"type":"code","page":24,"bbox":[65.22,794.63,314.58,808.39],"text":"– 24 –"},{"type":"text","page":25,"bbox":[65.22,67.74,533.1,81.19],"text":"Q71. The figure below shows the relationships among the components of product A, and the"},{"type":"text","page":25,"bbox":[85.74,85.85,533.1,153.13],"text":"numbers in parentheses indicate the quantity of components necessary to produce one unit of\nthe upper-level product or component. When 10 units of product A are produced, how many\nunits of component C must be ordered? Here, there are presently five units of component C\nin the inventory."},{"type":"text","page":25,"bbox":[341.94,155.29,349.42,168.84],"text":"A"},{"type":"text","page":25,"bbox":[281.22,183.97,410.22,197.52],"text":"B(2)\nC(1)"},{"type":"text","page":25,"bbox":[227.1,212.59,356.7,226.14],"text":"D(1)\nE(1)\nC(1)"},{"type":"text","page":25,"bbox":[65.22,216.53,533.12,315.19],"text":"a) 15\nb) 20\nc) 25\nd) 30\n\n\nQ72. The figure below shows the transaction model of an escrow service that is used in an"},{"type":"text","page":25,"bbox":[85.74,319.85,533.15,369.13],"text":"Internet auction site or other similar transactions. Which of the following is the action that\ncorresponds to (5) in this figure? Here, (1) through (6) indicate the sequence of transactions,\nand each of the numbers from (3) to (6) corresponds to an action in a) through d)."},{"type":"table","page":25,"bbox":[165.54,400.02,386.88,521.88],"rows":[["Escrow service company\n(3) (2) Paym\nfor p\n(6) (5)\n(4)\nSeller Buyer\n(1) Agreement of sale",null,null,null],["Seller",null,null,"Buyer"],[null,"","",null],[null,"(1) Agreement of sale",null,null]]},{"type":"text","page":25,"bbox":[219.24,410.44,337.08,423.88],"text":"Escrow service company"},{"type":"text","page":25,"bbox":[199.74,441.34,213.56,454.78],"text":"(3)"},{"type":"text","page":25,"bbox":[228.9,441.82,421.79,474.88],"text":"(2) Payment\n      for purchase\n(5)\n(6)"},{"type":"text","page":25,"bbox":[272.34,480.52,286.22,493.96],"text":"(4)"},{"type":"text","page":25,"bbox":[176.82,497.92,376.39,511.36],"text":"Buyer\nSeller"},{"type":"text","page":25,"bbox":[224.04,509.2,327.13,522.64],"text":"(1) Agreement of sale"},{"type":"text","page":25,"bbox":[84.12,517.25,456.84,580.93],"text":"a) Notice of payment deposit\nb) Notice of product receipt\nc) Shipment of product\nd) Transfer of payment"},{"type":"code","page":25,"bbox":[65.22,794.63,314.58,808.39],"text":"– 25 –"},{"type":"text","page":26,"bbox":[65.22,67.74,419.5,81.19],"text":"Q73.\nWhich of the following is an appropriate explanation of HEMS?"},{"type":"text","page":26,"bbox":[84.12,86.93,527.06,118.21],"text":"a) It is a system that connects multiple home appliances through a network to visualize the"},{"type":"text","page":26,"bbox":[84.12,122.93,521.77,154.21],"text":"power and perform optimum control of power consumption.\nb) It is a system that converts the electricity produced by a solar power generation system"},{"type":"text","page":26,"bbox":[84.12,158.93,506.34,190.21],"text":"and a residential-use fuel cell for the electricity to be useable in households, etc.\nc) It is a system that recycles the useful parts of home appliances discarded by general"},{"type":"text","page":26,"bbox":[84.12,194.93,515.03,244.21],"text":"households and offices to reduce the amount of waste materials and promote the\neffective use of resources.\nd) It is an electric hot water supply system that generates a considerable quantity of heat"},{"type":"text","page":26,"bbox":[102.12,248.93,408.35,262.21],"text":"with a relatively small amount of energy by using a heat pump."},{"type":"text","page":26,"bbox":[65.22,301.74,533.14,315.19],"text":"Q74. When real-time systems are classified into hard real-time and soft real-time systems, which"},{"type":"text","page":26,"bbox":[85.74,319.85,387.9,333.13],"text":"of the following is in the category of a hard real-time system?"},{"type":"text","page":26,"bbox":[65.22,358.91,533.19,443.17],"text":"a) Airbag control system\nb) Bank ATM system\nc) Seat reservation system\nd) Web delivery system\n\n\nQ75. Which of the following is an organizational structure of a corporation that is temporarily"},{"type":"text","page":26,"bbox":[65.22,447.83,533.15,496.2],"text":"structured by specialists from each department to reach a specific goal over a limited period\nand operates independently from all other standing organizations?"},{"type":"text","page":26,"bbox":[84.12,502.91,479.74,534.19],"text":"a) Company system organization\nb) Divisional system organization\nc) Functional organization\nd) Project organization"},{"type":"text","page":26,"bbox":[65.22,573.72,533.15,587.17],"text":"Q76. There are several quality control tools that have been used primarily for manufacturing"},{"type":"text","page":26,"bbox":[85.74,591.83,533.13,641.11],"text":"and inspection departments. Which of the following is a combined graph containing a bar\ngraph that shows the numeric values of individual items in descending order, and a line graph\nthat shows the cumulative total of the composition ratios of these numeric values?"},{"type":"text","page":26,"bbox":[65.22,664.91,406.09,731.11],"text":"a) Control chart\nb) Histogram\nc) Pareto chart\nd) Scatter diagram"},{"type":"code","page":26,"bbox":[65.22,794.63,314.58,808.39],"text":"– 26 –"},{"type":"text","page":27,"bbox":[65.22,67.74,533.21,81.19],"text":"Q77. In a sampling inspection, which of the following can be used to ascertain the probability"},{"type":"text","page":27,"bbox":[85.74,85.85,339.96,99.13],"text":"of acceptance of a lot with a certain defective ratio?"},{"type":"text","page":27,"bbox":[70.5,124.91,533.14,209.17],"text":"a) Bathtub curve\nb) Gompertz curve\nc) Logistic curve\nd) OC curve\n\n\nQ78. Which of following is an expression for calculating the cost of goods sold (or cost of sales)"},{"type":"text","page":27,"bbox":[65.22,213.83,231.59,245.11],"text":"of a manufacturing company?"},{"type":"text","page":27,"bbox":[84.12,250.74,500.47,264.19],"text":"a) Material cost in current period + Labor cost in current period + Expense in current"},{"type":"text","page":27,"bbox":[84.12,268.91,529.1,300.19],"text":"period\nb) Product inventory at beginning of period + Product manufacturing cost in current period"},{"type":"text","page":27,"bbox":[84.12,304.91,529.11,336.19],"text":"− Product inventory at end of period\nc) Product inventory at beginning of period + Product manufacturing cost in current period"},{"type":"text","page":27,"bbox":[84.12,340.91,499.96,372.19],"text":"− Work in process inventory at end of period\nd) Work in process inventory at beginning of period + Product manufacturing cost in"},{"type":"text","page":27,"bbox":[65.22,376.91,527.46,479.11],"text":"current period − work in process inventory at end of period\n\n\nQ79.\nThe break-even point (BEP) is a level where total cost and total revenue are equal. The\ntable below lists the fixed cost, variable cost per unit, price per unit, and BEP in units.\nWhich of the following is a value of the price per unit?"},{"type":"table","page":27,"bbox":[128.95,517.32,330.65,591.41],"rows":[["Fixed cost ($)",null,null,"100,000",null,null],["Variable cost per unit ($)",null,null,"2",null,null],["Price per unit ($)",null,null,"",null,null],["","BEP in units","","","10,000",""]]},{"type":"text","page":27,"bbox":[134.4,521.39,320.06,534.67],"text":"Fixed cost ($)\n100,000"},{"type":"text","page":27,"bbox":[134.4,539.93,322.9,553.21],"text":"Variable cost per unit ($)\n2"},{"type":"text","page":27,"bbox":[134.4,558.41,315.32,571.69],"text":"Price per unit ($)"},{"type":"text","page":27,"bbox":[134.4,576.89,327.36,590.17],"text":"BEP in units\n10,000"},{"type":"text","page":27,"bbox":[84.12,595.43,470.1,626.71],"text":"a) 4\nb) 8\nc) 12\nd) 16"},{"type":"text","page":27,"bbox":[65.22,649.78,533.14,679.69],"text":"Q80. Which of the following is the intellectual property right that does not require registration"},{"type":"text","page":27,"bbox":[85.74,684.35,430.37,697.63],"text":"for protection in the World Trade Organization (WTO) member states?"},{"type":"text","page":27,"bbox":[65.22,721.43,510.68,769.63],"text":"a) Copyright\nb) Industrial design\nc) Patent\nd) Trademark"},{"type":"code","page":27,"bbox":[65.22,794.63,314.58,808.39],"text":"– 27 –"}]'::jsonb,
  '["2021-april-a-q60-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Copyright"},{"label":"b","text":"Industrial design"},{"label":"c","text":"Patent"},{"label":"d","text":"Trademark\n\n – 27 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-A, Q60)',
  ARRAY[21,22,23,24,25,26,27]::int[],
  'native_text',
  '3.0',
  'Q60. When IT controls are classified into preventive controls and detective controls, which of
 the following is to be classified as a detective control?

 a) A data entry manual is created, and the persons in charge of data entry are trained.
 b) A data entry screen is designed so that operation errors are unlikely to occur.
 c) Access rights are assigned only to the person in charge of data entry.
 d) An output list resulting from data entry is cross-checked with the input form.

 – 21 –

Q61. Which of the following is an explanation of CRM?

 a) It is a business approach for significantly improving the efficiency of the entire supply
 chain through the real time exchange of information regarding production, inventory,
 procurement, sales, distribution, etc.
 b) It is a concept to optimize customer loyalty by sharing information throughout all
 customer channels within a company and improving customer satisfaction by raising the
 level of service.
 c) It is a method for improving business efficiency by planning and managing business
 resources throughout the company effectively and comprehensively.
 d) It is a method for wholesale dealers or manufacturers to increase business transactions
 with retail stores by supporting their business activities, and increasing their sales and
 profits.

Q62. Which of the following is an explanation of BPO?

 a) A company outsources all work processes of a specific department, such as management
 section or call center and its work system operation, to an external provider.
 b) A company reduces software development costs by using employees of a temporary
 employment agency with lower personnel expenses.
 c) A company rents a portion of the processing and storage capacities of servers owned by
 a telecommunications service provider and operates systems without owning its own
 servers.
 d) A company uses software functions provided by an external provider over a network
 without owning the software.

Q63. Which of the following is an appropriate description of chatbot?

 a) A software that uses image processing techniques and is employed for applications to
 describe image details to a human
 b) A software that uses natural language processing techniques and is employed for
 applications to communicate with a human
 c) A software that uses signal processing techniques and is employed for applications to
 convert a human’s voice into texts
 d) A software that uses speech processing techniques and is employed for applications to
 generate subtitles automatically for a human to read while watching videos

 – 22 –

Q64. Which of the following is a technique that performs the optimum resource allocation for
 computerization investment in each category classified by the similarities of risks and
 investment value?

 a) 3C analysis b) Benchmarking
 c) Enterprise architecture d) IT portfolio

Q65. In the verification of stakeholder requirements, which of the following indicates the ability
 to keep track of the process until the implementation of a change request?

 a) Interoperability b) Maintainability c) Traceability d) Usability

Q66. Which of the following is an explanation of core competence?

 a) The basic mindset and action guidelines behind management activities
 b) The business opportunities and threats in the environment around a company
 c) The management resources that form the source of competitive advantage over other
 companies
 d) The objectives to be achieved through the execution of a business strategy

Q67. In a product life cycle, which of the following is a stage where the withdrawal of some
 companies is observed when the demand peaks, and decision-making is necessary to
 determine whether it is possible to gain a strong foothold?

 a) Decline stage b) Growth stage
 c) Introduction stage d) Maturity stage

 – 23 –

Q68. When an IT vendor uses a “Balanced Scorecard” to promote a solution business, which of
 the following is an example of the learning and growth KPI goal? Here, “solution” means “to
 support a customer through information technology and professional services that are offered
 by experts so that the customer can achieve its management objectives.”

 a) To increase the number of customer proposals by a factor of 1.5 over that of the previous
 year by preparing an environment for reusing proposals to augment the number of
 registered solution cases
 b) To increase the sales volume in the consulting business for information strategy planning
 and system planning for it to account for 15% or more of the total sales of the company
 c) To set an average satisfaction score of 3.5 out of five (5) or more in a satisfaction
 survey of customers for whom a service is offered
 d) To train 30 employees as IT professionals in order to focus on the consulting services in
 the information strategy

Q69. Which of the following is an appropriate explanation of concurrent engineering?

 a) A new product development technique that sequentially executes processes, such as
 product design, manufacturing, and sales activities
 b) A technique that analyzes a target system and clarifies its specifications
 c) A technique that executes processes, such as product design and production planning, in
 parallel during the new product development procedure
 d) A technique that tries to figure out the optimal combination of functions and cost and to
 improve value through systematic procedures

Q70. Which of the following is the appropriate description of telemedicine?

 a) Caring for patients by using computer technologies when the physician and patients are
 physically together in a hospital
 b) Caring for patients by using electronic communication technologies when the physician
 and patients are not in the same location
 c) Caring for patients by using electronic communication technologies when the physician
 and patients are physically together at the patients’ house
 d) Caring for patients without using computer technologies when the physician and patients
 are physically together at the physician’s clinic

 – 24 –

Q71. The figure below shows the relationships among the components of product A, and the
 numbers in parentheses indicate the quantity of components necessary to produce one unit of
 the upper-level product or component. When 10 units of product A are produced, how many
 units of component C must be ordered? Here, there are presently five units of component C
 in the inventory.
 A

 B(2) C(1)

 D(1) E(1) C(1)

 a) 15 b) 20 c) 25 d) 30

Q72. The figure below shows the transaction model of an escrow service that is used in an
 Internet auction site or other similar transactions. Which of the following is the action that
 corresponds to (5) in this figure? Here, (1) through (6) indicate the sequence of transactions,
 and each of the numbers from (3) to (6) corresponds to an action in a) through d).

 Escrow service company

 (3) (2) Payment
 for purchase
 (6) (5)
 (4)
 Seller Buyer
 (1) Agreement of sale

 a) Notice of payment deposit b) Notice of product receipt
 c) Shipment of product d) Transfer of payment

 – 25 –

Q73. Which of the following is an appropriate explanation of HEMS?

 a) It is a system that connects multiple home appliances through a network to visualize the
 power and perform optimum control of power consumption.
 b) It is a system that converts the electricity produced by a solar power generation system
 and a residential-use fuel cell for the electricity to be useable in households, etc.
 c) It is a system that recycles the useful parts of home appliances discarded by general
 households and offices to reduce the amount of waste materials and promote the
 effective use of resources.
 d) It is an electric hot water supply system that generates a considerable quantity of heat
 with a relatively small amount of energy by using a heat pump.

Q74. When real-time systems are classified into hard real-time and soft real-time systems, which
 of the following is in the category of a hard real-time system?

 a) Airbag control system b) Bank ATM system
 c) Seat reservation system d) Web delivery system

Q75. Which of the following is an organizational structure of a corporation that is temporarily
 structured by specialists from each department to reach a specific goal over a limited period
 and operates independently from all other standing organizations?

 a) Company system organization b) Divisional system organization
 c) Functional organization d) Project organization

Q76. There are several quality control tools that have been used primarily for manufacturing
 and inspection departments. Which of the following is a combined graph containing a bar
 graph that shows the numeric values of individual items in descending order, and a line graph
 that shows the cumulative total of the composition ratios of these numeric values?

 a) Control chart b) Histogram
 c) Pareto chart d) Scatter diagram

 – 26 –

Q77. In a sampling inspection, which of the following can be used to ascertain the probability
 of acceptance of a lot with a certain defective ratio?

 a) Bathtub curve b) Gompertz curve
 c) Logistic curve d) OC curve

 Q78. Which of following is an expression for calculating the cost of goods sold (or cost of sales)
 of a manufacturing company?

 a) Material cost in current period + Labor cost in current period + Expense in current
 period
 b) Product inventory at beginning of period + Product manufacturing cost in current period
 − Product inventory at end of period
 c) Product inventory at beginning of period + Product manufacturing cost in current period
 − Work in process inventory at end of period
 d) Work in process inventory at beginning of period + Product manufacturing cost in
 current period − work in process inventory at end of period

Q79. The break-even point (BEP) is a level where total cost and total revenue are equal. The
 table below lists the fixed cost, variable cost per unit, price per unit, and BEP in units.
 Which of the following is a value of the price per unit?

 Fixed cost ($) 100,000
 Variable cost per unit ($) 2
 Price per unit ($)
 BEP in units 10,000

 a) 4 b) 8 c) 12 d) 16

Q80. Which of the following is the intellectual property right that does not require registration
 for protection in the World Trade Organization (WTO) member states?

 a) Copyright b) Industrial design c) Patent d) Trademark

 – 27 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/a/questions.pdf","pages":[21,22,23,24,25,26,27]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'B',
  1,
  'Q1. Read the following description of risks in information security, and then answer
 Subquestions 1 and 2.

Company S decides to define the assessment criteria and conduct a risk assessment of the
 company’s information assets to manage risks in the company’s information security by
 quantifying them. As a part of this decision, Mr. A is in charge of the risk assessment of
 server X and server Y.

[Calculation of values of risks]
 For each aspect, there are multiple threats and corresponding vulnerabilities. The risk values
 of information assets are calculated by the following formula:

Risk value = (Importance of information asset)
 × (Value of threat) × (Value of vulnerability)

[Criteria for determining the importance of information assets]
 Company S defines the evaluation criteria and values of the importance of information assets
 based on the risk assessment. Tables 1, 2 and 3 show the defined evaluation criteria and the
 values in terms of confidentiality, integrity, and availability, respectively.

Table 1 Evaluation criteria and values of confidentiality

Evaluation criteria Value
 Can be disclosed externally 1
 Can only be disclosed internally 2
 Can only be disclosed within the department 3
 Can only be disclosed to a minimum number of restricted entites 4

Table 2 Evaluation criteria and Table 3 Evaluation criteria and
 values of integrity values of availability

Evaluation criteria Value Evaluation criteria Value
 does not affect operations 1 24 hours / year 1
 Loss of Suspension of use has a slight impact on operations 2 5 hours / year 2
 information by non-regular
 has a significant impact 1 hour / year 3 integrity: 3 maintenance is
 on operations 10 minutes / year 4 permitted up to:
 1 minute / year 5

[Criteria for determining threats and vulnerabilities]
 Company S also defines the evaluation criteria and values of threats and vulnerabilities as
 shown in Tables 4 and 5 respectively.

- 3 -

Table 4 Evaluation criteria Table 5 Evaluation criteria
 and values of threats and values of vulnerabilities

Evaluation criteria Value Evaluation criteria Value
Low probability of occurrence 1 Appropriate controls and measures are in place 1
Moderate probability of occurrence 2 Some controls and measures are in place 2
High probability of occurrence 3 Inadequate controls and measures 3

[Server X and Server Y]
 Server X has a database of general supplier information. The general supplier information
 includes the supplier code, official name, abbreviation, address, and telephone number of
 the supplier.
 Server Y has a database of business transaction information. The business transaction
 information includes the supplier code, purchased product code, unit price, purchase history.

To evaluate the importance of servers X and Y in terms of confidentiality, integrity, and
 availability, Mr. A interviewed the related departments regarding the general supplier
 information and business transaction information, and summarized their responses.

[Responses of interview from the related departments]
 (1) General supplier information
 (i) General supplier information pertains to that published in telephone directories and
 on each supplier’s website. However, this information cannot be disclosed
 externally because Company S does not want its business relationship with some of
 the suppliers to be known by its competitors.
 (ii) The general supplier information is not used in EDI (Electronic Data Interchange)
 with the suppliers; hence, the impact on procurement operations is slight even if the
 information contains errors.
 (iii) Employees use general supplier information for checking telephone numbers or
 printing address labels for business letters. When server X is not available, the
 information can be obtained by alternate means.
 (2) Business transaction information
 (i) Business transaction information must not be known to competitors and competitive
 suppliers of Company S. Furthermore, the information cannot be disclosed to other
 departments even internally.
 (ii) Business transaction information errors have a considerable impact on operations
 including purchasing and payment.

- 4 -

(iii) Business transaction information is used for online entries in procurement during
 business hours and night time batch processing. The system that processes this
 information cannot have a downtime of 4 hours or more annually except for
 maintenance.

[Status of threats and vulnerabilities / Acceptable risk level]
 Mr. A investigates the threats to servers and the vulnerabilities of Company S against these
 threats. He assesses these threats and vulnerabilities based on the criteria as shown in Table
 4 and Table 5. The major threats and vulnerabilities are shown in Table 6.
 Company S defines acceptable risk levels as shown in Table 7. If the value of each risk of
 the information assets is less than or equal to the value shown in the table, the risk is retained;
 otherwise, measures to resolve the risk are implemented.

Table 6 Values of major threats and vulnerabilities Table 7 Acceptable
 of servers X and Y risk levels

Threat Vulnerability Confidentiality 13
 Type Value Type Value Integrity 15
 Virus infection 3 Anti-virus software not installed 3 Availability 10
 Unauthorized access 3 Inadequate access control 2
 Failure 2 Insufficient maintenance 3
 Spoofing 2 Inadequate password management 2
 Wiretapping 2 Latest recommended encryption not used 1

Table 8 Risk assessment of servers X and Y (excerpt)
 Information assets Threat Vulnerability Risk
 Importance
 Title Description Value Description Value Value
 Category Value

...
 Confidentiality Spoofing B D

...

Virus infection Antivirus software not installed 18
Server X
 Unauthorized access C 12
 Integrity
 Spoofing B 8

...
 Availability ...

...
 Confidentiality Unauthorized access C 18

...
Server Y
 Virus infection Antivirus software not installed 27
 Integrity
 ...
 Availability A ...

Note: The shaded parts are not shown. “...” indicates omission.

- 5 -

[Risk assessment of server X and server Y]
 Mr. A conducts a risk assessment of servers X and Y according to the criteria defined in
 Tables 1 to 5, the interview responses, and the status of servers X and Y. For the risk
 assessment in company S, the smallest value from the applicable criteria is selected from the
 assessment criteria defined in Tables 1 to 3.
 The partial assessment results are shown in Table 8.

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Table 8.

Answer group for A
 a) 1 b) 2 c) 3 d) 4 e) 5

Answer group for B and C
 a) Data loss due to data replication (backup) error
 b) Inadequate access control
 c) Inadequate capacity management (Availability)
 d) Inadequate password management
 e) Insufficient maintenance
 f) IT system error in batch processing (Integrity)

Answer group for D
 a) 4 b) 6 c) 8 d) 9 e) 12

Subquestion 2
 Concerning the area indicated by the dashed lines in the integrity section for server
 X in Table 8, from the answer group below, select the appropriate risk measure based on the
 acceptable risk levels of Company S.',
  '[{"type":"prompt","text":"Q1. Read the following description of risks in information security, and then answer\n Subquestions 1 and 2."},{"type":"context","text":"Company S decides to define the assessment criteria and conduct a risk assessment of the\n company’s information assets to manage risks in the company’s information security by\n quantifying them. As a part of this decision, Mr. A is in charge of the risk assessment of\n server X and server Y.\n\n[Calculation of values of risks]\n For each aspect, there are multiple threats and corresponding vulnerabilities. The risk values\n of information assets are calculated by the following formula:\n\nRisk value = (Importance of information asset)\n × (Value of threat) × (Value of vulnerability)\n\n[Criteria for determining the importance of information assets]\n Company S defines the evaluation criteria and values of the importance of information assets\n based on the risk assessment. Tables 1, 2 and 3 show the defined evaluation criteria and the\n values in terms of confidentiality, integrity, and availability, respectively.\n\nTable 1 Evaluation criteria and values of confidentiality\n\nEvaluation criteria Value\n Can be disclosed externally 1\n Can only be disclosed internally 2\n Can only be disclosed within the department 3\n Can only be disclosed to a minimum number of restricted entites 4\n\nTable 2 Evaluation criteria and Table 3 Evaluation criteria and\n values of integrity values of availability\n\nEvaluation criteria Value Evaluation criteria Value\n does not affect operations 1 24 hours / year 1\n Loss of Suspension of use has a slight impact on operations 2 5 hours / year 2\n information by non-regular\n has a significant impact 1 hour / year 3 integrity: 3 maintenance is\n on operations 10 minutes / year 4 permitted up to:\n 1 minute / year 5\n\n[Criteria for determining threats and vulnerabilities]\n Company S also defines the evaluation criteria and values of threats and vulnerabilities as\n shown in Tables 4 and 5 respectively.\n\n- 3 -\n\nTable 4 Evaluation criteria Table 5 Evaluation criteria\n and values of threats and values of vulnerabilities\n\nEvaluation criteria Value Evaluation criteria Value\nLow probability of occurrence 1 Appropriate controls and measures are in place 1\nModerate probability of occurrence 2 Some controls and measures are in place 2\nHigh probability of occurrence 3 Inadequate controls and measures 3\n\n[Server X and Server Y]\n Server X has a database of general supplier information. The general supplier information\n includes the supplier code, official name, abbreviation, address, and telephone number of\n the supplier.\n Server Y has a database of business transaction information. The business transaction\n information includes the supplier code, purchased product code, unit price, purchase history.\n\nTo evaluate the importance of servers X and Y in terms of confidentiality, integrity, and\n availability, Mr. A interviewed the related departments regarding the general supplier\n information and business transaction information, and summarized their responses.\n\n[Responses of interview from the related departments]\n (1) General supplier information\n (i) General supplier information pertains to that published in telephone directories and\n on each supplier’s website. However, this information cannot be disclosed\n externally because Company S does not want its business relationship with some of\n the suppliers to be known by its competitors.\n (ii) The general supplier information is not used in EDI (Electronic Data Interchange)\n with the suppliers; hence, the impact on procurement operations is slight even if the\n information contains errors.\n (iii) Employees use general supplier information for checking telephone numbers or\n printing address labels for business letters. When server X is not available, the\n information can be obtained by alternate means.\n (2) Business transaction information\n (i) Business transaction information must not be known to competitors and competitive\n suppliers of Company S. Furthermore, the information cannot be disclosed to other\n departments even internally.\n (ii) Business transaction information errors have a considerable impact on operations\n including purchasing and payment.\n\n- 4 -\n\n(iii) Business transaction information is used for online entries in procurement during\n business hours and night time batch processing. The system that processes this\n information cannot have a downtime of 4 hours or more annually except for\n maintenance.\n\n[Status of threats and vulnerabilities / Acceptable risk level]\n Mr. A investigates the threats to servers and the vulnerabilities of Company S against these\n threats. He assesses these threats and vulnerabilities based on the criteria as shown in Table\n 4 and Table 5. The major threats and vulnerabilities are shown in Table 6.\n Company S defines acceptable risk levels as shown in Table 7. If the value of each risk of\n the information assets is less than or equal to the value shown in the table, the risk is retained;\n otherwise, measures to resolve the risk are implemented.\n\nTable 6 Values of major threats and vulnerabilities Table 7 Acceptable\n of servers X and Y risk levels\n\nThreat Vulnerability Confidentiality 13\n Type Value Type Value Integrity 15\n Virus infection 3 Anti-virus software not installed 3 Availability 10\n Unauthorized access 3 Inadequate access control 2\n Failure 2 Insufficient maintenance 3\n Spoofing 2 Inadequate password management 2\n Wiretapping 2 Latest recommended encryption not used 1\n\nTable 8 Risk assessment of servers X and Y (excerpt)\n Information assets Threat Vulnerability Risk\n Importance\n Title Description Value Description Value Value\n Category Value\n\n...\n Confidentiality Spoofing B D\n\n...\n\nVirus infection Antivirus software not installed 18\nServer X\n Unauthorized access C 12\n Integrity\n Spoofing B 8\n\n...\n Availability ...\n\n...\n Confidentiality Unauthorized access C 18\n\n...\nServer Y\n Virus infection Antivirus software not installed 27\n Integrity\n ...\n Availability A ...\n\nNote: The shaded parts are not shown. “...” indicates omission.\n\n- 5 -\n\n[Risk assessment of server X and server Y]\n Mr. A conducts a risk assessment of servers X and Y according to the criteria defined in\n Tables 1 to 5, the interview responses, and the status of servers X and Y. For the risk\n assessment in company S, the smallest value from the applicable criteria is selected from the\n assessment criteria defined in Tables 1 to 3.\n The partial assessment results are shown in Table 8.\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in Table 8.\n\nAnswer group for A\n a) 1 b) 2 c) 3 d) 4 e) 5\n\nAnswer group for B and C\n a) Data loss due to data replication (backup) error\n b) Inadequate access control\n c) Inadequate capacity management (Availability)\n d) Inadequate password management\n e) Insufficient maintenance\n f) IT system error in batch processing (Integrity)\n\nAnswer group for D\n a) 4 b) 6 c) 8 d) 9 e) 12\n\nSubquestion 2\n Concerning the area indicated by the dashed lines in the integrity section for server\n X in Table 8, from the answer group below, select the appropriate risk measure based on the\n acceptable risk levels of Company S."}]'::jsonb,
  '["2021-april-b-q01-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Increasing the frequency of periodic maintenance"},{"label":"b","text":"Installing antivirus software"},{"label":"c","text":"Installing IDS (Intrusion Detection System)"},{"label":"d","text":"Strengthening password management"},{"label":"e","text":"Using public key cryptography\n\n - 6 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "c"}, {"subquestion": 1, "blank": "B", "answer": "d"}, {"subquestion": 1, "blank": "C", "answer": "b"}, {"subquestion": 1, "blank": "D", "answer": "c"}, {"subquestion": 2, "blank": null, "answer": "b"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"c"},{"subquestion":1,"blank":"B","answer":"d"},{"subquestion":1,"blank":"C","answer":"b"},{"subquestion":1,"blank":"D","answer":"c"},{"subquestion":2,"blank":null,"answer":"b"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-B, Q1)',
  ARRAY[3,4,5,6]::int[],
  'native_text',
  '3.0',
  'Q1. Read the following description of risks in information security, and then answer
 Subquestions 1 and 2.

 Company S decides to define the assessment criteria and conduct a risk assessment of the
 company’s information assets to manage risks in the company’s information security by
 quantifying them. As a part of this decision, Mr. A is in charge of the risk assessment of
 server X and server Y.

 [Calculation of values of risks]
 For each aspect, there are multiple threats and corresponding vulnerabilities. The risk values
 of information assets are calculated by the following formula:

 Risk value = (Importance of information asset)
 × (Value of threat) × (Value of vulnerability)

 [Criteria for determining the importance of information assets]
 Company S defines the evaluation criteria and values of the importance of information assets
 based on the risk assessment. Tables 1, 2 and 3 show the defined evaluation criteria and the
 values in terms of confidentiality, integrity, and availability, respectively.

 Table 1 Evaluation criteria and values of confidentiality

 Evaluation criteria Value
 Can be disclosed externally 1
 Can only be disclosed internally 2
 Can only be disclosed within the department 3
 Can only be disclosed to a minimum number of restricted entites 4

 Table 2 Evaluation criteria and Table 3 Evaluation criteria and
 values of integrity values of availability

 Evaluation criteria Value Evaluation criteria Value
 does not affect operations 1 24 hours / year 1
 Loss of Suspension of use has a slight impact on operations 2 5 hours / year 2
 information by non-regular
 has a significant impact 1 hour / year 3 integrity: 3 maintenance is
 on operations 10 minutes / year 4 permitted up to:
 1 minute / year 5

 [Criteria for determining threats and vulnerabilities]
 Company S also defines the evaluation criteria and values of threats and vulnerabilities as
 shown in Tables 4 and 5 respectively.

 - 3 -

Table 4 Evaluation criteria Table 5 Evaluation criteria
 and values of threats and values of vulnerabilities

Evaluation criteria Value Evaluation criteria Value
Low probability of occurrence 1 Appropriate controls and measures are in place 1
Moderate probability of occurrence 2 Some controls and measures are in place 2
High probability of occurrence 3 Inadequate controls and measures 3

 [Server X and Server Y]
 Server X has a database of general supplier information. The general supplier information
 includes the supplier code, official name, abbreviation, address, and telephone number of
 the supplier.
 Server Y has a database of business transaction information. The business transaction
 information includes the supplier code, purchased product code, unit price, purchase history.

 To evaluate the importance of servers X and Y in terms of confidentiality, integrity, and
 availability, Mr. A interviewed the related departments regarding the general supplier
 information and business transaction information, and summarized their responses.

 [Responses of interview from the related departments]
 (1) General supplier information
 (i) General supplier information pertains to that published in telephone directories and
 on each supplier’s website. However, this information cannot be disclosed
 externally because Company S does not want its business relationship with some of
 the suppliers to be known by its competitors.
 (ii) The general supplier information is not used in EDI (Electronic Data Interchange)
 with the suppliers; hence, the impact on procurement operations is slight even if the
 information contains errors.
 (iii) Employees use general supplier information for checking telephone numbers or
 printing address labels for business letters. When server X is not available, the
 information can be obtained by alternate means.
 (2) Business transaction information
 (i) Business transaction information must not be known to competitors and competitive
 suppliers of Company S. Furthermore, the information cannot be disclosed to other
 departments even internally.
 (ii) Business transaction information errors have a considerable impact on operations
 including purchasing and payment.

 - 4 -

(iii) Business transaction information is used for online entries in procurement during
 business hours and night time batch processing. The system that processes this
 information cannot have a downtime of 4 hours or more annually except for
 maintenance.

 [Status of threats and vulnerabilities / Acceptable risk level]
 Mr. A investigates the threats to servers and the vulnerabilities of Company S against these
 threats. He assesses these threats and vulnerabilities based on the criteria as shown in Table
 4 and Table 5. The major threats and vulnerabilities are shown in Table 6.
 Company S defines acceptable risk levels as shown in Table 7. If the value of each risk of
 the information assets is less than or equal to the value shown in the table, the risk is retained;
 otherwise, measures to resolve the risk are implemented.

 Table 6 Values of major threats and vulnerabilities Table 7 Acceptable
 of servers X and Y risk levels

 Threat Vulnerability Confidentiality 13
 Type Value Type Value Integrity 15
 Virus infection 3 Anti-virus software not installed 3 Availability 10
 Unauthorized access 3 Inadequate access control 2
 Failure 2 Insufficient maintenance 3
 Spoofing 2 Inadequate password management 2
 Wiretapping 2 Latest recommended encryption not used 1

 Table 8 Risk assessment of servers X and Y (excerpt)
 Information assets Threat Vulnerability Risk
 Importance
 Title Description Value Description Value Value
 Category Value

 ...
 Confidentiality Spoofing B D

 ...

 Virus infection Antivirus software not installed 18
Server X
 Unauthorized access C 12
 Integrity
 Spoofing B 8

 ...
 Availability ...

 ...
 Confidentiality Unauthorized access C 18

 ...
Server Y
 Virus infection Antivirus software not installed 27
 Integrity
 ...
 Availability A ...

 Note: The shaded parts are not shown. “...” indicates omission.

 - 5 -

[Risk assessment of server X and server Y]
 Mr. A conducts a risk assessment of servers X and Y according to the criteria defined in
 Tables 1 to 5, the interview responses, and the status of servers X and Y. For the risk
 assessment in company S, the smallest value from the applicable criteria is selected from the
 assessment criteria defined in Tables 1 to 3.
 The partial assessment results are shown in Table 8.

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Table 8.

 Answer group for A
 a) 1 b) 2 c) 3 d) 4 e) 5

 Answer group for B and C
 a) Data loss due to data replication (backup) error
 b) Inadequate access control
 c) Inadequate capacity management (Availability)
 d) Inadequate password management
 e) Insufficient maintenance
 f) IT system error in batch processing (Integrity)

 Answer group for D
 a) 4 b) 6 c) 8 d) 9 e) 12

Subquestion 2
 Concerning the area indicated by the dashed lines in the integrity section for server
 X in Table 8, from the answer group below, select the appropriate risk measure based on the
 acceptable risk levels of Company S.

 Answer group
 a) Increasing the frequency of periodic maintenance
 b) Installing antivirus software
 c) Installing IDS (Intrusion Detection System)
 d) Strengthening password management
 e) Using public key cryptography

 - 6 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/b/questions.pdf","pages":[3,4,5,6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'B',
  2,
  'Q2. Read the following description of CPU scheduling, and then answer Subquestions 1 and
 2.

Modern multiprogramming-based operating systems allow more than one process to be
 loaded into the memory for execution. The loaded processes share the CPU via time
 scheduling. CPU scheduling handles the problem of deciding which processes in the ready
 queue are to be executed at each specific time unit. One of the basic methods uses the
 Shortest-Job-First (SJF) algorithm. In SJF, the process manager selects the process with the
 shortest estimated CPU burst time among the waiting processes. Here, scheduling is
 performed by examining the length of the CPU burst time of each process.

Several criteria are applied to evaluate the performance of scheduling algorithms.
 Table 1 shows the definitions of CPU burst time, waiting time, response time, arrival time,
 and turnaround time.

Table 1 Definitions of criteria used to evaluate scheduling algorithms

CPU burst time The amount of time required by a process for CPU execution.
 Waiting time The amount of time that a process spends waiting in the ready queue.
 Response time The amount of time from the submission of a request until the first
 response is produced.
 Arrival time The time at which a process enters the ready queue.
 Turnaround The interval from the time of process submission to the time of process
 time completion (i.e., the total of CPU burst time and waiting time).

Subquestion 1
 From the answer group below, select the correct answer to be inserted in the blank _______
 in Table 3.

There are four processes: P1, P2, P3, and P4. Table 2 shows the CPU burst time of each
 process. Assume that all processes enter the ready queue simultaneously at time 0, and that
 they are ready for execution.

Table 2 CPU burst time of each process

Process CPU burst time
 P1 6
 P2 8
 P3 7
 P4 3

- 7 -

Figure 1 shows the process executed on each time unit using the SJF algorithm. The process
 manager selects P4 as the process to start execution at time 0 because it has the shortest CPU
 burst time among the ready processes. Each time a process is completed, the process
 manager selects another process with the next shortest CPU burst time.

Time 0 3 9 16 24
 Process P4 P1 P3 P2

Figure 1 Process executed on each time unit using the SJF algorithm

Table 3 shows the execution results of the processes of Table 2 in SJF algorithm.

Table 3 Execution results of the processes in SJF algorithm

Process Waiting time Response time Turnaround time
 P1 3 3 9
 P2 A
 P3 9 9 16
 P4 0 0 3

Answer group for A

a) 6 6 8 b) 16 8 24

c) 16 16 8 d) 16 16 24

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following figures and tables.

If the arrival time varies for each process, the process manager has a chance to reconsider
 whether or not it should stop the current executing process and switch to the arriving one. A
 preemptive SJF algorithm preempts the current executing process when another process
 arrives and has shorter CPU burst time.

There are four other processes (P5, P6, P7, and P8). Table 4 shows the arrival time and CPU
 burst time of each process.

- 8 -

Table 4 Arrival time and CPU burst time of each process
 Process Arrival time CPU burst time
 P5 0 8
 P6 1 4
 P7 2 9
 P8 3 5

Figure 2 shows the process executed on each time unit using the preemptive SJF algorithm.
It denotes that P5 will be provided a CPU burst time first and P7 will be the last. Because
P6 has the shortest CPU burst time at its arrival time, it preempts the current process and is
allocated the CPU until its end of execution.

Time 0 17 26

Process B P7

Figure 2 Process executed on each time unit in preemptive SJF algorithm

Table 5 shows the execution results of the processes of Table 4 using the preemptive SJF
algorithm.

Table 5 Execution results of the processes using the preemptive SJF algorithm

Process Waiting time Response time Turnaround time
 P5 9 0 17
 P6 0 0 4
 P7 15 15 24
 P8 C

The non-preemptive SJF algorithm will allow the currently running process to finish its CPU
burst time. Subsequently, the process manager selects the shortest process in the queue for
the next execution. Figure 3 shows the process executed on each time unit using the nonpreemptive SJF algorithm. Unlike the preemptive SJF algorithm, the non-preemptive SJF
algorithm allows the current process to continue, even if another shorter process arrives
during its execution.

Time 0 17 26

Process D P7

Figure 3 Process executed on each time unit using the non-preemptive SJF algorithm

- 9 -

Table 6 shows the execution results of the processes of Table 4 using the non-preemptive
SJF algorithm.

Table 6 Execution results of the processes using the non-preemptive SJF algorithm

Process Waiting time Response time Turnaround time
 P5 0 0 8
 P6 7 7 11
 P7 15 15 24
 P8 E

Answer group for B and D

0 1 3 5 8 10 12 17

a) P5 P6 P8

b) P5 P8 P6

c) P5 P6 P5 P8

d) P5 P6 P8 P5

e) P5 P6 P8 P6 P5',
  '[{"type":"prompt","text":"Q2. Read the following description of CPU scheduling, and then answer Subquestions 1 and\n 2."},{"type":"context","text":"Modern multiprogramming-based operating systems allow more than one process to be\n loaded into the memory for execution. The loaded processes share the CPU via time\n scheduling. CPU scheduling handles the problem of deciding which processes in the ready\n queue are to be executed at each specific time unit. One of the basic methods uses the\n Shortest-Job-First (SJF) algorithm. In SJF, the process manager selects the process with the\n shortest estimated CPU burst time among the waiting processes. Here, scheduling is\n performed by examining the length of the CPU burst time of each process.\n\nSeveral criteria are applied to evaluate the performance of scheduling algorithms.\n Table 1 shows the definitions of CPU burst time, waiting time, response time, arrival time,\n and turnaround time.\n\nTable 1 Definitions of criteria used to evaluate scheduling algorithms\n\nCPU burst time The amount of time required by a process for CPU execution.\n Waiting time The amount of time that a process spends waiting in the ready queue.\n Response time The amount of time from the submission of a request until the first\n response is produced.\n Arrival time The time at which a process enters the ready queue.\n Turnaround The interval from the time of process submission to the time of process\n time completion (i.e., the total of CPU burst time and waiting time).\n\nSubquestion 1\n From the answer group below, select the correct answer to be inserted in the blank _______\n in Table 3.\n\nThere are four processes: P1, P2, P3, and P4. Table 2 shows the CPU burst time of each\n process. Assume that all processes enter the ready queue simultaneously at time 0, and that\n they are ready for execution.\n\nTable 2 CPU burst time of each process\n\nProcess CPU burst time\n P1 6\n P2 8\n P3 7\n P4 3\n\n- 7 -\n\nFigure 1 shows the process executed on each time unit using the SJF algorithm. The process\n manager selects P4 as the process to start execution at time 0 because it has the shortest CPU\n burst time among the ready processes. Each time a process is completed, the process\n manager selects another process with the next shortest CPU burst time.\n\nTime 0 3 9 16 24\n Process P4 P1 P3 P2\n\nFigure 1 Process executed on each time unit using the SJF algorithm\n\nTable 3 shows the execution results of the processes of Table 2 in SJF algorithm.\n\nTable 3 Execution results of the processes in SJF algorithm\n\nProcess Waiting time Response time Turnaround time\n P1 3 3 9\n P2 A\n P3 9 9 16\n P4 0 0 3\n\nAnswer group for A\n\na) 6 6 8 b) 16 8 24\n\nc) 16 16 8 d) 16 16 24\n\nSubquestion 2\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following figures and tables.\n\nIf the arrival time varies for each process, the process manager has a chance to reconsider\n whether or not it should stop the current executing process and switch to the arriving one. A\n preemptive SJF algorithm preempts the current executing process when another process\n arrives and has shorter CPU burst time.\n\nThere are four other processes (P5, P6, P7, and P8). Table 4 shows the arrival time and CPU\n burst time of each process.\n\n- 8 -\n\nTable 4 Arrival time and CPU burst time of each process\n Process Arrival time CPU burst time\n P5 0 8\n P6 1 4\n P7 2 9\n P8 3 5\n\nFigure 2 shows the process executed on each time unit using the preemptive SJF algorithm.\nIt denotes that P5 will be provided a CPU burst time first and P7 will be the last. Because\nP6 has the shortest CPU burst time at its arrival time, it preempts the current process and is\nallocated the CPU until its end of execution.\n\nTime 0 17 26\n\nProcess B P7\n\nFigure 2 Process executed on each time unit in preemptive SJF algorithm\n\nTable 5 shows the execution results of the processes of Table 4 using the preemptive SJF\nalgorithm.\n\nTable 5 Execution results of the processes using the preemptive SJF algorithm\n\nProcess Waiting time Response time Turnaround time\n P5 9 0 17\n P6 0 0 4\n P7 15 15 24\n P8 C\n\nThe non-preemptive SJF algorithm will allow the currently running process to finish its CPU\nburst time. Subsequently, the process manager selects the shortest process in the queue for\nthe next execution. Figure 3 shows the process executed on each time unit using the nonpreemptive SJF algorithm. Unlike the preemptive SJF algorithm, the non-preemptive SJF\nalgorithm allows the current process to continue, even if another shorter process arrives\nduring its execution.\n\nTime 0 17 26\n\nProcess D P7\n\nFigure 3 Process executed on each time unit using the non-preemptive SJF algorithm\n\n- 9 -\n\nTable 6 shows the execution results of the processes of Table 4 using the non-preemptive\nSJF algorithm.\n\nTable 6 Execution results of the processes using the non-preemptive SJF algorithm\n\nProcess Waiting time Response time Turnaround time\n P5 0 0 8\n P6 7 7 11\n P7 15 15 24\n P8 E\n\nAnswer group for B and D\n\n0 1 3 5 8 10 12 17\n\na) P5 P6 P8\n\nb) P5 P8 P6\n\nc) P5 P6 P5 P8\n\nd) P5 P6 P8 P5\n\ne) P5 P6 P8 P6 P5"}]'::jsonb,
  '["2021-april-b-q02-figure1.webp","2021-april-b-q02-figure2.webp","2021-april-b-q02-figure3.webp","2021-april-b-q02-figure4.webp"]'::jsonb,
  '[{"label":"a","text":"0 0 5"},{"label":"b","text":"2 2 7"},{"label":"c","text":"5 5 9"},{"label":"d","text":"9 9 14\n\n - 10 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "d"}, {"subquestion": 2, "blank": "B", "answer": "d"}, {"subquestion": 2, "blank": "C", "answer": "b"}, {"subquestion": 2, "blank": "D", "answer": "a"}, {"subquestion": 2, "blank": "E", "answer": "d"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"d"},{"subquestion":2,"blank":"B","answer":"d"},{"subquestion":2,"blank":"C","answer":"b"},{"subquestion":2,"blank":"D","answer":"a"},{"subquestion":2,"blank":"E","answer":"d"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-B, Q2)',
  ARRAY[7,8,9,10]::int[],
  'native_text',
  '3.0',
  'Q2. Read the following description of CPU scheduling, and then answer Subquestions 1 and
 2.

 Modern multiprogramming-based operating systems allow more than one process to be
 loaded into the memory for execution. The loaded processes share the CPU via time
 scheduling. CPU scheduling handles the problem of deciding which processes in the ready
 queue are to be executed at each specific time unit. One of the basic methods uses the
 Shortest-Job-First (SJF) algorithm. In SJF, the process manager selects the process with the
 shortest estimated CPU burst time among the waiting processes. Here, scheduling is
 performed by examining the length of the CPU burst time of each process.

 Several criteria are applied to evaluate the performance of scheduling algorithms.
 Table 1 shows the definitions of CPU burst time, waiting time, response time, arrival time,
 and turnaround time.

 Table 1 Definitions of criteria used to evaluate scheduling algorithms

 CPU burst time The amount of time required by a process for CPU execution.
 Waiting time The amount of time that a process spends waiting in the ready queue.
 Response time The amount of time from the submission of a request until the first
 response is produced.
 Arrival time The time at which a process enters the ready queue.
 Turnaround The interval from the time of process submission to the time of process
 time completion (i.e., the total of CPU burst time and waiting time).

Subquestion 1
 From the answer group below, select the correct answer to be inserted in the blank _______
 in Table 3.

 There are four processes: P1, P2, P3, and P4. Table 2 shows the CPU burst time of each
 process. Assume that all processes enter the ready queue simultaneously at time 0, and that
 they are ready for execution.

 Table 2 CPU burst time of each process

 Process CPU burst time
 P1 6
 P2 8
 P3 7
 P4 3

 - 7 -

Figure 1 shows the process executed on each time unit using the SJF algorithm. The process
 manager selects P4 as the process to start execution at time 0 because it has the shortest CPU
 burst time among the ready processes. Each time a process is completed, the process
 manager selects another process with the next shortest CPU burst time.

 Time 0 3 9 16 24
 Process P4 P1 P3 P2

 Figure 1 Process executed on each time unit using the SJF algorithm

 Table 3 shows the execution results of the processes of Table 2 in SJF algorithm.

 Table 3 Execution results of the processes in SJF algorithm

 Process Waiting time Response time Turnaround time
 P1 3 3 9
 P2 A
 P3 9 9 16
 P4 0 0 3

 Answer group for A

 a) 6 6 8 b) 16 8 24

 c) 16 16 8 d) 16 16 24

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following figures and tables.

 If the arrival time varies for each process, the process manager has a chance to reconsider
 whether or not it should stop the current executing process and switch to the arriving one. A
 preemptive SJF algorithm preempts the current executing process when another process
 arrives and has shorter CPU burst time.

 There are four other processes (P5, P6, P7, and P8). Table 4 shows the arrival time and CPU
 burst time of each process.

 - 8 -

Table 4 Arrival time and CPU burst time of each process
 Process Arrival time CPU burst time
 P5 0 8
 P6 1 4
 P7 2 9
 P8 3 5

Figure 2 shows the process executed on each time unit using the preemptive SJF algorithm.
It denotes that P5 will be provided a CPU burst time first and P7 will be the last. Because
P6 has the shortest CPU burst time at its arrival time, it preempts the current process and is
allocated the CPU until its end of execution.

 Time 0 17 26

 Process B P7

 Figure 2 Process executed on each time unit in preemptive SJF algorithm

Table 5 shows the execution results of the processes of Table 4 using the preemptive SJF
algorithm.

 Table 5 Execution results of the processes using the preemptive SJF algorithm

 Process Waiting time Response time Turnaround time
 P5 9 0 17
 P6 0 0 4
 P7 15 15 24
 P8 C

The non-preemptive SJF algorithm will allow the currently running process to finish its CPU
burst time. Subsequently, the process manager selects the shortest process in the queue for
the next execution. Figure 3 shows the process executed on each time unit using the nonpreemptive SJF algorithm. Unlike the preemptive SJF algorithm, the non-preemptive SJF
algorithm allows the current process to continue, even if another shorter process arrives
during its execution.

 Time 0 17 26

 Process D P7

 Figure 3 Process executed on each time unit using the non-preemptive SJF algorithm

 - 9 -

Table 6 shows the execution results of the processes of Table 4 using the non-preemptive
SJF algorithm.

 Table 6 Execution results of the processes using the non-preemptive SJF algorithm

 Process Waiting time Response time Turnaround time
 P5 0 0 8
 P6 7 7 11
 P7 15 15 24
 P8 E

Answer group for B and D

 0 1 3 5 8 10 12 17

 a) P5 P6 P8

 b) P5 P8 P6

 c) P5 P6 P5 P8

 d) P5 P6 P8 P5

 e) P5 P6 P8 P6 P5

Answer group for C and E

 a) 0 0 5 b) 2 2 7

 c) 5 5 9 d) 9 9 14

 - 10 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/b/questions.pdf","pages":[7,8,9,10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'B',
  3,
  'Q3. Read the following description of a database for order management, and then answer
 Subquestions 1 and 2.

Factory U, a furniture manufacturer, uses an order management database to manage the order
 status of materials, which are required for its production.
 When factory U orders materials, they usually arrive together as a single delivery. However,
 some arrive in two or more delivery batches. For example, if factory U orders 100 rubber
 cushions, 80 of these arrive earlier, and the remaining 20 arrive later.

The database consists of the following four tables; the table structure and sample data are
 shown for each table. The underline ---- indicates the primary key, and the dotted underline
 ____ indicates the foreign key.
 (1) Material Table
 The Material table contains the information regarding the materials that factory U can
 order.

MaterialNo MaterialName UnitPrice
 1 Plastic sheet 10
 2 Rubber cushion 15
 3 Wood board 12

(2) Order Table
 The Order table contains the information regarding each order date of materials.

OrderNo OrderDate
 1 2021-04-02
 2 2021-04-05
 3 2021-04-06

(3) OrderDetail Table
 The OrderDetail table contains the information regarding materials and their quantities
 that are included in each order.

OrderDetailNo OrderNo MaterialNo Quantity
 1 1 1 40
 2 1 2 20
 3 2 1 10
 4 2 3 30
 5 3 1 10

- 11 -

(4) Arrival Table
 The Arrival table contains the information regarding the arrival status of ordered materials.

ArrivalNo ArrivalDate ArrivalQuantity OrderDetailNo OrderNo
 1 2021-04-05 20 1 1
 2 2021-04-06 10 2 1
 3 2021-04-07 30 4 2
 4 2021-04-08 20 1 1
 5 2021-04-09 10 3 2

From the sample data shown above, the current arrival status by OrderDetailNo is as follows.
 A value in parentheses indicates the ordered quantity and the quantity that arrives.

OrderDetailNo Arrival status _
 1 (40) Completed by ArrivalNo 1 (20) and ArrivalNo 4 (20).
 2 (20) Partially completed by ArrivalNo 2 (10). Not arrived (10).
 3 (10) Completed by ArrivalNo 5 (10).
 4 (30) Completed by ArrivalNo 3 (30).
 5 (10) Not arrived (10).

Subquestion 1
 The following SQL statement SQL1 displays the total quantity of materials that are recorded
 in the OrderDetail table by material.

-- SQL1 --
 SELECT m.MaterialNo, m.MaterialName, d.TotalQuantity
 FROM (SELECT MaterialNo, MaterialName
 FROM Material) m,

(SELECT MaterialNo, SUM(Quantity) as TotalQuantity

FROM OrderDetail
 GROUP BY MaterialNo) d
 WHERE m.MaterialNo = d.MaterialNo

ORDER BY d.TotalQuantity

From the answer group below, select the correct output of SQL1, when SQL1 is executed
 using the sample data shown above.

- 12 -

Answer group
 a) MaterialNo MaterialName TotalQuantity
 1 Plastic sheet___ 60

b) MaterialNo MaterialName TotalQuantity
 1 Plastic sheet 60
 2 Rubber cushion 20
 3 Wood board 30

c) MaterialNo MaterialName TotalQuantity
 1 Plastic sheet 60
 3 Wood board 30
 2 Rubber cushion 20

d) MaterialNo MaterialName TotalQuantity
 2 Rubber cushion 20
 3 Wood board 30
 1 Plastic sheet 60

e) MaterialNo MaterialName TotalQuantity
 3 Wood board 30
 2 Rubber cushion 20
 1 Plastic sheet 60

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description and SQL statement SQL2.

Note:
 - LEFT JOIN returns all rows from the left table with matching rows in the right table.
 - In this question, the function ISNULL(exp, val) returns the value of exp if exp is not
 NULL; otherwise, it returns the value of val.

The following SQL statement SQL2 displays the arrival status of ordered materials by order
 number.

- 13 -

-- SQL2 --
 SELECT d.OrderNo, d.TotalQuantity,
 ISNULL( ***A*** ) AS ArrivalQuantity,
 (d.TotalQuantity - ISNULL( ***A*** )) AS NeedToArrival
 FROM (SELECT OrderNo, ***B***
 FROM OrderDetail
 GROUP BY OrderNo) d
 LEFT JOIN (SELECT OrderNo, ***C***
 FROM Arrival
 GROUP BY OrderNo) a
 ON d.OrderNo = a.OrderNo

From the sample data on the previous pages, SQL2 creates the following output. During this
process, when two tables (d and a) are LEFT JOIN-ed, the joined table has one row containing
NULL fields. The d.OrderNo of that row is ***D***.

OrderNo TotalQuantity ArrivalQuantity NeedToArrival
 1 60 50 10
 2 40 40 00
 3 10 00 10

Answer group for A
 a) a.ArrivalQuantity, 0
 b) a.ArrivalQuantity, d.TotalQuantity
 c) d.TotalQuantity, 0
 d) d.TotalQuantity, a.ArrivalQuantity

Answer group for B and C
 a) ArrivalQuantity
 b) COUNT(ArrivalQuantity) AS ArrivalQuantity
 c) COUNT(Quantity) AS TotalQuantity
 d) Quantity AS TotalQuantity
 e) SUM(ArrivalQuantity) AS ArrivalQuantity
 f) SUM(Quantity) AS TotalQuantity

Answer group for D
 a) 1 b) 2 c) 3

- 14 -',
  '[{"type":"prompt","text":"Q3. Read the following description of a database for order management, and then answer\n Subquestions 1 and 2."},{"type":"context","text":"Factory U, a furniture manufacturer, uses an order management database to manage the order\n status of materials, which are required for its production.\n When factory U orders materials, they usually arrive together as a single delivery. However,\n some arrive in two or more delivery batches. For example, if factory U orders 100 rubber\n cushions, 80 of these arrive earlier, and the remaining 20 arrive later.\n\nThe database consists of the following four tables; the table structure and sample data are\n shown for each table. The underline ---- indicates the primary key, and the dotted underline\n ____ indicates the foreign key.\n (1) Material Table\n The Material table contains the information regarding the materials that factory U can\n order.\n\nMaterialNo MaterialName UnitPrice\n 1 Plastic sheet 10\n 2 Rubber cushion 15\n 3 Wood board 12\n\n(2) Order Table\n The Order table contains the information regarding each order date of materials.\n\nOrderNo OrderDate\n 1 2021-04-02\n 2 2021-04-05\n 3 2021-04-06\n\n(3) OrderDetail Table\n The OrderDetail table contains the information regarding materials and their quantities\n that are included in each order.\n\nOrderDetailNo OrderNo MaterialNo Quantity\n 1 1 1 40\n 2 1 2 20\n 3 2 1 10\n 4 2 3 30\n 5 3 1 10\n\n- 11 -\n\n(4) Arrival Table\n The Arrival table contains the information regarding the arrival status of ordered materials.\n\nArrivalNo ArrivalDate ArrivalQuantity OrderDetailNo OrderNo\n 1 2021-04-05 20 1 1\n 2 2021-04-06 10 2 1\n 3 2021-04-07 30 4 2\n 4 2021-04-08 20 1 1\n 5 2021-04-09 10 3 2\n\nFrom the sample data shown above, the current arrival status by OrderDetailNo is as follows.\n A value in parentheses indicates the ordered quantity and the quantity that arrives.\n\nOrderDetailNo Arrival status _\n 1 (40) Completed by ArrivalNo 1 (20) and ArrivalNo 4 (20).\n 2 (20) Partially completed by ArrivalNo 2 (10). Not arrived (10).\n 3 (10) Completed by ArrivalNo 5 (10).\n 4 (30) Completed by ArrivalNo 3 (30).\n 5 (10) Not arrived (10).\n\nSubquestion 1\n The following SQL statement SQL1 displays the total quantity of materials that are recorded\n in the OrderDetail table by material.\n\n-- SQL1 --\n SELECT m.MaterialNo, m.MaterialName, d.TotalQuantity\n FROM (SELECT MaterialNo, MaterialName\n FROM Material) m,\n\n(SELECT MaterialNo, SUM(Quantity) as TotalQuantity\n\nFROM OrderDetail\n GROUP BY MaterialNo) d\n WHERE m.MaterialNo = d.MaterialNo\n\nORDER BY d.TotalQuantity\n\nFrom the answer group below, select the correct output of SQL1, when SQL1 is executed\n using the sample data shown above.\n\n- 12 -\n\nAnswer group\n a) MaterialNo MaterialName TotalQuantity\n 1 Plastic sheet___ 60\n\nb) MaterialNo MaterialName TotalQuantity\n 1 Plastic sheet 60\n 2 Rubber cushion 20\n 3 Wood board 30\n\nc) MaterialNo MaterialName TotalQuantity\n 1 Plastic sheet 60\n 3 Wood board 30\n 2 Rubber cushion 20\n\nd) MaterialNo MaterialName TotalQuantity\n 2 Rubber cushion 20\n 3 Wood board 30\n 1 Plastic sheet 60\n\ne) MaterialNo MaterialName TotalQuantity\n 3 Wood board 30\n 2 Rubber cushion 20\n 1 Plastic sheet 60\n\nSubquestion 2\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following description and SQL statement SQL2.\n\nNote:\n - LEFT JOIN returns all rows from the left table with matching rows in the right table.\n - In this question, the function ISNULL(exp, val) returns the value of exp if exp is not\n NULL; otherwise, it returns the value of val.\n\nThe following SQL statement SQL2 displays the arrival status of ordered materials by order\n number.\n\n- 13 -\n\n-- SQL2 --\n SELECT d.OrderNo, d.TotalQuantity,\n ISNULL( ***A*** ) AS ArrivalQuantity,\n (d.TotalQuantity - ISNULL( ***A*** )) AS NeedToArrival\n FROM (SELECT OrderNo, ***B***\n FROM OrderDetail\n GROUP BY OrderNo) d\n LEFT JOIN (SELECT OrderNo, ***C***\n FROM Arrival\n GROUP BY OrderNo) a\n ON d.OrderNo = a.OrderNo\n\nFrom the sample data on the previous pages, SQL2 creates the following output. During this\nprocess, when two tables (d and a) are LEFT JOIN-ed, the joined table has one row containing\nNULL fields. The d.OrderNo of that row is ***D***.\n\nOrderNo TotalQuantity ArrivalQuantity NeedToArrival\n 1 60 50 10\n 2 40 40 00\n 3 10 00 10\n\nAnswer group for A\n a) a.ArrivalQuantity, 0\n b) a.ArrivalQuantity, d.TotalQuantity\n c) d.TotalQuantity, 0\n d) d.TotalQuantity, a.ArrivalQuantity\n\nAnswer group for B and C\n a) ArrivalQuantity\n b) COUNT(ArrivalQuantity) AS ArrivalQuantity\n c) COUNT(Quantity) AS TotalQuantity\n d) Quantity AS TotalQuantity\n e) SUM(ArrivalQuantity) AS ArrivalQuantity\n f) SUM(Quantity) AS TotalQuantity\n\nAnswer group for D\n a) 1 b) 2 c) 3\n\n- 14 -"}]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"subquestion": 1, "blank": null, "answer": "d"}, {"subquestion": 2, "blank": "A", "answer": "a"}, {"subquestion": 2, "blank": "B", "answer": "f"}, {"subquestion": 2, "blank": "C", "answer": "e"}, {"subquestion": 2, "blank": "D", "answer": "c"}]',
  '{"parts":[{"subquestion":1,"blank":null,"answer":"d"},{"subquestion":2,"blank":"A","answer":"a"},{"subquestion":2,"blank":"B","answer":"f"},{"subquestion":2,"blank":"C","answer":"e"},{"subquestion":2,"blank":"D","answer":"c"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-B, Q3)',
  ARRAY[11,12,13,14]::int[],
  'native_text',
  '3.0',
  'Q3. Read the following description of a database for order management, and then answer
 Subquestions 1 and 2.

 Factory U, a furniture manufacturer, uses an order management database to manage the order
 status of materials, which are required for its production.
 When factory U orders materials, they usually arrive together as a single delivery. However,
 some arrive in two or more delivery batches. For example, if factory U orders 100 rubber
 cushions, 80 of these arrive earlier, and the remaining 20 arrive later.

 The database consists of the following four tables; the table structure and sample data are
 shown for each table. The underline ---- indicates the primary key, and the dotted underline
 ____ indicates the foreign key.
 (1) Material Table
 The Material table contains the information regarding the materials that factory U can
 order.

 MaterialNo MaterialName UnitPrice
 1 Plastic sheet 10
 2 Rubber cushion 15
 3 Wood board 12

 (2) Order Table
 The Order table contains the information regarding each order date of materials.

 OrderNo OrderDate
 1 2021-04-02
 2 2021-04-05
 3 2021-04-06

 (3) OrderDetail Table
 The OrderDetail table contains the information regarding materials and their quantities
 that are included in each order.

 OrderDetailNo OrderNo MaterialNo Quantity
 1 1 1 40
 2 1 2 20
 3 2 1 10
 4 2 3 30
 5 3 1 10

 - 11 -

(4) Arrival Table
 The Arrival table contains the information regarding the arrival status of ordered materials.

 ArrivalNo ArrivalDate ArrivalQuantity OrderDetailNo OrderNo
 1 2021-04-05 20 1 1
 2 2021-04-06 10 2 1
 3 2021-04-07 30 4 2
 4 2021-04-08 20 1 1
 5 2021-04-09 10 3 2

 From the sample data shown above, the current arrival status by OrderDetailNo is as follows.
 A value in parentheses indicates the ordered quantity and the quantity that arrives.

 OrderDetailNo Arrival status _
 1 (40) Completed by ArrivalNo 1 (20) and ArrivalNo 4 (20).
 2 (20) Partially completed by ArrivalNo 2 (10). Not arrived (10).
 3 (10) Completed by ArrivalNo 5 (10).
 4 (30) Completed by ArrivalNo 3 (30).
 5 (10) Not arrived (10).

Subquestion 1
 The following SQL statement SQL1 displays the total quantity of materials that are recorded
 in the OrderDetail table by material.

 -- SQL1 --
 SELECT m.MaterialNo, m.MaterialName, d.TotalQuantity
 FROM (SELECT MaterialNo, MaterialName
 FROM Material) m,

 (SELECT MaterialNo, SUM(Quantity) as TotalQuantity

 FROM OrderDetail
 GROUP BY MaterialNo) d
 WHERE m.MaterialNo = d.MaterialNo

 ORDER BY d.TotalQuantity

 From the answer group below, select the correct output of SQL1, when SQL1 is executed
 using the sample data shown above.

 - 12 -

Answer group
 a) MaterialNo MaterialName TotalQuantity
 1 Plastic sheet___ 60

 b) MaterialNo MaterialName TotalQuantity
 1 Plastic sheet 60
 2 Rubber cushion 20
 3 Wood board 30

 c) MaterialNo MaterialName TotalQuantity
 1 Plastic sheet 60
 3 Wood board 30
 2 Rubber cushion 20

 d) MaterialNo MaterialName TotalQuantity
 2 Rubber cushion 20
 3 Wood board 30
 1 Plastic sheet 60

 e) MaterialNo MaterialName TotalQuantity
 3 Wood board 30
 2 Rubber cushion 20
 1 Plastic sheet 60

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description and SQL statement SQL2.

 Note:
 - LEFT JOIN returns all rows from the left table with matching rows in the right table.
 - In this question, the function ISNULL(exp, val) returns the value of exp if exp is not
 NULL; otherwise, it returns the value of val.

 The following SQL statement SQL2 displays the arrival status of ordered materials by order
 number.

 - 13 -

-- SQL2 --
 SELECT d.OrderNo, d.TotalQuantity,
 ISNULL( _____A_____ ) AS ArrivalQuantity,
 (d.TotalQuantity - ISNULL( _____A_____ )) AS NeedToArrival
 FROM (SELECT OrderNo, _____B_____
 FROM OrderDetail
 GROUP BY OrderNo) d
 LEFT JOIN (SELECT OrderNo, _____C_____
 FROM Arrival
 GROUP BY OrderNo) a
 ON d.OrderNo = a.OrderNo

From the sample data on the previous pages, SQL2 creates the following output. During this
process, when two tables (d and a) are LEFT JOIN-ed, the joined table has one row containing
NULL fields. The d.OrderNo of that row is _____D_____.

 OrderNo TotalQuantity ArrivalQuantity NeedToArrival
 1 60 50 10
 2 40 40 00
 3 10 00 10

Answer group for A
 a) a.ArrivalQuantity, 0
 b) a.ArrivalQuantity, d.TotalQuantity
 c) d.TotalQuantity, 0
 d) d.TotalQuantity, a.ArrivalQuantity

Answer group for B and C
 a) ArrivalQuantity
 b) COUNT(ArrivalQuantity) AS ArrivalQuantity
 c) COUNT(Quantity) AS TotalQuantity
 d) Quantity AS TotalQuantity
 e) SUM(ArrivalQuantity) AS ArrivalQuantity
 f) SUM(Quantity) AS TotalQuantity

Answer group for D
 a) 1 b) 2 c) 3

 - 14 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/b/questions.pdf","pages":[11,12,13,14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'B',
  4,
  'Q4. Read the following description of a network installation for company V, and then answer
 Subquestions 1 through 3.

Company V designs the internal network infrastructure with variable length subnet mask
 network address scheme (different segments of networks) using private IP addresses
 (10.1.1.0/24 and 172.16.100.0/24). These network segments are connected to each other
 using Core Router (CR), Router 1 (R1), and Router 2 (R2). An administrator planned the IP
 address scheme of company V according to Table 1. The Network Address Translation
 function is placed at CR to access the Internet from the internal network.
 The design of company V’s internal network is shown in Figure 1.

The Internet

203.0.113.0/30

e2

e1 e0
 CR
 10.1.1.0/30 172.16.100.0/30

10.1.1.128/25 e1 e0 172.16.100.128/25
 e2 e0 e1 e2

172.16.100.4/30
 R1 R2

PC1 PC2 PC3 FS1 PC4 PC5 PC6 FS2
 Product Department Sales Department

Figure 1 Company V’s internal network

Table1 Addressing scheme of company V

Device Interface IP Address Subnet Mask
 Core Router e0 172.16.100.1 255.255.255.252
 e1 10.1.1.1 255.255.255.252
 e2 203.0.113.2 255.255.255.252
 Router 1 e0 172.16.100.5 255.255.255.252
 e1 10.1.1.2 255.255.255.252
 e2 10.1.1.129 255.255.255.128
 Router 2 e0 172.16.100.2 255.255.255.252
 e1 172.16.100.6 255.255.255.252
 e2 172.16.100.129 255.255.255.128

- 15 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following tables.

The administrator assigned the IP addresses and configured static routing protocol on each
 router to get connection between R1’s LAN, R2’s LAN and the Internet. After completing
 the network configuration, the administrator starts to test the connection among the three
 routers. He used “ping” commands at the command prompt on PC1, PC2, PC4 and PC5 to
 ping to an address on the Internet; all the “ping” commands are successful. Tables 2, 3 and
 4 show the routing information of the routers. Note that “any/any” for “Destination Network”
 means a default gateway.

Table 2 Routing Information of CR

Destination Network Interface Next hop/GW
 172.16.100.0/30 e0 ***A***
 172.16.100.128/25 e0 172.16.100.2
 10.1.1.0/30 e1 directly connected
 10.1.1.128/25 e1 10.1.1.2
 203.0.113.0/30 e2 directly connected
 any/any e2 203.0.113.1

Table 3 Routing Information of R1

Destination Network Interface Next hop/GW
 172.16.100.4/30 e0 directly connected
 172.16.100.128/25 e0 ***B***
 any/any e1 10.1.1.1
 10.1.1.0/30 e1 directly connected
 10.1.1.128/25 e2 directly connected

Table 4 Routing Information of R2

Destination Network Interface Next _hop/GW
 172.16.100.0/30 e0 directly connected
 ***C*** e0 172.16.100.1
 10.1.1.128/25 e1 172.16.100.5
 172.16.100.4/30 e1 directly connected
 172.16.100.128/25 e2 directly connected

Answer group for A and B
 a) 10.1.1.0 b) 10.1.1.1 c) 10.1.1.2
 d) 172.16.100.0 e) 172.16.100.1 f) 172.16.100.2
 g) 172.16.100.5 h) 172.16.100.6 i) directly connected

- 16 -

Answer group for C
 a) 10.1.1.0/30 b) 10.1.1.128/25 c) 172.16.100.0/30
 d) 172.16.100.4/30 e) 172.16.100.128/25 f) 203.0.113.0/30
 g) any/any

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following description.

After the setup, all hosts from R1’s LAN and R2’s LAN can access the Internet and also
 share their resources with each other except for PC3. The administrator checked the status
 of PC3 and found that it was not able to connect to a wired network. Pinging the loopback
 address is successful, but the gateway cannot be reached. On the network switch, all the
 interface lights are on except for the interface connected to PC3. The LED on the network
 card of PC3 is off. The port of the switch connected to PC3 is operational when the other
 PCs are connected. He considers that ***D*** is the most likely cause of this problem,
 and resolved this problem successfully.

Answer group for D
 a) the gateway requires fixing
 b) the Internet connection is down
 c) the network cable is faulty
 d) the network switch is faulty
 e) the PC has an incorrect IP address for the DNS server

Subquestion 3
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

The administrator is configuring the firewall functions on the three routers to satisfy the
 following two requirements:
 (1) File server FS1 in the product department should be accessible from both the product
 department and sales department. Meanwhile, file server FS2 in the sales department
 must be accessible only from the sales department to protect customer information. Each
 file server provides its service with SMB protocol.
 (2) The administrator manages the entire network. He accesses the network from his laptop
 using SSH (remote login protocol). He usually works in the product department office,
 and occasionally works in the sales department office as well.

- 17 -

Tables 5, 6 and 7 show the firewall rules on routers CR, R1 and R2.
When the firewall function receives a packet, it scans the rule table in order from top to
bottom. When it finds a rule that matches the conditions, it terminates the scan and applies
that rule to the packet. Note that because this firewall function understands the TCP stream,
the related packets that have been allowed once (e.g., packets from the same TCP session)
remain allowed even if there is no explicit rule. In addition, the packets from each router
itself are implicitly allowed.

After the setup, he received a complaint from one of the employees claiming that the firewall
does not seem to be working. He found the misconfigured rule on the rule table of
***E***, and then he ***F***.

Table 5 Firewall rule table of CR

Rule No Source Destination Destination Service Action
 1 10.1.1.128/25 any any Allow
 2 172.16.100.128/25 any any Allow
 3 any any any Deny

Table 6 Firewall rule table of R1

Rule No Source Destination Destination Service Action
 1 172.16.100.128/25 FS1 SMB/tcp Allow
 2 172.16.100.128/25 10.1.1.128/25 SSH/tcp Allow
 3 10.1.1.128/25 any any Allow
 4 any any any Deny

Table 7 Firewall rule table of R2

Rule No Source Destination Destination Service Action
 1 10.1.1.128/25 FS2 SMB/tcp Allow
 2 10.1.1.128/25 172.16.100.128/25 SSH/tcp Allow
 3 172.16.100.128/25 any any Allow
 4 any any any Deny

Answer group for E
 a) CR b) R1 c) R2',
  '[{"type":"prompt","text":"Q4. Read the following description of a network installation for company V, and then answer\n Subquestions 1 through 3."},{"type":"context","text":"Company V designs the internal network infrastructure with variable length subnet mask\n network address scheme (different segments of networks) using private IP addresses\n (10.1.1.0/24 and 172.16.100.0/24). These network segments are connected to each other\n using Core Router (CR), Router 1 (R1), and Router 2 (R2). An administrator planned the IP\n address scheme of company V according to Table 1. The Network Address Translation\n function is placed at CR to access the Internet from the internal network.\n The design of company V’s internal network is shown in Figure 1.\n\nThe Internet\n\n203.0.113.0/30\n\ne2\n\ne1 e0\n CR\n 10.1.1.0/30 172.16.100.0/30\n\n10.1.1.128/25 e1 e0 172.16.100.128/25\n e2 e0 e1 e2\n\n172.16.100.4/30\n R1 R2\n\nPC1 PC2 PC3 FS1 PC4 PC5 PC6 FS2\n Product Department Sales Department\n\nFigure 1 Company V’s internal network\n\nTable1 Addressing scheme of company V\n\nDevice Interface IP Address Subnet Mask\n Core Router e0 172.16.100.1 255.255.255.252\n e1 10.1.1.1 255.255.255.252\n e2 203.0.113.2 255.255.255.252\n Router 1 e0 172.16.100.5 255.255.255.252\n e1 10.1.1.2 255.255.255.252\n e2 10.1.1.129 255.255.255.128\n Router 2 e0 172.16.100.2 255.255.255.252\n e1 172.16.100.6 255.255.255.252\n e2 172.16.100.129 255.255.255.128\n\n- 15 -\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following tables.\n\nThe administrator assigned the IP addresses and configured static routing protocol on each\n router to get connection between R1’s LAN, R2’s LAN and the Internet. After completing\n the network configuration, the administrator starts to test the connection among the three\n routers. He used “ping” commands at the command prompt on PC1, PC2, PC4 and PC5 to\n ping to an address on the Internet; all the “ping” commands are successful. Tables 2, 3 and\n 4 show the routing information of the routers. Note that “any/any” for “Destination Network”\n means a default gateway.\n\nTable 2 Routing Information of CR\n\nDestination Network Interface Next hop/GW\n 172.16.100.0/30 e0 ***A***\n 172.16.100.128/25 e0 172.16.100.2\n 10.1.1.0/30 e1 directly connected\n 10.1.1.128/25 e1 10.1.1.2\n 203.0.113.0/30 e2 directly connected\n any/any e2 203.0.113.1\n\nTable 3 Routing Information of R1\n\nDestination Network Interface Next hop/GW\n 172.16.100.4/30 e0 directly connected\n 172.16.100.128/25 e0 ***B***\n any/any e1 10.1.1.1\n 10.1.1.0/30 e1 directly connected\n 10.1.1.128/25 e2 directly connected\n\nTable 4 Routing Information of R2\n\nDestination Network Interface Next _hop/GW\n 172.16.100.0/30 e0 directly connected\n ***C*** e0 172.16.100.1\n 10.1.1.128/25 e1 172.16.100.5\n 172.16.100.4/30 e1 directly connected\n 172.16.100.128/25 e2 directly connected\n\nAnswer group for A and B\n a) 10.1.1.0 b) 10.1.1.1 c) 10.1.1.2\n d) 172.16.100.0 e) 172.16.100.1 f) 172.16.100.2\n g) 172.16.100.5 h) 172.16.100.6 i) directly connected\n\n- 16 -\n\nAnswer group for C\n a) 10.1.1.0/30 b) 10.1.1.128/25 c) 172.16.100.0/30\n d) 172.16.100.4/30 e) 172.16.100.128/25 f) 203.0.113.0/30\n g) any/any\n\nSubquestion 2\n From the answer group below, select the correct answer to be inserted in the blank _______\n in the following description.\n\nAfter the setup, all hosts from R1’s LAN and R2’s LAN can access the Internet and also\n share their resources with each other except for PC3. The administrator checked the status\n of PC3 and found that it was not able to connect to a wired network. Pinging the loopback\n address is successful, but the gateway cannot be reached. On the network switch, all the\n interface lights are on except for the interface connected to PC3. The LED on the network\n card of PC3 is off. The port of the switch connected to PC3 is operational when the other\n PCs are connected. He considers that ***D*** is the most likely cause of this problem,\n and resolved this problem successfully.\n\nAnswer group for D\n a) the gateway requires fixing\n b) the Internet connection is down\n c) the network cable is faulty\n d) the network switch is faulty\n e) the PC has an incorrect IP address for the DNS server\n\nSubquestion 3\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following description.\n\nThe administrator is configuring the firewall functions on the three routers to satisfy the\n following two requirements:\n (1) File server FS1 in the product department should be accessible from both the product\n department and sales department. Meanwhile, file server FS2 in the sales department\n must be accessible only from the sales department to protect customer information. Each\n file server provides its service with SMB protocol.\n (2) The administrator manages the entire network. He accesses the network from his laptop\n using SSH (remote login protocol). He usually works in the product department office,\n and occasionally works in the sales department office as well.\n\n- 17 -\n\nTables 5, 6 and 7 show the firewall rules on routers CR, R1 and R2.\nWhen the firewall function receives a packet, it scans the rule table in order from top to\nbottom. When it finds a rule that matches the conditions, it terminates the scan and applies\nthat rule to the packet. Note that because this firewall function understands the TCP stream,\nthe related packets that have been allowed once (e.g., packets from the same TCP session)\nremain allowed even if there is no explicit rule. In addition, the packets from each router\nitself are implicitly allowed.\n\nAfter the setup, he received a complaint from one of the employees claiming that the firewall\ndoes not seem to be working. He found the misconfigured rule on the rule table of\n***E***, and then he ***F***.\n\nTable 5 Firewall rule table of CR\n\nRule No Source Destination Destination Service Action\n 1 10.1.1.128/25 any any Allow\n 2 172.16.100.128/25 any any Allow\n 3 any any any Deny\n\nTable 6 Firewall rule table of R1\n\nRule No Source Destination Destination Service Action\n 1 172.16.100.128/25 FS1 SMB/tcp Allow\n 2 172.16.100.128/25 10.1.1.128/25 SSH/tcp Allow\n 3 10.1.1.128/25 any any Allow\n 4 any any any Deny\n\nTable 7 Firewall rule table of R2\n\nRule No Source Destination Destination Service Action\n 1 10.1.1.128/25 FS2 SMB/tcp Allow\n 2 10.1.1.128/25 172.16.100.128/25 SSH/tcp Allow\n 3 172.16.100.128/25 any any Allow\n 4 any any any Deny\n\nAnswer group for E\n a) CR b) R1 c) R2"}]'::jsonb,
  '["2021-april-b-q04-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"moved it to the top of the table"},{"label":"b","text":"removed it"},{"label":"c","text":"swapped it for the rule just above it"},{"label":"d","text":"swapped it for the rule just below it\n\n - 18 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "i"}, {"subquestion": 1, "blank": "B", "answer": "h"}, {"subquestion": 1, "blank": "C", "answer": "g"}, {"subquestion": 2, "blank": "D", "answer": "c"}, {"subquestion": 3, "blank": "E", "answer": "c"}, {"subquestion": 3, "blank": "F", "answer": "b"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"i"},{"subquestion":1,"blank":"B","answer":"h"},{"subquestion":1,"blank":"C","answer":"g"},{"subquestion":2,"blank":"D","answer":"c"},{"subquestion":3,"blank":"E","answer":"c"},{"subquestion":3,"blank":"F","answer":"b"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-B, Q4)',
  ARRAY[15,16,17,18]::int[],
  'native_text',
  '3.0',
  'Q4. Read the following description of a network installation for company V, and then answer
 Subquestions 1 through 3.

 Company V designs the internal network infrastructure with variable length subnet mask
 network address scheme (different segments of networks) using private IP addresses
 (10.1.1.0/24 and 172.16.100.0/24). These network segments are connected to each other
 using Core Router (CR), Router 1 (R1), and Router 2 (R2). An administrator planned the IP
 address scheme of company V according to Table 1. The Network Address Translation
 function is placed at CR to access the Internet from the internal network.
 The design of company V’s internal network is shown in Figure 1.

 The Internet

 203.0.113.0/30

 e2

 e1 e0
 CR
 10.1.1.0/30 172.16.100.0/30

 10.1.1.128/25 e1 e0 172.16.100.128/25
 e2 e0 e1 e2

 172.16.100.4/30
 R1 R2

 PC1 PC2 PC3 FS1 PC4 PC5 PC6 FS2
 Product Department Sales Department

 Figure 1 Company V’s internal network

 Table1 Addressing scheme of company V

 Device Interface IP Address Subnet Mask
 Core Router e0 172.16.100.1 255.255.255.252
 e1 10.1.1.1 255.255.255.252
 e2 203.0.113.2 255.255.255.252
 Router 1 e0 172.16.100.5 255.255.255.252
 e1 10.1.1.2 255.255.255.252
 e2 10.1.1.129 255.255.255.128
 Router 2 e0 172.16.100.2 255.255.255.252
 e1 172.16.100.6 255.255.255.252
 e2 172.16.100.129 255.255.255.128

 - 15 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following tables.

 The administrator assigned the IP addresses and configured static routing protocol on each
 router to get connection between R1’s LAN, R2’s LAN and the Internet. After completing
 the network configuration, the administrator starts to test the connection among the three
 routers. He used “ping” commands at the command prompt on PC1, PC2, PC4 and PC5 to
 ping to an address on the Internet; all the “ping” commands are successful. Tables 2, 3 and
 4 show the routing information of the routers. Note that “any/any” for “Destination Network”
 means a default gateway.

 Table 2 Routing Information of CR

 Destination Network Interface Next hop/GW
 172.16.100.0/30 e0 ___A___
 172.16.100.128/25 e0 172.16.100.2
 10.1.1.0/30 e1 directly connected
 10.1.1.128/25 e1 10.1.1.2
 203.0.113.0/30 e2 directly connected
 any/any e2 203.0.113.1

 Table 3 Routing Information of R1

 Destination Network Interface Next hop/GW
 172.16.100.4/30 e0 directly connected
 172.16.100.128/25 e0 ___B___
 any/any e1 10.1.1.1
 10.1.1.0/30 e1 directly connected
 10.1.1.128/25 e2 directly connected

 Table 4 Routing Information of R2

 Destination Network Interface Next _hop/GW
 172.16.100.0/30 e0 directly connected
 ___C___ e0 172.16.100.1
 10.1.1.128/25 e1 172.16.100.5
 172.16.100.4/30 e1 directly connected
 172.16.100.128/25 e2 directly connected

 Answer group for A and B
 a) 10.1.1.0 b) 10.1.1.1 c) 10.1.1.2
 d) 172.16.100.0 e) 172.16.100.1 f) 172.16.100.2
 g) 172.16.100.5 h) 172.16.100.6 i) directly connected

 - 16 -

Answer group for C
 a) 10.1.1.0/30 b) 10.1.1.128/25 c) 172.16.100.0/30
 d) 172.16.100.4/30 e) 172.16.100.128/25 f) 203.0.113.0/30
 g) any/any

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following description.

 After the setup, all hosts from R1’s LAN and R2’s LAN can access the Internet and also
 share their resources with each other except for PC3. The administrator checked the status
 of PC3 and found that it was not able to connect to a wired network. Pinging the loopback
 address is successful, but the gateway cannot be reached. On the network switch, all the
 interface lights are on except for the interface connected to PC3. The LED on the network
 card of PC3 is off. The port of the switch connected to PC3 is operational when the other
 PCs are connected. He considers that ___D___ is the most likely cause of this problem,
 and resolved this problem successfully.

 Answer group for D
 a) the gateway requires fixing
 b) the Internet connection is down
 c) the network cable is faulty
 d) the network switch is faulty
 e) the PC has an incorrect IP address for the DNS server

Subquestion 3
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

 The administrator is configuring the firewall functions on the three routers to satisfy the
 following two requirements:
 (1) File server FS1 in the product department should be accessible from both the product
 department and sales department. Meanwhile, file server FS2 in the sales department
 must be accessible only from the sales department to protect customer information. Each
 file server provides its service with SMB protocol.
 (2) The administrator manages the entire network. He accesses the network from his laptop
 using SSH (remote login protocol). He usually works in the product department office,
 and occasionally works in the sales department office as well.

 - 17 -

Tables 5, 6 and 7 show the firewall rules on routers CR, R1 and R2.
When the firewall function receives a packet, it scans the rule table in order from top to
bottom. When it finds a rule that matches the conditions, it terminates the scan and applies
that rule to the packet. Note that because this firewall function understands the TCP stream,
the related packets that have been allowed once (e.g., packets from the same TCP session)
remain allowed even if there is no explicit rule. In addition, the packets from each router
itself are implicitly allowed.

After the setup, he received a complaint from one of the employees claiming that the firewall
does not seem to be working. He found the misconfigured rule on the rule table of
___E___, and then he ___F___.

 Table 5 Firewall rule table of CR

 Rule No Source Destination Destination Service Action
 1 10.1.1.128/25 any any Allow
 2 172.16.100.128/25 any any Allow
 3 any any any Deny

 Table 6 Firewall rule table of R1

 Rule No Source Destination Destination Service Action
 1 172.16.100.128/25 FS1 SMB/tcp Allow
 2 172.16.100.128/25 10.1.1.128/25 SSH/tcp Allow
 3 10.1.1.128/25 any any Allow
 4 any any any Deny

 Table 7 Firewall rule table of R2

 Rule No Source Destination Destination Service Action
 1 10.1.1.128/25 FS2 SMB/tcp Allow
 2 10.1.1.128/25 172.16.100.128/25 SSH/tcp Allow
 3 172.16.100.128/25 any any Allow
 4 any any any Deny

Answer group for E
 a) CR b) R1 c) R2

Answer group for F
 a) moved it to the top of the table b) removed it
 c) swapped it for the rule just above it d) swapped it for the rule just below it

 - 18 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/b/questions.pdf","pages":[15,16,17,18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'B',
  5,
  'Q5. Read the following description of bus ticket reservation system, and then answer
 Subquestions 1 and 2.

Company W operates long-distance buses. Each bus has one departure point and one arrival
 point, and does not stop along the way. Company W is planning to develop the bus ticket
 reservation system.

∙ The system is designed for three types of users: Passenger, Manager, and Driver.
 ∙ Company W has several types of buses. The number of seats is fixed for each type.
 ∙ The departure point, arrival point, required time, and fare are determined for each route.
 ∙ Two months before the departure date, company W decides the routes to follow and buses
 to be used according to the schedule. At this time, all seats are registered as vacant seats.

Bus_type Bus
 Bus_type_ID Bus_ID
 Bus_type_name Bus_type_ID
 Number_of_seats

In_use
 Driver In_use_ID
 Driver_ID Departure_date Seat
 Seat_ID Driver_name Departure_time
 Driver_phone A B
 Driver_address Seat_number
 Bus_ID Ticket_number (*)

Route
 Ticket
 Route_ID
 Ticket_number
 Departure_point
 A
 Destination_point
 Passenger_name
 Time_required
 Passenger_phone
 Fare
 Seat_ID

Note: An underline indicates the primary key.
 (*) indicates that the entity value can be NULL.

Figure 1 Ticket reservation system database

The system has three processes: 1) Driver assignment, 2) Driver confirmation, and 3) Ticket
 booking.
 Here, DFD is deployed to present the data flow in the system. Figure 2 shows the context
 diagram of the system. Figure 3 shows the level 1 DFD of the Driver assignment and Driver
 confirmation processes.

- 19 -

l Manager 0 Passenger
 Bus Ticket
 Reservation
 Driver System

Figure 2 Context Diagram

[For the Manager and Driver]
 In the system, the manager has the responsibility of allocating a bus to each route and
 assigning a driver to the bus. After the manager assigns the bus driver, notification is sent
 to the driver. The driver has to confirm the assignment to complete the assignment process.

Departure date and time, Departure point,
 Driver Destination point, Driver, Bus
 ***C*** 1.1 Manager
 Driver assignment

Departure date and time, Departure
 point, Destination point, Bus

Driver
 1.2 Accept/Reject
 ***D***
 Driver confirmation

Figure 3 Level 1 DFD of Driver assignment and Driver confirmation processes

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Figure 1 and Figure 3.

Answer group for A
 a) Bus_type_ID b) Driver_ID c) In_use_ID
 d) Route_ID e) Seat_ID

Answer group for B
 a) Driver_ID (*) b) Driver_ID (*) c) Driver_ID (*)
 Route_ID Route_ID
 Seat_ID

d) Driver_ID (*) e) Seat_ID
 Route_ID Ticket_number
 Ticket_number

- 20 -

Answer group for C
 a) Bus
 b) Bus, Bus_type
 c) Bus, Bus_type, In_use
 d) Bus, Bus_type, In_use, Route, Seat
 e) Bus, Bus_type, In_use, Route, Seat, Ticket
 f) Bus, Bus_type, Route
 g) Bus, Bus_type, Route, Seat
 h) Bus, Bus_type, Route, Seat, Ticket

Answer group for D
 a) Bus b) Bus_type c) Driver d) In_use
 e) Route f) Seat g) Ticket

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

[For the passenger]
 Booking is performed by the passenger. The passenger opens the bus ticket reservation
 application to book a bus seat. Company W has many buses for many routes. The ticket
 booking can be accomplished by the passenger via a reservation application. The passenger
 is requested to choose the departure date and the departure and destination points. Then the
 system displays the bus schedule, the bus type, and the fare on that date, as shown in Figure
 4. The passenger can make one reservation via the booking screen.

Departure point _Town A Departure date 2021-05-12_
 Destination point _Town B Search __

Search Result -- Depart
 Departure Time Arrival Time Bus Type Bus ID Fare / Seat
 Town A Town B
 06.00 11.00 24 seater bus 901 500 
 07.00 12.00 36 seater bus 519 360 
 13.00 18.00 15 seater bus 444 550 

Figure 4 Screen: Booking

- 21 -

After the passenger has selected the preferred time and bus-type available in the booking
screen, another screen appears for the passenger to enter the passenger detail(s), as shown in
Figure 5. The ticket for each passenger is printed as an e-ticket, as illustrated in Figure 6.

Date 2021-05-12 e-Ticket No. 001 Seat 15
 From Town A To Town B Date 2021-05-12 Fare 500
 Departure time 6.00 Arrival time 11.00 From Town A To Town B
 Bus ID 901 Bus Type 24 seater bus Departure time 6.00 Arrival time 11.00
 Bus ID 901 Bus Type 24 seater bus
 Name Martin Mirror Name Martin Mirror
 Phone 6649092292 Phone 6649092292

Figure 5 Screen: Passenger details Figure 6 e-ticket

Figure 7 shows the level 1 DFD of the Ticket booking process.

Departure date, Departure time, Departure point, Bus_type
 Destination point, Passenger name, Passenger
 phone number, Bus type
 Bus
 2.0 Passenger
 In_use
 Ticket booking e-Ticket
 Route

Seat

Ticket

Figure 7 Level 1 DFD of Ticket booking process

The details of the Generate list process and Reservation process are as follows.
Generate list process
(1) Search In_use table using the departure date, departure point, and destination point in
 chronological order.
(2) Search Seat_table using the obtained key. If a vacant seat is available, add the departure
 time, arrival time, and bus information in the list.
(3) If the list is empty, generate an error message.
Reservation process
(1) Start exclusive control, and generate a unique number and use it as the ticket number.
(2) Search Seat_table using ***E*** as the key to search for a vacant seat.
(3) If a vacant seat is available, ***F***; otherwise, generate an error message.
(4) Terminate exclusive control.

- 22 -

Figure 8 shows the activity diagram of the Ticket booking process.

Passenger Ticket reservation system

Departure_date,
 Departure_point,
 Destination_point
 Request list Generate List

Error message
 Show error message Available
 No

Yes
 Show list
 In_use_ID, Bus_ID,
 Departure_date, Departure_time,
 Departure_point, Destination_point, Fare

Select Bus Reserve seat
 In_use_ID,
 Passenger_name,
 Passenger_phone

Error message
 Show error message Reserved
 No
 Yes
 e‐Ticket
 Departure_date, Bus_ID, Bus_type_name,
 Departure_time, Arrival_time, Seat_number,
 Departure_point, Destination point, Fare,
 Passenger_name, Passenger_phone

Figure 8 Activity diagram of Ticket booking process

Answer group for E
 a) Bus_ID b) Bus_type_ID c) Driver_ID d) In_use_ID
 e) Route_ID f) Seat_ID g) Ticket_number',
  '[{"type":"prompt","text":"Q5. Read the following description of bus ticket reservation system, and then answer\n Subquestions 1 and 2."},{"type":"context","text":"Company W operates long-distance buses. Each bus has one departure point and one arrival\n point, and does not stop along the way. Company W is planning to develop the bus ticket\n reservation system.\n\n∙ The system is designed for three types of users: Passenger, Manager, and Driver.\n ∙ Company W has several types of buses. The number of seats is fixed for each type.\n ∙ The departure point, arrival point, required time, and fare are determined for each route.\n ∙ Two months before the departure date, company W decides the routes to follow and buses\n to be used according to the schedule. At this time, all seats are registered as vacant seats.\n\nBus_type Bus\n Bus_type_ID Bus_ID\n Bus_type_name Bus_type_ID\n Number_of_seats\n\nIn_use\n Driver In_use_ID\n Driver_ID Departure_date Seat\n Seat_ID Driver_name Departure_time\n Driver_phone A B\n Driver_address Seat_number\n Bus_ID Ticket_number (*)\n\nRoute\n Ticket\n Route_ID\n Ticket_number\n Departure_point\n A\n Destination_point\n Passenger_name\n Time_required\n Passenger_phone\n Fare\n Seat_ID\n\nNote: An underline indicates the primary key.\n (*) indicates that the entity value can be NULL.\n\nFigure 1 Ticket reservation system database\n\nThe system has three processes: 1) Driver assignment, 2) Driver confirmation, and 3) Ticket\n booking.\n Here, DFD is deployed to present the data flow in the system. Figure 2 shows the context\n diagram of the system. Figure 3 shows the level 1 DFD of the Driver assignment and Driver\n confirmation processes.\n\n- 19 -\n\nl Manager 0 Passenger\n Bus Ticket\n Reservation\n Driver System\n\nFigure 2 Context Diagram\n\n[For the Manager and Driver]\n In the system, the manager has the responsibility of allocating a bus to each route and\n assigning a driver to the bus. After the manager assigns the bus driver, notification is sent\n to the driver. The driver has to confirm the assignment to complete the assignment process.\n\nDeparture date and time, Departure point,\n Driver Destination point, Driver, Bus\n ***C*** 1.1 Manager\n Driver assignment\n\nDeparture date and time, Departure\n point, Destination point, Bus\n\nDriver\n 1.2 Accept/Reject\n ***D***\n Driver confirmation\n\nFigure 3 Level 1 DFD of Driver assignment and Driver confirmation processes\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in Figure 1 and Figure 3.\n\nAnswer group for A\n a) Bus_type_ID b) Driver_ID c) In_use_ID\n d) Route_ID e) Seat_ID\n\nAnswer group for B\n a) Driver_ID (*) b) Driver_ID (*) c) Driver_ID (*)\n Route_ID Route_ID\n Seat_ID\n\nd) Driver_ID (*) e) Seat_ID\n Route_ID Ticket_number\n Ticket_number\n\n- 20 -\n\nAnswer group for C\n a) Bus\n b) Bus, Bus_type\n c) Bus, Bus_type, In_use\n d) Bus, Bus_type, In_use, Route, Seat\n e) Bus, Bus_type, In_use, Route, Seat, Ticket\n f) Bus, Bus_type, Route\n g) Bus, Bus_type, Route, Seat\n h) Bus, Bus_type, Route, Seat, Ticket\n\nAnswer group for D\n a) Bus b) Bus_type c) Driver d) In_use\n e) Route f) Seat g) Ticket\n\nSubquestion 2\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following description.\n\n[For the passenger]\n Booking is performed by the passenger. The passenger opens the bus ticket reservation\n application to book a bus seat. Company W has many buses for many routes. The ticket\n booking can be accomplished by the passenger via a reservation application. The passenger\n is requested to choose the departure date and the departure and destination points. Then the\n system displays the bus schedule, the bus type, and the fare on that date, as shown in Figure\n 4. The passenger can make one reservation via the booking screen.\n\nDeparture point _Town A Departure date 2021-05-12_\n Destination point _Town B Search __\n\nSearch Result -- Depart\n Departure Time Arrival Time Bus Type Bus ID Fare / Seat\n Town A Town B\n 06.00 11.00 24 seater bus 901 500 \n 07.00 12.00 36 seater bus 519 360 \n 13.00 18.00 15 seater bus 444 550 \n\nFigure 4 Screen: Booking\n\n- 21 -\n\nAfter the passenger has selected the preferred time and bus-type available in the booking\nscreen, another screen appears for the passenger to enter the passenger detail(s), as shown in\nFigure 5. The ticket for each passenger is printed as an e-ticket, as illustrated in Figure 6.\n\nDate 2021-05-12 e-Ticket No. 001 Seat 15\n From Town A To Town B Date 2021-05-12 Fare 500\n Departure time 6.00 Arrival time 11.00 From Town A To Town B\n Bus ID 901 Bus Type 24 seater bus Departure time 6.00 Arrival time 11.00\n Bus ID 901 Bus Type 24 seater bus\n Name Martin Mirror Name Martin Mirror\n Phone 6649092292 Phone 6649092292\n\nFigure 5 Screen: Passenger details Figure 6 e-ticket\n\nFigure 7 shows the level 1 DFD of the Ticket booking process.\n\nDeparture date, Departure time, Departure point, Bus_type\n Destination point, Passenger name, Passenger\n phone number, Bus type\n Bus\n 2.0 Passenger\n In_use\n Ticket booking e-Ticket\n Route\n\nSeat\n\nTicket\n\nFigure 7 Level 1 DFD of Ticket booking process\n\nThe details of the Generate list process and Reservation process are as follows.\nGenerate list process\n(1) Search In_use table using the departure date, departure point, and destination point in\n chronological order.\n(2) Search Seat_table using the obtained key. If a vacant seat is available, add the departure\n time, arrival time, and bus information in the list.\n(3) If the list is empty, generate an error message.\nReservation process\n(1) Start exclusive control, and generate a unique number and use it as the ticket number.\n(2) Search Seat_table using ***E*** as the key to search for a vacant seat.\n(3) If a vacant seat is available, ***F***; otherwise, generate an error message.\n(4) Terminate exclusive control.\n\n- 22 -\n\nFigure 8 shows the activity diagram of the Ticket booking process.\n\nPassenger Ticket reservation system\n\nDeparture_date,\n Departure_point,\n Destination_point\n Request list Generate List\n\nError message\n Show error message Available\n No\n\nYes\n Show list\n In_use_ID, Bus_ID,\n Departure_date, Departure_time,\n Departure_point, Destination_point, Fare\n\nSelect Bus Reserve seat\n In_use_ID,\n Passenger_name,\n Passenger_phone\n\nError message\n Show error message Reserved\n No\n Yes\n e‐Ticket\n Departure_date, Bus_ID, Bus_type_name,\n Departure_time, Arrival_time, Seat_number,\n Departure_point, Destination point, Fare,\n Passenger_name, Passenger_phone\n\nFigure 8 Activity diagram of Ticket booking process\n\nAnswer group for E\n a) Bus_ID b) Bus_type_ID c) Driver_ID d) In_use_ID\n e) Route_ID f) Seat_ID g) Ticket_number"}]'::jsonb,
  '["2021-april-b-q05-figure1.webp","2021-april-b-q05-figure2.webp","2021-april-b-q05-figure3.webp","2021-april-b-q05-figure4.webp","2021-april-b-q05-figure5.webp","2021-april-b-q05-figure6.webp"]'::jsonb,
  '[{"label":"a","text":"insert new data to Ticket table."},{"label":"b","text":"insert new data to Ticket table and insert new data to Seat table."},{"label":"c","text":"insert new data to Ticket table and set Ticket_number to Ticket_number in Seat table."},{"label":"d","text":"update Ticket table."},{"label":"e","text":"update Ticket table and insert new data to Seat table.\n\n - 23 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "c"}, {"subquestion": 1, "blank": "B", "answer": "b"}, {"subquestion": 1, "blank": "C", "answer": "f"}, {"subquestion": 1, "blank": "D", "answer": "d"}, {"subquestion": 2, "blank": "E", "answer": "d"}, {"subquestion": 2, "blank": "F", "answer": "c"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"c"},{"subquestion":1,"blank":"B","answer":"b"},{"subquestion":1,"blank":"C","answer":"f"},{"subquestion":1,"blank":"D","answer":"d"},{"subquestion":2,"blank":"E","answer":"d"},{"subquestion":2,"blank":"F","answer":"c"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-B, Q5)',
  ARRAY[19,20,21,22,23]::int[],
  'native_text',
  '3.0',
  'Q5. Read the following description of bus ticket reservation system, and then answer
 Subquestions 1 and 2.

 Company W operates long-distance buses. Each bus has one departure point and one arrival
 point, and does not stop along the way. Company W is planning to develop the bus ticket
 reservation system.

 ∙ The system is designed for three types of users: Passenger, Manager, and Driver.
 ∙ Company W has several types of buses. The number of seats is fixed for each type.
 ∙ The departure point, arrival point, required time, and fare are determined for each route.
 ∙ Two months before the departure date, company W decides the routes to follow and buses
 to be used according to the schedule. At this time, all seats are registered as vacant seats.

 Bus_type Bus
 Bus_type_ID Bus_ID
 Bus_type_name Bus_type_ID
 Number_of_seats

 In_use
 Driver In_use_ID
 Driver_ID Departure_date Seat
 Seat_ID Driver_name Departure_time
 Driver_phone A B
 Driver_address Seat_number
 Bus_ID Ticket_number (*)

 Route
 Ticket
 Route_ID
 Ticket_number
 Departure_point
 A
 Destination_point
 Passenger_name
 Time_required
 Passenger_phone
 Fare
 Seat_ID

 Note: An underline indicates the primary key.
 (*) indicates that the entity value can be NULL.

 Figure 1 Ticket reservation system database

 The system has three processes: 1) Driver assignment, 2) Driver confirmation, and 3) Ticket
 booking.
 Here, DFD is deployed to present the data flow in the system. Figure 2 shows the context
 diagram of the system. Figure 3 shows the level 1 DFD of the Driver assignment and Driver
 confirmation processes.

 - 19 -

l Manager 0 Passenger
 Bus Ticket
 Reservation
 Driver System

 Figure 2 Context Diagram

 [For the Manager and Driver]
 In the system, the manager has the responsibility of allocating a bus to each route and
 assigning a driver to the bus. After the manager assigns the bus driver, notification is sent
 to the driver. The driver has to confirm the assignment to complete the assignment process.

 Departure date and time, Departure point,
 Driver Destination point, Driver, Bus
 ___C___ 1.1 Manager
 Driver assignment

 Departure date and time, Departure
 point, Destination point, Bus

 Driver
 1.2 Accept/Reject
 ___D___
 Driver confirmation

 Figure 3 Level 1 DFD of Driver assignment and Driver confirmation processes

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Figure 1 and Figure 3.

 Answer group for A
 a) Bus_type_ID b) Driver_ID c) In_use_ID
 d) Route_ID e) Seat_ID

 Answer group for B
 a) Driver_ID (*) b) Driver_ID (*) c) Driver_ID (*)
 Route_ID Route_ID
 Seat_ID

 d) Driver_ID (*) e) Seat_ID
 Route_ID Ticket_number
 Ticket_number

 - 20 -

Answer group for C
 a) Bus
 b) Bus, Bus_type
 c) Bus, Bus_type, In_use
 d) Bus, Bus_type, In_use, Route, Seat
 e) Bus, Bus_type, In_use, Route, Seat, Ticket
 f) Bus, Bus_type, Route
 g) Bus, Bus_type, Route, Seat
 h) Bus, Bus_type, Route, Seat, Ticket

 Answer group for D
 a) Bus b) Bus_type c) Driver d) In_use
 e) Route f) Seat g) Ticket

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

 [For the passenger]
 Booking is performed by the passenger. The passenger opens the bus ticket reservation
 application to book a bus seat. Company W has many buses for many routes. The ticket
 booking can be accomplished by the passenger via a reservation application. The passenger
 is requested to choose the departure date and the departure and destination points. Then the
 system displays the bus schedule, the bus type, and the fare on that date, as shown in Figure
 4. The passenger can make one reservation via the booking screen.

 Departure point _Town A Departure date 2021-05-12_
 Destination point _Town B Search __

 Search Result -- Depart
 Departure Time Arrival Time Bus Type Bus ID Fare / Seat
 Town A Town B
 06.00 11.00 24 seater bus 901 500 
 07.00 12.00 36 seater bus 519 360 
 13.00 18.00 15 seater bus 444 550 

 Figure 4 Screen: Booking

 - 21 -

After the passenger has selected the preferred time and bus-type available in the booking
screen, another screen appears for the passenger to enter the passenger detail(s), as shown in
Figure 5. The ticket for each passenger is printed as an e-ticket, as illustrated in Figure 6.

 Date 2021-05-12 e-Ticket No. 001 Seat 15
 From Town A To Town B Date 2021-05-12 Fare 500
 Departure time 6.00 Arrival time 11.00 From Town A To Town B
 Bus ID 901 Bus Type 24 seater bus Departure time 6.00 Arrival time 11.00
 Bus ID 901 Bus Type 24 seater bus
 Name Martin Mirror Name Martin Mirror
 Phone 6649092292 Phone 6649092292

 Figure 5 Screen: Passenger details Figure 6 e-ticket

Figure 7 shows the level 1 DFD of the Ticket booking process.

 Departure date, Departure time, Departure point, Bus_type
 Destination point, Passenger name, Passenger
 phone number, Bus type
 Bus
 2.0 Passenger
 In_use
 Ticket booking e-Ticket
 Route

 Seat

 Ticket

 Figure 7 Level 1 DFD of Ticket booking process

The details of the Generate list process and Reservation process are as follows.
Generate list process
(1) Search In_use table using the departure date, departure point, and destination point in
 chronological order.
(2) Search Seat_table using the obtained key. If a vacant seat is available, add the departure
 time, arrival time, and bus information in the list.
(3) If the list is empty, generate an error message.
Reservation process
(1) Start exclusive control, and generate a unique number and use it as the ticket number.
(2) Search Seat_table using ___E___ as the key to search for a vacant seat.
(3) If a vacant seat is available, ___F___; otherwise, generate an error message.
(4) Terminate exclusive control.

 - 22 -

Figure 8 shows the activity diagram of the Ticket booking process.

 Passenger Ticket reservation system

 Departure_date,
 Departure_point,
 Destination_point
 Request list Generate List

 Error message
 Show error message Available
 No

 Yes
 Show list
 In_use_ID, Bus_ID,
 Departure_date, Departure_time,
 Departure_point, Destination_point, Fare

 Select Bus Reserve seat
 In_use_ID,
 Passenger_name,
 Passenger_phone

 Error message
 Show error message Reserved
 No
 Yes
 e‐Ticket
 Departure_date, Bus_ID, Bus_type_name,
 Departure_time, Arrival_time, Seat_number,
 Departure_point, Destination point, Fare,
 Passenger_name, Passenger_phone

 Figure 8 Activity diagram of Ticket booking process

Answer group for E
 a) Bus_ID b) Bus_type_ID c) Driver_ID d) In_use_ID
 e) Route_ID f) Seat_ID g) Ticket_number

Answer group for F
 a) insert new data to Ticket table.
 b) insert new data to Ticket table and insert new data to Seat table.
 c) insert new data to Ticket table and set Ticket_number to Ticket_number in Seat table.
 d) update Ticket table.
 e) update Ticket table and insert new data to Seat table.

 - 23 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/b/questions.pdf","pages":[19,20,21,22,23]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'B',
  6,
  'Q6. Read the following description of social network analysis, and then answer Subquestions
 1 through 3.

[Program Description]
 In social media marketing, influence is one of the most important factors. The most basic
 measure of influence is the number of “friends”. Although this can measure popularity, it
 does not consider “reach”. One of the more complex measures of influence is Closeness
 Centrality, which determines the “closeness” of an influencer to all the other users in the
 social network. This program calculates an index of Closeness Centrality (called Closeness
 Centrality Index (CCI)).

(1) Closeness Centrality uses the shortest path distances from one node to all other nodes
 on the network. The distance between two nodes is determined by counting the number
 of edges or links between the two. For example, in Figure 1, from node 10, node 6 has
 a distance of 1, and node 4 has a distance of 2.

6
 1

3
 2 10
 4 5

7
 node
 edge 9
 8

Figure 1 Social network example

(2) The CCI value is from 0 to 1, where the node with the highest value is the closest to all
 other nodes. For a graph with n number of nodes, the CCI value for each node is
 computed by the number of the other nodes divided by the sum of the distances to the
 other nodes.
 ܥܥܫ ൌെ1
 ∑ሺݏݐܽ݊ܿ݁ ݐ݋ ݋ݐ݄݁ ݎ ݊݋݀݁ ݏ ሻ

(3) The social network illustrated in Figure 1 produces the distance matrix shown in Table
 1. For example, the last row of Table 1 indicates that node 10 has distances 4, 4, 3, 2, 2,
 1, 3, 2, and 1 to nodes 1 to 9, and the CCI value of node 10 is 9 / 22 = 0.41. Here, CCI
 is rounded to two decimal places.

- 24 -

Table 1 Distance matrix of social network illustrated in Figure 1
 Node 1 2 3 4 5 6 7 8 9 10 CCI
 1 0 1 1 2 3 3 2 3 3 4 0.41
 2 1 0 2 2 3 3 1 3 3 4 B
 3 1 2 0 1 2 2 2 2 2 3 0.53
 4 2 2 1 0 1 1 1 1 1 2 0.75
 5 3 3 2 1 0 1 2 2 1 2 0.53
 6 3 3 2 1 1 2 2 1 0.53
 A
 7 2 1 2 1 2 2 2 3 0.53
 8 3 3 2 1 2 2 2 0 1 2 0.50
 9 3 3 2 1 1 2 2 1 0 1 0.56
 10 4 4 3 2 2 1 3 2 1 0 0.41

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Table 1.

Answer group for A
 a) b) c) d)
 0 2 0 3 0 2 0 3
 2 0 2 0 3 0 3 0

Answer group for B
 a) 0.36 b) 0.41 c) 0.45 d) 0.50

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following program.

[Program Description]
 (1) The program uses breadth-first search/traversal algorithm to build the distance matrix.
 The algorithm is as follows.
 o Set the distance of the start node.
 o Put the start node into the queue.
 o While the queue is not empty, repeat the following:
 o Get a node v from the queue.
 o For each node w that is a neighbor of node v, perform the following:
 o If node w has not yet been visited, calculate the distance between the start node
 and node w. Thereafter, add node w to the queue.

- 25 -

(2) The class Graph represents a graph network data structure with nodes and edges and has
 the following methods. Graph G is defined in the function main (not shown in the
 program). Here, graph G is undirected and connected (there is a path between every pair
 of nodes), and the number of nodes ≥ 2.

Method Description
 number_of_nodes() Returns the number of nodes
 neighbor_nodes(x) Returns an array of the neighbor nodes of node x

(3) The class Queue represents a queue data structure, and has the following methods.
 Queue Q is defined in the function bfs.

Method Description
 empty() Returns true if the queue is empty; otherwise, returns false
 enqueue(x) Enqueues x to the queue
 dequeue() Removes and returns the head element from the queue

(4) The program has the following functions.

Function Description
 Performs breath-first search/traversal from node s on graph G,
 bfs(G, s) and returns an array of the distances from node s to the other
 nodes on graph G
 distanceMatrix(G) Builds and returns a distance matrix for graph G
 computeCci(G) Computes CCI of the nodes on graph G

(5) The program uses the following external functions.

Function Description
 Returns true if variable x is uninitialized; otherwise returns
 uninitialized(x)
 false
 length(x) Returns the number of elements of array x

(6) The indexes of all arrays used in the program start at 1.

(7) The function main (not shown in the program) sets up the graph data in G and then calls
 the function computeCci.

- 26 -',
  '[{"type":"prompt","text":"Q6. Read the following description of social network analysis, and then answer Subquestions\n 1 through 3."},{"type":"context","text":"[Program Description]\n In social media marketing, influence is one of the most important factors. The most basic\n measure of influence is the number of “friends”. Although this can measure popularity, it\n does not consider “reach”. One of the more complex measures of influence is Closeness\n Centrality, which determines the “closeness” of an influencer to all the other users in the\n social network. This program calculates an index of Closeness Centrality (called Closeness\n Centrality Index (CCI)).\n\n(1) Closeness Centrality uses the shortest path distances from one node to all other nodes\n on the network. The distance between two nodes is determined by counting the number\n of edges or links between the two. For example, in Figure 1, from node 10, node 6 has\n a distance of 1, and node 4 has a distance of 2.\n\n6\n 1\n\n3\n 2 10\n 4 5\n\n7\n node\n edge 9\n 8\n\nFigure 1 Social network example\n\n(2) The CCI value is from 0 to 1, where the node with the highest value is the closest to all\n other nodes. For a graph with n number of nodes, the CCI value for each node is\n computed by the number of the other nodes divided by the sum of the distances to the\n other nodes.\n ܥܥܫ ൌെ1\n ∑ሺݏݐܽ݊ܿ݁ ݐ݋ ݋ݐ݄݁ ݎ ݊݋݀݁ ݏ ሻ\n\n(3) The social network illustrated in Figure 1 produces the distance matrix shown in Table\n 1. For example, the last row of Table 1 indicates that node 10 has distances 4, 4, 3, 2, 2,\n 1, 3, 2, and 1 to nodes 1 to 9, and the CCI value of node 10 is 9 / 22 = 0.41. Here, CCI\n is rounded to two decimal places.\n\n- 24 -\n\nTable 1 Distance matrix of social network illustrated in Figure 1\n Node 1 2 3 4 5 6 7 8 9 10 CCI\n 1 0 1 1 2 3 3 2 3 3 4 0.41\n 2 1 0 2 2 3 3 1 3 3 4 B\n 3 1 2 0 1 2 2 2 2 2 3 0.53\n 4 2 2 1 0 1 1 1 1 1 2 0.75\n 5 3 3 2 1 0 1 2 2 1 2 0.53\n 6 3 3 2 1 1 2 2 1 0.53\n A\n 7 2 1 2 1 2 2 2 3 0.53\n 8 3 3 2 1 2 2 2 0 1 2 0.50\n 9 3 3 2 1 1 2 2 1 0 1 0.56\n 10 4 4 3 2 2 1 3 2 1 0 0.41\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in Table 1.\n\nAnswer group for A\n a) b) c) d)\n 0 2 0 3 0 2 0 3\n 2 0 2 0 3 0 3 0\n\nAnswer group for B\n a) 0.36 b) 0.41 c) 0.45 d) 0.50\n\nSubquestion 2\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following program.\n\n[Program Description]\n (1) The program uses breadth-first search/traversal algorithm to build the distance matrix.\n The algorithm is as follows.\n o Set the distance of the start node.\n o Put the start node into the queue.\n o While the queue is not empty, repeat the following:\n o Get a node v from the queue.\n o For each node w that is a neighbor of node v, perform the following:\n o If node w has not yet been visited, calculate the distance between the start node\n and node w. Thereafter, add node w to the queue.\n\n- 25 -\n\n(2) The class Graph represents a graph network data structure with nodes and edges and has\n the following methods. Graph G is defined in the function main (not shown in the\n program). Here, graph G is undirected and connected (there is a path between every pair\n of nodes), and the number of nodes ≥ 2.\n\nMethod Description\n number_of_nodes() Returns the number of nodes\n neighbor_nodes(x) Returns an array of the neighbor nodes of node x\n\n(3) The class Queue represents a queue data structure, and has the following methods.\n Queue Q is defined in the function bfs.\n\nMethod Description\n empty() Returns true if the queue is empty; otherwise, returns false\n enqueue(x) Enqueues x to the queue\n dequeue() Removes and returns the head element from the queue\n\n(4) The program has the following functions.\n\nFunction Description\n Performs breath-first search/traversal from node s on graph G,\n bfs(G, s) and returns an array of the distances from node s to the other\n nodes on graph G\n distanceMatrix(G) Builds and returns a distance matrix for graph G\n computeCci(G) Computes CCI of the nodes on graph G\n\n(5) The program uses the following external functions.\n\nFunction Description\n Returns true if variable x is uninitialized; otherwise returns\n uninitialized(x)\n false\n length(x) Returns the number of elements of array x\n\n(6) The indexes of all arrays used in the program start at 1.\n\n(7) The function main (not shown in the program) sets up the graph data in G and then calls\n the function computeCci.\n\n- 26 -"}]'::jsonb,
  '["2021-april-b-q06-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"8"},{"label":"b","text":"9"},{"label":"c","text":"10"},{"label":"d","text":"14"},{"label":"e","text":"18"},{"label":"f","text":"22"},{"label":"g","text":"28"},{"label":"h","text":"36\n\n - 28 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "a"}, {"subquestion": 1, "blank": "B", "answer": "b"}, {"subquestion": 2, "blank": "C", "answer": "d"}, {"subquestion": 2, "blank": "D", "answer": "h"}, {"subquestion": 3, "blank": "E", "answer": "c"}, {"subquestion": 3, "blank": "F", "answer": "g"}, {"subquestion": 3, "blank": "G", "answer": "b"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"a"},{"subquestion":1,"blank":"B","answer":"b"},{"subquestion":2,"blank":"C","answer":"d"},{"subquestion":2,"blank":"D","answer":"h"},{"subquestion":3,"blank":"E","answer":"c"},{"subquestion":3,"blank":"F","answer":"g"},{"subquestion":3,"blank":"G","answer":"b"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-B, Q6)',
  ARRAY[24,25,26,27,28]::int[],
  'native_text',
  '3.0',
  'Q6. Read the following description of social network analysis, and then answer Subquestions
 1 through 3.

 [Program Description]
 In social media marketing, influence is one of the most important factors. The most basic
 measure of influence is the number of “friends”. Although this can measure popularity, it
 does not consider “reach”. One of the more complex measures of influence is Closeness
 Centrality, which determines the “closeness” of an influencer to all the other users in the
 social network. This program calculates an index of Closeness Centrality (called Closeness
 Centrality Index (CCI)).

 (1) Closeness Centrality uses the shortest path distances from one node to all other nodes
 on the network. The distance between two nodes is determined by counting the number
 of edges or links between the two. For example, in Figure 1, from node 10, node 6 has
 a distance of 1, and node 4 has a distance of 2.

 6
 1

 3
 2 10
 4 5

 7
 node
 edge 9
 8

 Figure 1 Social network example

 (2) The CCI value is from 0 to 1, where the node with the highest value is the closest to all
 other nodes. For a graph with n number of nodes, the CCI value for each node is
 computed by the number of the other nodes divided by the sum of the distances to the
 other nodes.
 ܥܥܫ ൌെ1
 ∑ሺݏݐܽ݊ܿ݁ ݐ݋ ݋ݐ݄݁ ݎ ݊݋݀݁ ݏ ሻ

 (3) The social network illustrated in Figure 1 produces the distance matrix shown in Table
 1. For example, the last row of Table 1 indicates that node 10 has distances 4, 4, 3, 2, 2,
 1, 3, 2, and 1 to nodes 1 to 9, and the CCI value of node 10 is 9 / 22 = 0.41. Here, CCI
 is rounded to two decimal places.

 - 24 -

Table 1 Distance matrix of social network illustrated in Figure 1
 Node 1 2 3 4 5 6 7 8 9 10 CCI
 1 0 1 1 2 3 3 2 3 3 4 0.41
 2 1 0 2 2 3 3 1 3 3 4 B
 3 1 2 0 1 2 2 2 2 2 3 0.53
 4 2 2 1 0 1 1 1 1 1 2 0.75
 5 3 3 2 1 0 1 2 2 1 2 0.53
 6 3 3 2 1 1 2 2 1 0.53
 A
 7 2 1 2 1 2 2 2 3 0.53
 8 3 3 2 1 2 2 2 0 1 2 0.50
 9 3 3 2 1 1 2 2 1 0 1 0.56
 10 4 4 3 2 2 1 3 2 1 0 0.41

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Table 1.

 Answer group for A
 a) b) c) d)
 0 2 0 3 0 2 0 3
 2 0 2 0 3 0 3 0

 Answer group for B
 a) 0.36 b) 0.41 c) 0.45 d) 0.50

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following program.

 [Program Description]
 (1) The program uses breadth-first search/traversal algorithm to build the distance matrix.
 The algorithm is as follows.
 o Set the distance of the start node.
 o Put the start node into the queue.
 o While the queue is not empty, repeat the following:
 o Get a node v from the queue.
 o For each node w that is a neighbor of node v, perform the following:
 o If node w has not yet been visited, calculate the distance between the start node
 and node w. Thereafter, add node w to the queue.

 - 25 -

(2) The class Graph represents a graph network data structure with nodes and edges and has
 the following methods. Graph G is defined in the function main (not shown in the
 program). Here, graph G is undirected and connected (there is a path between every pair
 of nodes), and the number of nodes ≥ 2.

 Method Description
 number_of_nodes() Returns the number of nodes
 neighbor_nodes(x) Returns an array of the neighbor nodes of node x

(3) The class Queue represents a queue data structure, and has the following methods.
 Queue Q is defined in the function bfs.

 Method Description
 empty() Returns true if the queue is empty; otherwise, returns false
 enqueue(x) Enqueues x to the queue
 dequeue() Removes and returns the head element from the queue

(4) The program has the following functions.

 Function Description
 Performs breath-first search/traversal from node s on graph G,
 bfs(G, s) and returns an array of the distances from node s to the other
 nodes on graph G
 distanceMatrix(G) Builds and returns a distance matrix for graph G
 computeCci(G) Computes CCI of the nodes on graph G

(5) The program uses the following external functions.

 Function Description
 Returns true if variable x is uninitialized; otherwise returns
 uninitialized(x)
 false
 length(x) Returns the number of elements of array x

(6) The indexes of all arrays used in the program start at 1.

(7) The function main (not shown in the program) sets up the graph data in G and then calls
 the function computeCci.

 - 26 -

[Program]

 FUNCTION: computeCci(Graph: G) {
 INT: i, j, n, sum
 n  G.number_of_nodes();
 INT: matrix[n][n]
 FLOAT: cci[n]
 matrix  distanceMatrix(G);
 FOR (i  1; i ≤ n; i  i + 1) {
 sum  0;
 FOR (j  1; j ≤ n; j  j + 1) {
 sum  sum + matrix[i][j];
 }
 cci[i]  (FLOAT)(n - 1) / (FLOAT)sum;
 }
 return(cci);
 }

 FUNCTION: distanceMatrix(Graph: G) {
 INT: i, j, n
 n  G.number_of_nodes();
 INT: d[n], matrix[n][n]
 FOR (i  1; i ≤ n; i  i + 1) {
 d  bfs(G, i);
 FOR (j  1; j ≤ n; j  j + 1) {
 matrix[i][j]  d[j];
 }
 }
 return(matrix);
 }

 FUNCTION: bfs(Graph: G, INT: s) {
 Queue: Q
 INT: i, array_w[], n, v, w
 n  G.number_of_nodes();
 INT: d[n]
 _____C_____;
 Q.enqueue(s);
 WHILE (not Q.empty()) {
 v  Q.dequeue(); /*  α */
 array_w  G.neighbor_nodes(v);
 FOR (i  1; i ≤ length(array_w); i  i + 1) {
 w  array_w[i]; /*  β */
 IF (uninitialized(d[w])) {
 _____D_____;
 Q.enqueue(w); /*  γ */
 }
 }
 }
 return(d);
 }

 - 27 -

Answer group for C
 a) d[1]  0 b) d[1]  1 c) d[1]  n
 d) d[s]  0 e) d[s]  1 f) d[s]  n

 Answer group for D
 a) d[v]  d[s] b) d[v]  d[s] + 1
 c) d[v]  d[w] d) d[v]  d[w] + 1
 e) d[w]  d[s] f) d[w]  d[s] + 1
 g) d[w]  d[v] h) d[w]  d[v] + 1

Subquestion 3

 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the following description. It is assumed that the correct answers are inserted
 in blanks ___C___ and ___D___.

 When the program is executed by providing graph G shown in Figure 1, function bfs is
 called 10 times.
 When function bfs is called the first time, the line pointed out by /*  α */ is executed
 ___E___ times, the line pointed out by /*  β */ is executed ___F___ times, and the
 line pointed out by /*  γ */ is executed ___G___ times.

 Answer group for E through G
 a) 8 b) 9 c) 10 d) 14
 e) 18 f) 22 g) 28 h) 36

 - 28 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/b/questions.pdf","pages":[24,25,26,27,28]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'B',
  7,
  'Q7. Read the following description of a C program and the program itself, and then answer
 Subquestions 1 and 2.

A polynomial with integer coefficients of degree n can be represented by an integer array of
 length n + 1. For example, the array {7, -1, 0, 5} represents the polynomial 5x3-x+7. In
 this representation, the leading coefficient, which is the last element of the array, is always
 non-zero except for a zero polynomial represented by {0}.

[Program Description]
 (1) The function display_poly prints a polynomial of degree deg that is represented by the
 array pol[] to the standard output. For each term of the polynomial, display_poly
 prints the coefficient, * (the multiplication sign), x, ^ (the power sign), and the degree
 of the term in this order, except for the following cases (if multiple cases match, the first
 one is applied).
 (i) Print 0 for the zero polynomial.
 (ii) Print nothing for a term if the coefficient of the term is 0.
 (iii) Print + before the positive coefficient of a term except for the term with the highest
 degree.
 (iv) If the coefficient of a term is 1 or -1 and the degree of the term is not 0, omit 1 and
 the following *.
 (v) If the degree of a term is 1, omit ^ and the degree.
 (vi) If the degree of a term is 0, do not print *, x, ^, and the degree.

(2) Examples of input and output of the function display_poly is shown in Table 1.

Table 1 Examples of input and output of function display_poly

Input Output

pol[] deg
 {0} 0 0
 {1} 0 1
 {-1, -1} 1 -x-1
 {1, 0, 1} 2 x^2+1
 {7, -1, 0, 5} 3 5*x^3-x+7
 {0, -6, 12, 1, -3} 4 -3*x^4+x^3+12*x^2-6*x

- 29 -

(3) The function iterates from the term with the highest degree to the lowest. To output one
 term in a polynomial in each iteration, the following three functions are called.
 (i) void print_coef(int coef, int pow, int deg);
 Prints coefficient coef of a term with degree pow of a polynomial of degree deg. For
 example, if the polynomial -3*x^4+x^3+12*x^2-6*x is given, it prints -3, +, +12,
 and -6 for each term.
 (ii) void print_star(int coef, int pow);
 Prints * for a term with coefficient coef and degree pow. For example, it prints three
 *’s for the polynomial -3*x^4+x^3+12*x^2-6*x.
 (iii) void print_xpow(int pow);
 Prints x, ^, and degree pow of a term. For example, it prints x^4, x^3, x^2, and x for
 each term of the polynomial -3*x^4+x^3+12*x^2-6*x.',
  '[{"type":"prompt","text":"Q7. Read the following description of a C program and the program itself, and then answer\n Subquestions 1 and 2."},{"type":"context","text":"A polynomial with integer coefficients of degree n can be represented by an integer array of\n length n + 1. For example, the array {7, -1, 0, 5} represents the polynomial 5x3-x+7. In\n this representation, the leading coefficient, which is the last element of the array, is always\n non-zero except for a zero polynomial represented by {0}.\n\n[Program Description]\n (1) The function display_poly prints a polynomial of degree deg that is represented by the\n array pol[] to the standard output. For each term of the polynomial, display_poly\n prints the coefficient, * (the multiplication sign), x, ^ (the power sign), and the degree\n of the term in this order, except for the following cases (if multiple cases match, the first\n one is applied).\n (i) Print 0 for the zero polynomial.\n (ii) Print nothing for a term if the coefficient of the term is 0.\n (iii) Print + before the positive coefficient of a term except for the term with the highest\n degree.\n (iv) If the coefficient of a term is 1 or -1 and the degree of the term is not 0, omit 1 and\n the following *.\n (v) If the degree of a term is 1, omit ^ and the degree.\n (vi) If the degree of a term is 0, do not print *, x, ^, and the degree.\n\n(2) Examples of input and output of the function display_poly is shown in Table 1.\n\nTable 1 Examples of input and output of function display_poly\n\nInput Output\n\npol[] deg\n {0} 0 0\n {1} 0 1\n {-1, -1} 1 -x-1\n {1, 0, 1} 2 x^2+1\n {7, -1, 0, 5} 3 5*x^3-x+7\n {0, -6, 12, 1, -3} 4 -3*x^4+x^3+12*x^2-6*x\n\n- 29 -\n\n(3) The function iterates from the term with the highest degree to the lowest. To output one\n term in a polynomial in each iteration, the following three functions are called.\n (i) void print_coef(int coef, int pow, int deg);\n Prints coefficient coef of a term with degree pow of a polynomial of degree deg. For\n example, if the polynomial -3*x^4+x^3+12*x^2-6*x is given, it prints -3, +, +12,\n and -6 for each term.\n (ii) void print_star(int coef, int pow);\n Prints * for a term with coefficient coef and degree pow. For example, it prints three\n *’s for the polynomial -3*x^4+x^3+12*x^2-6*x.\n (iii) void print_xpow(int pow);\n Prints x, ^, and degree pow of a term. For example, it prints x^4, x^3, x^2, and x for\n each term of the polynomial -3*x^4+x^3+12*x^2-6*x."},{"type":"code","language":"itpec-pseudocode","text":"printf(\"*\");\n    }\n}\n\nvoid print_xpow(int pow) {\n    if (pow > 0) {\n        printf(\"x\");\n    }\n    if (pow > 1) {\n        printf(\"^%d\", pow);\n    }\n}\n\nint main() {\n    int pol[5] = {11, 1, -1, 0, -7};\n\n    display_poly(pol, 4);\n    return 0;\n}"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0"},{"label":"b","text":"00"},{"label":"c","text":"0*x^2"},{"label":"d","text":"0*x^2+0"},{"label":"e","text":"a blank line (''\\n'' only)\n\n - 33 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "b"}, {"subquestion": 1, "blank": "B", "answer": "d"}, {"subquestion": 1, "blank": "C", "answer": "c"}, {"subquestion": 1, "blank": "D", "answer": "e"}, {"subquestion": 1, "blank": "E", "answer": "b"}, {"subquestion": 2, "blank": "F", "answer": "d"}, {"subquestion": 2, "blank": "G", "answer": "e"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"b"},{"subquestion":1,"blank":"B","answer":"d"},{"subquestion":1,"blank":"C","answer":"c"},{"subquestion":1,"blank":"D","answer":"e"},{"subquestion":1,"blank":"E","answer":"b"},{"subquestion":2,"blank":"F","answer":"d"},{"subquestion":2,"blank":"G","answer":"e"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-B, Q7)',
  ARRAY[29,30,31,32,33]::int[],
  'native_text',
  '3.0',
  'Q7. Read the following description of a C program and the program itself, and then answer
 Subquestions 1 and 2.

 A polynomial with integer coefficients of degree n can be represented by an integer array of
 length n + 1. For example, the array {7, -1, 0, 5} represents the polynomial 5x3-x+7. In
 this representation, the leading coefficient, which is the last element of the array, is always
 non-zero except for a zero polynomial represented by {0}.

 [Program Description]
 (1) The function display_poly prints a polynomial of degree deg that is represented by the
 array pol[] to the standard output. For each term of the polynomial, display_poly
 prints the coefficient, * (the multiplication sign), x, ^ (the power sign), and the degree
 of the term in this order, except for the following cases (if multiple cases match, the first
 one is applied).
 (i) Print 0 for the zero polynomial.
 (ii) Print nothing for a term if the coefficient of the term is 0.
 (iii) Print + before the positive coefficient of a term except for the term with the highest
 degree.
 (iv) If the coefficient of a term is 1 or -1 and the degree of the term is not 0, omit 1 and
 the following *.
 (v) If the degree of a term is 1, omit ^ and the degree.
 (vi) If the degree of a term is 0, do not print *, x, ^, and the degree.

 (2) Examples of input and output of the function display_poly is shown in Table 1.

 Table 1 Examples of input and output of function display_poly

 Input Output

 pol[] deg
 {0} 0 0
 {1} 0 1
 {-1, -1} 1 -x-1
 {1, 0, 1} 2 x^2+1
 {7, -1, 0, 5} 3 5*x^3-x+7
 {0, -6, 12, 1, -3} 4 -3*x^4+x^3+12*x^2-6*x

 - 29 -

(3) The function iterates from the term with the highest degree to the lowest. To output one
 term in a polynomial in each iteration, the following three functions are called.
 (i) void print_coef(int coef, int pow, int deg);
 Prints coefficient coef of a term with degree pow of a polynomial of degree deg. For
 example, if the polynomial -3*x^4+x^3+12*x^2-6*x is given, it prints -3, +, +12,
 and -6 for each term.
 (ii) void print_star(int coef, int pow);
 Prints * for a term with coefficient coef and degree pow. For example, it prints three
 *’s for the polynomial -3*x^4+x^3+12*x^2-6*x.
 (iii) void print_xpow(int pow);
 Prints x, ^, and degree pow of a term. For example, it prints x^4, x^3, x^2, and x for
 each term of the polynomial -3*x^4+x^3+12*x^2-6*x.

[Program]

 #include <stdio.h>

 /* prints polynomial */
 void display_poly(int[], int);
 /* prints coefficient of term in polynomial*/
 void print_coef(int, int, int);
 /* prints star of term in polynomial */
 void print_star(int, int);
 /* prints x and power of term in polynomial*/
 void print_xpow(int);

 void display_poly(int pol[], int deg) {
 int i;
 if (deg == 0) {
 printf( ____A____ );
 } else {
 for (i = deg; i >= 0; i--) {
 if (pol[i] != 0) {
 print_coef( ____B____ , deg);
 print_star( ____B____ );
 print_xpow(i);
 }
 }
 }
 printf("\n");
 }

 - 30 -

void print_coef(int coef, int pow, int deg) {
 if (coef == 1) {
 if (pow == 0) {
 printf( ____C____ );
 } else if (pow < deg) {
 printf("+");
 }
 } else if (coef == -1) {
 printf( ____D____ );
 if (pow == 0) {
 printf("1");
 }
 } else {
 if (coef > 1 && pow < deg) {
 printf("+");
 }
 printf("%d", coef);
 }
}

void print_star(int coef, int pow) {
 if ( ____E____ && coef != 1 && coef != -1) {
 printf("*");
 }
}

void print_xpow(int pow) {
 if (pow > 0) {
 printf("x");
 }
 if (pow > 1) {
 printf("^%d", pow);
 }
}

int main() {
 int pol[5] = {11, 1, -1, 0, -7};

 display_poly(pol, 4);
 return 0;
}

 - 31 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above program.

 Answer group for A
 a) "%d", 0 b) "%d", pol[0]
 c) "+%d", pol[deg] d) "-%d", pol[deg]

 Answer group for B
 a) *pol, deg - i b) pol[0], deg - i
 c) pol[i], deg - i d) pol[i], i
 e) pol[i + 1], deg - i f) pol[i + 1], i

 Answer group for C and D
 a) "" b) "+"
 c) "+1" d) "+x"
 e) "-" f) "-1"
 g) "-x" h) "1"

 Answer group for E
 a) pow == 0 b) pow > 0
 c) pow != 1 d) pow > 1

Subquestion 2
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the following description. It is assumed that the correct answers are inserted
 in all of the blanks ___A___ to ___E___.

 (1) The function print_xpow is modified as follows:

 void print_xpow(int pow) {
 if (pow > 0) {
 printf("x^%d", pow);
 }
 }

 When the program is executed, the program outputs ____F____.

 - 32 -

(2) Inadvertently, function main is modified as follows:

 int main() {
 int pol[3] = {0, 0, 0};

 display_poly(pol, 2);
 return 0;
 }

 This modification violates the rule that the leading coefficient, which is the last element
 of the array, is always non-zero except for a zero polynomial represented by {0}. In this
 case, when the program is executed, the program outputs ____G____. Here, ignore
 the modification in (1) above.

Answer group for F
 a) -7*x^4+0*x^3-1*x^2+1*x^1+11
 b) -7*x^4+0*x^3-1*x^2+1*x^1+11*x^0
 c) -7*x^4-x^2+x+11
 d) -7*x^4-x^2+x^1+11
 e) -7*x^4-x^2+x^1+11*x^0

Answer group for G
 a) 0
 b) 00
 c) 0*x^2
 d) 0*x^2+0
 e) a blank line (''\n'' only)

 - 33 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/b/questions.pdf","pages":[29,30,31,32,33]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-april',
  'B',
  8,
  'Q8. Read the following description of Java programs and the programs themselves, and then
 answer Subquestions 1 and 2.

[Program Description]
 This program is a prototype component for implementing the forward and backward buttons
 in a web browser-like application. As a user visits different web pages using the application,
 the visit history, a list of visited web pages, is maintained. The planned application
 functionality is that the user can go backward by clicking the back button and revisit
 previously visited web pages, and that the user can also sequentially return to the most
 recently visited web page by clicking the forward button. This is a partial implementation
 to assist the application to traverse the visit history.

The WebPage class (Program 1) denotes one visited web page at a particular time. The class
 has following members.
 (1) The WebPage constructor creates a WebPage with the URL and timestamp parameters.
 (2) The url field denotes the visited web page represented by a URL string.
 (3) The date field represents the timestamp of the web page visit.
 (4) The toString method returns the text representation of this object.

[Program 1]

public class WebPage {
 private final String url;
 private final String date;

WebPage(String url, String date) {
 this.url = url;
 this.date = date;
 }

public ***A*** toString() {
 return "URL: " + url + "\tAccessed: " + date;
 }
 }

The WebVisitHistory class (Program 2) is a partial implementation for managing the visit
 history. The class has the following members:
 (1) Node is a nested class representing each point in the visit history with the following
 members.
 (i) The webPage field represents the visited web page.
 (ii) The previous field is a reference to the Node representing the previously visited web
 page immediately before the web page represented by this Node. If there is no such
 previous web page, it refers to the oldestMarker field (see below).

- 34 -

(iii) The next field is a reference to the Node representing the visited web page
 immediately after the web page represented by this Node. If there is no such next
 web page, it refers to the newestMarker field (see below).
(2) The oldestMarker and newestMarker fields are two sentinel constants to mark the
 boundaries of the linked list of the visited web pages. oldestMarker refers to the first
 visited web page, and newestMarker refers to the last visited one.
(3) The length field keeps count of the visited web pages, and the length method returns
 the field value.
(4) The WebVisitHistory constructor initializes an empty visit history with only the
 boundary markers being adjacent to each other.
(5) The isEmpty method returns true if there are no web pages in the visit history, or false,
 otherwise.
(6) The add method adds the specified WebPage to the visit history as the last web page
 visited.
(7) The historyIterator method returns a history iterator to iterate the visit history data.
(8) The HistoryIterator inner class implements the java.util.ListIterator interface
 that supports the bidirectional iterations of the visit history data. An iterator maintains
 its position that always lies between Nodes representing visited web pages or the
 sentinels. The initial position for the iteration is set to the end of the visit history (i.e.,
 no next web page) so that it is possible to start iterating the visit history backward. The
 class has the following methods.
 (i) The hasNext method returns true if there are any web pages in the forward direction,
 or false, otherwise.
 (ii) The hasPrevious method returns true if there are any web pages in the backward
 direction, or false, otherwise.
 (iii) The next method returns the next web page and advances the position. If there is no
 next one, a NoSuchElementException is thrown.
 (iv) The previous method returns the previous web page and moves the position
 backward. If there is no previous one, a NoSuchElementException is thrown.
 (v) The nextIndex method returns the index of the web page that would be returned by
 a subsequent call to the next method, or the length value if this iterator is at the end
 of the visit history.
 (iv) The previousIndex method returns the index of the web page that would be
 returned by a subsequent call to the previous method, or -1 if this iterator is at the
 beginning of the visit history.
 (vii) The remove, add, and set methods are unsupported.

- 35 -

[Program 2]

import java.util.ListIterator;
 import java.util.NoSuchElementException;

public class WebVisitHistory {
 private final Node oldestMarker, newestMarker;
 private int length;

public WebVisitHistory() {
 oldestMarker = new Node(null);
 newestMarker = new Node(null);
 oldestMarker.next = newestMarker;
 newestMarker.previous = oldestMarker;
 }

private static class Node {
 private final WebPage webPage;
 private Node previous, next;

Node(WebPage webPage) {
 this.webPage = webPage;
 }
 }

public boolean isEmpty() {
 return length() == 0;
 }

public int length() {
 return length;
 }

public void add(WebPage webPage) {
 Node newNode = new Node(webPage);

Node backup = newestMarker.previous;
 newestMarker.previous = ***B*** ;
 backup.next = ***B*** ;
 newNode.next = newestMarker;
 newNode.previous = ***C***;
 ++length;
 }
 public ListIterator<WebPage> historyIterator() {
 return new HistoryIterator();
 }

- 36 -

private class HistoryIterator implements ListIterator<WebPage> {
 private Node current = newestMarker;
 private int index = length();

public boolean hasNext() {
 return current != newestMarker;
 }

public boolean hasPrevious() {
 return current.previous != oldestMarker;
 }

public WebPage next() {
 if (!hasNext()) {
 throw new NoSuchElementException();
 }
 WebPage webPage = current.webPage;
 current = ***D*** ;
 index++;
 return webPage;
 }

public WebPage previous() {
 if (!hasPrevious()) {
 throw new NoSuchElementException();
 }
 current = ***E*** ;
 index--;
 return current.webPage;
 }

public int nextIndex() {
 return ***F*** ;
 }

public int previousIndex() {
 return index - 1;
 }

public void remove() {
 throw new UnsupportedOperationException("unsupported");
 }

public void set(WebPage webPage) {
 throw new UnsupportedOperationException("unsupported");
 }

public void add(WebPage webPage) {
 throw new UnsupportedOperationException("unsupported");
 }
 }
}

- 37 -

The Tester class (Program 3) tests the implementation of iterations and generates the
following output:

Visited Pages: 4
Going backward:
index: 3 URL: https://example.com/p4.html Accessed: 2021-01-01 00:00:30
index: 2 URL: https://example.com/p3.html Accessed: 2021-01-01 00:00:20
index: 1 URL: https://example.com/p2.html Accessed: 2021-01-01 00:00:10
index: 0 URL: https://example.com/p1.html Accessed: 2021-01-01 00:00:00
Going forward:
index: 0 URL: https://example.com/p1.html Accessed: 2021-01-01 00:00:00
index: 1 URL: https://example.com/p2.html Accessed: 2021-01-01 00:00:10
index: 2 URL: https://example.com/p3.html Accessed: 2021-01-01 00:00:20
index: 3 URL: https://example.com/p4.html Accessed: 2021-01-01 00:00:30

[Program 3]

import java.util.ListIterator;

public class Tester {
 private static final String URL_TEMPLATE
 = "https://example.com/p%d.html";
 private static final int N_PAGES = 4;

public static void main(String[] args) {
 WebVisitHistory history = new WebVisitHistory();
 for (int i = 0; i < N_PAGES; ++i) {
 int t = i * 10;
 history.add(new WebPage(String.format(URL_TEMPLATE, i + 1),
 String.format("2021-01-01 00:%02d:%02d", t / 60, t % 60)));
 }

System.out.printf("Visited Pages: %d%n", history.length());
 ListIterator<WebPage> historyIterator =
 history.historyIterator();
 if (historyIterator.nextIndex() != history.length()) {
 throw new AssertionError();
 }
 System.out.println("Going backward:");
 while (historyIterator.hasPrevious()) {
 System.out.printf("index: %d %s%n",
 historyIterator.previousIndex(),
 historyIterator.previous());
 }

- 38 -

if (historyIterator.previousIndex() != -1) {
 throw new AssertionError();
 }
 System.out.println("Going forward:");
 while (historyIterator.hasNext()) {
 System.out.printf("index: %d %s%n",
 historyIterator.nextIndex(), historyIterator.next());
 }
 }
 }

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above programs.

Answer group for A
 a) Date b) Object c) String
 d) URL e) WebPage

Answer group for B and C
 a) backup b) backup.previous
 c) new Node(webPage) d) newestMarker.previous
 e) newNode f) oldestMarker.next

Answer group for D and E
 a) current.next b) current.next.next
 c) current.previous d) current.previous.previous
 e) newestMarker.previous f) oldestMarker.next

Answer group for F
 a) ++index b) index
 c) index + 1 d) index == length() ? index : index + 1
 e) index++

- 39 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following program.

As the next step of prototyping, new method removeRestAfter (Program 4) is added to the
 WebVisitHistory class. The method removes all Nodes after the Node having the specified
 WebPage to allow a new visit history path to be started after the WebPage. If there is no
 specified WebPage found on the visit history, a NoSuchElementException is thrown.
 Removing any visit history data makes any existing history iterators (ListIterators) void,
 and new history iterators must be obtained by calling the historyIterator method after
 the removal.

[Program 4]

public void removeRestAfter(WebPage webPage) {
 int count = 0;
 for (Node node = newestMarker.previous;
 node != oldestMarker; node = node.previous) {
 if (node.webPage == webPage) {
 node.next = ***G***;
 newestMarker.previous = node;
 length -= count;
 return;
 }
 count++;
 }
 throw new NoSuchElementException();
 }',
  '[{"type":"prompt","text":"Q8. Read the following description of Java programs and the programs themselves, and then\n answer Subquestions 1 and 2."},{"type":"context","text":"[Program Description]\n This program is a prototype component for implementing the forward and backward buttons\n in a web browser-like application. As a user visits different web pages using the application,\n the visit history, a list of visited web pages, is maintained. The planned application\n functionality is that the user can go backward by clicking the back button and revisit\n previously visited web pages, and that the user can also sequentially return to the most\n recently visited web page by clicking the forward button. This is a partial implementation\n to assist the application to traverse the visit history.\n\nThe WebPage class (Program 1) denotes one visited web page at a particular time. The class\n has following members.\n (1) The WebPage constructor creates a WebPage with the URL and timestamp parameters.\n (2) The url field denotes the visited web page represented by a URL string.\n (3) The date field represents the timestamp of the web page visit.\n (4) The toString method returns the text representation of this object.\n\n[Program 1]\n\npublic class WebPage {\n private final String url;\n private final String date;\n\nWebPage(String url, String date) {\n this.url = url;\n this.date = date;\n }\n\npublic ***A*** toString() {\n return \"URL: \" + url + \"\\tAccessed: \" + date;\n }\n }\n\nThe WebVisitHistory class (Program 2) is a partial implementation for managing the visit\n history. The class has the following members:\n (1) Node is a nested class representing each point in the visit history with the following\n members.\n (i) The webPage field represents the visited web page.\n (ii) The previous field is a reference to the Node representing the previously visited web\n page immediately before the web page represented by this Node. If there is no such\n previous web page, it refers to the oldestMarker field (see below).\n\n- 34 -\n\n(iii) The next field is a reference to the Node representing the visited web page\n immediately after the web page represented by this Node. If there is no such next\n web page, it refers to the newestMarker field (see below).\n(2) The oldestMarker and newestMarker fields are two sentinel constants to mark the\n boundaries of the linked list of the visited web pages. oldestMarker refers to the first\n visited web page, and newestMarker refers to the last visited one.\n(3) The length field keeps count of the visited web pages, and the length method returns\n the field value.\n(4) The WebVisitHistory constructor initializes an empty visit history with only the\n boundary markers being adjacent to each other.\n(5) The isEmpty method returns true if there are no web pages in the visit history, or false,\n otherwise.\n(6) The add method adds the specified WebPage to the visit history as the last web page\n visited.\n(7) The historyIterator method returns a history iterator to iterate the visit history data.\n(8) The HistoryIterator inner class implements the java.util.ListIterator interface\n that supports the bidirectional iterations of the visit history data. An iterator maintains\n its position that always lies between Nodes representing visited web pages or the\n sentinels. The initial position for the iteration is set to the end of the visit history (i.e.,\n no next web page) so that it is possible to start iterating the visit history backward. The\n class has the following methods.\n (i) The hasNext method returns true if there are any web pages in the forward direction,\n or false, otherwise.\n (ii) The hasPrevious method returns true if there are any web pages in the backward\n direction, or false, otherwise.\n (iii) The next method returns the next web page and advances the position. If there is no\n next one, a NoSuchElementException is thrown.\n (iv) The previous method returns the previous web page and moves the position\n backward. If there is no previous one, a NoSuchElementException is thrown.\n (v) The nextIndex method returns the index of the web page that would be returned by\n a subsequent call to the next method, or the length value if this iterator is at the end\n of the visit history.\n (iv) The previousIndex method returns the index of the web page that would be\n returned by a subsequent call to the previous method, or -1 if this iterator is at the\n beginning of the visit history.\n (vii) The remove, add, and set methods are unsupported.\n\n- 35 -\n\n[Program 2]\n\nimport java.util.ListIterator;\n import java.util.NoSuchElementException;\n\npublic class WebVisitHistory {\n private final Node oldestMarker, newestMarker;\n private int length;\n\npublic WebVisitHistory() {\n oldestMarker = new Node(null);\n newestMarker = new Node(null);\n oldestMarker.next = newestMarker;\n newestMarker.previous = oldestMarker;\n }\n\nprivate static class Node {\n private final WebPage webPage;\n private Node previous, next;\n\nNode(WebPage webPage) {\n this.webPage = webPage;\n }\n }\n\npublic boolean isEmpty() {\n return length() == 0;\n }\n\npublic int length() {\n return length;\n }\n\npublic void add(WebPage webPage) {\n Node newNode = new Node(webPage);\n\nNode backup = newestMarker.previous;\n newestMarker.previous = ***B*** ;\n backup.next = ***B*** ;\n newNode.next = newestMarker;\n newNode.previous = ***C***;\n ++length;\n }\n public ListIterator<WebPage> historyIterator() {\n return new HistoryIterator();\n }\n\n- 36 -\n\nprivate class HistoryIterator implements ListIterator<WebPage> {\n private Node current = newestMarker;\n private int index = length();\n\npublic boolean hasNext() {\n return current != newestMarker;\n }\n\npublic boolean hasPrevious() {\n return current.previous != oldestMarker;\n }\n\npublic WebPage next() {\n if (!hasNext()) {\n throw new NoSuchElementException();\n }\n WebPage webPage = current.webPage;\n current = ***D*** ;\n index++;\n return webPage;\n }\n\npublic WebPage previous() {\n if (!hasPrevious()) {\n throw new NoSuchElementException();\n }\n current = ***E*** ;\n index--;\n return current.webPage;\n }\n\npublic int nextIndex() {\n return ***F*** ;\n }\n\npublic int previousIndex() {\n return index - 1;\n }\n\npublic void remove() {\n throw new UnsupportedOperationException(\"unsupported\");\n }\n\npublic void set(WebPage webPage) {\n throw new UnsupportedOperationException(\"unsupported\");\n }\n\npublic void add(WebPage webPage) {\n throw new UnsupportedOperationException(\"unsupported\");\n }\n }\n}\n\n- 37 -\n\nThe Tester class (Program 3) tests the implementation of iterations and generates the\nfollowing output:\n\nVisited Pages: 4\nGoing backward:\nindex: 3 URL: https://example.com/p4.html Accessed: 2021-01-01 00:00:30\nindex: 2 URL: https://example.com/p3.html Accessed: 2021-01-01 00:00:20\nindex: 1 URL: https://example.com/p2.html Accessed: 2021-01-01 00:00:10\nindex: 0 URL: https://example.com/p1.html Accessed: 2021-01-01 00:00:00\nGoing forward:\nindex: 0 URL: https://example.com/p1.html Accessed: 2021-01-01 00:00:00\nindex: 1 URL: https://example.com/p2.html Accessed: 2021-01-01 00:00:10\nindex: 2 URL: https://example.com/p3.html Accessed: 2021-01-01 00:00:20\nindex: 3 URL: https://example.com/p4.html Accessed: 2021-01-01 00:00:30\n\n[Program 3]\n\nimport java.util.ListIterator;\n\npublic class Tester {\n private static final String URL_TEMPLATE\n = \"https://example.com/p%d.html\";\n private static final int N_PAGES = 4;\n\npublic static void main(String[] args) {\n WebVisitHistory history = new WebVisitHistory();\n for (int i = 0; i < N_PAGES; ++i) {\n int t = i * 10;\n history.add(new WebPage(String.format(URL_TEMPLATE, i + 1),\n String.format(\"2021-01-01 00:%02d:%02d\", t / 60, t % 60)));\n }\n\nSystem.out.printf(\"Visited Pages: %d%n\", history.length());\n ListIterator<WebPage> historyIterator =\n history.historyIterator();\n if (historyIterator.nextIndex() != history.length()) {\n throw new AssertionError();\n }\n System.out.println(\"Going backward:\");\n while (historyIterator.hasPrevious()) {\n System.out.printf(\"index: %d %s%n\",\n historyIterator.previousIndex(),\n historyIterator.previous());\n }\n\n- 38 -\n\nif (historyIterator.previousIndex() != -1) {\n throw new AssertionError();\n }\n System.out.println(\"Going forward:\");\n while (historyIterator.hasNext()) {\n System.out.printf(\"index: %d %s%n\",\n historyIterator.nextIndex(), historyIterator.next());\n }\n }\n }\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the above programs.\n\nAnswer group for A\n a) Date b) Object c) String\n d) URL e) WebPage\n\nAnswer group for B and C\n a) backup b) backup.previous\n c) new Node(webPage) d) newestMarker.previous\n e) newNode f) oldestMarker.next\n\nAnswer group for D and E\n a) current.next b) current.next.next\n c) current.previous d) current.previous.previous\n e) newestMarker.previous f) oldestMarker.next\n\nAnswer group for F\n a) ++index b) index\n c) index + 1 d) index == length() ? index : index + 1\n e) index++\n\n- 39 -\n\nSubquestion 2\n From the answer group below, select the correct answer to be inserted in the blank _______\n in the following program.\n\nAs the next step of prototyping, new method removeRestAfter (Program 4) is added to the\n WebVisitHistory class. The method removes all Nodes after the Node having the specified\n WebPage to allow a new visit history path to be started after the WebPage. If there is no\n specified WebPage found on the visit history, a NoSuchElementException is thrown.\n Removing any visit history data makes any existing history iterators (ListIterators) void,\n and new history iterators must be obtained by calling the historyIterator method after\n the removal.\n\n[Program 4]\n\npublic void removeRestAfter(WebPage webPage) {\n int count = 0;\n for (Node node = newestMarker.previous;\n node != oldestMarker; node = node.previous) {\n if (node.webPage == webPage) {\n node.next = ***G***;\n newestMarker.previous = node;\n length -= count;\n return;\n }\n count++;\n }\n throw new NoSuchElementException();\n }"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"newestMarker"},{"label":"b","text":"newestMarker.previous"},{"label":"c","text":"node"},{"label":"d","text":"node.next"},{"label":"e","text":"node.previous"},{"label":"f","text":"oldestMarker"},{"label":"g","text":"oldestMarker.next\n\n_ _\nCompany names and product names appearing in the test questions are trademarks or registered\ntrademarks of their respective companies. Note that the ® and ™ symbols are not used within the text.\n\n - 40 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "c"}, {"subquestion": 1, "blank": "B", "answer": "e"}, {"subquestion": 1, "blank": "C", "answer": "a"}, {"subquestion": 1, "blank": "D", "answer": "a"}, {"subquestion": 1, "blank": "E", "answer": "c"}, {"subquestion": 1, "blank": "F", "answer": "b"}, {"subquestion": 2, "blank": "G", "answer": "a"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"c"},{"subquestion":1,"blank":"B","answer":"e"},{"subquestion":1,"blank":"C","answer":"a"},{"subquestion":1,"blank":"D","answer":"a"},{"subquestion":1,"blank":"E","answer":"c"},{"subquestion":1,"blank":"F","answer":"b"},{"subquestion":2,"blank":"G","answer":"a"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021S, FE, Subject-B, Q8)',
  ARRAY[34,35,36,37,38,39,40]::int[],
  'native_text',
  '3.0',
  'Q8. Read the following description of Java programs and the programs themselves, and then
 answer Subquestions 1 and 2.

 [Program Description]
 This program is a prototype component for implementing the forward and backward buttons
 in a web browser-like application. As a user visits different web pages using the application,
 the visit history, a list of visited web pages, is maintained. The planned application
 functionality is that the user can go backward by clicking the back button and revisit
 previously visited web pages, and that the user can also sequentially return to the most
 recently visited web page by clicking the forward button. This is a partial implementation
 to assist the application to traverse the visit history.

 The WebPage class (Program 1) denotes one visited web page at a particular time. The class
 has following members.
 (1) The WebPage constructor creates a WebPage with the URL and timestamp parameters.
 (2) The url field denotes the visited web page represented by a URL string.
 (3) The date field represents the timestamp of the web page visit.
 (4) The toString method returns the text representation of this object.

 [Program 1]

 public class WebPage {
 private final String url;
 private final String date;

 WebPage(String url, String date) {
 this.url = url;
 this.date = date;
 }

 public ___A___ toString() {
 return "URL: " + url + "\tAccessed: " + date;
 }
 }

 The WebVisitHistory class (Program 2) is a partial implementation for managing the visit
 history. The class has the following members:
 (1) Node is a nested class representing each point in the visit history with the following
 members.
 (i) The webPage field represents the visited web page.
 (ii) The previous field is a reference to the Node representing the previously visited web
 page immediately before the web page represented by this Node. If there is no such
 previous web page, it refers to the oldestMarker field (see below).

 - 34 -

(iii) The next field is a reference to the Node representing the visited web page
 immediately after the web page represented by this Node. If there is no such next
 web page, it refers to the newestMarker field (see below).
(2) The oldestMarker and newestMarker fields are two sentinel constants to mark the
 boundaries of the linked list of the visited web pages. oldestMarker refers to the first
 visited web page, and newestMarker refers to the last visited one.
(3) The length field keeps count of the visited web pages, and the length method returns
 the field value.
(4) The WebVisitHistory constructor initializes an empty visit history with only the
 boundary markers being adjacent to each other.
(5) The isEmpty method returns true if there are no web pages in the visit history, or false,
 otherwise.
(6) The add method adds the specified WebPage to the visit history as the last web page
 visited.
(7) The historyIterator method returns a history iterator to iterate the visit history data.
(8) The HistoryIterator inner class implements the java.util.ListIterator interface
 that supports the bidirectional iterations of the visit history data. An iterator maintains
 its position that always lies between Nodes representing visited web pages or the
 sentinels. The initial position for the iteration is set to the end of the visit history (i.e.,
 no next web page) so that it is possible to start iterating the visit history backward. The
 class has the following methods.
 (i) The hasNext method returns true if there are any web pages in the forward direction,
 or false, otherwise.
 (ii) The hasPrevious method returns true if there are any web pages in the backward
 direction, or false, otherwise.
 (iii) The next method returns the next web page and advances the position. If there is no
 next one, a NoSuchElementException is thrown.
 (iv) The previous method returns the previous web page and moves the position
 backward. If there is no previous one, a NoSuchElementException is thrown.
 (v) The nextIndex method returns the index of the web page that would be returned by
 a subsequent call to the next method, or the length value if this iterator is at the end
 of the visit history.
 (iv) The previousIndex method returns the index of the web page that would be
 returned by a subsequent call to the previous method, or -1 if this iterator is at the
 beginning of the visit history.
 (vii) The remove, add, and set methods are unsupported.

 - 35 -

[Program 2]

 import java.util.ListIterator;
 import java.util.NoSuchElementException;

 public class WebVisitHistory {
 private final Node oldestMarker, newestMarker;
 private int length;

 public WebVisitHistory() {
 oldestMarker = new Node(null);
 newestMarker = new Node(null);
 oldestMarker.next = newestMarker;
 newestMarker.previous = oldestMarker;
 }

 private static class Node {
 private final WebPage webPage;
 private Node previous, next;

 Node(WebPage webPage) {
 this.webPage = webPage;
 }
 }

 public boolean isEmpty() {
 return length() == 0;
 }

 public int length() {
 return length;
 }

 public void add(WebPage webPage) {
 Node newNode = new Node(webPage);

 Node backup = newestMarker.previous;
 newestMarker.previous = ___B___ ;
 backup.next = ___B___ ;
 newNode.next = newestMarker;
 newNode.previous = ___C___;
 ++length;
 }
 public ListIterator<WebPage> historyIterator() {
 return new HistoryIterator();
 }

 - 36 -

private class HistoryIterator implements ListIterator<WebPage> {
 private Node current = newestMarker;
 private int index = length();

 public boolean hasNext() {
 return current != newestMarker;
 }

 public boolean hasPrevious() {
 return current.previous != oldestMarker;
 }

 public WebPage next() {
 if (!hasNext()) {
 throw new NoSuchElementException();
 }
 WebPage webPage = current.webPage;
 current = ___D___ ;
 index++;
 return webPage;
 }

 public WebPage previous() {
 if (!hasPrevious()) {
 throw new NoSuchElementException();
 }
 current = ___E___ ;
 index--;
 return current.webPage;
 }

 public int nextIndex() {
 return ___F___ ;
 }

 public int previousIndex() {
 return index - 1;
 }

 public void remove() {
 throw new UnsupportedOperationException("unsupported");
 }

 public void set(WebPage webPage) {
 throw new UnsupportedOperationException("unsupported");
 }

 public void add(WebPage webPage) {
 throw new UnsupportedOperationException("unsupported");
 }
 }
}

 - 37 -

The Tester class (Program 3) tests the implementation of iterations and generates the
following output:

Visited Pages: 4
Going backward:
index: 3 URL: https://example.com/p4.html Accessed: 2021-01-01 00:00:30
index: 2 URL: https://example.com/p3.html Accessed: 2021-01-01 00:00:20
index: 1 URL: https://example.com/p2.html Accessed: 2021-01-01 00:00:10
index: 0 URL: https://example.com/p1.html Accessed: 2021-01-01 00:00:00
Going forward:
index: 0 URL: https://example.com/p1.html Accessed: 2021-01-01 00:00:00
index: 1 URL: https://example.com/p2.html Accessed: 2021-01-01 00:00:10
index: 2 URL: https://example.com/p3.html Accessed: 2021-01-01 00:00:20
index: 3 URL: https://example.com/p4.html Accessed: 2021-01-01 00:00:30

[Program 3]

 import java.util.ListIterator;

 public class Tester {
 private static final String URL_TEMPLATE
 = "https://example.com/p%d.html";
 private static final int N_PAGES = 4;

 public static void main(String[] args) {
 WebVisitHistory history = new WebVisitHistory();
 for (int i = 0; i < N_PAGES; ++i) {
 int t = i * 10;
 history.add(new WebPage(String.format(URL_TEMPLATE, i + 1),
 String.format("2021-01-01 00:%02d:%02d", t / 60, t % 60)));
 }

 System.out.printf("Visited Pages: %d%n", history.length());
 ListIterator<WebPage> historyIterator =
 history.historyIterator();
 if (historyIterator.nextIndex() != history.length()) {
 throw new AssertionError();
 }
 System.out.println("Going backward:");
 while (historyIterator.hasPrevious()) {
 System.out.printf("index: %d %s%n",
 historyIterator.previousIndex(),
 historyIterator.previous());
 }

 - 38 -

if (historyIterator.previousIndex() != -1) {
 throw new AssertionError();
 }
 System.out.println("Going forward:");
 while (historyIterator.hasNext()) {
 System.out.printf("index: %d %s%n",
 historyIterator.nextIndex(), historyIterator.next());
 }
 }
 }

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above programs.

 Answer group for A
 a) Date b) Object c) String
 d) URL e) WebPage

 Answer group for B and C
 a) backup b) backup.previous
 c) new Node(webPage) d) newestMarker.previous
 e) newNode f) oldestMarker.next

 Answer group for D and E
 a) current.next b) current.next.next
 c) current.previous d) current.previous.previous
 e) newestMarker.previous f) oldestMarker.next

 Answer group for F
 a) ++index b) index
 c) index + 1 d) index == length() ? index : index + 1
 e) index++

 - 39 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following program.

 As the next step of prototyping, new method removeRestAfter (Program 4) is added to the
 WebVisitHistory class. The method removes all Nodes after the Node having the specified
 WebPage to allow a new visit history path to be started after the WebPage. If there is no
 specified WebPage found on the visit history, a NoSuchElementException is thrown.
 Removing any visit history data makes any existing history iterators (ListIterators) void,
 and new history iterators must be obtained by calling the historyIterator method after
 the removal.

 [Program 4]

 public void removeRestAfter(WebPage webPage) {
 int count = 0;
 for (Node node = newestMarker.previous;
 node != oldestMarker; node = node.previous) {
 if (node.webPage == webPage) {
 node.next = ___G___;
 newestMarker.previous = node;
 length -= count;
 return;
 }
 count++;
 }
 throw new NoSuchElementException();
 }

 Answer group for G
 a) newestMarker b) newestMarker.previous
 c) node d) node.next
 e) node.previous f) oldestMarker
 g) oldestMarker.next

_ _
Company names and product names appearing in the test questions are trademarks or registered
trademarks of their respective companies. Note that the ® and ™ symbols are not used within the text.

 - 40 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-april/b/questions.pdf","pages":[34,35,36,37,38,39,40]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-april/b/answers.pdf","pages":[1]}}'::jsonb,
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
VALUES ('2021-april', 'A', '2021 April FE Subject A', 60, 150, 5, true)
ON CONFLICT (exam_session, subject) DO UPDATE SET
  title = EXCLUDED.title, question_count = EXCLUDED.question_count,
  time_limit_minutes = EXCLUDED.time_limit_minutes, published = EXCLUDED.published;

DELETE FROM exam_questions
WHERE exam_id = (SELECT id FROM exams WHERE exam_session = '2021-april' AND subject = 'A');
INSERT INTO exam_questions (exam_id, question_id, sequence_number)
SELECT e.id, q.id, q.question_number
FROM exams e
JOIN questions q ON q.exam_session = e.exam_session AND q.subject = e.subject
WHERE e.exam_session = '2021-april' AND e.subject = 'A'
ORDER BY q.question_number;

INSERT INTO exams (exam_session, subject, title, question_count, time_limit_minutes, initial_hearts, published)
VALUES ('2021-april', 'B', '2021 April FE Subject B', 8, 150, 5, true)
ON CONFLICT (exam_session, subject) DO UPDATE SET
  title = EXCLUDED.title, question_count = EXCLUDED.question_count,
  time_limit_minutes = EXCLUDED.time_limit_minutes, published = EXCLUDED.published;

DELETE FROM exam_questions
WHERE exam_id = (SELECT id FROM exams WHERE exam_session = '2021-april' AND subject = 'B');
INSERT INTO exam_questions (exam_id, question_id, sequence_number)
SELECT e.id, q.id, q.question_number
FROM exams e
JOIN questions q ON q.exam_session = e.exam_session AND q.subject = e.subject
WHERE e.exam_session = '2021-april' AND e.subject = 'B'
ORDER BY q.question_number;

COMMIT;
