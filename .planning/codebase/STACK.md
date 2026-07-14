# Technology Stack

**Analysis Date:** 2026-07-14

## Languages

**Primary:**
- Java 25 - Backend API (Spring Boot service)
- TypeScript 6.0.2 - Frontend SPA (React application)

**Secondary:**
- SQL - Database migrations (Postgres)
- YAML - Configuration files (CI/CD, application config)
- Bash - Build scripts, Docker configuration

## Runtime

**Backend Environment:**
- JVM 25 (Eclipse Temurin) - Production container runtime
- Eclipse Temurin 25 JDK Alpine - Build stage
- Eclipse Temurin 25 JRE Alpine - Runtime stage

**Frontend Environment:**
- Node.js 20.x - Build and development
- Vite 8.1.1 - Development server and bundler

**Package Manager:**
- Backend: Gradle 8.x (wrapper included)
- Frontend: npm (with package-lock.json lockfile)

## Frameworks

**Core:**
- Spring Boot 3.5.9 - Backend REST API framework
- React 19.2.7 - Frontend UI framework (functional components)
- Tailwind CSS 4.3.2 - Utility-first CSS framework
- React Router DOM 7.18.1 - Client-side routing

**Testing:**
- JUnit 5 - Java unit testing (backend)
- Mockito - Java mocking (backend)
- Vitest 4.1.10 - React component testing (frontend)
- React Testing Library 16.3.2 - UI component testing

**Build/Dev:**
- Vite 8.1.1 - Frontend development server and bundler
- Gradle - Backend build automation
- OxLint 1.71.0 - Frontend linting

## Key Dependencies

**Backend Critical:**
- Spring Data JPA - Database ORM and query management
- Spring Security - JWT authentication and authorization
- Nimbus JOSE+JWT 9.41.2 - JWT verification and validation
- PostgreSQL Driver - Database connectivity

**Backend Infrastructure:**
- Spring Boot Starter Web - REST API support
- Spring Boot Starter Validation - Input validation (Jakarta Validation)
- Jackson - JSON serialization/deserialization

**Frontend Critical:**
- @supabase/supabase-js 2.110.2 - Supabase client SDK (auth + database)
- React 19.2.7 - UI component framework
- TypeScript - Type safety and developer tooling

**Frontend UI:**
- Lucide React 1.24.0 - Icon library
- React Markdown 10.1.0 - Markdown rendering
- class-variance-authority 0.7.1 - Component variant management
- clsx + tailwind-merge - Conditional class merging

## Configuration

**Backend Environment Variables:**
- `DATABASE_URL` - Postgres connection string (format: jdbc:postgresql://host:port/db?user=...&password=...)
- `SUPABASE_URL` - Supabase project URL (e.g., https://xxx.supabase.co)
- `SUPABASE_ANON_KEY` - Supabase public anonymous key
- `PORT` - Server port (default: 8080)
- `CORS_ALLOWED_ORIGINS` - Comma-separated frontend origins

**Frontend Environment Variables:**
- `VITE_SUPABASE_URL` - Supabase project URL
- `VITE_SUPABASE_ANON_KEY` - Supabase public anonymous key
- `VITE_API_URL` - Backend API base URL (optional, defaults to relative path)

**Build Configuration Files:**
- `src/api/build.gradle` - Gradle build configuration (dependencies, plugins)
- `src/web/package.json` - npm package manifest (scripts, dependencies)
- `src/web/vite.config.ts` - Vite build/dev configuration
- `src/web/tailwind.config.js` - Tailwind CSS customization
- `src/web/tsconfig.json` - TypeScript compiler options
- `docker-compose.yml` - Docker service orchestration
- `src/api/Dockerfile` - Backend container build

## Platform Requirements

**Development:**
- JDK 25+ (Eclipse Temurin recommended)
- Node.js 20.x+
- npm or compatible package manager
- Supabase CLI for local Postgres/edge functions
- Docker (optional, for containerized deployment)

**Production:**
- Backend: Docker container with JRE 25 Alpine (Eclipse Temurin)
- Frontend: Netlify (static hosting) or similar CDN
- Database: Supabase hosted Postgres (or compatible Postgres instance)
- Auth: Supabase Auth service

**Local Development Ports:**
- Backend: 8080 (Spring Boot default)
- Frontend: 5100 (Vite default, configured in vite.config.ts)
- Supabase: 54321 (local Postgres via Supabase CLI)
- Proxy: Vite proxies /api/* requests to backend on 8080

---

*Stack analysis: 2026-07-14*
