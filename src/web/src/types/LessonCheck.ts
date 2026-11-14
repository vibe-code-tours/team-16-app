/**
 * Inline one-question checkpoint stored in a lesson's `content_blocks`.
 * `answer` is the zero-based index of the correct entry in `choices`.
 */
export interface LessonCheck {
  type: 'check'
  question: string
  choices: string[]
  answer: number
  explanation?: string
}
