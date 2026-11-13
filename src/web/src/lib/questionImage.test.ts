import { describe, it, expect } from 'vitest'
import { toQuestionImage } from './questionImage'

describe('toQuestionImage', () => {
  it('serves a bare figure filename from the question-images folder', () => {
    expect(toQuestionImage('2021-april-a-q08-figure1.webp', 'Figure 1')).toEqual({
      src: '/question-images/2021-april-a-q08-figure1.webp',
      alt: 'Figure 1',
    })
  })

  it('passes full URLs and absolute paths through unchanged', () => {
    expect(toQuestionImage('https://example.com/a.png', 'x')?.src).toBe('https://example.com/a.png')
    expect(toQuestionImage('/static/a.png', 'x')?.src).toBe('/static/a.png')
  })

  it('reads url and alt from an image object', () => {
    expect(toQuestionImage({ url: 'q01-figure1.webp', alt: 'Truth table' }, 'x')).toEqual({
      src: '/question-images/q01-figure1.webp',
      alt: 'Truth table',
    })
  })

  it('falls back to the given alt text when the object has none', () => {
    expect(toQuestionImage({ url: 'q01-figure1.webp' }, 'Figure 1')?.alt).toBe('Figure 1')
  })

  it('returns null for values that are not images', () => {
    expect(toQuestionImage('', 'x')).toBeNull()
    expect(toQuestionImage(null, 'x')).toBeNull()
    expect(toQuestionImage({ alt: 'no url' }, 'x')).toBeNull()
  })
})
