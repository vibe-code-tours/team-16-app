-- Update all empty lessons with content_blocks
-- ITPEC FE Exam Short Lessons Content

-- ============================================================
-- TECHNOLOGY
-- ============================================================

-- Memory Hierarchy
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Levels of Memory"},
  {"type": "text", "content": "Computers use a hierarchy of memory types, each with different speed and cost. Faster memory is more expensive, so it is smaller."},
  {"type": "list", "items": [
    "**Registers**: Fastest, inside the CPU (bytes)",
    "**L1 Cache**: Very fast, built into CPU (KB)",
    "**L2 Cache**: Fast, on CPU chip (KB to MB)",
    "**RAM**: Main memory, volatile (GB)",
    "**SSD/HDD**: Persistent storage, slowest (TB)"
  ]},
  {"type": "tip", "content": "The principle of **locality of reference** means programs tend to access the same memory locations repeatedly, making caches effective."},
  {"type": "heading", "content": "Cache Memory"},
  {"type": "text", "content": "Cache stores frequently accessed data close to the CPU. When the CPU needs data, it checks the cache first (**cache hit**) before going to RAM (**cache miss**)."},
  {"type": "example", "content": "A **cache hit rate** of 95% means the CPU finds data in cache 95% of the time, only going to slower RAM for the remaining 5%."},
  {"type": "warning", "content": "Cache pollution occurs when less-used data displaces frequently used data, reducing performance."}
]' WHERE slug = 'memory-hierarchy';

-- Instruction Set Architecture
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is an ISA?"},
  {"type": "text", "content": "The **Instruction Set Architecture (ISA)** is the interface between hardware and software. It defines the commands a CPU can execute."},
  {"type": "heading", "content": "RISC vs CISC"},
  {"type": "list", "items": [
    "**RISC (Reduced Instruction Set Computer)**: Simple instructions, each executes in one clock cycle. Examples: ARM, MIPS",
    "**CISC (Complex Instruction Set Computer)**: Complex instructions that may take multiple cycles. Examples: x86, VAX"
  ]},
  {"type": "tip", "content": "RISC processors are common in mobile devices due to their power efficiency. CISC processors dominate desktops and servers."},
  {"type": "heading", "content": "Key ISA Concepts"},
  {"type": "list", "items": [
    "**Registers**: Small fast storage inside the CPU",
    **Addressing Modes**: How the CPU locates operands in memory",
    "**Data Types**: Supported formats (integer, float, string)"
  ]},
  {"type": "example", "content": "A RISC processor might use a **load-store architecture**: only load/store instructions access memory, while all other operations work on registers."}
]' WHERE slug = 'instruction-set-architecture';

-- Arrays and Lists
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Arrays"},
  {"type": "text", "content": "An **array** is a collection of elements stored in contiguous memory locations. Elements are accessed by their index."},
  {"type": "list", "items": [
    "**Access time**: O(1) — direct index lookup",
    "**Insertion/Deletion**: O(n) — may require shifting elements",
    "**Memory**: Contiguous allocation, fixed size (in static arrays)"
  ]},
  {"type": "code", "language": "python", "content": "arr = [10, 20, 30, 40, 50]\nprint(arr[2])  # Output: 30"},
  {"type": "heading", "content": "Linked Lists"},
  {"type": "text", "content": "A **linked list** stores elements in nodes, where each node contains data and a pointer to the next node."},
  {"type": "list", "items": [
    "**Access time**: O(n) — must traverse from head",
    "**Insertion/Deletion**: O(1) — if position is known",
    "**Memory**: Non-contiguous, dynamic size"
  ]},
  {"type": "tip", "content": "Use arrays when you need fast access by index. Use linked lists when you need frequent insertions and deletions."},
  {"type": "warning", "content": "Arrays can suffer from **cache misses** since elements may not fit in cache lines during traversal."}
]' WHERE slug = 'arrays-and-lists';

-- Stacks and Queues
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Stack (LIFO)"},
  {"type": "text", "content": "A **stack** follows **Last-In, First-Out (LIFO)** order. Think of a stack of plates — you add and remove from the top."},
  {"type": "list", "items": [
    "**push**: Add an element to the top",
    "**pop**: Remove the top element",
    "**peek/top**: View the top element without removing",
    "**isEmpty**: Check if the stack is empty"
  ]},
  {"type": "example", "content": "Stacks are used for: function call management (call stack), undo operations, expression evaluation, and backtracking algorithms."},
  {"type": "heading", "content": "Queue (FIFO)"},
  {"type": "text", "content": "A **queue** follows **First-In, First-Out (FIFO)** order. Think of a line at a store — first person in line is served first."},
  {"type": "list", "items": [
    "**enqueue**: Add an element to the rear",
    "**dequeue**: Remove the front element",
    "**front**: View the front element without removing",
    "**isEmpty**: Check if the queue is empty"
  ]},
  {"type": "tip", "content": "Variants include **priority queues** (highest priority served first) and **deques** (double-ended queues, insert/remove from both ends)."}
]' WHERE slug = 'stacks-and-queues';

-- Trees and Graphs
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Trees"},
  {"type": "text", "content": "A **tree** is a hierarchical data structure with a root node and child nodes. Each node has at most one parent."},
  {"type": "list", "items": [
    "**Binary Tree**: Each node has at most 2 children",
    "**Binary Search Tree (BST)**: Left < Parent < Right",
    "**Balanced Tree (AVL, Red-Black)**: Keeps height balanced for O(log n) operations",
    "**Heap**: Parent is always greater (max-heap) or smaller (min-heap) than children"
  ]},
  {"type": "tip", "content": "A **complete binary tree** fills all levels except possibly the last, which is filled from left to right. Heaps are typically stored as complete binary trees."},
  {"type": "heading", "content": "Graphs"},
  {"type": "text", "content": "A **graph** consists of vertices (nodes) and edges (connections). Graphs can be directed or undirected, weighted or unweighted."},
  {"type": "list", "items": [
    "**Adjacency Matrix**: 2D array, O(1) edge lookup, O(V²) space",
    "**Adjacency List**: List per vertex, O(degree) edge lookup, O(V+E) space",
    "**BFS**: Level-by-level traversal using a queue",
    "**DFS**: Deep-first traversal using a stack or recursion"
  ]},
  {"type": "example", "content": "Social networks are modeled as graphs: users are vertices, friendships are edges. Finding friends-of-friends is a graph traversal problem."}
]' WHERE slug = 'trees-and-graphs';

-- Sorting Algorithms
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Comparison-Based Sorting"},
  {"type": "text", "content": "Sorting algorithms arrange elements in order. Comparison-based sorts have a lower bound of **O(n log n)**."},
  {"type": "heading", "content": "Common Sorting Algorithms"},
  {"type": "list", "items": [
    "**Bubble Sort**: Repeatedly swap adjacent elements. O(n²) time, O(1) space",
    "**Selection Sort**: Find minimum, swap to front. O(n²) time, O(1) space",
    "**Insertion Sort**: Insert each element into correct position. O(n²) time, O(1) space",
    "**Merge Sort**: Divide and merge. O(n log n) time, O(n) space",
    "**Quick Sort**: Partition around pivot. O(n log n) average, O(n²) worst case"
  ]},
  {"type": "tip", "content": "For nearly sorted data, **Insertion Sort** performs well with O(n) time. For guaranteed O(n log n), use **Merge Sort**."},
  {"type": "warning", "content": "Quick Sort has O(n²) worst case when the pivot is always the smallest or largest element. Use randomized pivot to avoid this."},
  {"type": "example", "content": "**Merge Sort** is used in Python's `sorted()` and Java's `Arrays.sort()` for objects due to its stability and guaranteed O(n log n) performance."}
]' WHERE slug = 'sorting-algorithms';

-- Search Algorithms
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Linear Search"},
  {"type": "text", "content": "**Linear search** checks each element one by one until the target is found or the list ends."},
  {"type": "list", "items": [
    "Time complexity: **O(n)**",
    "Works on unsorted and sorted arrays",
    "No preprocessing required"
  ]},
  {"type": "code", "language": "python", "content": "def linear_search(arr, target):\n    for i, val in enumerate(arr):\n        if val == target:\n            return i\n    return -1"},
  {"type": "heading", "content": "Binary Search"},
  {"type": "text", "content": "**Binary search** divides the search interval in half each step. Requires a **sorted array**."},
  {"type": "list", "items": [
    "Time complexity: **O(log n)**",
    "Requires sorted data",
    "Much faster than linear search for large datasets"
  ]},
  {"type": "code", "language": "python", "content": "def binary_search(arr, target):\n    lo, hi = 0, len(arr) - 1\n    while lo <= hi:\n        mid = (lo + hi) // 2\n        if arr[mid] == target:\n            return mid\n        elif arr[mid] < target:\n            lo = mid + 1\n        else:\n            hi = mid - 1\n    return -1"},
  {"type": "tip", "content": "Binary search on an array of 1 billion elements needs at most 30 comparisons — that is the power of O(log n)!"}
]' WHERE slug = 'search-algorithms';

-- Relational Databases
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is a Relational Database?"},
  {"type": "text", "content": "A **relational database** stores data in tables (relations) with rows (tuples) and columns (attributes). Tables are linked through keys."},
  {"type": "heading", "content": "Key Concepts"},
  {"type": "list", "items": [
    "**Primary Key**: Uniquely identifies each row",
    "**Foreign Key**: References a primary key in another table",
    "**Candidate Key**: A minimal set of columns that can uniquely identify a row",
    "**Composite Key**: A primary key made of multiple columns"
  ]},
  {"type": "heading", "content": "SQL Basics"},
  {"type": "code", "language": "sql", "content": "SELECT name, email\nFROM users\nWHERE age > 18\nORDER BY name;"},
  {"type": "list", "items": [
    "**DDL**: CREATE, ALTER, DROP (define structure)",
    "**DML**: SELECT, INSERT, UPDATE, DELETE (manipulate data)",
    "**DCL**: GRANT, REVOKE (control access)"
  ]},
  {"type": "tip", "content": "Always normalize your database to at least **Third Normal Form (3NF)** to reduce redundancy and improve data integrity."},
  {"type": "example", "content": "A university database might have tables for `students`, `courses`, and `enrollments`. The `enrollments` table uses foreign keys to link students and courses."}
]' WHERE slug = 'relational-databases';

-- Normalization
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Why Normalize?"},
  {"type": "text", "content": "**Normalization** organizes database tables to reduce redundancy and improve data integrity. It eliminates anomalies during insert, update, and delete operations."},
  {"type": "heading", "content": "Normal Forms"},
  {"type": "list", "items": [
    "**1NF**: Each column contains atomic (indivisible) values; no repeating groups",
    "**2NF**: In 1NF + every non-key column depends on the entire primary key",
    "**3NF**: In 2NF + no transitive dependencies (non-key depends only on the key)",
    "**BCNF**: In 3NF + every determinant is a candidate key"
  ]},
  {"type": "tip", "content": "For most applications, achieving **3NF** is sufficient. Over-normalizing can lead to complex joins and poor performance."},
  {"type": "heading", "content": "Denormalization"},
  {"type": "text", "content": "Sometimes you intentionally **denormalize** to improve read performance by reducing joins. Common in data warehouses and reporting systems."},
  {"type": "example", "content": "An `orders` table with `customer_name` directly stored (instead of just `customer_id`) violates 3NF but avoids a JOIN for every query."},
  {"type": "warning", "content": "Denormalization introduces data redundancy. You must ensure all copies stay in sync during updates."}
]' WHERE slug = 'normalization';

-- OSI Model
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "The 7 Layers"},
  {"type": "text", "content": "The **OSI (Open Systems Interconnection)** model divides network communication into 7 layers. Each layer has a specific function."},
  {"type": "list", "items": [
    "**Layer 7 - Application**: HTTP, FTP, SMTP (user interface)",
    "**Layer 6 - Presentation**: Encryption, compression, translation",
    "**Layer 5 - Session**: Manages connections between applications",
    "**Layer 4 - Transport**: TCP, UDP (end-to-end communication)",
    "**Layer 3 - Network**: IP, routing (packet forwarding)",
    "**Layer 2 - Data Link**: MAC addresses, frames (local delivery)",
    "**Layer 1 - Physical**: Cables, signals (bit transmission)"
  ]},
  {"type": "tip", "content": "Remember: **A**ll **P**eople **S**eem **T**o **N**eed **D**ata **P**rocessing (Application, Presentation, Session, Transport, Network, Data Link, Physical)."},
  {"type": "heading", "content": "Key Layers for ITPEC"},
  {"type": "text", "content": "For the exam, focus on **Layer 4 (Transport)** for TCP/UDP and **Layer 3 (Network)** for IP addressing and routing."},
  {"type": "warning", "content": "Don't confuse the OSI model with the TCP/IP model, which has only 4 layers: Link, Internet, Transport, Application."}
]' WHERE slug = 'osi-model';

-- TCP/IP Protocol
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "TCP vs UDP"},
  {"type": "text", "content": "**TCP (Transmission Control Protocol)** and **UDP (User Datagram Protocol)** are the two main transport layer protocols."},
  {"type": "list", "items": [
    "**TCP**: Reliable, connection-oriented, ordered delivery. Used for web, email, file transfer",
    "**UDP**: Unreliable, connectionless, faster. Used for streaming, gaming, DNS"
  ]},
  {"type": "heading", "content": "TCP Connection"},
  {"type": "text", "content": "TCP uses a **three-way handshake** to establish a connection:"},
  {"type": "list", "items": [
    "**SYN**: Client sends synchronization request",
    "**SYN-ACK**: Server acknowledges and synchronizes",
    "**ACK**: Client acknowledges — connection established"
  ]},
  {"type": "heading", "content": "IP Addressing"},
  {"type": "list", "items": [
    "**IPv4**: 32-bit address (e.g., 192.168.1.1), about 4.3 billion addresses",
    "**IPv6**: 128-bit address, virtually unlimited addresses",
    "**Subnet Mask**: Divides IP into network and host portions",
    "**CIDR**: Classless Inter-Domain Routing (e.g., 192.168.1.0/24)"
  ]},
  {"type": "tip", "content": "Port numbers identify specific processes: HTTP = 80, HTTPS = 443, SSH = 22, DNS = 53, SMTP = 25."},
  {"type": "example", "content": "When you visit a website, your browser opens a TCP connection to port 80 or 443 of the server, sends an HTTP request, and receives the response."}
]' WHERE slug = 'tcp-ip-protocol';

-- Process Management
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is a Process?"},
  {"type": "text", "content": "A **process** is a program in execution. The OS manages processes by allocating CPU time, memory, and resources."},
  {"type": "heading", "content": "Process States"},
  {"type": "list", "items": [
    "**New**: Process is being created",
    "**Ready**: Waiting for CPU time",
    "**Running**: Currently executing on CPU",
    "**Waiting/Blocked**: Waiting for I/O or event",
    "**Terminated**: Finished execution"
  ]},
  {"type": "heading", "content": "Scheduling Algorithms"},
  {"type": "list", "items": [
    "**FCFS (First Come First Served)**: Simple, may cause convoy effect",
    "**SJF (Shortest Job First)**: Optimal average wait time, hard to predict",
    "**Round Robin**: Each process gets a time quantum, fair but context switch overhead",
    "**Priority Scheduling**: Higher priority processes run first"
  ]},
  {"type": "tip", "content": "**Context switching** is the process of saving and restoring CPU state when switching between processes. It adds overhead."},
  {"type": "warning", "content": "**Deadlock** occurs when two or more processes wait indefinitely for each other to release resources."}
]' WHERE slug = 'process-management';

-- Memory Management OS
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Virtual Memory"},
  {"type": "text", "content": "**Virtual memory** gives each process the illusion of having its own contiguous address space, even if physical memory is fragmented."},
  {"type": "heading", "content": "Paging"},
  {"type": "list", "items": [
    "Memory is divided into fixed-size blocks called **pages** (logical) and **frames** (physical)",
    "**Page table** maps logical addresses to physical addresses",
    "**Page fault**: Page not in memory — OS must load it from disk"
  ]},
  {"type": "heading", "content": "Segmentation"},
  {"type": "text", "content": "**Segmentation** divides memory into variable-size segments based on logical divisions (code, data, stack)."},
  {"type": "list", "items": [
    "Each segment has a base address and length",
    "More aligned with program structure than paging",
    "Can lead to external fragmentation"
  ]},
  {"type": "tip", "content": "**Thrashing** occurs when the system spends more time swapping pages than executing. It happens when memory is overcommitted."},
  {"type": "example", "content": "With 4KB pages, a 1GB process needs 262,144 page table entries. Multi-level page tables reduce this overhead."}
]' WHERE slug = 'memory-management-os';

-- SDLC Overview
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is SDLC?"},
  {"type": "text", "content": "The **Software Development Life Cycle (SDLC)** is a structured process for planning, creating, testing, and deploying software systems."},
  {"type": "heading", "content": "SDLC Phases"},
  {"type": "list", "items": [
    "**Planning**: Define scope, feasibility, resources",
    "**Analysis**: Gather requirements from stakeholders",
    "**Design**: System architecture, UI/UX, database design",
    "**Implementation**: Write the code",
    "**Testing**: Verify the software works correctly",
    "**Deployment**: Release to production",
    "**Maintenance**: Bug fixes, updates, improvements"
  ]},
  {"type": "heading", "content": "SDLC Models"},
  {"type": "list", "items": [
    "**Waterfall**: Sequential, each phase must complete before the next",
    "**Iterative**: Repeated cycles, each builds on the previous",
    "**Spiral**: Risk-driven, combines iterative with waterfall",
    "**V-Model**: Each development phase has a corresponding test phase"
  ]},
  {"type": "tip", "content": "The **V-Model** pairs each development phase with a testing phase: Requirements → Acceptance Testing, Design → Integration Testing, etc."},
  {"type": "warning", "content": "Skipping the requirements phase is the #1 cause of project failure. Always invest time in understanding what the user needs."}
]' WHERE slug = 'sdlc-overview';

-- Agile Methodology
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Agile Principles"},
  {"type": "text", "content": "Agile is an iterative approach to software development that delivers small, working increments frequently. It values **individuals and interactions** over processes and tools."},
  {"type": "list", "items": [
    "Customer collaboration over contract negotiation",
    "Responding to change over following a plan",
    "Working software over comprehensive documentation"
  ]},
  {"type": "heading", "content": "Scrum Framework"},
  {"type": "list", "items": [
    "**Sprint**: Fixed time period (1-4 weeks) for completing work",
    "**Product Backlog**: Prioritized list of features",
    "**Sprint Backlog**: Items selected for the current sprint",
    "**Daily Standup**: 15-min daily meeting: What did I do? What will I do? Any blockers?",
    "**Sprint Review**: Demo completed work to stakeholders",
    "**Retrospective**: Team reflects on how to improve"
  ]},
  {"type": "heading", "content": "Roles in Scrum"},
  {"type": "list", "items": [
    "**Product Owner**: Defines priorities and manages the backlog",
    "**Scrum Master**: Facilitates the process, removes blockers",
    "**Development Team**: Cross-functional team that builds the product"
  ]},
  {"type": "tip", "content": "The **Daily Standup** should be time-boxed to 15 minutes. If discussions go longer, schedule a separate meeting."},
  {"type": "example", "content": "In a 2-week sprint, the team selects 10 story points of work. If they complete 8, the velocity is 8, helping plan future sprints."}
]' WHERE slug = 'agile-methodology';

-- ============================================================
-- SECURITY
-- ============================================================

-- Symmetric Encryption
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "How Symmetric Encryption Works"},
  {"type": "text", "content": "**Symmetric encryption** uses the **same key** to encrypt and decrypt data. Both sender and receiver must share the secret key."},
  {"type": "list", "items": [
    "**DES**: 56-bit key, now considered insecure",
    "**3DES**: Applies DES three times, 112/168-bit effective key",
    "**AES**: 128/192/256-bit key, current standard",
    "**ChaCha20**: Modern stream cipher, used in TLS 1.3"
  ]},
  {"type": "heading", "content": "Modes of Operation"},
  {"type": "list", "items": [
    "**ECB (Electronic Codebook)**: Encrypts each block independently — insecure (patterns visible)",
    "**CBC (Cipher Block Chaining)**: Each block XORed with previous ciphertext — needs IV",
    "**CTR**: Turns block cipher into stream cipher — parallelizable",
    "**GCM**: Authenticated encryption — provides confidentiality and integrity"
  ]},
  {"type": "tip", "content": "Never use **ECB mode** for encrypting more than one block — it leaks patterns in the data."},
  {"type": "warning", "content": "The biggest challenge with symmetric encryption is **key distribution** — how do you securely share the key?"}
]' WHERE slug = 'symmetric-encryption';

-- Asymmetric Encryption
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Public-Key Cryptography"},
  {"type": "text", "content": "**Asymmetric encryption** uses a **key pair**: a public key (shared openly) and a private key (kept secret). Data encrypted with one key can only be decrypted with the other."},
  {"type": "heading", "content": "Common Algorithms"},
  {"type": "list", "items": [
    "**RSA**: Based on factoring large prime numbers. 2048-bit or 4096-bit keys",
    "**ECC (Elliptic Curve)**: Same security as RSA with smaller keys. 256-bit ECC ≈ 3072-bit RSA",
    "**Diffie-Hellman**: Key exchange protocol, not encryption directly",
    "**DSA**: Digital Signature Algorithm"
  ]},
  {"type": "heading", "content": "Use Cases"},
  {"type": "list", "items": [
    "**Key Exchange**: Securely share symmetric keys",
    "**Digital Signatures**: Prove authenticity and integrity",
    "**Encryption**: Small amounts of data (too slow for large data)"
  ]},
  {"type": "tip", "content": "In practice, asymmetric encryption is used to exchange a **session key**, which is then used for symmetric encryption of the actual data."},
  {"type": "example", "content": "When you visit an HTTPS site, your browser uses the server's public key (from its certificate) to negotiate a symmetric session key for the session."}
]' WHERE slug = 'asymmetric-encryption';

-- Firewalls
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is a Firewall?"},
  {"type": "text", "content": "A **firewall** is a network security device that monitors and filters incoming and outgoing traffic based on security rules."},
  {"type": "heading", "content": "Types of Firewalls"},
  {"type": "list", "items": [
    "**Packet Filtering**: Examines headers (IP, port) — fast but limited",
    "**Stateful Inspection**: Tracks connection state — more secure",
    "**Application Layer**: Inspects payload content (deep packet inspection)",
    "**Proxy Firewall**: Acts as intermediary between client and server",
    "**Next-Gen Firewall (NGFW)**: Combines traditional with IPS, application awareness"
  ]},
  {"type": "heading", "content": "Firewall Rules"},
  {"type": "text", "content": "Rules define what traffic to allow or block. They typically specify:"},
  {"type": "list", "items": [
    "**Source/Destination IP** address",
    "**Port number** (e.g., 80 for HTTP, 443 for HTTPS)",
    "**Protocol** (TCP, UDP, ICMP)",
    "**Action**: Allow or Deny"
  ]},
  {"type": "tip", "content": "Default policy should be **deny all** — only allow traffic that is explicitly needed."},
  {"type": "warning", "content": "Firewalls cannot protect against insider threats or attacks that use allowed ports (e.g., HTTPS on port 443)."}
]' WHERE slug = 'firewalls';

-- HTTPS and SSL/TLS
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is SSL/TLS?"},
  {"type": "text", "content": "**SSL (Secure Sockets Layer)** and its successor **TLS (Transport Layer Security)** provide encrypted communication over the internet. HTTPS = HTTP + TLS."},
  {"type": "heading", "content": "TLS Handshake"},
  {"type": "list", "items": [
    "**Client Hello**: Client sends supported TLS versions and cipher suites",
    "**Server Hello**: Server selects a cipher suite and sends its certificate",
    "**Certificate Verification**: Client verifies the server's certificate with a CA",
    "**Key Exchange**: Client generates a pre-master secret, encrypts it with server's public key",
    "**Session Key**: Both sides derive the same session key for symmetric encryption"
  ]},
  {"type": "heading", "content": "Digital Certificates"},
  {"type": "list", "items": [
    "**X.509**: Standard certificate format",
    "**CA (Certificate Authority)**: Trusted entity that issues certificates",
    "**Certificate Chain**: Root CA → Intermediate CA → Server Certificate",
    "**Let's Encrypt**: Free CA that provides automated certificates"
  ]},
  {"type": "tip", "content": "TLS 1.3 is faster and more secure than TLS 1.2. It removed support for weak cipher suites and reduced the handshake to 1 round trip."},
  {"type": "warning", "content": "SSL 2.0 and 3.0 are deprecated. Always use **TLS 1.2** or **TLS 1.3**."}
]' WHERE slug = 'https-ssl-tls';

-- Authentication Methods
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Authentication Factors"},
  {"type": "text", "content": "Authentication verifies identity using one or more factors:"},
  {"type": "list", "items": [
    "**Something you know**: Password, PIN, security questions",
    "**Something you have**: Smart card, token, phone (OTP)",
    "**Something you are**: Fingerprint, face, iris (biometrics)"
  ]},
  {"type": "heading", "content": "Multi-Factor Authentication (MFA)"},
  {"type": "text", "content": "**MFA** combines two or more factors for stronger security. Example: password + SMS code = something you know + something you have."},
  {"type": "list", "items": [
    "**TOTP (Time-based OTP)**: Codes that change every 30 seconds (Google Authenticator)",
    "**HOTP (HMAC-based OTP)**: Counter-based codes",
    "**FIDO2/WebAuthn**: Hardware security keys (YubiKey)"
  ]},
  {"type": "heading", "content": "Password Security"},
  {"type": "list", "items": [
    "Use **salted hashing** (bcrypt, Argon2) — never store plaintext passwords",
    "Enforce minimum length (12+ characters) over complexity rules",
    "Check against **breached password databases** (Have I Been Pwned)"
  ]},
  {"type": "tip", "content": "**Passwordless authentication** (biometrics, magic links, FIDO2) is increasingly popular as it eliminates password-related risks."},
  {"type": "warning", "content": "SMS-based OTP is vulnerable to **SIM swapping** attacks. Prefer TOTP apps or hardware keys for MFA."}
]' WHERE slug = 'authentication-methods';

-- Common Attack Types
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Web Application Attacks"},
  {"type": "list", "items": [
    "**SQL Injection**: Malicious SQL in user input to manipulate queries. Prevent with parameterized queries",
    "**XSS (Cross-Site Scripting)**: Injecting scripts into web pages. Prevent with input sanitization and CSP",
    "**CSRF**: Forcing users to execute unwanted actions. Prevent with CSRF tokens",
    "**Directory Traversal**: Accessing files outside the web root. Prevent with input validation"
  ]},
  {"type": "heading", "content": "Social Engineering Attacks"},
  {"type": "list", "items": [
    "**Phishing**: Deceptive emails/websites to steal credentials",
    "**Spear Phishing**: Targeted phishing at specific individuals",
    "**Pretexting**: Creating a fake scenario to extract information",
    "**Baiting**: Leaving infected USB drives for victims to find"
  ]},
  {"type": "heading", "content": "Network Attacks"},
  {"type": "list", "items": [
    "**DDoS**: Overwhelming a server with traffic from multiple sources",
    "**Man-in-the-Middle**: Intercepting communications between two parties",
    "**ARP Spoofing**: Mapping attacker's MAC to another host's IP",
    "**DNS Spoofing**: Redirecting domain names to malicious IPs"
  ]},
  {"type": "tip", "content": "**Defense in depth** is key: use input validation, parameterized queries, HTTPS, firewalls, and user education together."},
  {"type": "example", "content": "A SQL injection attack might use `' OR '1'='1` in a login form to bypass authentication. Always use prepared statements!"}
]' WHERE slug = 'common-attack-types';

-- ============================================================
-- MANAGEMENT
-- ============================================================

-- Waterfall vs Agile
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Waterfall Model"},
  {"type": "text", "content": "**Waterfall** is a sequential approach where each phase must complete before the next begins. Progress flows downward like a waterfall."},
  {"type": "list", "items": [
    "Best for projects with **well-defined, stable requirements**",
    "Clear milestones and documentation",
    "Difficult to accommodate changes once a phase is complete",
    "Testing happens late in the process"
  ]},
  {"type": "heading", "content": "Agile Approach"},
  {"type": "text", "content": "**Agile** delivers working software in short iterations (sprints). Requirements can evolve based on feedback."},
  {"type": "list", "items": [
    "Best for projects with **evolving or unclear requirements**",
    "Continuous feedback from stakeholders",
    "Testing is integrated throughout",
    "Requires active customer participation"
  ]},
  {"type": "heading", "content": "When to Use Which?"},
  {"type": "list", "items": [
    "**Waterfall**: Government contracts, safety-critical systems, fixed-price projects",
    "**Agile**: Startups, product development, projects with uncertain requirements",
    "**Hybrid**: Combine both — use Waterfall for planning, Agile for development"
  ]},
  {"type": "tip", "content": "The **Standish Group CHAOS Report** consistently shows higher success rates for Agile projects compared to Waterfall."},
  {"type": "warning", "content": "Agile is not an excuse for no planning. Without a clear product vision, Agile can lead to scope creep and budget overruns."}
]' WHERE slug = 'waterfall-vs-agile';

-- Risk Management
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is Risk Management?"},
  {"type": "text", "content": "**Risk management** is the process of identifying, analyzing, and responding to project risks to minimize their impact."},
  {"type": "heading", "content": "Risk Management Process"},
  {"type": "list", "items": [
    "**Identification**: Brainstorm and document potential risks",
    "**Analysis**: Assess probability and impact (qualitative and quantitative)",
    "**Response Planning**: Choose strategies to address risks",
    "**Monitoring**: Track risks and trigger response plans as needed"
  ]},
  {"type": "heading", "content": "Risk Response Strategies"},
  {"type": "list", "items": [
    "**Avoid**: Eliminate the risk by changing plans",
    "**Mitigate**: Reduce probability or impact",
    "**Transfer**: Shift risk to a third party (insurance, outsourcing)",
    "**Accept**: Acknowledge the risk and prepare contingency"
  ]},
  {"type": "tip", "content": "Use a **risk matrix** (probability × impact) to prioritize risks. Focus on high-probability, high-impact risks first."},
  {"type": "example", "content": "A risk register might list: \"Key developer may leave\" — Probability: Medium, Impact: High. Response: Cross-train team members and document knowledge."}
]' WHERE slug = 'risk-management';

-- Testing Types
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Testing Levels"},
  {"type": "list", "items": [
    "**Unit Testing**: Test individual functions/methods in isolation",
    "**Integration Testing**: Test how modules work together",
    "**System Testing**: Test the complete application end-to-end",
    "**Acceptance Testing**: Verify the system meets business requirements"
  ]},
  {"type": "heading", "content": "Functional Testing Types"},
  {"type": "list", "items": [
    "**Black-box Testing**: Test without knowing internal code (focus on inputs/outputs)",
    "**White-box Testing**: Test with knowledge of internal code structure",
    "**Regression Testing**: Re-test after changes to ensure nothing broke",
    "**Smoke Testing**: Quick test to verify basic functionality works"
  ]},
  {"type": "heading", "content": "Non-Functional Testing"},
  {"type": "list", "items": [
    "**Performance Testing**: Measure response times and throughput",
    "**Load Testing**: Test under expected load",
    "**Stress Testing**: Test beyond normal capacity",
    "**Security Testing**: Find vulnerabilities and weaknesses",
    "**Usability Testing**: Evaluate user experience"
  ]},
  {"type": "tip", "content": "The **Testing Pyramid** suggests: many unit tests at the base, fewer integration tests in the middle, and minimal end-to-end tests at the top."},
  {"type": "warning", "content": "Testing cannot prove the absence of bugs — only their presence. Aim for risk-based testing coverage."}
]' WHERE slug = 'testing-types';

-- DevOps Basics
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is DevOps?"},
  {"type": "text", "content": "**DevOps** combines Development and Operations to shorten the software delivery lifecycle through automation, collaboration, and continuous improvement."},
  {"type": "heading", "content": "Key DevOps Practices"},
  {"type": "list", "items": [
    "**CI (Continuous Integration)**: Developers merge code frequently, automated tests run on every change",
    "**CD (Continuous Delivery/Deployment)**: Code is automatically built, tested, and released",
    "**Infrastructure as Code (IaC)**: Manage infrastructure through code (Terraform, Ansible)",
    "**Monitoring & Logging**: Track application health and performance (Prometheus, ELK stack)"
  ]},
  {"type": "heading", "content": "DevOps Toolchain"},
  {"type": "list", "items": [
    "**Version Control**: Git, GitHub, GitLab",
    "**CI/CD**: Jenkins, GitHub Actions, GitLab CI",
    "**Containers**: Docker, Kubernetes",
    "**Configuration Management**: Ansible, Chef, Puppet",
    "**Monitoring**: Prometheus, Grafana, Datadog"
  ]},
  {"type": "tip", "content": "**DevOps is a culture, not just tools.** It requires collaboration between development, operations, and QA teams."},
  {"type": "example", "content": "A typical CI/CD pipeline: Push code → Automated build → Unit tests → Integration tests → Deploy to staging → Deploy to production."}
]' WHERE slug = 'devops-basics';

-- ============================================================
-- STRATEGY
-- ============================================================

-- Patents and Copyrights
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Intellectual Property Types"},
  {"type": "list", "items": [
    "**Patent**: Protects inventions (20 years). Must be novel, non-obvious, useful",
    "**Copyright**: Protects original works of authorship (life + 70 years). Automatic upon creation",
    "**Trademark**: Protects brand names, logos, slogans. Renewable indefinitely",
    "**Trade Secret**: Protects confidential business information. No registration needed"
  ]},
  {"type": "heading", "content": "Software Patents"},
  {"type": "text", "content": "Software patents protect specific technical inventions implemented in software. They are controversial because software is often seen as abstract."},
  {"type": "list", "items": [
    "A patent grants a **20-year monopoly** in exchange for public disclosure",
    "**Utility patents**: New processes, machines, or compositions",
    "**Design patents**: Ornamental designs for functional items"
  ]},
  {"type": "heading", "content": "Open Source & Copyright"},
  {"type": "list", "items": [
    "**GPL**: Derivative works must also be open source",
    "**MIT/BSD**: Permissive — can be used in proprietary software",
    "**Apache 2.0**: Permissive with patent grant"
  ]},
  {"type": "tip", "content": "Copyright protects the **expression** of an idea, not the idea itself. You can write your own spreadsheet program — you just can't copy Excel's code."},
  {"type": "warning", "content": "Using open-source code with **GPL license** in a proprietary project can force you to release your source code."}
]' WHERE slug = 'patents-and-copyrights';

-- IT Governance Frameworks
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is IT Governance?"},
  {"type": "text", "content": "**IT governance** ensures IT investments support business objectives, manages risk, and optimizes resources."},
  {"type": "heading", "content": "COBIT"},
  {"type": "list", "items": [
    "Developed by ISACA",
    "**2019 Framework**: 5 principles, 40 objectives",
    "Focuses on **aligning IT with business goals**",
    "Provides governance and management objectives",
    "Used for compliance and regulatory requirements"
  ]},
  {"type": "heading", "content": "ITIL"},
  {"type": "list", "items": [
    "Focuses on **IT service management (ITSM)**",
    "**ITIL 4**: 7 guiding principles, 4 dimensions, service value system",
    "Key practices: Incident, Problem, Change, Configuration Management",
    "Goal: Deliver value through IT services"
  ]},
  {"type": "heading", "content": "Other Frameworks"},
  {"type": "list", "items": [
    "**ISO 27001**: Information security management",
    "**CMMI**: Process improvement maturity levels",
    "**TOGAF**: Enterprise architecture framework"
  ]},
  {"type": "tip", "content": "COBIT and ITIL are complementary — COBIT focuses on governance, ITIL focuses on service delivery."},
  {"type": "example", "content": "A company might use COBIT for overall IT governance, ITIL for service management, and ISO 27001 for information security."}
]' WHERE slug = 'it-governance-frameworks';

-- SWOT Analysis
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is SWOT?"},
  {"type": "text", "content": "**SWOT Analysis** is a strategic planning tool used to evaluate an organization's internal and external environment."},
  {"type": "heading", "content": "The Four Quadrants"},
  {"type": "list", "items": [
    "**Strengths (Internal)**: What the organization does well, competitive advantages",
    "**Weaknesses (Internal)**: Areas needing improvement, resource gaps",
    "**Opportunities (External)**: Market trends, technology changes the org can exploit",
    "**Threats (External)**: Competitors, regulations, market shifts that could harm the org"
  ]},
  {"type": "heading", "content": "SWOT Matrix Strategies"},
  {"type": "list", "items": [
    "**SO (Maxi-Maxi)**: Use strengths to capitalize on opportunities",
    "**WO (Mini-Maxi)**: Overcome weaknesses by leveraging opportunities",
    "**ST (Maxi-Mini)**: Use strengths to mitigate threats",
    "**WT (Mini-Mini)**: Minimize weaknesses and avoid threats"
  ]},
  {"type": "tip", "content": "SWOT is most effective when combined with other tools like **PESTLE** (for external analysis) and **Porter's Five Forces** (for industry analysis)."},
  {"type": "example", "content": "A tech startup's SWOT: Strength = innovative product, Weakness = limited funding, Opportunity = growing market, Threat = established competitors."}
]' WHERE slug = 'swot-analysis';

-- ============================================================
-- BUSINESS
-- ============================================================

-- Cost-Benefit Analysis
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is CBA?"},
  {"type": "text", "content": "**Cost-Benefit Analysis (CBA)** compares the total expected costs of a project against its total expected benefits to determine whether it is worthwhile."},
  {"type": "heading", "content": "Key Metrics"},
  {"type": "list", "items": [
    "**ROI (Return on Investment)**: (Benefits - Costs) / Costs × 100%",
    "**NPV (Net Present Value)**: Sum of discounted future cash flows. NPV > 0 means profitable",
    "**IRR (Internal Rate of Return)**: Discount rate where NPV = 0. IRR > cost of capital is good",
    "**Payback Period**: Time to recover the initial investment"
  ]},
  {"type": "heading", "content": "Types of Costs"},
  {"type": "list", "items": [
    "**Direct Costs**: Hardware, software, personnel",
    "**Indirect Costs**: Training, maintenance, overhead",
    "**Intangible Costs**: Reduced morale, productivity loss"
  ]},
  {"type": "tip", "content": "Always consider **intangible benefits** like improved customer satisfaction or employee morale — they are real but harder to quantify."},
  {"type": "example", "content": "A project costs $100K and generates $150K in benefits over 3 years. ROI = ($150K - $100K) / $100K = 50%."}
]' WHERE slug = 'cost-benefit-analysis';

-- Procurement Process
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Procurement Overview"},
  {"type": "text", "content": "**Procurement** is the process of acquiring goods and services from external vendors. It involves planning, sourcing, contracting, and managing vendors."},
  {"type": "heading", "content": "Procurement Steps"},
  {"type": "list", "items": [
    "**Need Identification**: Determine what is needed and why",
    "**Solicitation**: Issue RFP (Request for Proposal) or RFQ (Request for Quote)",
    "**Vendor Evaluation**: Score proposals based on criteria (cost, quality, experience)",
    "**Contract Negotiation**: Finalize terms, pricing, and SLAs",
    "**Vendor Management**: Monitor performance and relationship"
  ]},
  {"type": "heading", "content": "Contract Types"},
  {"type": "list", "items": [
    "**Fixed Price**: Set total price — risk is on the vendor",
    "**Cost-Reimbursable**: Pay actual costs plus fee — risk is on the buyer",
    "**Time & Materials**: Pay hourly/daily rates — flexible but unpredictable total",
    "**Unit Price**: Pay per unit of deliverable"
  ]},
  {"type": "tip", "content": "For well-defined requirements, use **Fixed Price** contracts. For unclear scope, use **Cost-Reimbursable** with incentive clauses."},
  {"type": "warning", "content": "Always include **SLAs (Service Level Agreements)** in contracts to define expected performance and penalties for non-compliance."}
]' WHERE slug = 'procurement-process';

-- Business Process Modeling
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "What is BPM?"},
  {"type": "text", "content": "**Business Process Modeling (BPM)** visualizes and analyzes business processes to improve efficiency and effectiveness."},
  {"type": "heading", "content": "BPMN Notation"},
  {"type": "list", "items": [
    "**Events** (circles): Start, intermediate, end events",
    "**Activities** (rounded rectangles): Tasks, subprocesses",
    "**Gateways** (diamonds): Decision points (exclusive, parallel)",
    "**Flows** (arrows): Sequence flow, message flow",
    "**Swimlanes**: Pools (organizations) and lanes (roles)"
  ]},
  {"type": "heading", "content": "Process Improvement"},
  {"type": "list", "items": [
    "**Identify**: Map the current process (as-is)",
    "**Analyze**: Find bottlenecks, redundancies, and waste",
    "**Redesign**: Create the improved process (to-be)",
    "**Implement**: Roll out the new process",
    "**Monitor**: Measure performance and iterate"
  ]},
  {"type": "tip", "content": "**Lean** eliminates waste. **Six Sigma** reduces defects. Together (**Lean Six Sigma**), they maximize value and minimize variation."},
  {"type": "example", "content": "An order fulfillment process might show that 60% of time is spent waiting between steps — identifying this bottleneck leads to automation opportunities."}
]' WHERE slug = 'business-process-modeling';
