-- Question 12: Network Availability Calculation
-- Bus network topology with server, clients, and printers
-- Tests understanding of system availability with parallel components

INSERT INTO questions (
  exam_session,
  subject,
  question_number,
  difficulty,
  question_text,
  content_blocks,
  choices,
  correct_answer,
  explanation
) VALUES (
  '2025-october',
  'A',
  12,
  'medium',
  'One (1) server, three (3) clients, and two (2) printers are connected via a LAN as shown in the figure below. This system prints data that is located on the server in response to instructions from the clients. When the availability of each device is as shown in the table below, which of the following is the expression that represents the availability for the system? Here, the system is considered available if one (1) of the three (3) clients and one (1) of the two (2) printers are running.',
  '[
    {
      "type": "text",
      "text": "**Network Topology:** Bus network with the following devices:"
    },
    {
      "type": "markdown",
      "text": "| Device | Availability |\n|--------|--------------|\n| Server | a |\n| Client | b |\n| Printer | c |\n| LAN | 1 |"
    },
    {
      "type": "text",
      "text": "**System Availability Condition:** The system is available if:\n- The server is available AND\n- At least one of the three clients is available AND\n- At least one of the two printers is available"
    }
  ]'::jsonb,
  '[
    {"label": "a", "text": "ab³c²"},
    {"label": "b", "text": "a(1-b³)(1-c²)"},
    {"label": "c", "text": "a(1-b)³(1-c)²"},
    {"label": "d", "text": "a(1-(1-b)³)(1-(1-c)²)"}
  ]'::jsonb,
  'd',
  'The correct answer is **d) a(1-(1-b)³)(1-(1-c)²)**.\n\n**Explanation:**\n\n1. **Server availability:** The server must be available → factor of `a`\n\n2. **Client availability:** At least one of 3 clients must work. The probability that ALL clients fail is (1-b)³, so the probability that at least one works is:\n   `1 - (1-b)³`\n\n3. **Printer availability:** At least one of 2 printers must work. The probability that ALL printers fail is (1-c)², so the probability that at least one works is:\n   `1 - (1-c)²`\n\n4. **System availability:** All components are independent, so multiply:\n   `a × (1-(1-b)³) × (1-(1-c)²)`\n\nThis matches option **d**.'
)
ON CONFLICT (exam_session, subject, question_number) DO UPDATE
SET
  question_text = EXCLUDED.question_text,
  content_blocks = EXCLUDED.content_blocks,
  choices = EXCLUDED.choices,
  correct_answer = EXCLUDED.correct_answer,
  explanation = EXCLUDED.explanation,
  updated_at = now();
