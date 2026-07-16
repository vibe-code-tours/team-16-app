import { useState } from 'react'
import { Link } from 'react-router-dom'
import type { TopicMastery, SubtopicMastery } from '../../../types/WeakPoint'

interface WeakPointCardProps {
  topic: TopicMastery
  subtopics: SubtopicMastery[]
  rank: number
}

export function WeakPointCard({ topic, subtopics, rank }: WeakPointCardProps) {
  const [expanded, setExpanded] = useState(rank === 1)
  const percentage = Math.round(topic.masteryScore * 100)
  const topicSubtopics = subtopics
    .filter((subtopic) => subtopic.topicId === topic.topicId)
    .sort(compareSubtopics)
  const practicedSubtopics = topicSubtopics.filter((subtopic) => subtopic.questionsSeen > 0)
  const nextPractice = practicedSubtopics[0] ?? topicSubtopics[0]
  const mastery = getMasteryState(topic.masteryScore)

  return (
    <article className={`learning-topic-enter overflow-hidden rounded-3xl border bg-white shadow-sm transition-all duration-300 hover:shadow-xl hover:shadow-purple-100/50 motion-reduce:transition-none ${mastery.borderClassName}`}>
      <details className="group" open={expanded} onToggle={(event) => setExpanded(event.currentTarget.open)}>
        <summary className="list-none cursor-pointer p-5 focus:outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-purple-500 sm:p-6 [&::-webkit-details-marker]:hidden">
          <div className="flex flex-col gap-5 lg:flex-row lg:items-center lg:justify-between">
            <div className="flex min-w-0 items-center gap-4">
              <span className={`flex size-14 shrink-0 items-center justify-center rounded-2xl text-xl font-bold ring-1 ${mastery.iconClassName}`} aria-hidden="true">
                {rank === 1 ? '!' : rank}
              </span>
              <div className="min-w-0">
                <div className="flex flex-wrap items-center gap-2">
                  <span className={`inline-flex rounded-full px-2.5 py-1 text-[11px] font-bold uppercase tracking-wider ${mastery.badgeClassName}`}>
                    {rank === 1 ? 'Top priority' : mastery.label}
                  </span>
                  <span className="text-xs font-medium text-gray-400">Focus #{rank}</span>
                </div>
                <h3 className="mt-2 truncate text-xl font-bold text-gray-950 sm:text-2xl">{topic.topicName}</h3>
                <p className="mt-1 text-sm text-gray-500">
                  {topic.questionsSeen} {topic.questionsSeen === 1 ? 'answer' : 'answers'} analyzed · {practicedSubtopics.length} active {practicedSubtopics.length === 1 ? 'subtopic' : 'subtopics'}
                </p>
              </div>
            </div>

            <div className="flex items-center gap-4 sm:gap-6">
              <div className="min-w-32 flex-1 lg:w-48 lg:flex-none">
                <div className="flex items-center justify-between text-xs font-semibold">
                  <span className="text-gray-400">Mastery</span>
                  <span className={mastery.textClassName}>{percentage}%</span>
                </div>
                <div className="mt-2 h-2.5 overflow-hidden rounded-full bg-gray-100" role="progressbar" aria-label={`${topic.topicName} mastery`} aria-valuemin={0} aria-valuemax={100} aria-valuenow={percentage}>
                  <div className={`learning-progress-reveal h-full rounded-full bg-gradient-to-r ${mastery.progressClassName}`} style={{ width: `${percentage}%` }} />
                </div>
              </div>
              <span className="flex size-10 shrink-0 items-center justify-center rounded-xl bg-gray-50 text-gray-400 transition-all duration-200 group-open:rotate-180 group-hover:bg-purple-50 group-hover:text-purple-600 motion-reduce:transform-none motion-reduce:transition-none" aria-hidden="true">
                <ChevronDownIcon />
              </span>
            </div>
          </div>
        </summary>

        <div className="border-t border-gray-100 px-5 pb-5 pt-4 sm:px-6 sm:pb-6">
          <div className="mb-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <div>
              <p className="text-sm font-bold text-gray-900">Subtopic breakdown</p>
              <p className="mt-0.5 text-xs text-gray-500">Lower scores are shown first so you know where to begin.</p>
            </div>
            {nextPractice ? (
              <Link
                to={`/quiz/${nextPractice.subtopicId}`}
                className="group/action inline-flex min-h-10 items-center justify-center gap-2 rounded-xl bg-purple-600 px-4 py-2 text-sm font-bold text-white shadow-md shadow-purple-200 transition-all hover:-translate-y-0.5 hover:bg-purple-700 hover:shadow-lg focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 focus-visible:ring-offset-2 motion-reduce:transform-none motion-reduce:transition-none"
              >
                Practice {nextPractice.subtopicName}
                <ArrowRightIcon />
              </Link>
            ) : null}
          </div>

          <div className="grid gap-2 lg:grid-cols-2">
            {topicSubtopics.map((subtopic) => (
              <SubtopicRow key={subtopic.subtopicId} subtopic={subtopic} />
            ))}
          </div>
        </div>
      </details>
    </article>
  )
}

function SubtopicRow({ subtopic }: { subtopic: SubtopicMastery }) {
  const percentage = Math.round(subtopic.masteryScore * 100)
  const isPracticed = subtopic.questionsSeen > 0
  const mastery = getMasteryState(subtopic.masteryScore)

  return (
    <Link
      to={`/quiz/${subtopic.subtopicId}`}
      className="group/row flex min-h-20 items-center gap-3 rounded-2xl border border-transparent bg-gray-50/80 p-3 transition-all duration-200 hover:border-purple-200 hover:bg-purple-50/60 focus:outline-none focus-visible:ring-2 focus-visible:ring-purple-500 motion-reduce:transition-none"
      aria-label={`${isPracticed ? 'Practice' : 'Start'} ${subtopic.subtopicName}`}
    >
      <span className={`flex size-10 shrink-0 items-center justify-center rounded-xl text-sm font-bold ${isPracticed ? mastery.iconClassName : 'bg-white text-gray-400 ring-1 ring-gray-200'}`} aria-hidden="true">
        {isPracticed ? `${percentage}%` : '○'}
      </span>
      <div className="min-w-0 flex-1">
        <div className="flex items-center justify-between gap-3">
          <p className="truncate text-sm font-semibold text-gray-800 group-hover/row:text-purple-800">{subtopic.subtopicName}</p>
          <span className="shrink-0 text-xs font-semibold text-gray-400">
            {isPracticed ? `${subtopic.questionsCorrect}/${subtopic.questionsSeen}` : 'Not started'}
          </span>
        </div>
        <div className="mt-2 h-1.5 overflow-hidden rounded-full bg-white ring-1 ring-gray-100" aria-hidden="true">
          <div className={`learning-progress-reveal h-full rounded-full bg-gradient-to-r ${isPracticed ? mastery.progressClassName : 'from-gray-200 to-gray-200'}`} style={{ width: `${percentage}%` }} />
        </div>
      </div>
      <span className="text-gray-300 transition-transform group-hover/row:translate-x-0.5 group-hover/row:text-purple-500 motion-reduce:transform-none" aria-hidden="true">
        <ArrowRightIcon />
      </span>
    </Link>
  )
}

function getMasteryState(score: number): MasteryState {
  if (score < 0.4) {
    return {
      label: 'Needs focus',
      borderClassName: 'border-rose-200/80',
      badgeClassName: 'bg-rose-50 text-rose-700 ring-1 ring-rose-100',
      iconClassName: 'bg-rose-50 text-rose-600 ring-1 ring-rose-100',
      textClassName: 'text-rose-600',
      progressClassName: 'from-rose-500 to-orange-400',
    }
  }

  if (score < 0.7) {
    return {
      label: 'Developing',
      borderClassName: 'border-amber-200/80',
      badgeClassName: 'bg-amber-50 text-amber-700 ring-1 ring-amber-100',
      iconClassName: 'bg-amber-50 text-amber-600 ring-1 ring-amber-100',
      textClassName: 'text-amber-600',
      progressClassName: 'from-amber-500 to-yellow-400',
    }
  }

  return {
    label: 'Strong',
    borderClassName: 'border-emerald-200/80',
    badgeClassName: 'bg-emerald-50 text-emerald-700 ring-1 ring-emerald-100',
    iconClassName: 'bg-emerald-50 text-emerald-600 ring-1 ring-emerald-100',
    textClassName: 'text-emerald-600',
    progressClassName: 'from-emerald-500 to-teal-400',
  }
}

function compareSubtopics(a: SubtopicMastery, b: SubtopicMastery) {
  const aUnpracticed = a.questionsSeen === 0 ? 1 : 0
  const bUnpracticed = b.questionsSeen === 0 ? 1 : 0
  if (aUnpracticed !== bUnpracticed) return aUnpracticed - bUnpracticed
  if (a.masteryScore !== b.masteryScore) return a.masteryScore - b.masteryScore
  return b.questionsSeen - a.questionsSeen
}

function ChevronDownIcon() {
  return (
    <svg className="size-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="m6 9 6 6 6-6" />
    </svg>
  )
}

function ArrowRightIcon() {
  return (
    <svg className="size-4 transition-transform group-hover/action:translate-x-0.5 motion-reduce:transform-none" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M5 12h14M13 6l6 6-6 6" />
    </svg>
  )
}

interface MasteryState {
  label: string
  borderClassName: string
  badgeClassName: string
  iconClassName: string
  textClassName: string
  progressClassName: string
}
