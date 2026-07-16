# Testing Patterns

**Analysis Date:** 2026-07-14

## Test Framework

**Runner:**
- Backend: JUnit 5 (Spring Boot Test)
- Frontend: Vitest 4.1.10
- Config: `src/web/vitest.config.ts`

**Assertion Library:**
- Backend: JUnit assertions (`assertEquals`, `assertTrue`, `assertNotNull`)
- Frontend: Vitest assertions (`expect` with jest-dom matchers)

**Run Commands:**
```bash
cd src/api && ./gradlew test                    # Backend tests
cd src/web && npm run test                      # Frontend tests
cd src/web && npm run test -- --watch          # Frontend watch mode
```

## Test File Organization

**Backend:**
- Location: `src/api/src/test/java/com/nerdquiz/` (mirrors main structure)
- Naming: `<ClassName>Test.java` for unit tests
- Structure:
  ```
  src/api/src/test/java/com/nerdquiz/
  ├── controller/
  │   ├── QuestionControllerTest.java
  │   └── UserControllerTest.java
  └── service/
      ├── QuestionServiceTest.java
      └── QuizServiceTest.java
  ```

**Frontend:**
- Location: Co-located with components (`*.test.tsx`)
- Naming: `<ComponentName>.test.tsx`
- Structure:
  ```
  src/web/src/components/
  ├── ui/
  │   └── Button.test.tsx
  └── features/
      ├── ChoiceList.test.tsx
      ├── ExplanationBox.test.tsx
      ├── ProgressBar.test.tsx
      └── QuestionBlock.test.tsx
  ```

## Test Structure

**Backend (JUnit 5 + Mockito):**
```java
@ExtendWith(MockitoExtension.class)
class QuizServiceTest {

    @Mock
    private QuestionRepository questionRepository;

    @Mock
    private QuizSessionRepository quizSessionRepository;

    @InjectMocks
    private QuizService quizService;

    private UUID userId;
    private Question sampleQuestion;

    @BeforeEach
    void setUp() {
        userId = UUID.randomUUID();
        sampleQuestion = new Question();
        sampleQuestion.setId(UUID.randomUUID());
        // Setup sample data...
    }

    @Test
    void startQuiz_CreatesSession() {
        // Arrange
        when(questionRepository.findRandomQuestions(anyInt()))
                .thenReturn(List.of(sampleQuestion));

        StartQuizRequest request = new StartQuizRequest(null, 5);

        // Act
        QuizSessionResponse result = quizService.startQuiz(userId, request);

        // Assert
        assertNotNull(result);
        assertEquals(userId, result.userId());
    }
}
```

**Frontend (Vitest + React Testing Library):**
```typescript
describe('ChoiceList', () => {
  it('renders all choices', () => {
    render(
      <ChoiceList
        choices={mockChoices}
        selectedAnswer={null}
        onSelect={vi.fn()}
      />
    );

    expect(screen.getByText('a)')).toBeInTheDocument();
    expect(screen.getByText('Option A')).toBeInTheDocument();
  });

  it('calls onSelect when choice clicked', () => {
    const handleSelect = vi.fn();
    render(
      <ChoiceList
        choices={mockChoices}
        selectedAnswer={null}
        onSelect={handleSelect}
      />
    );

    fireEvent.click(screen.getByText('Option A'));
    expect(handleSelect).toHaveBeenCalledWith('a');
  });
});
```

**Patterns:**
- Setup: `@BeforeEach` (backend), `describe` blocks (frontend)
- Teardown: Automatic (JUnit 5 + Vitest cleanup)
- Assertions: Behavioral focus (test what it does, not how)

## Mocking

**Backend: Mockito**

Framework: Mockito (built into Spring Boot Test)

What to Mock:
- Repositories (`QuestionRepository`, `QuizSessionRepository`)
- External services (Supabase client)
- JWT utilities

What NOT to Mock:
- Domain objects (Questions, Users)
- DTOs (StartQuizRequest, QuizAnswerResponse)

Pattern:
```java
@Mock
private QuestionRepository questionRepository;

@Mock
private QuizSessionRepository quizSessionRepository;

@InjectMocks
private QuizService quizService;

// Use when().thenReturn() for stubbing
when(questionRepository.findRandomQuestions(anyInt()))
    .thenReturn(List.of(sampleQuestion));

// Use verify() for interaction verification
verify(quizSessionRepository).save(any(QuizSession.class));

// Use any() matchers for flexible matching
when(quizSessionRepository.findById(any(UUID.class)))
    .thenReturn(Optional.of(sampleSession));
```

**Frontend: Vitest Mocks**

Framework: Vitest built-in mocks + React Testing Library

What to Mock:
- Supabase client (avoid real auth calls)
- API responses (using `vi.fn()`)
- Router hooks (`useNavigate`, `useParams`)
- React context values

What NOT to Mock:
- Component rendering
- DOM events (use `fireEvent`)
- React hooks (test actual behavior)

Pattern:
```typescript
// Mock function creation
const handleSelect = vi.fn();
const mockNavigate = vi.fn();

// Mock Supabase client
vi.mock('../lib/supabase', () => ({
  supabase: {
    auth: {
      signInWithPassword: vi.fn(),
    },
  },
}));

// Mock API calls
vi.mock('../lib/api', () => ({
  api: {
    get: vi.fn(),
    post: vi.fn(),
  },
}));

// Mock React Router
vi.mock('react-router-dom', () => ({
  useNavigate: () => mockNavigate,
  useParams: () => ({ topicId: '123' }),
}));

// Verify interaction
fireEvent.click(screen.getByText('Submit'));
expect(handleSelect).toHaveBeenCalledWith('b');
```

**Mocking Patterns:**
- Use `any()` matchers for flexible argument matching
- Use `when().thenReturn()` for return values
- Use `verify()` or `expect().toHaveBeenCalled()` for interactions
- Use `any(UUID.class)` for UUID arguments

## Fixtures and Factories

**Test Data:**
- Backend: Manual construction in `@BeforeEach`
- Frontend: Inline object literals or const arrays

**Backend Fixtures:**
```java
private UUID userId;
private UUID sessionId;
private Question sampleQuestion;
private QuizSession sampleSession;

@BeforeEach
void setUp() {
    userId = UUID.randomUUID();
    sessionId = UUID.randomUUID();

    sampleQuestion = new Question();
    sampleQuestion.setId(UUID.randomUUID());
    sampleQuestion.setExamSession("2025-october");
    sampleQuestion.setSubject("A");
    sampleQuestion.setQuestionNumber(1);
    sampleQuestion.setQuestionText("What is 2 + 2?");
    sampleQuestion.setChoices("[{\"label\":\"a\",\"text\":\"3\"},{\"label\":\"b\",\"text\":\"4\"}]");
    sampleQuestion.setCorrectAnswer("b");
    sampleQuestion.setDifficulty("easy");

    sampleSession = new QuizSession();
    sampleSession.setId(sessionId);
    sampleSession.setUserId(userId);
    sampleSession.setQuestionCount(5);
    sampleSession.setScore(0);
    sampleSession.setXpEarned(0);
    sampleSession.setStatus("in_progress");
}
```

**Frontend Fixtures:**
```typescript
const mockChoices: Choice[] = [
  { label: 'a', text: 'Option A' },
  { label: 'b', text: 'Option B' },
  { label: 'c', text: 'Option C' },
  { label: 'd', text: 'Option D' },
];

const mockQuestion: Question = {
  id: 'q1',
  question_text: 'What is 2 + 2?',
  choices: mockChoices,
  correct_answer: 'b',
  explanation: 'Basic arithmetic',
  difficulty: 'easy',
};
```

**Location:**
- Backend: Within test class (`@BeforeEach` method)
- Frontend: Within test file or `describe` block

## Coverage

**Requirements:** Not enforced by CI (stretch goal)

**View Coverage:**
```bash
# Frontend
cd src/web && npm run test -- --coverage

# Backend
cd src/api && ./gradlew test jacocoTestReport
# Report: src/api/build/reports/jacoco/test/html/index.html
```

**Current State:**
- Frontend: 5 component tests (`Button`, `ChoiceList`, `ExplanationBox`, `ProgressBar`, `QuestionBlock`)
- Backend: 4 service/controller tests (`QuestionServiceTest`, `QuizServiceTest`, `QuestionControllerTest`, `UserControllerTest`)
- Coverage likely <50% (many untested components and services)

## Test Types

**Unit Tests:**
- Scope: Single class/method in isolation
- Backend: Service methods with mocked repositories
- Frontend: Component rendering and interaction
- Example: `QuizServiceTest.startQuiz_CreatesSession()`

**Integration Tests:**
- Scope: Multiple classes working together
- Backend: Not yet implemented (recommend `@SpringBootTest` + Testcontainers)
- Frontend: Not yet implemented (recommend testing custom hooks)

**E2E Tests:**
- Framework: Not used (future: Playwright)
- Status: Not implemented

## Common Patterns

**Async Testing:**
- Backend: N/A (synchronous in tests)
- Frontend: Use `waitFor()` for async operations

```typescript
import { render, screen, waitFor } from '@testing-library/react';

it('loads user data', async () => {
  render(<UserProfile />);
  
  await waitFor(() => {
    expect(screen.getByText('John Doe')).toBeInTheDocument();
  });
});
```

**Error Testing:**
- Backend: Test exception throwing and handling

```java
@Test
void startQuiz_NoQuestionsAvailable_ThrowsException() {
    when(questionRepository.findRandomQuestions(anyInt()))
        .thenReturn(List.of());

    StartQuizRequest request = new StartQuizRequest(null, 5);

    assertThrows(NoQuestionsAvailableException.class,
        () -> quizService.startQuiz(userId, request));
}
```

- Frontend: Test error states and error messages

```typescript
it('shows error message on failure', async () => {
  api.get.mockRejectedValue(new Error('Network error'));
  
  render(<UserProfile />);
  
  await waitFor(() => {
    expect(screen.getByText('Failed to load profile')).toBeInTheDocument();
  });
});
```

**State Testing:**
- Backend: N/A
- Frontend: Test state updates and conditional rendering

```typescript
it('updates selected answer', () => {
  const handleSelect = vi.fn();
  render(<ChoiceList choices={mockChoices} onSelect={handleSelect} />);
  
  fireEvent.click(screen.getByText('Option B'));
  expect(handleSelect).toHaveBeenCalledWith('b');
});
```

**Component Interaction Testing:**
- Test user interactions (clicks, inputs, form submissions)
- Verify callbacks are called with correct arguments
- Test conditional rendering based on state

## Test Configuration

**Backend (`build.gradle`):**
```groovy
testImplementation 'org.springframework.boot:spring-boot-starter-test'
testImplementation 'org.springframework.security:spring-security-test'

tasks.named('test') {
    useJUnitPlatform()
}
```

**Frontend (`vitest.config.ts`):**
```typescript
export default defineConfig({
  plugins: [react()],
  test: {
    globals: true,
    environment: 'jsdom',
    setupFiles: ['./src/test-setup.ts'],
    css: true,
  },
});
```

**Frontend Setup (`src/test-setup.ts`):**
```typescript
import '@testing-library/jest-dom';
```

## Best Practices

1. **Test behavior, not implementation** - Test what the component does, not how it does it
2. **Use accessible queries** - Prefer `getByRole`, `getByText`, `getByLabelText` over `getByTestId`
3. **Test user journeys** - Test complete user flows, not isolated snippets
4. **Mock external dependencies** - Never hit real APIs or databases in tests
5. **Use meaningful assertions** - Assert on expected outcomes, not intermediate states
6. **Keep tests independent** - Each test should be isolated and not depend on others
7. **Test edge cases** - Empty states, error states, boundary conditions
8. **Use descriptive test names** - Test name should describe the scenario and expected outcome

---

*Testing analysis: 2026-07-14*
