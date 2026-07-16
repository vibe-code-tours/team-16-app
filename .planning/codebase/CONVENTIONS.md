# Coding Conventions

**Analysis Date:** 2026-07-14

## Naming Patterns

**Backend Files (Java):**
- Controllers: PascalCase with `Controller` suffix - `QuizController.java`, `QuestionController.java`
- Services: PascalCase with `Service` suffix - `QuizService.java`, `QuestionService.java`
- Repositories: PascalCase with `Repository` suffix - `QuizSessionRepository.java`, `QuestionRepository.java`
- DTOs (Request): PascalCase with `Request` suffix - `StartQuizRequest.java`, `SubmitAnswerRequest.java`
- DTOs (Response): PascalCase with `Response` suffix - `QuizSessionResponse.java`, `QuizAnswerResponse.java`
- Exceptions: PascalCase with `Exception` suffix - `NoQuestionsAvailableException.java`, `QuizSessionNotFoundException.java`
- Entities: PascalCase, no suffix - `QuizSession.java`, `Question.java`, `QuizAnswer.java`
- Packages: lowercase singular - `com.nerdquiz.service`, `com.nerdquiz.model`, `com.nerdquiz.controller`

**Frontend Files (TypeScript/React):**
- Components: PascalCase + `.tsx` - `ProgressBar.tsx`, `ChoiceList.tsx`, `Button.tsx`
- Hooks: `use` + PascalCase + `.ts` - `useAuth.tsx`, `useTopics.ts`, `useLessons.ts`
- Utility functions: camelCase + `.ts` - `formatXp.ts`, `cn.ts`
- Type definitions: PascalCase + `.ts` - `Quiz.ts`, `types/index.ts`
- Routes: PascalCase + `.tsx` - `QuizSession.tsx`, `LearningMap.tsx`

**Functions & Variables (Java):**
- Methods: camelCase - `startQuiz()`, `submitAnswer()`, `getResult()`
- Variables: camelCase - `questionRepository`, `quizSession`, `isCorrect`
- Constants: UPPER_SNAKE_CASE - `XP_PER_CORRECT_ANSWER`, `BEARER_PREFIX`

**Functions & Variables (React):**
- Event handlers: `handle` + Action - `handleSelectAnswer()`, `handleSubmitAnswer()`, `handleNextQuestion()`
- State: descriptive noun - `questions`, `currentIndex`, `answers`, `showExplanation`
- State setters: `set` + Noun - `setQuestions()`, `setCurrentIndex()`, `setAnswers()`
- Props interfaces: `<Component>Props` - `ProgressBarProps`, `ChoiceListProps`, `AnswerState`

## Code Style

**Formatting:**
- Backend: Java standard formatting (4-space indentation)
- Frontend: ESLint + Prettier (standard Vite config)
- Tailwind: Utility-first classes, responsive mobile-first approach
- CSS organization: Tailwind config in `tailwind.config.js` for custom tokens

**Linting:**
- Backend: Spring Boot conventions (standard Java practices)
- Frontend: TypeScript strict mode with ESLint
- No custom ESLint config files found (standard Vite setup)

## Import Organization

**Backend (Java):**
1. `com.nerdquiz.*` - internal classes
2. `org.springframework.*` - Spring framework
3. `java.*` - standard library
4. Group by package, no blank lines between same-package imports

**Frontend (TypeScript/React):**
1. React/React Router imports
2. Supabase SDK imports
3. Component imports (UI then features)
4. Hook imports
5. Utility imports
6. Type imports (with `type` keyword)
7. Relative path imports from `../` or `./`

Example pattern from `QuizSession.tsx`:
```typescript
import { useState, useCallback, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { QuestionBlock } from '../components/features/QuestionBlock';
import { ChoiceList } from '../components/features/ChoiceList';
import { Button } from '../components/ui/Button';
import { Card } from '../components/ui/Card';
import type { Question, QuizResult } from '../types/Quiz';
```

## Error Handling

**Backend Patterns:**
- Service layer: Throw specific custom exceptions (`NoQuestionsAvailableException`, `QuizSessionNotFoundException`)
- Controller layer: Let exceptions propagate to `GlobalExceptionHandler`
- Exception handler: Returns RFC 7807 Problem Details format with status code, title, detail
- Example response: `{ "type": "...", "title": "...", "status": 404, "detail": "..." }`

```java
// Service layer - throw specific exception
if (questions.isEmpty()) {
    throw new NoQuestionsAvailableException();
}

// Controller layer - propagate naturally
QuizSessionResponse startQuiz(...) {
    UUID userId = UUID.fromString(authentication.getName());
    return ResponseEntity.ok(quizService.startQuiz(userId, request));
}

// GlobalExceptionHandler - handle all exceptions
@ExceptionHandler(NoQuestionsAvailableException.class)
public ResponseEntity<Map<String, Object>> handleNoQuestionsAvailable(NoQuestionsAvailableException ex) {
    return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of(
        "type", "https://nerdquiz.com/errors/not-found",
        "title", "No Questions Available",
        "status", 404,
        "detail", ex.getMessage()
    ));
}
```

**Frontend Patterns:**
- Components: Render conditional UI based on state (loading, error, success)
- Hooks: Use try/catch with console.error for non-critical operations
- API calls: Return error objects instead of throwing: `{ error: message }`
- Example from `useAuth.tsx`:
```typescript
try {
  const { data, error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) {
    return { error: error.message };
  }
  return { error: null };
} catch (err) {
  console.error('Unexpected error:', err);
  return { error: 'An unexpected error occurred' };
}
```

## Logging

**Framework:** SLF4J (backend), console (frontend)

**Backend Patterns:**
- Debug level for routine operations (JWT verification)
- Info level for significant events
- Use `LoggerFactory.getLogger(ClassName.class)`
- Never log PII (emails, user IDs, tokens)

```java
private static final Logger log = LoggerFactory.getLogger(JwtAuthenticationFilter.class);
log.debug("JWT verification failed: {}", e.getMessage());
```

**Frontend Patterns:**
- `console.error()` for actual errors
- `console.warn()` for deprecation notices or non-critical warnings
- No `console.log()` in production code

## Comments

**When to Comment:**
- Javadoc for public API methods (controllers, services)
- Inline comments for complex business logic
- No comments for obvious code

**JSDoc/TSDoc:**
- Backend: Javadoc style on service/controller classes
- Frontend: Not consistently used (rely on TypeScript types)
- Example:
```java
/**
 * JWT authentication filter that intercepts every request,
 * verifies the Supabase JWT, and sets the SecurityContext.
 */
```

## Function Design

**Size:**
- Methods: Under 30 lines preferred (flag over 30 lines)
- Components: Under 200 lines (flag and extract sub-components)

**Parameters:**
- Backend: Maximum 3-4 parameters; use Request/Response DTOs for more
- Frontend: Maximum 5-6 props; use Props interfaces for more
- Prefer composition over parameter lists

**Return Values:**
- Backend: Return DTOs, not entities; use ResponseEntity for status control
- Frontend: Return typed arrays/objects from hooks; return error objects for operations

**Early Returns:**
- Use guard clauses instead of deep nesting
- Example from `JwtAuthenticationFilter`:
```java
if (authHeader == null || !authHeader.startsWith(BEARER_PREFIX)) {
    filterChain.doFilter(request, response);
    return;
}
```

## Module Design

**Backend:**
- Controllers: Thin (validate input, call service, return DTO)
- Services: Business logic only (no HTTP concerns)
- Repositories: Data access with Spring Data JPA
- DTOs: Records for request/response (immutable, type-safe)

**Frontend:**
- Route components: Fetch data, render pages
- UI components: Pure rendering logic
- Feature components: Interactive logic
- Hooks: Stateful logic and side effects
- Types: Centralized type definitions in `types/` directory

**Barrel Files:**
- `types/index.ts` - Exports shared types
- No other barrel files (components imported directly)

## Validation

**Backend:**
- Jakarta Validation annotations on Request DTOs (`@Min`, `@Max`, `@Valid`)
- `@Valid` on controller parameters to trigger validation
- Validation errors caught by `GlobalExceptionHandler`

```java
public record StartQuizRequest(
    UUID subtopicId,
    @Min(1) @Max(10) Integer questionCount
) {}
```

**Frontend:**
- TypeScript types for compile-time validation
- No runtime validation library (rely on backend validation)
- Optional chaining for nullable props

## Testing Conventions

**Backend Tests:**
- Unit: `*Test.java` in same package as source (mirrors main structure)
- Integration: Separate `*IntegrationTest.java` files
- Controller: `@WebMvcTest` with MockMvc
- Service: JUnit 5 + Mockito

**Frontend Tests:**
- Component tests: `*.test.tsx` co-located with components
- Hook tests: `*.test.ts` co-located with hooks
- Framework: Vitest + React Testing Library + jsdom
- Setup: `src/test-setup.ts` with jest-dom matchers

**Test Naming:**
- Backend: `methodName_Scenario_ExpectedResult` (e.g., `startQuiz_CreatesSession`)
- Frontend: Descriptive phrases (e.g., "renders all choices", "calls onClick when clicked")

---

*Convention analysis: 2026-07-14*
