import { describe, expect, it } from 'vitest'
import { toQuestionImages } from './toQuestionImages'

describe('toQuestionImages', () => {
  it('returns an empty list when there are no images', () => {
    expect(toQuestionImages(undefined)).toEqual([])
  })

  it('accepts plain URL strings and url objects', () => {
    expect(
      toQuestionImages(['/a.png', { url: '/b.png', alt: 'Diagram' }, { url: '/c.png' }])
    ).toEqual([
      { url: '/a.png', alt: '' },
      { url: '/b.png', alt: 'Diagram' },
      { url: '/c.png', alt: '' },
    ])
  })

  it('drops entries without a usable url', () => {
    expect(toQuestionImages([null, 42, { alt: 'no url' }, { url: 7 }])).toEqual([])
  })
})
