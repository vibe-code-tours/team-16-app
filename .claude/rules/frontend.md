# Frontend conventions — React

Applies to: `src/web/**`

## Stack

- React 18+, Vite, TypeScript
- Tailwind CSS (utility-first, no custom CSS files unless unavoidable)
- React Router v7 for navigation
- Supabase JS SDK for auth (direct calls from frontend)

## Project layout

```
src/web/
├── package.json
├── vite.config.ts
├── tailwind.config.js
├── tsconfig.json
├── index.html
├── public/                    # Static assets (mascot, favicon)
└── src/
    ├── main.tsx               # Entry point, router setup
    ├── App.tsx                # Root layout + route definitions
    ├── routes/                # One file per route/page
    │   ├── LandingPage.tsx
    │   ├── LoginPage.tsx
    │   ├── RegisterPage.tsx
    │   ├── LearningMap.tsx
    │   ├── TopicDetail.tsx
    │   ├── QuizSession.tsx
    │   ├── ExamSimulation.tsx
    │   └── MistakeGarden.tsx
    ├── components/            # Reusable UI components
    │   ├── ui/                # Generic (Button, Card, Modal, etc.)
    │   └── features/          # Feature-specific (QuizCard, TopicNode, etc.)
    ├── hooks/                 # Custom hooks (useAuth, useQuiz, etc.)
    ├── lib/                   # Utility functions, Supabase client init
    │   └── supabase.ts        # createClient() with env vars
    ├── types/                 # TypeScript interfaces/types
    └── styles/
        └── globals.css        # Tailwind directives only
```

## Coding conventions

- Functional components only — no class components.
- TypeScript everywhere — no `any` types unless absolutely justified (and commented).
- One component per file, file name matches component name.
- Use `interface` for object shapes, `type` for unions/intersections.
- Extract complex logic into custom hooks in `hooks/`.
- Keep route components thin: fetch data, render components. Business logic in hooks/services.

## Naming conventions

| Element | Convention | Example |
|---|---|---|
| Component files | PascalCase + `.tsx` | `QuizCard.tsx`, `MistakeGarden.tsx` |
| Component names | PascalCase | `QuizCard`, `MistakeGarden`, `TopicNode` |
| Hook files | `use` + PascalCase + `.ts` | `useAuth.ts`, `useQuizSession.ts` |
| Hook names | `use` + PascalCase | `useAuth()`, `useQuizSession()`, `useMistakes()` |
| Utility files | camelCase + `.ts` | `formatXp.ts`, `calculateStreak.ts` |
| Utility functions | camelCase | `formatXp()`, `calculateStreak()`, `timeAgo()` |
| Type/Interface files | PascalCase + `.ts` | `Quiz.ts`, `UserProgress.ts` |
| TypeScript interfaces | PascalCase | `QuizQuestion`, `UserProgress`, `MistakeRecord` |
| Props interfaces | `<Component>Props` | `QuizCardProps`, `MistakeGardenProps` |
| Event handlers | `handle` + Event | `handleSubmit()`, `handleAnswerSelect()`, `handleNextQuestion()` |
| State variables | descriptive noun | `questions`, `selectedAnswer`, `timeRemaining` |
| State setters | `set` + Noun | `setQuestions()`, `setSelectedAnswer()` |
| Route constants | UPPER_SNAKE_CASE | `ROUTE_MAP = '/map'`, `ROUTE_QUIZ = '/quiz/:topicId'` |
| API endpoint constants | UPPER_SNAKE_CASE | `API_QUIZ = '/api/v1/quizzes'` |
| CSS variable names | kebab-case (Tailwind tokens) | `--color-primary`, `--spacing-lg` |

**What to flag:**
- Variable named `data`, `temp`, `info`, `res` — give it a meaningful name
- Function named `process()`, `handle()`, `doStuff()` — name the action specifically
- Component named `Component1`, `NewComponent`, `MyThing` — name it for what it does
- File named `utils.ts` with 200+ lines — split into focused files (`formatXp.ts`, `calculateStreak.ts`)
- Interface named `Props` without the component prefix — use `QuizCardProps` instead

## Styling

- Tailwind utility classes — no CSS modules, no styled-components.
- Use `cn()` (clsx + tailwind-merge) for conditional classes.
- Responsive by default: mobile-first, use `sm:`, `md:`, `lg:` breakpoints.
- Color palette defined in `tailwind.config.js` — extend, don't hardcode hex values in components.

## Auth flow

- Supabase Auth SDK initialized in `lib/supabase.ts`.
- `useAuth()` hook exposes: `user`, `session`, `signIn()`, `signUp()`, `signOut()`.
- JWT stored in Supabase's default storage (localStorage/cookies).
- Attach `Authorization: Bearer <token>` header to all API calls via a fetch interceptor or Axios instance.
- Protected routes: redirect to `/login` if no session.

## API calls

- All backend calls go through a centralized API client in `lib/api.ts`.
- Use the native `fetch` API (no Axios needed unless the team prefers it — be consistent).
- Base URL from `VITE_API_URL` env var.
- Always handle errors gracefully — show user-friendly messages, not raw error objects.

## Performance

- **`React.memo` for expensive renders.** Wrap components that receive complex props (objects, arrays) and render lists — prevents re-rendering when parent state changes but the component's props haven't.
- **`useMemo` for expensive computations.** Filtering/sorting quiz questions, computing XP totals, aggregating mistake stats — memoize the result so it only recalculates when dependencies change.
- **`useMemo`/`useCallback` for stable references.** Pass callbacks to child components via `useCallback` so they don't cause unnecessary child re-renders. Inline arrow functions in JSX = new reference every render = child re-renders every time.
- **Stable list keys.** Use entity IDs as `key`, never array indices — index keys cause incorrect DOM reuse when lists reorder or filter.
- **Route-level code splitting.** Use `React.lazy()` + `<Suspense>` for page components so the initial bundle doesn't include every route's code.
- **No unnecessary `useEffect`.** Don't use `useEffect` to transform data that could be computed during render. `useEffect` is for side effects (API calls, subscriptions), not derived state.
- **Clean up side effects.** Every `useEffect` that sets up a timer, subscription, or event listener must return a cleanup function.
- **Virtualize long lists.** If a list renders 50+ items (e.g., all questions in Mistake Garden), use windowing (`react-window` or `react-virtuoso`) to avoid rendering off-screen DOM nodes.

## Maintainability

- **Component size limit.** Flag components over ~200 lines — they're probably doing too much. Extract sub-components or move logic to hooks.
- **One concern per component.** A component either fetches data OR renders UI, not both. Route components fetch + delegate; UI components just render.
- **Extract logic into custom hooks.** If a component has more than ~10 lines of non-JSX logic (state management, API calls, effects), extract it into a `use*` hook in `hooks/`.
- **Explicit prop types.** Every component must have a typed `Props` interface. No `any` props, no `{...rest}` spreading without type safety.
- **Consistent loading/error/empty states.** Every data-fetching component must handle: loading (spinner/skeleton), error (message + retry), empty (helpful message), and success. Don't leave these as afterthoughts.
- **No inline styles.** Use Tailwind classes. If a style can't be expressed in Tailwind, use `tailwind.config.js` extensions, not `style={{ }}`.
- **No direct DOM manipulation.** Use React refs and state — never `document.querySelector` or `element.style`.
- **Avoid prop drilling past 2 levels.** If you're passing props through 3+ component layers, use context or restructure.

## Testing

- Component tests with React Testing Library + Vitest.
- Test user-visible behavior (text, buttons, navigation), not implementation details.
- Mock Supabase client and API responses in tests.
