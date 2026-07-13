# NerdQuiz Design Guidelines

> Visual identity, component patterns, and styling conventions for the NerdQuiz frontend.

---

## 1. Brand Identity

NerdQuiz is a **gamified IT exam prep** platform. The visual identity balances
**approachable playfulness** (gamification, XP, streaks, emoji mascot) with
**professional credibility** (certification exam content).

| Attribute | Value |
|---|---|
| App name | NerdQuiz |
| Tagline | "IT Exam Prep — Gamified" |
| Favicon | ⚡ Purple lightning bolt with blue glow |
| Theme color | `#7c3aed` (purple-600) |
| Tone | Friendly, encouraging, nerdy — not childish |

---

## 2. Color Palette

### 2.1 Brand Colors

| Token | Hex | Tailwind | Usage |
|---|---|---|---|
| **Brand Primary** | `#7c3aed` | `purple-600` | CTAs, header branding, links, active states, primary buttons |
| **Brand Primary Hover** | `#6d28d9` | `purple-700` | Button hover, emphasis |
| **Brand Light** | `#f5f3ff` | `purple-50` | XP earned cards, selected states, hero gradients |
| **Brand Accent** | `#ede9fe` | `purple-100` | Badge backgrounds, category accents |

> ⚠️ **Config note:** The Tailwind config defines a `primary` color scale using
> sky-blue, but the actual brand color throughout the app is **purple**. Use
> `purple-*` classes for brand actions. The `primary-*` scale is reserved for
> informational/info UI only.

### 2.2 Semantic Colors

| Role | Background | Text | Border | Tailwind Example |
|---|---|---|---|---|
| **Success** | `green-50` | `green-700` | `green-200` | `bg-green-50 text-green-700 border-green-200` |
| **Error** | `red-50` | `red-700` | `red-200` | `bg-red-50 text-red-700 border-red-200` |
| **Warning** | `amber-50` | `amber-700` | `amber-200` | `bg-amber-50 text-amber-700 border-amber-200` |
| **Info** | `blue-50` | `blue-700` | `blue-200` | `bg-blue-50 text-blue-700 border-blue-200` |

### 2.3 Gamification Colors

| Token | Hex | Tailwind | Usage |
|---|---|---|---|
| **XP Gold** | `#fbbf24` | `amber-400` / `xp-gold` | XP earned, star ratings, gold badges |
| **XP Green** | `#22c55e` | `green-500` / `xp-green` | XP progress, level-up bars |
| **Streak Fire** | — | `orange-500` | Streak counter, fire emoji 🔥 |

### 2.4 Topic Category Colors

Each ITPEC subject category has a dedicated accent color for its topic cards
in the Learning Map:

| Category | Accent | Tailwind Classes |
|---|---|---|
| **Technology** | Purple | `bg-purple-100 text-purple-700 border-l-purple-500` |
| **Security** | Red | `bg-red-100 text-red-700 border-l-red-500` |
| **Management** | Blue | `bg-blue-100 text-blue-700 border-l-blue-500` |
| **Strategy** | Emerald | `bg-emerald-100 text-emerald-700 border-l-emerald-500` |
| **Business** | Amber | `bg-amber-100 text-amber-700 border-l-amber-500` |

### 2.5 Neutral Palette

| Element | Tailwind Class |
|---|---|
| Page background | `bg-gray-50` |
| Card / header background | `bg-white` |
| Borders | `border-gray-200` |
| Primary text | `text-gray-900` |
| Secondary text | `text-gray-500` or `text-gray-600` |
| Disabled text | `text-gray-400` |
| Divider lines | `border-gray-200` |

---

## 3. Typography

### 3.1 Font Stack

NerdQuiz uses the **system font stack** (Tailwind defaults):

```
ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont,
"Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif
```

> **Future:** Consider adding a monospace font for code/quiz answers
> (e.g., `JetBrains Mono` or `Fira Code`) and an optional display font
> for the brand name.

### 3.2 Type Scale

| Role | Classes | Example |
|---|---|---|
| **Hero title** | `text-5xl sm:text-6xl font-bold` | Landing page headline |
| **Page title** | `text-3xl font-bold` | "My Learning Map" |
| **Section title** | `text-2xl font-bold` | "Quiz Results", "Mistake Garden" |
| **Card title** | `text-xl font-bold` or `text-lg font-bold` | Topic card name, lesson title |
| **Subtitle** | `text-lg font-semibold` | Description under headings |
| **Body** | `text-base` | Paragraphs, lesson content |
| **Secondary text** | `text-sm text-gray-500` | Metadata, timestamps, hints |
| **Badge / label** | `text-xs font-medium uppercase tracking-widest` | Category tags, "SUBJECT A" |
| **Stat number** | `text-3xl font-bold` or `text-5xl font-bold` | XP count, streak number |
| **Timer** | `font-mono text-lg font-bold` | Exam countdown |

### 3.3 Typography Rules

1. **One heading weight:** Use `font-bold` for all headings. Reserve
   `font-semibold` for subtitles and secondary emphasis.
2. **Color hierarchy:** Headings are `text-gray-900`, descriptions are
   `text-gray-600`, metadata is `text-gray-500`.
3. **Uppercase only for tiny labels:** `text-xs font-medium uppercase
   tracking-widest` for category tags and subject labels. Never uppercase
   body text.
4. **Markdown-rendered content** (lessons, quiz questions, explanations):
   inherits body styles. Don't apply custom markdown styling beyond the
   container.

---

## 4. Spacing System

Use Tailwind's spacing scale consistently. Here are the project conventions:

### 4.1 Page Layout Spacing

| Element | Classes |
|---|---|
| **Page horizontal padding** | `px-4` |
| **Page vertical padding** | `py-6` to `py-8` |
| **Content max-width** | `max-w-2xl` (quiz) / `max-w-3xl` (lessons) / `max-w-4xl` (mistake garden, exams) / `max-w-5xl` (topic detail) |
| **Centered content** | `mx-auto max-w-{size}` |
| **Section gap** | `gap-6` (card grids) |
| **Vertical rhythm** | `space-y-3` (compact lists) / `space-y-4` (standard) / `space-y-6` (forms, sections) |
| **Card internal padding** | `p-4` (compact) / `p-6` (standard) / `p-8` (featured) |

### 4.2 Spacing Rules

1. **Consistent gutters:** Always use `gap-6` for card grids, never `gap-4`
   or `gap-8`.
2. **Section separation:** Use `mb-6` or `space-y-6` between major sections.
3. **Inline elements:** Use `gap-2` to `gap-3` for tags, badges, and inline
   items.
4. **Form fields:** `space-y-4` between fields, `mb-2` between label and
   input.

---

## 5. Layout & Page Structure

### 5.1 Page Shell

Every route page follows this structure:

```tsx
<div className="min-h-screen bg-gray-50">
  <header className="border-b border-gray-200 bg-white">
    <div className="mx-auto flex max-w-{size} items-center justify-between px-4 py-3">
      {/* Logo / title + nav */}
    </div>
  </header>
  <main className="mx-auto max-w-{size} px-4 py-6">
    {/* Page content */}
  </main>
</div>
```

### 5.2 Header Pattern

| Element | Classes |
|---|---|
| **Sticky header** | `sticky top-0 z-10` (Learning Map, Exam) |
| **Non-sticky** | Static (Landing, Auth) |
| **Header height** | `py-3` or `py-4` |
| **Left side** | Back button + page title |
| **Right side** | Stats, streak, or action buttons |

### 5.3 Content Widths

| Page Type | Max Width | Rationale |
|---|---|---|
| Auth forms | `max-w-sm` | Narrow, focused |
| Quiz / Results | `max-w-2xl` | Single-column, readable |
| Lessons | `max-w-3xl` | Reading comfort |
| Mistake Garden | `max-w-4xl` | Wider table/list |
| Exam simulation | `max-w-4xl` | Timer + questions |
| Topic detail | `max-w-5xl` | Header + card grid |
| Landing page | Full-width | Hero section |

---

## 6. Component Patterns

### 6.1 Existing UI Components

Three reusable components exist in `src/web/src/components/ui/`:

#### Button

```tsx
<Button variant="primary" size="md">Start Quiz</Button>
```

| Prop | Values | Default |
|---|---|---|
| `variant` | `primary` \| `secondary` \| `outline` \| `ghost` | `primary` |
| `size` | `sm` \| `md` \| `lg` | `md` |

| Variant | Visual |
|---|---|
| `primary` | Solid purple-600 background, white text |
| `secondary` | Solid gray background, dark text |
| `outline` | Border only, transparent background |
| `ghost` | No border/background, text only |

> **Convention:** Prefer `<Button>` over inline `<button>` elements. The
> component handles focus rings, disabled states, and transitions.

#### Card

```tsx
<Card padding="md" className="extra-classes">
  {children}
</Card>
```

| Prop | Values | Default |
|---|---|---|
| `padding` | `none` \| `sm` \| `md` \| `lg` | `md` |
| `className` | string | — |

Base styles: `bg-white rounded-xl shadow-sm border border-gray-200`

#### Badge

```tsx
<Badge variant="success">Correct</Badge>
```

| Prop | Values | Default |
|---|---|---|
| `variant` | `default` \| `success` \| `warning` \| `error` \| `info` | `default` |

### 6.2 Component Conventions

All UI components share these base traits:

| Trait | Classes |
|---|---|
| **Border radius** | `rounded-lg` (buttons, inputs) / `rounded-xl` (cards, callouts) |
| **Transitions** | `transition-colors` for color changes / `transition-all` for interactive cards |
| **Focus ring** | `focus:outline-none focus:ring-2 focus:ring-purple-500 focus:ring-offset-2` |
| **Disabled state** | `disabled:opacity-50 disabled:cursor-not-allowed` |
| **Shadow** | `shadow-sm` (default cards) / `shadow-md` (hovered cards) / `shadow-lg` (modals) |

### 6.3 Common Patterns

#### Choice/Option Buttons (Quiz)
```tsx
<button className={`w-full text-left p-4 rounded-xl border-2 transition-all ${
  isSelected
    ? 'border-purple-500 bg-purple-50'
    : 'border-gray-200 bg-white hover:border-gray-300'
}`}>
  {choice.text}
</button>
```

#### Correct / Incorrect States
```tsx
// Correct
<div className="rounded-xl border-2 border-green-500 bg-green-50 p-4">
// Incorrect
<div className="rounded-xl border-2 border-red-500 bg-red-50 p-4">
```

#### Callout Box (Tips, Warnings, Examples)
```tsx
<div className={`rounded-r-lg border-l-4 p-4 ${borderColor} ${bgColor}`}>
  {children}
</div>
```

#### Loading Spinner
```tsx
<div className="flex items-center justify-center py-12">
  <div className="h-8 w-8 animate-spin rounded-full border-b-2 border-purple-600" />
</div>
```

#### Error State
```tsx
<div role="alert" className="rounded-xl border border-red-200 bg-red-50 p-4 text-sm text-red-700">
  {errorMessage}
</div>
```

#### Empty State
```tsx
<div className="rounded-xl border border-gray-200 bg-white p-6 text-center text-sm text-gray-500">
  {emptyMessage}
</div>
```

#### Progress Bar
```tsx
<div className="h-2 overflow-hidden rounded-full bg-gray-200">
  <div className="h-full bg-purple-600 rounded-full" style={{ width: `${percent}%` }} />
</div>
```

---

## 7. Icons & Emoji

### 7.1 Current Approach

NerdQuiz does **not** use an icon library. Icons come from two sources:

1. **Inline SVGs** — Used for functional icons (lock, check, chevron).
   All follow the pattern: `viewBox="0 0 20 20" fill="currentColor"`.
2. **Emoji** — Used for decorative/gamification icons:
   - 🔥 Streak / fire
   - ⚡ XP / energy
   - 🏆 Achievements
   - 📚 Lessons
   - 🎯 Quizzes
   - 🌱 Mistake Garden
   - 📝 Quiz questions
   - 📊 Stats

### 7.2 Icon Conventions

| Use Case | Approach |
|---|---|
| Functional UI (lock, check, expand) | Inline SVG components in `components/features/` |
| Gamification indicators | Emoji (text-based, large size) |
| Feature cards | Emoji as decorative element |
| Navigation | Text labels preferred over icons |

> **Future consideration:** If the icon set grows, adopt a library like
> `lucide-react` for consistency. Until then, inline SVGs are fine.

---

## 8. Interactive States

### 8.1 Hover Patterns

| Element | Hover Effect |
|---|---|
| **Buttons** | Darken background (`hover:bg-purple-700`) |
| **Cards** | Add shadow (`hover:shadow-md`) |
| **Choice options** | Border highlight (`hover:border-gray-300`) |
| **Links** | Color change (`hover:text-purple-700`) |

### 8.2 Selected States

| Element | Selected Appearance |
|---|---|
| **Quiz choice** | `border-purple-500 bg-purple-50` |
| **Topic card** | `border-l-4 border-purple-500` (left accent) |
| **Tab / nav item** | `text-purple-600 font-medium` |

### 8.3 Feedback States (Quiz)

| State | Visual |
|---|---|
| **Selected** | Purple border + purple-50 background |
| **Correct** | Green border + green-50 background + ✅ |
| **Incorrect** | Red border + red-50 background + ❌ |
| **Disabled (after answer)** | Reduced opacity on unselected options |

---

## 9. Responsive Design

### 9.1 Breakpoints

Use Tailwind's default breakpoints:

| Prefix | Min Width | Usage |
|---|---|---|
| (none) | 0px | Mobile-first default |
| `sm:` | 640px | Small tablets |
| `md:` | 768px | Tablets |
| `lg:` | 1024px | Desktop |

### 9.2 Responsive Patterns

| Pattern | Classes |
|---|---|
| **Card grid** | `grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3` |
| **Hero text** | `text-5xl sm:text-6xl` |
| **Stack to row** | `flex flex-col gap-4 sm:flex-row` |
| **Hide on mobile** | `hidden sm:block` |
| **Padding adjustment** | `px-4 sm:px-6 lg:px-8` |

### 9.3 Mobile-First Rules

1. **Default styles = mobile.** Write mobile styles without a breakpoint prefix.
2. **Enhance for larger screens.** Use `sm:`, `md:`, `lg:` to progressively
   enhance.
3. **Touch targets:** Minimum 44×44px tap targets on mobile (buttons already
   meet this with `py-2 px-4`).
4. **No hover-dependent interactions.** Hover effects enhance but are never
   required for functionality.

---

## 10. Animations & Transitions

### 10.1 Approved Animations

| Animation | Classes | Usage |
|---|---|---|
| **Spinner** | `animate-spin` | Loading states |
| **Pulse** | `animate-pulse` | Skeleton loading |
| **Bounce** | `animate-bounce` | Landing page mascot emoji |
| **Fade in** | `transition-opacity duration-200` | Show/hide elements |
| **Color transition** | `transition-colors` | Button hover, active states |

### 10.2 Animation Rules

1. **Subtle over flashy.** Animations should feel responsive, not distracting.
2. **Respect `prefers-reduced-motion`.** For any non-essential animation, add
   `motion-reduce:hidden` or conditionally disable.
3. **No auto-playing animations** that loop infinitely (except spinners).
4. **Keep transitions under 300ms.** Most should be 150–200ms.

---

## 11. Writing & Content

### 11.1 UI Copy

| Principle | Example |
|---|---|
| **Action-oriented buttons** | "Start Quiz" not "Submit" |
| **Encouraging feedback** | "Great job!" / "Keep going!" not "Correct" |
| **Specific empty states** | "No mistakes yet — keep studying!" not "No data" |
| **Helpful error messages** | "Could not load topics. Check your connection and try again." not "Error" |

### 11.2 Gamification Language

| Term | Meaning | Visual |
|---|---|---|
| **XP** | Experience points earned from quizzes | ⚡ gold number |
| **Streak** | Consecutive days of study | 🔥 orange number |
| **Mistake Garden** | Collection of wrong answers for review | 🌱 green accent |
| **Level** | Progress tier | 🏆 purple accent |

---

## 12. Accessibility

### 12.1 Core Requirements

1. **Color contrast:** All text must meet WCAG AA (4.5:1 for normal text,
   3:1 for large text). The current palette meets this — don't add lighter
   text colors.
2. **Focus indicators:** Every interactive element must have a visible focus
   ring (`focus:ring-2 focus:ring-purple-500 focus:ring-offset-2`).
3. **Semantic HTML:** Use `<main>`, `<header>`, `<nav>`, `<section>`,
   `<article>` instead of generic `<div>` for page structure.
4. **Form labels:** Every `<input>` must have an associated `<label>` or
   `aria-label`.
5. **Alt text:** All images need `alt` attributes. Decorative images use
   `alt=""`.
6. **Alert roles:** Error messages use `role="alert"`.
7. **Keyboard navigation:** All interactive elements must be reachable via
   Tab and activatable via Enter/Space.

### 12.2 Quiz-Specific Accessibility

1. **Answer feedback:** Don't rely on color alone to indicate correct/incorrect.
   Include text labels ("✓ Correct", "✗ Incorrect") or icons.
2. **Timer announcements:** Screen readers should announce timer warnings.
3. **Progress:** Announce quiz progress ("Question 3 of 10").

---

## 13. Dark Mode (Future)

> Not currently supported. If added later:

1. Define a `dark:` variant strategy in `tailwind.config.js`.
2. Use CSS custom properties for the color palette so dark mode can swap values.
3. Test all semantic colors (success, error, warning) in dark backgrounds.
4. Never use pure black (`bg-black`) — use `gray-900` or darker.

---

## 14. Design Checklist for New Features

When building a new page or component:

- [ ] Use existing `<Button>`, `<Card>`, `<Badge>` components where applicable
- [ ] Follow the page shell pattern (header + main + max-width)
- [ ] Use brand purple (`purple-600`) for primary actions, not blue
- [ ] Handle all four states: loading, error, empty, success
- [ ] Use `text-gray-500` for secondary text, `text-gray-900` for primary
- [ ] Border radius: `rounded-lg` for buttons/inputs, `rounded-xl` for cards
- [ ] Include focus rings on all interactive elements
- [ ] Mobile-first responsive design
- [ ] Use `transition-colors` on interactive elements
- [ ] No hardcoded hex values — use Tailwind color classes
- [ ] No inline styles — use Tailwind utilities or `cn()` for conditionals
- [ ] Semantic HTML elements (`<main>`, `<header>`, `<section>`)
- [ ] Accessible: labels, contrast, keyboard navigation

---

## 15. File Organization

```
src/web/src/
├── components/
│   ├── ui/                  # Shared primitives (Button, Card, Badge)
│   │   ├── Button.tsx
│   │   ├── Card.tsx
│   │   └── Badge.tsx
│   └── features/            # Feature-specific components
│       ├── TopicNode.tsx
│       └── ...
├── lib/
│   └── cn.ts                # clsx + tailwind-merge utility
├── routes/                  # Page components (one per route)
│   ├── LandingPage.tsx
│   ├── LoginPage.tsx
│   └── ...
└── styles/
    └── globals.css          # CSS variables + Tailwind directives
```

> **Rule:** New UI primitives go in `components/ui/`. Feature-specific
> components go in `components/features/`. Route-level pages go in `routes/`.
