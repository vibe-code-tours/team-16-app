-- Populate one-line descriptions for every subtopic so the Learning Map
-- stops showing the "Lessons coming soon." placeholder.

UPDATE public.subtopics SET description = CASE slug
  -- Technology
  WHEN 'computer-architecture'   THEN 'CPU, memory hierarchy, and how hardware executes instructions.'
  WHEN 'data-structures'         THEN 'Arrays, lists, stacks, queues, trees, and graphs.'
  WHEN 'algorithms'              THEN 'Sorting, searching, and thinking about complexity.'
  WHEN 'databases'               THEN 'Relational databases, SQL, and normalization.'
  WHEN 'networking'              THEN 'The OSI model, TCP/IP, and how the internet moves data.'
  WHEN 'operating-systems'       THEN 'Processes, threads, and how the OS manages memory.'
  WHEN 'software-development'    THEN 'The SDLC, Agile, and modern development workflows.'
  -- Security
  WHEN 'cryptography'            THEN 'Symmetric and asymmetric encryption, and where each is used.'
  WHEN 'network-security'        THEN 'Firewalls, HTTPS, and how to keep traffic safe.'
  WHEN 'access-control'          THEN 'Passwords, MFA, and proving who a user really is.'
  WHEN 'security-threats'        THEN 'Common attacks — injection, XSS, phishing, and DDoS.'
  -- Management
  WHEN 'project-management'      THEN 'Waterfall vs Agile and managing project risk.'
  WHEN 'quality-assurance'       THEN 'Testing strategies from unit tests to end-to-end.'
  WHEN 'development-processes'   THEN 'DevOps, CI/CD, and infrastructure as code.'
  -- Strategy
  WHEN 'intellectual-property'   THEN 'Copyrights, patents, trademarks, and trade secrets.'
  WHEN 'it-governance'           THEN 'Frameworks like COBIT and ITIL that keep IT aligned with the business.'
  WHEN 'business-strategy'       THEN 'SWOT, Porter''s Five Forces, and competitive positioning.'
  -- Business
  WHEN 'finance'                 THEN 'ROI, NPV, and how projects get costed and justified.'
  WHEN 'procurement'             THEN 'RFI/RFP/RFQ, SLAs, and picking the right vendor.'
  WHEN 'business-operations'     THEN 'BPMN, process modelling, and finding the bottleneck.'
  ELSE description
END
WHERE slug IN (
  'computer-architecture','data-structures','algorithms','databases','networking',
  'operating-systems','software-development','cryptography','network-security',
  'access-control','security-threats','project-management','quality-assurance',
  'development-processes','intellectual-property','it-governance','business-strategy',
  'finance','procurement','business-operations'
);
