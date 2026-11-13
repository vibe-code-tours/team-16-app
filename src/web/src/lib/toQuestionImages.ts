export interface QuestionImage {
  url: string
  alt: string
}

/**
 * Normalise the loosely typed `images` array from the quiz API (plain URL strings
 * or `{ url, alt? }` objects) into the shape `QuestionBlock` renders. Unknown
 * entries are dropped.
 */
export function toQuestionImages(images: unknown[] | undefined): QuestionImage[] {
  if (!images) return []
  return images.flatMap((img): QuestionImage[] => {
    if (typeof img === 'string') return [{ url: img, alt: '' }]
    if (img && typeof img === 'object' && 'url' in img && typeof img.url === 'string') {
      const alt = 'alt' in img && typeof img.alt === 'string' ? img.alt : ''
      return [{ url: img.url, alt }]
    }
    return []
  })
}
