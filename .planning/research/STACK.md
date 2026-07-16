# Stack Research — Admin Dashboard

**Domain:** Admin dashboard for existing React + Spring Boot + Supabase app
**Researched:** 2026-07-15
**Confidence:** HIGH

## Context

NerdQuiz already has React 19, Tailwind CSS 4, React Router v7, Supabase JS SDK, lucide-react icons, and a custom UI component system (Button, Card, Badge). The admin dashboard adds three capabilities that the current stack lacks: **analytics charts**, **paginated data tables with search/filter**, and **date formatting for timestamps**. This research covers only the new dependencies required.

## Recommended Stack

### New Dependencies

| Technology | Version | Purpose | Why Recommended |
|------------|---------|---------|-----------------|
| `recharts` | ^3.9.2 | Bar charts, line charts, pie charts for analytics | Declarative React components wrapping D3; native SVG; 233+ code snippets in Context7; peer-dep supports React 19; largest React charting ecosystem. |
| `react-is` | ^19.2.7 | Peer dependency required by recharts | Recharts declares `react-is` as a peer dep — must install to avoid warnings. Match major version to React 19. |
| `@tanstack/react-table` | ^8.21.3 | Headless data table with pagination, sorting, filtering | De facto standard for React data tables; headless = full Tailwind styling control; 9690 code snippets in Context7; v8 is stable (v9 still beta). |
| `date-fns` | ^4.4.0 | Date formatting ("Jul 15, 2026"), relative time ("3 days ago") | Tree-shakeable (only import what you use); lighter than moment.js; works with TypeScript out of the box; v4 is current stable. |

### What We Already Have (No New Deps Needed)

| Existing Tool | Purpose for Admin Dashboard |
|---------------|----------------------------|
| `lucide-react` ^1.24.0 | Icons for admin nav, stat cards, table actions |
| `class-variance-authority` ^0.7.1 | Variant-based styling for stat cards, badges |
| `clsx` + `tailwind-merge` | Conditional class merging for responsive chart/table layouts |
| `Card` component | Reuse for stat cards, chart containers |
| `Badge` component | User role badges (admin/user), status indicators |
| `Button` component | Action buttons in user detail, role change, deactivation |
| `ProtectedRoute` | Extend for admin role guard (`AdminRoute` wrapper) |

## Installation

```bash
# Core new deps (4 packages)
npm install recharts react-is @tanstack/react-table date-fns

# That's it — no dev dependencies needed for these
```

## Detailed Rationale

### Charts: Recharts (not Nivo, not Chart.js)

**Recharts** is the right choice because:

1. **Declarative React components** — `<BarChart>`, `<LineChart>`, `<PieChart>` compose like regular JSX. No imperative canvas API.
2. **ResponsiveContainer** — handles responsive sizing out of the box; charts fit whatever card/container they're in.
3. **React 19 support confirmed** — peerDependencies explicitly include `^19.0.0`.
4. **SVG-based** — charts are inspectable, styleable, and accessible. Not locked into a `<canvas>`.
5. **Minimal config** — a working chart is ~15 lines of JSX. Perfect for a Week 2 MVP.

**Why not Nivo?** Also excellent, but heavier bundle (~40KB vs Recharts ~30KB gzipped) and more opinionated styling. Recharts gives more control with less overhead for simple admin charts.

**Why not Chart.js + react-chartjs-2?** Canvas-based (less accessible, harder to style with Tailwind), imperative API wrapped in React. Better for complex interactive charts, overkill for admin stat charts.

### Data Table: TanStack Table v8 (not v9 beta)

**TanStack Table v8** because:

1. **Stable release** — v8.21.3 is production-ready. v9 is at beta.48 with breaking API changes (`useTable` + `tableFeatures` replaces `useReactTable`).
2. **Headless** — zero UI opinions. We style with our existing Tailwind + CVA system. No fighting a pre-built table component.
3. **Server-side pagination** — `manualPagination: true` delegates page changes to our backend `GET /api/v1/admin/users?page=0&size=20`. The admin user list will be paginated server-side.
4. **Column filtering** — built-in `getFilteredRowModel()` for client-side search, or `manualFiltering` for server-side search. We'll use server-side since the user list comes from the API.
5. **React 19 compatible** — `peerDependencies: { "react": ">=16.8" }`.

**Use the v8 API (`useReactTable`), not the v9 beta API.** The Context7 docs showed both v8 and v9 patterns — v9 is not yet stable. The v8 API is:

```typescript
import { useReactTable, getCoreRowModel, flexRender } from '@tanstack/react-table'
```

### Date Formatting: date-fns (not dayjs, not moment.js)

**date-fns v4** because:

1. **Tree-shakeable** — `import { format, formatDistanceToNow } from 'date-fns'` pulls only those functions. No bloat.
2. **TypeScript native** — no `@types/date-fns` needed.
3. **Server-safe** — pure functions, no mutable state (unlike moment.js).
4. **v4 is current** — the project uses ESM (`"type": "module"`), and date-fns v4 has native ESM support.

**Why not dayjs?** Also good and small, but plugin system is awkward for the 2-3 formatting functions we need. date-fns gives the same result with simpler imports.

**Why not moment.js?** Deprecated in maintenance mode; 300KB+ bundle; mutable state is a footgun.

## What NOT to Use

| Avoid | Why | Use Instead |
|-------|-----|-------------|
| `antd` / Ant Design | Heavy CSS-in-JS, opinionated design language that clashes with Tailwind. Brings its own layout system. | Build with our existing Tailwind components + Recharts/TanStack Table |
| `@tremor/react` | Tempting as an all-in-one dashboard kit, but adds a design system dependency that conflicts with our existing Card/Badge/Button components. Another thing to fight when customizing. | Compose from Recharts charts + TanStack Table + our existing components |
| `react-admin` | Full admin framework — massive overhead for a founders-only dashboard. Brings its own routing, data layer, auth. | Hand-built routes using React Router + our existing auth pattern |
| `MUI DataGrid` | Excellent component, but brings Material UI as a dependency. We use Tailwind, not MUI. Two styling systems = confusion. | TanStack Table (headless) + Tailwind styling |
| TanStack Query (for now) | Adds data-fetching/caching layer. Our admin dashboard has ~5 endpoints with manual refresh. Not worth the abstraction for an MVP. | Simple `useState` + `useEffect` + `fetch` pattern, same as existing pages |
| TanStack Table v9 (beta) | Breaking API changes, may have bugs, will require migration when v9 ships stable. | TanStack Table v8 — migrate to v9 later when stable |

## Stack Patterns

**For stat cards (total users, active users, quiz attempts):**
- Build with existing `Card` component + `lucide-react` icons
- No new library needed — these are simple layout + number display
- Use `Badge` for trend indicators (up/down)

**For analytics charts (daily active users, quiz attempts over time, topic distribution):**
- Use Recharts `<ResponsiveContainer>` + `<LineChart>`, `<BarChart>`, `<PieChart>`
- Wrap each chart in the existing `Card` component
- Data comes from `GET /api/v1/admin/stats` — fetch on mount, display immediately

**For user list (paginated table with search, filter by role):**
- Use TanStack Table v8 with `manualPagination` + `manualFiltering`
- Backend handles pagination: `GET /api/v1/admin/users?page=0&size=20&search=&role=`
- Search input debounces (300ms) then triggers server request
- Role filter is a `<select>` dropdown
- Table styled with Tailwind — no pre-built table CSS

**For user detail view (profile info, quiz history):**
- Simple layout with `Card` components
- Date formatting with `date-fns`: `format(new Date(user.created_at), 'MMM d, yyyy')`
- Relative time with `formatDistanceToNow`

**For admin role guard (route protection):**
- Extend existing `ProtectedRoute` pattern — create `AdminRoute` that also checks `user.role === 'admin'`
- Redirect non-admins to `/` or show 403 page
- Backend filter returns 403 for non-admin JWT tokens hitting `/api/v1/admin/*`

## Version Compatibility

| Package | Version | Compatible With | Notes |
|---------|---------|-----------------|-------|
| `recharts@3.9.2` | React 16-19 | peerDep: `^16.8.0 \|\| ^17 \|\| ^18 \|\| ^19` | Requires `react-is` as peer dep |
| `react-is@19.2.7` | React 19.2.7 | Matches project's React version exactly | Must match major version of react |
| `@tanstack/react-table@8.21.3` | React 16.8+ | peerDep: `>=16.8` | v8 stable API; v9 beta has breaking changes |
| `date-fns@4.4.0` | ESM + TypeScript | Native ESM, no peer deps | Works with `"type": "module"` in package.json |
| Tailwind CSS 4.3.2 | All new deps | Headless table/charts have no CSS opinions | We style everything with Tailwind utilities |

## Sources

- Context7 `/recharts/recharts` — React 19 peer dep confirmed; ResponsiveContainer, BarChart, LineChart API
- Context7 `/tanstack/table` — v8 `useReactTable` API; v9 beta `useTable` + `tableFeatures` pattern; server-side pagination setup
- npm registry — verified current stable versions: recharts 3.9.2, @tanstack/react-table 8.21.3, date-fns 4.4.0
- Project `src/web/package.json` — existing dependencies and versions verified
- Project `src/web/src/components/ui/` — existing component patterns (Button, Card, Badge) confirmed

---
*Stack research for: NerdQuiz Admin Dashboard*
*Researched: 2026-07-15*
