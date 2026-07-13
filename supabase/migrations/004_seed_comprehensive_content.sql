-- 004_seed_comprehensive_content.sql

DO $$
DECLARE
    v_topic_algo UUID;
    v_lesson_algo UUID;
    v_quiz_algo UUID;
    
    v_topic_mgmt UUID;
    v_lesson_mgmt UUID;
    v_quiz_mgmt UUID;
    
    v_topic_math UUID;
    v_lesson_math UUID;
    v_quiz_math UUID;
    
    v_q_id UUID;
BEGIN
    -- ============================================================
    -- 1. ALGORITHMS & DATA STRUCTURES
    -- ============================================================
    INSERT INTO public.topics (title, description)
    VALUES ('Algorithms & Data Structures', 'Efficiency, sorting, searching, and how data is organized.')
    RETURNING id INTO v_topic_algo;

    INSERT INTO public.lessons (topic_id, content)
    VALUES (v_topic_algo, 'Algorithms are step-by-step procedures for calculations. Efficiency is measured using Big O notation, which describes how the runtime or space requirements grow as the input size increases.
    
Common Complexities:
- O(1): Constant time (e.g., accessing an array element by index).
- O(log n): Logarithmic time (e.g., Binary Search).
- O(n): Linear time (e.g., Linear Search).
- O(n log n): Linearithmic time (e.g., Merge Sort, Quick Sort).
- O(n²): Quadratic time (e.g., Bubble Sort, Insertion Sort).

Data Structures:
1. Arrays: Fixed size, fast access by index.
2. Linked Lists: Dynamic size, fast insertion/deletion.
3. Stacks: Last-In-First-Out (LIFO).
4. Queues: First-In-First-Out (FIFO).
5. Trees: Hierarchical structure (e.g., Binary Search Tree).
6. Hash Tables: Key-value pairs with fast average-case lookup.')
    RETURNING id INTO v_lesson_algo;

    INSERT INTO public.quizzes (topic_id, lesson_id)
    VALUES (v_topic_algo, v_lesson_algo)
    RETURNING id INTO v_quiz_algo;

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_algo, 'Which Big O notation represents the worst-case time complexity of Binary Search?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'O(log n)', true), (v_q_id, 'O(n)', false), (v_q_id, 'O(n log n)', false), (v_q_id, 'O(1)', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_algo, 'Which data structure follows the LIFO (Last-In-First-Out) principle?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Stack', true), (v_q_id, 'Queue', false), (v_q_id, 'Linked List', false), (v_q_id, 'Hash Table', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_algo, 'What is the average time complexity of looking up a value in a Hash Table?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'O(1)', true), (v_q_id, 'O(log n)', false), (v_q_id, 'O(n)', false), (v_q_id, 'O(n²)', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_algo, 'Which sorting algorithm has a worst-case time complexity of O(n²)?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Bubble Sort', true), (v_q_id, 'Merge Sort', false), (v_q_id, 'Heap Sort', false), (v_q_id, 'Quick Sort (Average Case)', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_algo, 'Which of these is a characteristic of a Linked List compared to an Array?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Dynamic size', true), (v_q_id, 'Constant time random access', false), (v_q_id, 'Contiguous memory allocation', false), (v_q_id, 'Fixed size', false);


    -- ============================================================
    -- 2. IT MANAGEMENT & STRATEGY
    -- ============================================================
    INSERT INTO public.topics (title, description)
    VALUES ('IT Management', 'Project management, SLAs, and organizational IT standards.')
    RETURNING id INTO v_topic_mgmt;

    INSERT INTO public.lessons (topic_id, content)
    VALUES (v_topic_mgmt, 'IT Management focuses on aligning technology goals with business objectives.
    
Key Concepts:
1. SLA (Service Level Agreement): A formal contract between a service provider and a customer that defines the expected level of service (e.g., 99.9% uptime).
2. ITIL (Information Technology Infrastructure Library): A set of best practices for IT service management (ITSM) to ensure a high-quality service delivery.
3. Project Management:
   - Critical Path Method (CPM): Identifying the longest sequence of dependent tasks to determine the shortest possible project duration.
   - Gantt Chart: A visual timeline used to track project schedules and progress.
4. Risk Management: The process of identifying, assessing, and mitigating potential threats to a project.')
    RETURNING id INTO v_lesson_mgmt;

    INSERT INTO public.quizzes (topic_id, lesson_id)
    VALUES (v_topic_mgmt, v_lesson_mgmt)
    RETURNING id INTO v_quiz_mgmt;

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_mgmt, 'What does SLA stand for in IT Management?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Service Level Agreement', true), (v_q_id, 'System Level Analysis', false), (v_q_id, 'Service Logic Architecture', false), (v_q_id, 'Software Level Agreement', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_mgmt, 'Which tool is used to visualize a project schedule over time?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Gantt Chart', true), (v_q_id, 'ER Diagram', false), (v_q_id, 'UML Class Diagram', false), (v_q_id, 'Flowchart', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_mgmt, 'What is the purpose of the Critical Path Method (CPM)?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'To find the shortest time to complete a project', true), (v_q_id, 'To reduce the project budget', false), (v_q_id, 'To assign roles to developers', false), (v_q_id, 'To document software requirements', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_mgmt, 'Which framework provides a set of best practices for IT Service Management (ITSM)?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'ITIL', true), (v_q_id, 'ISO 9001', false), (v_q_id, 'CMMI', false), (v_q_id, 'COBIT', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_mgmt, 'What is the primary focus of Risk Management?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Identifying and mitigating potential threats', true), (v_q_id, 'Increasing the number of features', false), (v_q_id, 'Writing the user manual', false), (v_q_id, 'Performing unit tests', false);


    -- ============================================================
    -- 3. DISCRETE MATHEMATICS & LOGIC
    -- ============================================================
    INSERT INTO public.topics (title, description)
    VALUES ('Mathematics & Logic', 'Boolean algebra, set theory, and logic gates.')
    RETURNING id INTO v_topic_math;

    INSERT INTO public.lessons (topic_id, content)
    VALUES (v_topic_math, 'Discrete Mathematics is the foundation of computer science.
    
Key Areas:
1. Boolean Algebra: A system of logic where values are either True (1) or False (0).
   - AND: True only if both inputs are True.
   - OR: True if at least one input is True.
   - NOT: Reverses the input value.
2. Logic Gates: Physical implementations of Boolean functions (AND, OR, NOT, XOR, NAND, NOR).
3. Set Theory: Dealing with collections of objects.
   - Union (∪): Elements in either set.
   - Intersection (∩): Elements in both sets.
   - Complement: Elements NOT in the set.
4. Truth Tables: Tables used to determine the output of a logic function for all possible input combinations.')
    RETURNING id INTO v_lesson_math;

    INSERT INTO public.quizzes (topic_id, lesson_id)
    VALUES (v_topic_math, v_lesson_math)
    RETURNING id INTO v_quiz_math;

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_math, 'In Boolean algebra, what is the result of (True AND False)?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'False', true), (v_q_id, 'True', false), (v_q_id, 'Null', false), (v_q_id, 'Undefined', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_math, 'Which logic gate returns True only when both inputs are different?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'XOR', true), (v_q_id, 'AND', false), (v_q_id, 'OR', false), (v_q_id, 'NOR', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_math, 'What does the intersection (∩) of two sets represent?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Elements present in both sets', true), (v_q_id, 'Elements present in either set', false), (v_q_id, 'Elements present in only one set', false), (v_q_id, 'The total number of elements', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_math, 'Which gate is the inverse of the OR gate?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'NOR', true), (v_q_id, 'NAND', false), (v_q_id, 'XOR', false), (v_q_id, 'AND', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_math, 'What is the result of (True OR False)?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'True', true), (v_q_id, 'False', false), (v_q_id, 'Null', false), (v_q_id, 'Undefined', false);

END $$;
