import { useEffect, useMemo, useState } from 'react'
import ReactMarkdown from 'react-markdown'

const DRAFT_BASE = '/imports/2021-April-A/ai-draft'
const SOURCE_PDF = '/imports/2021-April-A/source.pdf'
const DRAFT_FILES = ['q01.md', 'q02.md', 'q03.md']

interface DraftQuestion {
  filename: string
  metadata: Record<string, string>
  body: string
  draftJson: DraftJson | null
}

interface DraftJson {
  question_no?: number
  status?: string
  source?: string
  verified_against_pdf?: boolean
  blocks?: DraftBlock[]
}

type DraftBlock =
  | { type: 'markdown'; text: string }
  | { type: 'choices'; choices: { label: string; text: string }[] }
  | {
      type: 'pdf_region'
      reason?: string
      page?: number
      bbox?: number[]
      contains?: string[]
    }

function parseFrontMatter(markdown: string) {
  const match = markdown.match(/^---\n([\s\S]*?)\n---\n\n?/)
  if (!match) {
    return { metadata: {}, body: markdown }
  }

  const metadata = Object.fromEntries(
    match[1]
      .split('\n')
      .map((line) => line.match(/^([^:]+):\s*(.*)$/))
      .filter((line): line is RegExpMatchArray => Boolean(line))
      .map((line) => [line[1], line[2]])
  )

  return {
    metadata,
    body: markdown.slice(match[0].length),
  }
}

function parseDraftJson(markdown: string): DraftJson | null {
  const match = markdown.match(/## Draft JSON\s+```json\n([\s\S]*?)\n```/)
  if (!match) return null

  try {
    return JSON.parse(match[1]) as DraftJson
  } catch {
    return null
  }
}

function displayMarkdown(body: string) {
  return body.replace(/## Draft JSON\s+```json\n[\s\S]*?\n```\s*$/, '').trim()
}

function metadataValue(value: string | undefined) {
  return value && value.length > 0 ? value : 'unknown'
}

function PdfRegionBlock({ block }: { block: Extract<DraftBlock, { type: 'pdf_region' }> }) {
  const page = block.page ?? 1

  return (
    <div className="rounded-md border border-amber-300 dark:border-amber-800 bg-amber-50 dark:bg-amber-900/30 p-4 text-sm text-amber-950 dark:text-amber-400">
      <div className="mb-2 flex flex-wrap items-center gap-2">
        <span className="rounded-full bg-amber-200 dark:bg-amber-900/30 px-2 py-0.5 text-xs font-semibold text-amber-950 dark:text-amber-400">
          pdf_region
        </span>
        <span>Page {page}</span>
        {block.bbox && <span>bbox [{block.bbox.join(', ')}]</span>}
      </div>
      {block.reason && <p className="mb-3 leading-relaxed">{block.reason}</p>}
      {block.contains && block.contains.length > 0 && (
        <p className="mb-3 text-xs uppercase text-amber-800 dark:text-amber-400">
          Contains: {block.contains.join(', ')}
        </p>
      )}
      <a
        href={`${SOURCE_PDF}#page=${page}`}
        target="_blank"
        rel="noreferrer"
        className="inline-flex rounded-md border border-amber-400 dark:border-amber-800 px-3 py-2 font-medium text-amber-950 dark:text-amber-400 hover:bg-amber-100 dark:hover:bg-amber-900/30"
      >
        Open PDF page
      </a>
    </div>
  )
}

function DraftBlocks({ blocks }: { blocks: DraftBlock[] }) {
  const pdfRegions = blocks.filter(
    (block): block is Extract<DraftBlock, { type: 'pdf_region' }> => block.type === 'pdf_region'
  )

  if (pdfRegions.length === 0) return null

  return (
    <div className="space-y-3">
      <h3 className="text-sm font-semibold uppercase text-gray-500 dark:text-gray-400">Review Regions</h3>
      {pdfRegions.map((block, index) => (
        <PdfRegionBlock key={index} block={block} />
      ))}
    </div>
  )
}

export function AiDraftPreview() {
  const [drafts, setDrafts] = useState<DraftQuestion[]>([])
  const [activeFile, setActiveFile] = useState(DRAFT_FILES[0])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    async function loadDrafts() {
      try {
        const loaded = await Promise.all(
          DRAFT_FILES.map(async (filename) => {
            const response = await fetch(`${DRAFT_BASE}/${filename}`)
            if (!response.ok) {
              throw new Error(`Could not load ${filename}`)
            }

            const markdown = await response.text()
            const { metadata, body } = parseFrontMatter(markdown)

            return {
              filename,
              metadata,
              body,
              draftJson: parseDraftJson(body),
            }
          })
        )

        setDrafts(loaded)
        setError(null)
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Could not load draft Markdown')
      } finally {
        setLoading(false)
      }
    }

    loadDrafts()
  }, [])

  const activeDraft = useMemo(
    () => drafts.find((draft) => draft.filename === activeFile) ?? drafts[0],
    [activeFile, drafts]
  )

  const readyWarnings = drafts.filter(
    (draft) => draft.metadata.source === 'ai_extraction' && draft.metadata.status === 'ready'
  )

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <header className="border-b border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800">
        <div className="mx-auto flex max-w-6xl flex-col gap-4 px-4 py-5 sm:px-6 lg:px-8">
          <div className="flex flex-wrap items-start justify-between gap-4">
            <div>
              <p className="text-sm font-medium uppercase text-gray-500 dark:text-gray-400">AI extraction POC</p>
              <h1 className="mt-1 text-2xl font-bold text-gray-950 dark:text-gray-50">2021 April A Draft Preview</h1>
            </div>
            <a
              href={`${DRAFT_BASE}/extraction-report.json`}
              target="_blank"
              rel="noreferrer"
              className="rounded-md border border-gray-300 dark:border-gray-600 px-3 py-2 text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700"
            >
              Report JSON
            </a>
          </div>

          <div className="flex flex-wrap gap-2">
            {drafts.length > 0
              ? drafts.map((draft) => (
                  <button
                    key={draft.filename}
                    onClick={() => setActiveFile(draft.filename)}
                    className={`rounded-md border px-3 py-2 text-sm font-medium ${
                      activeFile === draft.filename
                        ? 'border-gray-950 dark:border-white bg-gray-950 dark:bg-white text-white dark:text-gray-950'
                        : 'border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700'
                    }`}
                  >
                    Q{metadataValue(draft.metadata.question_no).padStart(2, '0')}
                  </button>
                ))
              : DRAFT_FILES.map((filename) => (
                  <button
                    key={filename}
                    disabled
                    className="rounded-md border border-gray-200 dark:border-gray-700 px-3 py-2 text-sm text-gray-400 dark:text-gray-500"
                  >
                    {filename}
                  </button>
                ))}
          </div>
        </div>
      </header>

      <main className="mx-auto grid max-w-6xl gap-6 px-4 py-6 sm:px-6 lg:grid-cols-[220px_minmax(0,1fr)] lg:px-8">
        <aside className="space-y-3">
          <div className="rounded-md border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-4">
            <h2 className="mb-3 text-sm font-semibold uppercase text-gray-500 dark:text-gray-400">Safety State</h2>
            <div className="space-y-2 text-sm">
              <div className="flex items-center justify-between gap-3">
                <span className="text-gray-500 dark:text-gray-400">Status</span>
                <span className="font-semibold text-gray-950 dark:text-gray-50">
                  {metadataValue(activeDraft?.metadata.status)}
                </span>
              </div>
              <div className="flex items-center justify-between gap-3">
                <span className="text-gray-500 dark:text-gray-400">Source</span>
                <span className="font-semibold text-gray-950 dark:text-gray-50">
                  {metadataValue(activeDraft?.metadata.source)}
                </span>
              </div>
              <div className="flex items-center justify-between gap-3">
                <span className="text-gray-500 dark:text-gray-400">Verified</span>
                <span className="font-semibold text-gray-950 dark:text-gray-50">
                  {metadataValue(activeDraft?.metadata.verified_against_pdf)}
                </span>
              </div>
            </div>
          </div>

          <div
            className={`rounded-md border p-4 text-sm ${
              readyWarnings.length > 0
                ? 'border-red-300 dark:border-red-800 bg-red-50 dark:bg-red-900/30 text-red-900 dark:text-red-400'
                : 'border-green-300 dark:border-green-800 bg-green-50 dark:bg-green-900/30 text-green-900 dark:text-green-400'
            }`}
          >
            {readyWarnings.length > 0
              ? `${readyWarnings.length} AI draft marked ready`
              : 'No AI draft is marked ready'}
          </div>
        </aside>

        <section className="min-w-0 rounded-md border border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 p-5">
          {loading && <p className="text-gray-600 dark:text-gray-400">Loading draft Markdown...</p>}
          {error && <p className="text-red-700 dark:text-red-400">{error}</p>}
          {activeDraft && !loading && !error && (
            <div className="space-y-6">
              <div className="flex flex-wrap items-center gap-2 border-b border-gray-100 dark:border-gray-700 pb-4">
                <span className="rounded-full bg-gray-100 dark:bg-gray-700 px-2 py-1 text-xs font-semibold text-gray-700 dark:text-gray-300">
                  {activeDraft.filename}
                </span>
                <span className="rounded-full bg-amber-100 dark:bg-amber-900/30 px-2 py-1 text-xs font-semibold text-amber-800 dark:text-amber-400">
                  draft only
                </span>
                <span className="rounded-full bg-blue-100 dark:bg-blue-900/30 px-2 py-1 text-xs font-semibold text-blue-800 dark:text-blue-400">
                  human review required
                </span>
              </div>

              <article className="max-w-none text-gray-900 dark:text-gray-100 break-words overflow-hidden">
                <ReactMarkdown
                  components={{
                    h1: ({ children }) => (
                      <h1 className="mb-4 text-2xl font-bold text-gray-950 dark:text-gray-50">{children}</h1>
                    ),
                    p: ({ children }) => <p className="mb-4 leading-7">{children}</p>,
                    blockquote: ({ children }) => (
                      <blockquote className="mb-5 rounded-md border border-amber-200 dark:border-amber-800 bg-amber-50 dark:bg-amber-900/30 px-4 py-3 text-amber-900 dark:text-amber-400">
                        {children}
                      </blockquote>
                    ),
                    ol: ({ children }) => (
                      <ol className="mb-4 list-decimal space-y-1 pl-6 leading-7">{children}</ol>
                    ),
                  }}
                >
                  {displayMarkdown(activeDraft.body)}
                </ReactMarkdown>
              </article>

              {activeDraft.draftJson?.blocks && <DraftBlocks blocks={activeDraft.draftJson.blocks} />}
            </div>
          )}
        </section>
      </main>
    </div>
  )
}
