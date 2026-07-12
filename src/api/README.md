# NerdQuiz Backend API

Spring Boot REST API for the NerdQuiz IT exam prep platform.

## Before you start

Read the coding conventions: [`../../.claude/rules/backend.md`](../../.claude/rules/backend.md)

## Setup

### Prerequisites
- Java 21+
- PostgreSQL (via Supabase CLI)

### Run locally

```bash
# Start Supabase (Postgres)
supabase start
supabase db reset

# Run the API
./gradlew bootRun
```

API runs on http://localhost:8080

## API Endpoints

### Public (no auth required)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/health` | Health check |
| GET | `/api/v1/questions/random?count=5` | Get random questions |
| GET | `/api/v1/questions/session/{session}?subject=A` | Get questions by exam session |
| GET | `/api/v1/questions/stats?examSession=...&subject=A` | Get question count |

### Protected (JWT required)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/quizzes/start` | Start a new quiz |
| POST | `/api/v1/quizzes/{sessionId}/answers` | Submit an answer |
| GET | `/api/v1/quizzes/{sessionId}/result` | Get quiz results |

## Project Structure

```
src/main/java/com/nerdquiz/
├── NerdQuizApplication.java      # Entry point
├── config/
│   ├── SecurityConfig.java       # Spring Security config
│   └── JwtAuthenticationFilter.java  # JWT verification
├── controller/
│   ├── QuestionController.java   # Question endpoints
│   ├── QuizController.java       # Quiz endpoints
│   └── HealthController.java     # Health check
├── service/
│   ├── QuestionService.java      # Question business logic
│   └── QuizService.java          # Quiz business logic
├── repository/
│   ├── QuestionRepository.java   # Question queries
│   ├── QuizSessionRepository.java
│   └── QuizAnswerRepository.java
├── model/
│   ├── Question.java             # JPA entity
│   ├── QuizSession.java
│   └── QuizAnswer.java
├── dto/
│   ├── QuestionResponse.java
│   ├── QuizSessionResponse.java
│   ├── StartQuizRequest.java
│   ├── SubmitAnswerRequest.java
│   └── QuizResultResponse.java
└── exception/
    └── GlobalExceptionHandler.java
```

## Database

The API uses the same Supabase Postgres database. Run migrations:

```bash
supabase db reset
```

Tables used:
- `questions` - Exam questions
- `quiz_sessions` - Quiz session tracking
- `quiz_answers` - Individual answers

## Frontend Connection

The frontend connects to the API via:
- Base URL: `http://localhost:8080/api/v1`
- Proxy configured in Vite: `/api` → `http://localhost:8080`
- JWT token from Supabase Auth sent in `Authorization: Bearer` header

## Testing

```bash
./gradlew test
```
