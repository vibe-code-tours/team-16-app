# 5. Use Supabase Auth for user authentication

- Status: accepted
- Date: 2026-07-10

## Context

NerdQuiz needs user registration, login, and session management. Building auth from scratch in Spring Boot (registration flow, password hashing, email verification, session/JWT management, password reset) would consume 2–3 days of a2-week sprint.

## Decision

In the context of **needing auth in a2-week sprint**, facing **the tradeoff between building custom auth in Spring Boot vs. using a managed auth service**, we chose **Supabase Auth (called directly from the React frontend)** to achieve **production-ready auth in hours instead of days**, accepting **auth logic lives outside the backend and Spring Boot becomes a JWT-verifier only**.

## How it works

1. The React frontend calls Supabase Auth SDK for registration, login, and session refresh.
2. Supabase issues JWTs (access + refresh tokens).
3. The frontend attaches the JWT to every API call via `Authorization: Bearer <token>`.
4. Spring Boot verifies the JWT signature and extracts the user ID — it never handles passwords.

## Consequences

- Spring Boot has no auth endpoints — it's a pure resource server.
- JWT verification uses Supabase's published JWKS endpoint (no shared secrets).
- Social login (Google) is easy to add via Supabase Auth providers.
- We are coupled to Supabase's auth schema (`auth.users` table) for user identity.
