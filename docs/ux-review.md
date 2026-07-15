# UX Review — NerdQuiz

**Reviewed:** Full frontend codebase (React + Tailwind)  
**Date:** 2026-07-15  
**Audience:** Product and engineering team

---

## 1. What Works Well

**The Learning Map is a strong central hub.** The welcome hero greets the learner by name, shows their streak and XP, and — critically — surfaces a "Continue" button that points to the next topic they should work on. A student returning for day two of studying doesn't have to think about where to go. The progress bar, the motivational messages that change based on streak and completion, the category-grouped roadmap with locked/unlocked states — all of this gives the student a clear sense of "here's where you are, here's what's next." This is the best screen in the app.

**The quiz flow is clean and focused.** Five questions, one at a time, with a progress bar at the top. Select an answer, tap "Check," see instant feedback with an explanation. The color coding (green for correct, red for incorrect, purple for selected) is intuitive. The XP earned on the results screen closes the loop with a reward. No clutter, no distractions — just practice.

**The lesson reader respects the learner's time.** Short, structured content blocks with clear visual hierarchy — headings, text, tips in blue, warnings in amber, examples in green. The "Mark as Complete" button at the bottom is the only action, and it earns XP. There's no ambiguity about what to do after reading.

**The exam simulation captures the pressure of real test day.** The countdown timer, the heart system (three hearts, lose one per wrong answer), and the 60-question format mirror the actual ITPEC FE exam. The difficulty selector before starting lets students customize their practice. The sticky header during the exam keeps critical information (time, hearts, question count) visible without scrolling.

**Auth flow handles edge cases gracefully.** The registration form checks for existing emails before submitting. The login form gives a specific hint for Google OAuth users who try password login. The error messages are human-readable, not technical.

---

## 2. The Core Tension

The Learning Map knows exactly what the student should do next — it calculates the next topic, shows progress, and offers a "Continue" button. But every other screen in the app sends the student back to a generic hub and makes them figure out their next step themselves. The app has a conveyor belt at the entrance and a filing cabinet everywhere else.

After completing a lesson, the student sees "Back to Topic." After finishing a quiz, "Back to Map." After an exam, "Back to Map" or "Try Again." After reviewing a mistake, the mistake just disappears from the list. At every moment of completion — the moment when the student is most motivated to keep going — the app drops them off and walks away.

---

## 3. The User's Day

### Scenario: A returning student (day 3 of studying)

**Today:**

The student logs in and lands on the Learning Map. Good — the "Continue" button points to "Network Security Basics," their next unfinished topic. They tap it. They're on the Topic Detail page, which shows a list of lessons (some locked, some completed) and a prominent purple quiz button.

They tap the first unlocked lesson. It opens in-line on the same page — a short reading with a "Mark as Complete" button. They read it, tap the button. Now they're back on the lesson list. The lesson they just completed has a green checkmark. The next lesson is now unlocked.

They tap the next lesson. Read it. Mark complete. Back to the list.

After finishing all lessons, they tap the purple quiz button. Five questions, instant feedback. They get 3/5. The results screen shows "+30 XP" and a "Back to Map" button. They tap it. They're back on the Learning Map.

Now what? The map shows the topic is "in progress" (they completed lessons but didn't ace the quiz). The "Continue" button still points to the same topic. They tap it again, see the lesson list again, and have to figure out that they should retake the quiz. There's no signal saying "you got 3/5 on the quiz — try again to improve" or "you've completed all lessons, now retake the quiz to clear this topic."

**Friction count:** 8 taps from login to productive study. Two unnecessary round-trips to the Learning Map. One moment of confusion about what to do after a partial quiz result.

**What it should feel like:**

The student logs in and taps "Continue Network Security Basics." They land on the Topic Detail page. After completing the last lesson, the app notices they've finished all lessons and automatically surfaces: "You've finished all lessons! Ready for the quiz?" — or, if they've already attempted the quiz, "You scored 3/5 last time. Try again?"

After finishing the quiz with 5/5, the results screen says "Topic cleared! 🎉" with a button that says "Next: Security Protocols →" pointing to the next topic. The student never visits the Learning Map unless they want to browse. The app carries them forward.

**The gap:** The app calculates the next topic but only surfaces it on the Learning Map. It knows quiz scores but doesn't use them to guide the student's next action on the Topic Detail page. After quiz completion, "Back to Map" is a dead end when the student should be propelled forward.

### Scenario: A student reviewing mistakes

**Today:**

The student taps "Mistakes" in the sidebar. They see a list of wrong answers — question text, their answer, the correct answer, and an explanation. Each card has a "Mark as Reviewed" button. They tap it. The mistake disappears from the list.

After reviewing five mistakes, the list is shorter. But there's no connection between what they just reviewed and what they should practice next. They reviewed three networking mistakes and two security mistakes — but the app doesn't say "you keep missing networking questions, try the networking quiz."

**What it should feel like:**

The student opens the Mistake Garden and sees not just a list of wrong answers, but a pattern: "You've missed 4 questions about subnetting. Here's a focused 5-question quiz on that topic." The review becomes a bridge to practice, not a dead-end list.

**The gap:** The Mistake Garden is a filing cabinet of past errors. It should be a launchpad for improvement.

### Scenario: A student checking their weak areas

**Today:**

The student taps "Weak Points" in the sidebar. They see a summary of topics and subtopics with accuracy percentages, sorted weakest-first. It's informative — "Firewall: 20%, Encryption: 33%, Access Control: 40%."

But there's no action. The weak points page says "you're bad at firewalls" without saying "here's a quiz on firewalls." The student has to mentally map "firewall" to a topic, navigate to the Learning Map, find the topic, and start a quiz. That's four screens of navigation for something the app could do in one tap.

**What it should feel like:**

The weak point card for "Firewall" has a "Practice Now →" button that starts a quiz filtered to firewall questions. The analysis and the action are on the same screen.

**The gap:** The app has the data to connect analysis to action but presents them as separate, disconnected screens.

---

## 4. What to Cut

### "Back to Map" as the primary post-completion action

Every results screen — quiz completion, exam completion, lesson completion — ends with "Back to Map" as the primary button. This is a backward-pointing action on a screen that should be forward-pointing. The student just accomplished something; the app should show them what they earned and where to go next, not send them to a hub to start over.

**Replace with:** A forward-pointing CTA that matches context. After a quiz: "Next Topic →" or "Retake Quiz." After an exam: "Review Mistakes" or "Practice Weak Areas." After a lesson: auto-advance to the next lesson or the topic's quiz.

### Duplicate quiz entry points

Quizzes can be started from two completely different places: the Topic Detail page (inside a topic) and the Quiz Listing page (via the sidebar "Quiz" link). Both lead to the same quiz interface, but the Quiz Listing page strips away context — it shows topics grouped by category with question counts, but no indication of which quizzes the student has already attempted or how they scored.

**Demote the Quiz Listing page.** Keep it as an advanced option (maybe under Profile or as a secondary link), but make the primary quiz path through the Topic Detail page, where the student has context about what they're practicing and why. The sidebar should guide toward the next action, not present a parallel entry point.

### AI Draft Preview at `/ai-draft` (public, unauthenticated)

This is a developer tool for reviewing AI-extracted questions. It's accessible to anyone without authentication. It should either require auth or be removed from the production frontend entirely. It doesn't belong in a student-facing application.

---

## 5. What's Missing

### Forward paths after completion

**What the user would see:** After finishing a quiz, instead of just "Quiz complete! 3/5. +30 XP. Back to Map," the screen shows "Quiz complete! 3/5. +30 XP. You're close — try again to clear this topic?" or "Perfect score! Next topic: Security Protocols →"

**Why it matters:** This is the single highest-impact improvement. Every completion moment is a motivational peak. Sending the student backward at that peak wastes momentum. Carrying them forward turns a study session into a streak.

**Impact:** Transforms the daily study flow from fragmented hub-spoke navigation to a continuous learning path.

### Resume interrupted exams

**What the user would see:** If a student starts an exam, closes their browser, and comes back, the app detects the in-progress session and asks "You have an exam in progress. Resume?"

**Why it matters:** Exam simulation is a 60-minute commitment. Students get interrupted — by life, by battery death, by Wi-Fi drops. Losing 20 minutes of progress because the browser closed is deeply frustrating.

**Impact:** Prevents the most demotivating failure mode in the app.

### Targeted practice from weak points

**What the user would see:** Each weak point card has a "Practice 5 questions" button that starts a quiz filtered to that specific subtopic.

**Why it matters:** The weak point analysis is only useful if it leads to action. Right now it's a report card with no study plan.

**Impact:** Connects the app's analytics capability to its core learning loop.

### Mistake patterns and trending

**What the user would see:** The Mistake Garden groups mistakes by topic or subtopic, shows "You've made 5 mistakes in Networking this week," and highlights trending patterns.

**Why it matters:** A flat list of mistakes doesn't help the student see their growth areas. Grouping by topic transforms a list of errors into a study plan.

**Impact:** Turns the Mistake Garden from a graveyard of wrong answers into a diagnostic tool.

### Search and filter in Mistake Garden

**What the user would see:** A search bar and category filters on the Mistake Garden page. "Show me only Security mistakes" or search for "firewall."

**Why it matters:** As the mistake list grows (which means the app is working — students are practicing and making mistakes), finding specific mistakes becomes tedious. A student preparing for an exam wants to focus on a specific category.

**Impact:** Essential for the app to scale beyond the first few weeks of use.

### Difficulty selection for topic quizzes

**What the user would see:** Before starting a 5-question quiz on a topic, the student can choose easy, medium, or hard — just like the exam simulation already allows.

**Why it matters:** The exam simulation already offers difficulty selection, but the topic quizzes don't. A student who finds a topic easy shouldn't waste time on easy questions. A student who's struggling should be able to start with easier questions and build confidence.

**Impact:** Makes the topic quiz more adaptable to different skill levels.

---

## 6. Priorities

Ranked by impact on the student's daily study experience:

1. **Forward paths after completion** — Replace every "Back to Map" with a context-aware next step. This touches quiz results, exam results, and lesson completion. It's the highest-leverage change because it affects every study session.

2. **Connect weak points to action** — Add "Practice" buttons on weak point cards. This turns analytics into learning, which is the whole point of the app.

3. **Targeted practice from mistakes** — Group mistakes by topic and add quiz shortcuts. This makes the Mistake Garden actionable instead of archival.

4. **Resume interrupted exams** — Persist exam session state so students don't lose progress. This prevents the worst frustration in the app.

5. **Demote the Quiz Listing page** — Make the Topic Detail page the primary quiz entry point. Reduce navigation ambiguity.

6. **Add search/filter to Mistake Garden** — Essential for scale, lower priority than the structural changes above.

7. **Difficulty selection for topic quizzes** — Nice to have for adaptive learning, but the existing flow works.

8. **Remove or protect AI Draft Preview** — Security hygiene, quick fix.

---

*This review was produced by reading every component, route, hook, and type in the frontend codebase. All recommendations reference specific user experiences, not code structure.*
