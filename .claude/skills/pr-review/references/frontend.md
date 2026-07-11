# Frontend Review Checklist — React / TypeScript

Applies to: `src/web/**`

## Code quality

- Functional components only, no class components
- TypeScript — no `any` types without justification
- One component per file, name matches file name
- Tailwind utilities only — no `style={{ }}` inline styles
- API calls go through centralized client (`lib/api.ts`)
- **`useMemo` for expensive computations** — filtering/sorting questions, computing stats, aggregating data
- **`useCallback` for callbacks passed to child components** — prevents unnecessary child re-renders
- **Stable list keys** — entity IDs as `key`, never array indices for dynamic lists
- **Route-level code splitting** — `React.lazy()` + `<Suspense>` for page components
- **No unnecessary `useEffect`** — derived state is computed during render, not in effects
- **`useEffect` has cleanup** — timers, subscriptions, event listeners all have return cleanup
- **Every data-fetching component handles loading/error/empty states** — not just the happy path
- **No direct DOM manipulation** — use refs and state, never `document.querySelector`
- **Explicit prop types** — every component has a typed `Props` interface, no `any` props
- **Components under ~200 lines** — flag if exceeded; extract sub-components or hooks
- **No prop drilling past 2 levels** — use context or restructure instead
- **No inline functions in JSX for frequently re-rendered components** — pass memoized references

## Naming

- **Component files:** PascalCase + `.tsx` — `QuizCard.tsx`, `MistakeGarden.tsx`
- **Component names:** PascalCase, match file name — `QuizCard`, not `quizCard` or `component1`
- **Hook files:** `use` + PascalCase + `.ts` — `useAuth.ts`, `useQuizSession.ts`
- **Hook names:** `use` + PascalCase — `useAuth()`, `useQuizSession()`
- **Props interfaces:** `<Component>Props` — `QuizCardProps`, not `Props` or `QuizProps`
- **Event handlers:** `handle` + Event — `handleSubmit()`, `handleAnswerSelect()`
- **State setters:** `set` + Noun — `setQuestions()`, `setSelectedAnswer()`
- **Route constants:** UPPER_SNAKE_CASE — `ROUTE_MAP = '/map'`
- **Utility functions:** camelCase, descriptive — `formatXp()`, `calculateStreak()`
- **Type files:** PascalCase + `.ts` — `Quiz.ts`, `UserProgress.ts`
- **No vague names** — no `data`, `temp`, `info`, `res`, `process()`, `handle()`, `doStuff()`
- **No generic `utils.ts`** — split into focused files (`formatXp.ts`, `calculateStreak.ts`)
