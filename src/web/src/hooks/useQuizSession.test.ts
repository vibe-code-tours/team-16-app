import { describe, it, expect, vi, beforeEach } from 'vitest'
import { renderHook, waitFor, act } from '@testing-library/react'
import { useQuizSession } from './useQuizSession'
import { api } from '../lib/api'

vi.mock('../lib/api', () => ({
  api: { post: vi.fn() },
}))

const mockApiPost = vi.mocked(api.post)

const apiSession = {
  id: 'session-1',
  status: 'in_progress',
  questions: [
    {
      id: 'q1',
      subtopicId: 'sub-1',
      questionText: 'What is 2 + 2?',
      images: ['2021-april-a-q08-figure1.webp'],
      choices: [
        { label: 'a', text: '3' },
        { label: 'b', text: '4' },
      ],
      correctAnswer: 'b',
      explanation: 'Two plus two is four.',
    },
    {
      id: 'q2',
      subtopicId: 'sub-1',
      questionText: 'What is 3 + 3?',
      choices: [
        { label: 'a', text: '6' },
        { label: 'b', text: '9' },
      ],
      correctAnswer: 'a',
      explanation: null,
    },
  ],
}

async function startedQuiz() {
  mockApiPost.mockResolvedValue(apiSession)
  const rendered = renderHook(() => useQuizSession('sub-1'))
  act(() => rendered.result.current.startQuiz())
  await waitFor(() => expect(rendered.result.current.questions).toHaveLength(2))
  return rendered
}

describe('useQuizSession', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  it('does not load anything until the quiz is started', () => {
    const { result } = renderHook(() => useQuizSession('sub-1'))

    expect(result.current.hasStarted).toBe(false)
    expect(mockApiPost).not.toHaveBeenCalled()
  })

  it('loads five questions for the subtopic when started', async () => {
    const { result } = await startedQuiz()

    expect(mockApiPost).toHaveBeenCalledWith('/api/v1/quizzes/start', { subtopicId: 'sub-1', questionCount: 5 })
    expect(result.current.sessionId).toBe('session-1')
    expect(result.current.currentQuestion?.question_text).toBe('What is 2 + 2?')
    expect(result.current.currentQuestion?.images).toEqual(['2021-april-a-q08-figure1.webp'])
    expect(result.current.isLoading).toBe(false)
  })

  it('reports an error when the quiz cannot be loaded', async () => {
    mockApiPost.mockRejectedValue(new Error('Network down'))
    const { result } = renderHook(() => useQuizSession('sub-1'))

    act(() => result.current.startQuiz())

    await waitFor(() => expect(result.current.error).toBe('Network down'))
    expect(result.current.questions).toEqual([])
  })

  it('marks a correct answer and records it with the backend', async () => {
    const { result } = await startedQuiz()

    act(() => result.current.selectAnswer('b'))
    act(() => result.current.checkAnswer())

    expect(result.current.isAnswered).toBe(true)
    expect(result.current.isCorrect).toBe(true)
    expect(mockApiPost).toHaveBeenLastCalledWith('/api/v1/quizzes/session-1/answers', {
      questionId: 'q1',
      answer: 'b',
    })
  })

  it('marks a wrong answer as not correct', async () => {
    const { result } = await startedQuiz()

    act(() => result.current.selectAnswer('a'))
    act(() => result.current.checkAnswer())

    expect(result.current.isAnswered).toBe(true)
    expect(result.current.isCorrect).toBe(false)
  })

  it('does not check when no answer is selected', async () => {
    const { result } = await startedQuiz()

    act(() => result.current.checkAnswer())

    expect(result.current.isAnswered).toBe(false)
    expect(mockApiPost).toHaveBeenCalledTimes(1)
  })

  it('keeps the checked answer when another choice is clicked afterwards', async () => {
    const { result } = await startedQuiz()

    act(() => result.current.selectAnswer('b'))
    act(() => result.current.checkAnswer())
    act(() => result.current.selectAnswer('a'))

    expect(result.current.selectedLabel).toBe('b')
  })

  it('moves to the next question with a clean answer state', async () => {
    const { result } = await startedQuiz()
    expect(result.current.isLastQuestion).toBe(false)

    act(() => result.current.selectAnswer('b'))
    act(() => result.current.checkAnswer())
    act(() => result.current.goToNextQuestion())

    expect(result.current.currentQuestion?.id).toBe('q2')
    expect(result.current.selectedLabel).toBeNull()
    expect(result.current.isAnswered).toBe(false)
    expect(result.current.isLastQuestion).toBe(true)
  })
})
