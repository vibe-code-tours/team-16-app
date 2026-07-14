-- NerdQuiz seed: 2021 October FE Subjects A and B
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
  '2021-october',
  'A',
  1,
  'Q1. What is the octal equivalent value of the hexadecimal number 7B5?',
  '[{"type":"text","page":3,"bbox":[65.22,67.74,420.76,81.19],"text":"Q1.  What is the octal equivalent value of the hexadecimal number 7B5?"},{"type":"text","page":3,"bbox":[65.22,104.93,491.22,136.21],"text":"a) 735\nb) 3665\nc) 7551\nd)\n7561"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"735"},{"label":"b","text":"3665"},{"label":"c","text":"7551"},{"label":"d","text":"7561"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q1)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q1. What is the octal equivalent value of the hexadecimal number 7B5?

 a) 735 b) 3665 c) 7551 d) 7561',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  2,
  'Q2. For a non-negative integer x, which of the following gives the remainder after division of x
 by 8 as a result?',
  '[{"type":"text","page":3,"bbox":[65.22,140.93,533.1,171.19],"text":"Q2.  For a non-negative integer x, which of the following gives the remainder after division of x"},{"type":"text","page":3,"bbox":[83.28,175.85,163.63,189.13],"text":"by 8 as a result?"},{"type":"text","page":3,"bbox":[65.22,212.93,347.76,298.21],"text":"a) Performing a bitwise AND operation on x and 7\nb) Performing a bitwise AND operation on x and 248\nc) Performing a bitwise OR operation on x and 8\nd) Performing a bitwise OR operation on x and 15"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Performing a bitwise AND operation on x and 7"},{"label":"b","text":"Performing a bitwise AND operation on x and 248"},{"label":"c","text":"Performing a bitwise OR operation on x and 8"},{"label":"d","text":"Performing a bitwise OR operation on x and 15"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q2)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q2. For a non-negative integer x, which of the following gives the remainder after division of x
 by 8 as a result?

 a) Performing a bitwise AND operation on x and 7
 b) Performing a bitwise AND operation on x and 248
 c) Performing a bitwise OR operation on x and 8
 d) Performing a bitwise OR operation on x and 15',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  3,
  'Q3. For three sets A, B and C, which of the following equalities holds? Here,  and are
 the union and intersection symbols, respectively.',
  '[{"type":"text","page":3,"bbox":[65.22,302.93,533.07,336.07],"text":"Q3.  For three sets A, B and C, which of the following equalities holds? Here,  and are"},{"type":"text","page":3,"bbox":[83.22,337.85,319.75,351.13],"text":"the union and intersection symbols, respectively."},{"type":"text","page":3,"bbox":[84.12,374.93,323.76,445.57],"text":"a) (A B ) (A C ) = B (A C)\nb) (A B ) C = (A C) (B C)\nc) (A C ) (B A) = (A B) (B C)\nd) (A C ) (B C) = (A B) C"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"(A B ) (A C ) = B (A C)"},{"label":"b","text":"(A B ) C = (A C) (B C)"},{"label":"c","text":"(A C ) (B A) = (A B) (B C)"},{"label":"d","text":"(A C ) (B C) = (A B) C"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q3)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q3. For three sets A, B and C, which of the following equalities holds? Here,  and are
 the union and intersection symbols, respectively.

 a) (A B ) (A C ) = B (A C)
 b) (A B ) C = (A C) (B C)
 c) (A C ) (B A) = (A B) (B C)
 d) (A C ) (B C) = (A B) C',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  4,
  'Q4. An adjacency matrix is used to indicate which vertices of a directed or undirected graph are
 adjacent to each other. Which of the following is an appropriate matrix that represents the
 directed graph below?',
  '[{"type":"text","page":3,"bbox":[65.22,464.93,533.11,495.19],"text":"Q4.  An adjacency matrix is used to indicate which vertices of a directed or undirected graph are"},{"type":"text","page":3,"bbox":[83.22,499.85,533.12,531.13],"text":"adjacent to each other. Which of the following is an appropriate matrix that represents the\ndirected graph below?"},{"type":"text","page":3,"bbox":[96.12,591.4,481.86,621.13],"text":"a)\n\n\n\n\nb)\n\n\n\n\nc)\n\n\n\n\nd)"},{"type":"text","page":3,"bbox":[96.12,626.4,488.94,638.55],"text":"A B C\n\n\nA B C\n\n\nA B C\n\n\nA B C"},{"type":"table","page":3,"bbox":[110.88,641.46,164.22,696.96],"rows":[["1","1","1"],["1","1","1"],["0","0","1"]]},{"type":"table","page":3,"bbox":[220.2,641.46,273.6,696.96],"rows":[["1","0","1"],["0","1","0"],["1","1","1"]]},{"type":"table","page":3,"bbox":[328.92,641.46,382.26,696.96],"rows":[["0","1","1"],["1","0","1"],["0","0","1"]]},{"type":"table","page":3,"bbox":[438.3,641.46,491.64,696.96],"rows":[["0","1","0"],["1","0","1"],["0","0","0"]]},{"type":"text","page":3,"bbox":[96.12,644.88,487.13,657.03],"text":"A\n1\n1\n1\n\n\nA\n1\n0\n1\n\n\nA\n0\n1\n1\n\n\nA\n0\n1\n0"},{"type":"text","page":3,"bbox":[96.12,663.36,487.13,675.51],"text":"B\n1\n1\n1\n\n\nB\n0\n1\n0\n\n\nB\n1\n0\n1\n\n\nB\n1\n0\n1"},{"type":"text","page":3,"bbox":[96.12,681.9,487.13,694.05],"text":"C\n0\n0\n1\n\n\nC\n1\n1\n1\n\n\nC\n0\n0\n1\n\n\nC\n0\n0\n0"},{"type":"code","page":3,"bbox":[65.22,794.63,311.58,808.39],"text":"– 3 –"}]'::jsonb,
  '["2021-october-a-q04-figure1.webp"]'::jsonb,
  '[{"label":"a","text":""},{"label":"b","text":""},{"label":"c","text":""},{"label":"d","text":"A B C A B C A B C A B C\n\n A 1 1 1 A 1 0 1 A 0 1 1 A 0 1 0\n\n B 1 1 1 B 0 1 0 B 1 0 1 B 1 0 1\n\n C 0 0 1 C 1 1 1 C 0 0 1 C 0 0 0\n\n – 3 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q4)',
  ARRAY[3]::int[],
  'native_text',
  '3.0',
  'Q4. An adjacency matrix is used to indicate which vertices of a directed or undirected graph are
 adjacent to each other. Which of the following is an appropriate matrix that represents the
 directed graph below?

 a) b) c) d)
 A B C A B C A B C A B C

 A 1 1 1 A 1 0 1 A 0 1 1 A 0 1 0

 B 1 1 1 B 0 1 0 B 1 0 1 B 1 0 1

 C 0 0 1 C 1 1 1 C 0 0 1 C 0 0 0

 – 3 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[3]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  5,
  'Q5. When sorting an array of n elements by using a randomized version of the quicksort
 algorithm, where the pivot is selected randomly, which of the following shows the averagecase and the worst-case time complexities? Here, big-O notation, O(x), is used to denote the
 growth rate.

 Average-case time Worst-case time
 complexity complexity',
  '[{"type":"text","page":4,"bbox":[65.22,67.74,533.12,135.13],"text":"Q5.\nWhen sorting an array of n elements by using a randomized version of the quicksort\nalgorithm, where the pivot is selected randomly, which of the following shows the average-\ncase and the worst-case time complexities? Here, big-O notation, O(x), is used to denote the\ngrowth rate."},{"type":"table","page":4,"bbox":[86.52,155.46,361.62,264.96],"rows":[[null,"Average-case time\ncomplexity","Worst-case time\ncomplexity"],["a)","O(nlog n)","O(n)"],["b)","O(nlog n)","O(n2)"],["c)","O(n2log n)","O(n)"],["d)","O(n2log n)","O(n2)"]]},{"type":"text","page":4,"bbox":[91.44,156.23,218.06,172.09],"text":"Average-case time"},{"type":"text","page":4,"bbox":[258.6,156.23,339.99,169.51],"text":"Worst-case time"},{"type":"text","page":4,"bbox":[91.8,170.03,327.78,200.65],"text":"complexity\na)\nO(nlog n)\nO(n)"},{"type":"text","page":4,"bbox":[143.22,170.03,200.22,183.31],"text":"complexity"},{"type":"text","page":4,"bbox":[91.44,206.79,314.82,220.99],"text":"b)\nO(nlog n)\nO(n2)"},{"type":"text","page":4,"bbox":[91.8,227.61,312.84,241.33],"text":"c)\nO(n2log n)\nO(n)"},{"type":"text","page":4,"bbox":[91.44,247.47,314.82,261.67],"text":"d)\nO(n2log n)\nO(n2)"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"O(nlog n) O(n)"},{"label":"b","text":"O(nlog n) O(n2)"},{"label":"c","text":"O(n2log n) O(n)"},{"label":"d","text":"O(n2log n) O(n2)"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q5)',
  ARRAY[4]::int[],
  'native_text',
  '3.0',
  'Q5. When sorting an array of n elements by using a randomized version of the quicksort
 algorithm, where the pivot is selected randomly, which of the following shows the averagecase and the worst-case time complexities? Here, big-O notation, O(x), is used to denote the
 growth rate.

 Average-case time Worst-case time
 complexity complexity
 a) O(nlog n) O(n)
 b) O(nlog n) O(n2)
 c) O(n2log n) O(n)
 d) O(n2log n) O(n2)',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[4]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  6,
  'Q6. For an automaton with input and output symbols {0, 1} and a state transition diagram
 shown below, which of the following is the output string for the input string 0011001110?
 Here, S1 represents the initial state, and the label x/y on each arc indicates that if x is an
 input, then y is the corresponding output at the state transition.

 0/0 1/1

 1/0 1/1
 S1 S2 S3
 0/0

 0/0',
  '[{"type":"text","page":4,"bbox":[65.22,286.74,509.96,317.17],"text":"Q6.  For an automaton with input and output symbols {0, 1} and a state transition diagram"},{"type":"text","page":4,"bbox":[85.08,321.83,518.98,371.11],"text":"shown below, which of the following is the output string for the input string 0011001110?\nHere, S1 represents the initial state, and the label x/y on each arc indicates that if x is an\ninput, then y is the corresponding output at the state transition."},{"type":"text","page":4,"bbox":[228.78,418.89,379.72,432.09],"text":"0/0\n1/1"},{"type":"text","page":4,"bbox":[330.18,444.57,377.11,475.95],"text":"1/1\nS3"},{"type":"text","page":4,"bbox":[262.86,444.87,278.14,457.95],"text":"1/0"},{"type":"text","page":4,"bbox":[231.36,462.03,309.49,482.79],"text":"S2\nS1\n0/0"},{"type":"text","page":4,"bbox":[296.58,490.11,311.86,503.19],"text":"0/0"},{"type":"text","page":4,"bbox":[65.22,544.91,390.48,612.19],"text":"a) 0001000110\nb) 0001001110\nc) 0010001000\nd) 0011111110"},{"type":"code","page":4,"bbox":[65.22,794.63,311.58,808.39],"text":"– 4 –"}]'::jsonb,
  '["2021-october-a-q06-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"0001000110"},{"label":"b","text":"0001001110"},{"label":"c","text":"0010001000"},{"label":"d","text":"0011111110\n\n – 4 –"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q6)',
  ARRAY[4]::int[],
  'native_text',
  '3.0',
  'Q6. For an automaton with input and output symbols {0, 1} and a state transition diagram
 shown below, which of the following is the output string for the input string 0011001110?
 Here, S1 represents the initial state, and the label x/y on each arc indicates that if x is an
 input, then y is the corresponding output at the state transition.

 0/0 1/1

 1/0 1/1
 S1 S2 S3
 0/0

 0/0

 a) 0001000110 b) 0001001110
 c) 0010001000 d) 0011111110

 – 4 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[4]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  7,
  'Q7. After the procedure shown below has been executed in the listed order, which value will be
 stored in variable y? Here, the stack and queue structures are initially empty, and the four types
 of operations are defined as shown below.

 [Operations]
 push(x): Add the value of x onto the top of the stack.
 pop(): Remove a value from the top of the stack, then return the value.
 enq(x): Add the value of x into the rear of the queue.
 deq(): Remove a value from the front of the queue, then return the value.

 [Procedure]
 enq(1)
 enq(2)
 push(3)
 push(deq())
 enq(4)
 push(deq())
 y ← pop()',
  '[{"type":"text","page":5,"bbox":[65.22,67.74,533.16,81.19],"text":"Q7.  After the procedure shown below has been executed in the listed order, which value will be"},{"type":"text","page":5,"bbox":[83.22,85.85,533.08,117.13],"text":"stored in variable y? Here, the stack and queue structures are initially empty, and the four types\nof operations are defined as shown below."},{"type":"text","page":5,"bbox":[71.76,140.93,165.36,154.21],"text":"[Operations]"},{"type":"text","page":5,"bbox":[114.9,158.93,492.41,226.21],"text":"push(x):\nAdd the value of x onto the top of the stack.\npop():\nRemove a value from the top of the stack, then return the value.\nenq(x):\nAdd the value of x into the rear of the queue.\ndeq():\nRemove a value from the front of the queue, then return the value."},{"type":"text","page":5,"bbox":[100.62,239.93,160.26,253.21],"text":"[Procedure]"},{"type":"text","page":5,"bbox":[70.86,257.93,173.76,397.21],"text":"enq(1)\nenq(2)\npush(3)\npush(deq())\nenq(4)\npush(deq())\ny ← pop()"},{"type":"text","page":5,"bbox":[84.12,401.76,464.44,415.21],"text":"a) 1\nb) 2\nc) 3\nd) 4"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"1"},{"label":"b","text":"2"},{"label":"c","text":"3"},{"label":"d","text":"4"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q7)',
  ARRAY[5]::int[],
  'native_text',
  '3.0',
  'Q7. After the procedure shown below has been executed in the listed order, which value will be
 stored in variable y? Here, the stack and queue structures are initially empty, and the four types
 of operations are defined as shown below.

 [Operations]
 push(x): Add the value of x onto the top of the stack.
 pop(): Remove a value from the top of the stack, then return the value.
 enq(x): Add the value of x into the rear of the queue.
 deq(): Remove a value from the front of the queue, then return the value.

 [Procedure]
 enq(1)
 enq(2)
 push(3)
 push(deq())
 enq(4)
 push(deq())
 y ← pop()

 a) 1 b) 2 c) 3 d) 4',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[5]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  8,
  'Q8. Which of the following is the name for the tree depicted below? Here, the number in each
 node represents the key of the node.

 5

 3 7

 2 4 6 9

 1 8 10',
  '[{"type":"text","page":5,"bbox":[65.22,455.76,525.62,469.21],"text":"Q8.  Which of the following is the name for the tree depicted below? Here, the number in each"},{"type":"text","page":5,"bbox":[65.22,473.93,259.14,504.13],"text":"node represents the key of the node."},{"type":"text","page":5,"bbox":[277.38,514.15,283.42,527.18],"text":"5"},{"type":"text","page":5,"bbox":[203.22,555.85,209.26,568.88],"text":"3"},{"type":"text","page":5,"bbox":[345.9,555.85,351.94,568.88],"text":"7"},{"type":"text","page":5,"bbox":[160.38,583.63,252.04,596.66],"text":"2\n4"},{"type":"text","page":5,"bbox":[303.12,583.63,394.78,596.66],"text":"6\n9"},{"type":"text","page":5,"bbox":[65.22,611.41,449.04,649.21],"text":"8\n10"},{"type":"text","page":5,"bbox":[117.6,611.41,123.64,624.44],"text":"1"},{"type":"text","page":5,"bbox":[84.12,653.93,423.84,721.21],"text":"a) Balanced tree\nb) Binary search tree\nc) Max heap\nd) Min heap"},{"type":"code","page":5,"bbox":[65.22,794.63,311.58,808.39],"text":"– 5 –"}]'::jsonb,
  '["2021-october-a-q08-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"Balanced tree"},{"label":"b","text":"Binary search tree"},{"label":"c","text":"Max heap"},{"label":"d","text":"Min heap\n\n – 5 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q8)',
  ARRAY[5]::int[],
  'native_text',
  '3.0',
  'Q8. Which of the following is the name for the tree depicted below? Here, the number in each
 node represents the key of the node.

 5

 3 7

 2 4 6 9

 1 8 10

 a) Balanced tree b) Binary search tree
 c) Max heap d) Min heap

 – 5 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[5]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  9,
  'Q9. When the function M(n) is defined as shown below, what is the value of M(97)?

 n  10 ( n  100 )
 M(n) =
 M ( M ( n  11 )) ( n  100 )',
  '[{"type":"text","page":6,"bbox":[65.22,68.76,484.82,82.21],"text":"Q9.  When the function M(n) is defined as shown below, what is the value of M(97)?"},{"type":"text","page":6,"bbox":[102.0,112.26,333.6,163.51],"text":"10\n\nn\n\n(\n100\n\nn\n)\nM(n)  =\n\n\n))\n11\n(\n(\n\nn\nM\nM\n\n(\n100\n\nn\n)"},{"type":"text","page":6,"bbox":[65.22,185.93,470.1,217.21],"text":"a) 81\nb) 86\nc) 91\nd) 96"}]'::jsonb,
  '["2021-october-a-q09-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"81"},{"label":"b","text":"86"},{"label":"c","text":"91"},{"label":"d","text":"96"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q9)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q9. When the function M(n) is defined as shown below, what is the value of M(97)?

 n  10 ( n  100 )
 M(n) =
 M ( M ( n  11 )) ( n  100 )

 a) 81 b) 86 c) 91 d) 96',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  10,
  'Q10. Which of the following is an appropriate description of XML?',
  '[{"type":"text","page":6,"bbox":[65.22,221.93,410.2,252.19],"text":"Q10.\nWhich of the following is an appropriate description of XML?"},{"type":"text","page":6,"bbox":[93.6,275.76,513.85,343.21],"text":"a) An exclusive editor is required to produce XML documents.\nb) It is an integration of the logical structure and document style.\nc) It is based on HTML and offers more extended functions.\nd) The attributes and logical structure of a document can be defined with user-defined"},{"type":"text","page":6,"bbox":[111.6,347.93,136.92,361.21],"text":"tags."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"An exclusive editor is required to produce XML documents."},{"label":"b","text":"It is an integration of the logical structure and document style."},{"label":"c","text":"It is based on HTML and offers more extended functions."},{"label":"d","text":"The attributes and logical structure of a document can be defined with user-defined\n tags."}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q10)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q10. Which of the following is an appropriate description of XML?

 a) An exclusive editor is required to produce XML documents.
 b) It is an integration of the logical structure and document style.
 c) It is based on HTML and offers more extended functions.
 d) The attributes and logical structure of a document can be defined with user-defined
 tags.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  11,
  'Q11. Which of the following is an appropriate term for a special register that contains the
 address of the next instruction to be fetched?',
  '[{"type":"text","page":6,"bbox":[65.22,400.74,533.2,432.13],"text":"Q11.\nWhich of the following is an appropriate term for a special register that contains the\naddress of the next instruction to be fetched?"},{"type":"text","page":6,"bbox":[65.22,455.93,421.45,505.15],"text":"a) Accumulator\nb) Instruction register\nc) Program counter\nd) Status register"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Accumulator"},{"label":"b","text":"Instruction register"},{"label":"c","text":"Program counter"},{"label":"d","text":"Status register"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q11)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q11. Which of the following is an appropriate term for a special register that contains the
 address of the next instruction to be fetched?

 a) Accumulator b) Instruction register
 c) Program counter d) Status register',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  12,
  'Q12. In memory systems, when data is detected in the cache, it is known as a hit. When data
 is not detected in the cache, it is read from the main memory and is known as a miss. Which
 of the following is the approximate hit ratio for the specifications in the table below? Here,
 effective access time is calculated as the weighted average of hit time and miss time, and other
 overhead is ignored.

 Specifications Time (ns)
 Access time of the cache 100

 Access time of the main memory 900
 Effective access time of the processor 250',
  '[{"type":"text","page":6,"bbox":[65.22,509.76,533.24,612.13],"text":"Q12.\nIn memory systems, when data is detected in the cache, it is known as a hit. When data\nis not detected in the cache, it is read from the main memory and is known as a miss. Which\nof the following is the approximate hit ratio for the specifications in the table below? Here,\neffective access time is calculated as the weighted average of hit time and miss time, and other\noverhead is ignored."},{"type":"table","page":6,"bbox":[121.92,632.46,409.5,708.96],"rows":[["Specifications","Time (ns)"],["Access time of the cache","100"],["Access time of the main memory","900"],["Effective access time of the processor","250"]]},{"type":"text","page":6,"bbox":[194.04,635.33,400.56,648.61],"text":"Specifications\nTime (ns)"},{"type":"text","page":6,"bbox":[127.32,653.81,385.15,667.09],"text":"Access time of the cache\n100"},{"type":"text","page":6,"bbox":[127.32,674.81,385.16,688.09],"text":"Access time of the main memory\n900"},{"type":"text","page":6,"bbox":[127.32,693.35,385.18,706.63],"text":"Effective access time of the processor\n250"},{"type":"text","page":6,"bbox":[84.12,730.91,488.22,744.19],"text":"a) 0.25\nb) 0.35\nc) 0.73\nd)\n0.81"},{"type":"code","page":6,"bbox":[65.22,794.63,311.58,808.39],"text":"– 6 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0.25"},{"label":"b","text":"0.35"},{"label":"c","text":"0.73"},{"label":"d","text":"0.81\n\n – 6 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q12)',
  ARRAY[6]::int[],
  'native_text',
  '3.0',
  'Q12. In memory systems, when data is detected in the cache, it is known as a hit. When data
 is not detected in the cache, it is read from the main memory and is known as a miss. Which
 of the following is the approximate hit ratio for the specifications in the table below? Here,
 effective access time is calculated as the weighted average of hit time and miss time, and other
 overhead is ignored.

 Specifications Time (ns)
 Access time of the cache 100

 Access time of the main memory 900
 Effective access time of the processor 250

 a) 0.25 b) 0.35 c) 0.73 d) 0.81

 – 6 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  13,
  'Q13. Which of the following is a computer architecture where each instruction is divided into
 multiple stages (e.g., fetch, decode, and execute) in the processor and multiple functional
 units execute two or more instructions in parallel by slightly shifting execution stages of the
 instructions?',
  '[{"type":"text","page":7,"bbox":[65.22,68.76,533.15,154.21],"text":"Q13.\nWhich of the following is a computer architecture where each instruction is divided into\nmultiple stages (e.g., fetch, decode, and execute) in the processor and multiple functional\nunits execute two or more instructions in parallel by slightly shifting execution stages of the\ninstructions?"},{"type":"text","page":7,"bbox":[65.22,158.93,495.38,190.15],"text":"a) Multicore\nb) Pipeline\nc) RISC\nd) VLIW"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Multicore"},{"label":"b","text":"Pipeline"},{"label":"c","text":"RISC"},{"label":"d","text":"VLIW"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q13)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q13. Which of the following is a computer architecture where each instruction is divided into
 multiple stages (e.g., fetch, decode, and execute) in the processor and multiple functional
 units execute two or more instructions in parallel by slightly shifting execution stages of the
 instructions?

 a) Multicore b) Pipeline c) RISC d) VLIW',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  14,
  'Q14. Which of the following is a connection method that is referred to as a daisy chain?',
  '[{"type":"text","page":7,"bbox":[65.22,194.76,506.21,244.21],"text":"Q14.\nWhich of the following is a connection method that is referred to as a daisy chain?"},{"type":"text","page":7,"bbox":[84.12,248.93,510.39,262.21],"text":"a) A keyboard, a mouse, and a printer are connected to a USB hub, and the USB hub is"},{"type":"text","page":7,"bbox":[84.12,266.93,528.78,298.21],"text":"connected to a PC.\nb) A PC and a measuring device are connected with RS-232C, and the PC and a printer are"},{"type":"text","page":7,"bbox":[84.12,302.93,522.89,334.21],"text":"connected by USB.\nc) A PC is connected from its own Thunderbolt connection port with a cable to one of the"},{"type":"text","page":7,"bbox":[84.12,338.93,511.72,388.21],"text":"two (2) 4K displays, each of which is equipped with two (2) Thunderbolt connection\nports, and the display is connected to the other display with a cable.\nd) Several network cameras and PCs are connected to a network hub."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A keyboard, a mouse, and a printer are connected to a USB hub, and the USB hub is\n connected to a PC."},{"label":"b","text":"A PC and a measuring device are connected with RS-232C, and the PC and a printer are\n connected by USB."},{"label":"c","text":"A PC is connected from its own Thunderbolt connection port with a cable to one of the\n two (2) 4K displays, each of which is equipped with two (2) Thunderbolt connection\n ports, and the display is connected to the other display with a cable."},{"label":"d","text":"Several network cameras and PCs are connected to a network hub."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q14)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q14. Which of the following is a connection method that is referred to as a daisy chain?

 a) A keyboard, a mouse, and a printer are connected to a USB hub, and the USB hub is
 connected to a PC.
 b) A PC and a measuring device are connected with RS-232C, and the PC and a printer are
 connected by USB.
 c) A PC is connected from its own Thunderbolt connection port with a cable to one of the
 two (2) 4K displays, each of which is equipped with two (2) Thunderbolt connection
 ports, and the display is connected to the other display with a cable.
 d) Several network cameras and PCs are connected to a network hub.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  15,
  'Q15. Which of the following is the appropriate description of RAID 5?',
  '[{"type":"text","page":7,"bbox":[65.22,410.93,424.83,441.19],"text":"Q15.\nWhich of the following is the appropriate description of RAID 5?"},{"type":"text","page":7,"bbox":[84.12,446.93,338.01,532.21],"text":"a) Bit-level striping with a dedicated parity disk\nb) Block-level striping with a dedicated parity disk\nc) Block-level striping with distributed parity disks\nd) Byte-level striping with a dedicated parity disk"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Bit-level striping with a dedicated parity disk"},{"label":"b","text":"Block-level striping with a dedicated parity disk"},{"label":"c","text":"Block-level striping with distributed parity disks"},{"label":"d","text":"Byte-level striping with a dedicated parity disk"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q15)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q15. Which of the following is the appropriate description of RAID 5?

 a) Bit-level striping with a dedicated parity disk
 b) Block-level striping with a dedicated parity disk
 c) Block-level striping with distributed parity disks
 d) Byte-level striping with a dedicated parity disk',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  16,
  'Q16. In the time-chart of a system shown below, the shaded parts represent the normal working
 hours of the system, and the white parts represent the time when the system is not available
 due to failure. The numbers inside each part indicate the start and end hours of each state.
 Which of the following is the availability of the system?

 0~60 60~70 70~145 145~150 150~240 240~255 255~300',
  '[{"type":"text","page":7,"bbox":[65.34,554.93,533.07,586.21],"text":"Q16. In the time-chart of a system shown below, the shaded parts represent the normal working"},{"type":"text","page":7,"bbox":[70.86,590.93,533.19,658.21],"text":"hours of the system, and the white parts represent the time when the system is not available\ndue to failure. The numbers inside each part indicate the start and end hours of each state.\nWhich of the following is the availability of the system?"},{"type":"table","page":7,"bbox":[100.8,660.06,456.03,677.55],"rows":[["","0~60","","60~70","","70~145","","145~150","","150~240","","240~255","","255~300",""]]},{"type":"text","page":7,"bbox":[111.18,662.33,453.0,675.61],"text":"0~60\n60~70\n70~145 145~150 150~240 240~255 255~300"},{"type":"text","page":7,"bbox":[84.12,681.89,479.1,713.17],"text":"a) 0.10\nb) 0.82\nc) 0.90\nd) 0.98"},{"type":"code","page":7,"bbox":[65.22,794.63,311.58,808.39],"text":"– 7 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0.10"},{"label":"b","text":"0.82"},{"label":"c","text":"0.90"},{"label":"d","text":"0.98\n\n – 7 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q16)',
  ARRAY[7]::int[],
  'native_text',
  '3.0',
  'Q16. In the time-chart of a system shown below, the shaded parts represent the normal working
 hours of the system, and the white parts represent the time when the system is not available
 due to failure. The numbers inside each part indicate the start and end hours of each state.
 Which of the following is the availability of the system?

 0~60 60~70 70~145 145~150 150~240 240~255 255~300

 a) 0.10 b) 0.82 c) 0.90 d) 0.98

 – 7 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[7]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  17,
  'Q17. In Round Robin scheduling, the CPU-time is shared among processes on the basis of the
 predefined time slot. There are four processes, namely P1, P2, P3, and P4, and their
 corresponding CPU-execution times are shown in the table below. All four (4) processes arrive
 at time 0, in the given order, and waiting time is the total time for which a process has to wait
 before it obtains its time slice for execution. Each time slot is 10 milliseconds. Which of the
 following is the average waiting time in milliseconds for the processes to be executed in
 Round Robin?

 Process CPU-execution time
 P1 10
 P2 23
 P3 7
 P4 3',
  '[{"type":"text","page":8,"bbox":[65.22,67.74,533.15,189.13],"text":"Q17.\nIn Round Robin scheduling, the CPU-time is shared among processes on the basis of the\npredefined time slot. There are four processes, namely P1, P2, P3, and P4, and their\ncorresponding CPU-execution times are shown in the table below. All four (4) processes arrive\nat time 0, in the given order, and waiting time is the total time for which a process has to wait\nbefore it obtains its time slice for execution. Each time slot is 10 milliseconds. Which of the\nfollowing is the average waiting time in milliseconds for the processes to be executed in\nRound Robin?"},{"type":"table","page":8,"bbox":[173.22,209.46,341.7,301.98],"rows":[["Process","CPU-execution time"],["P1","10"],["P2","23"],["P3","7"],["P4","3"]]},{"type":"text","page":8,"bbox":[181.08,212.33,335.84,225.61],"text":"Process\nCPU-execution time"},{"type":"text","page":8,"bbox":[193.08,230.81,292.62,244.09],"text":"P1\n10"},{"type":"text","page":8,"bbox":[193.08,249.35,292.62,262.63],"text":"P2\n23"},{"type":"text","page":8,"bbox":[193.08,267.83,289.62,281.11],"text":"P3\n7"},{"type":"text","page":8,"bbox":[193.08,286.31,289.62,299.59],"text":"P4\n3"},{"type":"text","page":8,"bbox":[84.12,323.93,485.1,337.21],"text":"a) 10.75\nb) 14.25\nc) 15.00\nd) 16.75"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"10.75"},{"label":"b","text":"14.25"},{"label":"c","text":"15.00"},{"label":"d","text":"16.75"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q17)',
  ARRAY[8]::int[],
  'native_text',
  '3.0',
  'Q17. In Round Robin scheduling, the CPU-time is shared among processes on the basis of the
 predefined time slot. There are four processes, namely P1, P2, P3, and P4, and their
 corresponding CPU-execution times are shown in the table below. All four (4) processes arrive
 at time 0, in the given order, and waiting time is the total time for which a process has to wait
 before it obtains its time slice for execution. Each time slot is 10 milliseconds. Which of the
 following is the average waiting time in milliseconds for the processes to be executed in
 Round Robin?

 Process CPU-execution time
 P1 10
 P2 23
 P3 7
 P4 3

 a) 10.75 b) 14.25 c) 15.00 d) 16.75',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[8]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  18,
  'Q18. There exist methods to obtain backup files for the purpose of recovering files and
 managing generations. Which of the following is an appropriate description for those methods
 or procedures?',
  '[{"type":"text","page":8,"bbox":[65.22,359.76,533.16,426.13],"text":"Q18.\nThere exist methods to obtain backup files for the purpose of recovering files and\nmanaging generations. Which of the following is an appropriate description for those methods\nor procedures?"},{"type":"text","page":8,"bbox":[84.12,449.93,521.63,463.21],"text":"a) A differential backup contains all files that are modified following the last full backup,"},{"type":"text","page":8,"bbox":[84.12,467.93,497.82,517.21],"text":"while an incremental backup saves all files that are modified after the last full,\ndifferential, or incremental backup.\nb) A differential backup may take longer to restore files than an incremental backup,"},{"type":"text","page":8,"bbox":[84.12,521.93,513.65,571.21],"text":"because the most recent versions of files are spread across a larger number of backup\nsets.\nc) A multiplexed backup is used as a mixed combination of a full backup, differential"},{"type":"text","page":8,"bbox":[84.12,575.93,514.01,607.21],"text":"backup, and incremental backup.\nd) An incremental backup tends to take longer to backup files than a differential backup"},{"type":"text","page":8,"bbox":[102.12,611.93,352.99,625.21],"text":"because more files are copied during each backup."},{"type":"code","page":8,"bbox":[65.22,794.63,311.58,808.39],"text":"– 8 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A differential backup contains all files that are modified following the last full backup,\n while an incremental backup saves all files that are modified after the last full,\n differential, or incremental backup."},{"label":"b","text":"A differential backup may take longer to restore files than an incremental backup,\n because the most recent versions of files are spread across a larger number of backup\n sets."},{"label":"c","text":"A multiplexed backup is used as a mixed combination of a full backup, differential\n backup, and incremental backup."},{"label":"d","text":"An incremental backup tends to take longer to backup files than a differential backup\n because more files are copied during each backup.\n\n – 8 –"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q18)',
  ARRAY[8]::int[],
  'native_text',
  '3.0',
  'Q18. There exist methods to obtain backup files for the purpose of recovering files and
 managing generations. Which of the following is an appropriate description for those methods
 or procedures?

 a) A differential backup contains all files that are modified following the last full backup,
 while an incremental backup saves all files that are modified after the last full,
 differential, or incremental backup.
 b) A differential backup may take longer to restore files than an incremental backup,
 because the most recent versions of files are spread across a larger number of backup
 sets.
 c) A multiplexed backup is used as a mixed combination of a full backup, differential
 backup, and incremental backup.
 d) An incremental backup tends to take longer to backup files than a differential backup
 because more files are copied during each backup.

 – 8 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[8]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  19,
  'Q19. A processor takes 15 seconds to run an application compiled with an old compiler. A new
 compiler was released. The same application compiled with the new compiler executes
 fewer instructions by 40%, but the average clock cycles per instruction (CPI) is increased
 by 10%. How many seconds does it take for the same processor to run the same application
 compiled with the new compiler?',
  '[{"type":"text","page":9,"bbox":[65.22,68.76,533.01,82.21],"text":"Q19.  A processor takes 15 seconds to run an application compiled with an old compiler. A new"},{"type":"text","page":9,"bbox":[65.22,86.93,533.13,172.21],"text":"compiler was released. The same application compiled with the new compiler executes\nfewer instructions by 40%, but the average clock cycles per instruction (CPI) is increased\nby 10%. How many seconds does it take for the same processor to run the same application\ncompiled with the new compiler?"},{"type":"text","page":9,"bbox":[84.12,176.93,482.22,190.21],"text":"a) 4.125\nb) 6.6\nc) 9.09\nd)\n9.9"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"4.125"},{"label":"b","text":"6.6"},{"label":"c","text":"9.09"},{"label":"d","text":"9.9"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q19)',
  ARRAY[9]::int[],
  'native_text',
  '3.0',
  'Q19. A processor takes 15 seconds to run an application compiled with an old compiler. A new
 compiler was released. The same application compiled with the new compiler executes
 fewer instructions by 40%, but the average clock cycles per instruction (CPI) is increased
 by 10%. How many seconds does it take for the same processor to run the same application
 compiled with the new compiler?

 a) 4.125 b) 6.6 c) 9.09 d) 9.9',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[9]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  20,
  'Q20. Which of the following is an appropriate explanation of an actuator?',
  '[{"type":"text","page":9,"bbox":[65.22,229.74,439.12,243.19],"text":"Q20.\nWhich of the following is an appropriate explanation of an actuator?"},{"type":"text","page":9,"bbox":[84.12,268.91,501.04,300.19],"text":"a) It amplifies weak electrical signals sent from microphones, sensors, and so on.\nb) It compares a given target value and a controlled value obtained from a sensor and"},{"type":"text","page":9,"bbox":[84.12,304.91,525.38,354.19],"text":"outputs an operation amount so that the controlled value is matched with the target\nvalue.\nc) It converts the power from an energy source into rotation, translational motion, or other"},{"type":"text","page":9,"bbox":[84.12,358.91,500.26,390.19],"text":"movements based on the control signals.\nd) It detects position, angle, velocity, acceleration, force, temperature, and so on, and"},{"type":"text","page":9,"bbox":[102.12,394.91,295.45,408.19],"text":"converts them into electric information."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It amplifies weak electrical signals sent from microphones, sensors, and so on."},{"label":"b","text":"It compares a given target value and a controlled value obtained from a sensor and\n outputs an operation amount so that the controlled value is matched with the target\n value."},{"label":"c","text":"It converts the power from an energy source into rotation, translational motion, or other\n movements based on the control signals."},{"label":"d","text":"It detects position, angle, velocity, acceleration, force, temperature, and so on, and\n converts them into electric information."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q20)',
  ARRAY[9]::int[],
  'native_text',
  '3.0',
  'Q20. Which of the following is an appropriate explanation of an actuator?

 a) It amplifies weak electrical signals sent from microphones, sensors, and so on.
 b) It compares a given target value and a controlled value obtained from a sensor and
 outputs an operation amount so that the controlled value is matched with the target
 value.
 c) It converts the power from an energy source into rotation, translational motion, or other
 movements based on the control signals.
 d) It detects position, angle, velocity, acceleration, force, temperature, and so on, and
 converts them into electric information.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[9]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  21,
  'Q21. Which of the following is a logical expression that is equivalent to the logic circuit shown
 below?

 A

 B',
  '[{"type":"text","page":9,"bbox":[65.22,447.72,533.15,479.11],"text":"Q21.\nWhich of the following is a logical expression that is equivalent to the logic circuit shown\nbelow?"},{"type":"text","page":9,"bbox":[126.96,497.98,134.96,511.54],"text":"A"},{"type":"text","page":9,"bbox":[126.96,520.72,134.96,534.28],"text":"B"},{"type":"text","page":9,"bbox":[65.22,575.04,417.48,624.49],"text":"a) A AND B\nb) A AND (A OR B)\nc) A OR B\nd) B AND (A OR B)"},{"type":"code","page":9,"bbox":[65.22,794.63,311.58,808.39],"text":"– 9 –"}]'::jsonb,
  '["2021-october-a-q21-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"A AND B"},{"label":"b","text":"A AND (A OR B)"},{"label":"c","text":"A OR B"},{"label":"d","text":"B AND (A OR B)\n\n – 9 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q21)',
  ARRAY[9]::int[],
  'native_text',
  '3.0',
  'Q21. Which of the following is a logical expression that is equivalent to the logic circuit shown
 below?

 A

 B

 a) A AND B b) A AND (A OR B)
 c) A OR B d) B AND (A OR B)

 – 9 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[9]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  22,
  'Q22. A device, which operates using a 100V household power supply and through which a
 current of 10 A flows during operation, is operated from 0 minutes to 120 minutes as shown
 in the figure below. How much electrical energy, in watt-hour, is consumed during this time?
 Here, the value of the voltage and current is the effective value, no current flows when the
 device stops, and the power factor is 1.

 Operating

 Stopped
 0 30 60 90 120 minutes',
  '[{"type":"text","page":10,"bbox":[65.22,67.74,533.17,153.13],"text":"Q22.\nA device, which operates using a 100V household power supply and through which a\ncurrent of 10 A flows during operation, is operated from 0 minutes to 120 minutes as shown\nin the figure below. How much electrical energy, in watt-hour, is consumed during this time?\nHere, the value of the voltage and current is the effective value, no current flows when the\ndevice stops, and the power factor is 1."},{"type":"text","page":10,"bbox":[105.48,185.4,158.43,198.57],"text":"Operating"},{"type":"text","page":10,"bbox":[109.5,224.16,154.39,237.33],"text":"Stopped"},{"type":"text","page":10,"bbox":[179.04,239.7,498.72,260.95],"text":"0\n30\n60\n90\n120\nminutes"},{"type":"text","page":10,"bbox":[84.12,266.93,485.1,298.21],"text":"a) 1,000\nb) 1,200\nc) 1,500\nd) 2,000"}]'::jsonb,
  '["2021-october-a-q22-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"1,000"},{"label":"b","text":"1,200"},{"label":"c","text":"1,500"},{"label":"d","text":"2,000"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q22)',
  ARRAY[10]::int[],
  'native_text',
  '3.0',
  'Q22. A device, which operates using a 100V household power supply and through which a
 current of 10 A flows during operation, is operated from 0 minutes to 120 minutes as shown
 in the figure below. How much electrical energy, in watt-hour, is consumed during this time?
 Here, the value of the voltage and current is the effective value, no current flows when the
 device stops, and the power factor is 1.

 Operating

 Stopped
 0 30 60 90 120 minutes

 a) 1,000 b) 1,200 c) 1,500 d) 2,000',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  23,
  'Q23. According to ISO 9241-11: 2018, which of the following is defined as the “extent to
 which a system, product, or service can be used by specified users to achieve specified goals
 with effectiveness, efficiency, and satisfaction in a specified context of use”?',
  '[{"type":"text","page":10,"bbox":[65.22,319.74,533.16,387.13],"text":"Q23.\nAccording to ISO 9241-11: 2018, which of the following is defined as the “extent to\nwhich a system, product, or service can be used by specified users to achieve specified goals\nwith effectiveness, efficiency, and satisfaction in a specified context of use”?"},{"type":"text","page":10,"bbox":[65.22,393.28,390.54,460.21],"text":"a) Accessibility\nb) Adaptability\nc) Availability\nd) Usability"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Accessibility"},{"label":"b","text":"Adaptability"},{"label":"c","text":"Availability"},{"label":"d","text":"Usability"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q23)',
  ARRAY[10]::int[],
  'native_text',
  '3.0',
  'Q23. According to ISO 9241-11: 2018, which of the following is defined as the “extent to
 which a system, product, or service can be used by specified users to achieve specified goals
 with effectiveness, efficiency, and satisfaction in a specified context of use”?

 a) Accessibility b) Adaptability
 c) Availability d) Usability',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  24,
  'Q24. Which of the following is an explanation of clipping in 3D graphics processing?',
  '[{"type":"text","page":10,"bbox":[65.22,464.93,495.44,495.19],"text":"Q24.\nWhich of the following is an explanation of clipping in 3D graphics processing?"},{"type":"text","page":10,"bbox":[84.12,500.93,527.05,550.21],"text":"a) It is a process that applies shading to the surface of an object for a more 3D appearance.\nb) It is a process that defines a window within the image display area, removes the area"},{"type":"text","page":10,"bbox":[84.12,554.93,523.69,586.21],"text":"outside the window, and cuts out the section visible within the window.\nc) It is a process that is performed in the last phase of CG video production and visualizes"},{"type":"text","page":10,"bbox":[84.12,590.93,502.46,622.21],"text":"object data so that it can be rendered on the screen.\nd) It is a process to hide the jaggies that occur near the edge of a shape because of the"},{"type":"text","page":10,"bbox":[65.22,626.93,292.8,676.15],"text":"limited number of pixels on the screen."},{"type":"code","page":10,"bbox":[65.22,794.63,314.58,808.39],"text":"– 10 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is a process that applies shading to the surface of an object for a more 3D appearance."},{"label":"b","text":"It is a process that defines a window within the image display area, removes the area\n outside the window, and cuts out the section visible within the window."},{"label":"c","text":"It is a process that is performed in the last phase of CG video production and visualizes\n object data so that it can be rendered on the screen."},{"label":"d","text":"It is a process to hide the jaggies that occur near the edge of a shape because of the\n limited number of pixels on the screen.\n\n – 10 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q24)',
  ARRAY[10]::int[],
  'native_text',
  '3.0',
  'Q24. Which of the following is an explanation of clipping in 3D graphics processing?

 a) It is a process that applies shading to the surface of an object for a more 3D appearance.
 b) It is a process that defines a window within the image display area, removes the area
 outside the window, and cuts out the section visible within the window.
 c) It is a process that is performed in the last phase of CG video production and visualizes
 object data so that it can be rendered on the screen.
 d) It is a process to hide the jaggies that occur near the edge of a shape because of the
 limited number of pixels on the screen.

 – 10 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  25,
  'Q25. When the relationships between continent and country, and between country and city are
 shown in the class diagram below, which of the following is an appropriate combination of
 multiplicities that are to be inserted into blank A through blank D? Here, there are no cross
 continental countries. Each continent has at least one country, and each country has at least
 one city.

 A B C D',
  '[{"type":"text","page":11,"bbox":[65.22,67.74,533.21,189.13],"text":"Q25.\nWhen the relationships between continent and country, and between country and city are\nshown in the class diagram below, which of the following is an appropriate combination of\nmultiplicities that are to be inserted into blank A through blank D? Here, there are no cross\ncontinental countries. Each continent has at least one country, and each country has at least\none city."},{"type":"table","page":11,"bbox":[92.64,227.46,529.5,319.98],"rows":[[null,"A","B","C","D"],["a)","1..1","1..*","1..*","1..1"],["b)","1..1","1..*","1..1","1..*"],["c)","1..1","0..*","0..*","1..1"],["d)","1..1","0..*","1..1","0..*"]]},{"type":"text","page":11,"bbox":[109.86,230.33,486.42,243.61],"text":"A\nB\nC\nD"},{"type":"text","page":11,"bbox":[105.24,248.81,491.1,262.09],"text":"a)\n1..1\n1..*\n1..*\n1..1"},{"type":"text","page":11,"bbox":[104.88,267.35,491.1,280.63],"text":"b)\n1..1\n1..*\n1..1\n1..*"},{"type":"text","page":11,"bbox":[105.24,285.83,491.1,299.11],"text":"c)\n1..1\n0..*\n0..*\n1..1"},{"type":"text","page":11,"bbox":[104.88,304.31,491.1,317.59],"text":"d)\n1..1\n0..*\n1..1\n0..*"},{"type":"code","page":11,"bbox":[65.22,794.63,317.4,808.39],"text":"– 11 –"}]'::jsonb,
  '["2021-october-a-q25-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"1..1 1..* 1..* 1..1"},{"label":"b","text":"1..1 1..* 1..1 1..*"},{"label":"c","text":"1..1 0..* 0..* 1..1"},{"label":"d","text":"1..1 0..* 1..1 0..*\n\n – 11 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q25)',
  ARRAY[11]::int[],
  'native_text',
  '3.0',
  'Q25. When the relationships between continent and country, and between country and city are
 shown in the class diagram below, which of the following is an appropriate combination of
 multiplicities that are to be inserted into blank A through blank D? Here, there are no cross
 continental countries. Each continent has at least one country, and each country has at least
 one city.

 A B C D
 a) 1..1 1..* 1..* 1..1
 b) 1..1 1..* 1..1 1..*
 c) 1..1 0..* 0..* 1..1
 d) 1..1 0..* 1..1 0..*

 – 11 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[11]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  26,
  'Q26. Tables Course and Section were created to record the course and section information of
 a university, respectively, as shown below; the primary keys are underlined.

 Course (cid, title, credits)
 Section (cid, secid, semester, year)

 The current status of those tables are shown below.

 Course Section

 cid title credits cid secid semester year

 CSE101 Discrete Mathematics 3 CSE101 1 Spring 2018

 CSE102 Computer Prog. I 3 CSE101 1 Spring 2019

 CSE103 Computer Prog. II 3 CSE101 2 Fall 2019

 EEE101 Electrical Circuits I 4 CSE102 1 Fall 2018

 EEE102 Electrical Circuits II 4 CSE102 2 Fall 2018

 CSE103 1 Spring 2019

 CSE103 2 Fall 2019

 EEE101 1 Spring 2019

 EEE102 1 Spring 2019

 EEE102 1 Fall 2019

 When the SQL shown below is executed, which of the following tables is obtained as the
 output?

 SELECT C.title

 FROM Course C

 WHERE 1 = (SELECT COUNT(cid)

 FROM Section S

 WHERE C.cid = S.cid AND S.year = 2019);',
  '[{"type":"text","page":12,"bbox":[65.22,67.74,533.12,99.13],"text":"Q26.\nTables Course and Section were created to record the course and section information of\na university, respectively, as shown below; the primary keys are underlined."},{"type":"text","page":12,"bbox":[93.54,122.33,218.89,135.61],"text":"Course (cid, title, credits)"},{"type":"text","page":12,"bbox":[93.54,141.35,262.95,154.63],"text":"Section (cid, secid, semester, year)"},{"type":"text","page":12,"bbox":[65.22,179.93,332.69,211.21],"text":"The current status of those tables are shown below."},{"type":"text","page":12,"bbox":[88.62,215.56,349.45,227.28],"text":"Course\nSection"},{"type":"table","page":12,"bbox":[88.83,231.3,297.03,343.49],"rows":[["cid","title","credits"],["CSE101","Discrete Mathematics","3"],["CSE102","Computer Prog. I","3"],["CSE103","Computer Prog. II","3"],["EEE101","Electrical Circuits I","4"],["EEE102","Electrical Circuits II","4"]]},{"type":"table","page":12,"bbox":[311.74,231.3,524.48,436.01],"rows":[["cid","secid","semester","year"],["CSE101","1","Spring","2018"],["CSE101","1","Spring","2019"],["CSE101","2","Fall","2019"],["CSE102","1","Fall","2018"],["CSE102","2","Fall","2018"],["CSE103","1","Spring","2019"],["CSE103","2","Fall","2019"],["EEE101","1","Spring","2019"],["EEE102","1","Spring","2019"],["EEE102","1","Fall","2019"]]},{"type":"text","page":12,"bbox":[94.26,234.78,291.75,246.93],"text":"cid\ntitle\ncredits"},{"type":"text","page":12,"bbox":[317.16,234.78,510.74,246.93],"text":"cid\nsecid\nsemester\nyear"},{"type":"text","page":12,"bbox":[94.26,254.4,267.92,266.55],"text":"CSE101\nDiscrete Mathematics\n3"},{"type":"text","page":12,"bbox":[317.16,254.4,513.86,266.55],"text":"CSE101\n1\nSpring\n2018"},{"type":"text","page":12,"bbox":[94.26,272.88,267.91,285.03],"text":"CSE102\nComputer Prog. I\n3"},{"type":"text","page":12,"bbox":[317.16,272.88,513.86,285.03],"text":"CSE101\n1\nSpring\n2019"},{"type":"text","page":12,"bbox":[94.26,291.36,267.93,303.51],"text":"CSE103\nComputer Prog. II\n3"},{"type":"text","page":12,"bbox":[317.16,291.36,513.85,303.51],"text":"CSE101\n2\nFall\n2019"},{"type":"text","page":12,"bbox":[94.26,309.9,267.95,322.05],"text":"EEE101\nElectrical Circuits I\n4"},{"type":"text","page":12,"bbox":[317.16,309.9,513.85,322.05],"text":"CSE102\n1\nFall\n2018"},{"type":"text","page":12,"bbox":[94.26,328.38,267.96,340.53],"text":"EEE102\nElectrical Circuits II\n4"},{"type":"text","page":12,"bbox":[317.16,328.38,513.85,340.53],"text":"CSE102\n2\nFall\n2018"},{"type":"text","page":12,"bbox":[317.16,346.86,513.86,359.01],"text":"CSE103\n1\nSpring\n2019"},{"type":"text","page":12,"bbox":[317.16,365.4,513.85,377.55],"text":"CSE103\n2\nFall\n2019"},{"type":"text","page":12,"bbox":[317.16,383.88,513.85,396.03],"text":"EEE101\n1\nSpring\n2019"},{"type":"text","page":12,"bbox":[317.16,402.36,513.85,414.51],"text":"EEE102\n1\nSpring\n2019"},{"type":"text","page":12,"bbox":[317.16,420.9,513.85,433.05],"text":"EEE102\n1\nFall\n2019"},{"type":"text","page":12,"bbox":[84.0,457.91,514.98,471.19],"text":"When the SQL shown below is executed, which of the following tables is obtained as the"},{"type":"text","page":12,"bbox":[65.22,475.91,131.42,507.19],"text":"output?"},{"type":"text","page":12,"bbox":[86.4,514.69,176.9,524.71],"text":"SELECT C.title"},{"type":"text","page":12,"bbox":[86.4,532.69,173.51,542.71],"text":"FROM Course C"},{"type":"text","page":12,"bbox":[86.4,550.69,261.31,560.71],"text":"WHERE 1 = (SELECT COUNT(cid)"},{"type":"text","page":12,"bbox":[86.4,568.69,179.57,578.71],"text":"FROM Section S"},{"type":"text","page":12,"bbox":[86.4,586.69,327.56,596.71],"text":"WHERE C.cid = S.cid AND S.year = 2019);"},{"type":"text","page":12,"bbox":[70.62,621.24,430.31,632.87],"text":"a)\nb)\nc)\nd)"},{"type":"text","page":12,"bbox":[76.26,638.16,98.33,649.79],"text":"Title"},{"type":"text","page":12,"bbox":[168.42,638.16,187.38,649.79],"text":"title"},{"type":"text","page":12,"bbox":[288.9,638.16,307.86,649.79],"text":"title"},{"type":"text","page":12,"bbox":[424.56,638.16,443.52,649.79],"text":"title"},{"type":"text","page":12,"bbox":[168.42,657.6,247.79,669.23],"text":"Computer Prog. II"},{"type":"text","page":12,"bbox":[288.9,657.6,383.35,669.23],"text":"Discrete Mathematics"},{"type":"text","page":12,"bbox":[76.26,663.42,97.54,675.05],"text":"Null"},{"type":"text","page":12,"bbox":[424.56,663.42,509.4,675.05],"text":"Electrical Circuits I"},{"type":"text","page":12,"bbox":[168.42,676.14,253.26,687.77],"text":"Electrical Circuits I"},{"type":"text","page":12,"bbox":[288.9,676.14,370.01,687.77],"text":"Computer Prog. I"},{"type":"text","page":12,"bbox":[168.42,694.62,256.72,706.25],"text":"Electrical Circuits II"},{"type":"text","page":12,"bbox":[288.9,694.62,373.74,706.25],"text":"Electrical Circuits I"},{"type":"text","page":12,"bbox":[288.9,713.1,377.2,724.73],"text":"Electrical Circuits II"},{"type":"code","page":12,"bbox":[65.22,794.63,314.58,808.39],"text":"– 12 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":""},{"label":"b","text":""},{"label":"c","text":""},{"label":"d","text":"Title title title title\n\n Computer Prog. II Discrete Mathematics\n Null Electrical Circuits I\n Electrical Circuits I Computer Prog. I\n\n Electrical Circuits II Electrical Circuits I\n\n Electrical Circuits II\n\n – 12 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q26)',
  ARRAY[12]::int[],
  'native_text',
  '3.0',
  'Q26. Tables Course and Section were created to record the course and section information of
 a university, respectively, as shown below; the primary keys are underlined.

 Course (cid, title, credits)
 Section (cid, secid, semester, year)

 The current status of those tables are shown below.

 Course Section

 cid title credits cid secid semester year

 CSE101 Discrete Mathematics 3 CSE101 1 Spring 2018

 CSE102 Computer Prog. I 3 CSE101 1 Spring 2019

 CSE103 Computer Prog. II 3 CSE101 2 Fall 2019

 EEE101 Electrical Circuits I 4 CSE102 1 Fall 2018

 EEE102 Electrical Circuits II 4 CSE102 2 Fall 2018

 CSE103 1 Spring 2019

 CSE103 2 Fall 2019

 EEE101 1 Spring 2019

 EEE102 1 Spring 2019

 EEE102 1 Fall 2019

 When the SQL shown below is executed, which of the following tables is obtained as the
 output?

 SELECT C.title

 FROM Course C

 WHERE 1 = (SELECT COUNT(cid)

 FROM Section S

 WHERE C.cid = S.cid AND S.year = 2019);

 a) b) c) d)
 Title title title title

 Computer Prog. II Discrete Mathematics
 Null Electrical Circuits I
 Electrical Circuits I Computer Prog. I

 Electrical Circuits II Electrical Circuits I

 Electrical Circuits II

 – 12 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[12]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  27,
  'Q27. Which of the following is an appropriate explanation of an E-R diagram?',
  '[{"type":"text","page":13,"bbox":[65.22,67.31,461.75,81.61],"text":"Q27.\nWhich of the following is an appropriate explanation of an E-R diagram?"},{"type":"text","page":13,"bbox":[84.12,104.93,530.8,136.21],"text":"a) A relationship is expressed by describing the related entity name in the entity type.\nb) The relationship between entity types is expressed by an arrow from the referencing side"},{"type":"text","page":13,"bbox":[84.12,140.93,511.08,190.21],"text":"in the direction of the referenced side.\nc) There are no attributes in the entity type, but the relationship type has attributes.\nd) There are several kinds of relationships between entity types such as one-to-many or"},{"type":"text","page":13,"bbox":[65.22,194.93,178.76,225.13],"text":"many-to-many."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A relationship is expressed by describing the related entity name in the entity type."},{"label":"b","text":"The relationship between entity types is expressed by an arrow from the referencing side\n in the direction of the referenced side."},{"label":"c","text":"There are no attributes in the entity type, but the relationship type has attributes."},{"label":"d","text":"There are several kinds of relationships between entity types such as one-to-many or\n many-to-many."}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q27)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q27. Which of the following is an appropriate explanation of an E-R diagram?

 a) A relationship is expressed by describing the related entity name in the entity type.
 b) The relationship between entity types is expressed by an arrow from the referencing side
 in the direction of the referenced side.
 c) There are no attributes in the entity type, but the relationship type has attributes.
 d) There are several kinds of relationships between entity types such as one-to-many or
 many-to-many.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  28,
  'Q28. Which of the following is the main purpose of transaction support in a database
 management system?',
  '[{"type":"text","page":13,"bbox":[65.22,247.74,533.1,279.13],"text":"Q28.\nWhich of the following is the main purpose of transaction support in a database\nmanagement system?"},{"type":"text","page":13,"bbox":[86.4,284.93,519.2,316.21],"text":"a) To ensure that either all the updates corresponding to a given transaction are made or"},{"type":"text","page":13,"bbox":[65.22,320.93,487.46,405.13],"text":"none of them are made\nb) To ensure that only authorized users can access the database\nc) To help users update data by providing a graphical user interface\nd) To provide an accessible catalog in which descriptions of data items are stored"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"To ensure that either all the updates corresponding to a given transaction are made or\n none of them are made"},{"label":"b","text":"To ensure that only authorized users can access the database"},{"label":"c","text":"To help users update data by providing a graphical user interface"},{"label":"d","text":"To provide an accessible catalog in which descriptions of data items are stored"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q28)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q28. Which of the following is the main purpose of transaction support in a database
 management system?

 a) To ensure that either all the updates corresponding to a given transaction are made or
 none of them are made
 b) To ensure that only authorized users can access the database
 c) To help users update data by providing a graphical user interface
 d) To provide an accessible catalog in which descriptions of data items are stored',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  29,
  'Q29. Which of the following is an appropriate description of distributed databases?',
  '[{"type":"text","page":13,"bbox":[65.22,409.74,483.45,459.13],"text":"Q29.\nWhich of the following is an appropriate description of distributed databases?"},{"type":"text","page":13,"bbox":[84.12,464.93,501.44,478.21],"text":"a) Access to a database server is shared among a globally distributed userbase so that"},{"type":"text","page":13,"bbox":[84.12,482.93,526.39,514.21],"text":"everyone can access the database.\nb) It is a database that is distributed to all interested researchers and other users worldwide"},{"type":"text","page":13,"bbox":[84.12,518.93,477.99,550.21],"text":"so that everyone can benefit.\nc) It is a NoSQL database instead of a Relational Database Management System"},{"type":"text","page":13,"bbox":[84.12,554.93,485.79,586.21],"text":"(RDBMS).\nd) It stores different parts of a database in different locations, and its processing is"},{"type":"text","page":13,"bbox":[65.22,590.93,247.11,640.15],"text":"distributed across those parts."},{"type":"code","page":13,"bbox":[65.22,794.63,314.58,808.39],"text":"– 13 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Access to a database server is shared among a globally distributed userbase so that\n everyone can access the database."},{"label":"b","text":"It is a database that is distributed to all interested researchers and other users worldwide\n so that everyone can benefit."},{"label":"c","text":"It is a NoSQL database instead of a Relational Database Management System\n (RDBMS)."},{"label":"d","text":"It stores different parts of a database in different locations, and its processing is\n distributed across those parts.\n\n – 13 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q29)',
  ARRAY[13]::int[],
  'native_text',
  '3.0',
  'Q29. Which of the following is an appropriate description of distributed databases?

 a) Access to a database server is shared among a globally distributed userbase so that
 everyone can access the database.
 b) It is a database that is distributed to all interested researchers and other users worldwide
 so that everyone can benefit.
 c) It is a NoSQL database instead of a Relational Database Management System
 (RDBMS).
 d) It stores different parts of a database in different locations, and its processing is
 distributed across those parts.

 – 13 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[13]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  30,
  'Q30. In the OSI basic reference model, which of the following is a network device that operates
 at the network layer?',
  '[{"type":"text","page":14,"bbox":[65.22,67.74,533.11,99.13],"text":"Q30.\nIn the OSI basic reference model, which of the following is a network device that operates\nat the network layer?"},{"type":"text","page":14,"bbox":[65.22,122.76,491.08,154.15],"text":"a) Access point\nb) Bridge\nc) Repeater\nd) Router"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Access point"},{"label":"b","text":"Bridge"},{"label":"c","text":"Repeater"},{"label":"d","text":"Router"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q30)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q30. In the OSI basic reference model, which of the following is a network device that operates
 at the network layer?

 a) Access point b) Bridge c) Repeater d) Router',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  31,
  'Q31. Which of the following is a mechanism that enables multiple terminals to have private
 addresses different from each other to connect to the Internet by sharing a single global IP
 address?',
  '[{"type":"text","page":14,"bbox":[65.22,158.76,524.54,225.13],"text":"Q31.\nWhich of the following is a mechanism that enables multiple terminals to have private\naddresses different from each other to connect to the Internet by sharing a single global IP\naddress?"},{"type":"text","page":14,"bbox":[65.22,248.93,502.81,280.21],"text":"a) DHCP\nb) DNS\nc) NAPT\nd) RADIUS"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"DHCP"},{"label":"b","text":"DNS"},{"label":"c","text":"NAPT"},{"label":"d","text":"RADIUS"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q31)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q31. Which of the following is a mechanism that enables multiple terminals to have private
 addresses different from each other to connect to the Internet by sharing a single global IP
 address?

 a) DHCP b) DNS c) NAPT d) RADIUS',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  32,
  'Q32. Which of the following is a data link layer function that enables a receiver to control the
 amount of data a sender transmits?',
  '[{"type":"text","page":14,"bbox":[65.22,284.93,533.13,333.13],"text":"Q32.\nWhich of the following is a data link layer function that enables a receiver to control the\namount of data a sender transmits?"},{"type":"text","page":14,"bbox":[84.12,356.93,431.82,388.21],"text":"a) Congestion control\nb) Error control\nc) Flow control\nd) Media access control"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Congestion control"},{"label":"b","text":"Error control"},{"label":"c","text":"Flow control"},{"label":"d","text":"Media access control"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q32)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q32. Which of the following is a data link layer function that enables a receiver to control the
 amount of data a sender transmits?

 a) Congestion control b) Error control
 c) Flow control d) Media access control',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  33,
  'Q33. In TCP/IP, which of the following is an application layer protocol that enables a server
 to automatically configure its clients with network information such as IP addresses, the
 subnet mask, and the default gateway address?',
  '[{"type":"text","page":14,"bbox":[65.22,427.74,533.19,477.13],"text":"Q33.\nIn TCP/IP, which of the following is an application layer protocol that enables a server\nto automatically configure its clients with network information such as IP addresses, the\nsubnet mask, and the default gateway address?"},{"type":"text","page":14,"bbox":[84.12,500.93,394.45,532.21],"text":"a) ARP\nb) DHCP\nc) DNS\nd) NSLOOKUP"},{"type":"code","page":14,"bbox":[65.22,794.63,314.58,808.39],"text":"– 14 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"ARP"},{"label":"b","text":"DHCP"},{"label":"c","text":"DNS"},{"label":"d","text":"NSLOOKUP\n\n – 14 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q33)',
  ARRAY[14]::int[],
  'native_text',
  '3.0',
  'Q33. In TCP/IP, which of the following is an application layer protocol that enables a server
 to automatically configure its clients with network information such as IP addresses, the
 subnet mask, and the default gateway address?

 a) ARP b) DHCP
 c) DNS d) NSLOOKUP

 – 14 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  34,
  'Q34. Which of the following is an appropriate explanation of Software-Defined Networking
 (SDN) that uses OpenFlow?',
  '[{"type":"text","page":15,"bbox":[65.22,67.74,533.11,99.13],"text":"Q34.\nWhich of the following is an appropriate explanation of Software-Defined Networking\n(SDN) that uses OpenFlow?"},{"type":"text","page":15,"bbox":[84.12,104.93,525.37,136.21],"text":"a) It is a network technology that logically separates data forwarding and network control,"},{"type":"text","page":15,"bbox":[84.12,140.93,512.43,190.21],"text":"and it is implemented with a combination of network devices specialized for data\nforwarding function, and a network control software.\nb) It is a software technology for business operation analysis and visualization that uses"},{"type":"text","page":15,"bbox":[84.12,194.93,532.28,244.21],"text":"data flow diagrams and activity diagrams to discover problems in business processes and\nmake improvements.\nc) It is an Internet of Things (IoT) technology that uses RFID, and it is a software"},{"type":"text","page":15,"bbox":[84.12,248.93,509.65,280.21],"text":"architecture that optimizes distribution networks.\nd) It is an optimum deployment method for servers on a network that was developed to"},{"type":"text","page":15,"bbox":[102.12,284.93,364.02,298.21],"text":"efficiently stream a range of content over the Internet."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is a network technology that logically separates data forwarding and network control,\n and it is implemented with a combination of network devices specialized for data\n forwarding function, and a network control software."},{"label":"b","text":"It is a software technology for business operation analysis and visualization that uses\n data flow diagrams and activity diagrams to discover problems in business processes and\n make improvements."},{"label":"c","text":"It is an Internet of Things (IoT) technology that uses RFID, and it is a software\n architecture that optimizes distribution networks."},{"label":"d","text":"It is an optimum deployment method for servers on a network that was developed to\n efficiently stream a range of content over the Internet."}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q34)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q34. Which of the following is an appropriate explanation of Software-Defined Networking
 (SDN) that uses OpenFlow?

 a) It is a network technology that logically separates data forwarding and network control,
 and it is implemented with a combination of network devices specialized for data
 forwarding function, and a network control software.
 b) It is a software technology for business operation analysis and visualization that uses
 data flow diagrams and activity diagrams to discover problems in business processes and
 make improvements.
 c) It is an Internet of Things (IoT) technology that uses RFID, and it is a software
 architecture that optimizes distribution networks.
 d) It is an optimum deployment method for servers on a network that was developed to
 efficiently stream a range of content over the Internet.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  35,
  'Q35. Which of the following is an appropriate description of a Trojan horse?',
  '[{"type":"text","page":15,"bbox":[65.22,337.74,452.2,351.19],"text":"Q35.\nWhich of the following is an appropriate description of a Trojan horse?"},{"type":"text","page":15,"bbox":[65.22,374.93,438.38,460.15],"text":"a) A brute force attack software tool\nb) A malicious computer program that presents itself as a legitimate one\nc) A malicious user that steals private information from a system\nd) A software tool to decrypt an encrypted password"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A brute force attack software tool"},{"label":"b","text":"A malicious computer program that presents itself as a legitimate one"},{"label":"c","text":"A malicious user that steals private information from a system"},{"label":"d","text":"A software tool to decrypt an encrypted password"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q35)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q35. Which of the following is an appropriate description of a Trojan horse?

 a) A brute force attack software tool
 b) A malicious computer program that presents itself as a legitimate one
 c) A malicious user that steals private information from a system
 d) A software tool to decrypt an encrypted password',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  36,
  'Q36. Which of the following properties for information security defined in ISO/IEC
 27000:2018 refers to a guarantee that the message data received is the same as the message
 data sent?',
  '[{"type":"text","page":15,"bbox":[65.22,464.76,533.14,531.13],"text":"Q36.\nWhich of the following properties for information security defined in ISO/IEC\n27000:2018 refers to a guarantee that the message data received is the same as the message\ndata sent?"},{"type":"text","page":15,"bbox":[84.12,554.93,409.75,586.21],"text":"a) Availability\nb) Confidentiality\nc) Integrity\nd) Non-repudiation"},{"type":"code","page":15,"bbox":[65.22,794.63,314.58,808.39],"text":"– 15 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Availability"},{"label":"b","text":"Confidentiality"},{"label":"c","text":"Integrity"},{"label":"d","text":"Non-repudiation\n\n – 15 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q36)',
  ARRAY[15]::int[],
  'native_text',
  '3.0',
  'Q36. Which of the following properties for information security defined in ISO/IEC
 27000:2018 refers to a guarantee that the message data received is the same as the message
 data sent?

 a) Availability b) Confidentiality
 c) Integrity d) Non-repudiation

 – 15 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[15]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  37,
  'Q37. Which of the following is an example of ransomware?',
  '[{"type":"text","page":16,"bbox":[65.22,67.74,371.74,81.19],"text":"Q37.\nWhich of the following is an example of ransomware?"},{"type":"text","page":16,"bbox":[84.12,104.93,523.35,136.21],"text":"a) A range of different types of software including adware, spyware, and freeware\nb) Malicious software blocking access to a victimized computer and demanding money to"},{"type":"text","page":16,"bbox":[84.12,140.93,521.96,172.21],"text":"unblock it\nc) Software that assigns randomized MAC addresses to PCs to ensure user privacy on the"},{"type":"text","page":16,"bbox":[84.12,176.93,499.34,208.21],"text":"Internet\nd) Software that generates random numbers needed by computer security application"},{"type":"text","page":16,"bbox":[65.22,212.93,146.47,244.15],"text":"software"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A range of different types of software including adware, spyware, and freeware"},{"label":"b","text":"Malicious software blocking access to a victimized computer and demanding money to\n unblock it"},{"label":"c","text":"Software that assigns randomized MAC addresses to PCs to ensure user privacy on the\n Internet"},{"label":"d","text":"Software that generates random numbers needed by computer security application\n software"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q37)',
  ARRAY[16]::int[],
  'native_text',
  '3.0',
  'Q37. Which of the following is an example of ransomware?

 a) A range of different types of software including adware, spyware, and freeware
 b) Malicious software blocking access to a victimized computer and demanding money to
 unblock it
 c) Software that assigns randomized MAC addresses to PCs to ensure user privacy on the
 Internet
 d) Software that generates random numbers needed by computer security application
 software',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[16]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  38,
  'Q38. A typical example of security threats is information leakage when a sender sends data
 containing important information to a receiver. Which of the following is the most appropriate
 measure to prevent information leakage?',
  '[{"type":"text","page":16,"bbox":[65.22,248.76,533.14,315.13],"text":"Q38.\nA typical example of security threats is information leakage when a sender sends data\ncontaining important information to a receiver. Which of the following is the most appropriate\nmeasure to prevent information leakage?"},{"type":"text","page":16,"bbox":[84.12,320.93,526.31,352.21],"text":"a) The data is encrypted with a private key before being sent to the receiver via email. In a"},{"type":"text","page":16,"bbox":[84.12,356.93,527.75,406.21],"text":"separate email, the private key is sent to the receiver so that the receiver can decrypt the\ndata.\nb) The data is password-locked, and it is attached in an email that includes the password in"},{"type":"text","page":16,"bbox":[84.12,410.93,527.65,460.21],"text":"the text part of the email. Before the email is sent, the receiver address is checked to\nmake sure that the email is sent to the correct address.\nc) The receiver creates a pair of public/private keys and sends the public key to the sender."},{"type":"text","page":16,"bbox":[84.12,464.93,532.81,514.21],"text":"The data is encrypted with the public key and sent to the receiver via email. The receiver\nthen decrypts the data with the private key.\nd) The sender compresses the data on a USB memory as much as possible before giving the"},{"type":"text","page":16,"bbox":[84.12,518.93,530.94,568.21],"text":"USB memory to the receiver so that the receiver can utilize the rest of the memory space\neffectively."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"The data is encrypted with a private key before being sent to the receiver via email. In a\n separate email, the private key is sent to the receiver so that the receiver can decrypt the\n data."},{"label":"b","text":"The data is password-locked, and it is attached in an email that includes the password in\n the text part of the email. Before the email is sent, the receiver address is checked to\n make sure that the email is sent to the correct address."},{"label":"c","text":"The receiver creates a pair of public/private keys and sends the public key to the sender.\n The data is encrypted with the public key and sent to the receiver via email. The receiver\n then decrypts the data with the private key."},{"label":"d","text":"The sender compresses the data on a USB memory as much as possible before giving the\n USB memory to the receiver so that the receiver can utilize the rest of the memory space\n effectively."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q38)',
  ARRAY[16]::int[],
  'native_text',
  '3.0',
  'Q38. A typical example of security threats is information leakage when a sender sends data
 containing important information to a receiver. Which of the following is the most appropriate
 measure to prevent information leakage?

 a) The data is encrypted with a private key before being sent to the receiver via email. In a
 separate email, the private key is sent to the receiver so that the receiver can decrypt the
 data.
 b) The data is password-locked, and it is attached in an email that includes the password in
 the text part of the email. Before the email is sent, the receiver address is checked to
 make sure that the email is sent to the correct address.
 c) The receiver creates a pair of public/private keys and sends the public key to the sender.
 The data is encrypted with the public key and sent to the receiver via email. The receiver
 then decrypts the data with the private key.
 d) The sender compresses the data on a USB memory as much as possible before giving the
 USB memory to the receiver so that the receiver can utilize the rest of the memory space
 effectively.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[16]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  39,
  'Q39. Which of the following is a type of malware that embeds itself within a program and
 inserts its copy into other programs?',
  '[{"type":"text","page":16,"bbox":[65.22,572.93,533.1,621.13],"text":"Q39.\nWhich of the following is a type of malware that embeds itself within a program and\ninserts its copy into other programs?"},{"type":"text","page":16,"bbox":[84.12,644.93,497.86,658.21],"text":"a) Backdoor\nb) Trojan horse\nc) Virus\nd)\nWorm"},{"type":"code","page":16,"bbox":[65.22,794.63,314.58,808.39],"text":"– 16 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Backdoor"},{"label":"b","text":"Trojan horse"},{"label":"c","text":"Virus"},{"label":"d","text":"Worm\n\n – 16 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q39)',
  ARRAY[16]::int[],
  'native_text',
  '3.0',
  'Q39. Which of the following is a type of malware that embeds itself within a program and
 inserts its copy into other programs?

 a) Backdoor b) Trojan horse c) Virus d) Worm

 – 16 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[16]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  40,
  'Q40. According to ISO/IEC 27000:2018 (Information security management systems -
 Overview and vocabulary), which of the following is the definition of “level of risk”?',
  '[{"type":"text","page":17,"bbox":[65.22,67.74,533.04,99.13],"text":"Q40.\nAccording to ISO/IEC 27000:2018 (Information security management systems -\nOverview and vocabulary), which of the following is the definition of “level of risk”?"},{"type":"text","page":17,"bbox":[84.12,104.93,512.69,136.21],"text":"a) Magnitude of a risk expressed in terms of the combination of consequences and their"},{"type":"text","page":17,"bbox":[65.22,140.93,409.98,226.21],"text":"likelihood\nb) Terms of reference for evaluating the significance of a risk\nc) The priority order assigned to the risks to be handled\nd) Weakness of an asset or control that can be exploited by threats"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Magnitude of a risk expressed in terms of the combination of consequences and their\n likelihood"},{"label":"b","text":"Terms of reference for evaluating the significance of a risk"},{"label":"c","text":"The priority order assigned to the risks to be handled"},{"label":"d","text":"Weakness of an asset or control that can be exploited by threats"}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q40)',
  ARRAY[17]::int[],
  'native_text',
  '3.0',
  'Q40. According to ISO/IEC 27000:2018 (Information security management systems -
 Overview and vocabulary), which of the following is the definition of “level of risk”?

 a) Magnitude of a risk expressed in terms of the combination of consequences and their
 likelihood
 b) Terms of reference for evaluating the significance of a risk
 c) The priority order assigned to the risks to be handled
 d) Weakness of an asset or control that can be exploited by threats',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[17]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  41,
  'Q41. Which of the following is dynamic analysis of malware?',
  '[{"type":"text","page":17,"bbox":[65.22,230.76,382.16,261.19],"text":"Q41.\nWhich of the following is dynamic analysis of malware?"},{"type":"text","page":17,"bbox":[84.12,266.93,525.37,298.21],"text":"a) Malware is identified by calculating the hash value of the subject for analysis and cross-"},{"type":"text","page":17,"bbox":[84.12,302.93,521.37,352.21],"text":"checking it against a list of known malware hash values that are registered in an online\ndatabase.\nb) On the basis of the file extensions and content of file headers on a hard disk, malicious"},{"type":"text","page":17,"bbox":[84.12,356.93,528.04,388.21],"text":"program files with false extensions are detected.\nc) The subject for analysis is extracted from communication data on a network and reverse"},{"type":"text","page":17,"bbox":[84.12,392.93,513.08,442.21],"text":"compiled, and the functions of the subject for analysis are investigated from the code\nobtained.\nd) The subject for analysis is run in a sandbox, and its behavior and external"},{"type":"text","page":17,"bbox":[102.12,446.93,246.76,460.21],"text":"communication are observed."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Malware is identified by calculating the hash value of the subject for analysis and crosschecking it against a list of known malware hash values that are registered in an online\n database."},{"label":"b","text":"On the basis of the file extensions and content of file headers on a hard disk, malicious\n program files with false extensions are detected."},{"label":"c","text":"The subject for analysis is extracted from communication data on a network and reverse\n compiled, and the functions of the subject for analysis are investigated from the code\n obtained."},{"label":"d","text":"The subject for analysis is run in a sandbox, and its behavior and external\n communication are observed."}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q41)',
  ARRAY[17]::int[],
  'native_text',
  '3.0',
  'Q41. Which of the following is dynamic analysis of malware?

 a) Malware is identified by calculating the hash value of the subject for analysis and crosschecking it against a list of known malware hash values that are registered in an online
 database.
 b) On the basis of the file extensions and content of file headers on a hard disk, malicious
 program files with false extensions are detected.
 c) The subject for analysis is extracted from communication data on a network and reverse
 compiled, and the functions of the subject for analysis are investigated from the code
 obtained.
 d) The subject for analysis is run in a sandbox, and its behavior and external
 communication are observed.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[17]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  42,
  'Q42. Which of the following technologies is the most suitable to divide the whole company
 network into networks by department?',
  '[{"type":"text","page":17,"bbox":[65.22,499.74,533.19,548.53],"text":"Q42.\nWhich of the following technologies is the most suitable to divide the whole company\nnetwork into networks by department?"},{"type":"text","page":17,"bbox":[65.22,552.89,508.08,620.17],"text":"a) DMZ (DeMilitarized Zone)\nb) NAT (Network Address Translation)\nc) VLAN (Virtual Local Area Network)\nd) VPN (Virtual Private Network)"},{"type":"code","page":17,"bbox":[65.22,794.63,314.58,808.39],"text":"– 17 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"DMZ (DeMilitarized Zone)"},{"label":"b","text":"NAT (Network Address Translation)"},{"label":"c","text":"VLAN (Virtual Local Area Network)"},{"label":"d","text":"VPN (Virtual Private Network)\n\n – 17 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q42)',
  ARRAY[17]::int[],
  'native_text',
  '3.0',
  'Q42. Which of the following technologies is the most suitable to divide the whole company
 network into networks by department?

 a) DMZ (DeMilitarized Zone) b) NAT (Network Address Translation)
 c) VLAN (Virtual Local Area Network) d) VPN (Virtual Private Network)

 – 17 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[17]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  43,
  'Q43. An SQL injection attack caused the SQL statement below to be executed. Which of the
 following does the SQL statement do? Here, the accounts table contains account information
 in each row.

 SELECT * FROM accounts WHERE username=''1'' or ''1’=''1''; DROP TABLE accounts;',
  '[{"type":"text","page":18,"bbox":[65.22,68.76,531.92,135.13],"text":"Q43.\nAn SQL injection attack caused the SQL statement below to be executed. Which of the\nfollowing does the SQL statement do? Here, the accounts table contains account information\nin each row."},{"type":"text","page":18,"bbox":[75.72,141.25,527.93,151.27],"text":"SELECT * FROM accounts WHERE username=''1'' or ''1’=''1''; DROP TABLE accounts;"},{"type":"text","page":18,"bbox":[84.12,176.93,530.64,226.21],"text":"a) It creates a new user ‘1’.\nb) It creates a pop-up box that shows the first username in the “accounts” table.\nc) It selects all the records in the “accounts” table and deletes the “accounts” table from the"},{"type":"text","page":18,"bbox":[84.12,230.93,514.3,262.21],"text":"database.\nd) It selects one record from the “accounts” table and drops the rest of the records in the"},{"type":"text","page":18,"bbox":[65.22,266.76,131.8,298.15],"text":"table."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It creates a new user ‘1’."},{"label":"b","text":"It creates a pop-up box that shows the first username in the “accounts” table."},{"label":"c","text":"It selects all the records in the “accounts” table and deletes the “accounts” table from the\n database."},{"label":"d","text":"It selects one record from the “accounts” table and drops the rest of the records in the\n table."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q43)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q43. An SQL injection attack caused the SQL statement below to be executed. Which of the
 following does the SQL statement do? Here, the accounts table contains account information
 in each row.

 SELECT * FROM accounts WHERE username=''1'' or ''1’=''1''; DROP TABLE accounts;

 a) It creates a new user ‘1’.
 b) It creates a pop-up box that shows the first username in the “accounts” table.
 c) It selects all the records in the “accounts” table and deletes the “accounts” table from the
 database.
 d) It selects one record from the “accounts” table and drops the rest of the records in the
 table.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  44,
  'Q44. To provide a guarantee to its online customers that all credit card information is protected
 when transferred between their PC and the web service over public networks, which of the
 following technologies should be used?',
  '[{"type":"text","page":18,"bbox":[65.22,301.74,533.18,369.13],"text":"Q44.\nTo provide a guarantee to its online customers that all credit card information is protected\nwhen transferred between their PC and the web service over public networks, which of the\nfollowing technologies should be used?"},{"type":"text","page":18,"bbox":[65.22,392.76,482.44,424.15],"text":"a) S/MIME\nb) SSH\nc) TLS\nd) VPN"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"S/MIME"},{"label":"b","text":"SSH"},{"label":"c","text":"TLS"},{"label":"d","text":"VPN"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q44)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q44. To provide a guarantee to its online customers that all credit card information is protected
 when transferred between their PC and the web service over public networks, which of the
 following technologies should be used?

 a) S/MIME b) SSH c) TLS d) VPN',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  45,
  'Q45. Which of the following UML diagrams is used to represent the user interactions with the
 system and the functions of the system?',
  '[{"type":"text","page":18,"bbox":[65.22,428.76,533.23,477.13],"text":"Q45.\nWhich of the following UML diagrams is used to represent the user interactions with the\nsystem and the functions of the system?"},{"type":"text","page":18,"bbox":[84.12,500.93,415.1,532.21],"text":"a) Activity diagram\nb) Class diagram\nc) Sequence diagram\nd) Use case diagram"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Activity diagram"},{"label":"b","text":"Class diagram"},{"label":"c","text":"Sequence diagram"},{"label":"d","text":"Use case diagram"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q45)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q45. Which of the following UML diagrams is used to represent the user interactions with the
 system and the functions of the system?

 a) Activity diagram b) Class diagram
 c) Sequence diagram d) Use case diagram',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  46,
  'Q46. Which of the following is an appropriate description of an acceptance test?',
  '[{"type":"text","page":18,"bbox":[65.22,572.76,475.7,586.21],"text":"Q46.\n Which of the following is an appropriate description of an acceptance test?"},{"type":"text","page":18,"bbox":[84.12,608.93,510.08,640.21],"text":"a) It is conducted by developers to verify response time and other performance items.\nb) It is conducted by testers to ensure that the interfaces and linkages between different"},{"type":"text","page":18,"bbox":[84.12,644.93,523.73,676.21],"text":"software parts work properly.\nc) It is conducted by the project manager to verify whether users’ functional requirements"},{"type":"text","page":18,"bbox":[84.12,680.93,525.3,712.21],"text":"are met or not.\nd) It is conducted by users to confirm that the software is complete and meets the business"},{"type":"text","page":18,"bbox":[102.12,716.93,346.33,730.21],"text":"needs that prompted the software to be developed."},{"type":"code","page":18,"bbox":[65.22,794.63,314.58,808.39],"text":"– 18 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"It is conducted by developers to verify response time and other performance items."},{"label":"b","text":"It is conducted by testers to ensure that the interfaces and linkages between different\n software parts work properly."},{"label":"c","text":"It is conducted by the project manager to verify whether users’ functional requirements\n are met or not."},{"label":"d","text":"It is conducted by users to confirm that the software is complete and meets the business\n needs that prompted the software to be developed.\n\n – 18 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q46)',
  ARRAY[18]::int[],
  'native_text',
  '3.0',
  'Q46. Which of the following is an appropriate description of an acceptance test?

 a) It is conducted by developers to verify response time and other performance items.
 b) It is conducted by testers to ensure that the interfaces and linkages between different
 software parts work properly.
 c) It is conducted by the project manager to verify whether users’ functional requirements
 are met or not.
 d) It is conducted by users to confirm that the software is complete and meets the business
 needs that prompted the software to be developed.

 – 18 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  47,
  'Q47. In the development process, which of the following is an activity that should be
 performed in software architectural design?',
  '[{"type":"text","page":19,"bbox":[65.22,68.76,539.02,190.21],"text":"Q47.\nIn the development process, which of the following is an activity that should be\nperformed in software architectural design?\n\na) Analyzing the requirements in incremental steps by arranging them in the form of a chart\nb) Describing the specifications so that the program is clarified on a line-by-line basis\nc) Obtaining the opinion of the customer and deciding the specifications\nd) Transforming the requirements for the software into a design that describes its top-level"},{"type":"text","page":19,"bbox":[65.22,194.93,343.92,226.21],"text":"structure and identifies the software components"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Analyzing the requirements in incremental steps by arranging them in the form of a chart"},{"label":"b","text":"Describing the specifications so that the program is clarified on a line-by-line basis"},{"label":"c","text":"Obtaining the opinion of the customer and deciding the specifications"},{"label":"d","text":"Transforming the requirements for the software into a design that describes its top-level\n structure and identifies the software components"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q47)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q47. In the development process, which of the following is an activity that should be
 performed in software architectural design?

 a) Analyzing the requirements in incremental steps by arranging them in the form of a chart
 b) Describing the specifications so that the program is clarified on a line-by-line basis
 c) Obtaining the opinion of the customer and deciding the specifications
 d) Transforming the requirements for the software into a design that describes its top-level
 structure and identifies the software components',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  48,
  'Q48. Which of the following is an appropriate description concerning test data for black box
 testing?',
  '[{"type":"text","page":19,"bbox":[65.22,230.93,533.16,298.21],"text":"Q48.\nWhich of the following is an appropriate description concerning test data for black box\ntesting?"},{"type":"text","page":19,"bbox":[65.22,302.93,356.37,388.21],"text":"a) Test data is created based on branch coverage.\nb) Test data is created based on condition coverage.\nc) Test data is created based on external specifications.\nd) Test data is created based on program structures."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Test data is created based on branch coverage."},{"label":"b","text":"Test data is created based on condition coverage."},{"label":"c","text":"Test data is created based on external specifications."},{"label":"d","text":"Test data is created based on program structures."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q48)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q48. Which of the following is an appropriate description concerning test data for black box
 testing?

 a) Test data is created based on branch coverage.
 b) Test data is created based on condition coverage.
 c) Test data is created based on external specifications.
 d) Test data is created based on program structures.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  49,
  'Q49. In an agile software development project, when can the customer review the first piece
 of working software?',
  '[{"type":"text","page":19,"bbox":[65.22,409.74,533.23,441.13],"text":"Q49.\nIn an agile software development project, when can the customer review the first piece\nof working software?"},{"type":"text","page":19,"bbox":[65.22,464.93,320.08,550.21],"text":"a) After the completion of the first epic\nb) After the completion of the first few releases\nc) After the completion of the first iteration\nd) After the completion of the whole project"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"After the completion of the first epic"},{"label":"b","text":"After the completion of the first few releases"},{"label":"c","text":"After the completion of the first iteration"},{"label":"d","text":"After the completion of the whole project"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q49)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q49. In an agile software development project, when can the customer review the first piece
 of working software?

 a) After the completion of the first epic
 b) After the completion of the first few releases
 c) After the completion of the first iteration
 d) After the completion of the whole project',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  50,
  'Q50. According to the Capability Maturity Model Integration, which of the following is the
 final and highest level of maturity?',
  '[{"type":"text","page":19,"bbox":[65.22,554.93,533.12,603.13],"text":"Q50.\nAccording to the Capability Maturity Model Integration, which of the following is the\nfinal and highest level of maturity?"},{"type":"text","page":19,"bbox":[65.22,608.93,446.87,676.21],"text":"a) Auditable\n\n\nb) Custom\nc) Optimizing\n\n\nd) Quantitatively Managed"},{"type":"code","page":19,"bbox":[65.22,794.63,314.58,808.39],"text":"– 19 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Auditable"},{"label":"b","text":"Custom"},{"label":"c","text":"Optimizing"},{"label":"d","text":"Quantitatively Managed\n\n – 19 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q50)',
  ARRAY[19]::int[],
  'native_text',
  '3.0',
  'Q50. According to the Capability Maturity Model Integration, which of the following is the
 final and highest level of maturity?

 a) Auditable b) Custom
 c) Optimizing d) Quantitatively Managed

 – 19 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[19]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  51,
  'Q51. Which of the following is one of the major responsibilities of a project manager?',
  '[{"type":"text","page":20,"bbox":[65.22,68.76,498.56,82.21],"text":"Q51.\nWhich of the following is one of the major responsibilities of a project manager?"},{"type":"text","page":20,"bbox":[84.12,104.93,516.35,172.21],"text":"a) Coding programs and debugging errors\nb) Evaluating the quality of project deliverables\nc) Organizing project members to achieve a planned result within a budget and schedule\nd) Providing the user requirements at the beginning of the project"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Coding programs and debugging errors"},{"label":"b","text":"Evaluating the quality of project deliverables"},{"label":"c","text":"Organizing project members to achieve a planned result within a budget and schedule"},{"label":"d","text":"Providing the user requirements at the beginning of the project"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q51)',
  ARRAY[20]::int[],
  'native_text',
  '3.0',
  'Q51. Which of the following is one of the major responsibilities of a project manager?

 a) Coding programs and debugging errors
 b) Evaluating the quality of project deliverables
 c) Organizing project members to achieve a planned result within a budget and schedule
 d) Providing the user requirements at the beginning of the project',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[20]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  52,
  'Q52. A project is planned to complete in 12 months and the budget for the completion of the
 project is $100,000. After six months, it is found that $60,000 was spent, but only 40% of
 the work has been completed. If the Cost Performance Index (CPI) is not changed, what is
 the estimated amount (in dollars) required to complete the remaining tasks of the project?',
  '[{"type":"text","page":20,"bbox":[65.22,212.76,533.18,280.21],"text":"Q52.\nA project is planned to complete in 12 months and the budget for the completion of the\nproject is $100,000. After six months, it is found that $60,000 was spent, but only 40% of\nthe work has been completed. If the Cost Performance Index (CPI) is not changed, what is\nthe estimated amount (in dollars) required to complete the remaining tasks of the project?"},{"type":"text","page":20,"bbox":[84.12,302.93,489.72,316.21],"text":"a) 40,000\nb) 60,000\nc) 90,000\nd) 150,000"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"40,000"},{"label":"b","text":"60,000"},{"label":"c","text":"90,000"},{"label":"d","text":"150,000"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q52)',
  ARRAY[20]::int[],
  'native_text',
  '3.0',
  'Q52. A project is planned to complete in 12 months and the budget for the completion of the
 project is $100,000. After six months, it is found that $60,000 was spent, but only 40% of
 the work has been completed. If the Cost Performance Index (CPI) is not changed, what is
 the estimated amount (in dollars) required to complete the remaining tasks of the project?

 a) 40,000 b) 60,000 c) 90,000 d) 150,000',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[20]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  53,
  'Q53. In project time management, which of the following is the amount of time that the start
 of a successor activity requires to be delayed after the finish of a predecessor activity?',
  '[{"type":"text","page":20,"bbox":[65.22,356.76,533.1,388.21],"text":"Q53.\nIn project time management, which of the following is the amount of time that the start\nof a successor activity requires to be delayed after the finish of a predecessor activity?"},{"type":"text","page":20,"bbox":[84.12,410.93,508.45,442.21],"text":"a) Free float\nb) Lag\nc) Lead\nd) Total float"},{"type":"code","page":20,"bbox":[65.22,794.63,314.58,808.39],"text":"– 20 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Free float"},{"label":"b","text":"Lag"},{"label":"c","text":"Lead"},{"label":"d","text":"Total float\n\n – 20 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q53)',
  ARRAY[20]::int[],
  'native_text',
  '3.0',
  'Q53. In project time management, which of the following is the amount of time that the start
 of a successor activity requires to be delayed after the finish of a predecessor activity?

 a) Free float b) Lag c) Lead d) Total float

 – 20 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[20]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  54,
  'Q54. The activities and nodes of a project are shown in the arrow diagram below. Which of
 the following is the effect of extending the duration of activity C by 3 days?

 D
 6 E A
 3 6
 C H
 5 1
 B G
 4 5
 F
 7 Legend:
 Node

 Activity name
 Activity Number of days required

 Dummy activity',
  '[{"type":"text","page":21,"bbox":[65.22,68.76,533.13,100.21],"text":"Q54.\nThe activities and nodes of a project are shown in the arrow diagram below. Which of\nthe following is the effect of extending the duration of activity C by 3 days?"},{"type":"text","page":21,"bbox":[252.18,126.21,260.5,138.84],"text":"D"},{"type":"text","page":21,"bbox":[253.44,139.65,339.98,155.28],"text":"6\nE"},{"type":"text","page":21,"bbox":[172.74,143.25,179.78,155.88],"text":"A"},{"type":"text","page":21,"bbox":[333.54,156.09,339.3,168.72],"text":"6"},{"type":"text","page":21,"bbox":[173.4,156.69,179.16,169.32],"text":"3"},{"type":"text","page":21,"bbox":[390.54,169.47,398.86,182.1],"text":"H"},{"type":"text","page":21,"bbox":[252.54,172.35,260.23,184.98],"text":"C"},{"type":"text","page":21,"bbox":[391.8,182.91,397.56,195.54],"text":"1"},{"type":"text","page":21,"bbox":[253.44,185.79,259.2,198.42],"text":"5"},{"type":"text","page":21,"bbox":[172.74,197.31,179.78,209.94],"text":"B"},{"type":"text","page":21,"bbox":[332.28,197.31,340.6,209.94],"text":"G"},{"type":"text","page":21,"bbox":[173.4,210.75,179.16,223.38],"text":"4"},{"type":"text","page":21,"bbox":[333.54,210.75,339.3,223.38],"text":"5"},{"type":"text","page":21,"bbox":[252.84,217.11,259.88,229.74],"text":"F"},{"type":"text","page":21,"bbox":[253.44,230.55,259.2,243.18],"text":"7"},{"type":"text","page":21,"bbox":[331.8,233.3,383.3,257.37],"text":"Node\nLegend:"},{"type":"text","page":21,"bbox":[391.92,267.43,477.9,287.97],"text":"Activity name\nNumber of days required"},{"type":"text","page":21,"bbox":[354.24,273.91,385.62,283.89],"text":"Activity"},{"type":"text","page":21,"bbox":[328.68,299.95,389.22,309.93],"text":"Dummy activity"},{"type":"text","page":21,"bbox":[84.12,334.43,312.51,401.71],"text":"a) The project duration is not affected.\nb) The project duration is extended by 1 day.\nc) The project duration is extended by 2 days.\nd) The project duration is extended by 3 days."}]'::jsonb,
  '["2021-october-a-q54-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"The project duration is not affected."},{"label":"b","text":"The project duration is extended by 1 day."},{"label":"c","text":"The project duration is extended by 2 days."},{"label":"d","text":"The project duration is extended by 3 days."}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q54)',
  ARRAY[21]::int[],
  'native_text',
  '3.0',
  'Q54. The activities and nodes of a project are shown in the arrow diagram below. Which of
 the following is the effect of extending the duration of activity C by 3 days?

 D
 6 E A
 3 6
 C H
 5 1
 B G
 4 5
 F
 7 Legend:
 Node

 Activity name
 Activity Number of days required

 Dummy activity

 a) The project duration is not affected.
 b) The project duration is extended by 1 day.
 c) The project duration is extended by 2 days.
 d) The project duration is extended by 3 days.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[21]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  55,
  'Q55. Which of the following corresponds to benchmarking in process improvement of service
 management?',
  '[{"type":"text","page":21,"bbox":[65.22,441.24,533.12,472.63],"text":"Q55.\nWhich of the following corresponds to benchmarking in process improvement of service\nmanagement?"},{"type":"text","page":21,"bbox":[84.12,478.43,511.4,509.71],"text":"a) The availability, reliability, and performance are measured at the service level, and a"},{"type":"text","page":21,"bbox":[84.12,514.43,484.43,545.71],"text":"report is sent to the customers.\nb) The current status of IT service management is analyzed from the viewpoint of"},{"type":"text","page":21,"bbox":[84.12,550.43,520.28,581.71],"text":"strengths, weaknesses, opportunities, and threats.\nc) The performance of IT services is measured from the viewpoint of finance, customers,"},{"type":"text","page":21,"bbox":[84.12,586.43,509.69,617.71],"text":"internal processes, and learning and growth, and strategic activities are supported.\nd) The service quality and performance level are evaluated in comparison with the best"},{"type":"text","page":21,"bbox":[102.12,622.43,302.42,635.71],"text":"practices within and outside the industry."},{"type":"code","page":21,"bbox":[65.22,794.63,314.58,808.39],"text":"– 21 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"The availability, reliability, and performance are measured at the service level, and a\n report is sent to the customers."},{"label":"b","text":"The current status of IT service management is analyzed from the viewpoint of\n strengths, weaknesses, opportunities, and threats."},{"label":"c","text":"The performance of IT services is measured from the viewpoint of finance, customers,\n internal processes, and learning and growth, and strategic activities are supported."},{"label":"d","text":"The service quality and performance level are evaluated in comparison with the best\n practices within and outside the industry.\n\n – 21 –"}]'::jsonb,
  'd',
  '{"value":"d"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q55)',
  ARRAY[21]::int[],
  'native_text',
  '3.0',
  'Q55. Which of the following corresponds to benchmarking in process improvement of service
 management?

 a) The availability, reliability, and performance are measured at the service level, and a
 report is sent to the customers.
 b) The current status of IT service management is analyzed from the viewpoint of
 strengths, weaknesses, opportunities, and threats.
 c) The performance of IT services is measured from the viewpoint of finance, customers,
 internal processes, and learning and growth, and strategic activities are supported.
 d) The service quality and performance level are evaluated in comparison with the best
 practices within and outside the industry.

 – 21 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[21]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  56,
  'Q56. Which of the following is the appropriate description for a system migration plan?',
  '[{"type":"text","page":22,"bbox":[65.22,68.76,525.29,118.21],"text":"Q56.\nWhich of the following is the appropriate description for a system migration plan?\n\na) A system migration plan must describe the decision criteria for restoring the old system"},{"type":"text","page":22,"bbox":[84.12,122.93,522.69,172.21],"text":"in case the migration fails.\nb) Operating the new system and the old system in parallel reduces the cost of migration.\nc) Sharing a part of the environment between the new system and the old system makes it"},{"type":"text","page":22,"bbox":[84.12,176.93,500.4,208.21],"text":"easier to verify the migration status.\nd) The greater the amount of data to be migrated, the more appropriate it would be to"},{"type":"text","page":22,"bbox":[102.12,212.93,474.03,226.21],"text":"migrate the data in a single batch immediately before the system is switched."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"A system migration plan must describe the decision criteria for restoring the old system\n in case the migration fails."},{"label":"b","text":"Operating the new system and the old system in parallel reduces the cost of migration."},{"label":"c","text":"Sharing a part of the environment between the new system and the old system makes it\n easier to verify the migration status."},{"label":"d","text":"The greater the amount of data to be migrated, the more appropriate it would be to\n migrate the data in a single batch immediately before the system is switched."}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q56)',
  ARRAY[22]::int[],
  'native_text',
  '3.0',
  'Q56. Which of the following is the appropriate description for a system migration plan?

 a) A system migration plan must describe the decision criteria for restoring the old system
 in case the migration fails.
 b) Operating the new system and the old system in parallel reduces the cost of migration.
 c) Sharing a part of the environment between the new system and the old system makes it
 easier to verify the migration status.
 d) The greater the amount of data to be migrated, the more appropriate it would be to
 migrate the data in a single batch immediately before the system is switched.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[22]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  57,
  'Q57. For servers, the total cost of ownership (TCO) is calculated over a period of 5 years. The
 purchase price of the servers is $120,500 and the other annual costs are listed as below. What
 is the TCO of the servers (in dollars)?

 Area of cost Annual cost ($)
 Insurance 2,030
 Maintenance 1,000
 Repair (average) 700
 Registration 270',
  '[{"type":"text","page":22,"bbox":[65.22,266.76,533.11,316.21],"text":"Q57.\nFor servers, the total cost of ownership (TCO) is calculated over a period of 5 years. The\npurchase price of the servers is $120,500 and the other annual costs are listed as below. What\nis the TCO of the servers (in dollars)?"},{"type":"table","page":22,"bbox":[159.02,335.34,362.26,428.06],"rows":[["Area of cost","Annual cost ($)"],["Insurance","2,030"],["Maintenance","1,000"],["Repair (average)","700"],["Registration","270"]]},{"type":"text","page":22,"bbox":[186.42,338.33,357.61,351.61],"text":"Area of cost\nAnnual cost ($)"},{"type":"text","page":22,"bbox":[164.46,356.81,359.79,370.09],"text":"Insurance\n2,030"},{"type":"text","page":22,"bbox":[164.46,375.35,359.84,388.63],"text":"Maintenance\n1,000"},{"type":"text","page":22,"bbox":[164.46,393.83,359.81,407.11],"text":"Repair (average)\n700"},{"type":"text","page":22,"bbox":[164.46,412.31,359.77,425.59],"text":"Registration\n270"},{"type":"text","page":22,"bbox":[65.22,449.93,497.1,481.15],"text":"a) 28,100\nb) 120,500\nc) 140,500\nd) 622,500"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"28,100"},{"label":"b","text":"120,500"},{"label":"c","text":"140,500"},{"label":"d","text":"622,500"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q57)',
  ARRAY[22]::int[],
  'native_text',
  '3.0',
  'Q57. For servers, the total cost of ownership (TCO) is calculated over a period of 5 years. The
 purchase price of the servers is $120,500 and the other annual costs are listed as below. What
 is the TCO of the servers (in dollars)?

 Area of cost Annual cost ($)
 Insurance 2,030
 Maintenance 1,000
 Repair (average) 700
 Registration 270

 a) 28,100 b) 120,500 c) 140,500 d) 622,500',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[22]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  58,
  'Q58. In the event of a disk failure, which of the following is a method for recovering a database
 by restoring a full backup data onto a disk from a tape, and then reflecting, from logs, postupdate copies after the full backup was taken?',
  '[{"type":"text","page":22,"bbox":[65.22,503.76,533.1,607.21],"text":"Q58.\nIn the event of a disk failure, which of the following is a method for recovering a database\nby restoring a full backup data onto a disk from a tape, and then reflecting, from logs, post-\nupdate copies after the full backup was taken?\n\na) Checkpoint restart\nb) Reboot\nc) Roll forward\nd) Rollback"},{"type":"code","page":22,"bbox":[65.22,794.63,314.58,808.39],"text":"– 22 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Checkpoint restart"},{"label":"b","text":"Reboot"},{"label":"c","text":"Roll forward"},{"label":"d","text":"Rollback\n\n – 22 –"}]'::jsonb,
  'c',
  '{"value":"c"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q58)',
  ARRAY[22]::int[],
  'native_text',
  '3.0',
  'Q58. In the event of a disk failure, which of the following is a method for recovering a database
 by restoring a full backup data onto a disk from a tape, and then reflecting, from logs, postupdate copies after the full backup was taken?

 a) Checkpoint restart b) Reboot
 c) Roll forward d) Rollback

 – 22 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[22]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  59,
  'Q59. Which of the following is the most appropriate point to be checked in the audit of a
 system test?',
  '[{"type":"text","page":23,"bbox":[65.22,68.76,533.16,172.21],"text":"Q59.\nWhich of the following is the most appropriate point to be checked in the audit of a\nsystem test?\n\na) The test cases were created comprehensively.\nb) The test plan was approved only by the responsible person on the user’s side.\nc) The test was performed in an environment where the actual business operations are"},{"type":"text","page":23,"bbox":[84.12,176.93,446.98,208.21],"text":"performed.\nd) The test was performed only by the person in charge on the user’s side."}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"The test cases were created comprehensively."},{"label":"b","text":"The test plan was approved only by the responsible person on the user’s side."},{"label":"c","text":"The test was performed in an environment where the actual business operations are\n performed."},{"label":"d","text":"The test was performed only by the person in charge on the user’s side."}]'::jsonb,
  'a',
  '{"value":"a"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q59)',
  ARRAY[23]::int[],
  'native_text',
  '3.0',
  'Q59. Which of the following is the most appropriate point to be checked in the audit of a
 system test?

 a) The test cases were created comprehensively.
 b) The test plan was approved only by the responsible person on the user’s side.
 c) The test was performed in an environment where the actual business operations are
 performed.
 d) The test was performed only by the person in charge on the user’s side.',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[23]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'A',
  60,
  'Q60. The director requested a system auditor to audit the operating status of an accounting
 system that was developed by the information systems department and is operated by the
 accounting department. Which of the following is the most appropriate description concerning
 the system auditor for this audit?

 a) The system auditor must be a certified public accountant because the accounting system
 must conform to the various standards of business accounting.
 b) The system auditor must be a person who belongs to neither the information systems
 department nor the accounting department to guarantee independence.
 c) The system auditor must report directly to the accounting department manager because
 the accounting system handles highly confidential information.
 d) The system auditor must report directly to the information systems department manager
 to perform system audits efficiently.

Q61. Which of the following is an appropriate feasibility evaluation when checking whether
 the lifetime benefits of the proposed information system is greater than its lifetime costs?

 a) Economic feasibility b) Operational feasibility
 c) Scheduling feasibility d) Technical feasibility

 – 23 –

Q62. In an evaluation of an IT investment, a preliminary evaluation, an interim evaluation,
 and a posteriori evaluation are conducted in accordance with the planning, execution, and
 completion of individual projects. Which of the following is a description of the preliminary
 evaluation?

 a) A variance between the plan and results as well as its cause are analyzed in detail, and it
 is determined whether a change is required in the investment amount or the effect goal.
 b) An effect goal is set on the basis of the investment purpose, and the information that is
 required to make a decision on whether it is possible to execute is provided to higherlevel management.
 c) Milestones when the investment effect should be attained and the data collection method
 that is required for the evaluation are planned in advance, and an evaluation is made at
 the times of those milestones.
 d) The achievement status of the effect goal that was set in advance is evaluated, and
 improvement measures for achieving the objective is considered when required.

Q63. Which of the following is a description of BPO?

 a) It refers to a company not having its own server and operating a system by renting a part
 of the processing capability or the storage capacity of a server that is owned by a
 communication service provider.
 b) It refers to a company not having its own software and using functions of software that
 an external specialized vendor provides via a network.
 c) It refers to the outsourcing of a whole business process of a specific department of the
 company, such as the administration department or the call center, together with the
 operation of a business system to an external specialized vendor.
 d) It refers to utilizing employees from a staffing company with lower personnel
 expenditures than those of the company to reduce the cost of software development.

Q64. In computerization investment, which of the following is a technique that is used to create
 categories on the basis of the similarities of risks and investment values and perform optimum
 resource allocation?

 a) 3C analysis b) Benchmarking
 c) Enterprise architecture d) IT portfolio

 – 24 –

Q65. Which of the following is an activity that is performed when non-functional requirements
 are defined?

 a) Clarifying the flows of information (i.e., data) between the functions that constitute
 business operations
 b) Creating technical requirements of development standard according to the programming
 language used in system development
 c) Defining the scope to be implemented as system functions
 d) Specifying the interface for exchanging information with other systems

Q66. Which of the following is a technique that is used to identify and evaluate the internal
 and external factors that are helpful or harmful to the objectives of business organizations or
 projects?

 a) Five forces analysis b) PPM analysis
 c) SWOT analysis d) Value chain analysis

Q67. The sales prices of products are decided according to different sales price setting methods.
 Which of the following approaches sets a high sales price by using the consumer psychology
 that high quality equals to high price?

 a) Cost plus pricing b) Differential pricing
 c) Marketing price following pricing d) Prestige pricing

 – 25 –

Q68. Company T sells three (3) products: A, B, and C. Currently, products A, B, and C have
 10,000, 20,000, and 80,000 purchasers every month, respectively. There is a plan to change
 the product line and sell four (4) new products, P, Q, R, and S, from next year. Accordingly, a
 trial calculation was made on the proportion of existing customers that will purchase the new
 products and the number of new customers. Which of the following is an appropriate
 conclusion from the trial calculation? Here, numerical values up to one (1) decimal point in
 each line of the table below represent the proportion of people who will change to the new
 product from the corresponding old product.

 Number of
 P Q R S
 people

 A 10,000 0.5 0.3 0.1 0.1

 B 20,000 0.1 0.6 0.1 0.1

 C 80,000 0.1 0.1 0.3 0.3

 Number of existing
 15,000 23,000 27,000 27,000
 customers

 Number of new
 5,000 7,000 13,000 23,000
 customers

 a) Among the purchasers of product A, 1,000 people are estimated to purchase the new
 product Q.
 b) Of the prospective purchasers of the new product P, 50% are estimated to be purchasers
 of product A.
 c) The number of new customers of the new product S are estimated to be fewer than the
 number of people who will purchase the new product S among the purchasers of product
 C.
 d) The purchasers of product B are estimated to purchase any one (1) of the new products
 P, Q, R, and S.

Q69. Which of the following is the appropriate explanation for product innovation in the
 management of technology?

 a) Acquiring business profits through achievements of the development of technology
 b) Developing new products or products that enable differentiation from other companies
 c) Making innovative reforms in business processes
 d) Strategically managing business with technology as the core

 – 26 –

Q70. Among the different business systems supported by technology, which of the following
 analyzes routes of distribution, tracking and load tendency?

 a) LMS b) OMS c) TMS d) WMS

Q71. Which of the following is a product that can take advantage of the cell production
 system?

 a) A product that needs to be produced in large quantities to improve productivity
 b) A product that requires a division of labor on the basis of standardization, simplification,
 and specialization
 c) A product that requires a variety of types and needs flexible production
 d) A product whose specifications do not change over a long period of time

Q72. Which of the following performs its processing according to steps (1) through (3)?

 (1) Based on the types, quantities, and the parts list of the product planned to be
 manufactured during a fixed period of time in the future, the required quantity of
 components is calculated.
 (2) The net order quantity of each component is calculated from the amount of inventory
 that can be allocated.
 (3) The ordering time of the components is determined while considering the
 manufacturing and procurement lead time.

 a) CAD (Computer Aided Design) b) CRP (Capacity Requirements Planning)
 c) JIT (Just In Time) d) MRP (Material Requirements Planning)

 – 27 –

Q73. Which of the following is an appropriate description of Initial Coin Offering (ICO)?

 a) A crowd-funding method in which backers contribute money toward an idea or a startup
 and get rewards like physical products
 b) A fundraising method that is mainly used by a financially stable company which wants
 to expand and develop to the public
 c) A popular fundraising method that is used primarily by a startup, normally through
 utilizing cryptocurrency
 d) A process of offering shares of a private corporation to the public in a new stock
 issuance

Q74. Which of the following is an appropriate example of utilizing machine learning at a
 production site?

 a) Instead of programming the working method for the production robot in the factory, the
 robot itself learns, thus improving the efficiency of work.
 b) The causes for the occurrence of defects in a factory are decomposed and arranged in a
 tree shape so that analysts can statistically look for the cause and solution.
 c) The production equipment in a factory is connected through high-speed communication
 so that the host computer can be controlled in real time.
 d) The productivity of employees in the factory improves each time the cumulative
 production volume doubles, and the unit cost reduces at a fixed percentage.

Q75. Which of the following is a management organization that creates a cross-functional team
 between project and functional organizations to flexibly respond to changes in the business
 environment?

 a) Divisional organization b) Line and staff organization
 c) Matrix organization d) Project organization

 – 28 –

Q76. Which of the following is an example of Green IT?

 a) Development of a powerful in-house data center
 b) Development of efficient in-house software
 c) Using a desktop PC instead of a thin client laptop
 d) Using web conferencing instead of travelling to meetings

Q77. Which of the following is a description of a CIO?

 a) The chief executive that governs the planning and execution of strategies in the area of
 finances, such as fund-raising or financial reporting
 b) The chief executive that governs the planning and execution of strategies regarding
 information management and information systems
 c) The chief executive that governs the planning and execution of technological strategies
 and R&D plans of the company
 d) The chief executive that governs the planning of business strategies and the execution of
 business

Q78. Which of the following is the appropriate description concerning creation and operation
 of a Business Continuity Plan (BCP)?

 a) In addition to natural disasters, device failure in information systems and malware
 infections are also included in the scope of examination.
 b) The planning contents are important matters related to the business strategy and
 therefore, only senior managers are notified.
 c) The planning contents are restricted to those activities performed by the company.
 d) The recovery of business processes dependent on IT is prioritized according to technical
 easiness of recovery.

 – 29 –

Q79. Company A has two media plans. One plan is for a series of 30-second radio
 advertisements (ads) and the other is for 60-second TV ads. Exposure is rated in points.
 The company is considering an exposure of at least 60 points in the city and at most 40 points
 outside the city. The table below shows the cost and exposure of both TV and radio ads.
 Which of the following is the set of expressions that can determine the number of media ads
 to minimize the total cost?

 Cost In the city Outside the city
 exposure (points) exposure (points)
 TV ads 2000 8 6
 Radio ads 800 10 3

 a) Conditions 8x + 6y ≤ 60, 10x + 3y ≤ 40, x ≥ 0, y ≥ 0
 Objective function 2000x + 800y  minimize
 b) Conditions 8x + 6y ≥ 60, 10x + 3y ≤ 40, x ≥ 0, y ≥ 0
 Objective function 2000x + 800y  minimize
 c) Conditions 8x + 10y ≤ 60, 6x + 3y ≤ 40, x ≥ 0, y ≥ 0
 Objective function 2000x + 800y  minimize
 d) Conditions 8x + 10y ≥ 60, 6x + 3y ≤ 40, x ≥ 0, y ≥ 0
 Objective function 2000x + 800y  minimize

Q80. Which of the following is an appropriate description of the scope of software protection
 under WTO’s Agreement on Trade-Related Aspects of Intellectual Property Rights
 (TRIPS)?',
  '[{"type":"text","page":23,"bbox":[65.22,230.93,533.13,315.13],"text":"Q60.\nThe director requested a system auditor to audit the operating status of an accounting\nsystem that was developed by the information systems department and is operated by the\naccounting department. Which of the following is the most appropriate description concerning\nthe system auditor for this audit?"},{"type":"text","page":23,"bbox":[84.12,338.93,527.65,352.21],"text":"a) The system auditor must be a certified public accountant because the accounting system"},{"type":"text","page":23,"bbox":[84.12,356.93,512.06,388.21],"text":"must conform to the various standards of business accounting.\nb) The system auditor must be a person who belongs to neither the information systems"},{"type":"text","page":23,"bbox":[84.12,392.93,522.6,424.21],"text":"department nor the accounting department to guarantee independence.\nc) The system auditor must report directly to the accounting department manager because"},{"type":"text","page":23,"bbox":[84.12,428.93,526.71,460.21],"text":"the accounting system handles highly confidential information.\nd) The system auditor must report directly to the information systems department manager"},{"type":"text","page":23,"bbox":[102.12,464.93,279.41,478.21],"text":"to perform system audits efficiently."},{"type":"text","page":23,"bbox":[65.22,517.74,533.1,549.13],"text":"Q61.\nWhich of the following is an appropriate feasibility evaluation when checking whether\nthe lifetime benefits of the proposed information system is greater than its lifetime costs?"},{"type":"text","page":23,"bbox":[65.22,572.9,438.19,640.15],"text":"a) Economic feasibility\nb) Operational feasibility\nc) Scheduling feasibility\nd) Technical feasibility"},{"type":"code","page":23,"bbox":[65.22,794.63,314.58,808.39],"text":"– 23 –"},{"type":"text","page":24,"bbox":[65.22,67.74,533.15,135.13],"text":"Q62.\n In an evaluation of an IT investment, a preliminary evaluation, an interim evaluation,\nand a posteriori evaluation are conducted in accordance with the planning, execution, and\ncompletion of individual projects. Which of the following is a description of the preliminary\nevaluation?"},{"type":"text","page":24,"bbox":[84.12,160.91,528.19,174.19],"text":"a) A variance between the plan and results as well as its cause are analyzed in detail, and it"},{"type":"text","page":24,"bbox":[84.12,178.91,523.36,210.19],"text":"is determined whether a change is required in the investment amount or the effect goal.\nb) An effect goal is set on the basis of the investment purpose, and the information that is"},{"type":"text","page":24,"bbox":[84.12,214.91,531.04,264.19],"text":"required to make a decision on whether it is possible to execute is provided to higher-\nlevel management.\nc) Milestones when the investment effect should be attained and the data collection method"},{"type":"text","page":24,"bbox":[84.12,268.91,520.26,318.19],"text":"that is required for the evaluation are planned in advance, and an evaluation is made at\nthe times of those milestones.\nd) The achievement status of the effect goal that was set in advance is evaluated, and"},{"type":"text","page":24,"bbox":[65.22,322.91,489.04,389.17],"text":"improvement measures for achieving the objective is considered when required.\n\n\nQ63.\nWhich of the following is a description of BPO?"},{"type":"text","page":24,"bbox":[84.12,414.89,530.08,428.17],"text":"a) It refers to a company not having its own server and operating a system by renting a part"},{"type":"text","page":24,"bbox":[84.12,432.89,521.95,482.17],"text":"of the processing capability or the storage capacity of a server that is owned by a\ncommunication service provider.\nb) It refers to a company not having its own software and using functions of software that"},{"type":"text","page":24,"bbox":[84.12,486.89,517.98,518.17],"text":"an external specialized vendor provides via a network.\nc) It refers to the outsourcing of a whole business process of a specific department of the"},{"type":"text","page":24,"bbox":[84.12,522.89,507.68,572.17],"text":"company, such as the administration department or the call center, together with the\noperation of a business system to an external specialized vendor.\nd) It refers to utilizing employees from a staffing company with lower personnel"},{"type":"text","page":24,"bbox":[102.12,576.89,508.58,590.17],"text":"expenditures than those of the company to reduce the cost of software development."},{"type":"text","page":24,"bbox":[65.22,612.89,533.11,679.09],"text":"Q64.\nIn computerization investment, which of the following is a technique that is used to create\ncategories on the basis of the similarities of risks and investment values and perform optimum\nresource allocation?"},{"type":"text","page":24,"bbox":[65.22,684.89,407.12,770.11],"text":"a) 3C analysis\nb) Benchmarking\nc) Enterprise architecture\nd) IT portfolio"},{"type":"code","page":24,"bbox":[65.22,794.63,314.58,808.39],"text":"– 24 –"},{"type":"text","page":25,"bbox":[65.22,67.74,533.17,99.13],"text":"Q65.\nWhich of the following is an activity that is performed when non-functional requirements\nare defined?"},{"type":"text","page":25,"bbox":[84.12,122.93,505.12,136.21],"text":"a) Clarifying the flows of information (i.e., data) between the functions that constitute"},{"type":"text","page":25,"bbox":[84.12,140.93,528.7,172.21],"text":"business operations\nb) Creating technical requirements of development standard according to the programming"},{"type":"text","page":25,"bbox":[65.22,176.93,447.68,244.21],"text":"language used in system development\nc) Defining the scope to be implemented as system functions\nd) Specifying the interface for exchanging information with other systems"},{"type":"text","page":25,"bbox":[65.22,265.74,533.14,315.13],"text":"Q66.\nWhich of the following is a technique that is used to identify and evaluate the internal\nand external factors that are helpful or harmful to the objectives of business organizations or\nprojects?"},{"type":"text","page":25,"bbox":[84.12,338.93,429.84,370.21],"text":"a) Five forces analysis\nb) PPM analysis\nc) SWOT analysis\nd) Value chain analysis"},{"type":"text","page":25,"bbox":[65.22,392.93,533.23,459.13],"text":"Q67.\nThe sales prices of products are decided according to different sales price setting methods.\nWhich of the following approaches sets a high sales price by using the consumer psychology\nthat high quality equals to high price?"},{"type":"text","page":25,"bbox":[84.12,464.93,429.45,514.21],"text":"a) Cost plus pricing\nb) Differential pricing\nc) Marketing price following pricing\nd) Prestige pricing"},{"type":"code","page":25,"bbox":[65.22,794.63,314.58,808.39],"text":"– 25 –"},{"type":"text","page":26,"bbox":[65.22,67.74,533.27,207.13],"text":"Q68.\nCompany T sells three (3) products: A, B, and C. Currently, products A, B, and C have\n10,000, 20,000, and 80,000 purchasers every month, respectively. There is a plan to change\nthe product line and sell four (4) new products, P, Q, R, and S, from next year. Accordingly, a\ntrial calculation was made on the proportion of existing customers that will purchase the new\nproducts and the number of new customers. Which of the following is an appropriate\nconclusion from the trial calculation? Here, numerical values up to one (1) decimal point in\neach line of the table below represent the proportion of people who will change to the new\nproduct from the corresponding old product."},{"type":"table","page":26,"bbox":[105.2,229.39,501.99,418.47],"rows":[["","Number of\npeople","P","Q","R","S"],["A","10,000","0.5","0.3","0.1","0.1"],["B","20,000","0.1","0.6","0.1","0.1"],["C","80,000","0.1","0.1","0.3","0.3"],["Number of existing\ncustomers",null,"15,000","23,000","27,000","27,000"],["Number of new\ncustomers",null,"5,000","7,000","13,000","23,000"]]},{"type":"text","page":26,"bbox":[130.74,234.29,216.18,256.63],"text":"Number of"},{"type":"text","page":26,"bbox":[171.0,243.35,471.9,265.63],"text":"people\nP\nQ\nR\nS"},{"type":"text","page":26,"bbox":[127.2,274.85,499.08,288.13],"text":"A\n10,000\n0.5\n0.3\n0.1\n0.1"},{"type":"text","page":26,"bbox":[127.2,297.35,499.08,310.63],"text":"B\n20,000\n0.1\n0.6\n0.1\n0.1"},{"type":"text","page":26,"bbox":[126.84,319.85,499.08,333.13],"text":"C\n80,000\n0.1\n0.1\n0.3\n0.3"},{"type":"text","page":26,"bbox":[114.6,342.29,211.02,355.57],"text":"Number of existing"},{"type":"text","page":26,"bbox":[136.98,351.35,499.08,373.63],"text":"customers\n15,000\n23,000\n27,000\n27,000"},{"type":"text","page":26,"bbox":[123.66,382.79,201.95,396.07],"text":"Number of new"},{"type":"text","page":26,"bbox":[136.98,391.85,499.08,414.13],"text":"customers\n5,000\n7,000\n13,000\n23,000"},{"type":"text","page":26,"bbox":[84.12,442.43,509.39,455.71],"text":"a) Among the purchasers of product A, 1,000 people are estimated to purchase the new"},{"type":"text","page":26,"bbox":[84.12,460.43,527.33,491.71],"text":"product Q.\nb) Of the prospective purchasers of the new product P, 50% are estimated to be purchasers"},{"type":"text","page":26,"bbox":[102.12,496.43,168.12,509.71],"text":"of product A."},{"type":"text","page":26,"bbox":[84.12,514.43,518.32,527.71],"text":"c) The number of new customers of the new product S are estimated to be fewer than the"},{"type":"text","page":26,"bbox":[84.12,532.43,530.41,581.71],"text":"number of people who will purchase the new product S among the purchasers of product\nC.\nd) The purchasers of product B are estimated to purchase any one (1) of the new products"},{"type":"text","page":26,"bbox":[102.12,586.43,175.8,599.71],"text":"P, Q, R, and S."},{"type":"text","page":26,"bbox":[65.22,622.43,516.47,671.71],"text":"Q69.\nWhich of the following is the appropriate explanation for product innovation in the\nmanagement of technology?"},{"type":"text","page":26,"bbox":[84.12,676.43,521.03,761.71],"text":"a) Acquiring business profits through achievements of the development of technology\nb) Developing new products or products that enable differentiation from other companies\nc) Making innovative reforms in business processes\nd) Strategically managing business with technology as the core"},{"type":"code","page":26,"bbox":[65.22,794.63,314.58,808.39],"text":"– 26 –"},{"type":"text","page":27,"bbox":[65.22,68.76,530.19,100.21],"text":"Q70.\nAmong the different business systems supported by technology, which of the following\nanalyzes routes of distribution, tracking and load tendency?"},{"type":"text","page":27,"bbox":[84.12,122.93,486.72,136.21],"text":"a) LMS\nb) OMS\nc) TMS\nd) WMS"},{"type":"text","page":27,"bbox":[65.22,158.93,533.18,207.13],"text":"Q71.\nWhich of the following is a product that can take advantage of the cell production\nsystem?"},{"type":"text","page":27,"bbox":[84.12,230.93,531.45,262.21],"text":"a) A product that needs to be produced in large quantities to improve productivity\nb) A product that requires a division of labor on the basis of standardization, simplification,"},{"type":"text","page":27,"bbox":[84.12,266.93,454.4,316.21],"text":"and specialization\nc) A product that requires a variety of types and needs flexible production\nd) A product whose specifications do not change over a long period of time"},{"type":"text","page":27,"bbox":[65.22,338.76,506.74,369.19],"text":"Q72.\nWhich of the following performs its processing according to steps (1) through (3)?"},{"type":"text","page":27,"bbox":[102.36,392.93,533.11,406.21],"text":"(1) Based on the types, quantities, and the parts list of the product planned to be"},{"type":"text","page":27,"bbox":[102.36,410.93,533.15,460.21],"text":"manufactured during a fixed period of time in the future, the required quantity of\ncomponents is calculated.\n(2) The net order quantity of each component is calculated from the amount of inventory"},{"type":"text","page":27,"bbox":[102.36,464.93,533.17,496.21],"text":"that can be allocated.\n(3) The ordering time of the components is determined while considering the"},{"type":"text","page":27,"bbox":[84.12,500.93,522.85,586.21],"text":"manufacturing and procurement lead time.\n\na) CAD (Computer Aided Design)\nb) CRP (Capacity Requirements Planning)\nc) JIT (Just In Time)\nd) MRP (Material Requirements Planning)"},{"type":"code","page":27,"bbox":[65.22,794.63,314.58,808.39],"text":"– 27 –"},{"type":"text","page":28,"bbox":[65.22,67.74,514.12,99.13],"text":"Q73.\nWhich of the following is an appropriate description of Initial Coin Offering (ICO)?"},{"type":"text","page":28,"bbox":[84.12,104.93,529.35,118.21],"text":"a) A crowd-funding method in which backers contribute money toward an idea or a startup"},{"type":"text","page":28,"bbox":[84.12,122.93,522.7,154.21],"text":"and get rewards like physical products\nb) A fundraising method that is mainly used by a financially stable company which wants"},{"type":"text","page":28,"bbox":[84.12,158.93,503.49,190.21],"text":"to expand and develop to the public\nc) A popular fundraising method that is used primarily by a startup, normally through"},{"type":"text","page":28,"bbox":[84.12,194.93,491.35,226.21],"text":"utilizing cryptocurrency\nd) A process of offering shares of a private corporation to the public in a new stock"},{"type":"text","page":28,"bbox":[65.22,230.93,533.12,315.13],"text":"issuance\n\n\nQ74.\nWhich of the following is an appropriate example of utilizing machine learning at a\nproduction site?"},{"type":"text","page":28,"bbox":[84.12,320.93,526.42,352.21],"text":"a) Instead of programming the working method for the production robot in the factory, the"},{"type":"text","page":28,"bbox":[84.12,356.93,522.51,388.21],"text":"robot itself learns, thus improving the efficiency of work.\nb) The causes for the occurrence of defects in a factory are decomposed and arranged in a"},{"type":"text","page":28,"bbox":[84.12,392.93,526.28,424.21],"text":"tree shape so that analysts can statistically look for the cause and solution.\nc) The production equipment in a factory is connected through high-speed communication"},{"type":"text","page":28,"bbox":[84.12,428.93,490.79,460.21],"text":"so that the host computer can be controlled in real time.\nd) The productivity of employees in the factory improves each time the cumulative"},{"type":"text","page":28,"bbox":[65.22,464.93,466.65,496.21],"text":"production volume doubles, and the unit cost reduces at a fixed percentage."},{"type":"text","page":28,"bbox":[65.22,518.76,533.16,586.21],"text":"Q75.\nWhich of the following is a management organization that creates a cross-functional team\nbetween project and functional organizations to flexibly respond to changes in the business\nenvironment?"},{"type":"text","page":28,"bbox":[84.12,590.93,466.12,622.21],"text":"a) Divisional organization\nb) Line and staff organization\nc) Matrix organization\nd) Project organization"},{"type":"code","page":28,"bbox":[65.22,794.63,314.58,808.39],"text":"– 28 –"},{"type":"text","page":29,"bbox":[65.22,67.74,356.51,81.19],"text":"Q76.\nWhich of the following is an example of Green IT?"},{"type":"text","page":29,"bbox":[84.12,104.93,340.85,118.21],"text":"a)\nDevelopment of a powerful in-house data center"},{"type":"text","page":29,"bbox":[84.12,122.93,324.17,136.21],"text":"b)\nDevelopment of efficient in-house software"},{"type":"text","page":29,"bbox":[84.12,140.93,346.48,154.21],"text":"c)\nUsing a desktop PC instead of a thin client laptop"},{"type":"text","page":29,"bbox":[65.22,158.93,384.04,225.19],"text":"d)\nUsing web conferencing instead of travelling to meetings\n\n\nQ77.\nWhich of the following is a description of a CIO?"},{"type":"text","page":29,"bbox":[84.12,250.91,521.63,264.19],"text":"a) The chief executive that governs the planning and execution of strategies in the area of"},{"type":"text","page":29,"bbox":[84.12,268.91,504.62,300.19],"text":"finances, such as fund-raising or financial reporting\nb) The chief executive that governs the planning and execution of strategies regarding"},{"type":"text","page":29,"bbox":[84.12,304.91,523.23,336.19],"text":"information management and information systems\nc) The chief executive that governs the planning and execution of technological strategies"},{"type":"text","page":29,"bbox":[84.12,340.91,530.01,372.19],"text":"and R&D plans of the company\nd) The chief executive that governs the planning of business strategies and the execution of"},{"type":"text","page":29,"bbox":[65.22,376.91,533.12,461.11],"text":"business\n\n\nQ78.\nWhich of the following is the appropriate description concerning creation and operation\nof a Business Continuity Plan (BCP)?"},{"type":"text","page":29,"bbox":[84.12,466.91,499.71,498.19],"text":"a) In addition to natural disasters, device failure in information systems and malware"},{"type":"text","page":29,"bbox":[84.12,502.91,488.05,534.19],"text":"infections are also included in the scope of examination.\nb) The planning contents are important matters related to the business strategy and"},{"type":"text","page":29,"bbox":[84.12,538.91,529.0,588.19],"text":"therefore, only senior managers are notified.\nc) The planning contents are restricted to those activities performed by the company.\nd) The recovery of business processes dependent on IT is prioritized according to technical"},{"type":"text","page":29,"bbox":[102.12,592.91,205.45,606.19],"text":"easiness of recovery."},{"type":"code","page":29,"bbox":[65.22,794.63,314.58,808.39],"text":"– 29 –"},{"type":"text","page":30,"bbox":[65.22,67.74,539.12,171.13],"text":"Q79.\nCompany A has two media plans.  One plan is for a series of 30-second radio\nadvertisements (ads) and the other is for 60-second TV ads.  Exposure is rated in points.\nThe company is considering an exposure of at least 60 points in the city and at most 40 points\noutside the city. The table below shows the cost and exposure of both TV and radio ads.\nWhich of the following is the set of expressions that can determine the number of media ads\nto minimize the total cost?"},{"type":"table","page":30,"bbox":[128.94,191.34,457.32,265.01],"rows":[["","Cost","In the city\nexposure (points)","Outside the city\nexposure (points)"],["TV ads","2000","8","6"],["Radio ads","800","10","3"]]},{"type":"text","page":30,"bbox":[134.4,195.41,351.55,226.69],"text":"Cost\nIn the city\nexposure (points)"},{"type":"text","page":30,"bbox":[364.08,195.41,450.79,226.69],"text":"Outside the city\nexposure (points)"},{"type":"text","page":30,"bbox":[134.4,231.89,413.95,245.17],"text":"TV ads\n2000\n8\n6"},{"type":"text","page":30,"bbox":[134.4,250.43,413.91,263.71],"text":"Radio ads\n800\n10\n3"},{"type":"text","page":30,"bbox":[84.12,286.91,412.62,300.19],"text":"a) Conditions  8x + 6y ≤ 60,   10x + 3y ≤ 40,    x ≥ 0,   y ≥ 0"},{"type":"text","page":30,"bbox":[84.12,304.82,412.62,336.19],"text":"Objective function 2000x + 800y  minimize\nb) Conditions  8x + 6y ≥ 60,   10x + 3y ≤ 40,    x ≥ 0,   y ≥ 0"},{"type":"text","page":30,"bbox":[84.12,340.82,412.62,372.19],"text":"Objective function 2000x + 800y  minimize\nc) Conditions  8x + 10y ≤ 60,   6x + 3y ≤ 40,    x ≥ 0,   y ≥ 0"},{"type":"text","page":30,"bbox":[84.12,376.82,412.62,408.19],"text":"Objective function 2000x + 800y  minimize\nd) Conditions  8x + 10y ≥ 60,   6x + 3y ≤ 40,    x ≥ 0,   y ≥ 0"},{"type":"text","page":30,"bbox":[102.12,412.82,326.24,426.19],"text":"Objective function 2000x + 800y  minimize"},{"type":"text","page":30,"bbox":[65.22,449.26,531.79,498.19],"text":"Q80.\nWhich of the following is an appropriate description of the scope of software protection\nunder WTO’s Agreement on Trade-Related Aspects of Intellectual Property Rights"},{"type":"text","page":30,"bbox":[83.28,502.91,132.31,516.19],"text":"(TRIPS)?"},{"type":"text","page":30,"bbox":[84.12,520.91,518.63,570.19],"text":"a) Algorithms and programming languages are protected.\nb) Application programs are protected but system programs such as an OS are not, as the"},{"type":"text","page":30,"bbox":[84.12,574.91,512.41,624.19],"text":"value of the right is included in the hardware cost.\nc) Both source programs and object programs are protected.\nd) Documents that describe algorithms are protected, but programs created by using the"},{"type":"text","page":30,"bbox":[65.22,628.91,195.4,660.19],"text":"algorithms are not."},{"type":"code","page":30,"bbox":[65.22,794.63,314.58,808.39],"text":"– 30 –"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"Algorithms and programming languages are protected."},{"label":"b","text":"Application programs are protected but system programs such as an OS are not, as the\n value of the right is included in the hardware cost."},{"label":"c","text":"Both source programs and object programs are protected."},{"label":"d","text":"Documents that describe algorithms are protected, but programs created by using the\n algorithms are not.\n\n – 30 –"}]'::jsonb,
  'b',
  '{"value":"b"}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-A, Q60)',
  ARRAY[23,24,25,26,27,28,29,30]::int[],
  'native_text',
  '3.0',
  'Q60. The director requested a system auditor to audit the operating status of an accounting
 system that was developed by the information systems department and is operated by the
 accounting department. Which of the following is the most appropriate description concerning
 the system auditor for this audit?

 a) The system auditor must be a certified public accountant because the accounting system
 must conform to the various standards of business accounting.
 b) The system auditor must be a person who belongs to neither the information systems
 department nor the accounting department to guarantee independence.
 c) The system auditor must report directly to the accounting department manager because
 the accounting system handles highly confidential information.
 d) The system auditor must report directly to the information systems department manager
 to perform system audits efficiently.

Q61. Which of the following is an appropriate feasibility evaluation when checking whether
 the lifetime benefits of the proposed information system is greater than its lifetime costs?

 a) Economic feasibility b) Operational feasibility
 c) Scheduling feasibility d) Technical feasibility

 – 23 –

Q62. In an evaluation of an IT investment, a preliminary evaluation, an interim evaluation,
 and a posteriori evaluation are conducted in accordance with the planning, execution, and
 completion of individual projects. Which of the following is a description of the preliminary
 evaluation?

 a) A variance between the plan and results as well as its cause are analyzed in detail, and it
 is determined whether a change is required in the investment amount or the effect goal.
 b) An effect goal is set on the basis of the investment purpose, and the information that is
 required to make a decision on whether it is possible to execute is provided to higherlevel management.
 c) Milestones when the investment effect should be attained and the data collection method
 that is required for the evaluation are planned in advance, and an evaluation is made at
 the times of those milestones.
 d) The achievement status of the effect goal that was set in advance is evaluated, and
 improvement measures for achieving the objective is considered when required.

Q63. Which of the following is a description of BPO?

 a) It refers to a company not having its own server and operating a system by renting a part
 of the processing capability or the storage capacity of a server that is owned by a
 communication service provider.
 b) It refers to a company not having its own software and using functions of software that
 an external specialized vendor provides via a network.
 c) It refers to the outsourcing of a whole business process of a specific department of the
 company, such as the administration department or the call center, together with the
 operation of a business system to an external specialized vendor.
 d) It refers to utilizing employees from a staffing company with lower personnel
 expenditures than those of the company to reduce the cost of software development.

Q64. In computerization investment, which of the following is a technique that is used to create
 categories on the basis of the similarities of risks and investment values and perform optimum
 resource allocation?

 a) 3C analysis b) Benchmarking
 c) Enterprise architecture d) IT portfolio

 – 24 –

Q65. Which of the following is an activity that is performed when non-functional requirements
 are defined?

 a) Clarifying the flows of information (i.e., data) between the functions that constitute
 business operations
 b) Creating technical requirements of development standard according to the programming
 language used in system development
 c) Defining the scope to be implemented as system functions
 d) Specifying the interface for exchanging information with other systems

Q66. Which of the following is a technique that is used to identify and evaluate the internal
 and external factors that are helpful or harmful to the objectives of business organizations or
 projects?

 a) Five forces analysis b) PPM analysis
 c) SWOT analysis d) Value chain analysis

Q67. The sales prices of products are decided according to different sales price setting methods.
 Which of the following approaches sets a high sales price by using the consumer psychology
 that high quality equals to high price?

 a) Cost plus pricing b) Differential pricing
 c) Marketing price following pricing d) Prestige pricing

 – 25 –

Q68. Company T sells three (3) products: A, B, and C. Currently, products A, B, and C have
 10,000, 20,000, and 80,000 purchasers every month, respectively. There is a plan to change
 the product line and sell four (4) new products, P, Q, R, and S, from next year. Accordingly, a
 trial calculation was made on the proportion of existing customers that will purchase the new
 products and the number of new customers. Which of the following is an appropriate
 conclusion from the trial calculation? Here, numerical values up to one (1) decimal point in
 each line of the table below represent the proportion of people who will change to the new
 product from the corresponding old product.

 Number of
 P Q R S
 people

 A 10,000 0.5 0.3 0.1 0.1

 B 20,000 0.1 0.6 0.1 0.1

 C 80,000 0.1 0.1 0.3 0.3

 Number of existing
 15,000 23,000 27,000 27,000
 customers

 Number of new
 5,000 7,000 13,000 23,000
 customers

 a) Among the purchasers of product A, 1,000 people are estimated to purchase the new
 product Q.
 b) Of the prospective purchasers of the new product P, 50% are estimated to be purchasers
 of product A.
 c) The number of new customers of the new product S are estimated to be fewer than the
 number of people who will purchase the new product S among the purchasers of product
 C.
 d) The purchasers of product B are estimated to purchase any one (1) of the new products
 P, Q, R, and S.

Q69. Which of the following is the appropriate explanation for product innovation in the
 management of technology?

 a) Acquiring business profits through achievements of the development of technology
 b) Developing new products or products that enable differentiation from other companies
 c) Making innovative reforms in business processes
 d) Strategically managing business with technology as the core

 – 26 –

Q70. Among the different business systems supported by technology, which of the following
 analyzes routes of distribution, tracking and load tendency?

 a) LMS b) OMS c) TMS d) WMS

Q71. Which of the following is a product that can take advantage of the cell production
 system?

 a) A product that needs to be produced in large quantities to improve productivity
 b) A product that requires a division of labor on the basis of standardization, simplification,
 and specialization
 c) A product that requires a variety of types and needs flexible production
 d) A product whose specifications do not change over a long period of time

Q72. Which of the following performs its processing according to steps (1) through (3)?

 (1) Based on the types, quantities, and the parts list of the product planned to be
 manufactured during a fixed period of time in the future, the required quantity of
 components is calculated.
 (2) The net order quantity of each component is calculated from the amount of inventory
 that can be allocated.
 (3) The ordering time of the components is determined while considering the
 manufacturing and procurement lead time.

 a) CAD (Computer Aided Design) b) CRP (Capacity Requirements Planning)
 c) JIT (Just In Time) d) MRP (Material Requirements Planning)

 – 27 –

Q73. Which of the following is an appropriate description of Initial Coin Offering (ICO)?

 a) A crowd-funding method in which backers contribute money toward an idea or a startup
 and get rewards like physical products
 b) A fundraising method that is mainly used by a financially stable company which wants
 to expand and develop to the public
 c) A popular fundraising method that is used primarily by a startup, normally through
 utilizing cryptocurrency
 d) A process of offering shares of a private corporation to the public in a new stock
 issuance

Q74. Which of the following is an appropriate example of utilizing machine learning at a
 production site?

 a) Instead of programming the working method for the production robot in the factory, the
 robot itself learns, thus improving the efficiency of work.
 b) The causes for the occurrence of defects in a factory are decomposed and arranged in a
 tree shape so that analysts can statistically look for the cause and solution.
 c) The production equipment in a factory is connected through high-speed communication
 so that the host computer can be controlled in real time.
 d) The productivity of employees in the factory improves each time the cumulative
 production volume doubles, and the unit cost reduces at a fixed percentage.

Q75. Which of the following is a management organization that creates a cross-functional team
 between project and functional organizations to flexibly respond to changes in the business
 environment?

 a) Divisional organization b) Line and staff organization
 c) Matrix organization d) Project organization

 – 28 –

Q76. Which of the following is an example of Green IT?

 a) Development of a powerful in-house data center
 b) Development of efficient in-house software
 c) Using a desktop PC instead of a thin client laptop
 d) Using web conferencing instead of travelling to meetings

Q77. Which of the following is a description of a CIO?

 a) The chief executive that governs the planning and execution of strategies in the area of
 finances, such as fund-raising or financial reporting
 b) The chief executive that governs the planning and execution of strategies regarding
 information management and information systems
 c) The chief executive that governs the planning and execution of technological strategies
 and R&D plans of the company
 d) The chief executive that governs the planning of business strategies and the execution of
 business

Q78. Which of the following is the appropriate description concerning creation and operation
 of a Business Continuity Plan (BCP)?

 a) In addition to natural disasters, device failure in information systems and malware
 infections are also included in the scope of examination.
 b) The planning contents are important matters related to the business strategy and
 therefore, only senior managers are notified.
 c) The planning contents are restricted to those activities performed by the company.
 d) The recovery of business processes dependent on IT is prioritized according to technical
 easiness of recovery.

 – 29 –

Q79. Company A has two media plans. One plan is for a series of 30-second radio
 advertisements (ads) and the other is for 60-second TV ads. Exposure is rated in points.
 The company is considering an exposure of at least 60 points in the city and at most 40 points
 outside the city. The table below shows the cost and exposure of both TV and radio ads.
 Which of the following is the set of expressions that can determine the number of media ads
 to minimize the total cost?

 Cost In the city Outside the city
 exposure (points) exposure (points)
 TV ads 2000 8 6
 Radio ads 800 10 3

 a) Conditions 8x + 6y ≤ 60, 10x + 3y ≤ 40, x ≥ 0, y ≥ 0
 Objective function 2000x + 800y  minimize
 b) Conditions 8x + 6y ≥ 60, 10x + 3y ≤ 40, x ≥ 0, y ≥ 0
 Objective function 2000x + 800y  minimize
 c) Conditions 8x + 10y ≤ 60, 6x + 3y ≤ 40, x ≥ 0, y ≥ 0
 Objective function 2000x + 800y  minimize
 d) Conditions 8x + 10y ≥ 60, 6x + 3y ≤ 40, x ≥ 0, y ≥ 0
 Objective function 2000x + 800y  minimize

Q80. Which of the following is an appropriate description of the scope of software protection
 under WTO’s Agreement on Trade-Related Aspects of Intellectual Property Rights
 (TRIPS)?

 a) Algorithms and programming languages are protected.
 b) Application programs are protected but system programs such as an OS are not, as the
 value of the right is included in the hardware cost.
 c) Both source programs and object programs are protected.
 d) Documents that describe algorithms are protected, but programs created by using the
 algorithms are not.

 – 30 –',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/a/questions.pdf","pages":[23,24,25,26,27,28,29,30]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/a/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'B',
  1,
  'Q1. Read the following description of public key cryptography, and then answer Subquestions
 1 and 2.

Public key cryptography is a widely used method to secure e-mail communications. It makes
 use of a pair of keys to encrypt and sign the e-mail messages. The same pair of keys can
 then be used in reverse to decrypt and verify the e-mail messages. Public key cryptography
 uses two keys: a private key that is kept secure, and a public key that can be published
 publicly. Figure 1 shows a typical application of public key cryptography, message
 encryption and digital signature.

[Message encryption]

Decrypt using Encrypt using
 Alice’s private key Alice’s public key

Plain text message Encrypted message Plain text message

Alice A third party
 (receiver) (sender)
 The Internet

[Digital signature]

Sign using Verify using
 Alice’s private key Alice’s public key

Plain text message Signed message Plain text message

Alice A third party
 (sender) (receiver)
 The Internet

Figure 1 Typical application of public key cryptography

In the scenario shown in Figure 1, Alice has published her public key along with her e-mail
 address on the Internet. When a third party wishes to communicate with Alice, it can use
 Alice’s public key to encrypt an e-mail message and send it to Alice who can then use her
 private key to decrypt the message and obtain the original message. Conversely, Alice can
 use her private key to sign a message before sending it to a third party. The third party can
 then use Alice’s public key to verify the signed message and confirm the authenticity of the
 original message.

- 3 -

The signing process ensures integrity rather than confidentiality because Alice’s public key
is publicly available allowing anyone who can access Alice’s public key to verify the signed
message.

Figure 2 shows the communication flow between Alice, Bob and Charlie using public key
cryptography.
(1) Alice sends a product catalogue to Bob and Charlie. The information on the catalogue
 is not confidential; thus the e-mail messages are not encrypted. However, the messages
 are signed to ensure integrity and non-repudiation of the information on the catalogue.
(2) After receiving the catalogue, Bob wishes to make a purchase; hence, he sends a reply
 message to Alice. As the message includes sensitive financial information, the message
 is encrypted to make sure that only Alice can read the message. The message is also
 signed to allow Alice to confirm that the purchase is actually made by Bob.

(1) Alice sends a catalogue to Bob and Charlie

Verify using
 Sign using

Signed message Catalogue

Bob
 Catalogue

Alice Sign using
 Signed message Verify using Catalogue
 A
 B
 Charlie

(2) Bob Sends a reply message to Alice Bob

Order
 information

Encrypted
 Signed Encrypt using message
 encrypted message C

Encrypted Sign using
 message

Encrypted
 Verify using
 Alice message
 D
 Order
 Decrypt using information

Note: Shaded parts are not shown

Figure 2 Communication flow using public key cryptography

- 4 -

Subquestion 1
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Figure 2. If needed, the same answer can be selected more than once.

Answer group for A through D
 a) Alice’s private key b) Alice’s public key
 c) Bob’s private key d) Bob’s public key
 e) Charlie’s private key f) Charlie’s public key

Subquestion 2
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the following description.

In addition to the use of the correct keys for the intended functions, the order of processing
 is important. Some e-mail programs allow users to choose whether to encrypt the message
 first and then sign the encrypted message later or the other way around. Figure 3 shows the
 encrypt-then-sign method and sign-then-encrypt method.

[Encrypt‐then‐sign method]
 Signed
 encrypted message

Plain text Encrypted Encrypted
 message message message

[Sign‐then‐encrypt method]
 Encrypted signed
 message

Plain text Signed Signed
 message message message

Figure 3 Encrypt-then-sign method and sign-then-encrypt method

The order of the signing and encryption processes in each method provides a unique benefit
 over the other method. For instance, it is possible to ***E*** by encrypting the message
 first and then signing the message later. Conversely, if the original message is signed first,
 it can help to ***F***. Thus, it is important for users to choose the appropriate method
 accordingly.

- 5 -',
  '[{"type":"prompt","text":"Q1. Read the following description of public key cryptography, and then answer Subquestions\n 1 and 2."},{"type":"context","text":"Public key cryptography is a widely used method to secure e-mail communications. It makes\n use of a pair of keys to encrypt and sign the e-mail messages. The same pair of keys can\n then be used in reverse to decrypt and verify the e-mail messages. Public key cryptography\n uses two keys: a private key that is kept secure, and a public key that can be published\n publicly. Figure 1 shows a typical application of public key cryptography, message\n encryption and digital signature.\n\n[Message encryption]\n\nDecrypt using Encrypt using\n Alice’s private key Alice’s public key\n\nPlain text message Encrypted message Plain text message\n\nAlice A third party\n (receiver) (sender)\n The Internet\n\n[Digital signature]\n\nSign using Verify using\n Alice’s private key Alice’s public key\n\nPlain text message Signed message Plain text message\n\nAlice A third party\n (sender) (receiver)\n The Internet\n\nFigure 1 Typical application of public key cryptography\n\nIn the scenario shown in Figure 1, Alice has published her public key along with her e-mail\n address on the Internet. When a third party wishes to communicate with Alice, it can use\n Alice’s public key to encrypt an e-mail message and send it to Alice who can then use her\n private key to decrypt the message and obtain the original message. Conversely, Alice can\n use her private key to sign a message before sending it to a third party. The third party can\n then use Alice’s public key to verify the signed message and confirm the authenticity of the\n original message.\n\n- 3 -\n\nThe signing process ensures integrity rather than confidentiality because Alice’s public key\nis publicly available allowing anyone who can access Alice’s public key to verify the signed\nmessage.\n\nFigure 2 shows the communication flow between Alice, Bob and Charlie using public key\ncryptography.\n(1) Alice sends a product catalogue to Bob and Charlie. The information on the catalogue\n is not confidential; thus the e-mail messages are not encrypted. However, the messages\n are signed to ensure integrity and non-repudiation of the information on the catalogue.\n(2) After receiving the catalogue, Bob wishes to make a purchase; hence, he sends a reply\n message to Alice. As the message includes sensitive financial information, the message\n is encrypted to make sure that only Alice can read the message. The message is also\n signed to allow Alice to confirm that the purchase is actually made by Bob.\n\n(1) Alice sends a catalogue to Bob and Charlie\n\nVerify using\n Sign using\n\nSigned message Catalogue\n\nBob\n Catalogue\n\nAlice Sign using\n Signed message Verify using Catalogue\n A\n B\n Charlie\n\n(2) Bob Sends a reply message to Alice Bob\n\nOrder\n information\n\nEncrypted\n Signed Encrypt using message\n encrypted message C\n\nEncrypted Sign using\n message\n\nEncrypted\n Verify using\n Alice message\n D\n Order\n Decrypt using information\n\nNote: Shaded parts are not shown\n\nFigure 2 Communication flow using public key cryptography\n\n- 4 -\n\nSubquestion 1\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in Figure 2. If needed, the same answer can be selected more than once.\n\nAnswer group for A through D\n a) Alice’s private key b) Alice’s public key\n c) Bob’s private key d) Bob’s public key\n e) Charlie’s private key f) Charlie’s public key\n\nSubquestion 2\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in the following description.\n\nIn addition to the use of the correct keys for the intended functions, the order of processing\n is important. Some e-mail programs allow users to choose whether to encrypt the message\n first and then sign the encrypted message later or the other way around. Figure 3 shows the\n encrypt-then-sign method and sign-then-encrypt method.\n\n[Encrypt‐then‐sign method]\n Signed\n encrypted message\n\nPlain text Encrypted Encrypted\n message message message\n\n[Sign‐then‐encrypt method]\n Encrypted signed\n message\n\nPlain text Signed Signed\n message message message\n\nFigure 3 Encrypt-then-sign method and sign-then-encrypt method\n\nThe order of the signing and encryption processes in each method provides a unique benefit\n over the other method. For instance, it is possible to ***E*** by encrypting the message\n first and then signing the message later. Conversely, if the original message is signed first,\n it can help to ***F***. Thus, it is important for users to choose the appropriate method\n accordingly.\n\n- 5 -"}]'::jsonb,
  '["2021-october-b-q01-figure1.webp","2021-october-b-q01-figure2.webp","2021-october-b-q01-figure3.webp"]'::jsonb,
  '[{"label":"a","text":"detect and discard unauthenticated message earlier"},{"label":"b","text":"ensure that the private key can be recovered if the original key is lost"},{"label":"c","text":"hide the signatory of the private key from unintended parties"},{"label":"d","text":"increase the encryption strength"},{"label":"e","text":"significantly reduce the time required to sign the message\n\n - 6 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "a"}, {"subquestion": 1, "blank": "B", "answer": "b"}, {"subquestion": 1, "blank": "C", "answer": "b"}, {"subquestion": 1, "blank": "D", "answer": "d"}, {"subquestion": 2, "blank": "E", "answer": "a"}, {"subquestion": 2, "blank": "F", "answer": "c"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"a"},{"subquestion":1,"blank":"B","answer":"b"},{"subquestion":1,"blank":"C","answer":"b"},{"subquestion":1,"blank":"D","answer":"d"},{"subquestion":2,"blank":"E","answer":"a"},{"subquestion":2,"blank":"F","answer":"c"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-B, Q1)',
  ARRAY[3,4,5,6]::int[],
  'native_text',
  '3.0',
  'Q1. Read the following description of public key cryptography, and then answer Subquestions
 1 and 2.

 Public key cryptography is a widely used method to secure e-mail communications. It makes
 use of a pair of keys to encrypt and sign the e-mail messages. The same pair of keys can
 then be used in reverse to decrypt and verify the e-mail messages. Public key cryptography
 uses two keys: a private key that is kept secure, and a public key that can be published
 publicly. Figure 1 shows a typical application of public key cryptography, message
 encryption and digital signature.

 [Message encryption]

 Decrypt using Encrypt using
 Alice’s private key Alice’s public key

 Plain text message Encrypted message Plain text message

 Alice A third party
 (receiver) (sender)
 The Internet

 [Digital signature]

 Sign using Verify using
 Alice’s private key Alice’s public key

 Plain text message Signed message Plain text message

 Alice A third party
 (sender) (receiver)
 The Internet

 Figure 1 Typical application of public key cryptography

 In the scenario shown in Figure 1, Alice has published her public key along with her e-mail
 address on the Internet. When a third party wishes to communicate with Alice, it can use
 Alice’s public key to encrypt an e-mail message and send it to Alice who can then use her
 private key to decrypt the message and obtain the original message. Conversely, Alice can
 use her private key to sign a message before sending it to a third party. The third party can
 then use Alice’s public key to verify the signed message and confirm the authenticity of the
 original message.

 - 3 -

The signing process ensures integrity rather than confidentiality because Alice’s public key
is publicly available allowing anyone who can access Alice’s public key to verify the signed
message.

Figure 2 shows the communication flow between Alice, Bob and Charlie using public key
cryptography.
(1) Alice sends a product catalogue to Bob and Charlie. The information on the catalogue
 is not confidential; thus the e-mail messages are not encrypted. However, the messages
 are signed to ensure integrity and non-repudiation of the information on the catalogue.
(2) After receiving the catalogue, Bob wishes to make a purchase; hence, he sends a reply
 message to Alice. As the message includes sensitive financial information, the message
 is encrypted to make sure that only Alice can read the message. The message is also
 signed to allow Alice to confirm that the purchase is actually made by Bob.

(1) Alice sends a catalogue to Bob and Charlie

 Verify using
 Sign using

 Signed message Catalogue

 Bob
 Catalogue

 Alice Sign using
 Signed message Verify using Catalogue
 A
 B
 Charlie

(2) Bob Sends a reply message to Alice Bob

 Order
 information

 Encrypted
 Signed Encrypt using message
 encrypted message C

 Encrypted Sign using
 message

 Encrypted
 Verify using
 Alice message
 D
 Order
 Decrypt using information

 Note: Shaded parts are not shown

 Figure 2 Communication flow using public key cryptography

 - 4 -

Subquestion 1
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Figure 2. If needed, the same answer can be selected more than once.

 Answer group for A through D
 a) Alice’s private key b) Alice’s public key
 c) Bob’s private key d) Bob’s public key
 e) Charlie’s private key f) Charlie’s public key

Subquestion 2
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the following description.

 In addition to the use of the correct keys for the intended functions, the order of processing
 is important. Some e-mail programs allow users to choose whether to encrypt the message
 first and then sign the encrypted message later or the other way around. Figure 3 shows the
 encrypt-then-sign method and sign-then-encrypt method.

 [Encrypt‐then‐sign method]
 Signed
 encrypted message

 Plain text Encrypted Encrypted
 message message message

 [Sign‐then‐encrypt method]
 Encrypted signed
 message

 Plain text Signed Signed
 message message message

 Figure 3 Encrypt-then-sign method and sign-then-encrypt method

 The order of the signing and encryption processes in each method provides a unique benefit
 over the other method. For instance, it is possible to ___E___ by encrypting the message
 first and then signing the message later. Conversely, if the original message is signed first,
 it can help to ___F___. Thus, it is important for users to choose the appropriate method
 accordingly.

 - 5 -

Answer group for E and F
 a) detect and discard unauthenticated message earlier
 b) ensure that the private key can be recovered if the original key is lost
 c) hide the signatory of the private key from unintended parties
 d) increase the encryption strength
 e) significantly reduce the time required to sign the message

 - 6 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/b/questions.pdf","pages":[3,4,5,6]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'B',
  2,
  'Q2. Read the following description of the Gray code, and then answer Subquestions 1 through
 3.
 In this question, the symbols “ • ”, “ + ”, “  ”, and “ ¯ ” indicate the logical operators AND,
 OR, exclusive OR, and NOT respectively.

The Gray code is a code in which the Hamming distance between any two adjacent codes is
 1. The Hamming distance is the number of positions at which the corresponding bits differ
 when comparing binary numbers with the same number of bits. For example, the Hamming
 distance between two binary codes 1001 and 1010 is ***A***. According to Table 1, two
 adjacent binary codes, whose decimal values are ***B***, have the largest Hamming
 distance, and the value is ***C***.
 For decimal values 0, 1, 2, and 3, the binary codes are 0000, 0001, 0010, and 0011, and the
 Gray codes are 0000, 0001, 0011, and 0010 respectively as shown in Table 1.

Table 1 Table of 4-bit binary code and 4-bit Gray code
 Decimal value Binary code Gray code
 0 0000 0000
 1 0001 0001
 2 0010 0011
 3 0011 0010
 4 0100 0110
 5 0101 0111
 6 0110 0101
 7 0111 0100
 8 1000 1100
 9 1001 1101
 10 1010 1111
 11 1011 1110
 12 1100 1010
 13 1101 1011
 14 1110 1001
 15 1111 1000

- 7 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above description.

Answer group for A and C
 a) 1 b) 2 c) 3 d) 4

Answer group for B
 a) 1 and 2 b) 3 and 4 c) 5 and 6
 d) 7 and 8 e) 9 and 10 f) 11 and 12

- 8 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following description.

Consider the logical formulas that convert binary codes to equivalent Gray codes.
 Table 2 shows the truth table for the binary code to the Gray code conversion. The inputs
 are the 4-bit binary codes (bits are named B1, B2, B3, and B4), and the outputs are the 4-bit
 Gray codes (bits are named G1, G2, G3, and G4).

Table 2 Truth table for binary code to Gray code conversion
 Inputs Outputs
 B1 B2 B3 B4 G1 G2 G3 G4
 0 0 0 0 0 0 0 0
 0 0 0 1 0 0 0 1
 0 0 1 0 0 0 1 1
 0 0 1 1 0 0 1 0
 0 1 0 0 0 1 1 0
 0 1 0 1 0 1 1 1
 0 1 1 0 0 1 0 1
 0 1 1 1 0 1 0 0
 1 0 0 0 1 1 0 0
 1 0 0 1 1 1 0 1
 1 0 1 0 1 1 1 1
 1 0 1 1 1 1 1 0
 1 1 0 0 1 0 1 0
 1 1 0 1 1 0 1 1
 1 1 1 0 1 0 0 1
 1 1 1 1 1 0 0 0

The logical formulas that output G1, G2, G3, and G4 are expressed as follows:
 G1 = B1
 G2 = B1  B2
 G3 = B2  B3
 G4 = ***D***

Answer group for D
 a) B0  (B3 + B4) b) B0  (B3  B4)
 c) B3 + B4 d) B3  B4

- 9 -

Subquestion 3
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following description.

Consider the logical formulas that convert Gray codes to equivalent binary codes.
 Table 3 shows the truth table for the Gray code to the binary code conversion. The inputs
 are the 4-bit Gray codes (bits are named G1, G2, G3, and G4), and the outputs are the 4-bit
 binary codes (bits are named B1, B2, B3, and B4).

Table 3 Truth table for Gray code to binary code conversion
 Inputs Outputs
 G1 G2 G3 G4 B1 B2 B3 B4
 0 0 0 0 0 0 0 0
 0 0 0 1 0 0 0 1
 0 0 1 0 0 0 1 1
 0 0 1 1 0 0 1 0
 0 1 0 0 0 1 1 1
 0 1 0 1 0 1 1 0
 0 1 1 0 0 1 0 0
 0 1 1 1 0 1 0 1
 1 0 0 0 1 1 1 1
 1 0 0 1 1 1 1 0
 1 0 1 0 1 1 0 0
 1 0 1 1 1 1 0 1
 1 1 0 0 1 0 0 0
 1 1 0 1 1 0 0 1
 1 1 1 0 1 0 1 1
 1 1 1 1 1 0 1 0

The logical formulas that output B1, B2, and B3 (B4 is omitted) are expressed as follows:
 B1 = G1 B2 = G1•G2 + G1•G2 = G1  G2
 B2 = G1•G2 + G1•G2 = G1  G2 B3 = G1•G2•G3 + G1•G2•G3 + G1•G2•G3 + G1•G2•G3
 B3 = G1•G2•G3 + G1•G2•G3 + G1•G2•G3 + G1•G2•G3 = E',
  '[{"type":"prompt","text":"Q2. Read the following description of the Gray code, and then answer Subquestions 1 through\n 3.\n In this question, the symbols “ • ”, “ + ”, “  ”, and “ ¯ ” indicate the logical operators AND,\n OR, exclusive OR, and NOT respectively."},{"type":"context","text":"The Gray code is a code in which the Hamming distance between any two adjacent codes is\n 1. The Hamming distance is the number of positions at which the corresponding bits differ\n when comparing binary numbers with the same number of bits. For example, the Hamming\n distance between two binary codes 1001 and 1010 is ***A***. According to Table 1, two\n adjacent binary codes, whose decimal values are ***B***, have the largest Hamming\n distance, and the value is ***C***.\n For decimal values 0, 1, 2, and 3, the binary codes are 0000, 0001, 0010, and 0011, and the\n Gray codes are 0000, 0001, 0011, and 0010 respectively as shown in Table 1.\n\nTable 1 Table of 4-bit binary code and 4-bit Gray code\n Decimal value Binary code Gray code\n 0 0000 0000\n 1 0001 0001\n 2 0010 0011\n 3 0011 0010\n 4 0100 0110\n 5 0101 0111\n 6 0110 0101\n 7 0111 0100\n 8 1000 1100\n 9 1001 1101\n 10 1010 1111\n 11 1011 1110\n 12 1100 1010\n 13 1101 1011\n 14 1110 1001\n 15 1111 1000\n\n- 7 -\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the above description.\n\nAnswer group for A and C\n a) 1 b) 2 c) 3 d) 4\n\nAnswer group for B\n a) 1 and 2 b) 3 and 4 c) 5 and 6\n d) 7 and 8 e) 9 and 10 f) 11 and 12\n\n- 8 -\n\nSubquestion 2\n From the answer group below, select the correct answer to be inserted in the blank _______\n in the following description.\n\nConsider the logical formulas that convert binary codes to equivalent Gray codes.\n Table 2 shows the truth table for the binary code to the Gray code conversion. The inputs\n are the 4-bit binary codes (bits are named B1, B2, B3, and B4), and the outputs are the 4-bit\n Gray codes (bits are named G1, G2, G3, and G4).\n\nTable 2 Truth table for binary code to Gray code conversion\n Inputs Outputs\n B1 B2 B3 B4 G1 G2 G3 G4\n 0 0 0 0 0 0 0 0\n 0 0 0 1 0 0 0 1\n 0 0 1 0 0 0 1 1\n 0 0 1 1 0 0 1 0\n 0 1 0 0 0 1 1 0\n 0 1 0 1 0 1 1 1\n 0 1 1 0 0 1 0 1\n 0 1 1 1 0 1 0 0\n 1 0 0 0 1 1 0 0\n 1 0 0 1 1 1 0 1\n 1 0 1 0 1 1 1 1\n 1 0 1 1 1 1 1 0\n 1 1 0 0 1 0 1 0\n 1 1 0 1 1 0 1 1\n 1 1 1 0 1 0 0 1\n 1 1 1 1 1 0 0 0\n\nThe logical formulas that output G1, G2, G3, and G4 are expressed as follows:\n G1 = B1\n G2 = B1  B2\n G3 = B2  B3\n G4 = ***D***\n\nAnswer group for D\n a) B0  (B3 + B4) b) B0  (B3  B4)\n c) B3 + B4 d) B3  B4\n\n- 9 -\n\nSubquestion 3\n From the answer group below, select the correct answer to be inserted in the blank _______\n in the following description.\n\nConsider the logical formulas that convert Gray codes to equivalent binary codes.\n Table 3 shows the truth table for the Gray code to the binary code conversion. The inputs\n are the 4-bit Gray codes (bits are named G1, G2, G3, and G4), and the outputs are the 4-bit\n binary codes (bits are named B1, B2, B3, and B4).\n\nTable 3 Truth table for Gray code to binary code conversion\n Inputs Outputs\n G1 G2 G3 G4 B1 B2 B3 B4\n 0 0 0 0 0 0 0 0\n 0 0 0 1 0 0 0 1\n 0 0 1 0 0 0 1 1\n 0 0 1 1 0 0 1 0\n 0 1 0 0 0 1 1 1\n 0 1 0 1 0 1 1 0\n 0 1 1 0 0 1 0 0\n 0 1 1 1 0 1 0 1\n 1 0 0 0 1 1 1 1\n 1 0 0 1 1 1 1 0\n 1 0 1 0 1 1 0 0\n 1 0 1 1 1 1 0 1\n 1 1 0 0 1 0 0 0\n 1 1 0 1 1 0 0 1\n 1 1 1 0 1 0 1 1\n 1 1 1 1 1 0 1 0\n\nThe logical formulas that output B1, B2, and B3 (B4 is omitted) are expressed as follows:\n B1 = G1 B2 = G1•G2 + G1•G2 = G1  G2\n B2 = G1•G2 + G1•G2 = G1  G2 B3 = G1•G2•G3 + G1•G2•G3 + G1•G2•G3 + G1•G2•G3\n B3 = G1•G2•G3 + G1•G2•G3 + G1•G2•G3 + G1•G2•G3 = E"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"(G1+G2)•G3 + (G1+G2)•G3 + G1•G2•G3"},{"label":"b","text":"(G1+G2)•G3 + (G1+G2)•G3 + G1•G2•G3"},{"label":"c","text":"(G1  G2) • G3"},{"label":"d","text":"(G1  G2) + G3"},{"label":"e","text":"G1  G2  G3\n\n - 10 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "b"}, {"subquestion": 1, "blank": "B", "answer": "d"}, {"subquestion": 1, "blank": "C", "answer": "d"}, {"subquestion": 2, "blank": "D", "answer": "d"}, {"subquestion": 3, "blank": "E", "answer": "e"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"b"},{"subquestion":1,"blank":"B","answer":"d"},{"subquestion":1,"blank":"C","answer":"d"},{"subquestion":2,"blank":"D","answer":"d"},{"subquestion":3,"blank":"E","answer":"e"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-B, Q2)',
  ARRAY[7,8,9,10]::int[],
  'native_text',
  '3.0',
  'Q2. Read the following description of the Gray code, and then answer Subquestions 1 through
 3.
 In this question, the symbols “ • ”, “ + ”, “  ”, and “ ¯ ” indicate the logical operators AND,
 OR, exclusive OR, and NOT respectively.

 The Gray code is a code in which the Hamming distance between any two adjacent codes is
 1. The Hamming distance is the number of positions at which the corresponding bits differ
 when comparing binary numbers with the same number of bits. For example, the Hamming
 distance between two binary codes 1001 and 1010 is ___A___. According to Table 1, two
 adjacent binary codes, whose decimal values are ___B___, have the largest Hamming
 distance, and the value is ___C___.
 For decimal values 0, 1, 2, and 3, the binary codes are 0000, 0001, 0010, and 0011, and the
 Gray codes are 0000, 0001, 0011, and 0010 respectively as shown in Table 1.

 Table 1 Table of 4-bit binary code and 4-bit Gray code
 Decimal value Binary code Gray code
 0 0000 0000
 1 0001 0001
 2 0010 0011
 3 0011 0010
 4 0100 0110
 5 0101 0111
 6 0110 0101
 7 0111 0100
 8 1000 1100
 9 1001 1101
 10 1010 1111
 11 1011 1110
 12 1100 1010
 13 1101 1011
 14 1110 1001
 15 1111 1000

 - 7 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above description.

 Answer group for A and C
 a) 1 b) 2 c) 3 d) 4

 Answer group for B
 a) 1 and 2 b) 3 and 4 c) 5 and 6
 d) 7 and 8 e) 9 and 10 f) 11 and 12

 - 8 -

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following description.

 Consider the logical formulas that convert binary codes to equivalent Gray codes.
 Table 2 shows the truth table for the binary code to the Gray code conversion. The inputs
 are the 4-bit binary codes (bits are named B1, B2, B3, and B4), and the outputs are the 4-bit
 Gray codes (bits are named G1, G2, G3, and G4).

 Table 2 Truth table for binary code to Gray code conversion
 Inputs Outputs
 B1 B2 B3 B4 G1 G2 G3 G4
 0 0 0 0 0 0 0 0
 0 0 0 1 0 0 0 1
 0 0 1 0 0 0 1 1
 0 0 1 1 0 0 1 0
 0 1 0 0 0 1 1 0
 0 1 0 1 0 1 1 1
 0 1 1 0 0 1 0 1
 0 1 1 1 0 1 0 0
 1 0 0 0 1 1 0 0
 1 0 0 1 1 1 0 1
 1 0 1 0 1 1 1 1
 1 0 1 1 1 1 1 0
 1 1 0 0 1 0 1 0
 1 1 0 1 1 0 1 1
 1 1 1 0 1 0 0 1
 1 1 1 1 1 0 0 0

 The logical formulas that output G1, G2, G3, and G4 are expressed as follows:
 G1 = B1
 G2 = B1  B2
 G3 = B2  B3
 G4 = ___D___

 Answer group for D
 a) B0  (B3 + B4) b) B0  (B3  B4)
 c) B3 + B4 d) B3  B4

 - 9 -

Subquestion 3
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following description.

 Consider the logical formulas that convert Gray codes to equivalent binary codes.
 Table 3 shows the truth table for the Gray code to the binary code conversion. The inputs
 are the 4-bit Gray codes (bits are named G1, G2, G3, and G4), and the outputs are the 4-bit
 binary codes (bits are named B1, B2, B3, and B4).

 Table 3 Truth table for Gray code to binary code conversion
 Inputs Outputs
 G1 G2 G3 G4 B1 B2 B3 B4
 0 0 0 0 0 0 0 0
 0 0 0 1 0 0 0 1
 0 0 1 0 0 0 1 1
 0 0 1 1 0 0 1 0
 0 1 0 0 0 1 1 1
 0 1 0 1 0 1 1 0
 0 1 1 0 0 1 0 0
 0 1 1 1 0 1 0 1
 1 0 0 0 1 1 1 1
 1 0 0 1 1 1 1 0
 1 0 1 0 1 1 0 0
 1 0 1 1 1 1 0 1
 1 1 0 0 1 0 0 0
 1 1 0 1 1 0 0 1
 1 1 1 0 1 0 1 1
 1 1 1 1 1 0 1 0

 The logical formulas that output B1, B2, and B3 (B4 is omitted) are expressed as follows:
 B1 = G1 B2 = G1•G2 + G1•G2 = G1  G2
 B2 = G1•G2 + G1•G2 = G1  G2 B3 = G1•G2•G3 + G1•G2•G3 + G1•G2•G3 + G1•G2•G3
 B3 = G1•G2•G3 + G1•G2•G3 + G1•G2•G3 + G1•G2•G3 = E

 Answer group for E
 a) (G1+G2)•G3 + (G1+G2)•G3 + G1•G2•G3
 a) (G1+G2)•G3 + (G1+G2)•G3 + G1•G2•G3
 a) (G1+G2)•G3 + (G1+G2)•G3 + G1•G2•G3
 b) (G1+G2)•G3 + (G1+G2)•G3 + G1•G2•G3
 c) (G1  G2) • G3
 d) (G1  G2) + G3
 e) G1  G2  G3

 - 10 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/b/questions.pdf","pages":[7,8,9,10]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'B',
  3,
  'Q3. Read the following description of a database for a DVD rental shop, and then answer
 Subquestions 1 through 3.

Store U, a DVD rental shop, uses a relational database to manage lending and returning
 operations at the store.

Disk table
 DiskID FilmName DirectorName YearOfProduction DateEntered
 D0280 Alice in AI wonderland A. I. Carroll 2019 2019-10-25
 D0480 Super IT man Clark Kent Jr. 2020 2021-02-26
 D0860 Hello database world! I. T. Pec 2021 2021-10-10
 Disk table contains information about each DVD, including the disk ID, film name,
 director name, year of production, and date entered in the store.

Customer table
 CustomerID CustomerName Address Phone
 C001 John 401 North street, East city 1234567
 C003 Kathy 44 South street, East city 2345678
 C005 Tom 109 Central street, West city 3456789
 Customer table contains information about each customer, including the customer ID,
 customer name, address, and phone number.

Bill table
 BillID CustomerID RentDateTime RentalCharge ReturnDateTime Penalty
 B1680 C005 2021-10-16 18:30 1.00 2021-10-18 17:50 NULL
 B2120 C003 2021-10-21 12:10 2.00 NULL NULL
 B2180 C005 2021-10-21 18:40 1.00 NULL NULL
 Bill table contains information about the bills for each customer, including the bill ID,
 customer ID, rented date and time, returned date and time, rental charge, and penalty.

BillDetail table
 BillDetailID BillID DiskID
 B1680-1 B1680 D0280
 B2120-1 B2120 D0860
 B2120-2 B2120 D0280
 B2180-1 B2180 D0480
 BillDetail table contains the details of a bill, including the bill ID and disk ID.

- 11 -

When a customer rents DVDs, a bill record is created. Rental charge is $1.00 per DVD. At
 that time, NULL is set to the columns ReturnDateTime and Penalty.
 When the customer returns the rented DVDs, the value of ReturnDateTime is set. The value
 of Penalty is set only if the customer misses a deadline and he/she needs to pay a penalty.
 The deadline is 72 hours from the rented date and time. The penalty is $1.00 per day (24
 hours) per DVD.

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following SQL statement SQL1.

The following SQL statement SQL1 outputs the customers who currently (at the time SQL1
 is executed) miss the deadline with the number of DVDs they still have with them.

-- SQL1 --
 SELECT C.CustomerID, CustomerName, COUNT(*) AS DiskCount
 FROM Customer C, Bill B, BillDetail D
 WHERE C.CustomerID = B.CustomerID
 AND B.BillID = D.BillID
 AND ***A***
 AND ***B***
 GROUP BY C.CustomerID, CustomerName

From the sample data shown in the table definitions, SQL1 outputs the following result. It
 is assumed that SQL1 is executed at 13:30 on 2021-10-24.

CustomerID CustomerName DiskCount
 C003 Kathy 2

Note:
 - The GETDATE() function returns the current date and time, in a ''YYYY-MM-DD
 HH:MI:SS.sss'' format.
 - The DATEDIFF(part, start, end) function returns the difference between two date and
 time values start and end, based on a date/time part, indicated by part (YY: year, MM:
 month, DD: day, HH: hour, MI: minute, SS: second). For example, DATEDIFF(HH,
 ''2021-10-23 23:00'', ''2021-10-24 01:20'') returns 3 (rounded up to the next
 integer).

- 12 -

Answer group for A
 a) Penalty IS NOT NULL b) Penalty IS NULL
 c) ReturnDateTime IS NOT NULL d) ReturnDateTime IS NULL

Answer group for B
 a) DATEDIFF(HH, RentDateTime, GETDATE()) < 72
 b) DATEDIFF(HH, RentDateTime, GETDATE()) > 72
 c) DATEDIFF(HH, ReturnDateTime, GETDATE()) < 72
 d) DATEDIFF(HH, ReturnDateTime, GETDATE()) > 72

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following SQL statement SQL2.

The following SQL statement SQL2 outputs all customers with their bill information. If a
 customer has no associated bill information, NULL is set to the fields BillID and
 RentDateTime.

-- SQL2 --
 SELECT C.CustomerID, CustomerName, BillID, RentDateTime
 FROM CUSTOMER C
 ***C*** Bill B
 ON C.CustomerID = B.CustomerID

From the sample data shown in the table definitions, SQL2 outputs the following result:

CustomerID CustomerName BillID RentDateTime
 C001 John NULL NULL
 C003 Kathy B2120 2021-10-21 12:10
 C005 Tom B1680 2021-10-16 18:30
 C005 Tom B2180 2021-10-21 18:40

Note:
 - INNER JOIN: The keyword selects records that have matching values in both tables.
 - FULL OUTER JOIN: The keyword returns all records when there is a match in either left
 or right table records.
 - LEFT OUTER JOIN: The keyword returns all records from the left table, and the matched
 records from the right table. The result is NULL from the right side, if there is no match.

- 13 -

- RIGHT OUTER JOIN: The keyword returns all records from the right table, and the
 matched records from the left table. The result is NULL from the left side, if there is no
 match.

Answer group for C
 a) FULL OUTER JOIN b) INNER JOIN
 c) LEFT OUTER JOIN d) RIGHT OUTER JOIN

Subquestion 3
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the following SQL statement SQL3.

The store manager wants to determine which DVDs were entered in the store a certain time
 ago and still appeal to customers. The following SQL statement SQL3 outputs DVDs that
 were entered in the store on and before 2019-10-31 and were rented twice or more during
 the last 12 months. It is assumed that Bill table contains the bill information for the last 12
 months.

-- SQL3 --
 SELECT D.DiskID, FilmName, COUNT(*) AS RentCount
 FROM Disk D, BillDetail B
 WHERE D.DiskID = B.DiskID
 AND DateEntered <= ''2019-10-31''
 ***D***
 ***E***

From the sample data shown in the table definitions, SQL3 outputs the following result:

DiskID FilmName RentCount
 D0280 Alice in AI wonderland 2',
  '[{"type":"prompt","text":"Q3. Read the following description of a database for a DVD rental shop, and then answer\n Subquestions 1 through 3."},{"type":"context","text":"Store U, a DVD rental shop, uses a relational database to manage lending and returning\n operations at the store.\n\nDisk table\n DiskID FilmName DirectorName YearOfProduction DateEntered\n D0280 Alice in AI wonderland A. I. Carroll 2019 2019-10-25\n D0480 Super IT man Clark Kent Jr. 2020 2021-02-26\n D0860 Hello database world! I. T. Pec 2021 2021-10-10\n Disk table contains information about each DVD, including the disk ID, film name,\n director name, year of production, and date entered in the store.\n\nCustomer table\n CustomerID CustomerName Address Phone\n C001 John 401 North street, East city 1234567\n C003 Kathy 44 South street, East city 2345678\n C005 Tom 109 Central street, West city 3456789\n Customer table contains information about each customer, including the customer ID,\n customer name, address, and phone number.\n\nBill table\n BillID CustomerID RentDateTime RentalCharge ReturnDateTime Penalty\n B1680 C005 2021-10-16 18:30 1.00 2021-10-18 17:50 NULL\n B2120 C003 2021-10-21 12:10 2.00 NULL NULL\n B2180 C005 2021-10-21 18:40 1.00 NULL NULL\n Bill table contains information about the bills for each customer, including the bill ID,\n customer ID, rented date and time, returned date and time, rental charge, and penalty.\n\nBillDetail table\n BillDetailID BillID DiskID\n B1680-1 B1680 D0280\n B2120-1 B2120 D0860\n B2120-2 B2120 D0280\n B2180-1 B2180 D0480\n BillDetail table contains the details of a bill, including the bill ID and disk ID.\n\n- 11 -\n\nWhen a customer rents DVDs, a bill record is created. Rental charge is $1.00 per DVD. At\n that time, NULL is set to the columns ReturnDateTime and Penalty.\n When the customer returns the rented DVDs, the value of ReturnDateTime is set. The value\n of Penalty is set only if the customer misses a deadline and he/she needs to pay a penalty.\n The deadline is 72 hours from the rented date and time. The penalty is $1.00 per day (24\n hours) per DVD.\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following SQL statement SQL1.\n\nThe following SQL statement SQL1 outputs the customers who currently (at the time SQL1\n is executed) miss the deadline with the number of DVDs they still have with them.\n\n-- SQL1 --\n SELECT C.CustomerID, CustomerName, COUNT(*) AS DiskCount\n FROM Customer C, Bill B, BillDetail D\n WHERE C.CustomerID = B.CustomerID\n AND B.BillID = D.BillID\n AND ***A***\n AND ***B***\n GROUP BY C.CustomerID, CustomerName\n\nFrom the sample data shown in the table definitions, SQL1 outputs the following result. It\n is assumed that SQL1 is executed at 13:30 on 2021-10-24.\n\nCustomerID CustomerName DiskCount\n C003 Kathy 2\n\nNote:\n - The GETDATE() function returns the current date and time, in a ''YYYY-MM-DD\n HH:MI:SS.sss'' format.\n - The DATEDIFF(part, start, end) function returns the difference between two date and\n time values start and end, based on a date/time part, indicated by part (YY: year, MM:\n month, DD: day, HH: hour, MI: minute, SS: second). For example, DATEDIFF(HH,\n ''2021-10-23 23:00'', ''2021-10-24 01:20'') returns 3 (rounded up to the next\n integer).\n\n- 12 -\n\nAnswer group for A\n a) Penalty IS NOT NULL b) Penalty IS NULL\n c) ReturnDateTime IS NOT NULL d) ReturnDateTime IS NULL\n\nAnswer group for B\n a) DATEDIFF(HH, RentDateTime, GETDATE()) < 72\n b) DATEDIFF(HH, RentDateTime, GETDATE()) > 72\n c) DATEDIFF(HH, ReturnDateTime, GETDATE()) < 72\n d) DATEDIFF(HH, ReturnDateTime, GETDATE()) > 72\n\nSubquestion 2\n From the answer group below, select the correct answer to be inserted in the blank _______\n in the following SQL statement SQL2.\n\nThe following SQL statement SQL2 outputs all customers with their bill information. If a\n customer has no associated bill information, NULL is set to the fields BillID and\n RentDateTime.\n\n-- SQL2 --\n SELECT C.CustomerID, CustomerName, BillID, RentDateTime\n FROM CUSTOMER C\n ***C*** Bill B\n ON C.CustomerID = B.CustomerID\n\nFrom the sample data shown in the table definitions, SQL2 outputs the following result:\n\nCustomerID CustomerName BillID RentDateTime\n C001 John NULL NULL\n C003 Kathy B2120 2021-10-21 12:10\n C005 Tom B1680 2021-10-16 18:30\n C005 Tom B2180 2021-10-21 18:40\n\nNote:\n - INNER JOIN: The keyword selects records that have matching values in both tables.\n - FULL OUTER JOIN: The keyword returns all records when there is a match in either left\n or right table records.\n - LEFT OUTER JOIN: The keyword returns all records from the left table, and the matched\n records from the right table. The result is NULL from the right side, if there is no match.\n\n- 13 -\n\n- RIGHT OUTER JOIN: The keyword returns all records from the right table, and the\n matched records from the left table. The result is NULL from the left side, if there is no\n match.\n\nAnswer group for C\n a) FULL OUTER JOIN b) INNER JOIN\n c) LEFT OUTER JOIN d) RIGHT OUTER JOIN\n\nSubquestion 3\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in the following SQL statement SQL3.\n\nThe store manager wants to determine which DVDs were entered in the store a certain time\n ago and still appeal to customers. The following SQL statement SQL3 outputs DVDs that\n were entered in the store on and before 2019-10-31 and were rented twice or more during\n the last 12 months. It is assumed that Bill table contains the bill information for the last 12\n months.\n\n-- SQL3 --\n SELECT D.DiskID, FilmName, COUNT(*) AS RentCount\n FROM Disk D, BillDetail B\n WHERE D.DiskID = B.DiskID\n AND DateEntered <= ''2019-10-31''\n ***D***\n ***E***\n\nFrom the sample data shown in the table definitions, SQL3 outputs the following result:\n\nDiskID FilmName RentCount\n D0280 Alice in AI wonderland 2"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"AND COUNT(*) >= 2"},{"label":"b","text":"HAVING COUNT(*) >= 2"},{"label":"c","text":"GROUP BY D.DiskID"},{"label":"d","text":"GROUP BY D.DiskID, FilmName"},{"label":"e","text":"ORDER BY D.DiskID"},{"label":"f","text":"ORDER BY D.DiskID, FilmName\n\n - 14 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "d"}, {"subquestion": 1, "blank": "B", "answer": "b"}, {"subquestion": 2, "blank": "C", "answer": "c"}, {"subquestion": 3, "blank": "D", "answer": "d"}, {"subquestion": 3, "blank": "E", "answer": "b"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"d"},{"subquestion":1,"blank":"B","answer":"b"},{"subquestion":2,"blank":"C","answer":"c"},{"subquestion":3,"blank":"D","answer":"d"},{"subquestion":3,"blank":"E","answer":"b"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-B, Q3)',
  ARRAY[11,12,13,14]::int[],
  'native_text',
  '3.0',
  'Q3. Read the following description of a database for a DVD rental shop, and then answer
 Subquestions 1 through 3.

 Store U, a DVD rental shop, uses a relational database to manage lending and returning
 operations at the store.

 Disk table
 DiskID FilmName DirectorName YearOfProduction DateEntered
 D0280 Alice in AI wonderland A. I. Carroll 2019 2019-10-25
 D0480 Super IT man Clark Kent Jr. 2020 2021-02-26
 D0860 Hello database world! I. T. Pec 2021 2021-10-10
 Disk table contains information about each DVD, including the disk ID, film name,
 director name, year of production, and date entered in the store.

 Customer table
 CustomerID CustomerName Address Phone
 C001 John 401 North street, East city 1234567
 C003 Kathy 44 South street, East city 2345678
 C005 Tom 109 Central street, West city 3456789
 Customer table contains information about each customer, including the customer ID,
 customer name, address, and phone number.

 Bill table
 BillID CustomerID RentDateTime RentalCharge ReturnDateTime Penalty
 B1680 C005 2021-10-16 18:30 1.00 2021-10-18 17:50 NULL
 B2120 C003 2021-10-21 12:10 2.00 NULL NULL
 B2180 C005 2021-10-21 18:40 1.00 NULL NULL
 Bill table contains information about the bills for each customer, including the bill ID,
 customer ID, rented date and time, returned date and time, rental charge, and penalty.

 BillDetail table
 BillDetailID BillID DiskID
 B1680-1 B1680 D0280
 B2120-1 B2120 D0860
 B2120-2 B2120 D0280
 B2180-1 B2180 D0480
 BillDetail table contains the details of a bill, including the bill ID and disk ID.

 - 11 -

When a customer rents DVDs, a bill record is created. Rental charge is $1.00 per DVD. At
 that time, NULL is set to the columns ReturnDateTime and Penalty.
 When the customer returns the rented DVDs, the value of ReturnDateTime is set. The value
 of Penalty is set only if the customer misses a deadline and he/she needs to pay a penalty.
 The deadline is 72 hours from the rented date and time. The penalty is $1.00 per day (24
 hours) per DVD.

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following SQL statement SQL1.

 The following SQL statement SQL1 outputs the customers who currently (at the time SQL1
 is executed) miss the deadline with the number of DVDs they still have with them.

 -- SQL1 --
 SELECT C.CustomerID, CustomerName, COUNT(*) AS DiskCount
 FROM Customer C, Bill B, BillDetail D
 WHERE C.CustomerID = B.CustomerID
 AND B.BillID = D.BillID
 AND _____A_____
 AND _____B_____
 GROUP BY C.CustomerID, CustomerName

 From the sample data shown in the table definitions, SQL1 outputs the following result. It
 is assumed that SQL1 is executed at 13:30 on 2021-10-24.

 CustomerID CustomerName DiskCount
 C003 Kathy 2

 Note:
 - The GETDATE() function returns the current date and time, in a ''YYYY-MM-DD
 HH:MI:SS.sss'' format.
 - The DATEDIFF(part, start, end) function returns the difference between two date and
 time values start and end, based on a date/time part, indicated by part (YY: year, MM:
 month, DD: day, HH: hour, MI: minute, SS: second). For example, DATEDIFF(HH,
 ''2021-10-23 23:00'', ''2021-10-24 01:20'') returns 3 (rounded up to the next
 integer).

 - 12 -

Answer group for A
 a) Penalty IS NOT NULL b) Penalty IS NULL
 c) ReturnDateTime IS NOT NULL d) ReturnDateTime IS NULL

 Answer group for B
 a) DATEDIFF(HH, RentDateTime, GETDATE()) < 72
 b) DATEDIFF(HH, RentDateTime, GETDATE()) > 72
 c) DATEDIFF(HH, ReturnDateTime, GETDATE()) < 72
 d) DATEDIFF(HH, ReturnDateTime, GETDATE()) > 72

Subquestion 2
 From the answer group below, select the correct answer to be inserted in the blank _______
 in the following SQL statement SQL2.

 The following SQL statement SQL2 outputs all customers with their bill information. If a
 customer has no associated bill information, NULL is set to the fields BillID and
 RentDateTime.

 -- SQL2 --
 SELECT C.CustomerID, CustomerName, BillID, RentDateTime
 FROM CUSTOMER C
 _____C_____ Bill B
 ON C.CustomerID = B.CustomerID

 From the sample data shown in the table definitions, SQL2 outputs the following result:

 CustomerID CustomerName BillID RentDateTime
 C001 John NULL NULL
 C003 Kathy B2120 2021-10-21 12:10
 C005 Tom B1680 2021-10-16 18:30
 C005 Tom B2180 2021-10-21 18:40

 Note:
 - INNER JOIN: The keyword selects records that have matching values in both tables.
 - FULL OUTER JOIN: The keyword returns all records when there is a match in either left
 or right table records.
 - LEFT OUTER JOIN: The keyword returns all records from the left table, and the matched
 records from the right table. The result is NULL from the right side, if there is no match.

 - 13 -

- RIGHT OUTER JOIN: The keyword returns all records from the right table, and the
 matched records from the left table. The result is NULL from the left side, if there is no
 match.

 Answer group for C
 a) FULL OUTER JOIN b) INNER JOIN
 c) LEFT OUTER JOIN d) RIGHT OUTER JOIN

Subquestion 3
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in the following SQL statement SQL3.

 The store manager wants to determine which DVDs were entered in the store a certain time
 ago and still appeal to customers. The following SQL statement SQL3 outputs DVDs that
 were entered in the store on and before 2019-10-31 and were rented twice or more during
 the last 12 months. It is assumed that Bill table contains the bill information for the last 12
 months.

 -- SQL3 --
 SELECT D.DiskID, FilmName, COUNT(*) AS RentCount
 FROM Disk D, BillDetail B
 WHERE D.DiskID = B.DiskID
 AND DateEntered <= ''2019-10-31''
 _____D_____
 _____E_____

 From the sample data shown in the table definitions, SQL3 outputs the following result:

 DiskID FilmName RentCount
 D0280 Alice in AI wonderland 2

 Answer group for D and E
 a) AND COUNT(*) >= 2
 b) HAVING COUNT(*) >= 2
 c) GROUP BY D.DiskID
 d) GROUP BY D.DiskID, FilmName
 e) ORDER BY D.DiskID
 f) ORDER BY D.DiskID, FilmName

 - 14 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/b/questions.pdf","pages":[11,12,13,14]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'B',
  4,
  'Q4. Read the following description of an internal network of a company, and then answer
 Subquestions 1 through 3.

Company V designed the internal network infrastructure with the different network
 addresses 172.16.0.0/24, 172.16.1.0/24, and 172.16.2.0/24. These networks are connected
 to each other using Firewall, Router A, and Router B. Company V uses the NAT (Network
 Address Translation) function on Firewall to access the Internet from the internal network.
 A mail server, a DNS server, and an external Web server are located in the DMZ. PCs used
 by the tech team are connected to Network A and PCs used by the solution team are
 connected to Network B. Firewall blocks all incoming communication from the Internet to
 the internal network including the DMZ, except for explicitly allowed communication. The
 DMZ uses the subnet 192.168.1.0/27.
 Figure 1 shows the internal network of Company V.

The Internet

DMZ
 192.168.1.2
 Mail Server
 203.0.113.2
 192.168.1.1 192.168.1.3
 Firewall DNS Server
 172.16.0.1 192.168.1.4 External Web Server

e0 172.16.0.2 e0 172.16.0.3

Router A Router B
 Network A Network B
 e1 172.16.1.1 e1 172.16.2.1

172.16.2.10
 DHCP Server

PC‐A#1 … PC‐A#151 PC‐B#1 … PC‐B#151
 172.16.1.50 … 172.16.1.200 172.16.2.50 … 172.16.2.200

Tech team Solution team

Figure 1 Internal network of Company V

- 15 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

To assign IP addresses to all PCs efficiently, DHCP server is running on Network B. All PCs
 will obtain IP address information from the DHCP server. For management devices such as
 routers and servers, a static IP address scheme is used. When PCs in Network A request
 DHCP information, they will send DHCP requests to the DHCP server on Network B. The
 DHCP server can provide IP addresses only when a DHCP request broadcast is received, and
 this is normally limited to those within the same physical network ***A***. To get the
 DHCP information from Network A, a DHCP relay agent feature is needed on Router A.
 The DHCP relay agent is a service that forwards DHCP packets between clients and servers.
 It forwards received requests from clients to the DHCP server in a unicast fashion. In this
 network configuration, the destination address of a forwarded request is ***B***. The
 DHCP relay agent also forwards replies from the DHCP server to clients.
 In this network installation, a network administrator enables the DHCP relay agent on
 interface e1 on Router A which is connected to the DHCP clients. After the DHCP relay
 agent is configured, the DHCP request broadcast is forwarded to the DHCP server and it can
 reply with the valid IP address to the client on a different network.

Answer group for A
 a) 172.16.0.0/16 b) 172.16.0.0/24 c) 172.16.1.0/24
 d) 172.16.2.0/24 e) 172.16.3.0/24

Answer group for B
 a) 172.16.0.2 b) 172.16.0.3 c) 172.16.0.255 d) 172.16.1.1
 e) 172.16.1.255 f) 172.16.2.1 g) 172.16.2.10 h) 172.16.2.255

- 16 -

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

The routing tables are properly configured in the internal network of Company V. The
 network administrator confirms that PCs in Network A can communicate with each other
 and also communicate with servers in the DMZ. However, PCs in Network B cannot connect
 to other networks.
 He confirms that the communication among PCs in Network B is working properly.
 However, he finds out that a ping message to Firewall and Router A fails. He checks the IP
 address information of several PCs in Network B. Table 1 shows the IP address information
 of host PC-B#1.

Table 1 IP address information of the host PC-B#1

IP address Subnet mask Default gateway
 172.16.2.50 255.255.255.0 172.16.1.1

Based on the information in Table 1, he finally identifies that ***C***. After he changes
 the configuration of the DHCP server as shown in Table 2, PCs in Network B can access
 servers in the DMZ and Network B.

Table 2 Changed configuration of DHCP server

Network Subnet mask Range Default gateway
 172.16.2.0 255.255.255.0 172.16.2.50 to ***D***
 172.16.2.200

Answer group for C
 a) the host could not contact the DHCP server and generated its own IP address
 b) the host received the incorrect gateway address that was assigned by the DHCP server
 c) the host uses a private address that is most likely assigned using DHCP
 d) the host uses the IP address of DHCP server as its default gateway

Answer group for D
 a) 172.16.0.2 b) 172.16.1.1 c) 172.16.2.1
 d) 172.16.2.10 e) 192.168.1.1

- 17 -

Subquestion 3
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Table 3.

To secure the servers located in the DMZ, the network administrator implements the traffic
 rules shown in Table 3 on Firewall based on the following rules:
 (1) Mail transferring services (SMTP) on the external IP address of Firewall will be mapped
 to the mail server in the DMZ.
 (2) Mail receiving services (IMAP) on the external IP address of Firewall will be mapped
 to the mail server in the DMZ.
 (3) Allow access from the DMZ to the Internet via NAT (IP address translation), which is
 necessary for correct functionality of the mapped service.
 (4) Allow access from the LANs to the DMZ, which makes the servers accessible to local
 users.
 (5) Disable access from the DMZ to the LAN to protect against network intrusions from
 the DMZ.

Note that the return traffic of packets allowed by the aforementioned rules is also implicitly
 allowed.

Table 3 Traffic rules on Firewall (other settings are not shown)

Source Destination Service IP version Action Translation
 Internet Firewall ***E*** any Allow MAP 192.168.1.2
 Internet Firewall IMAP any Allow MAP 192.168.1.2
 DMZ Internet any any Allow ***F***
 LANs DMZ any any Allow
 DMZ LANs any any deny
 … … … … … …',
  '[{"type":"prompt","text":"Q4. Read the following description of an internal network of a company, and then answer\n Subquestions 1 through 3."},{"type":"context","text":"Company V designed the internal network infrastructure with the different network\n addresses 172.16.0.0/24, 172.16.1.0/24, and 172.16.2.0/24. These networks are connected\n to each other using Firewall, Router A, and Router B. Company V uses the NAT (Network\n Address Translation) function on Firewall to access the Internet from the internal network.\n A mail server, a DNS server, and an external Web server are located in the DMZ. PCs used\n by the tech team are connected to Network A and PCs used by the solution team are\n connected to Network B. Firewall blocks all incoming communication from the Internet to\n the internal network including the DMZ, except for explicitly allowed communication. The\n DMZ uses the subnet 192.168.1.0/27.\n Figure 1 shows the internal network of Company V.\n\nThe Internet\n\nDMZ\n 192.168.1.2\n Mail Server\n 203.0.113.2\n 192.168.1.1 192.168.1.3\n Firewall DNS Server\n 172.16.0.1 192.168.1.4 External Web Server\n\ne0 172.16.0.2 e0 172.16.0.3\n\nRouter A Router B\n Network A Network B\n e1 172.16.1.1 e1 172.16.2.1\n\n172.16.2.10\n DHCP Server\n\nPC‐A#1 … PC‐A#151 PC‐B#1 … PC‐B#151\n 172.16.1.50 … 172.16.1.200 172.16.2.50 … 172.16.2.200\n\nTech team Solution team\n\nFigure 1 Internal network of Company V\n\n- 15 -\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following description.\n\nTo assign IP addresses to all PCs efficiently, DHCP server is running on Network B. All PCs\n will obtain IP address information from the DHCP server. For management devices such as\n routers and servers, a static IP address scheme is used. When PCs in Network A request\n DHCP information, they will send DHCP requests to the DHCP server on Network B. The\n DHCP server can provide IP addresses only when a DHCP request broadcast is received, and\n this is normally limited to those within the same physical network ***A***. To get the\n DHCP information from Network A, a DHCP relay agent feature is needed on Router A.\n The DHCP relay agent is a service that forwards DHCP packets between clients and servers.\n It forwards received requests from clients to the DHCP server in a unicast fashion. In this\n network configuration, the destination address of a forwarded request is ***B***. The\n DHCP relay agent also forwards replies from the DHCP server to clients.\n In this network installation, a network administrator enables the DHCP relay agent on\n interface e1 on Router A which is connected to the DHCP clients. After the DHCP relay\n agent is configured, the DHCP request broadcast is forwarded to the DHCP server and it can\n reply with the valid IP address to the client on a different network.\n\nAnswer group for A\n a) 172.16.0.0/16 b) 172.16.0.0/24 c) 172.16.1.0/24\n d) 172.16.2.0/24 e) 172.16.3.0/24\n\nAnswer group for B\n a) 172.16.0.2 b) 172.16.0.3 c) 172.16.0.255 d) 172.16.1.1\n e) 172.16.1.255 f) 172.16.2.1 g) 172.16.2.10 h) 172.16.2.255\n\n- 16 -\n\nSubquestion 2\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the following description.\n\nThe routing tables are properly configured in the internal network of Company V. The\n network administrator confirms that PCs in Network A can communicate with each other\n and also communicate with servers in the DMZ. However, PCs in Network B cannot connect\n to other networks.\n He confirms that the communication among PCs in Network B is working properly.\n However, he finds out that a ping message to Firewall and Router A fails. He checks the IP\n address information of several PCs in Network B. Table 1 shows the IP address information\n of host PC-B#1.\n\nTable 1 IP address information of the host PC-B#1\n\nIP address Subnet mask Default gateway\n 172.16.2.50 255.255.255.0 172.16.1.1\n\nBased on the information in Table 1, he finally identifies that ***C***. After he changes\n the configuration of the DHCP server as shown in Table 2, PCs in Network B can access\n servers in the DMZ and Network B.\n\nTable 2 Changed configuration of DHCP server\n\nNetwork Subnet mask Range Default gateway\n 172.16.2.0 255.255.255.0 172.16.2.50 to ***D***\n 172.16.2.200\n\nAnswer group for C\n a) the host could not contact the DHCP server and generated its own IP address\n b) the host received the incorrect gateway address that was assigned by the DHCP server\n c) the host uses a private address that is most likely assigned using DHCP\n d) the host uses the IP address of DHCP server as its default gateway\n\nAnswer group for D\n a) 172.16.0.2 b) 172.16.1.1 c) 172.16.2.1\n d) 172.16.2.10 e) 192.168.1.1\n\n- 17 -\n\nSubquestion 3\n From the answer group below, select the correct answer to be inserted in each blank\n _______ in Table 3.\n\nTo secure the servers located in the DMZ, the network administrator implements the traffic\n rules shown in Table 3 on Firewall based on the following rules:\n (1) Mail transferring services (SMTP) on the external IP address of Firewall will be mapped\n to the mail server in the DMZ.\n (2) Mail receiving services (IMAP) on the external IP address of Firewall will be mapped\n to the mail server in the DMZ.\n (3) Allow access from the DMZ to the Internet via NAT (IP address translation), which is\n necessary for correct functionality of the mapped service.\n (4) Allow access from the LANs to the DMZ, which makes the servers accessible to local\n users.\n (5) Disable access from the DMZ to the LAN to protect against network intrusions from\n the DMZ.\n\nNote that the return traffic of packets allowed by the aforementioned rules is also implicitly\n allowed.\n\nTable 3 Traffic rules on Firewall (other settings are not shown)\n\nSource Destination Service IP version Action Translation\n Internet Firewall ***E*** any Allow MAP 192.168.1.2\n Internet Firewall IMAP any Allow MAP 192.168.1.2\n DMZ Internet any any Allow ***F***\n LANs DMZ any any Allow\n DMZ LANs any any deny\n … … … … … …"}]'::jsonb,
  '["2021-october-b-q04-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"any"},{"label":"b","text":"DNAT"},{"label":"c","text":"DNS"},{"label":"d","text":"HTTP"},{"label":"e","text":"HTTPS"},{"label":"f","text":"NAT"},{"label":"g","text":"Port Forwarding"},{"label":"h","text":"SMTP"},{"label":"i","text":"udp\n\n - 18 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "d"}, {"subquestion": 1, "blank": "B", "answer": "g"}, {"subquestion": 2, "blank": "C", "answer": "b"}, {"subquestion": 2, "blank": "D", "answer": "c"}, {"subquestion": 3, "blank": "E", "answer": "h"}, {"subquestion": 3, "blank": "F", "answer": "f"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"d"},{"subquestion":1,"blank":"B","answer":"g"},{"subquestion":2,"blank":"C","answer":"b"},{"subquestion":2,"blank":"D","answer":"c"},{"subquestion":3,"blank":"E","answer":"h"},{"subquestion":3,"blank":"F","answer":"f"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-B, Q4)',
  ARRAY[15,16,17,18]::int[],
  'native_text',
  '3.0',
  'Q4. Read the following description of an internal network of a company, and then answer
 Subquestions 1 through 3.

 Company V designed the internal network infrastructure with the different network
 addresses 172.16.0.0/24, 172.16.1.0/24, and 172.16.2.0/24. These networks are connected
 to each other using Firewall, Router A, and Router B. Company V uses the NAT (Network
 Address Translation) function on Firewall to access the Internet from the internal network.
 A mail server, a DNS server, and an external Web server are located in the DMZ. PCs used
 by the tech team are connected to Network A and PCs used by the solution team are
 connected to Network B. Firewall blocks all incoming communication from the Internet to
 the internal network including the DMZ, except for explicitly allowed communication. The
 DMZ uses the subnet 192.168.1.0/27.
 Figure 1 shows the internal network of Company V.

 The Internet

 DMZ
 192.168.1.2
 Mail Server
 203.0.113.2
 192.168.1.1 192.168.1.3
 Firewall DNS Server
 172.16.0.1 192.168.1.4 External Web Server

 e0 172.16.0.2 e0 172.16.0.3

 Router A Router B
 Network A Network B
 e1 172.16.1.1 e1 172.16.2.1

 172.16.2.10
 DHCP Server

 PC‐A#1 … PC‐A#151 PC‐B#1 … PC‐B#151
 172.16.1.50 … 172.16.1.200 172.16.2.50 … 172.16.2.200

 Tech team Solution team

 Figure 1 Internal network of Company V

 - 15 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

 To assign IP addresses to all PCs efficiently, DHCP server is running on Network B. All PCs
 will obtain IP address information from the DHCP server. For management devices such as
 routers and servers, a static IP address scheme is used. When PCs in Network A request
 DHCP information, they will send DHCP requests to the DHCP server on Network B. The
 DHCP server can provide IP addresses only when a DHCP request broadcast is received, and
 this is normally limited to those within the same physical network ___A___. To get the
 DHCP information from Network A, a DHCP relay agent feature is needed on Router A.
 The DHCP relay agent is a service that forwards DHCP packets between clients and servers.
 It forwards received requests from clients to the DHCP server in a unicast fashion. In this
 network configuration, the destination address of a forwarded request is ___B___. The
 DHCP relay agent also forwards replies from the DHCP server to clients.
 In this network installation, a network administrator enables the DHCP relay agent on
 interface e1 on Router A which is connected to the DHCP clients. After the DHCP relay
 agent is configured, the DHCP request broadcast is forwarded to the DHCP server and it can
 reply with the valid IP address to the client on a different network.

 Answer group for A
 a) 172.16.0.0/16 b) 172.16.0.0/24 c) 172.16.1.0/24
 d) 172.16.2.0/24 e) 172.16.3.0/24

 Answer group for B
 a) 172.16.0.2 b) 172.16.0.3 c) 172.16.0.255 d) 172.16.1.1
 e) 172.16.1.255 f) 172.16.2.1 g) 172.16.2.10 h) 172.16.2.255

 - 16 -

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

 The routing tables are properly configured in the internal network of Company V. The
 network administrator confirms that PCs in Network A can communicate with each other
 and also communicate with servers in the DMZ. However, PCs in Network B cannot connect
 to other networks.
 He confirms that the communication among PCs in Network B is working properly.
 However, he finds out that a ping message to Firewall and Router A fails. He checks the IP
 address information of several PCs in Network B. Table 1 shows the IP address information
 of host PC-B#1.

 Table 1 IP address information of the host PC-B#1

 IP address Subnet mask Default gateway
 172.16.2.50 255.255.255.0 172.16.1.1

 Based on the information in Table 1, he finally identifies that ___C___. After he changes
 the configuration of the DHCP server as shown in Table 2, PCs in Network B can access
 servers in the DMZ and Network B.

 Table 2 Changed configuration of DHCP server

 Network Subnet mask Range Default gateway
 172.16.2.0 255.255.255.0 172.16.2.50 to ___D___
 172.16.2.200

 Answer group for C
 a) the host could not contact the DHCP server and generated its own IP address
 b) the host received the incorrect gateway address that was assigned by the DHCP server
 c) the host uses a private address that is most likely assigned using DHCP
 d) the host uses the IP address of DHCP server as its default gateway

 Answer group for D
 a) 172.16.0.2 b) 172.16.1.1 c) 172.16.2.1
 d) 172.16.2.10 e) 192.168.1.1

 - 17 -

Subquestion 3
 From the answer group below, select the correct answer to be inserted in each blank
 _______ in Table 3.

 To secure the servers located in the DMZ, the network administrator implements the traffic
 rules shown in Table 3 on Firewall based on the following rules:
 (1) Mail transferring services (SMTP) on the external IP address of Firewall will be mapped
 to the mail server in the DMZ.
 (2) Mail receiving services (IMAP) on the external IP address of Firewall will be mapped
 to the mail server in the DMZ.
 (3) Allow access from the DMZ to the Internet via NAT (IP address translation), which is
 necessary for correct functionality of the mapped service.
 (4) Allow access from the LANs to the DMZ, which makes the servers accessible to local
 users.
 (5) Disable access from the DMZ to the LAN to protect against network intrusions from
 the DMZ.

 Note that the return traffic of packets allowed by the aforementioned rules is also implicitly
 allowed.

 Table 3 Traffic rules on Firewall (other settings are not shown)

 Source Destination Service IP version Action Translation
 Internet Firewall ___E___ any Allow MAP 192.168.1.2
 Internet Firewall IMAP any Allow MAP 192.168.1.2
 DMZ Internet any any Allow ___F___
 LANs DMZ any any Allow
 DMZ LANs any any deny
 … … … … … …

 Answer group for E and F
 a) any b) DNAT c) DNS
 d) HTTP e) HTTPS f) NAT
 g) Port Forwarding h) SMTP i) udp

 - 18 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/b/questions.pdf","pages":[15,16,17,18]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'B',
  5,
  'Q5. Read the following description of a food ordering application, and then answer
 Subquestions 1 and 2.

Company W plans to offer takeout food services to its customers and develops a food
 ordering application. Using this application, a customer can select a restaurant, select foods,
 and place orders. The customer can indicate the time they wish to pick up the order, so that
 restaurants can prepare the food at the correct time.

[Main functions]
 (1) Member subscription
 • There are two types of members: a customer member (hereinafter, a customer) and a
 restaurant member (hereinafter, a restaurant).
 • To be a member of the application, the customers and restaurants must subscribe to the
 application.
 • The subscription information includes the member type, name, and phone number.
 • The application registers customer ID or restaurant ID with a password for each
 member.

(2) Restaurant type function
 • Creating the restaurant information
 o A restaurant registers its restaurant information that includes name, address, and
 phone number.
 o After creating the restaurant information, the restaurant can add a menu to the
 restaurant information. Each menu is identified by a menu ID.
 o For each food item on the menu, the restaurant registers the food name, price, food
 description, and an image of the food item. Each food item is identified by a food
 ID.
 o The restaurant information including the menu can be changed or deleted.
 • Confirming the customer orders
 o After a customer has placed an order, an order list is displayed on the restaurant’s
 screen.
 o The restaurant checks the order list, confirms the availability of each food, and
 sends a notification to the customer.
 o When cooking starts (deadline time), the restaurant sends a “Cannot cancel order”
 message to the customer; the customer cannot cancel the order after this time.

- 19 -

(3) Customer type function
 • Placing orders
 o A customer can order food from one restaurant at a time.
 o An order must be placed on the same day of picking up food.
 o To order food, a customer views the menu, selects the food item, and fills-in the
 number of each food item to be ordered.
 o After a customer confirms the order, the application displays the order summary
 on the customer’s screen. The order summary includes the food name, number of
 dishes and price for each food item.
 o A customer places the order to the restaurant and informs the restaurant of the
 time he/she will come to pick up the foods.
 o A customer must wait for the notification from the restaurant.
 • Canceling orders
 o A customer can cancel the order before the deadline time.

Figure 1 shows the use case diagram of the food ordering application. A customer has to
perform member subscription. After that, the customer can login to the application; the
application will then display the list of restaurants. The customer can select a restaurant,
display and select food, order (or cancel) some food items, confirm the order, and specify
the pickup time the customer will go to the restaurant to collect the food.

Food ordering application

Member
 subscription

A

Place order
 Confirm
 Customer order Restaurant
 Cancel
 order
 Manage
 kitchen
 C

Display « include » Manage
 menu menu

Display « include » Manage
 restaurant restaurant

Note: shaded parts are not shown

Figure 1 Use case diagram of the food ordering application

- 20 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Figure 1.

Answer group for A
 a) Check acceptability b) Send notification
 c) Set pickup time d) Verify member subscription

Answer group for B
 a) « extend » b) « extend »

c) « include » d) « include »

Answer group for C
 a) Change order b) Change restaurant
 c) Confirm login information d) No cancellation

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Table 1.

To understand the requirement of each function, the system analyst describes the details
 using a use case description. Table 1 shows the use case description of “Place order”. In
 “Place order”, after a customer successfully logs in to the application, he/she can start to
 order food.

Table 1 Use case description of ”Place order”

Use case name Place order
 Primary actor Customer
 Secondary actor -
 Input Customer ID, Restaurant ID, Menu ID, ***D***",
 Number of dishes, Pickup time
 Output Order summary as the list of food items.
 Trigger The customer clicks “Place order” button on the customer’s screen.
 Availability Always
 Pre-condition The customer has successfully logged in to the application.
 Post-condition The order list is displayed on the restaurant’s screen.

- 21 -

Table 1 Use case description of ”Place order” (continued)

Basic flow Actor Application
 1. Select a restaurant
 From the list of restaurants, the
 customer selects a restaurant.
 2. Select a menu
 From the available menus such as
 lunch and dinner, the customer
 selects a menu.
 3. Select foods
 From the list of food items, the
 customer selects food items. For
 each selected food item, the
 customer fills in ***E*** and
 clicks the “Add food” button to
 add the food to the order.
 4. Check selected food items
 For each selected food item, the
 application checks if ***E*** is
 acceptable or not, and returns the
 reply “Accepted” or “Not
 accepted”, accordingly.
 5. Submit the order
 After the customer confirms all
 needed food items are added to the
 basket, the customer fills in
 ***F*** and clicks the
 “Submit” button to submit this
 order.
 6. Check ***F***
 If it conflicts with the rule, then
 the application returns the reply
 “Not acceptable” and prompts the
 customer to fill it in again.
 If there is no conflict, the
 application sends a confirmation
 request to the restaurant and waits
 for a reply from the restaurant.
 7. Order completion
 After the order is confirmed by the
 restaurant, the application sends a
 notification to the customer.

- 22 -

Answer group for D
 a) Chef ID b) Deadline time
 c) Delivery address d) Food ID
 e) Service charge f) Total amount',
  '[{"type":"prompt","text":"Q5. Read the following description of a food ordering application, and then answer\n Subquestions 1 and 2."},{"type":"context","text":"Company W plans to offer takeout food services to its customers and develops a food\n ordering application. Using this application, a customer can select a restaurant, select foods,\n and place orders. The customer can indicate the time they wish to pick up the order, so that\n restaurants can prepare the food at the correct time.\n\n[Main functions]\n (1) Member subscription\n • There are two types of members: a customer member (hereinafter, a customer) and a\n restaurant member (hereinafter, a restaurant).\n • To be a member of the application, the customers and restaurants must subscribe to the\n application.\n • The subscription information includes the member type, name, and phone number.\n • The application registers customer ID or restaurant ID with a password for each\n member.\n\n(2) Restaurant type function\n • Creating the restaurant information\n o A restaurant registers its restaurant information that includes name, address, and\n phone number.\n o After creating the restaurant information, the restaurant can add a menu to the\n restaurant information. Each menu is identified by a menu ID.\n o For each food item on the menu, the restaurant registers the food name, price, food\n description, and an image of the food item. Each food item is identified by a food\n ID.\n o The restaurant information including the menu can be changed or deleted.\n • Confirming the customer orders\n o After a customer has placed an order, an order list is displayed on the restaurant’s\n screen.\n o The restaurant checks the order list, confirms the availability of each food, and\n sends a notification to the customer.\n o When cooking starts (deadline time), the restaurant sends a “Cannot cancel order”\n message to the customer; the customer cannot cancel the order after this time.\n\n- 19 -\n\n(3) Customer type function\n • Placing orders\n o A customer can order food from one restaurant at a time.\n o An order must be placed on the same day of picking up food.\n o To order food, a customer views the menu, selects the food item, and fills-in the\n number of each food item to be ordered.\n o After a customer confirms the order, the application displays the order summary\n on the customer’s screen. The order summary includes the food name, number of\n dishes and price for each food item.\n o A customer places the order to the restaurant and informs the restaurant of the\n time he/she will come to pick up the foods.\n o A customer must wait for the notification from the restaurant.\n • Canceling orders\n o A customer can cancel the order before the deadline time.\n\nFigure 1 shows the use case diagram of the food ordering application. A customer has to\nperform member subscription. After that, the customer can login to the application; the\napplication will then display the list of restaurants. The customer can select a restaurant,\ndisplay and select food, order (or cancel) some food items, confirm the order, and specify\nthe pickup time the customer will go to the restaurant to collect the food.\n\nFood ordering application\n\nMember\n subscription\n\nA\n\nPlace order\n Confirm\n Customer order Restaurant\n Cancel\n order\n Manage\n kitchen\n C\n\nDisplay « include » Manage\n menu menu\n\nDisplay « include » Manage\n restaurant restaurant\n\nNote: shaded parts are not shown\n\nFigure 1 Use case diagram of the food ordering application\n\n- 20 -\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in Figure 1.\n\nAnswer group for A\n a) Check acceptability b) Send notification\n c) Set pickup time d) Verify member subscription\n\nAnswer group for B\n a) « extend » b) « extend »\n\nc) « include » d) « include »\n\nAnswer group for C\n a) Change order b) Change restaurant\n c) Confirm login information d) No cancellation\n\nSubquestion 2\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in Table 1.\n\nTo understand the requirement of each function, the system analyst describes the details\n using a use case description. Table 1 shows the use case description of “Place order”. In\n “Place order”, after a customer successfully logs in to the application, he/she can start to\n order food.\n\nTable 1 Use case description of ”Place order”\n\nUse case name Place order\n Primary actor Customer\n Secondary actor -\n Input Customer ID, Restaurant ID, Menu ID, ***D***\",\n Number of dishes, Pickup time\n Output Order summary as the list of food items.\n Trigger The customer clicks “Place order” button on the customer’s screen.\n Availability Always\n Pre-condition The customer has successfully logged in to the application.\n Post-condition The order list is displayed on the restaurant’s screen.\n\n- 21 -\n\nTable 1 Use case description of ”Place order” (continued)\n\nBasic flow Actor Application\n 1. Select a restaurant\n From the list of restaurants, the\n customer selects a restaurant.\n 2. Select a menu\n From the available menus such as\n lunch and dinner, the customer\n selects a menu.\n 3. Select foods\n From the list of food items, the\n customer selects food items. For\n each selected food item, the\n customer fills in ***E*** and\n clicks the “Add food” button to\n add the food to the order.\n 4. Check selected food items\n For each selected food item, the\n application checks if ***E*** is\n acceptable or not, and returns the\n reply “Accepted” or “Not\n accepted”, accordingly.\n 5. Submit the order\n After the customer confirms all\n needed food items are added to the\n basket, the customer fills in\n ***F*** and clicks the\n “Submit” button to submit this\n order.\n 6. Check ***F***\n If it conflicts with the rule, then\n the application returns the reply\n “Not acceptable” and prompts the\n customer to fill it in again.\n If there is no conflict, the\n application sends a confirmation\n request to the restaurant and waits\n for a reply from the restaurant.\n 7. Order completion\n After the order is confirmed by the\n restaurant, the application sends a\n notification to the customer.\n\n- 22 -\n\nAnswer group for D\n a) Chef ID b) Deadline time\n c) Delivery address d) Food ID\n e) Service charge f) Total amount"}]'::jsonb,
  '["2021-october-b-q05-figure1.webp","2021-october-b-q05-figure2.webp","2021-october-b-q05-figure3.webp"]'::jsonb,
  '[{"label":"a","text":"amount of tip"},{"label":"b","text":"deadline time"},{"label":"c","text":"delivery address"},{"label":"d","text":"number of dishes"},{"label":"e","text":"pickup time"},{"label":"f","text":"total amount\n\n - 23 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "c"}, {"subquestion": 1, "blank": "B", "answer": "d"}, {"subquestion": 1, "blank": "C", "answer": "d"}, {"subquestion": 2, "blank": "D", "answer": "d"}, {"subquestion": 2, "blank": "E", "answer": "d"}, {"subquestion": 2, "blank": "F", "answer": "e"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"c"},{"subquestion":1,"blank":"B","answer":"d"},{"subquestion":1,"blank":"C","answer":"d"},{"subquestion":2,"blank":"D","answer":"d"},{"subquestion":2,"blank":"E","answer":"d"},{"subquestion":2,"blank":"F","answer":"e"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-B, Q5)',
  ARRAY[19,20,21,22,23]::int[],
  'native_text',
  '3.0',
  'Q5. Read the following description of a food ordering application, and then answer
 Subquestions 1 and 2.

 Company W plans to offer takeout food services to its customers and develops a food
 ordering application. Using this application, a customer can select a restaurant, select foods,
 and place orders. The customer can indicate the time they wish to pick up the order, so that
 restaurants can prepare the food at the correct time.

 [Main functions]
 (1) Member subscription
 • There are two types of members: a customer member (hereinafter, a customer) and a
 restaurant member (hereinafter, a restaurant).
 • To be a member of the application, the customers and restaurants must subscribe to the
 application.
 • The subscription information includes the member type, name, and phone number.
 • The application registers customer ID or restaurant ID with a password for each
 member.

 (2) Restaurant type function
 • Creating the restaurant information
 o A restaurant registers its restaurant information that includes name, address, and
 phone number.
 o After creating the restaurant information, the restaurant can add a menu to the
 restaurant information. Each menu is identified by a menu ID.
 o For each food item on the menu, the restaurant registers the food name, price, food
 description, and an image of the food item. Each food item is identified by a food
 ID.
 o The restaurant information including the menu can be changed or deleted.
 • Confirming the customer orders
 o After a customer has placed an order, an order list is displayed on the restaurant’s
 screen.
 o The restaurant checks the order list, confirms the availability of each food, and
 sends a notification to the customer.
 o When cooking starts (deadline time), the restaurant sends a “Cannot cancel order”
 message to the customer; the customer cannot cancel the order after this time.

 - 19 -

(3) Customer type function
 • Placing orders
 o A customer can order food from one restaurant at a time.
 o An order must be placed on the same day of picking up food.
 o To order food, a customer views the menu, selects the food item, and fills-in the
 number of each food item to be ordered.
 o After a customer confirms the order, the application displays the order summary
 on the customer’s screen. The order summary includes the food name, number of
 dishes and price for each food item.
 o A customer places the order to the restaurant and informs the restaurant of the
 time he/she will come to pick up the foods.
 o A customer must wait for the notification from the restaurant.
 • Canceling orders
 o A customer can cancel the order before the deadline time.

Figure 1 shows the use case diagram of the food ordering application. A customer has to
perform member subscription. After that, the customer can login to the application; the
application will then display the list of restaurants. The customer can select a restaurant,
display and select food, order (or cancel) some food items, confirm the order, and specify
the pickup time the customer will go to the restaurant to collect the food.

 Food ordering application

 Member
 subscription

 A

 Place order
 Confirm
 Customer order Restaurant
 Cancel
 order
 Manage
 kitchen
 C

 Display « include » Manage
 menu menu

 Display « include » Manage
 restaurant restaurant

 Note: shaded parts are not shown

 Figure 1 Use case diagram of the food ordering application

 - 20 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Figure 1.

 Answer group for A
 a) Check acceptability b) Send notification
 c) Set pickup time d) Verify member subscription

 Answer group for B
 a) « extend » b) « extend »

 c) « include » d) « include »

 Answer group for C
 a) Change order b) Change restaurant
 c) Confirm login information d) No cancellation

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in Table 1.

 To understand the requirement of each function, the system analyst describes the details
 using a use case description. Table 1 shows the use case description of “Place order”. In
 “Place order”, after a customer successfully logs in to the application, he/she can start to
 order food.

 Table 1 Use case description of ”Place order”

 Use case name Place order
 Primary actor Customer
 Secondary actor -
 Input Customer ID, Restaurant ID, Menu ID, ___D__",
 Number of dishes, Pickup time
 Output Order summary as the list of food items.
 Trigger The customer clicks “Place order” button on the customer’s screen.
 Availability Always
 Pre-condition The customer has successfully logged in to the application.
 Post-condition The order list is displayed on the restaurant’s screen.

 - 21 -

Table 1 Use case description of ”Place order” (continued)

Basic flow Actor Application
 1. Select a restaurant
 From the list of restaurants, the
 customer selects a restaurant.
 2. Select a menu
 From the available menus such as
 lunch and dinner, the customer
 selects a menu.
 3. Select foods
 From the list of food items, the
 customer selects food items. For
 each selected food item, the
 customer fills in ___E___ and
 clicks the “Add food” button to
 add the food to the order.
 4. Check selected food items
 For each selected food item, the
 application checks if ___E___ is
 acceptable or not, and returns the
 reply “Accepted” or “Not
 accepted”, accordingly.
 5. Submit the order
 After the customer confirms all
 needed food items are added to the
 basket, the customer fills in
 ___F___ and clicks the
 “Submit” button to submit this
 order.
 6. Check ___F___
 If it conflicts with the rule, then
 the application returns the reply
 “Not acceptable” and prompts the
 customer to fill it in again.
 If there is no conflict, the
 application sends a confirmation
 request to the restaurant and waits
 for a reply from the restaurant.
 7. Order completion
 After the order is confirmed by the
 restaurant, the application sends a
 notification to the customer.

 - 22 -

Answer group for D
 a) Chef ID b) Deadline time
 c) Delivery address d) Food ID
 e) Service charge f) Total amount

Answer group for E and F
 a) amount of tip b) deadline time
 c) delivery address d) number of dishes
 e) pickup time f) total amount

 - 23 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/b/questions.pdf","pages":[19,20,21,22,23]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'B',
  6,
  'Q6. Read the following description of encryption and decryption programs, and then answer
 Subquestions 1 and 2.

[Caesar cipher]
 A Caesar cipher is one of the simplest encryption methods. During encryption (decryption),
 each alphabetical character in a given plain (cipher) text is replaced by an alphabetical
 character a given number of positions down (up) the alphabet. It is assumed that a set of
 uppercase alphabet wraps around from “Z” to “A”, and a set of lowercase alphabet wraps
 around from “z” to “a”.
 Encryption example: If the given number is 2, “A” would be replaced by “C”, “p” would be
 replaced by “r”, and “Z” would be replaced by “B”.
 Decryption example: If the given number is 2, “c” would be replaced by “a”, “R” would be
 replaced by “P”, and “b” would be replaced by “z”.

[Program Description]
 The program consists of the following two functions: Encrypt and Decrypt.

FUNCTION: Encrypt(CHAR: input[], CHAR: output[],
 INT: textLen, INT: keyEven, INT: keyOdd)
 FUNCTION: Decrypt(CHAR: input[], CHAR: output[],
 INT: textLen, INT: keyEven, INT: keyOdd)

(1) The function Encrypt encrypts the plain text given by input[] using the keys keyEven
 and keyOdd. The cipher text is obtained in output[].
 The function Decrypt decrypts the cipher text given by input[] using the keys keyEven
 and keyOdd. The plain text is obtained in output[].

(i) input[] and output[] are character arrays. The array indexes start at 0.
 (ii) textLen indicates the number of characters in input[] and output[].
 (iii) keyEven and keyOdd are used to determine the number of positions down (up) the
 alphabet when the text is encrypted (decrypted). The argument values of keyEven
 and keyOdd range between 0 and 25.

- 24 -

(2) The steps for encrypting the plain text are as follows:
 (i) For each character input[i] ( i: 0, 1, … , textLen - 1), repeat (ii).
 (ii) If input[i] is an alphabetical character (“A” - “Z” or “a” - “z”), find an alphabetical
 character keyEven or keyOdd position down the alphabet from input[i], and store it
 into output[i]. Here, keyEven is used if i is an even number (0, 2, 4, …), and keyOdd
 is used if i is an odd number (1, 3, 5, …).
 Otherwise, copy input[i] to output[i].

(3) The steps for decrypting the cipher text are as follows:
 (i) For each character input[i] ( i: 0, 1, … , textLen - 1), repeat (ii).
 (ii) If input[i] is an alphabetical character (“A” - “Z” or “a” - “z”), find an alphabetical
 character keyEven or keyOdd position up the alphabet from input[i], and store it
 into output[i]. Here, keyEven is used if i is an even number (0, 2, 4, …), and keyOdd
 is used if i is an odd number (1, 3, 5, …).
 Otherwise, copy input[i] to output[i].

(4) Characters are represented by ASCII; alphabetical characters “A” - “Z” have consecutive
 internal codes 65 - 90, and “a” - “z” have consecutive internal codes 97 - 122.

(5) The “%” operator indicates a remainder operation. In this question, it is assumed that
 the sign of the non-zero remainder is the same as that of the left-hand operand.
 For example, 2 % 26 = 2, 30 % 26 = 4, (-2) % 26 = -2, and (-30) % 26 = -4.

(6) Sample input and output examples:

Function called Input output

input[] keyEven keyOdd output[]
 Encrypt “ABCxyz” 2 2 “CDEzab”
 Encrypt “ABCxyz” 2 3 “CEEaac”
 Encrypt “non=no(on)” 3 2 “***A***”
 Decrypt “CDEzab” 2 2 “ABCxyz”
 Decrypt “CEEaac” 2 3 “ABCxyz”
 Decrypt “***B***” 3 2 “f(x)=x+1”

- 25 -',
  '[{"type":"prompt","text":"Q6. Read the following description of encryption and decryption programs, and then answer\n Subquestions 1 and 2."},{"type":"context","text":"[Caesar cipher]\n A Caesar cipher is one of the simplest encryption methods. During encryption (decryption),\n each alphabetical character in a given plain (cipher) text is replaced by an alphabetical\n character a given number of positions down (up) the alphabet. It is assumed that a set of\n uppercase alphabet wraps around from “Z” to “A”, and a set of lowercase alphabet wraps\n around from “z” to “a”.\n Encryption example: If the given number is 2, “A” would be replaced by “C”, “p” would be\n replaced by “r”, and “Z” would be replaced by “B”.\n Decryption example: If the given number is 2, “c” would be replaced by “a”, “R” would be\n replaced by “P”, and “b” would be replaced by “z”.\n\n[Program Description]\n The program consists of the following two functions: Encrypt and Decrypt.\n\nFUNCTION: Encrypt(CHAR: input[], CHAR: output[],\n INT: textLen, INT: keyEven, INT: keyOdd)\n FUNCTION: Decrypt(CHAR: input[], CHAR: output[],\n INT: textLen, INT: keyEven, INT: keyOdd)\n\n(1) The function Encrypt encrypts the plain text given by input[] using the keys keyEven\n and keyOdd. The cipher text is obtained in output[].\n The function Decrypt decrypts the cipher text given by input[] using the keys keyEven\n and keyOdd. The plain text is obtained in output[].\n\n(i) input[] and output[] are character arrays. The array indexes start at 0.\n (ii) textLen indicates the number of characters in input[] and output[].\n (iii) keyEven and keyOdd are used to determine the number of positions down (up) the\n alphabet when the text is encrypted (decrypted). The argument values of keyEven\n and keyOdd range between 0 and 25.\n\n- 24 -\n\n(2) The steps for encrypting the plain text are as follows:\n (i) For each character input[i] ( i: 0, 1, … , textLen - 1), repeat (ii).\n (ii) If input[i] is an alphabetical character (“A” - “Z” or “a” - “z”), find an alphabetical\n character keyEven or keyOdd position down the alphabet from input[i], and store it\n into output[i]. Here, keyEven is used if i is an even number (0, 2, 4, …), and keyOdd\n is used if i is an odd number (1, 3, 5, …).\n Otherwise, copy input[i] to output[i].\n\n(3) The steps for decrypting the cipher text are as follows:\n (i) For each character input[i] ( i: 0, 1, … , textLen - 1), repeat (ii).\n (ii) If input[i] is an alphabetical character (“A” - “Z” or “a” - “z”), find an alphabetical\n character keyEven or keyOdd position up the alphabet from input[i], and store it\n into output[i]. Here, keyEven is used if i is an even number (0, 2, 4, …), and keyOdd\n is used if i is an odd number (1, 3, 5, …).\n Otherwise, copy input[i] to output[i].\n\n(4) Characters are represented by ASCII; alphabetical characters “A” - “Z” have consecutive\n internal codes 65 - 90, and “a” - “z” have consecutive internal codes 97 - 122.\n\n(5) The “%” operator indicates a remainder operation. In this question, it is assumed that\n the sign of the non-zero remainder is the same as that of the left-hand operand.\n For example, 2 % 26 = 2, 30 % 26 = 4, (-2) % 26 = -2, and (-30) % 26 = -4.\n\n(6) Sample input and output examples:\n\nFunction called Input output\n\ninput[] keyEven keyOdd output[]\n Encrypt “ABCxyz” 2 2 “CDEzab”\n Encrypt “ABCxyz” 2 3 “CEEaac”\n Encrypt “non=no(on)” 3 2 “***A***”\n Decrypt “CDEzab” 2 2 “ABCxyz”\n Decrypt “CEEaac” 2 3 “ABCxyz”\n Decrypt “***B***” 3 2 “f(x)=x+1”\n\n- 25 -"}]'::jsonb,
  '["2021-october-b-q06-figure1.webp","2021-october-b-q06-figure2.webp"]'::jsonb,
  '[{"label":"a","text":"((- keyEven % 26) + 26) % 26"},{"label":"b","text":"((keyEven % 26) + 26) % 26"},{"label":"c","text":"(- keyEven % 26) + 26"},{"label":"d","text":"(26 - keyEven) % 26\n\n - 29 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "d"}, {"subquestion": 1, "blank": "B", "answer": "d"}, {"subquestion": 1, "blank": "C", "answer": "a"}, {"subquestion": 1, "blank": "D", "answer": "b"}, {"subquestion": 1, "blank": "E", "answer": "c"}, {"subquestion": 2, "blank": "F", "answer": "a"}, {"subquestion": 2, "blank": "G", "answer": "d"}, {"subquestion": 2, "blank": "H", "answer": "b"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"d"},{"subquestion":1,"blank":"B","answer":"d"},{"subquestion":1,"blank":"C","answer":"a"},{"subquestion":1,"blank":"D","answer":"b"},{"subquestion":1,"blank":"E","answer":"c"},{"subquestion":2,"blank":"F","answer":"a"},{"subquestion":2,"blank":"G","answer":"d"},{"subquestion":2,"blank":"H","answer":"b"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-B, Q6)',
  ARRAY[24,25,26,27,28,29]::int[],
  'native_text',
  '3.0',
  'Q6. Read the following description of encryption and decryption programs, and then answer
 Subquestions 1 and 2.

 [Caesar cipher]
 A Caesar cipher is one of the simplest encryption methods. During encryption (decryption),
 each alphabetical character in a given plain (cipher) text is replaced by an alphabetical
 character a given number of positions down (up) the alphabet. It is assumed that a set of
 uppercase alphabet wraps around from “Z” to “A”, and a set of lowercase alphabet wraps
 around from “z” to “a”.
 Encryption example: If the given number is 2, “A” would be replaced by “C”, “p” would be
 replaced by “r”, and “Z” would be replaced by “B”.
 Decryption example: If the given number is 2, “c” would be replaced by “a”, “R” would be
 replaced by “P”, and “b” would be replaced by “z”.

 [Program Description]
 The program consists of the following two functions: Encrypt and Decrypt.

 FUNCTION: Encrypt(CHAR: input[], CHAR: output[],
 INT: textLen, INT: keyEven, INT: keyOdd)
 FUNCTION: Decrypt(CHAR: input[], CHAR: output[],
 INT: textLen, INT: keyEven, INT: keyOdd)

 (1) The function Encrypt encrypts the plain text given by input[] using the keys keyEven
 and keyOdd. The cipher text is obtained in output[].
 The function Decrypt decrypts the cipher text given by input[] using the keys keyEven
 and keyOdd. The plain text is obtained in output[].

 (i) input[] and output[] are character arrays. The array indexes start at 0.
 (ii) textLen indicates the number of characters in input[] and output[].
 (iii) keyEven and keyOdd are used to determine the number of positions down (up) the
 alphabet when the text is encrypted (decrypted). The argument values of keyEven
 and keyOdd range between 0 and 25.

 - 24 -

(2) The steps for encrypting the plain text are as follows:
 (i) For each character input[i] ( i: 0, 1, … , textLen - 1), repeat (ii).
 (ii) If input[i] is an alphabetical character (“A” - “Z” or “a” - “z”), find an alphabetical
 character keyEven or keyOdd position down the alphabet from input[i], and store it
 into output[i]. Here, keyEven is used if i is an even number (0, 2, 4, …), and keyOdd
 is used if i is an odd number (1, 3, 5, …).
 Otherwise, copy input[i] to output[i].

(3) The steps for decrypting the cipher text are as follows:
 (i) For each character input[i] ( i: 0, 1, … , textLen - 1), repeat (ii).
 (ii) If input[i] is an alphabetical character (“A” - “Z” or “a” - “z”), find an alphabetical
 character keyEven or keyOdd position up the alphabet from input[i], and store it
 into output[i]. Here, keyEven is used if i is an even number (0, 2, 4, …), and keyOdd
 is used if i is an odd number (1, 3, 5, …).
 Otherwise, copy input[i] to output[i].

(4) Characters are represented by ASCII; alphabetical characters “A” - “Z” have consecutive
 internal codes 65 - 90, and “a” - “z” have consecutive internal codes 97 - 122.

(5) The “%” operator indicates a remainder operation. In this question, it is assumed that
 the sign of the non-zero remainder is the same as that of the left-hand operand.
 For example, 2 % 26 = 2, 30 % 26 = 4, (-2) % 26 = -2, and (-30) % 26 = -4.

(6) Sample input and output examples:

 Function called Input output

 input[] keyEven keyOdd output[]
 Encrypt “ABCxyz” 2 2 “CDEzab”
 Encrypt “ABCxyz” 2 3 “CEEaac”
 Encrypt “non=no(on)” 3 2 “____A____”
 Decrypt “CDEzab” 2 2 “ABCxyz”
 Decrypt “CEEaac” 2 3 “ABCxyz”
 Decrypt “____B____” 3 2 “f(x)=x+1”

 - 25 -

[Program]

 FUNCTION: Encrypt(CHAR: input[], CHAR: output[],
 INT: textLen, INT: keyEven, INT: keyOdd) {
 INT: i, key

 FOR (i  0; i < textLen; i  i + 1) {
 IF (____C____ )
 key  keyEven;
 ELSE
 key  keyOdd;
 IF (input[i] ≥ ''A'' and input[i] ≤ ''Z'')
 output[i]  ____D1____;
 ELSE {
 IF (input[i] ≥ ''a'' and input[i] ≤ ''z'')
 output[i]  ____D2____ ;
 ELSE
 output[i]  input[i];
 }
 }
 }

 FUNCTION: Decrypt(CHAR: input[], CHAR: output[],
 INT: textLen, INT: keyEven, INT: keyOdd) {
 INT: i, key

 FOR (i  0; i < textLen; i  i + 1) {
 IF (____C____ )
 key  keyEven;
 ELSE
 key  keyOdd;
 IF (input[i] ≥ ''A'' and input[i] ≤ ''Z'')
 output[i]  ____E1____;
 ELSE {
 IF (input[i] ≥ ''a'' and input[i] ≤ ''z'')
 output[i]  ____E2____ ;
 ELSE
 output[i]  input[i];
 }
 }
 }

 - 26 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above description and the program.
 Here, the answers to be inserted in D1 and D2 should be selected as the correct combination
 from the answer group for D, and the answers to be inserted in E1 and E2 should be selected
 as the correct combination from the answer group for E.

 Answer group for A
 a) pqp=pq(qp) b) prp=pr(rp)
 c) prp=rp(pr) d) qqq=qq(qq)

 Answer group for B
 a) h(z)=a+1 b) h(z)=z+3
 c) i(a)=a+4 d) i(a)=z+1

 Answer group for C
 a) i % 2 = 0 b) i % 2 = 1
 c) input[i] = 0 d) input[i] = 1

 Answer group for D
 D1 D2
 a) ''A'' + (input[i] - ''A'' + key - 26) % 26 ''a'' + (input[i] - ''a'' + key - 26) % 26
 b) ''A'' + (input[i] - ''A'' + key) % 26 ''a'' + (input[i] - ''a'' + key) % 26
 c) ''A'' + (input[i] - ''A'' - key + 26) % 26 ''a'' + (input[i] - ''a'' - key + 26) % 26
 d) ''A'' + (input[i] - ''A'' - key) % 26 ''a'' + (input[i] - ''a'' - key) % 26
 e) (input[i] + key) % 26 (input[i] + key) % 26
 f) (input[i] - key) % 26 (input[i] - key) % 26

 Answer group for E
 E1 E2
 a) ''A'' + (input[i] - ''A'' + key - 26) % 26 ''a'' + (input[i] - ''a'' + key - 26) % 26
 b) ''A'' + (input[i] - ''A'' + key) % 26 ''a'' + (input[i] - ''a'' + key) % 26
 c) ''A'' + (input[i] - ''A'' - key + 26) % 26 ''a'' + (input[i] - ''a'' - key + 26) % 26
 d) ''A'' + (input[i] - ''A'' - key) % 26 ''a'' + (input[i] - ''a'' - key) % 26
 e) (input[i] + key) % 26 (input[i] + key) % 26
 f) (input[i] - key) % 26 (input[i] - key) % 26

 - 27 -

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description.

 The algorithms and codes used in the functions Encrypt and Decrypt are very similar.
 Therefore, the function Encrypt can perform the decryption operation if the arguments are
 given appropriately.

 Consider a case where a main program calls the function Decrypt using the following
 statement. Here, keyEven and keyOdd values satisfy the condition described in (1) (iii).

 Decrypt(input, output, textLen, keyEven, keyOdd);
 If this statement is replaced by the following statement:

 Encrypt(input, output, textLen, 26 - keyEven, 26 - keyOdd);
 then decryption can be done by the function Encrypt in most cases. However, there is a
 problem that the values of the 4th and/or 5th arguments do not satisfy the condition described
 in (1) (iii) when the values of keyEven and/or keyOdd are ____F____.

 Moreover, to facilitate a user’s convenience, the function Encrypt is to be modified so that
 it can accept any keyEven and keyOdd values.
 Concretely, the following sequence of the statements are added to the function Encrypt
 immediately before the FOR loop. These statements convert any given keyEven and keyOdd
 values into the prescribed keyEven and keyOdd values that range between 0 and 25.

 /* Converts any keyEven value into the prescribed range between 0 and 25. */
 ___G___
 /* Converts any keyOdd value into the prescribed range between 0 and 25. */
 ___X___ // Note: Shaded parts are not shown.

 Here, the sequence of the statements ____G____ can be replaced by the following
 assignment statement:

 keyEven  ____H____;

 - 28 -

Answer group for F
 a) 0 b) 0 or 25
 c) 25 d) not 0

Answer group for G
 a) IF (keyEven < 0)
 keyEven  - keyEven;
 keyEven  keyEven % 26;

 b) IF (keyEven < 0)
 keyEven  keyEven + 26;
 keyEven  keyEven % 26;
 c) keyEven  keyEven % 26;
 IF (keyEven < 0)
 keyEven  - keyEven;
 d) keyEven  keyEven % 26;
 IF (keyEven < 0)
 keyEven  keyEven + 26;

Answer group for H
 a) ((- keyEven % 26) + 26) % 26 b) ((keyEven % 26) + 26) % 26
 c) (- keyEven % 26) + 26 d) (26 - keyEven) % 26

 - 29 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/b/questions.pdf","pages":[24,25,26,27,28,29]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'B',
  7,
  'Q7. Read the following description of a C program, and then answer Subquestions 1 and 2.

The number of dots composing an equilateral (regular) triangle with N dots on a side is called
 an N-th triangular number (TN). For example, 10 is the 4th triangular number because 10
 dots can form an equilateral triangle with 4 dots on each side. Figure 1 shows examples of
 triangular numbers.

○
 ○ ○○
 ○ ○○ ○○○
 ○ ○○ ○○○ ○○○○
 T1 = 1 T2 = 3 T3 = 6 T4 = 10

Figure 1 Examples of triangular numbers

The sum of two consecutive triangular numbers TN-1 + TN is known to be N2. For example,
 T3 + T4 = 16, which is 42.

[Program Description]
 For given input value of N (1 ≤ N ≤ 1000), the program draws a triangle using the characters
 ''O'' and '' '' (space character) and determines the triangular number by counting the number
 of ''O''s in the triangle. For TN where N ≥ 2, it also draws the previous triangle and determines
 its triangular number, and checks if their summation equals to N2.
 Table 1 shows the triangles drawn by the program for the first four triangles. In Table 1, the
 character ''.'' indicates a space character.

Table 1 Triangles drawn by the program

N TN Triangle drawn by the program
 1 1 O.
 2 3 .O.
 O.O.
 3 6 ..O.
 .O.O.
 O.O.O.
 4 10 ...O.
 ..O.O.
 .O.O.O.
 O.O.O.O.

- 30 -

The program outputs the following result for the input value 1.

Input value for generating a triangular number: 1
 O
 T(1) = 1

The program outputs the following result for the input value 3.

Input value for generating a triangular number: 3
 O
 O O
 O O O
 T(3) = 6

The previous triangle
 O
 O O
 T(2) = 3

T(2) + T(3) = 3 ^ 2
 Square property held

Table 2 shows the description of the functions used in the program.

Table 2 Functions used in the program

Function Function Description
 int DrawTriangle(int n) Draws an equilateral triangle with n dots on a side
 and prints the n-th triangular number.
 void PrintSpace(int n) Prints n space characters.',
  '[{"type":"prompt","text":"Q7. Read the following description of a C program, and then answer Subquestions 1 and 2."},{"type":"context","text":"The number of dots composing an equilateral (regular) triangle with N dots on a side is called\n an N-th triangular number (TN). For example, 10 is the 4th triangular number because 10\n dots can form an equilateral triangle with 4 dots on each side. Figure 1 shows examples of\n triangular numbers.\n\n○\n ○ ○○\n ○ ○○ ○○○\n ○ ○○ ○○○ ○○○○\n T1 = 1 T2 = 3 T3 = 6 T4 = 10\n\nFigure 1 Examples of triangular numbers\n\nThe sum of two consecutive triangular numbers TN-1 + TN is known to be N2. For example,\n T3 + T4 = 16, which is 42.\n\n[Program Description]\n For given input value of N (1 ≤ N ≤ 1000), the program draws a triangle using the characters\n ''O'' and '' '' (space character) and determines the triangular number by counting the number\n of ''O''s in the triangle. For TN where N ≥ 2, it also draws the previous triangle and determines\n its triangular number, and checks if their summation equals to N2.\n Table 1 shows the triangles drawn by the program for the first four triangles. In Table 1, the\n character ''.'' indicates a space character.\n\nTable 1 Triangles drawn by the program\n\nN TN Triangle drawn by the program\n 1 1 O.\n 2 3 .O.\n O.O.\n 3 6 ..O.\n .O.O.\n O.O.O.\n 4 10 ...O.\n ..O.O.\n .O.O.O.\n O.O.O.O.\n\n- 30 -\n\nThe program outputs the following result for the input value 1.\n\nInput value for generating a triangular number: 1\n O\n T(1) = 1\n\nThe program outputs the following result for the input value 3.\n\nInput value for generating a triangular number: 3\n O\n O O\n O O O\n T(3) = 6\n\nThe previous triangle\n O\n O O\n T(2) = 3\n\nT(2) + T(3) = 3 ^ 2\n Square property held\n\nTable 2 shows the description of the functions used in the program.\n\nTable 2 Functions used in the program\n\nFunction Function Description\n int DrawTriangle(int n) Draws an equilateral triangle with n dots on a side\n and prints the n-th triangular number.\n void PrintSpace(int n) Prints n space characters."}]'::jsonb,
  '["2021-october-b-q07-figure1.webp"]'::jsonb,
  '[{"label":"a","text":"T(2) + T(3) = 3 ^ 2"},{"label":"b","text":"T(2) + T(3) = 9"},{"label":"c","text":"T(2) + T(3) = S(3)"},{"label":"d","text":"T(3) + T(2) = 3 ^ 2"},{"label":"e","text":"T(3) + T(2) = 9"},{"label":"f","text":"T(3) + T(2) = S(3)\n\n - 35 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "a"}, {"subquestion": 1, "blank": "B", "answer": "c"}, {"subquestion": 1, "blank": "C", "answer": "b"}, {"subquestion": 1, "blank": "D", "answer": "d"}, {"subquestion": 1, "blank": "E", "answer": "c"}, {"subquestion": 2, "blank": "F", "answer": "b"}, {"subquestion": 2, "blank": "G", "answer": "c"}, {"subquestion": 2, "blank": "H", "answer": "c"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"a"},{"subquestion":1,"blank":"B","answer":"c"},{"subquestion":1,"blank":"C","answer":"b"},{"subquestion":1,"blank":"D","answer":"d"},{"subquestion":1,"blank":"E","answer":"c"},{"subquestion":2,"blank":"F","answer":"b"},{"subquestion":2,"blank":"G","answer":"c"},{"subquestion":2,"blank":"H","answer":"c"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-B, Q7)',
  ARRAY[30,31,32,33,34,35]::int[],
  'native_text',
  '3.0',
  'Q7. Read the following description of a C program, and then answer Subquestions 1 and 2.

 The number of dots composing an equilateral (regular) triangle with N dots on a side is called
 an N-th triangular number (TN). For example, 10 is the 4th triangular number because 10
 dots can form an equilateral triangle with 4 dots on each side. Figure 1 shows examples of
 triangular numbers.

 ○
 ○ ○○
 ○ ○○ ○○○
 ○ ○○ ○○○ ○○○○
 T1 = 1 T2 = 3 T3 = 6 T4 = 10

 Figure 1 Examples of triangular numbers

 The sum of two consecutive triangular numbers TN-1 + TN is known to be N2. For example,
 T3 + T4 = 16, which is 42.

 [Program Description]
 For given input value of N (1 ≤ N ≤ 1000), the program draws a triangle using the characters
 ''O'' and '' '' (space character) and determines the triangular number by counting the number
 of ''O''s in the triangle. For TN where N ≥ 2, it also draws the previous triangle and determines
 its triangular number, and checks if their summation equals to N2.
 Table 1 shows the triangles drawn by the program for the first four triangles. In Table 1, the
 character ''.'' indicates a space character.

 Table 1 Triangles drawn by the program

 N TN Triangle drawn by the program
 1 1 O.
 2 3 .O.
 O.O.
 3 6 ..O.
 .O.O.
 O.O.O.
 4 10 ...O.
 ..O.O.
 .O.O.O.
 O.O.O.O.

 - 30 -

The program outputs the following result for the input value 1.

 Input value for generating a triangular number: 1
 O
 T(1) = 1

The program outputs the following result for the input value 3.

 Input value for generating a triangular number: 3
 O
 O O
 O O O
 T(3) = 6

 The previous triangle
 O
 O O
 T(2) = 3

 T(2) + T(3) = 3 ^ 2
 Square property held

Table 2 shows the description of the functions used in the program.

 Table 2 Functions used in the program

 Function Function Description
 int DrawTriangle(int n) Draws an equilateral triangle with n dots on a side
 and prints the n-th triangular number.
 void PrintSpace(int n) Prints n space characters.

[Program]

 #include <stdio.h>

 int DrawTriangle(int n);
 void PrintSpace(int n); // α

 - 31 -

int main() {
 int N, S, Ta, Tb;

 printf("Input value for generating a triangular number: ");
 scanf("%d", &N);
 Ta = DrawTriangle(____A____);
 if (N > 1) {
 printf("The previous triangle\n");
 Tb = DrawTriangle(____B____);
 S = N * N; // β
 if (____C____) {
 printf("T(%d) + T(%d) = %d ^ 2\n", N - 1, N, N); // γ
 printf("Square property held\n");
 } else {
 printf("Square property not held\n");
 }
 printf("\n");
 }
 return 0;
}

int DrawTriangle(int n) {
 int i, j, result = 0;

 for (i = 1; i <= n; i++) {
 PrintSpace(____D____ );
 for (j = 1; ____E____ ; j++) {
 printf("O ");
 result++;
 }
 printf("\n");
 }
 printf("T(%d) = %d\n\n", n, result);
 return result;
}

void PrintSpace(int n) {
 int i;

 for (i = 1; i <= n; i++) {
 printf(" ");
 }
}

 - 32 -

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above program.

 Answer group for A and B
 a) N b) N + 1 c) N – 1 d) Ta e) Ta - 1

 Answer group for C
 a) N > 2 b) Ta + Tb == S
 c) Ta == S + Tb d) Tb == S + Ta

 Answer group for D
 a) i b) i - 1 c) n - 1
 d) n - i e) n – i + 1

 Answer group for E
 a) j < i b) j < i - 1 c) j <= i d) j <= i + 1

Subquestion 2
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the following description. It is assumed that the correct answer in Subquestion
 1 is inserted in ___E___.

 The number of dots composing a square with N dots on a side is called N-th square number
 (SN). Figure 2 shows examples of square numbers.

 ○○○○
 ○○○ ○○○○
 ○○ ○○○ ○○○○
 ○ ○○ ○○○ ○○○○
 S1 = 1 S2 = 4 S3 = 9 S4 = 16

 Figure 2 Examples of square numbers

 Using the square number, the property of two consecutive triangular numbers can be
 expressed by the formula TN-1 + TN = SN.

 - 33 -

A new function is to be added so that the program also draws a square using the characters
''O'', ''*'', and ''_'' (space character), and determines the square number by counting the
number of ''O''s and ''*''s in the square.
The square with N dots on a side consists of two triangles; the triangle with N dots on a side
(drawn with ''O''s) and the triangle with N - 1 dots on a side (drawn with ''*''s).
Table 3 shows the description of the new function added to the program.

 Table 3 New function added to the program

 Function Function Description
 int DrawSquare(int n) Draws a square with n dots on a side
 and prints the n-th square number.

Concretely, the program is to be modified as follows:
(1) Immediately after the line designated by α, insert the following line.
 int DrawSquare(int n);

(2) Replace the line designated by β with the following two lines.
 printf("The square number\n");
 S = DrawSquare(N);

(3) Replace the line designated by γ with the following line.
 printf("T(%d) + T(%d) = S(%d)\n", N - 1, N, N);

(4) After the last line of the program, insert the following new function.

 int DrawSquare(int n) {
 int i, j, result = 0;

 for (i = 1; i <= n; i++) {
 for (j = 1; ____E____ ; j++) {
 printf("O ");
 result++;
 }
 for (j = ____F____; j <= n; j++) {
 printf("* ");
 result++;
 }
 printf("\n");
 }
 printf("S(%d) = %d\n\n", n, result);
 return result;
 }

 - 34 -

After the modification, the program outputs the following result for the input value 3.

 Input value for generating a triangular number: 3
 O
 O O
 O O O
 T(3) = 6

 The previous triangle
 O
 O O
 T(2) = 3

 The square number
 _G_
 S(3) = 9

 ____H____
 Square property held

Answer group for F
 a) i b) i + 1 c) i - 1 d) n - i

Answer group for G
 a) * * O b) * O O c) O * * d) O O *
 * O O * * O O O * O * *
 O O O * * * O O O * * *

Answer group for H
 a) T(2) + T(3) = 3 ^ 2 b) T(2) + T(3) = 9
 c) T(2) + T(3) = S(3) d) T(3) + T(2) = 3 ^ 2
 e) T(3) + T(2) = 9 f) T(3) + T(2) = S(3)

 - 35 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/b/questions.pdf","pages":[30,31,32,33,34,35]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/b/answers.pdf","pages":[1]}}'::jsonb,
  true
),
(
  '2021-october',
  'B',
  8,
  'Q8. Read the following description of Java programs, and then answer Subquestions 1 and 2.

[Program Description]
 This is a calculator program that performs addition, subtraction, multiplication, and division
 of integer values. The calculator has digit keys, arithmetic operation keys for addition,
 subtraction, multiplication, and division, an equal key, and a clear key. When a key is pressed,
 the program executes the process corresponding to that key. Numbers etc. are displayed by
 calling System.out.println.

(1) The interface key defines the method that executes the process when a calculator key is
 pressed.
 The method operateOn executes the process corresponding to the key with respect to
 the instance of the class java.util.Stack (hereinafter, stack) given by the parameter.
 The class Stack supports the method peek that returns the object at the top of the stack
 without removing it from the stack, in addition to the methods push and pop. The
 method clear removes all the objects from the stack.

(2) The enumeration DigitKey defines the constants DIGIT0 through DIGIT9 that represent
 the digit keys.
 The method operateOn processes the keys as an input of decimal numbers. The value
 stored at the top of the stack given by the stack parameter is 0 (initial value) or the
 numeric value that has been entered. The method updates this value.

(3) The enumeration OperationKey defines the constants ADD, SUBTRACT, MULTIPLY,
 DIVIDE, EQUAL, and CLEAR that represent the respective arithmetic operation keys for
 addition, subtraction, multiplication, and division, the equal key, and the clear key.
 The method operateOn executes the corresponding arithmetic operation with respect
 to the values on the stack.
 Each of the constants, except for EQUAL and CLEAR, defines its operation using the
 functional interface java.util.function.BinaryOperator<T>. Its method apply
 takes two parameters and returns the result of the operation. The type of the parameters
 and the return value is specified by type T.

(4) The class Calculator represents the calculator unit. The field stack holds the stack
 that represents the status of numerical values inside the calculator. The field
 pendingKey holds an arithmetic operation key until the input of numerical values
 required for the arithmetic operation is completed. Moreover, it holds the equal key
 when the equal key is pressed.

- 36 -

For example, when the constants of the keys DIGIT2, ADD, and DIGIT4 are processed in
 sequence, the values stored on the stack are 4 and 2 from the top, and the value of
 pendingKey is ADD. When the constant of the key EQUAL is processed next, the addition
 process of the arithmetic operation key ADD is executed. Then, the value stored on the
 stack becomes 6, and the value of pendingKey becomes EQUAL. Here, the results of the
 arithmetic operations with respect to two numerical values follow the results of int type
 arithmetic operations of Java.
 The method onKeyPressed is called when a calculator key is pressed. The key pressed
 is given by the parameter. A process is executed on the basis of the key pressed and the
 internal status of the calculator.

(5) The class CalculatorTest is a program for testing the class Calculator.
 First, the method main creates the mappings between characters and their corresponding
 key constants; it creates an instance of the class Calculator. Next, it converts each
 character in the string given by the parameter into its corresponding key constant. It
 then calls the method onKeyPressed of the Calculator instance with the converted
 key constant. For example, when a string “2*3=” is given by the parameter of the
 method main, each character is converted into its corresponding key constant, and the
 given string is converted into a sequence of the key constants DIGIT2, MULTIPLY,
 DIGIT3, and EQUAL, and the method onKeyPressed is called. Figure 1 shows the output
 when the method main is executed.

DIGIT2
 2
 MULTIPLY
 2
 DIGIT3
 3
 EQUAL
 6

Figure 1 Output when the method main is executed

[Program 1]
 import java.util.Stack;

public interface Key {
 public void operateOn(Stack<Integer> stack);
 }

- 37 -

[Program 2]
 import java.util.Stack;

enum DigitKey ***A*** Key {
 DIGIT0, DIGIT1, DIGIT2, DIGIT3, DIGIT4,
 DIGIT5, DIGIT6, DIGIT7, DIGIT8, DIGIT9;

public void operateOn(Stack<Integer> stack) {
 stack.push(***B*** * 10 + ***C***);
 }
 }

[Program 3]
 import java.util.Stack;
 import java.util.function.BinaryOperator;

enum OperationKey ***A*** Key {

ADD((val1, val2) -> val1 + val2),

SUBTRACT((val1, val2) -> val1 - val2),

MULTIPLY((val1, val2) -> val1 * val2),

DIVIDE((val1, val2) -> val1 / val2),

EQUAL(null),

CLEAR(null);

private final BinaryOperator<Integer> operator;

OperationKey(BinaryOperator<Integer> operator) {

this.operator = operator;
 }

public void operateOn(Stack<Integer> stack) {
 if (***D*** ) {
 Integer val2 = stack.pop();
 Integer val1 = stack.pop();
 stack.push(operator.apply(val1, val2));
 }
 }
 }

- 38 -

[Program 4]
 import java.util.Stack;

public class Calculator {
 private final Stack<Integer> stack = new Stack<>();
 private Key pendingKey;

public Calculator() {
 stack.push(0);
 }

public void onKeyPressed(Key key) {
 System.out.println(key);
 if (key instanceof DigitKey) {
 if (pendingKey == OperationKey.EQUAL) {
 reset();
 }
 key.operateOn(stack);
 System.out.println(stack.peek());
 } else if (key == OperationKey.CLEAR) {
 reset();
 System.out.println(stack.peek());
 } else {
 try {
 if (pendingKey != null) {
 pendingKey.operateOn(stack);
 }
 System.out.println(stack.peek());
 pendingKey = key;
 if (key != OperationKey.EQUAL) {
 stack.push(0);
 }
 } catch (ArithmeticException e) {
 System.out.println("Error");
 reset();
 }
 }
 }

private void reset() {
 stack.clear();
 stack.push(0);
 pendingKey = null;
 }
 }

- 39 -

[Program 5]
 import java.util.HashMap;
 import java.util.Map;

public class CalculatorTest {
 public static void main(String[] args) {
 Map<Character, ***E***> map = new HashMap<>();

// Store the relation between characters and constants of OperationKey into map.
 for (OperationKey key : OperationKey.values()) {
 map.put("+-*/=C".charAt(key.ordinal()), key);
 }

// Store the relation between numbers and constants of DigitKey into map.
 for (DigitKey key : DigitKey.values()) {
 map.put("0123456789".charAt(key.ordinal()), key);
 }

Calculator calc = new Calculator();
 String chars = args[0];
 // Convert each char. of chars into the constant of the key, and call onKeyPressed.
 for (int i = 0; i < chars.length(); i++) {
 calc.onKeyPressed(map.get(chars.charAt(i)));
 }
 }
 }

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above programs.

Answer group for A
 a) extends b) implements c) imports
 d) inherits e) requires f) throws

Answer group for B and C
 a) ordinal() b) stack.peek()
 c) stack.pop() d) stack.push(0)
 e) stack.push(ordinal()) f) values()

- 40 -

Answer group for D
 a) operator != null b) operator == null c) stack != null
 d) stack == null e) this != operator f) this == operator

Answer group for E
 a) Calculator b) Character c) DigitKey
 d) Integer e) Key f) OperationKey

Subquestion 2
 Table 1 shows the last row of output (in case of Figure 1, it is 6) when the method main is
 executed with a string as the parameter. From the answer group below, select the correct
 answer to be inserted in each blank _______ in Table 1. Here, assume that the correct
 answers are filled in all blanks _______ in the programs.

Table 1 Character string (parameter) and output (last row)

Character string (parameter) Output (last row)

2*6/3= 4

-2= -2

2*4== ***F***

2*4C2= ***G***

8/2/= ***H***',
  '[{"type":"prompt","text":"Q8. Read the following description of Java programs, and then answer Subquestions 1 and 2."},{"type":"context","text":"[Program Description]\n This is a calculator program that performs addition, subtraction, multiplication, and division\n of integer values. The calculator has digit keys, arithmetic operation keys for addition,\n subtraction, multiplication, and division, an equal key, and a clear key. When a key is pressed,\n the program executes the process corresponding to that key. Numbers etc. are displayed by\n calling System.out.println.\n\n(1) The interface key defines the method that executes the process when a calculator key is\n pressed.\n The method operateOn executes the process corresponding to the key with respect to\n the instance of the class java.util.Stack (hereinafter, stack) given by the parameter.\n The class Stack supports the method peek that returns the object at the top of the stack\n without removing it from the stack, in addition to the methods push and pop. The\n method clear removes all the objects from the stack.\n\n(2) The enumeration DigitKey defines the constants DIGIT0 through DIGIT9 that represent\n the digit keys.\n The method operateOn processes the keys as an input of decimal numbers. The value\n stored at the top of the stack given by the stack parameter is 0 (initial value) or the\n numeric value that has been entered. The method updates this value.\n\n(3) The enumeration OperationKey defines the constants ADD, SUBTRACT, MULTIPLY,\n DIVIDE, EQUAL, and CLEAR that represent the respective arithmetic operation keys for\n addition, subtraction, multiplication, and division, the equal key, and the clear key.\n The method operateOn executes the corresponding arithmetic operation with respect\n to the values on the stack.\n Each of the constants, except for EQUAL and CLEAR, defines its operation using the\n functional interface java.util.function.BinaryOperator<T>. Its method apply\n takes two parameters and returns the result of the operation. The type of the parameters\n and the return value is specified by type T.\n\n(4) The class Calculator represents the calculator unit. The field stack holds the stack\n that represents the status of numerical values inside the calculator. The field\n pendingKey holds an arithmetic operation key until the input of numerical values\n required for the arithmetic operation is completed. Moreover, it holds the equal key\n when the equal key is pressed.\n\n- 36 -\n\nFor example, when the constants of the keys DIGIT2, ADD, and DIGIT4 are processed in\n sequence, the values stored on the stack are 4 and 2 from the top, and the value of\n pendingKey is ADD. When the constant of the key EQUAL is processed next, the addition\n process of the arithmetic operation key ADD is executed. Then, the value stored on the\n stack becomes 6, and the value of pendingKey becomes EQUAL. Here, the results of the\n arithmetic operations with respect to two numerical values follow the results of int type\n arithmetic operations of Java.\n The method onKeyPressed is called when a calculator key is pressed. The key pressed\n is given by the parameter. A process is executed on the basis of the key pressed and the\n internal status of the calculator.\n\n(5) The class CalculatorTest is a program for testing the class Calculator.\n First, the method main creates the mappings between characters and their corresponding\n key constants; it creates an instance of the class Calculator. Next, it converts each\n character in the string given by the parameter into its corresponding key constant. It\n then calls the method onKeyPressed of the Calculator instance with the converted\n key constant. For example, when a string “2*3=” is given by the parameter of the\n method main, each character is converted into its corresponding key constant, and the\n given string is converted into a sequence of the key constants DIGIT2, MULTIPLY,\n DIGIT3, and EQUAL, and the method onKeyPressed is called. Figure 1 shows the output\n when the method main is executed.\n\nDIGIT2\n 2\n MULTIPLY\n 2\n DIGIT3\n 3\n EQUAL\n 6\n\nFigure 1 Output when the method main is executed\n\n[Program 1]\n import java.util.Stack;\n\npublic interface Key {\n public void operateOn(Stack<Integer> stack);\n }\n\n- 37 -\n\n[Program 2]\n import java.util.Stack;\n\nenum DigitKey ***A*** Key {\n DIGIT0, DIGIT1, DIGIT2, DIGIT3, DIGIT4,\n DIGIT5, DIGIT6, DIGIT7, DIGIT8, DIGIT9;\n\npublic void operateOn(Stack<Integer> stack) {\n stack.push(***B*** * 10 + ***C***);\n }\n }\n\n[Program 3]\n import java.util.Stack;\n import java.util.function.BinaryOperator;\n\nenum OperationKey ***A*** Key {\n\nADD((val1, val2) -> val1 + val2),\n\nSUBTRACT((val1, val2) -> val1 - val2),\n\nMULTIPLY((val1, val2) -> val1 * val2),\n\nDIVIDE((val1, val2) -> val1 / val2),\n\nEQUAL(null),\n\nCLEAR(null);\n\nprivate final BinaryOperator<Integer> operator;\n\nOperationKey(BinaryOperator<Integer> operator) {\n\nthis.operator = operator;\n }\n\npublic void operateOn(Stack<Integer> stack) {\n if (***D*** ) {\n Integer val2 = stack.pop();\n Integer val1 = stack.pop();\n stack.push(operator.apply(val1, val2));\n }\n }\n }\n\n- 38 -\n\n[Program 4]\n import java.util.Stack;\n\npublic class Calculator {\n private final Stack<Integer> stack = new Stack<>();\n private Key pendingKey;\n\npublic Calculator() {\n stack.push(0);\n }\n\npublic void onKeyPressed(Key key) {\n System.out.println(key);\n if (key instanceof DigitKey) {\n if (pendingKey == OperationKey.EQUAL) {\n reset();\n }\n key.operateOn(stack);\n System.out.println(stack.peek());\n } else if (key == OperationKey.CLEAR) {\n reset();\n System.out.println(stack.peek());\n } else {\n try {\n if (pendingKey != null) {\n pendingKey.operateOn(stack);\n }\n System.out.println(stack.peek());\n pendingKey = key;\n if (key != OperationKey.EQUAL) {\n stack.push(0);\n }\n } catch (ArithmeticException e) {\n System.out.println(\"Error\");\n reset();\n }\n }\n }\n\nprivate void reset() {\n stack.clear();\n stack.push(0);\n pendingKey = null;\n }\n }\n\n- 39 -\n\n[Program 5]\n import java.util.HashMap;\n import java.util.Map;\n\npublic class CalculatorTest {\n public static void main(String[] args) {\n Map<Character, ***E***> map = new HashMap<>();\n\n// Store the relation between characters and constants of OperationKey into map.\n for (OperationKey key : OperationKey.values()) {\n map.put(\"+-*/=C\".charAt(key.ordinal()), key);\n }\n\n// Store the relation between numbers and constants of DigitKey into map.\n for (DigitKey key : DigitKey.values()) {\n map.put(\"0123456789\".charAt(key.ordinal()), key);\n }\n\nCalculator calc = new Calculator();\n String chars = args[0];\n // Convert each char. of chars into the constant of the key, and call onKeyPressed.\n for (int i = 0; i < chars.length(); i++) {\n calc.onKeyPressed(map.get(chars.charAt(i)));\n }\n }\n }\n\nSubquestion 1\n From the answer groups below, select the correct answer to be inserted in each blank\n _______ in the above programs.\n\nAnswer group for A\n a) extends b) implements c) imports\n d) inherits e) requires f) throws\n\nAnswer group for B and C\n a) ordinal() b) stack.peek()\n c) stack.pop() d) stack.push(0)\n e) stack.push(ordinal()) f) values()\n\n- 40 -\n\nAnswer group for D\n a) operator != null b) operator == null c) stack != null\n d) stack == null e) this != operator f) this == operator\n\nAnswer group for E\n a) Calculator b) Character c) DigitKey\n d) Integer e) Key f) OperationKey\n\nSubquestion 2\n Table 1 shows the last row of output (in case of Figure 1, it is 6) when the method main is\n executed with a string as the parameter. From the answer group below, select the correct\n answer to be inserted in each blank _______ in Table 1. Here, assume that the correct\n answers are filled in all blanks _______ in the programs.\n\nTable 1 Character string (parameter) and output (last row)\n\nCharacter string (parameter) Output (last row)\n\n2*6/3= 4\n\n-2= -2\n\n2*4== ***F***\n\n2*4C2= ***G***\n\n8/2/= ***H***"}]'::jsonb,
  '[]'::jsonb,
  '[{"label":"a","text":"0"},{"label":"b","text":"2"},{"label":"c","text":"4"},{"label":"d","text":"8"},{"label":"e","text":"16"},{"label":"f","text":"32"},{"label":"g","text":"64"},{"label":"h","text":"ArithmeticException"},{"label":"i","text":"Error\n\n_ _\nCompany names and product names appearing in the test questions are trademarks or registered\ntrademarks of their respective companies. Note that the ® and ™ symbols are not used within the text.\n\n - 41 -"}]'::jsonb,
  '[{"subquestion": 1, "blank": "A", "answer": "b"}, {"subquestion": 1, "blank": "B", "answer": "c"}, {"subquestion": 1, "blank": "C", "answer": "a"}, {"subquestion": 1, "blank": "D", "answer": "a"}, {"subquestion": 1, "blank": "E", "answer": "e"}, {"subquestion": 2, "blank": "F", "answer": "d"}, {"subquestion": 2, "blank": "G", "answer": "b"}, {"subquestion": 2, "blank": "H", "answer": "i"}]',
  '{"parts":[{"subquestion":1,"blank":"A","answer":"b"},{"subquestion":1,"blank":"B","answer":"c"},{"subquestion":1,"blank":"C","answer":"a"},{"subquestion":1,"blank":"D","answer":"a"},{"subquestion":1,"blank":"E","answer":"e"},{"subquestion":2,"blank":"F","answer":"d"},{"subquestion":2,"blank":"G","answer":"b"},{"subquestion":2,"blank":"H","answer":"i"}]}'::jsonb,
  NULL,
  'medium',
  0.5,
  'questions.pdf',
  '(2021A, FE, Subject-B, Q8)',
  ARRAY[36,37,38,39,40,41]::int[],
  'native_text',
  '3.0',
  'Q8. Read the following description of Java programs, and then answer Subquestions 1 and 2.

 [Program Description]
 This is a calculator program that performs addition, subtraction, multiplication, and division
 of integer values. The calculator has digit keys, arithmetic operation keys for addition,
 subtraction, multiplication, and division, an equal key, and a clear key. When a key is pressed,
 the program executes the process corresponding to that key. Numbers etc. are displayed by
 calling System.out.println.

 (1) The interface key defines the method that executes the process when a calculator key is
 pressed.
 The method operateOn executes the process corresponding to the key with respect to
 the instance of the class java.util.Stack (hereinafter, stack) given by the parameter.
 The class Stack supports the method peek that returns the object at the top of the stack
 without removing it from the stack, in addition to the methods push and pop. The
 method clear removes all the objects from the stack.

 (2) The enumeration DigitKey defines the constants DIGIT0 through DIGIT9 that represent
 the digit keys.
 The method operateOn processes the keys as an input of decimal numbers. The value
 stored at the top of the stack given by the stack parameter is 0 (initial value) or the
 numeric value that has been entered. The method updates this value.

 (3) The enumeration OperationKey defines the constants ADD, SUBTRACT, MULTIPLY,
 DIVIDE, EQUAL, and CLEAR that represent the respective arithmetic operation keys for
 addition, subtraction, multiplication, and division, the equal key, and the clear key.
 The method operateOn executes the corresponding arithmetic operation with respect
 to the values on the stack.
 Each of the constants, except for EQUAL and CLEAR, defines its operation using the
 functional interface java.util.function.BinaryOperator<T>. Its method apply
 takes two parameters and returns the result of the operation. The type of the parameters
 and the return value is specified by type T.

 (4) The class Calculator represents the calculator unit. The field stack holds the stack
 that represents the status of numerical values inside the calculator. The field
 pendingKey holds an arithmetic operation key until the input of numerical values
 required for the arithmetic operation is completed. Moreover, it holds the equal key
 when the equal key is pressed.

 - 36 -

For example, when the constants of the keys DIGIT2, ADD, and DIGIT4 are processed in
 sequence, the values stored on the stack are 4 and 2 from the top, and the value of
 pendingKey is ADD. When the constant of the key EQUAL is processed next, the addition
 process of the arithmetic operation key ADD is executed. Then, the value stored on the
 stack becomes 6, and the value of pendingKey becomes EQUAL. Here, the results of the
 arithmetic operations with respect to two numerical values follow the results of int type
 arithmetic operations of Java.
 The method onKeyPressed is called when a calculator key is pressed. The key pressed
 is given by the parameter. A process is executed on the basis of the key pressed and the
 internal status of the calculator.

(5) The class CalculatorTest is a program for testing the class Calculator.
 First, the method main creates the mappings between characters and their corresponding
 key constants; it creates an instance of the class Calculator. Next, it converts each
 character in the string given by the parameter into its corresponding key constant. It
 then calls the method onKeyPressed of the Calculator instance with the converted
 key constant. For example, when a string “2*3=” is given by the parameter of the
 method main, each character is converted into its corresponding key constant, and the
 given string is converted into a sequence of the key constants DIGIT2, MULTIPLY,
 DIGIT3, and EQUAL, and the method onKeyPressed is called. Figure 1 shows the output
 when the method main is executed.

 DIGIT2
 2
 MULTIPLY
 2
 DIGIT3
 3
 EQUAL
 6

 Figure 1 Output when the method main is executed

[Program 1]
 import java.util.Stack;

 public interface Key {
 public void operateOn(Stack<Integer> stack);
 }

 - 37 -

[Program 2]
 import java.util.Stack;

 enum DigitKey ___A___ Key {
 DIGIT0, DIGIT1, DIGIT2, DIGIT3, DIGIT4,
 DIGIT5, DIGIT6, DIGIT7, DIGIT8, DIGIT9;

 public void operateOn(Stack<Integer> stack) {
 stack.push(___B___ * 10 + ___C___);
 }
 }

[Program 3]
 import java.util.Stack;
 import java.util.function.BinaryOperator;

 enum OperationKey ___A___ Key {

 ADD((val1, val2) -> val1 + val2),

 SUBTRACT((val1, val2) -> val1 - val2),

 MULTIPLY((val1, val2) -> val1 * val2),

 DIVIDE((val1, val2) -> val1 / val2),

 EQUAL(null),

 CLEAR(null);

 private final BinaryOperator<Integer> operator;

 OperationKey(BinaryOperator<Integer> operator) {

 this.operator = operator;
 }

 public void operateOn(Stack<Integer> stack) {
 if (___D___ ) {
 Integer val2 = stack.pop();
 Integer val1 = stack.pop();
 stack.push(operator.apply(val1, val2));
 }
 }
 }

 - 38 -

[Program 4]
 import java.util.Stack;

 public class Calculator {
 private final Stack<Integer> stack = new Stack<>();
 private Key pendingKey;

 public Calculator() {
 stack.push(0);
 }

 public void onKeyPressed(Key key) {
 System.out.println(key);
 if (key instanceof DigitKey) {
 if (pendingKey == OperationKey.EQUAL) {
 reset();
 }
 key.operateOn(stack);
 System.out.println(stack.peek());
 } else if (key == OperationKey.CLEAR) {
 reset();
 System.out.println(stack.peek());
 } else {
 try {
 if (pendingKey != null) {
 pendingKey.operateOn(stack);
 }
 System.out.println(stack.peek());
 pendingKey = key;
 if (key != OperationKey.EQUAL) {
 stack.push(0);
 }
 } catch (ArithmeticException e) {
 System.out.println("Error");
 reset();
 }
 }
 }

 private void reset() {
 stack.clear();
 stack.push(0);
 pendingKey = null;
 }
 }

 - 39 -

[Program 5]
 import java.util.HashMap;
 import java.util.Map;

 public class CalculatorTest {
 public static void main(String[] args) {
 Map<Character, ___E___> map = new HashMap<>();

 // Store the relation between characters and constants of OperationKey into map.
 for (OperationKey key : OperationKey.values()) {
 map.put("+-*/=C".charAt(key.ordinal()), key);
 }

 // Store the relation between numbers and constants of DigitKey into map.
 for (DigitKey key : DigitKey.values()) {
 map.put("0123456789".charAt(key.ordinal()), key);
 }

 Calculator calc = new Calculator();
 String chars = args[0];
 // Convert each char. of chars into the constant of the key, and call onKeyPressed.
 for (int i = 0; i < chars.length(); i++) {
 calc.onKeyPressed(map.get(chars.charAt(i)));
 }
 }
 }

Subquestion 1
 From the answer groups below, select the correct answer to be inserted in each blank
 _______ in the above programs.

 Answer group for A
 a) extends b) implements c) imports
 d) inherits e) requires f) throws

 Answer group for B and C
 a) ordinal() b) stack.peek()
 c) stack.pop() d) stack.push(0)
 e) stack.push(ordinal()) f) values()

 - 40 -

Answer group for D
 a) operator != null b) operator == null c) stack != null
 d) stack == null e) this != operator f) this == operator

 Answer group for E
 a) Calculator b) Character c) DigitKey
 d) Integer e) Key f) OperationKey

Subquestion 2
 Table 1 shows the last row of output (in case of Figure 1, it is 6) when the method main is
 executed with a string as the parameter. From the answer group below, select the correct
 answer to be inserted in each blank _______ in Table 1. Here, assume that the correct
 answers are filled in all blanks _______ in the programs.

 Table 1 Character string (parameter) and output (last row)

 Character string (parameter) Output (last row)

 2*6/3= 4

 -2= -2

 2*4== ___F___

 2*4C2= ___G___

 8/2/= ___H___

 Answer group for F through H
 a) 0 b) 2
 c) 4 d) 8
 e) 16 f) 32
 g) 64 h) ArithmeticException
 i) Error

_ _
Company names and product names appearing in the test questions are trademarks or registered
trademarks of their respective companies. Note that the ® and ™ symbols are not used within the text.

 - 41 -',
  '{"question_pdf":{"filename":"questions.pdf","storage_path":"2021-october/b/questions.pdf","pages":[36,37,38,39,40,41]},"answer_pdf":{"filename":"answers.pdf","storage_path":"2021-october/b/answers.pdf","pages":[1]}}'::jsonb,
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
VALUES ('2021-october', 'A', '2021 October FE Subject A', 60, 150, 5, true)
ON CONFLICT (exam_session, subject) DO UPDATE SET
  title = EXCLUDED.title, question_count = EXCLUDED.question_count,
  time_limit_minutes = EXCLUDED.time_limit_minutes, published = EXCLUDED.published;

DELETE FROM exam_questions
WHERE exam_id = (SELECT id FROM exams WHERE exam_session = '2021-october' AND subject = 'A');
INSERT INTO exam_questions (exam_id, question_id, sequence_number)
SELECT e.id, q.id, q.question_number
FROM exams e
JOIN questions q ON q.exam_session = e.exam_session AND q.subject = e.subject
WHERE e.exam_session = '2021-october' AND e.subject = 'A'
ORDER BY q.question_number;

INSERT INTO exams (exam_session, subject, title, question_count, time_limit_minutes, initial_hearts, published)
VALUES ('2021-october', 'B', '2021 October FE Subject B', 8, 150, 5, true)
ON CONFLICT (exam_session, subject) DO UPDATE SET
  title = EXCLUDED.title, question_count = EXCLUDED.question_count,
  time_limit_minutes = EXCLUDED.time_limit_minutes, published = EXCLUDED.published;

DELETE FROM exam_questions
WHERE exam_id = (SELECT id FROM exams WHERE exam_session = '2021-october' AND subject = 'B');
INSERT INTO exam_questions (exam_id, question_id, sequence_number)
SELECT e.id, q.id, q.question_number
FROM exams e
JOIN questions q ON q.exam_session = e.exam_session AND q.subject = e.subject
WHERE e.exam_session = '2021-october' AND e.subject = 'B'
ORDER BY q.question_number;

COMMIT;
