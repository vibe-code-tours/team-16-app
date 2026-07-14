# Mid-point Review — NerdQuiz

> ⚠️ **Historical document** — reflects the state at mid-point (Week 1). For current
> status, see `docs/gsd/feature-board.md` (last synced 2026-07-15).

## 1. Current Progress (End of Week 1 / Mid-point)

We have successfully implemented the core learning loop. The application is functional and allows a user to move from registration to learning and practice.

### Completed Features:
- [x] **Authentication**: Full flow with Supabase Auth (Email/Google).
- [x] **Learning Map**: Visual topic tree fetching data from Supabase.
- [x] **Short Lessons**: Reading notes per topic with a dedicated viewer.
- [x] **Topic Quizzes**: 5-question quizzes with instant feedback.
- [x] **XP System**: Progress tracking via XP earned per correct answer.
- [x] **Mistake Garden**: Collection and review system for wrong answers.
- [x] **Content Seeding**: 20 subtopics across 5 categories seeded with lessons and questions.

### Technical Stack Validation:
- **Frontend**: React 19 + Tailwind CSS v4 + React Router v7.
- **Backend**: Spring Boot 3.5.9 (Java 25) for REST API + Supabase (Postgres + Auth + RLS).
- **Infrastructure**: GitHub Actions for CI.

---

## 2. Refined Path (Week 2 & Beyond)

Based on our current velocity, we are ahead of schedule on basic features. We will now shift focus from "Basic Functionality" to "Exam Readiness and Polish."

### Priority 1: Exam Simulation (High)
- Implement the timed "Subject-A" simulation (60 questions).
- Add the "Hearts" system to penalize wrong answers during simulation.
- Create a "Result Summary" page showing score, time taken, and weak areas.

### Priority 2: Data Scaling (Medium)
- Move from manual SQL seeding to a programmatic "PDF $ightarrow$ JSON $ightarrow$ SQL" pipeline.
- Expand dataset to cover 5-10 recent exam sessions.

### Priority 3: Polish & UX (Medium)
- Add animations (Framer Motion) for transitions between lessons and quizzes.
- Implement a "Streak" tracking system to motivate daily use.
- Improve mobile responsiveness for a "native-app" feel.

### Priority 4: Stretch Goals (Low)
- AI-powered weak point analysis based on Mistake Garden data.
- Flashcard system for key terminology.

---

## 3. Role Rotation Plan

To ensure all team members gain experience across the stack, we will rotate roles for the final sprint:

| Role | Week 1 (Previous) | Week 2 (New) | Focus Area |
|---|---|---|---|
| **Anchor** (Lead/Reviewer) | Member A | Member B | Integration & Quality Gate |
| **Frontend Lead** | Member B | Member C | UX, Animations, Mobile |
| **Backend/Data Lead** | Member C | Member A | Exam Sim Logic, PDF Pipeline |
| **QA/Docs Lead** | Member D | Member D | Testing, User Guide, Demo Prep |

---

## 4. Optimization Focus (Chapter 5 Goal)

We will implement the following optimizations:
1. **Query Optimization**: Use Supabase views or stored procedures for complex XP/Streak calculations.
2. **Bundle Size**: Audit `package.json` to remove unused dependencies.
3. **Token Efficiency**: Implement a custom AI skill to assist in extracting exam questions more accurately without redundant prompts.
