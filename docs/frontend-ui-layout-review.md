# Frontend UI Layout Review

> **Date:** 2026-07-13
> **Author:** Myo Min Lin
> **Status:** Draft — for team discussion

---

## Current State

### Routing

**Public routes (3):**

| Route | Component | Description |
|---|---|---|
| `/` | LandingPage | Full-screen hero with owl mascot, CTA buttons, feature grid |
| `/login` | LoginPage | Centered single-column form |
| `/register` | RegisterPage | Centered single-column form |

**Protected routes (7):**

| Route | Component | Description |
|---|---|---|
| `/map` | LearningMap | Roadmap with topic nodes by category |
| `/map/:topicId` | TopicDetail | Lesson list for a topic |
| `/lesson/:lessonId` | LessonPage | Lesson content reader |
| `/quiz/:quizId` | QuizPage | Question-by-question quiz |
| `/mistakes` | MistakeGarden | Review wrong answers |
| `/profile` | UserProfile | Stats + sign out |
| `/exam` | ExamPage | Timed exam simulation |

> **Note:** `QuizSession.tsx` and `QuizResult.tsx` exist as files but are **not wired into the router**.

### No Shared Layout Shell

There is **no shared layout, navbar, sidebar, or footer component**. Every route page builds its own full-page layout independently. `ProtectedRoute` is purely an auth guard (spinner → redirect or render children) with no visual output.

### Page-by-Page Layout

| Page | Header Style | Sticky | Notable UI |
|---|---|---|---|
| **LearningMap** | Rich bar: wordmark, XP, Streak, Mistake Garden btn, Exam btn, profile avatar | ✅ | Only page with app-like nav |
| **TopicDetail** | Wordmark + "Back to map" link | ❌ | Lesson cards list |
| **LessonPage** | Back arrow + "Lesson" title | ❌ | Prose content card, "I've read it!" button |
| **QuizPage** | Back arrow "Quit Quiz" + question counter | ❌ | Progress bar, colored answer options |
| **ExamPage** | "Quit Exam" + countdown timer + hearts | ✅ | Difficulty selector, progress bar |
| **MistakeGarden** | Back arrow + title | ❌ | Grid of mistake cards |
| **UserProfile** | "Back to map" text link | ❌ | Avatar, stats grid, sign out |

### Key Issues

1. **No persistent navigation** — users navigate between pages via back/forward links embedded in each page header. There is no global nav bar, sidebar, or tab bar.
2. **Inconsistent max-widths** — pages use `max-w-2xl`, `max-w-3xl`, `max-w-4xl`, and `max-w-5xl` interchangeably.
3. **Only LearningMap acts as a "home"** — it is the only authenticated page with a rich header containing stats and navigation to other features.
4. **Each page re-implements its own header** — no shared component, leading to duplication and inconsistency.

---

## UI Framework Options

### Current Stack

- React 19 + Tailwind CSS 4 + Vite 8
- React Router v7
- `clsx` + `tailwind-merge` already set up (`cn()` utility ready)

### Options

#### 1. Shadcn/ui ⭐ (Recommended)

- **What:** Copy-paste components built on Radix UI primitives + Tailwind CSS
- **Layout pieces:** Sidebar, Navbar, Sheet (mobile nav), Dropdown Menu, Avatar, Button, Card
- **Pros:** You own the code (copy into your project, not a dependency), extremely customizable, matches existing Tailwind setup perfectly, huge community
- **Cons:** You maintain the components yourself (upgrades are manual)
- **Install:** `npx shadcn@latest init` then `npx shadcn@latest add sidebar sheet avatar dropdown-menu`
- **Bundle size:** Minimal — only what you use

#### 2. DaisyUI

- **What:** Tailwind CSS plugin that adds component class names (`btn`, `navbar`, `drawer`, etc.)
- **Layout pieces:** `navbar`, `drawer` (sidebar), `hero`, `footer`, `card`, `btn`
- **Pros:** Dead simple — just Tailwind classes, no JS imports, lightweight
- **Cons:** Less flexible for custom layouts, opinions baked into class names, harder to match exact design
- **Install:** `npm i daisyui` + add to Tailwind config

#### 3. Headless UI (by Tailwind Labs)

- **What:** Unstyled, accessible React components (transitions, menus, dialogs)
- **Layout pieces:** `Disclosure` (collapsible nav), `Menu`, `Dialog`, `Transition`
- **Pros:** Fully accessible, zero styling opinions, you control everything
- **Cons:** No layout primitives — you still build the sidebar/navbar from scratch, just with accessible behavior

#### 4. Mantine

- **What:** Full React component library with its own styling system
- **Pros:** Has an AppShell layout component with sidebar/navbar out of the box
- **Cons:** Uses its own CSS-in-JS (`@mantine/core`), conflicts with Tailwind setup, heavier bundle

#### 5. Ant Design

- **What:** Enterprise-grade React component library
- **Pros:** Mature, battle-tested
- **Cons:** Heavy (~1MB+), own design system clashing with Tailwind, overkill for a learning app

### Comparison Matrix

| | Shadcn/ui | DaisyUI | Headless UI | Mantine | Ant Design |
|---|---|---|---|---|---|
| **Tailwind-native** | ✅ Yes | ✅ Yes | ✅ Yes | ❌ Own system | ❌ Own system |
| **Layout components** | ✅ Sidebar, Sheet | ✅ Navbar, Drawer | ⚠️ Primitives only | ✅ AppShell | ✅ Layout |
| **Mobile responsive** | ✅ Built-in | ✅ Built-in | Build yourself | ✅ Built-in | ✅ Built-in |
| **Customizable** | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐ |
| **Bundle impact** | Minimal | Tiny | Tiny | Medium | Heavy |
| **Current stack fit** | ✅ Perfect | ✅ Good | ✅ Good | ⚠️ Conflicts | ⚠️ Conflicts |
| **Code ownership** | You own it | Plugin | NPM dep | NPM dep | NPM dep |

---

## Recommendation

**Shadcn/ui** is the strongest fit because:

- **Tailwind-native** — works with existing `clsx` + `tailwind-merge` and `cn()` utility
- **Ready-made Sidebar component** with mobile-responsive sheet (hamburger menu → slide-out)
- **You copy the code** into your project, so you can customize the layout to match the purple theme
- **No dependency conflicts** with React 19 / Tailwind 4
- **Industry standard** — most modern React + Tailwind projects are converging on it

### Proposed Layout Pattern with Shadcn/ui

```
┌─────────────────────────────────────────────┐
│  Sidebar (collapsible)  │  Main Content     │
│                         │                   │
│  ┌───────────────────┐  │  ┌─────────────┐  │
│  │  NerdQuiz logo    │  │  │  Header     │  │
│  │                   │  │  │  (stats,    │  │
│  │  🗺 Learning Map  │  │  │   avatar)   │  │
│  │  🌿 Mistakes      │  │  ├─────────────┤  │
│  │  📝 Exam          │  │  │             │  │
│  │  👤 Profile       │  │  │  Page       │  │
│  │                   │  │  │  Content    │  │
│  └───────────────────┘  │  │             │  │
│                         │  └─────────────┘  │
└─────────────────────────────────────────────┘
```

- **`AppSidebar`** — collapsible sidebar with nav links (Map, Mistakes, Exams, Profile)
- **`SidebarProvider`** + **`SidebarInset`** — wraps `<Routes>` content
- **Top header** — breadcrumb, user avatar dropdown, XP/streak stats
- **Mobile** — hamburger icon opens sidebar as a slide-out Sheet

---

## Next Steps

1. Team review and vote on framework choice
2. If Shadcn/ui: initialize in the project and add layout components
3. Create a shared `AppLayout` component wrapping all protected routes
4. Migrate existing page headers into the shared layout
5. Ensure consistent max-width and spacing across all pages
