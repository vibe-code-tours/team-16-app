-- 003_seed_more_content.sql

DO $$
DECLARE
    -- Operating Systems
    v_topic_os UUID;
    v_lesson_os UUID;
    v_quiz_os UUID;
    
    -- Networks
    v_topic_net UUID;
    v_lesson_net UUID;
    v_quiz_net UUID;
    
    -- Databases
    v_topic_db UUID;
    v_lesson_db UUID;
    v_quiz_db UUID;
    
    -- Software Engineering
    v_topic_se UUID;
    v_lesson_se UUID;
    v_quiz_se UUID;
    
    -- Security
    v_topic_sec UUID;
    v_lesson_sec UUID;
    v_quiz_sec UUID;

    v_q_id UUID;
BEGIN
    -- ============================================================
    -- 1. OPERATING SYSTEMS
    -- ============================================================
    INSERT INTO public.topics (title, description)
    VALUES ('Operating Systems', 'Understanding how OS manages hardware and software resources.')
    RETURNING id INTO v_topic_os;

    INSERT INTO public.lessons (topic_id, content)
    VALUES (v_topic_os, 'An Operating System (OS) acts as an intermediary between users and computer hardware. 
    Key functions include:
    1. Process Management: The OS schedules which process runs on the CPU using algorithms like First-Come-First-Served (FCFS) or Round Robin.
    2. Memory Management: Using Virtual Memory and Paging to allow programs to be larger than physical RAM.
    3. File System: Organizing data into files and directories.
    4. Deadlock: A situation where two or more processes are unable to proceed because each is waiting for the other to release a resource.')
    RETURNING id INTO v_lesson_os;

    INSERT INTO public.quizzes (topic_id, lesson_id)
    VALUES (v_topic_os, v_lesson_os)
    RETURNING id INTO v_quiz_os;

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_os, 'What is the primary purpose of a CPU scheduler?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'To increase CPU utilization', true), (v_q_id, 'To increase RAM speed', false), (v_q_id, 'To manage disk space', false), (v_q_id, 'To encrypt data', false);
    
    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_os, 'Which of these is a common memory management technique?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Paging', true), (v_q_id, 'Hashing', false), (v_q_id, 'Indexing', false), (v_q_id, 'Caching', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_os, 'What describes a "Deadlock" situation?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Processes waiting for each other in a cycle', true), (v_q_id, 'CPU overheating', false), (v_q_id, 'Network cable disconnected', false), (v_q_id, 'Insufficient RAM', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_os, 'Which scheduling algorithm gives each process a fixed time slice?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Round Robin', true), (v_q_id, 'FCFS', false), (v_q_id, 'Shortest Job First', false), (v_q_id, 'Priority Scheduling', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_os, 'Virtual memory is primarily used to...') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Execute programs larger than physical RAM', true), (v_q_id, 'Increase internet speed', false), (v_q_id, 'Backup data automatically', false), (v_q_id, 'Replace the CPU', false);


    -- ============================================================
    -- 2. COMPUTER NETWORKS
    -- ============================================================
    INSERT INTO public.topics (title, description)
    VALUES ('Computer Networks', 'Basics of data communication, OSI model, and internet protocols.')
    RETURNING id INTO v_topic_net;

    INSERT INTO public.lessons (topic_id, content)
    VALUES (v_topic_net, 'Computer networks allow devices to share resources.
    The OSI Model defines 7 layers:
    - Physical, Data Link, Network (IP), Transport (TCP/UDP), Session, Presentation, Application (HTTP/DNS).
    TCP (Transmission Control Protocol) is connection-oriented and reliable, while UDP (User Datagram Protocol) is connectionless and faster.
    DNS (Domain Name System) translates human-readable names (google.com) into IP addresses.')
    RETURNING id INTO v_lesson_net;

    INSERT INTO public.quizzes (topic_id, lesson_id)
    VALUES (v_topic_net, v_lesson_net)
    RETURNING id INTO v_quiz_net;

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_net, 'Which layer of the OSI model is responsible for routing packets?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Network Layer', true), (v_q_id, 'Data Link Layer', false), (v_q_id, 'Transport Layer', false), (v_q_id, 'Physical Layer', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_net, 'Which protocol is connectionless and often used for streaming?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'UDP', true), (v_q_id, 'TCP', false), (v_q_id, 'HTTP', false), (v_q_id, 'FTP', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_net, 'What does DNS stand for?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Domain Name System', true), (v_q_id, 'Digital Network Service', false), (v_q_id, 'Data Node System', false), (v_q_id, 'Dynamic Name Server', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_net, 'At which OSI layer does a switch typically operate?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Data Link Layer', true), (v_q_id, 'Network Layer', false), (v_q_id, 'Transport Layer', false), (v_q_id, 'Session Layer', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_net, 'What is the main purpose of the TCP 3-way handshake?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'To establish a reliable connection', true), (v_q_id, 'To assign an IP address', false), (v_q_id, 'To encrypt the payload', false), (v_q_id, 'To resolve a domain name', false);


    -- ============================================================
    -- 3. DATABASES
    -- ============================================================
    INSERT INTO public.topics (title, description)
    VALUES ('Databases', 'Relational database design, SQL, and data integrity.')
    RETURNING id INTO v_topic_db;

    INSERT INTO public.lessons (topic_id, content)
    VALUES (v_topic_db, 'Relational databases store data in tables with rows and columns.
    Key concepts:
    - Primary Key: Uniquely identifies a record in a table.
    - Foreign Key: Links two tables together.
    - Normalization: The process of organizing data to reduce redundancy (e.g., 1NF, 2NF, 3NF).
    - ACID Properties: Atomicity, Consistency, Isolation, and Durability ensure reliable transactions.')
    RETURNING id INTO v_lesson_db;

    INSERT INTO public.quizzes (topic_id, lesson_id)
    VALUES (v_topic_db, v_lesson_db)
    RETURNING id INTO v_quiz_db;

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_db, 'What is a Primary Key?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'A unique identifier for a record', true), (v_q_id, 'A key used to encrypt the DB', false), (v_q_id, 'A duplicate of another column', false), (v_q_id, 'A type of index', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_db, 'Which SQL command is used to remove all records from a table without deleting the table structure?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'TRUNCATE', true), (v_q_id, 'DROP', false), (v_q_id, 'DELETE ALL', false), (v_q_id, 'REMOVE', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_db, 'What does the "A" in ACID stand for?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Atomicity', true), (v_q_id, 'Availability', false), (v_q_id, 'Aggregation', false), (v_q_id, 'Authentication', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_db, 'What is the goal of Database Normalization?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'To reduce data redundancy', true), (v_q_id, 'To increase data duplication', false), (v_q_id, 'To remove all indexes', false), (v_q_id, 'To convert SQL to NoSQL', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_db, 'Which join returns all records when there is a match in either left or right table?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'FULL OUTER JOIN', true), (v_q_id, 'INNER JOIN', false), (v_q_id, 'LEFT JOIN', false), (v_q_id, 'CROSS JOIN', false);


    -- ============================================================
    -- 4. SOFTWARE ENGINEERING
    -- ============================================================
    INSERT INTO public.topics (title, description)
    VALUES ('Software Engineering', 'Development lifecycles, methodologies, and testing.')
    RETURNING id INTO v_topic_se;

    INSERT INTO public.lessons (topic_id, content)
    VALUES (v_topic_se, 'Software Engineering is the application of a systematic approach to development.
    - SDLC (Software Development Life Cycle): Planning -> Analysis -> Design -> Implementation -> Testing -> Maintenance.
    - Waterfall: Linear and sequential.
    - Agile: Iterative and incremental (e.g., Scrum, Kanban).
    - Testing: Unit Testing (single component), Integration Testing (combined components), System Testing (complete system).')
    RETURNING id INTO v_lesson_se;

    INSERT INTO public.quizzes (topic_id, lesson_id)
    VALUES (v_topic_se, v_lesson_se)
    RETURNING id INTO v_quiz_se;

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_se, 'Which development model is iterative and emphasizes customer feedback?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Agile', true), (v_q_id, 'Waterfall', false), (v_q_id, 'V-Model', false), (v_q_id, 'Big Bang', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_se, 'What is "Unit Testing"?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Testing individual components', true), (v_q_id, 'Testing the whole system', false), (v_q_id, 'Testing user acceptance', false), (v_q_id, 'Testing network speed', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_se, 'In which phase of the SDLC is the software design documented?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Design Phase', true), (v_q_id, 'Analysis Phase', false), (v_q_id, 'Maintenance Phase', false), (v_q_id, 'Testing Phase', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_se, 'What is a "Sprint" in Scrum?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'A fixed-length development iteration', true), (v_q_id, 'A type of bug', false), (v_q_id, 'A documentation tool', false), (v_q_id, 'A hardware acceleration', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_se, 'What is "Black Box Testing"?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Testing based on specifications without knowing internal code', true), (v_q_id, 'Testing the physical hardware', false), (v_q_id, 'Testing without a compiler', false), (v_q_id, 'Testing in a dark room', false);


    -- ============================================================
    -- 5. INFORMATION SECURITY
    -- ============================================================
    INSERT INTO public.topics (title, description)
    VALUES ('Information Security', 'Protecting data, encryption, and threat mitigation.')
    RETURNING id INTO v_topic_sec;

    INSERT INTO public.lessons (topic_id, content)
    VALUES (v_topic_sec, 'Information Security ensures Confidentiality, Integrity, and Availability (CIA Triad).
    - Symmetric Encryption: Same key for encryption and decryption (e.g., AES).
    - Asymmetric Encryption: Public key to encrypt, private key to decrypt (e.g., RSA).
    - Firewall: A network security system that monitors and controls incoming/outgoing traffic.
    - Phishing: A social engineering attack used to steal sensitive data.')
    RETURNING id INTO v_lesson_sec;

    INSERT INTO public.quizzes (topic_id, lesson_id)
    VALUES (v_topic_sec, v_lesson_sec)
    RETURNING id INTO v_quiz_sec;

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_sec, 'What does the "C" in the CIA Triad stand for?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Confidentiality', true), (v_q_id, 'Consistency', false), (v_q_id, 'Complexity', false), (v_q_id, 'Control', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_sec, 'Which encryption method uses two different keys (Public and Private)?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Asymmetric Encryption', true), (v_q_id, 'Symmetric Encryption', false), (v_q_id, 'Hashing', false), (v_q_id, 'Base64 Encoding', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_sec, 'What is a "Phishing" attack?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'Using deceptive emails to steal data', true), (v_q_id, 'Overloading a server with requests', false), (v_q_id, 'Cracking a password via brute force', false), (v_q_id, 'Injecting code into a database', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_sec, 'What is the purpose of a Firewall?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'To filter network traffic based on rules', true), (v_q_id, 'To cool down the CPU', false), (v_q_id, 'To increase internet bandwidth', false), (v_q_id, 'To store passwords securely', false);

    INSERT INTO public.questions (quiz_id, text) VALUES (v_quiz_sec, 'Which of these is a common hashing algorithm?') RETURNING id INTO v_q_id;
    INSERT INTO public.options (question_id, text, is_correct) VALUES (v_q_id, 'SHA-256', true), (v_q_id, 'RSA', false), (v_q_id, 'AES', false), (v_q_id, 'DES', false);

END $$;
