# NerdQuiz — Comprehensive Q&A

> A gamified IT exam prep platform for ITPEC FE certification. Everything you need to
> understand the project in one place: architecture, features, data flow, and practical use cases.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Tech Stack & Architecture](#2-tech-stack--architecture)
3. [Database Schema & Data Flow](#3-database-schema--data-flow)
4. [Authentication & Authorization](#4-authentication--authorization)
5. [Landing Page](#5-landing-page)
6. [Learning Map](#6-learning-map)
7. [Lessons](#7-lessons)
8. [Quizzes](#8-quizzes)
9. [Exam Simulation](#9-exam-simulation)
10. [Mistake Garden](#10-mistake-garden)
11. [Weak Point Analysis](#11-weak-point-analysis)
12. [XP & Streak System](#12-xp--streak-system)
13. [User Profile](#13-user-profile)
14. [Admin Dashboard](#14-admin-dashboard)
15. [API Endpoints](#15-api-endpoints)
16. [Security & RLS](#16-security--rls)
17. [Data Extraction Pipeline](#17-data-extraction-pipeline)
18. [Deployment & CI/CD](#18-deployment--cicd)
19. [Frontend Architecture](#19-frontend-architecture)
20. [Backend Architecture](#20-backend-architecture)

---

## 1. Project Overview

### Q: What is NerdQuiz?

**A:** NerdQuiz is a **gamified IT exam study platform** inspired by Duolingo's learning style, designed specifically for **ITPEC FE (Fundamental IT Engineer) certification** candidates. It helps students prepare for the exam through short lessons, topic quizzes, exam simulations, and mistake review — all wrapped in a motivational XP and streak system.

### Q: Who is the target audience?

**A:** ITPEC FE certification candidates in Asia, primarily in Japan, the Philippines, Myanmar, Vietnam, and other countries that use the ITPEC standard. The typical user is a student or early-career IT professional studying for their certification exam.

### Q: What makes NerdQuiz different from a plain question bank?

**A:** Unlike a simple Q&A app, NerdQuiz provides a **complete learning loop**:

```
Read a lesson → Take a quiz → Earn XP → Review mistakes → Repeat
                                 ↓
                         Exam simulation → Result analysis
```

It adapts Duolingo's motivational features (XP, streaks, learning map) while respecting that IT exam questions require careful reading and understanding, not speed-based answering.

### Q: What are the core features?

```
┌──────────────────────────────────────────────────────┐
│                 NerdQuiz Features                      │
├──────────────────────────────────────────────────────┤
│  📚 Bite-sized lessons (2-3 min reads)               │
│  🎯 Topic quizzes (5 questions, instant feedback)     │
│  🗺️ Learning map with skill tree progression          │
│  🌱 Mistake Garden (wrong answer review)              │
│  📝 Exam simulation (60 min, 60 questions)            │
│  ⚡ XP & streak tracking                              │
│  📊 Weak point analysis                               │
│  🏆 Achievement tracking                              │
│  🎨 Dark mode support                                 │
│  📱 Mobile responsive                                 │
└──────────────────────────────────────────────────────┘
```

### Q: What exam data is used?

**A:** Questions come from **ITPEC Past Exam Papers** ([itpec.org](https://itpec.org/pastexamqa/fe.html)), freely available for educational use. The project currently seeds **3 exam sessions** (2021-April, 2021-October, 2022-April) plus business questions, totaling approximately **180+ questions** focused on **Subject-A** (morning session, 60 questions per exam).

---

## 2. Tech Stack & Architecture

### Q: What is the technology stack?

```
┌──────────────────────────────────────────────────────────┐
│                    Technology Stack                        │
├──────────┬───────────────────────────────────────────────┤
│ Frontend │ React 19, TypeScript 6, Tailwind CSS 4.3      │
│          │ React Router v7, Vite 8                       │
├──────────┼───────────────────────────────────────────────┤
│ Backend  │ Java 25, Spring Boot 3.5, Gradle              │
│          │ Spring Security, Spring Data JPA               │
│          │ Nimbus JOSE+JWT 9.41                           │
├──────────┼───────────────────────────────────────────────┤
│ Database │ Supabase (PostgreSQL)                          │
│          │ Row Level Security, pgcrypto                   │
├──────────┼───────────────────────────────────────────────┤
│ Auth     │ Supabase Auth (email/password + Google OAuth)  │
├──────────┼───────────────────────────────────────────────┤
│ Deploy   │ Frontend: Netlify | Backend: Docker → Cloud Run│
│          │ CI: GitHub Actions                             │
└──────────┴───────────────────────────────────────────────┘
```

### Q: How is the system architected?

**A:** The architecture follows a **three-tier pattern** with a hybrid data access approach:

```
┌──────────────┐       ┌──────────────────┐       ┌──────────────────┐
│   React SPA  │──────▶│  Spring Boot API  │──────▶│  Supabase        │
│  (src/web/)  │       │  (src/api/)       │       │  (Postgres DB)   │
│              │       │                   │       │                  │
│  React Router│       │  REST endpoints   │       │  Migrations in   │
│  Tailwind CSS│       │  JWT verification │       │  supabase/       │
└──────┬───────┘       └───────────────────┘       └──────────────────┘
       │
       │  Supabase Auth SDK   ← Direct auth calls
       │  (register, login)    (credentials never hit backend)
       ▼
┌──────────────────┐
│  Supabase Auth   │
│  (managed)       │
└──────────────────┘
```

**Two data access patterns:**

| Path | How | Security |
|------|-----|----------|
| **Backend API** | `React → Spring Boot → Postgres` | JWT verification + business logic |
| **Direct Supabase** | `React → Supabase SDK → Postgres` | RLS policies only (known deviation) |

### Q: Where are the API endpoints defined?

```
Base path: /api/v1/...

Frontend (React)                    Backend (Spring Boot)           Database
     │                                     │
     │  POST /api/v1/me/profile             │  Create/get user profile
     │  POST /api/v1/me/streak              │  Update login streak
     │  GET  /api/v1/topics                 │  List topics with progress
     │  GET  /api/v1/subtopics/{id}/lessons │  Get lessons for subtopic
     │  POST /api/v1/lessons/{id}/complete  │  Mark lesson complete
     │  GET  /api/v1/subtopics/{id}/quiz    │  Get quiz questions
     │  POST /api/v1/quizzes/start          │  Start a quiz session
     │  POST /api/v1/quizzes/{id}/answers   │  Submit an answer
     │  GET  /api/v1/quizzes/{id}/result    │  Get quiz results
     │  POST /api/v1/exams/start            │  Start exam simulation
     │  POST /api/v1/exams/{id}/answers     │  Submit exam answer
     │  POST /api/v1/exams/{id}/finish      │  Finish exam
     │  GET  /api/v1/exams/{id}/result      │  Get exam results
     │  GET  /api/v1/me/mistakes            │  List user mistakes
     │  PUT  /api/v1/me/mistakes/{id}/review│  Mark mistake reviewed
     │  GET  /api/v1/me/weak-points         │  Weak point analysis
     │  GET  /api/v1/admin/stats            │  Admin dashboard stats
     │  GET  /api/v1/admin/users            │  Admin user list
     │  GET  /api/v1/admin/users/{id}       │  Admin user details
     │  PUT  /api/v1/admin/users/{id}/role  │  Change user role
     │  POST /api/v1/admin/users/{id}/deactivate │ Deactivate user
     │  POST /api/v1/admin/users/{id}/reset-streak│ Reset streak
```

---

> 📊 **Entity-Relationship Diagram:**
> See [docs/diagrams/ER_diagram.png](diagrams/ER_diagram.png) for a visual representation of all
> tables, relationships, and foreign keys.

## 3. Database Schema & Data Flow

### Q: What are the main database tables?

**A:** The schema has **25+ tables** organized by domain:

```
📁 Core Content
   ├── topics            - 5 IT categories (Technology, Security, etc.)
   ├── subtopics         - 20 sub-topics within categories
   ├── lessons           - Short reading lessons with JSON content blocks
   ├── lesson_prerequisites - Lesson dependency chain
   ├── questions         - Exam questions with choices, difficulty, images
   └── question_subtopics - Question-to-subtopic mapping

📁 Learning Progress
   ├── user_lesson_progress  - Lesson completion tracking
   ├── quiz_sessions         - Practice quiz attempts
   ├── quiz_session_questions- Questions issued in a quiz session
   ├── quiz_answers          - Individual answer records
   ├── user_subtopic_mastery - Mastery scores per subtopic
   └── user_daily_activity   - Daily question/XP counts

📁 Exam System
   ├── exams              - Exam definitions (e.g., "2021-April Subject-A")
   ├── exam_questions     - Questions in each exam
   ├── exam_sessions      - User exam attempts
   ├── exam_session_questions - Questions issued per session
   ├── exam_answers       - Exam answer records
   └── exam_heart_events  - Heart deduction tracking (legacy)

📁 User System
   ├── user_profiles      - Display name, role, avatar, email
   ├── user_stats         - XP, streak, quiz/exam counts
   ├── xp_events          - XP transaction log (idempotent)
   └── mistakes           - Wrong answer collection
       └── mistake_reviews - Review history

📁 Flashcards (stretch)
   ├── flashcards              - Flashcard definitions
   ├── user_flashcard_state    - Spaced repetition state
   └── flashcard_reviews       - Review history with SM-2 algorithm
```

### Q: What is the seed data?

```sql
-- 5 Topics (categories)
Technology, Security, Management, Strategy, Business

-- 20 Subtopics (3-7 per topic)
Computer Architecture, Data Structures, Algorithms, Databases,
Networking, Operating Systems, Software Development,
Cryptography, Network Security, Access Control, Security Threats,
Project Management, Quality Assurance, Development Processes,
Intellectual Property, IT Governance, Business Strategy,
Finance, Procurement, Business Operations

-- 32+ Lessons with rich JSON content blocks
-- 180+ Questions from 3 exam sessions
-- Difficulty rules trigger (auto-assigns easy/medium/hard)
```

### Q: How are questions structured in the database?

```json
// Each question in the 'questions' table:
{
  "id": "uuid",
  "subtopic_id": "uuid (references subtopics)",
  "exam_session": "2021-April",
  "subject": "A",
  "question_number": 1,
  "question_text": "Which of the following is an example of...",
  "content_blocks": [],              // Rich content (code blocks, tables)
  "images": [{ "url": "...", "alt": "..." }],
  "choices": [
    { "label": "a", "text": "Encryption algorithm..." },
    { "label": "b", "text": "Firewall configuration..." },
    { "label": "c", "text": "Access control list..." },
    { "label": "d", "text": "Digital signature..." }
  ],
  "correct_answer": "a",
  "explanation": "The correct answer is A because...",
  "difficulty": "medium",           // easy | medium | hard
  "difficulty_score": 0.500,        // 0.000 - 1.000
  "times_answered": 42,
  "times_correct": 28,
  "published": true
}
```

---

## 4. Authentication & Authorization

### Q: How does authentication work?

**A:** The auth flow is **frontend-to-Supabase**, never passing credentials through the backend:

```
1. User fills in email/password (or clicks Google OAuth)
2. Frontend calls supabase.auth.signInWithPassword() or signInWithOAuth()
3. Supabase returns JWT (access + refresh tokens)
4. Frontend stores JWT in Supabase's default storage
5. On API calls, frontend attaches: Authorization: Bearer <token>
6. Backend verifies JWT signature via Supabase JWKS endpoint
7. Backend extracts user ID from JWT sub claim
8. Backend creates/updates user profile on first login
```

### Q: What about role-based access control?

**A:** Two roles are supported:

| Role | Access | Stored in |
|------|--------|-----------|
| `user` | Learning map, lessons, quizzes, exam, mistakes, profile | `user_profiles.role` |
| `admin` | Everything above + admin dashboard, user management | `user_profiles.role` |

```typescript
// Route guards in App.tsx
<Route path="/admin" element={
  <ProtectedRoute>           // Must be logged in
    <AdminRoute>             // Must have admin role
      <Layout><AdminDashboard /></Layout>
    </AdminRoute>
  </ProtectedRoute>
} />
```

### Q: How does the backend verify JWTs?

```java
// JwtAuthenticationFilter (simplified)
public class JwtAuthenticationFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, ...) {
        String token = extractBearerToken(request);
        if (token != null) {
            JWKSet jwks = loadJWKS();           // Cached from Supabase
            JWT verified = verifyToken(token, jwks);  // Signature + expiry
            String userId = verified.getSubject();     // sub claim
            SecurityContextHolder.getContext()
                .setAuthentication(new JwtAuthentication(userId));
        }
        chain.doFilter(request, response);
    }
}
```

---

## 5. Landing Page

### Q: What does the landing page show?

```
┌─────────────────────────────────────────────────────────────┐
│  ⚡ NerdQuiz                    [Sign in] [Get started]     │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  [IT Exam Prep — Gamified]                                   │
│                                                              │
│  NerdQuiz                                                    │
│                                                              │
│  A focused, encouraging way to prepare for ITPEC FE          │
│  certification with lessons, quizzes, review, and exam       │
│  practice in one learning loop.                              │
│                                                              │
│  [Start learning free →]  [Continue your journey]            │
│                                                              │
│  ┌─────────────────────────────────────────────┐             │
│  │ 🦉 Today's mission                          │             │
│  │ Learn a little, prove it, and keep improving│             │
│  │ ┌──────┬──────┬──────┐                     │             │
│  │ │2-3m  │  5Q  │ 60Q  │                     │             │
│  │ │Lessons│Quizzes│Exam  │                     │             │
│  │ └──────┴──────┴──────┘                     │             │
│  │ ████████████████████░░░░ 70%               │             │
│  └─────────────────────────────────────────────┘             │
│                                                              │
│  [Complete learning loop]                                    │
│  Everything you need to pass                                 │
│                                                              │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐                     │
│  │ 📚       │ │ 🎯       │ │ 🗺️       │                     │
│  │Bite-sized│ │Practice  │ │Learning  │                     │
│  │ lessons  │ │ quizzes  │ │ map      │                     │
│  ├──────────┤ ├──────────┤ ├──────────┤                     │
│  │ 🌱       │ │ 📝       │ │ ⚡       │                     │
│  │Mistake   │ │Exam sim  │ │XP &      │                     │
│  │ Garden   │ │          │ │ streaks  │                     │
│  └──────────┘ └──────────┘ └──────────┘                     │
└─────────────────────────────────────────────────────────────┘
```

**Use case:** A new visitor arrives at the site. Within seconds they see:
- The value proposition (ITPEC FE prep, gamified)
- How it works (lessons → quizzes → exam → mistake review)
- Quick stats showing the learning format
- Clear CTA to get started

---

## 6. Learning Map

### Q: How does the Learning Map work?

**A:** The Learning Map is the **central navigation hub** — a visual roadmap showing all 5 ITPEC topic categories with their subtopics, each in locked/unlocked/in_progress/completed states.

```
┌──────────────────────────────────────────────────────┐
│  [Today's quest]                                     │
│                                                       │
│  Ready for your next win, Alex?                      │
│  Your 3-day streak is glowing. Keep the momentum!    │
│                                                       │
│  [Continue Technology →]  [View full roadmap]        │
│                                                       │
│  ┌──────────────────────────────────────┐            │
│  │ 🏆 Journey progress                  │            │
│  │ 45%                                  │            │
│  │ ████████████████░░░░░░░░            │            │
│  │ ⚡ 230 XP    🔥 3-day streak        │            │
│  └──────────────────────────────────────┘            │
│                                                       │
│  ┌─── [Your roadmap] ─────────────────────────────┐  │
│  │                                                │  │
│  │ ● TECHNOLOGY — Milestone · 3 of 7 cleared     │  │
│  │                                                │  │
│  │   ✅ 1. Computer Architecture                  │  │
│  │       │                                       │  │
│  │   ✅ 2. Data Structures                       │  │
│  │       │                                       │  │
│  │   🔄 3. Algorithms (in progress)              │  │
│  │       │                                       │  │
│  │   🔒 4. Databases                             │  │
│  │   ...                                         │  │
│  │                                                │  │
│  │ ● SECURITY — Milestone · 1 of 4 cleared       │  │
│  │   ...                                         │  │
│  └────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────┘
```

**Use case:** A returning student opens the app. They see their overall progress (45%), their current streak (3 days), and exactly which topic to continue next. The map guides them: "Continue Algorithms" is the most actionable next step.

### Q: How are topics grouped?

```typescript
const CATEGORY_ORDER = [
  'Technology',   // 7 subtopics: purple
  'Security',     // 4 subtopics: red
  'Management',   // 3 subtopics: blue
  'Strategy',     // 3 subtopics: emerald
  'Business',     // 3 subtopics: amber
]
```

### Q: How are topics tracked per user?

```typescript
interface TopicWithStatus extends Topic {
  status: 'locked' | 'not_started' | 'in_progress' | 'completed'
  progress: TopicProgress | null  // questions_answered, questions_correct
}
```

The backend computes status by checking prerequisite completion and user progress via `TopicService`, leveraging `user_subtopic_mastery` and `user_lesson_progress` tables.

---

## 7. Lessons

### Q: What are lessons and how do they work?

**A:** Lessons are **short reading notes (2-3 minutes)** that introduce key concepts before a quiz. Each lesson belongs to a subtopic and is displayed before the user can start the quiz.

```typescript
// Lesson structure in the database
interface Lesson {
  id: string
  subtopic_id: string
  title: string                                     // "What is Encryption?"
  content_blocks: ContentBlock[]                     // Rich JSON content
  estimated_minutes: number                          // 2-3 min read
  xp_reward: number                                  // XP for completing
  display_order: number                              // Sequence
  published: boolean
}
```

```typescript
// Content blocks can be:
type ContentBlock =
  | { type: 'paragraph'; text: string }
  | { type: 'heading'; text: string; level: number }
  | { type: 'code'; language: string; code: string }
  | { type: 'list'; items: string[]; ordered: boolean }
  | { type: 'image'; url: string; alt: string; caption?: string }
```

### Q: What's the lesson flow?

```
Learning Map → Click topic → Topic Detail (list of subtopics)
                                ↓
                    Click subtopic → Lesson Page
                                ↓
                         Read lesson content
                                ↓
                     Mark complete (POST /api/v1/lessons/{id}/complete)
                                ↓
                     XP reward earned + quiz unlocked
                                ↓
                     Redirect to QuizPage (/quiz/{subtopicId})
```

**Use case:** A student is studying "Cryptography" under Security. They open the lesson "Introduction to Encryption," read a 2-minute explanation with code examples, mark it complete, earn 10 XP, and are immediately directed to a 5-question quiz to test understanding.

---

## 8. Quizzes

### Q: How do the practice quizzes work?

**A:** Each subtopic has **5-question quizzes** with instant feedback after each answer. This is the core practice mechanic.

```
┌─────────────────────────────────────────────────────────────┐
│  Quiz: Data Structures                        Progress: 3/5 │
│  ████████░░░░░░░░░░░░░░░░                                  │
│                                                              │
│  Q3 of 5                                                     │
│                                                              │
│  Which data structure operates on a Last-In-First-Out        │
│  (LIFO) principle?                                           │
│                                                              │
│  ○ a. Queue                                                  │
│  ○ b. Stack  ◄── selected                                    │
│  ○ c. Array                                                  │
│  ○ d. Linked List                                            │
│                                                              │
│  [Submit Answer]                                             │
│                                                              │
│  ┌───────────────────────────────────────────┐              │
│  │ ✅ Correct!                               │              │
│  │                                           │              │
│  │ A Stack follows LIFO: the last element    │              │
│  │ added is the first one removed. Think of  │              │
│  │ a stack of plates — you take the top one. │              │
│  │                                           │              │
│  │          [Next Question →]                │              │
│  └───────────────────────────────────────────┘              │
└─────────────────────────────────────────────────────────────┘
```

### Q: What happens after each answer?

```typescript
// Backend flow in QuizService.submitAnswer():
1. Validate session ownership and status
2. Validate question was issued for this session
3. Reject duplicate answers
4. Check correctness
5. If wrong → record in mistakes table (Mistake Garden)
6. Update session score and XP
7. If all 5 answered → mark session completed
8. Award XP (10 per correct answer)
9. Update subtopic mastery score
```

### Q: How does the quiz flow work from start to finish?

```
Start Quiz → Backend picks 5 random questions for the subtopic
              ↓
Display Q1 → User selects answer → Submit
              ↓
Show: ✅ Correct! (with explanation)
   OR: ❌ Wrong. Correct answer is X (with explanation)
              ↓
Auto-advance or user clicks "Next Question"
              ↓
... repeat for all 5 questions ...
              ↓
Show Quiz Result screen: score, XP earned, answer review
              ↓
Wrong answers automatically appear in Mistake Garden
```

**Use case:** After reading the "Data Structures" lesson, a student takes the 5-question quiz. They get 4 out of 5 correct, earn 40 XP, see explanations for all answers, and the one wrong answer is saved to their Mistake Garden for later review.

---

## 9. Exam Simulation

### Q: What is the Exam Simulation?

**A:** The exam simulation replicates **real ITPEC FE exam conditions**: 60 questions with a 60-minute countdown timer. No heart penalties — wrong answers simply don't earn XP. This is the most complex feature in the app.

### Q: How does the Exam Simulation work?

```
┌─────────────────────────────────────────────────────────────┐
│  Exam Simulation                    [Finish Exam]  ⏱️ 42:15 │
├─────────────────────────────────────────────────────────────┤
│  ██████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│
│  Question 12 of 60                                          │
│                                                              │
│  Which of the following is NOT a characteristic of a        │
│  firewall?                                                   │
│                                                              │
│  ○ a. Filters network traffic based on rules                │
│  ● b. Encrypts data at rest  ◄── selected                   │
│  ○ c. Can be hardware or software-based                     │
│  ○ d. Inspects packet headers                               │
│                                                              │
│  [Submit Answer]                                             │
│                                                              │
│  ┌───────────────────────────────────────────┐              │
│  │ ❌ Incorrect                             │              │
│  │ Correct answer: a                         │              │
│  │                                           │              │
│  │ Firewalls filter traffic but don't        │              │
│  │ encrypt data. Encryption is handled by    │              │
│  │ other mechanisms.                         │              │
│  │                                           │              │
│  │           [Next Question →]               │              │
│  └───────────────────────────────────────────┘              │
│                                                              │
│  ← Previous                    [Submit Early]  View Results→│
└─────────────────────────────────────────────────────────────┘
```

### Q: How are exam questions selected?

**A:** The backend picks random questions from the entire question pool:

```java
// ExamService.startExam():
List<Question> questions = difficulty == null
    ? questionRepository.findUsableExamQuestionsAll(questionCount)
    : questionRepository.findUsableExamQuestionsByDifficulty(questionCount, difficulty);

// Repository queries (native SQL):
// findUsableExamQuestionsAll:
//   SELECT * FROM questions WHERE published = true
//   ORDER BY RANDOM() LIMIT :questionCount
//
// findUsableExamQuestionsByDifficulty:
//   SELECT * FROM questions WHERE published = true AND difficulty = :difficulty
//   ORDER BY RANDOM() LIMIT :questionCount
```

The selected questions are stored in `exam_session_questions` so the submit endpoint can validate that each answer belongs to the session's issued question set — preventing answer injection from outside the session.

### Q: What are the key features of the exam?

```
Feature              Detail
──────────────────────────────────────────────────
Questions            60 random questions from pool
Timer               60 minutes, auto-submits when expired
Answer flow         Submit → instant feedback → next
Navigation          Jump to any question via progress bar
Submit early        Finish before time runs out
Auto-expire         Timer reaches 0 → exam auto-submits
Results             Score %, correct/total, XP earned
Answer review       Per-question breakdown with explanations
Pass threshold      60% or higher = pass
Difficulty filter   All / Easy / Medium / Hard
Question validation Answers validated against issued question set
```

### Q: What happens when an exam completes?

```typescript
// Backend flow in ExamService.finishExam():
1. Count correct answers from exam_answers table
2. Calculate score percentage: (correct / total) × 100
3. Award XP: correct × 10 XP
4. Mark session as completed / expired / abandoned
5. Return: sessionId, totalQuestions, correctAnswers,
           scorePercentage, status, xpEarned

// Result screen shows:
┌─────────────────────────────────────┐
│        🏆 Congratulations!          │
│  You passed the exam simulation!    │
│                                     │
│  ┌──────┬──────────┬──────────┐    │
│  │ 72%  │ 43/60    │  430 XP  │    │
│  │ Score│ Correct  │  Earned  │    │
│  └──────┴──────────┴──────────┘    │
│                                     │
│  Q1  ✅ Correct                     │
│  Q2  ❌ Incorrect (Your: b, Correct: a)
│  Q3  ✅ Correct                     │
│  ...                                │
│                                     │
│  [Take Another Exam]                │
└─────────────────────────────────────┘
```

**Use case:** A student has completed all topics and feels ready. They start the exam simulation, answer all 60 questions in 45 minutes, submit early, score 72% (pass), earn 430 XP, and review every answer with explanations for the ones they got wrong.

---

## 10. Mistake Garden

### Q: What is the Mistake Garden?

**A:** The Mistake Garden is a **centralized review space** where all wrong answers from quizzes are collected. Students can review each mistake, see the correct answer with explanation, and mark it as reviewed.

**It is the core exam prep feature** — what makes NerdQuiz different from a plain quiz app.

```
┌─────────────────────────────────────────────────────────────┐
│  Your Mistake Garden                                         │
│                                                              │
│  Every mistake is a seed for growth. Review your wrong       │
│  answers to master the material.                             │
│                                                              │
│  🔍 [Search questions...                     ]               │
│                                                              │
│  [All] [Technology] [Security] [Management] [Strategy] ...   │
│                                                              │
│  ┌─── Technology ──────────────────────────────────── 12 ──┐ │
│  │                                                        │ │
│  │  📅 Jul 15, 2026                      [Mark Reviewed]  │ │
│  │                                                        │ │
│  │  Question: Which of the following is NOT a type of     │ │
│  │  database index?                                       │ │
│  │                                                        │ │
│  │  ┌──────────────────────┐ ┌──────────────────────┐    │ │
│  │  │ ❌ Your Answer       │ │ ✅ Correct Answer    │    │ │
│  │  │                      │ │                      │    │ │
│  │  │ b. B-tree index     │ │ d. Sequential index  │    │ │
│  │  └──────────────────────┘ └──────────────────────┘    │ │
│  │                                                        │ │
│  │  💡 Explanation: B-tree, hash, and bitmap are real    │ │
│  │  index types. "Sequential" isn't an index type.       │ │
│  │                                                        │ │
│  │  [Practice this topic →]                               │ │
│  └────────────────────────────────────────────────────────┘ │
│  ┌─── Security ───────────────────────────────────── 5 ───┐ │
│  ...                                                      │ │
└─────────────────────────────────────────────────────────────┘
```

### Q: How does it work?

```typescript
// Mistake tracking flow:
1. User answers a quiz question wrong
2. QuizService.submitAnswer() calls mistakeService.recordMistake()
3. Mistake is saved to the 'mistakes' table
4. User navigates to /mistakes to see all collected mistakes
5. Mistakes are grouped by topic, filterable by category
6. Each mistake shows: question text, your answer, correct answer, explanation
7. User can "Mark as Reviewed" → mistake is removed from list
8. Each mistake tracks: mistake_count, review_count, first_missed_at, last_missed_at
```

### Q: Why is this the most important feature?

**A:** The team briefing states: **"Exam prep IS about learning from mistakes."** Unlike a plain quiz app where a wrong answer is forgotten once the quiz ends, the Mistake Garden creates a persistent feedback loop:

```
Wrong answer → Saved to Mistake Garden → Review later → Learn → Don't make same error on real exam
```

**Use case:** A student gets 3 questions wrong during their Security quiz. Later that week, they open the Mistake Garden, filter by "Security," and review all 3 questions. They read the explanations, understand why they were wrong, and mark them as reviewed. On their next Security quiz, they get all 5 correct.

---

## 11. Weak Point Analysis

### Q: How does Weak Point Analysis work?

**A:** The system analyzes each user's answer history to identify **subtopics with the lowest mastery scores**, then recommends focused practice on those areas.

```
┌─────────────────────────────────────────────────────────────┐
│  ◎ Personalized from 142 answers                            │
│                                                              │
│  Turn weak points into your next wins.                      │
│                                                              │
│  Your learning radar finds the areas that deserve            │
│  attention first, so every practice session has a clear      │
│  purpose.                                                    │
│                                                              │
│  ┌─────────────────────────────────────────────┐            │
│  │ ⚡ Recommended next                         │            │
│  │                                             │            │
│  │ Cryptography                                │            │
│  │ 12 answers analyzed                         │            │
│  │                                             │            │
│  │ Current mastery: ██████░░░░ 35%             │            │
│  │                                             │            │
│  │ [Start focused practice →]                  │            │
│  └─────────────────────────────────────────────┘            │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ 🎯 Overall   📊 Avg Mastery    ⚡ Questions          │   │
│  │  42%            54%               142                 │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
│  [All topics] [Needs focus] [Developing] [Strong]           │
│                                                              │
│  #1  Cryptography          35%  ████░░░░  [Practice →]     │
│  #2  Network Security      42%  █████░░░  [Practice →]     │
│  #3  Algorithms            48%  █████░░░  [Practice →]     │
│  #4  Databases             55%  ██████░░  [Practice →]     │
│  ...                                                         │
└─────────────────────────────────────────────────────────────┘
```

### Q: How is mastery calculated?

```typescript
// user_subtopic_mastery table
interface MasteryRecord {
  user_id: string
  subtopic_id: string
  mastery_score: number    // 0.0000 - 1.0000 (0% - 100%)
  ability_score: number    // IRT-based ability estimate
  questions_seen: number
  questions_correct: number
  last_practiced_at: Date | null
}
```

**Use case:** A student has taken 10 quizzes across different topics. They open Weak Point Analysis and see that "Cryptography" has only 35% mastery. They click "Start focused practice," which takes them directly to a Cryptography quiz. After 3 more quizzes on Cryptography, the mastery score rises to 65%.

---

## 12. XP & Streak System

### Q: How does XP work?

| Action | XP Awarded | Notes |
|--------|-----------|-------|
| Correct quiz answer | 10 XP | Per correct answer in practice quizzes |
| Correct exam answer | 10 XP | Per correct answer in exam simulation |
| Complete a lesson | Configurable (varies by lesson) | Awarded via lesson completion endpoint |
| Streak milestone | Future feature | Not yet implemented |

```sql
-- XP is tracked in two tables:
-- user_stats: Running total (total_xp)
-- xp_events: Transaction log (idempotent per user + idempotency_key)

-- XP is awarded via the RPC function:
CREATE OR REPLACE FUNCTION increment_user_xp(p_user_id UUID, p_amount INT)
-- Updates total_xp in user_stats and logs a xp_event
```

### Q: How does the streak system work?

**A:** The streak tracks **consecutive daily login activity**:

```typescript
// Streak logic in UserService.updateUserStreak():
1. Get user's last_active_date from user_stats
2. Compare with today's date:
   - If last_active_date === today → no change (same day)
   - If last_active_date === yesterday → increment streak by 1
   - If last_active_date < yesterday → reset streak to 1
   - If last_active_date is null → set streak to 1
3. Award 50 XP if streak ≥ 7 days (stretch goal)
4. Update user_stats.current_streak
```

```
🔥 3-day streak    ⚡ 230 total XP

Visual indicators in the app:
- Header shows current streak with fire emoji
- Learning Map shows streak count
- Welcome message changes based on streak:
  "Your 3-day streak is glowing!"
  "Your 7-day streak is on fire!"
```

**Use case:** A student logs in every day for a week. Each day their streak increments: 1→2→3...→7. On day 8, they skip. When they return on day 9, their streak resets to 1. This motivates daily study habits.

---

## 13. User Profile

### Q: What does the user profile show?

**A:** The profile page at `/profile` is a comprehensive personal dashboard (46KB component) showing:

```
┌─────────────────────────────────────────────┐
│  📸 Avatar                   [Edit Profile] │
│  Alex                                        │
│  alex@email.com                              │
│  Member since July 2026                       │
├─────────────────────────────────────────────┤
│  ⚡ 230 XP           🔥 3-day streak        │
│  🏆 12 quizzes        📝 3 exams            │
│  ✅ 48 correct        ❌ 12 wrong            │
├─────────────────────────────────────────────┤
│  Recent Activity                             │
│  ┌──────────────────────────────────────┐   │
│  │ 📝 Exam Simulation         72%  Jul15│   │
│  │ 🎯 Cryptography Quiz       80%  Jul14│   │
│  │ 📚 Completed: Encryption   +10 XP    │   │
│  └──────────────────────────────────────┘   │
└─────────────────────────────────────────────┘
```

**Use case:** A student wants to see their overall progress. They visit their profile page, see they've earned 230 XP, have a 3-day streak, completed 12 quizzes and 3 exams, and review their recent activity.

---

## 14. Admin Dashboard

### Q: What does the Admin Dashboard show?

**A:** The admin dashboard is **role-gated** (admin only) and provides platform health monitoring:

```
┌─────────────────────────────────────────────────────────────┐
│  ⚡ NerdQuiz Admin                        [Users] [Stats]   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────┬──────┬──────┬──────┬─────────┬─────────┐        │
│  │ 142  │  38  │  89  │ 456  │  72%    │  58%   │        │
│  │Total │Active│Active│Quiz  │Avg Quiz │Exam Pass│        │
│  │Users │Today │Week  │Attempt│Score    │Rate     │        │
│  └──────┴──────┴──────┴──────┴─────────┴─────────┘        │
│                                                              │
│  📊 Daily Active Users (Last 30 days)                       │
│  40 ┤        ╭──╮                                           │
│  30 ┤  ╭──╮  │  ╰──╮  ╭──╮                                │
│  20 ┤  │  │  │     │  │  ╰──╮  ╭──╮                       │
│  10 ┤  ╰──╯  ╰─────╯  ╰─────╯  ╰──╯                       │
│      └──────────────────────────────────                    │
│         Jun 25  Jul 2   Jul 9   Jul 16   Jul 23            │
│                                                              │
│  📊 Topic Engagement                                        │
│  ┌──────────────────────────────────────────┐              │
│  │ Technology ████████████████ 42%          │              │
│  │ Security   ██████████░░░░ 28%            │              │
│  │ Management ██████░░░░░░ 18%              │              │
│  │ Strategy   ████░░░░░░░░ 8%               │              │
│  │ Business   ██░░░░░░░░░░ 4%               │              │
│  └──────────────────────────────────────────┘              │
│                                                              │
│  [Manage Users →]                                            │
└─────────────────────────────────────────────────────────────┘
```

### Q: What user management features are available?

```
User Management Page (/admin/users):

- Searchable table with columns: Name, Email, Role, Status, XP, Streak, Last Login
- Quick filters: Active Today, Inactive 30d+, New 7d
- Sorting by any column
- User detail drawer with tabs:
  ├── Overview (profile info, stats summary)
  ├── Activity (recent quiz/exam history)
  └── Performance (scores, mastery, weak points)
- Actions: Change role, Reset streak, Deactivate, CSV export
```

**Use case (founder):** Every morning, the founder opens the admin dashboard. They see 38 active users today, 89 this week. The topic engagement chart shows Technology and Security are the most popular topics. They drill into user management to see who signed up recently and check a few users' activity.

**Use case (support):** A user reports a bug. The admin searches for the user by email, opens their detail drawer, sees their recent activity, and can deactivate the account if needed.

---

## 15. API Endpoints

### Q: What are all the backend API endpoints?

```yaml
Health:
  GET  /api/v1/health                    # Health check (public)

Topics:
  GET  /api/v1/topics                    # List topics with user progress

Lessons:
  GET  /api/v1/subtopics/{id}/lessons    # Get lessons for a subtopic
  POST /api/v1/lessons/{id}/complete     # Mark lesson complete

Quizzes:
  GET  /api/v1/subtopics/{id}/quiz       # Get quiz questions for subtopic
  POST /api/v1/quizzes/start             # Start a quiz session
  POST /api/v1/quizzes/{id}/answers      # Submit answer
  GET  /api/v1/quizzes/{id}/result       # Get quiz result

Exams:
  POST /api/v1/exams/start               # Start exam simulation
  POST /api/v1/exams/{id}/answers        # Submit exam answer
  POST /api/v1/exams/{id}/finish         # Finish/complete exam
  GET  /api/v1/exams/{id}/result         # Get exam result

User Profile:
  POST /api/v1/me/profile                # Create or update profile
  PUT  /api/v1/me/profile                # Update profile fields
  POST /api/v1/me/streak                 # Update login streak
  GET  /api/v1/me/mistakes               # List user mistakes
  PUT  /api/v1/me/mistakes/{id}/review   # Mark mistake as reviewed
  GET  /api/v1/me/weak-points            # Weak point analysis

Admin:
  GET  /api/v1/admin/stats               # Platform statistics
  GET  /api/v1/admin/users               # List all users (paginated)
  GET  /api/v1/admin/users/{id}          # User detail
  PUT  /api/v1/admin/users/{id}/role     # Change user role
  POST /api/v1/admin/users/{id}/deactivate    # Deactivate user
  POST /api/v1/admin/users/{id}/reset-streak  # Reset streak
```

### Q: How are errors returned?

```json
// RFC 7807 Problem Details format
// 404 Example:
{
  "type": "about:blank",
  "title": "Not Found",
  "status": 404,
  "detail": "Quiz session not found"
}

// 400 Example:
{
  "type": "about:blank",
  "title": "Bad Request",
  "status": 400,
  "detail": "Exam session has expired"
}
```

---

## 16. Security & RLS

### Q: What Row Level Security policies are in place?

```sql
-- Public content (anyone can read)
topics, subtopics, lessons, questions, exams, flashcards
  → SELECT for published content only

-- User-owned data (users can only see their own)
profiles, user_stats, xp_events, user_daily_activity,
user_subtopic_mastery, user_lesson_progress,
quiz_sessions, exam_sessions
  → auth.uid() = user_id

-- Session-scoped data (users can only see through their own sessions)
quiz_answers, exam_answers, quiz_session_questions,
exam_session_questions
  → EXISTS (SELECT 1 FROM sessions WHERE id = session_id AND user_id = auth.uid())

-- Mistakes
mistakes
  → auth.uid() = user_id
```

### Q: What additional security layers exist beyond RLS?

**A:** The backend has three security utility classes in `src/api/.../security/`:

```java
// 1. RateLimitFilter — In-memory rate limiting (100 requests/min per IP)
// Prevents abuse of API endpoints
public class RateLimitFilter extends OncePerRequestFilter {
    private final Map<String, RateLimitBucket> buckets = ...;
    // Returns 429 Too Many Requests if limit exceeded
}

// 2. InputSanitizer — Sanitizes user input to prevent XSS
public class InputSanitizer {
    // Strips HTML tags, prevents script injection
    // Used on display_name and other user-provided text
}

// 3. SecurityHeadersConfig — HTTP security headers
// X-Content-Type-Options: nosniff
// X-Frame-Options: DENY
// Content-Security-Policy: restricted
// Strict-Transport-Security: max-age=31536000
```

### Q: What are the key security rules?

```
Rule                        Enforcement
──────────────────────────────────────────────────
No passwords in backend     Supabase Auth handles all credentials
JWT verification            Every API request via JwtAuthenticationFilter
User ID from JWT            Never trust client-supplied userId
No PII in logs              Emails, JWTs, passwords never logged
CORS restricted             Only frontend origin allowed
Input validation            Jakarta @Valid on all request DTOs
Error messages              No stack traces or SQL errors leaked
Service role key            Backend only, never in frontend
Rate limiting               100 req/min per IP (RateLimitFilter)
XSS prevention             InputSanitizer on user-provided text
Security headers            HSTS, CSP, X-Frame-Options via SecurityHeadersConfig
```

### Q: Are there any known security deviations?

**A:** Yes. Some frontend components query Supabase directly (skipping the backend JWT filter):

| Component | Direct Supabase Access | Risk |
|-----------|----------------------|------|
| `LessonPage` | Reads `lessons` + `subtopics` directly | RLS-only protection |
| `useAuth` | Reads/writes `user_profiles` directly | RLS-only protection |
| `QuizPage` | Inserts into `user_mistakes`, calls RPCs | RLS-only protection |

These are known deviations from the intended architecture. The backend path (`React → Spring Boot → Postgres`) is preferred because it includes JWT verification + business logic. Direct Supabase calls rely solely on RLS policies.

---

## 17. Data Extraction Pipeline

### Q: How are exam questions extracted from PDFs?

**A:** The extraction pipeline is documented in `.claude/skills/extract-data/`:

```
ITPEC ZIP Archive (PDFs)
        ↓
  PyMuPDF (pdfplumber) text extraction
        ↓
  AI-assisted parsing (Claude/GPT) → JSON structure
        ↓
  Human review & verification
        ↓
  SQL seed statements
        ↓
  Database import via Supabase migration
```

### Q: What question metadata is captured?

```json
{
  "exam_session": "2021-April",
  "subject": "A",
  "question_number": 17,
  "difficulty": "medium",
  "topic_category": "Technology",
  "question_text": "Which of the following is...",
  "choices": [
    { "label": "a", "text": "..." },
    { "label": "b", "text": "..." },
    { "label": "c", "text": "..." },
    { "label": "d", "text": "..." }
  ],
  "correct_answer": "c",
  "explanation": "The correct answer is C because...",
  "images": [{ "url": "/images/2021-april-17.webp", "alt": "Diagram showing..." }],
  "source_file": "FE202104_AM_Q.pdf",
  "source_pages": [12]
}
```

### Q: How many questions are currently seeded?

**Scope for the demo:**
- **3 exam sessions** (2021-April, 2021-October, 2022-April)
- **Subject-A only** (60 questions per exam = ~180 questions)
- **Business questions** (additional seed data)
- Difficulty auto-assigned via database trigger `assign_question_difficulty()`

---

## 18. Deployment & CI/CD

### Q: How is the application deployed?

```
Frontend (Netlify):
  - Static SPA hosting with CDN
  - SPA routing fallback (netlify.toml)
  - Build: npm run build → publishes to CDN

Backend (Docker → Cloud Run / Render):
  - Multi-stage Dockerfile (Gradle build → JRE 25 runtime)
  - docker-compose.yml for local development
  - GitHub Actions CI/CD

Database (Supabase):
  - Managed PostgreSQL
  - Migrations via supabase db push
  - Session pooler for IPv4 environments
```

### Q: What CI checks run on every PR?

```yaml
CI Pipeline (.github/workflows/ci.yml):
  1. Lint (ESLint / OxLint)        # Frontend code quality
  2. Typecheck (tsc)                # TypeScript compilation
  3. Test (Vitest + JUnit)          # Unit + integration tests
  4. Build (npm build + ./gradlew)  # Production build verification

Security Pipeline (.github/workflows/security.yml):
  1. gitleaks                       # Leaked secrets detection
  2. semgrep                        # SAST (Static Application Security Testing)

Dependabot (.github/dependabot.yml):
  - Weekly dependency vulnerability scan
  - Auto-PRs for patches
```

### Q: How do you run the project locally?

```bash
# 1. Start local database (requires Docker)
supabase start
supabase db reset

# 2. Start backend (Spring Boot on :8080)
cd src/api
./gradlew bootRun

# 3. Start frontend (Vite on :5100)
cd src/web
npm install
npm run dev

# Open http://localhost:5100
```

---

## 19. Frontend Architecture

### Q: How is the frontend structured?

```
src/web/src/
├── main.tsx                         # Entry point
├── App.tsx                          # Route definitions + AuthProvider
├── lib/
│   ├── supabase.ts                  # Supabase client singleton
│   └── api.ts                       # Centralized API client (fetch)
├── hooks/
│   ├── useAuth.tsx                  # Auth state, sign in/up/out
│   ├── useTopics.ts                 # Topic listing
│   ├── useLessons.ts                # Lesson fetching
│   ├── useExamSimulation.ts         # Exam session management
│   ├── useWeakPoints.ts             # Weak point data
│   ├── useTheme.tsx                 # Dark mode toggle
│   ├── useAdminStats.ts             # Admin dashboard stats
│   ├── useAdminUsers.ts             # Admin user management
│   ├── useAdminUserDetail.ts        # Admin user detail
│   ├── use-mobile.tsx               # Mobile detection
│   └── useFocusTrap.ts             # Accessibility focus trapping
├── components/
│   ├── layout/                      # Layout, Header, Sidebar
│   ├── ui/                          # Button, Card, Badge, Modal, etc.
│   └── features/                    # Feature-specific components
│       ├── exam/                    # ExamStartScreen, ExamTimer, etc.
│       ├── weak-points/             # WeakPointCard, WeakPointSummary
│       └── TopicNode.tsx, QuizCard.tsx, etc.
├── routes/                          # One file per route/page
├── types/                           # TypeScript interfaces
└── styles/
    └── globals.css                  # Tailwind directives
```

### Q: What UI components are available?

```typescript
// Generic UI components (src/web/src/components/ui/):
Button        - Primary, secondary, ghost, outline, danger variants
Card          - Contained panels with optional padding
Badge         - Status labels (success, error, warning, info)
Modal         - Overlay dialogs
Skeleton      - Loading placeholder
Toggle        - On/off switches
Spinner       - Loading indicator
ProgressBar   - Horizontal progress indicator

// Layout components:
Layout        - Header + Sidebar + main content area
Header        - Logo, navigation, XP/streak display, dark mode toggle
Sidebar       - Navigation links (map, quizzes, exam, mistakes, profile)

// Feature components:
TopicNode     - Single topic in the learning map tree
WeakPointCard - Topic-level weak point display
WeakPointSummary - Aggregate stats cards
ExamStartScreen   - Exam configuration (difficulty selector)
ExamQuestionCard  - Question display with choices
ExamTimer         - Countdown timer display
ExamProgressBar   - Question navigation grid
ExamResultScreen  - Score and answer review
```

### Q: What React Router routes are defined?

```typescript
// Route structure in App.tsx
/              → LandingPage    (public, no layout)
/login         → LoginPage      (public, no layout)
/register      → RegisterPage   (public, no layout)
/ai-draft      → AiDraftPreview (admin only)

/map           → LearningMap    (student, sidebar)
/map/:topicId  → TopicDetail    (student, sidebar)
/lesson/:lessonId → LessonPage  (student, sidebar)
/quiz/:subtopicId → QuizPage    (student, sidebar)
/quiz-result/:sessionId → QuizResult (student, sidebar)
/mistakes      → MistakeGarden  (student, sidebar)
/exam          → ExamSimulation (student, full screen)
/profile       → UserProfile    (auth, sidebar)
/weak-points   → WeakPointAnalysis (auth, sidebar)

/admin         → AdminDashboard (admin, sidebar)
/admin/users   → AdminUsers     (admin, sidebar)
```

---

## 20. Backend Architecture

### Q: How is the backend structured?

```
src/api/src/main/java/com/nerdquiz/
├── NerdQuizApplication.java        # Entry point
├── config/
│   ├── SecurityConfig.java         # Spring Security filter chain
│   ├── CorsConfig.java             # CORS configuration
│   ├── JwtAuthenticationFilter.java# JWT verification filter
│   └── JwtUtil.java                # JWKS loading + token parsing
├── controller/
│   ├── HealthController.java       # GET /api/v1/health
│   ├── TopicController.java        # Topic endpoints
│   ├── LessonController.java       # Lesson endpoints
│   ├── LessonProgressController.java # Lesson completion
│   ├── QuizController.java         # Quiz CRUD
│   ├── ExamController.java         # Exam simulation
│   ├── MistakeController.java      # Mistake management
│   ├── UserController.java         # User streak, profile
│   ├── UserProfileController.java  # Profile CRUD
│   ├── UserMistakeController.java  # User-specific mistakes
│   ├── QuestionController.java     # Question queries
│   ├── WeakPointController.java    # Weak point analysis
│   └── AdminController.java        # Admin endpoints
├── service/
│   ├── QuizService.java            # Quiz business logic
│   ├── ExamService.java            # Exam business logic
│   ├── TopicService.java           # Topic + progress computation
│   ├── LessonService.java          # Lesson queries
│   ├── LessonProgressService.java  # Lesson completion logic
│   ├── QuestionService.java        # Question query helpers
│   ├── MistakeService.java         # Mistake recording + review
│   ├── UserService.java            # XP, streak management
│   ├── UserProfileService.java     # Profile management
│   ├── UserDailyActivityService.java # Activity tracking
│   ├── WeakPointService.java       # Mastery scoring
│   └── AdminService.java           # Admin stats (JdbcTemplate)
├── repository/                     # Spring Data JPA repositories
├── model/                          # JPA entities
├── dto/                            # Request/Response records
└── exception/                      # GlobalExceptionHandler + custom exceptions
```

### Q: How are services structured?

```java
// Each service follows the pattern:
@Service
public class XxxService {
    // 1. Constants at the top
    private static final int SOME_LIMIT = 5;

    // 2. Constructor injection (no @Autowired on fields)
    private final XxxRepository repository;
    private final YyyService dependency;
    public XxxService(XxxRepository repo, YyyService dep) { ... }

    // 3. Transactional public methods
    @Transactional
    public ResponseType doSomething(UserId, RequestType request) {
        // Validate
        // Execute business logic
        // Return response DTO
    }

    // 4. Private helper methods
    private void validateSomething(...) { ... }
}
```

---

## Practical Use Cases Summary

### New Student Journey

```
1. Alex visits NerdQuiz.com               → Landing Page
2. Clicks "Start learning free"            → Registration
3. Signs up with email + password           → Supabase Auth
4. Sees welcome + learning map              → Learning Map
5. Clicks "Technology" topic                → Topic Detail
6. Reads "Computer Architecture" lesson     → Lesson Page
7. Takes 5-question quiz                    → Quiz Page
8. Gets 4/5 correct, earns 40 XP           → Quiz Result
9. Reviews the 1 wrong answer               → Mistake Garden
10. Checks profile: 40 XP, 1 streak day    → User Profile
```

### Exam Prep Journey

```
1. Completes all Technology lessons/quizzes → Topic: Completed
2. Studies Security → Management → Strategy → Business
3. Reviews all wrong answers                → Mistake Garden
4. Checks weak areas: Cryptography (35%)    → Weak Point Analysis
5. Takes focused Cryptography quiz          → Quiz Practice
6. Feels ready, starts exam simulation      → Exam Simulation
7. Answers 60 questions in 50 minutes       → Submits Early
8. Scores 72% (pass), earns 430 XP         → Exam Result
9. Reviews every wrong answer               → Answer Review
```

### Admin Use Case

```
1. Admin logs in → auto-routed to dashboard  → /admin
2. Sees: 142 users, 38 active today          → Stats Cards
3. Checks daily active users chart           → Line Chart
4. Sees Technology is most engaged topic      → Bar Chart
5. Clicks "Manage Users"                     → /admin/users
6. Searches for a specific user              → Search
7. Opens user detail drawer                  → Detail View
8. Sees user has 0 XP, no activity in 7 days → Reset streak
9. Optionally deactivates the account        → Deactivate
10. Exports user list as CSV                 → CSV Export
```

---

> *Last updated: July 2026*
> *Generated for NerdQuiz — a gamified IT exam prep platform for ITPEC FE certification*
