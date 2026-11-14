import type { LessonCheck } from '../types/LessonCheck'

const MIN_CHOICES = 2

function isNonEmptyString(value: unknown): value is string {
  return typeof value === 'string' && value.trim().length > 0
}

/**
 * Validates a raw content block from the API. Returns a typed check block,
 * or null when the block is not a well-formed `check` block.
 */
export function parseLessonCheck(block: unknown): LessonCheck | null {
  if (typeof block !== 'object' || block === null) return null

  const { type, question, choices, answer, explanation } = block as Record<string, unknown>
  if (type !== 'check' || !isNonEmptyString(question)) return null
  if (!Array.isArray(choices) || choices.length < MIN_CHOICES) return null
  if (!choices.every(isNonEmptyString)) return null
  if (new Set(choices).size !== choices.length) return null
  if (typeof answer !== 'number' || !Number.isInteger(answer)) return null
  if (answer < 0 || answer >= choices.length) return null

  return {
    type: 'check',
    question,
    choices,
    answer,
    explanation: isNonEmptyString(explanation) ? explanation : undefined,
  }
}
