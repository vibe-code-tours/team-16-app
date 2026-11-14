import { useState, useMemo } from 'react'
import { useNavigate } from 'react-router-dom'
import { Sprout, Search } from 'lucide-react'
import { EmptyState } from '../components/ui/EmptyState'
import { Button } from '../components/ui/Button'
import { GardenSummary } from '../components/features/mistakes/GardenSummary'
import { MistakeRetryCard } from '../components/features/mistakes/MistakeRetryCard'
import { useMistakes } from '../hooks/useMistakes'
import type { Mistake } from '../types/Mistake'

export function MistakeGarden() {
  const { mistakes, loading, error, clearedCount, refetch, markReviewed } = useMistakes()
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedCategory, setSelectedCategory] = useState<string>('All')
  const [expandedTopic, setExpandedTopic] = useState<string | null>(null)
  const navigate = useNavigate()

  const filteredMistakes = useMemo(() => {
    return mistakes.filter((mistake) => {
      // Search filter
      const matchesSearch = searchQuery === '' ||
        mistake.questionText?.toLowerCase().includes(searchQuery.toLowerCase()) ||
        mistake.explanation?.toLowerCase().includes(searchQuery.toLowerCase())

      // Category filter
      const matchesCategory = selectedCategory === 'All' ||
        mistake.topicName === selectedCategory

      return matchesSearch && matchesCategory
    })
  }, [mistakes, searchQuery, selectedCategory])

  // Group filtered mistakes by topic name
  const topicGroups = useMemo(() => {
    const groups = new Map<string, Mistake[]>()
    for (const mistake of filteredMistakes) {
      const topic = mistake.topicName || 'Other'
      if (!groups.has(topic)) {
        groups.set(topic, [])
      }
      groups.get(topic)!.push(mistake)
    }
    return groups
  }, [filteredMistakes])

  return (
    <div className="overflow-hidden">
      <div className="mb-8 text-center">
        <h1 className="text-3xl font-bold text-gray-900 dark:text-gray-100 mb-2">Your Mistake Garden</h1>
        <p className="text-gray-500 dark:text-gray-400">
          Every mistake is a seed for growth. Review your wrong answers to master the material.
        </p>
      </div>

      {error && (
        <div role="alert" className="mb-6 rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700 dark:border-red-800 dark:bg-red-900/30 dark:text-red-400">
          Couldn't load your mistakes: {error}
          <Button onClick={refetch} variant="outline" size="sm" className="mt-3">
            Retry
          </Button>
        </div>
      )}

      {loading ? (
        <div className="flex justify-center py-12">
          <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-purple-600"></div>
        </div>
      ) : mistakes.length === 0 ? (
        <>
          {clearedCount > 0 && <GardenSummary remainingCount={0} clearedCount={clearedCount} />}
          <EmptyState
          icon={<Sprout className="size-8 text-gray-400" />}
          title="Your garden is empty!"
          description={clearedCount > 0 ? 'Every mistake has bloomed. Great work!' : "You haven't made any mistakes yet. Keep studying!"}
          />
        </>
      ) : (
        <>
          <GardenSummary remainingCount={mistakes.length} clearedCount={clearedCount} />

          {/* Search and Filter */}
          <div className="mb-6 space-y-4">
            <div className="relative">
              <input
                type="text"
                placeholder="Search questions..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full rounded-xl border border-gray-200 bg-white px-4 py-3 pl-10 text-gray-900 placeholder-gray-500 focus:border-purple-500 focus:outline-none focus:ring-2 focus:ring-purple-500/20 dark:border-gray-700 dark:bg-gray-800 dark:text-gray-100 dark:placeholder-gray-400"
              />
              <svg
                className="absolute left-3 top-1/2 h-5 w-5 -translate-y-1/2 text-gray-400"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
              </svg>
            </div>

            <div className="flex flex-wrap gap-2">
              {['All', ...new Set(mistakes.map(m => m.topicName).filter(Boolean) as string[])].map((category) => (
                <button
                  key={category}
                  onClick={() => setSelectedCategory(category)}
                  className={`rounded-full px-4 py-2 text-sm font-medium transition ${
                    selectedCategory === category
                      ? 'bg-purple-600 text-white'
                      : 'bg-gray-100 text-gray-700 hover:bg-gray-200 dark:bg-gray-800 dark:text-gray-300 dark:hover:bg-gray-700'
                  }`}
                >
                  {category}
                </button>
              ))}
            </div>

            {(searchQuery || selectedCategory !== 'All') && (
              <div className="flex items-center justify-between text-sm text-gray-500 dark:text-gray-400">
                <span>
                  Showing {filteredMistakes.length} of {mistakes.length} mistakes in {topicGroups.size} {topicGroups.size === 1 ? 'topic' : 'topics'}
                </span>
                <button
                  onClick={() => {
                    setSearchQuery('')
                    setSelectedCategory('All')
                  }}
                  className="text-purple-600 hover:text-purple-700 dark:text-purple-400 dark:hover:text-purple-300"
                >
                  Clear filters
                </button>
              </div>
            )}
          </div>

          {filteredMistakes.length === 0 ? (
            <EmptyState
              icon={<Search className="size-8 text-gray-400" />}
              title="No mistakes match your filters"
              description="Try adjusting your search or category filter."
              action={{ label: 'Clear filters', onClick: () => { setSearchQuery(''); setSelectedCategory('All') } }}
            />
          ) : (
            <div className="grid grid-cols-1 gap-8">
              {Array.from(topicGroups.entries()).map(([topicName, topicMistakes]) => {
                const isExpanded = expandedTopic === topicName || expandedTopic === null
                const subTopicId = topicMistakes.find(m => m.subtopicId)?.subtopicId
                const distinctSubtopics = new Set(topicMistakes.map(m => m.subtopicName).filter(Boolean))

                return (
                  <section key={topicName} className="rounded-2xl border border-gray-200 bg-white shadow-sm dark:border-gray-700 dark:bg-gray-800 overflow-hidden">
                    {/* Topic header with count and practice button */}
                    <div
                      className="flex items-center justify-between px-6 py-4 cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700/50"
                      onClick={() => setExpandedTopic(isExpanded ? null : topicName)}
                    >
                      <div className="flex items-center gap-3">
                        <h2 className="text-lg font-bold text-gray-900 dark:text-gray-100">{topicName}</h2>
                        <span className="inline-flex items-center rounded-full bg-purple-100 px-2.5 py-0.5 text-xs font-semibold text-purple-700 dark:bg-purple-900/30 dark:text-purple-400">
                          {topicMistakes.length} {topicMistakes.length === 1 ? 'mistake' : 'mistakes'}
                        </span>
                        {distinctSubtopics.size > 0 && (
                          <span className="hidden sm:inline text-xs text-gray-400 dark:text-gray-500">
                            {distinctSubtopics.size} {distinctSubtopics.size === 1 ? 'subtopic' : 'subtopics'}
                          </span>
                        )}
                      </div>
                      <div className="flex items-center gap-3" onClick={(e) => e.stopPropagation()}>
                        {subTopicId && (
                          <button
                            onClick={() => navigate(`/quiz/${subTopicId}`)}
                            className="inline-flex items-center gap-1.5 rounded-lg bg-purple-600 px-3 py-1.5 text-xs font-semibold text-white hover:bg-purple-700 transition-colors"
                          >
                            Practice this topic
                            <svg className="size-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                              <path d="M5 12h14M13 6l6 6-6 6" />
                            </svg>
                          </button>
                        )}
                        <svg
                          className={`size-5 text-gray-400 transition-transform ${isExpanded ? '' : 'rotate-180'}`}
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth="2"
                          strokeLinecap="round"
                          strokeLinejoin="round"
                        >
                          <path d="m6 15 6-6 6 6" />
                        </svg>
                      </div>
                    </div>

                    {/* Individual mistakes within topic */}
                    {isExpanded && (
                      <div className="border-t border-gray-100 dark:border-gray-700 divide-y divide-gray-100 dark:divide-gray-700">
                        {topicMistakes.map((mistake) => (
                          <MistakeRetryCard key={mistake.id} mistake={mistake} onReviewed={markReviewed} />
                        ))}
                      </div>
                    )}
                  </section>
                )
              })}
            </div>
          )}
        </>
      )}
    </div>
  )
}
