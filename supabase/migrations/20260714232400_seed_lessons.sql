INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'computer-architecture'),
  'What is a CPU?',
  'what-is-a-cpu',
  'Learn about the Central Processing Unit and its role in computing.',
  '[
    {"type": "heading", "content": "The Brain of Your Computer"},
    {"type": "text", "content": "The **Central Processing Unit (CPU)** is often called the brain of the computer. It executes instructions from programs by performing basic arithmetic, logic, control, and input/output operations."},
    {"type": "text", "content": "### How Does a CPU Work?"},
    {"type": "list", "items": [
      "**Fetch**: The CPU retrieves instructions from memory",
      "**Decode**: It interprets what the instruction means",
      "**Execute**: It carries out the instruction",
      "**Store**: Results are written back to memory"
    ]},
    {"type": "tip", "content": "This cycle happens billions of times per second! A 3 GHz processor can perform 3 billion cycles per second."},
    {"type": "heading", "content": "Key Components"},
    {"type": "list", "items": [
      "**ALU (Arithmetic Logic Unit)**: Performs math and logic operations",
      "**Control Unit**: Directs the flow of data",
      "**Registers**: Small, fast storage inside the CPU",
      "**Cache**: Faster memory closer to the CPU"
    ]},
    {"type": "example", "content": "When you open a web browser, the CPU fetches the program from storage, decodes the instructions, and executes them to display the browser window."},
    {"type": "warning", "content": "A faster CPU doesn't always mean a faster computer. Other components like RAM and storage speed also matter!"}
  ]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'computer-architecture'),
  'Memory Hierarchy',
  'memory-hierarchy',
  'Understanding the different levels of computer memory.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'computer-architecture'),
  'Instruction Set Architecture',
  'instruction-set-architecture',
  'Learn about RISC vs CISC and how CPUs understand instructions.',
  '[]'::jsonb,
  5,
  10,
  3,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'data-structures'),
  'Arrays and Lists',
  'arrays-and-lists',
  'The fundamentals of sequential data storage.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'data-structures'),
  'Stacks and Queues',
  'stacks-and-queues',
  'LIFO and FIFO data structures explained.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'data-structures'),
  'Trees and Graphs',
  'trees-and-graphs',
  'Hierarchical and network data structures.',
  '[]'::jsonb,
  5,
  10,
  3,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'algorithms'),
  'Sorting Algorithms',
  'sorting-algorithms',
  'Learn about bubble sort, merge sort, and quicksort.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'algorithms'),
  'Search Algorithms',
  'search-algorithms',
  'Linear search vs binary search.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'databases'),
  'Relational Databases',
  'relational-databases',
  'Introduction to SQL and relational database concepts.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'databases'),
  'Normalization',
  'normalization',
  'Database design principles to reduce redundancy.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'networking'),
  'OSI Model',
  'osi-model',
  'The 7 layers of network communication.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'networking'),
  'TCP/IP Protocol',
  'tcp-ip-protocol',
  'How data travels across the internet.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'operating-systems'),
  'Process Management',
  'process-management',
  'How the OS manages running programs.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'operating-systems'),
  'Memory Management',
  'memory-management-os',
  'Virtual memory, paging, and segmentation.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'software-development'),
  'SDLC Overview',
  'sdlc-overview',
  'Software Development Life Cycle phases.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'software-development'),
  'Agile Methodology',
  'agile-methodology',
  'Iterative development and Scrum basics.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'cryptography'),
  'Symmetric Encryption',
  'symmetric-encryption',
  'Shared key encryption methods like AES.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'cryptography'),
  'Asymmetric Encryption',
  'asymmetric-encryption',
  'Public-key cryptography and RSA.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'network-security'),
  'Firewalls',
  'firewalls',
  'Network security barriers.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'network-security'),
  'HTTPS and SSL/TLS',
  'https-ssl-tls',
  'Secure web communication.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'access-control'),
  'Authentication Methods',
  'authentication-methods',
  'Passwords, MFA, and biometrics.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'security-threats'),
  'Common Attack Types',
  'common-attack-types',
  'SQL injection, XSS, and phishing.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'project-management'),
  'Waterfall vs Agile',
  'waterfall-vs-agile',
  'Traditional vs iterative approaches.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'project-management'),
  'Risk Management',
  'risk-management',
  'Identifying and mitigating project risks.',
  '[]'::jsonb,
  5,
  10,
  2,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'quality-assurance'),
  'Testing Types',
  'testing-types',
  'Unit, integration, and system testing.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'development-processes'),
  'DevOps Basics',
  'devops-basics',
  'Continuous integration and deployment.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'intellectual-property'),
  'Patents and Copyrights',
  'patents-and-copyrights',
  'Protecting intellectual property.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'it-governance'),
  'IT Governance Frameworks',
  'it-governance-frameworks',
  'COBIT and ITIL overview.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'business-strategy'),
  'SWOT Analysis',
  'swot-analysis',
  'Strengths, weaknesses, opportunities, threats.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'finance'),
  'Cost-Benefit Analysis',
  'cost-benefit-analysis',
  'Evaluating project financials.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'procurement'),
  'Procurement Process',
  'procurement-process',
  'Vendor selection and contracts.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES (
  (SELECT id FROM subtopics WHERE slug = 'business-operations'),
  'Business Process Modeling',
  'business-process-modeling',
  'BPMN and process visualization.',
  '[]'::jsonb,
  5,
  10,
  1,
  true
);
