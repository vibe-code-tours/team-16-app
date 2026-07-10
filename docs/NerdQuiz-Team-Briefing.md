# NerdQuiz — Team Briefing

> Prepared by: Myo Min Lin
> Date: July 2026
> Purpose: Share research findings and key points before we start building together.

---

## 1. What We're Building

**NerdQuiz** — a gamified IT exam study and practice platform, inspired by Duolingo's learning style but designed for IT certification exams like ITPEC FE.

It's **not** just a question bank. It's a **learning experience** where students read short lessons, answer quizzes, track progress, and review their mistakes — all in one place.

---

## 2. Key Features We're Going For

| Feature | What It Means |
|---------|---------------|
| **Learning Map** | Visual map with locked/unlocked topics — like Duolingo's skill tree |
| **Short Lessons** | Brief reading notes (2-3 min) before each quiz |
| **5-Question Quizzes** | Bite-sized practice after each lesson |
| **Real Exam Simulation** | Timed exam with actual exam conditions |
| **XP, Hearts, Streak** | Motivation system — earn XP, maintain daily streak |
| **Mistake Garden** | Wrong answers go here for review — this is core for exam prep |
| **Flashcards** | Memorize key concepts with spaced repetition |
| **AI Adaptive Difficulty** | Questions get harder as you improve (simplified version first) |
| **AI Weak Point Analysis** | System highlights where you're struggling |
| **Cute Landing Page** | With a mascot — first impression matters |

---

## 3. Data Source — What We Found

### Where the questions come from

All our exam questions come from [ITPEC Past Exam Papers](https://itpec.org/pastexamqa/fe.html), which are freely available for educational use.

### What the data looks like

| Detail | Finding |
|--------|---------|
| **Available exams** | 39 sessions (April 2007 – October 2025) |
| **Questions per exam** | 80 total (60 Subject-A morning + 20 Subject-B afternoon) |
| **Total questions available** | ~3,120 questions |
| **Format** | PDF files — NOT structured data |
| **Answer choices** | 4 choices (a-d) for Subject-A, 5-10 choices for Subject-B |
| **Answer keys** | Separate PDF with simple answer table |

### The challenge

**Questions are in PDFs, not in a database.** We need to extract and structure them before we can use them in the app. This is one of our biggest tasks.

---

## 4. The Extraction Problem — This Needs Team Effort

### Why it's hard

- PDFs have inconsistent file naming across years
- Subject-B questions are complex — they include code snippets, diagrams, and "answer groups" (pick the right combination)
- Some questions reference images/figures that don't extract as text
- We need to categorize each question by topic (Technology, Security, Management, etc.)

### Our plan

| Phase | What | Who |
|-------|------|-----|
| Download | Get all 39 exam ZIPs from ITPEC | Data team |
| Extract text | Convert PDFs to raw text | Data team |
| Parse & structure | Use AI (GPT/Claude) to parse into JSON | Data team + AI |
| Human review | Verify extracted data is correct | Everyone helps |
| Seed database | Import structured data into MySQL | Backend team |

### Realistic scope for demo

**We don't need all 3,120 questions for the demo.** Starting with 3-4 recent exams (~320 questions) is enough to show all features working. We can expand later.

---

## 5. Duolingo-Style — What Works, What Doesn't

This was a key research question: **Can we actually apply Duolingo's style to IT exam prep?**

### What translates well ✅

| Duolingo Feature | Why It Works for Us |
|------------------|-------------------|
| Learning map with levels | FE exam has clear topic categories — perfect for a map |
| Short lessons before quizzes | Bite-sized reading → immediate practice |
| XP and streak | Motivates daily study — critical for exam prep |
| Mistake Garden | Exam prep IS about learning from mistakes |
| Unlock progression | Master basics before moving to advanced topics |
| 5 questions per session | Perfect chunk size for focused practice |

### What doesn't translate well ⚠️

| Duolingo Pattern | Problem for IT Exams |
|------------------|---------------------|
| Speed-based answering | FE questions require careful reading — not instant recall |
| Hearts/lives system | Frustrating during practice — keep it only for exam simulation |
| "Type the answer" | FE questions are long scenarios — not word translation |
| Repetitive drilling of same item | FE covers huge breadth — needs variety, not repetition |
| Short, simple answers | FE questions have paragraphs of context |

### Our adapted approach

**Keep the motivation system (XP, streak, map), but change the learning flow:**

- No timer pressure during practice mode (let students think)
- Show explanation after each answer (learning, not testing)
- Hearts only in exam simulation (realistic pressure)
- Mistake Garden as the core review feature

---

## 6. Scope Reality Check

### What we CAN build in 1 week (Local Demo)

- ✅ User registration and login
- ✅ Learning map with topic categories
- ✅ Short reading lessons
- ✅ 5-question quizzes with instant feedback
- ✅ XP, hearts, streak tracking
- ✅ Mistake Garden for wrong answers
- ✅ Basic exam simulation (timed)
- ✅ Simple adaptive difficulty (rule-based)
- ✅ Cute landing page with mascot
- ✅ 3-4 exam sessions worth of questions (~320)

### What's a stretch goal

- ⚠️ Full AI adaptive difficulty
- ⚠️ AI weak point analysis
- ⚠️ Flashcard system
- ⚠️ Polished animations and transitions

### What's NOT happening in week 1

- ❌ AI Coach (future feature)
- ❌ All 3,120 questions extracted
- ❌ Advanced gamification (leaderboards, achievements)
- ❌ Native mobile app

---

## 7. How We'll Work — GSD (Get Stuff Done) Approach

### The reality

We have ~1 week for local demo. Writing complete, detailed requirements for every feature before coding starts would take days we don't have. **We don't have time for traditional spec-first development.**

### Our approach

**Each developer owns their feature end-to-end** — from figuring out what to build, to how to build it, to shipping it.

| Traditional Way | Our Way (GSD) |
|----------------|---------------|
| PM writes full spec | Developer reads the feature goal |
| Developer waits for spec | Developer uses AI (Claude Code, GPT) to research and plan |
| Backend waits for frontend specs | Each dev figures out their own API contracts |
| Long planning meetings | Quick sync, then go build |
| "I'm blocked, waiting for requirements" | "I looked it up, figured it out, shipping it" |

### What this means for each developer

1. **You get a feature goal** — e.g., "Build the Mistake Garden"
2. **You figure out the details** — use AI tools to research best practices, design patterns, data structures
3. **You plan your own approach** — database schema, API endpoints, UI components
4. **You build it** — with AI assistance for code generation
5. **You sync with the team** — short check-ins to avoid conflicts

### What's expected

- **Be resourceful** — don't wait for someone to hand you answers
- **Use AI tools** — Claude Code, ChatGPT, Copilot — they're your research assistants
- **Make decisions** — if something is unclear, decide and move forward
- **Communicate** — if your decision affects someone else's work, sync first
- **Document as you go** — quick notes on what you built and why

### What the team lead provides

- **Feature goals** — high-level "what" (not detailed "how")
- **Architecture boundaries** — database schema, API conventions, shared components
- **Unblocking** — if you're truly stuck, the team figures it out together
- **Integration** — making sure everyone's work fits together

### Why this works for us

- **Speed** — no bottleneck waiting for complete specs
- **Ownership** — each developer deeply understands their feature
- **Learning** — everyone grows by researching and solving problems independently
- **Flexibility** — we can adjust as we discover what works and what doesn't

---

## 8. Key Decisions to Make as a Team (Quick Votes)

Before we start coding, we need to agree on a few things:

| Decision | Options | My Suggestion |
|----------|---------|---------------|
| **Frontend framework** | React / Vue / Vanilla + Tailwind | React (most team members know it) |
| **How many exams for demo?** | 2 / 3 / 4 sessions | 3 sessions (balanced effort vs value) |
| **Who handles data extraction?** | Dedicated pair / Everyone takes turns | 2 people dedicated, others help review |
| **Question difficulty assignment** | Manual / Rule-based / AI | Rule-based for week 1, AI later |
| **Mascot design** | AI-generated / Hand-drawn / Free asset | AI-generated (fast, cute, unique) |

---

## 9. Team Coordination

### Communication

- Daily standup (15 min) — what did you do, what's blocking you
- Shared Slack/Discord channel for quick questions
- PR reviews — at least one teammate reviews before merge

### Work distribution principle

- **No one works in isolation** — pair up on complex features
- **Data extraction is a shared responsibility** — everyone should help verify
- **Frontend and backend should deploy early** — even if incomplete, so we can integrate

### What "done" looks like for demo

1. A student can register, log in, and see the learning map
2. They can open a topic, read a lesson, and answer 5 questions
3. They earn XP and see their streak
4. Wrong answers appear in the Mistake Garden
5. They can start a timed exam simulation
6. It works on a phone browser

---

## 10. Risks to Watch

| Risk | Impact | Mitigation |
|------|--------|------------|
| Data extraction takes too long | No questions = no app | Start extraction day 1, use AI + human review |
| Subject-B questions too complex to parse | Missing data | Focus on Subject-A for demo, add B later |
| Team members have different skill levels | Slow progress | Pair programming, clear task breakdown |
| Scope creep (adding too many features) | Nothing finishes | Stick to the core list, defer extras |
| Integration issues (frontend + backend) | Demo fails | Deploy early, test integration daily |

---

## 11. Summary — What I Want Everyone to Know

1. **This project is ambitious but doable** — if we focus on the core features first
2. **Data extraction is our biggest risk** — we need to start early and work together on it
3. **Duolingo-style works for motivation, not for question style** — we're adapting, not copying
4. **320 questions is enough for demo** — we don't need all 3,120 right away
5. **Mistake Garden is THE exam prep feature** — this is what makes us different from a plain quiz app
6. **GSD approach** — no one waits for complete specs. You get a feature goal, you figure out the details using AI tools, you build it, you ship it
7. **Week 1 is for Local Demo** — functional but rough. Week 2 is for polish and public demo

---

*Let's build something great together. Questions? Let's discuss in our next team meeting.*
