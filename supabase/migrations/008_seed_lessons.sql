-- Seed lessons for all subtopics.
-- Each row references a subtopic by slug and stores content_blocks as JSONB
-- consumed by src/web/src/components/features/LessonContent.tsx.

INSERT INTO lessons (subtopic_id, title, slug, summary, content_blocks, estimated_minutes, xp_reward, display_order, published)
VALUES
  ((SELECT id FROM subtopics WHERE slug = 'computer-architecture'), 'What is a CPU?', 'what-is-a-cpu', 'Learn about the Central Processing Unit and its role in computing.',
    '[
      {"type": "heading", "content": "The Brain of Your Computer"},
      {"type": "text", "content": "The **Central Processing Unit (CPU)** is often called the brain of the computer. It executes instructions from programs by performing basic arithmetic, logic, control, and input/output operations."},
      {"type": "heading", "content": "How Does a CPU Work?"},
      {"type": "list", "items": ["**Fetch**: The CPU retrieves instructions from memory", "**Decode**: It interprets what the instruction means", "**Execute**: It carries out the instruction", "**Store**: Results are written back to memory"]},
      {"type": "tip", "content": "This cycle happens billions of times per second! A 3 GHz processor can perform 3 billion cycles per second."},
      {"type": "heading", "content": "Key Components"},
      {"type": "list", "items": ["**ALU (Arithmetic Logic Unit)**: Performs math and logic operations", "**Control Unit**: Directs the flow of data", "**Registers**: Small, fast storage inside the CPU", "**Cache**: Faster memory closer to the CPU"]},
      {"type": "example", "content": "When you open a web browser, the CPU fetches the program from storage, decodes the instructions, and executes them to display the browser window."},
      {"type": "warning", "content": "A faster CPU doesn''t always mean a faster computer. Other components like RAM and storage speed also matter!"}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'computer-architecture'), 'Memory Hierarchy', 'memory-hierarchy', 'Understanding the different levels of computer memory.',
    '[
      {"type": "heading", "content": "The Memory Pyramid"},
      {"type": "text", "content": "Computer memory is organized in a **hierarchy** — from very fast and small at the top, to slow and large at the bottom. Cost per byte drops as you go down."},
      {"type": "list", "items": ["**Registers** — inside the CPU, nanosecond access, only a few bytes", "**Cache (L1/L2/L3)** — very fast SRAM, KB to MB", "**Main memory (RAM)** — DRAM, GB, volatile", "**Secondary storage** — SSD/HDD, TB, non-volatile"]},
      {"type": "tip", "content": "The CPU looks in the fastest level first and only reaches down when it misses — this is called the locality principle."}
    ]'::jsonb, 5, 10, 2, true),
  ((SELECT id FROM subtopics WHERE slug = 'computer-architecture'), 'Instruction Set Architecture', 'instruction-set-architecture', 'Learn about RISC vs CISC and how CPUs understand instructions.',
    '[
      {"type": "heading", "content": "What is an ISA?"},
      {"type": "text", "content": "An **Instruction Set Architecture (ISA)** defines the set of instructions a CPU understands — the boundary between hardware and software."},
      {"type": "heading", "content": "RISC vs CISC"},
      {"type": "list", "items": ["**RISC** (e.g. ARM, RISC-V): small set of simple, fixed-length instructions; runs fast in a pipeline", "**CISC** (e.g. x86): large set of complex instructions; each can do more work per instruction"]},
      {"type": "example", "content": "Your phone almost certainly runs on ARM (RISC). Your laptop probably runs x86 (CISC)."}
    ]'::jsonb, 5, 10, 3, true),

  ((SELECT id FROM subtopics WHERE slug = 'data-structures'), 'Arrays and Lists', 'arrays-and-lists', 'The fundamentals of sequential data storage.',
    '[
      {"type": "heading", "content": "Sequential Data"},
      {"type": "text", "content": "**Arrays** store elements contiguously in memory. Access by index is O(1). Inserting in the middle is O(n) because everything after has to shift."},
      {"type": "text", "content": "**Linked lists** store elements in nodes connected by pointers. Insert/delete at a known node is O(1), but random access is O(n)."},
      {"type": "tip", "content": "Rule of thumb: use arrays when you read a lot, lists when you insert/remove a lot."}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'data-structures'), 'Stacks and Queues', 'stacks-and-queues', 'LIFO and FIFO data structures explained.',
    '[
      {"type": "heading", "content": "Two Simple Structures"},
      {"type": "list", "items": ["**Stack** — Last In, First Out (LIFO). Think of a stack of plates.", "**Queue** — First In, First Out (FIFO). Think of people in line."]},
      {"type": "example", "content": "The browser back button uses a stack. A printer job spooler uses a queue."}
    ]'::jsonb, 5, 10, 2, true),
  ((SELECT id FROM subtopics WHERE slug = 'data-structures'), 'Trees and Graphs', 'trees-and-graphs', 'Hierarchical and network data structures.',
    '[
      {"type": "heading", "content": "Beyond Linear"},
      {"type": "text", "content": "A **tree** is a hierarchical structure with one root and no cycles. A **graph** is a general set of nodes connected by edges — it may have cycles."},
      {"type": "list", "items": ["Binary search trees keep sorted data with O(log n) search", "Graphs model networks: roads, social connections, web links"]}
    ]'::jsonb, 5, 10, 3, true),

  ((SELECT id FROM subtopics WHERE slug = 'algorithms'), 'Sorting Algorithms', 'sorting-algorithms', 'Learn about bubble sort, merge sort, and quicksort.',
    '[
      {"type": "heading", "content": "How Do We Sort?"},
      {"type": "list", "items": ["**Bubble sort** — O(n^2), easy to understand, rarely used", "**Merge sort** — O(n log n), stable, uses extra memory", "**Quicksort** — O(n log n) average, in-place, most common in practice"]},
      {"type": "tip", "content": "Library sort functions (like Python''s sorted() or Java''s Arrays.sort) usually use a tuned quicksort or a hybrid like Timsort."}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'algorithms'), 'Search Algorithms', 'search-algorithms', 'Linear search vs binary search.',
    '[
      {"type": "heading", "content": "Finding a Needle"},
      {"type": "list", "items": ["**Linear search** — check every element. O(n). Works on any list.", "**Binary search** — halve the range each step. O(log n). Requires sorted input."]},
      {"type": "example", "content": "Looking up a word in a dictionary — you don''t start at A, you open somewhere in the middle. That''s binary search."}
    ]'::jsonb, 5, 10, 2, true),

  ((SELECT id FROM subtopics WHERE slug = 'databases'), 'Relational Databases', 'relational-databases', 'Introduction to SQL and relational database concepts.',
    '[
      {"type": "heading", "content": "Tables, Rows, Relationships"},
      {"type": "text", "content": "A **relational database** stores data in tables. Each row is a record, each column an attribute. Tables are linked by **foreign keys**."},
      {"type": "list", "items": ["**Primary key** uniquely identifies a row", "**Foreign key** references a primary key in another table", "**SQL** is the standard language to query relational data"]}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'databases'), 'Normalization', 'normalization', 'Database design principles to reduce redundancy.',
    '[
      {"type": "heading", "content": "Why Normalize?"},
      {"type": "text", "content": "**Normalization** organizes tables to reduce duplication and prevent update anomalies."},
      {"type": "list", "items": ["**1NF** — atomic values, no repeating groups", "**2NF** — no partial dependencies on a composite key", "**3NF** — no transitive dependencies"]},
      {"type": "warning", "content": "Over-normalizing can hurt read performance. Real systems often denormalize hot paths."}
    ]'::jsonb, 5, 10, 2, true),

  ((SELECT id FROM subtopics WHERE slug = 'networking'), 'OSI Model', 'osi-model', 'The 7 layers of network communication.',
    '[
      {"type": "heading", "content": "Seven Layers"},
      {"type": "list", "items": ["**7 Application** — HTTP, DNS, SMTP", "**6 Presentation** — encoding, encryption", "**5 Session** — connection management", "**4 Transport** — TCP, UDP", "**3 Network** — IP, routing", "**2 Data Link** — Ethernet, MAC addresses", "**1 Physical** — cables, radio waves"]},
      {"type": "tip", "content": "Mnemonic: **A**ll **P**eople **S**eem **T**o **N**eed **D**ata **P**rocessing."}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'networking'), 'TCP/IP Protocol', 'tcp-ip-protocol', 'How data travels across the internet.',
    '[
      {"type": "heading", "content": "The Internet''s Backbone"},
      {"type": "list", "items": ["**IP** delivers packets between machines using addresses like 192.168.1.1", "**TCP** provides reliable, ordered delivery on top of IP", "**UDP** is faster but unreliable — good for video/audio"]},
      {"type": "example", "content": "Loading a web page uses TCP. A live video call typically uses UDP."}
    ]'::jsonb, 5, 10, 2, true),

  ((SELECT id FROM subtopics WHERE slug = 'operating-systems'), 'Process Management', 'process-management', 'How the OS manages running programs.',
    '[
      {"type": "heading", "content": "Processes and Threads"},
      {"type": "text", "content": "A **process** is a running program with its own memory. A **thread** is a lightweight unit of execution inside a process — threads share memory."},
      {"type": "list", "items": ["The OS scheduler decides which process runs next", "Context switches save and restore process state", "Multi-core CPUs run multiple processes truly in parallel"]}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'operating-systems'), 'Memory Management', 'memory-management-os', 'Virtual memory, paging, and segmentation.',
    '[
      {"type": "heading", "content": "Every Program Thinks It Owns the RAM"},
      {"type": "text", "content": "The OS gives each process a **virtual address space**. Hardware translates virtual addresses to physical RAM using page tables."},
      {"type": "list", "items": ["**Paging** — memory in fixed-size pages", "**Swap** — pages moved to disk when RAM is full", "**Protection** — one process can''t read another''s memory"]}
    ]'::jsonb, 5, 10, 2, true),

  ((SELECT id FROM subtopics WHERE slug = 'software-development'), 'SDLC Overview', 'sdlc-overview', 'Software Development Life Cycle phases.',
    '[
      {"type": "heading", "content": "From Idea to Production"},
      {"type": "list", "items": ["**Requirements** — what should it do?", "**Design** — how will it work?", "**Implementation** — write the code", "**Testing** — does it work?", "**Deployment** — ship it", "**Maintenance** — keep it working"]}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'software-development'), 'Agile Methodology', 'agile-methodology', 'Iterative development and Scrum basics.',
    '[
      {"type": "heading", "content": "Ship Small, Ship Often"},
      {"type": "text", "content": "**Agile** favors short iterations, working software, and responding to change over rigid plans."},
      {"type": "list", "items": ["**Sprint** — a short (usually 2-week) development cycle", "**Backlog** — prioritized list of work", "**Standup** — quick daily sync", "**Retrospective** — how can we improve?"]}
    ]'::jsonb, 5, 10, 2, true),

  ((SELECT id FROM subtopics WHERE slug = 'cryptography'), 'Symmetric Encryption', 'symmetric-encryption', 'Shared key encryption methods like AES.',
    '[
      {"type": "heading", "content": "One Key for Both Sides"},
      {"type": "text", "content": "**Symmetric encryption** uses the same key to encrypt and decrypt. Fast, but both parties need the key in advance."},
      {"type": "list", "items": ["**AES** — modern standard, 128/192/256-bit keys", "**DES/3DES** — older, mostly retired"]},
      {"type": "warning", "content": "The hard part is safely sharing the key — that''s where asymmetric encryption comes in."}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'cryptography'), 'Asymmetric Encryption', 'asymmetric-encryption', 'Public-key cryptography and RSA.',
    '[
      {"type": "heading", "content": "Two Keys, One Public"},
      {"type": "text", "content": "**Asymmetric encryption** uses a **public key** to encrypt and a matching **private key** to decrypt. Anyone can send you a secret; only you can read it."},
      {"type": "list", "items": ["**RSA** — classic, based on factoring large primes", "**ECC** — elliptic-curve, shorter keys for the same security", "Used to bootstrap symmetric keys in HTTPS"]}
    ]'::jsonb, 5, 10, 2, true),

  ((SELECT id FROM subtopics WHERE slug = 'network-security'), 'Firewalls', 'firewalls', 'Network security barriers.',
    '[
      {"type": "heading", "content": "A Gate on the Network"},
      {"type": "text", "content": "A **firewall** inspects traffic and allows or blocks it based on rules — usually source/destination IP, port, and protocol."},
      {"type": "list", "items": ["**Packet-filter** — inspects each packet in isolation", "**Stateful** — tracks connections", "**Application** — understands HTTP, DNS, etc."]}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'network-security'), 'HTTPS and SSL/TLS', 'https-ssl-tls', 'Secure web communication.',
    '[
      {"type": "heading", "content": "The Padlock in Your Browser"},
      {"type": "text", "content": "**HTTPS** is HTTP over **TLS** (formerly SSL). TLS uses asymmetric encryption to agree on a symmetric key, then encrypts the session with that key."},
      {"type": "list", "items": ["**Certificate** — proves a server owns a domain, signed by a trusted CA", "**Handshake** — client and server agree on keys and ciphers", "**Session** — actual traffic, encrypted symmetrically"]}
    ]'::jsonb, 5, 10, 2, true),

  ((SELECT id FROM subtopics WHERE slug = 'access-control'), 'Authentication Methods', 'authentication-methods', 'Passwords, MFA, and biometrics.',
    '[
      {"type": "heading", "content": "Proving Who You Are"},
      {"type": "list", "items": ["**Something you know** — password, PIN", "**Something you have** — phone, hardware token", "**Something you are** — fingerprint, face"]},
      {"type": "tip", "content": "**MFA** combines two or more of these — much harder to defeat than a password alone."}
    ]'::jsonb, 5, 10, 1, true),

  ((SELECT id FROM subtopics WHERE slug = 'security-threats'), 'Common Attack Types', 'common-attack-types', 'SQL injection, XSS, and phishing.',
    '[
      {"type": "heading", "content": "Know Your Enemy"},
      {"type": "list", "items": ["**SQL injection** — attacker sneaks SQL into an input field", "**XSS (cross-site scripting)** — malicious JS runs in a victim''s browser", "**Phishing** — fake email or site tricks a user into revealing credentials", "**DDoS** — flood of traffic to knock a service offline"]},
      {"type": "warning", "content": "Most breaches start with a human mistake, not a zero-day."}
    ]'::jsonb, 5, 10, 1, true),

  ((SELECT id FROM subtopics WHERE slug = 'project-management'), 'Waterfall vs Agile', 'waterfall-vs-agile', 'Traditional vs iterative approaches.',
    '[
      {"type": "heading", "content": "Two Ways to Run a Project"},
      {"type": "list", "items": ["**Waterfall** — plan everything up front, execute in sequence. Good when requirements are locked.", "**Agile** — iterate in short cycles, adjust as you learn. Good when requirements evolve."]}
    ]'::jsonb, 5, 10, 1, true),
  ((SELECT id FROM subtopics WHERE slug = 'project-management'), 'Risk Management', 'risk-management', 'Identifying and mitigating project risks.',
    '[
      {"type": "heading", "content": "Plan for What Could Go Wrong"},
      {"type": "list", "items": ["**Identify** risks early", "**Assess** likelihood and impact", "**Mitigate** — avoid, transfer, reduce, or accept", "**Monitor** throughout the project"]}
    ]'::jsonb, 5, 10, 2, true),

  ((SELECT id FROM subtopics WHERE slug = 'quality-assurance'), 'Testing Types', 'testing-types', 'Unit, integration, and system testing.',
    '[
      {"type": "heading", "content": "The Testing Pyramid"},
      {"type": "list", "items": ["**Unit tests** — one function/class at a time, fast, many", "**Integration tests** — components together, slower, fewer", "**System / E2E tests** — full app, slowest, few"]},
      {"type": "tip", "content": "Bugs are cheapest to catch at the unit-test layer."}
    ]'::jsonb, 5, 10, 1, true),

  ((SELECT id FROM subtopics WHERE slug = 'development-processes'), 'DevOps Basics', 'devops-basics', 'Continuous integration and deployment.',
    '[
      {"type": "heading", "content": "Dev + Ops"},
      {"type": "text", "content": "**DevOps** merges development and operations to ship faster and more reliably."},
      {"type": "list", "items": ["**CI (Continuous Integration)** — every change is built and tested automatically", "**CD (Continuous Delivery / Deployment)** — every green change is releasable, often auto-shipped", "**IaC** — infrastructure defined as code"]}
    ]'::jsonb, 5, 10, 1, true),

  ((SELECT id FROM subtopics WHERE slug = 'intellectual-property'), 'Patents and Copyrights', 'patents-and-copyrights', 'Protecting intellectual property.',
    '[
      {"type": "heading", "content": "Two Different Protections"},
      {"type": "list", "items": ["**Copyright** — automatic, protects a specific expression (code, text, images)", "**Patent** — granted by an office, protects an invention or process", "**Trademark** — protects brand identity (logos, names)", "**Trade secret** — protected by keeping it secret"]}
    ]'::jsonb, 5, 10, 1, true),

  ((SELECT id FROM subtopics WHERE slug = 'it-governance'), 'IT Governance Frameworks', 'it-governance-frameworks', 'COBIT and ITIL overview.',
    '[
      {"type": "heading", "content": "Running IT Like a Business"},
      {"type": "list", "items": ["**COBIT** — framework for governance and management of enterprise IT", "**ITIL** — best practices for IT service management", "**ISO 27001** — information security management standard"]}
    ]'::jsonb, 5, 10, 1, true),

  ((SELECT id FROM subtopics WHERE slug = 'business-strategy'), 'SWOT Analysis', 'swot-analysis', 'Strengths, weaknesses, opportunities, threats.',
    '[
      {"type": "heading", "content": "A Four-Quadrant Snapshot"},
      {"type": "list", "items": ["**S**trengths — internal advantages", "**W**eaknesses — internal disadvantages", "**O**pportunities — external favorable factors", "**T**hreats — external unfavorable factors"]},
      {"type": "example", "content": "Startups often use SWOT before choosing which market to enter first."}
    ]'::jsonb, 5, 10, 1, true),

  ((SELECT id FROM subtopics WHERE slug = 'finance'), 'Cost-Benefit Analysis', 'cost-benefit-analysis', 'Evaluating project financials.',
    '[
      {"type": "heading", "content": "Is It Worth Doing?"},
      {"type": "text", "content": "**Cost-benefit analysis (CBA)** compares the total expected cost of a decision against its expected benefit, usually in monetary terms."},
      {"type": "list", "items": ["**ROI** — return on investment as a percentage", "**Payback period** — how long until you break even", "**NPV** — net present value, accounting for time"]}
    ]'::jsonb, 5, 10, 1, true),

  ((SELECT id FROM subtopics WHERE slug = 'procurement'), 'Procurement Process', 'procurement-process', 'Vendor selection and contracts.',
    '[
      {"type": "heading", "content": "Buying Well"},
      {"type": "list", "items": ["**RFI** — request for information, learn who''s out there", "**RFP** — request for proposal, ask vendors to solve a problem", "**RFQ** — request for quotation, ask for pricing on a defined item", "**Contract** — agreed terms, SLAs, penalties"]}
    ]'::jsonb, 5, 10, 1, true),

  ((SELECT id FROM subtopics WHERE slug = 'business-operations'), 'Business Process Modeling', 'business-process-modeling', 'BPMN and process visualization.',
    '[
      {"type": "heading", "content": "Draw the Work"},
      {"type": "text", "content": "**Business Process Modeling** captures how work flows through an organization so it can be analyzed and improved."},
      {"type": "list", "items": ["**BPMN** — standard notation for process diagrams", "**Swim lanes** — show who does what", "**Bottlenecks** show up visually and can be redesigned"]}
    ]'::jsonb, 5, 10, 1, true);
