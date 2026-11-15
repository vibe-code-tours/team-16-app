import { Flower2, Sprout } from 'lucide-react'

/** Cap on plants drawn per kind so a large garden stays readable. */
const MAX_PLANTS_SHOWN = 24

interface GardenSummaryProps {
  remainingCount: number
  clearedCount: number
}

interface PlantRowProps {
  count: number
  kind: 'seedling' | 'flower'
}

function PlantRow({ count, kind }: PlantRowProps) {
  const shown = Math.min(count, MAX_PLANTS_SHOWN)
  const overflow = count - shown
  const Icon = kind === 'flower' ? Flower2 : Sprout
  const colorClass = kind === 'flower' ? 'text-pink-500 dark:text-pink-400' : 'text-green-600 dark:text-green-400'

  return (
    <>
      {Array.from({ length: shown }, (_, index) => (
        <Icon key={`${kind}-${index}`} aria-hidden="true" data-testid={kind} className={`size-6 ${colorClass}`} />
      ))}
      {overflow > 0 && (
        <span className="self-center text-xs font-medium text-gray-500 dark:text-gray-400">+{overflow}</span>
      )}
    </>
  )
}

/** Visual garden: a seedling per open mistake, a flower per mistake cleared this session. */
export function GardenSummary({ remainingCount, clearedCount }: GardenSummaryProps) {
  return (
    <section
      aria-label="Garden summary"
      className="mb-6 rounded-2xl border border-green-100 bg-green-50/60 p-4 dark:border-green-900 dark:bg-green-900/20"
    >
      <p className="mb-3 text-sm font-medium text-gray-700 dark:text-gray-300">
        {clearedCount} cleared this session · {remainingCount} still growing
      </p>
      <div className="flex flex-wrap gap-1">
        <PlantRow count={clearedCount} kind="flower" />
        <PlantRow count={remainingCount} kind="seedling" />
      </div>
    </section>
  )
}
