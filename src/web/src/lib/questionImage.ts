const QUESTION_IMAGES_PATH = '/question-images'

export interface QuestionImage {
  src: string
  alt: string
}

function resolveSource(source: string): string {
  if (/^(https?:)?\/\//.test(source) || source.startsWith('/') || source.startsWith('data:')) {
    return source
  }
  return `${QUESTION_IMAGES_PATH}/${encodeURIComponent(source)}`
}

/**
 * Turns a stored question image into something an <img> can render.
 * The database stores bare figure filenames (served from public/question-images);
 * older rows may hold a full URL or a { url, alt } object.
 */
export function toQuestionImage(image: unknown, fallbackAlt: string): QuestionImage | null {
  if (typeof image === 'string' && image.trim() !== '') {
    return { src: resolveSource(image.trim()), alt: fallbackAlt }
  }
  if (image && typeof image === 'object' && 'url' in image) {
    const { url, alt } = image as { url?: unknown; alt?: unknown }
    if (typeof url === 'string' && url.trim() !== '') {
      return { src: resolveSource(url.trim()), alt: typeof alt === 'string' && alt ? alt : fallbackAlt }
    }
  }
  return null
}
