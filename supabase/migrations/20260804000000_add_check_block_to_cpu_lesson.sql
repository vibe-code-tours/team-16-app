-- Adds an inline "check" block (one-question checkpoint) to the seeded
-- "What is a CPU?" lesson so the new block type is visible in the demo.
-- Data-only change: content_blocks is already jsonb, no schema change.
-- Block shape: { type, question, choices[], answer (zero-based index), explanation }.
-- Idempotent: skipped if the lesson already contains a check block.
UPDATE public.lessons AS l
SET content_blocks = l.content_blocks || jsonb_build_array(
      jsonb_build_object(
        'type', 'check',
        'question', 'Which CPU component performs arithmetic and logic operations?',
        'choices', jsonb_build_array('Control Unit', 'ALU (Arithmetic Logic Unit)', 'Registers', 'Cache'),
        'answer', 1,
        'explanation', 'The **ALU** does the math and logic. The Control Unit directs the flow of data, while registers and cache are small, fast storage.'
      )
    ),
    updated_at = now()
FROM public.subtopics AS s
WHERE l.subtopic_id = s.id
  AND s.slug = 'computer-architecture'
  AND l.slug = 'what-is-a-cpu'
  AND NOT l.content_blocks @> '[{"type": "check"}]'::jsonb;
