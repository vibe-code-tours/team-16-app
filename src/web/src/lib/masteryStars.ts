export const MAX_MASTERY_STARS = 3
export const MIN_QUESTIONS_FOR_STARS = 5
export const ONE_STAR_THRESHOLD = 0.4
export const TWO_STAR_THRESHOLD = 0.7
export const THREE_STAR_THRESHOLD = 0.9

/** Returns 0–3 stars for a mastery score, or 0 until enough questions have been answered. */
export function getMasteryStars(masteryScore: number, questionsSeen: number): number {
  if (questionsSeen < MIN_QUESTIONS_FOR_STARS) return 0
  if (masteryScore >= THREE_STAR_THRESHOLD) return 3
  if (masteryScore >= TWO_STAR_THRESHOLD) return 2
  if (masteryScore >= ONE_STAR_THRESHOLD) return 1
  return 0
}
