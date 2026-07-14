-- Populate content_blocks for lessons that have empty content

-- Memory Hierarchy
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Understanding Memory Hierarchy"},
  {"type": "text", "content": "Computer memory is organized in a hierarchy based on speed, size, and cost. Faster memory is more expensive and smaller, while slower memory is cheaper and larger."},
  {"type": "list", "items": [
    "**Registers**: Fastest, smallest (bytes), inside CPU",
    "**Cache**: Fast, small (KB-MB), close to CPU",
    "**RAM**: Moderate speed, large (GB), main memory",
    "**Storage**: Slowest, largest (TB), persistent"
  ]},
  {"type": "tip", "content": "The CPU spends most of its time waiting for data from memory. A good memory hierarchy reduces this wait time significantly."},
  {"type": "example", "content": "When you run a program, the OS loads it from storage into RAM, then frequently accessed data is cached in L1/L2 cache for fast CPU access."}
]'::jsonb WHERE slug = 'memory-hierarchy';

-- Instruction Set Architecture
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "RISC vs CISC"},
  {"type": "text", "content": "Instruction Set Architecture (ISA) defines the set of instructions a CPU can execute. The two main philosophies are RISC and CISC."},
  {"type": "list", "items": [
    "**RISC** (Reduced Instruction Set Computer): Simple, fast instructions",
    "**CISC** (Complex Instruction Set Computer): Complex, multi-step instructions",
    "Modern CPUs often use a hybrid approach"
  ]},
  {"type": "example", "content": "ARM processors use RISC (found in smartphones), while x86 processors use CISC (found in desktops/laptops)."},
  {"type": "warning", "content": "RISC vs CISC is not about which is better overall - each has trade-offs in power consumption, performance, and code density."}
]'::jsonb WHERE slug = 'instruction-set-architecture';

-- Arrays and Lists
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Arrays and Lists"},
  {"type": "text", "content": "Arrays store elements of the same type in contiguous memory locations. Lists (linked lists) store elements as nodes connected by pointers."},
  {"type": "heading", "content": "Key Differences"},
  {"type": "list", "items": [
    "**Array**: Fixed size, O(1) random access, O(n) insertion/deletion",
    "**Linked List**: Dynamic size, O(n) random access, O(1) insertion/deletion (at head)",
    "Arrays have better cache locality"
  ]},
  {"type": "tip", "content": "Use arrays when you need fast random access and know the size upfront. Use linked lists when you frequently insert/delete elements."}
]'::jsonb WHERE slug = 'arrays-and-lists';

-- Stacks and Queues
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Stacks and Queues"},
  {"type": "text", "content": "Stacks and queues are abstract data types that control how elements are added and removed."},
  {"type": "heading", "content": "Stack (LIFO)"},
  {"type": "list", "items": [
    "Last In, First Out",
    "Operations: push(), pop(), peek()",
    "Used in function calls and undo operations"
  ]},
  {"type": "heading", "content": "Queue (FIFO)"},
  {"type": "list", "items": [
    "First In, First Out",
    "Operations: enqueue(), dequeue(), front()",
    "Used in print spooling and BFS algorithms"
  ]},
  {"type": "example", "content": "A browser''s back button uses a stack. A printer queue uses a queue."}
]'::jsonb WHERE slug = 'stacks-and-queues';

-- Trees and Graphs
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Trees and Graphs"},
  {"type": "text", "content": "Trees and graphs are non-linear data structures used to represent hierarchical and network relationships."},
  {"type": "heading", "content": "Trees"},
  {"type": "list", "items": [
    "Hierarchical structure with root and children",
    "Binary trees, AVL trees, B-trees",
    "Used in file systems and databases"
  ]},
  {"type": "heading", "content": "Graphs"},
  {"type": "list", "items": [
    "Nodes connected by edges",
    "Directed/undirected, weighted/unweighted",
    "Used in social networks and routing"
  ]},
  {"type": "tip", "content": "A tree is a special type of graph with no cycles."}
]'::jsonb WHERE slug = 'trees-and-graphs';

-- Sorting Algorithms
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Sorting Algorithms"},
  {"type": "text", "content": "Sorting arranges data in a specific order (ascending/descending). Different algorithms have different time and space complexities."},
  {"type": "heading", "content": "Common Sorting Algorithms"},
  {"type": "list", "items": [
    "**Bubble Sort**: O(n²) - Simple but slow",
    "**Merge Sort**: O(n log n) - Divide and conquer, stable",
    "**Quick Sort**: O(n log n) average - Fast but unstable",
    "**Insertion Sort**: O(n²) - Good for small datasets"
  ]},
  {"type": "example", "content": "Merge Sort divides the array into halves, sorts each half recursively, then merges them back together."}
]'::jsonb WHERE slug = 'sorting-algorithms';

-- Search Algorithms
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Linear vs Binary Search"},
  {"type": "text", "content": "Search algorithms find an element in a collection. The choice depends on whether the data is sorted."},
  {"type": "list", "items": [
    "**Linear Search**: O(n) - Works on unsorted data, checks each element",
    "**Binary Search**: O(log n) - Requires sorted data, divides search space in half"
  ]},
  {"type": "tip", "content": "Binary search is much faster than linear search for large sorted datasets. For 1 million elements, linear search takes 1M steps, binary search only 20."},
  {"type": "example", "content": "Looking up a word in a dictionary uses binary search - you open the middle and eliminate half the pages."}
]'::jsonb WHERE slug = 'search-algorithms';

-- Relational Databases
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Introduction to Relational Databases"},
  {"type": "text", "content": "Relational databases store data in tables with rows and columns. SQL (Structured Query Language) is used to query and manipulate the data."},
  {"type": "heading", "content": "Key Concepts"},
  {"type": "list", "items": [
    "**Table**: Collection of related data organized in rows and columns",
    "**Primary Key**: Uniquely identifies each row",
    "**Foreign Key**: References a primary key in another table",
    "**Normalization**: Reduces data redundancy"
  ]},
  {"type": "example", "content": "SELECT * FROM users WHERE age > 18; -- Retrieves all adult users"},
  {"type": "warning", "content": "Always use parameterized queries to prevent SQL injection attacks!"}
]'::jsonb WHERE slug = 'relational-databases';

-- Normalization
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Database Normalization"},
  {"type": "text", "content": "Normalization organizes database tables to reduce redundancy and ensure data integrity."},
  {"type": "heading", "content": "Normal Forms"},
  {"type": "list", "items": [
    "**1NF**: Each column has atomic values, no repeating groups",
    "**2NF**: 1NF + all non-key columns depend on the whole primary key",
    "**3NF**: 2NF + no transitive dependencies"
  ]},
  {"type": "example", "content": "Storing customer name in every order record violates 3NF. Instead, store customer ID and keep customer details in a separate table."},
  {"type": "tip", "content": "Most real-world databases aim for 3NF. Higher normal forms exist but are rarely needed."}
]'::jsonb WHERE slug = 'normalization';

-- OSI Model
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "The OSI Model"},
  {"type": "text", "content": "The Open Systems Interconnection (OSI) model defines 7 layers of network communication, from physical hardware to application software."},
  {"type": "heading", "content": "The 7 Layers"},
  {"type": "list", "items": [
    "**7 - Application**: HTTP, FTP, SMTP",
    "**6 - Presentation**: Data formatting, encryption",
    "**5 - Session**: Connection management",
    "**4 - Transport**: TCP, UDP - reliable delivery",
    "**3 - Network**: IP, routing",
    "**2 - Data Link**: MAC addresses, frames",
    "**1 - Physical**: Cables, signals, bits"
  ]},
  {"type": "tip", "content": "Mnemonic: Please Do Not Throw Sausage Pizza Away (Physical → Application)"}
]'::jsonb WHERE slug = 'osi-model';

-- TCP/IP Protocol
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "TCP/IP Protocol"},
  {"type": "text", "content": "TCP/IP is the fundamental protocol suite of the internet. It combines the Transmission Control Protocol and the Internet Protocol."},
  {"type": "list", "items": [
    "**IP**: Handles addressing and routing between networks",
    "**TCP**: Provides reliable, ordered data delivery",
    "**UDP**: Faster but unreliable delivery"
  ]},
  {"type": "example", "content": "When you visit a website, TCP ensures all packets arrive in order. If any packet is lost, TCP requests retransmission."},
  {"type": "warning", "content": "TCP guarantees delivery but adds latency. Use UDP for real-time applications like video streaming where speed matters more."}
]'::jsonb WHERE slug = 'tcp-ip-protocol';

-- Process Management
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Process Management"},
  {"type": "text", "content": "A process is a program in execution. The operating system manages multiple processes through scheduling."},
  {"type": "heading", "content": "Process States"},
  {"type": "list", "items": [
    "**New**: Process is being created",
    "**Ready**: Waiting for CPU time",
    "**Running**: Currently executing",
    "**Waiting**: Waiting for I/O or event",
    "**Terminated**: Finished execution"
  ]},
  {"type": "heading", "content": "Scheduling Algorithms"},
  {"type": "list", "items": [
    "First-Come, First-Served (FCFS)",
    "Shortest Job First (SJF)",
    "Round Robin (RR)",
    "Priority Scheduling"
  ]},
  {"type": "tip", "content": "Context switching between processes has overhead. Too many processes can degrade performance due to thrashing."}
]'::jsonb WHERE slug = 'process-management';

-- Memory Management (OS)
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Memory Management"},
  {"type": "text", "content": "The OS manages memory allocation between running processes using techniques like paging and segmentation."},
  {"type": "heading", "content": "Key Concepts"},
  {"type": "list", "items": [
    "**Virtual Memory**: Abstracts physical memory, gives each process its own address space",
    "**Paging**: Divides memory into fixed-size pages",
    "**Segmentation**: Divides memory into variable-sized segments",
    "**Swapping**: Moves processes between RAM and disk"
  ]},
  {"type": "example", "content": "When RAM is full, the OS moves idle pages to disk (swap file) and brings them back when needed."},
  {"type": "warning", "content": "Thrashing occurs when the OS spends more time swapping pages than executing programs."}
]'::jsonb WHERE slug = 'memory-management-os';

-- SDLC Overview
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Software Development Life Cycle"},
  {"type": "text", "content": "SDLC is a structured process for planning, creating, testing, and deploying software."},
  {"type": "heading", "content": "SDLC Phases"},
  {"type": "list", "items": [
    "**Requirements**: Gathering what the software should do",
    "**Design**: Architecture and system design",
    "**Implementation**: Writing the actual code",
    "**Testing**: Verifying correctness",
    "**Deployment**: Releasing to production",
    "**Maintenance**: Bug fixes and updates"
  ]},
  {"type": "tip", "content": "The earlier a bug is found in the SDLC, the cheaper it is to fix."}
]'::jsonb WHERE slug = 'sdlc-overview';

-- Agile Methodology
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Agile Development"},
  {"type": "text", "content": "Agile is an iterative approach to software development that emphasizes flexibility, collaboration, and customer feedback."},
  {"type": "heading", "content": "Scrum Framework"},
  {"type": "list", "items": [
    "**Sprints**: Time-boxed iterations (1-4 weeks)",
    "**Daily Standup**: Quick daily sync meeting",
    "**Product Backlog**: Prioritized feature list",
    "**Sprint Retrospective**: Review and improve"
  ]},
  {"type": "example", "content": "Instead of delivering everything at the end, Agile teams deliver working software every sprint, gathering feedback along the way."},
  {"type": "warning", "content": "Agile requires strong discipline and communication. Simply holding daily meetings doesn''t make you Agile."}
]'::jsonb WHERE slug = 'agile-methodology';

-- Symmetric Encryption
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Symmetric Encryption"},
  {"type": "text", "content": "Symmetric encryption uses the same key for both encryption and decryption."},
  {"type": "heading", "content": "Common Algorithms"},
  {"type": "list", "items": [
    "**AES** (Advanced Encryption Standard): Current standard, 128/192/256-bit keys",
    "**DES**: Older standard, 56-bit key (now insecure)",
    "**3DES**: Triple DES, more secure but slower"
  ]},
  {"type": "example", "content": "AES-256 is used by the US government for classified information. It is considered quantum-resistant."},
  {"type": "tip", "content": "The main challenge with symmetric encryption is secure key exchange - how do you share the key safely?"}
]'::jsonb WHERE slug = 'symmetric-encryption';

-- Asymmetric Encryption
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Asymmetric Encryption"},
  {"type": "text", "content": "Asymmetric encryption uses a public-private key pair. The public key encrypts, the private key decrypts."},
  {"type": "heading", "content": "Common Algorithms"},
  {"type": "list", "items": [
    "**RSA**: Based on factoring large prime numbers",
    "**ECC**: Elliptic Curve Cryptography, stronger per bit",
    "**Diffie-Hellman**: Secure key exchange protocol"
  ]},
  {"type": "example", "content": "When you visit an HTTPS website, your browser uses the server''s public key to establish a secure session."},
  {"type": "tip", "content": "Asymmetric encryption is slower than symmetric encryption. In practice, asymmetric is used to exchange a symmetric session key."}
]'::jsonb WHERE slug = 'asymmetric-encryption';

-- Firewalls
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Firewalls"},
  {"type": "text", "content": "A firewall monitors and controls incoming and outgoing network traffic based on security rules."},
  {"type": "heading", "content": "Types of Firewalls"},
  {"type": "list", "items": [
    "**Packet Filtering**: Checks source/destination IP and port",
    "**Stateful Inspection**: Tracks connection state",
    "**Application Gateway**: Inspects application-layer data",
    "**Next-Gen Firewall**: Includes IDS/IPS and threat intelligence"
  ]},
  {"type": "example", "content": "A firewall can block all incoming traffic except HTTP/HTTPS on ports 80 and 443."},
  {"type": "warning", "content": "Firewalls are not enough - they cannot detect attacks that use allowed ports (e.g., SQL injection over port 443)."}
]'::jsonb WHERE slug = 'firewalls';

-- HTTPS and SSL/TLS
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "HTTPS and SSL/TLS"},
  {"type": "text", "content": "HTTPS (HTTP Secure) encrypts communication between a browser and a web server using SSL/TLS protocols."},
  {"type": "heading", "content": "How TLS Works"},
  {"type": "list", "items": [
    "**Handshake**: Browser and server agree on encryption method",
    "**Certificate**: Server presents a digital certificate signed by a CA",
    "**Key Exchange**: Asymmetric encryption exchanges a symmetric session key",
    "**Secure Communication**: All data is encrypted with the session key"
  ]},
  {"type": "tip", "content": "Look for the padlock icon in your browser''s address bar to verify a site uses HTTPS."},
  {"type": "example", "content": "Without HTTPS, passwords and credit card numbers sent over Wi-Fi can be intercepted by anyone on the same network."}
]'::jsonb WHERE slug = 'https-ssl-tls';

-- Authentication Methods
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Authentication Methods"},
  {"type": "text", "content": "Authentication verifies who you are. Modern systems use multiple factors for better security."},
  {"type": "heading", "content": "Authentication Factors"},
  {"type": "list", "items": [
    "**Something you know**: Password, PIN",
    "**Something you have**: Phone, hardware token",
    "**Something you are**: Fingerprint, face, iris"
  ]},
  {"type": "heading", "content": "MFA (Multi-Factor Authentication)"},
  {"type": "text", "content": "MFA requires two or more factors. For example, a password (know) and a one-time code from your phone (have)."},
  {"type": "tip", "content": "Passwords alone are the weakest form of authentication. Always enable MFA when available."}
]'::jsonb WHERE slug = 'authentication-methods';

-- Common Attack Types
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Common Security Attacks"},
  {"type": "text", "content": "Understanding common attack types helps developers build more secure applications."},
  {"type": "heading", "content": "Major Attack Types"},
  {"type": "list", "items": [
    "**SQL Injection**: Malicious SQL in user input",
    "**XSS (Cross-Site Scripting)**: Injecting scripts into web pages",
    "**Phishing**: Fake emails/websites to steal credentials",
    "**Man-in-the-Middle**: Intercepting communication"
  ]},
  {"type": "example", "content": "SQL Injection: Input like `'' OR 1=1 --` can bypass authentication if not properly sanitized."},
  {"type": "warning", "content": "Always validate and sanitize user input. Never concatenate user input directly into SQL queries."}
]'::jsonb WHERE slug = 'common-attack-types';

-- Waterfall vs Agile
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Waterfall vs Agile"},
  {"type": "text", "content": "Waterfall and Agile are two fundamentally different approaches to software development."},
  {"type": "heading", "content": "Waterfall"},
  {"type": "list", "items": [
    "Sequential phases: Requirements → Design → Implementation → Testing → Deployment",
    "Each phase must complete before the next begins",
    "Rigid, hard to change requirements mid-project"
  ]},
  {"type": "heading", "content": "Agile"},
  {"type": "list", "items": [
    "Iterative with short sprints (1-4 weeks)",
    "Continuous feedback and adaptation",
    "Working software delivered incrementally"
  ]},
  {"type": "example", "content": "Waterfall works well for projects with clear, stable requirements (e.g., bridge construction). Agile suits software where requirements evolve."}
]'::jsonb WHERE slug = 'waterfall-vs-agile';

-- Risk Management
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Risk Management"},
  {"type": "text", "content": "Risk management identifies, assesses, and controls threats to a project."},
  {"type": "heading", "content": "Risk Management Process"},
  {"type": "list", "items": [
    "**Identify**: Find potential risks",
    "**Assess**: Evaluate probability and impact",
    "**Mitigate**: Plan and implement controls",
    "**Monitor**: Track risks throughout the project"
  ]},
  {"type": "example", "content": "A project risk: ''Key developer might leave.'' Mitigation: Cross-train another team member and document critical knowledge."},
  {"type": "tip", "content": "Focus on risks with high probability AND high impact. Low-impact risks can be accepted or ignored."}
]'::jsonb WHERE slug = 'risk-management';

-- Testing Types
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Software Testing Types"},
  {"type": "text", "content": "Different testing levels catch different types of bugs at different stages."},
  {"type": "heading", "content": "Testing Pyramid"},
  {"type": "list", "items": [
    "**Unit Tests**: Test individual functions/classes (fast, many)",
    "**Integration Tests**: Test component interactions",
    "**System Tests**: Test the entire application",
    "**Acceptance Tests**: Validate against requirements"
  ]},
  {"type": "example", "content": "A unit test checks if a calculator adds correctly. An integration test checks if the calculator API returns JSON."},
  {"type": "tip", "content": "Follow the testing pyramid: write many unit tests, fewer integration tests, and even fewer end-to-end tests."}
]'::jsonb WHERE slug = 'testing-types';

-- DevOps Basics
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "DevOps Fundamentals"},
  {"type": "text", "content": "DevOps combines development and operations to enable continuous delivery and faster deployment cycles."},
  {"type": "heading", "content": "Key Practices"},
  {"type": "list", "items": [
    "**CI/CD**: Continuous Integration and Continuous Deployment",
    "**Infrastructure as Code**: Managing servers with code (Terraform, Ansible)",
    "**Monitoring**: Tracking application health and performance",
    "**Microservices**: Small, independent services"
  ]},
  {"type": "example", "content": "A CI/CD pipeline automatically runs tests on every pull request and deploys to production after merge."},
  {"type": "tip", "content": "DevOps is as much about culture as tools. Break down silos between dev and ops teams."}
]'::jsonb WHERE slug = 'devops-basics';

-- Patents and Copyrights
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Intellectual Property Protection"},
  {"type": "text", "content": "Intellectual property (IP) law protects creations of the mind, including inventions, literary works, and software."},
  {"type": "heading", "content": "Types of IP Protection"},
  {"type": "list", "items": [
    "**Patents**: Protect inventions and processes (20 years)",
    "**Copyrights**: Protect creative works (author''s life + 70 years)",
    "**Trademarks**: Protect brand names and logos",
    "**Trade Secrets**: Protect confidential business information"
  ]},
  {"type": "example", "content": "Software can be protected by copyright (source code) and patents (algorithms). The Google search algorithm is a trade secret."},
  {"type": "warning", "content": "Open source licenses (GPL, MIT, Apache) grant specific permissions. Violating a license can lead to legal action."}
]'::jsonb WHERE slug = 'patents-and-copyrights';

-- IT Governance Frameworks
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "IT Governance Frameworks"},
  {"type": "text", "content": "IT governance frameworks help organizations align IT strategy with business goals and manage risk."},
  {"type": "heading", "content": "Major Frameworks"},
  {"type": "list", "items": [
    "**COBIT**: Comprehensive IT governance and management framework",
    "**ITIL**: IT service management best practices",
    "**ISO 27001**: Information security management standard"
  ]},
  {"type": "example", "content": "COBIT defines 5 domains: Evaluate, Direct, Monitor, Plan, Build, Run, Monitor."},
  {"type": "tip", "content": "These frameworks are complementary. Many organizations use COBIT for governance and ITIL for service management."}
]'::jsonb WHERE slug = 'it-governance-frameworks';

-- SWOT Analysis
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "SWOT Analysis"},
  {"type": "text", "content": "SWOT (Strengths, Weaknesses, Opportunities, Threats) is a strategic planning tool used to evaluate a business or project."},
  {"type": "heading", "content": "The Four Quadrants"},
  {"type": "list", "items": [
    "**Strengths**: Internal positive attributes (e.g., skilled team, brand)",
    "**Weaknesses**: Internal negative attributes (e.g., limited budget)",
    "**Opportunities**: External positive factors (e.g., growing market)",
    "**Threats**: External negative factors (e.g., new competitors)"
  ]},
  {"type": "example", "content": "SWOT for a startup: Strength=innovative tech, Weakness=small team, Opportunity=untapped market, Threat=big company entering same space."},
  {"type": "tip", "content": "Use SWOT to identify strategic options: leverage strengths to seize opportunities, and address weaknesses to avoid threats."}
]'::jsonb WHERE slug = 'swot-analysis';

-- Finance: Cost-Benefit Analysis
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Cost-Benefit Analysis"},
  {"type": "text", "content": "Cost-Benefit Analysis (CBA) compares the costs and benefits of a project to determine if it is financially worthwhile."},
  {"type": "heading", "content": "Key Metrics"},
  {"type": "list", "items": [
    "**Net Present Value (NPV)**: Present value of benefits minus costs",
    "**Payback Period**: Time to recover the initial investment",
    "**ROI**: Return on Investment = (Net Profit / Cost) × 100%"
  ]},
  {"type": "example", "content": "A project costs $100k and saves $30k/year. Payback period = 3.33 years. ROI = 30% annually."},
  {"type": "tip", "content": "Include intangible benefits (e.g., improved customer satisfaction) even if hard to quantify."}
]'::jsonb WHERE slug = 'cost-benefit-analysis';

-- Procurement Process
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Procurement Process"},
  {"type": "text", "content": "Procurement is the process of acquiring goods and services from external sources."},
  {"type": "heading", "content": "Procurement Steps"},
  {"type": "list", "items": [
    "**Need Identification**: Define what to purchase",
    "**Vendor Selection**: RFQ/RFP, evaluate proposals",
    "**Contract Negotiation**: Terms, pricing, SLAs",
    "**Order & Receive**: Purchase order, delivery",
    "**Payment & Review**: Invoice processing, vendor evaluation"
  ]},
  {"type": "example", "content": "A company needing cloud hosting issues an RFP, evaluates AWS/Azure/GCP, negotiates pricing, and signs a contract with SLAs."},
  {"type": "tip", "content": "Always have a clear Service Level Agreement (SLA) that defines uptime guarantees, response times, and penalties."}
]'::jsonb WHERE slug = 'procurement-process';

-- Business Process Modeling
UPDATE lessons SET content_blocks = '[
  {"type": "heading", "content": "Business Process Modeling"},
  {"type": "text", "content": "Business Process Modeling visually represents how work flows through an organization, using diagrams and notations."},
  {"type": "heading", "content": "BPMN Elements"},
  {"type": "list", "items": [
    "**Events**: Start, end, intermediate events (circles)",
    "**Activities**: Tasks and sub-processes (rounded rectangles)",
    "**Gateways**: Decision points (diamonds)",
    "**Flows**: Sequence and message flows (arrows)"
  ]},
  {"type": "example", "content": "An order process: Start → Receive Order → Check Stock → [In Stock?] → Yes: Ship → No: Order from Supplier → End"},
  {"type": "tip", "content": "BPMN is the industry standard. Swimlanes show which department or role performs each step."}
]'::jsonb WHERE slug = 'business-process-modeling';
