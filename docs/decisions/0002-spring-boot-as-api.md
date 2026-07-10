# 2. Use Spring Boot as the REST API backend

- Status: accepted
- Date: 2026-07-10

## Context

NerdQuiz needs a backend that serves the React frontend with quiz data, user progress, XP/streak logic, and exam simulation state. The team has chosen Java 25 and Spring Boot from the tech stack.

## Decision

In the context of **building a REST API for a gamified exam-prep platform**, facing **the need for a robust, well-documented backend framework**, we chose **Spring Boot (Java 25)** to achieve **a mature ecosystem, strong typing, and straightforward JWT verification**, accepting **a heavier runtime footprint compared to lighter alternatives like Node/Express**.

## Consequences

- Spring Boot handles all REST endpoints; the frontend calls it directly.
- Supabase Auth issues JWTs — Spring Boot verifies them via a filter, not by managing login flows.
- Java 25 features (pattern matching, records, virtual threads) keep the codebase modern.
- Team members unfamiliar with Java/Spring will need a ramp-up period.
