# Input Validation & Sanitization

## Requirements

- Must work with Spring Boot 3.x (Java 25) backend
- Must not break existing Supabase Auth flow
- All security measures must return RFC 7807 Problem Details format on rejection
- JPA parameterized queries prevent SQL injection at ORM level — input patterns are defense-in-depth

## How to Build It

**1. Structural validation with Jakarta `@Valid` (already in project):**

```java
// In Request DTOs
public record CreateProfileRequest(
    @NotBlank @Size(max = 100) String name,
    @Email @NotBlank String email
) {}
```

**2. XSS sanitization for free-text fields — create `InputSanitizer.java`:**

```java
@Component
public class InputSanitizer {

    private static final Pattern XSS_PATTERN = Pattern.compile(
        "<script[^>]*>|javascript:|on\\w+\\s*=|<iframe|<object|<embed|<form",
        Pattern.CASE_INSENSITIVE
    );

    /**
     * Sanitize a string value — strips XSS payloads.
     * Use on free-text fields (names, descriptions, comments).
     * Do NOT use on fields that must contain HTML (none in this app).
     */
    public String sanitize(String input) {
        if (input == null) return null;
        return XSS_PATTERN.matcher(input).replaceAll("");
    }

    /**
     * Check if input contains suspicious patterns.
     * Returns true if input is safe, false if it contains XSS.
     */
    public boolean isSafe(String input) {
        if (input == null) return true;
        return !XSS_PATTERN.matcher(input).find();
    }
}
```

**3. SQL injection defense — the real protection is JPA parameterized queries:**

```java
// CORRECT — parameterized query (safe)
@Query("SELECT q FROM Question q WHERE q.topicCategory = :category")
List<Question> findByCategory(@Param("category") String category);

// WRONG — string concatenation (vulnerable — NEVER do this)
// @Query("SELECT * FROM questions WHERE category = '" + category + "'")
```

**4. Payload size limits in `application.properties`:**

```properties
server.tomcat.max-http-form-post-size=100KB
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
```

**5. Path traversal prevention for file-serving endpoints:**

```java
// Check for .. in filename components
if (filename.contains("..") || filename.startsWith("/")) {
    throw new ForbiddenException("Path traversal not allowed");
}
```

## What to Avoid

- **Never match `"` in SQL injection regex patterns.** Discovered during spike 003 — double quotes are valid JSON syntax. Every JSON body contains `"`, causing 100% false positive rate. The pattern `('|"|;|--)` is wrong; use keyword-based patterns instead.
- **Don't apply XSS patterns to JSON keys/values globally.** XSS patterns are for free-text fields rendered in HTML, not for structured data like JSON. Apply per-field.
- **Don't rely solely on client-side validation.** Backend validation is the authority. Client-side is UX only.
- **Don't use `String.replace()` for XSS sanitization.** Use regex with word boundaries to avoid breaking legitimate content (e.g., `<form>` in a chemistry discussion).
- **Don't forget URL-encoded path traversal.** Test with `%2F..%2F` encoding, not just raw `../`.

## Constraints

- JPA parameterized queries are the PRIMARY SQL injection defense — input patterns are defense-in-depth only
- XSS patterns must be tuned per-field (free-text only) — applying globally causes false positives
- Jakarta `@Valid` handles structural validation (type, length, format) — custom sanitizer handles content validation (XSS)
- Spring Boot's `server.tomcat.max-http-form-post-size` handles payload size limits natively

## Origin

Synthesized from spikes: 003
Source files available in: sources/003-input-validation/
