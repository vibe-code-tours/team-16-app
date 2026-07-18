package com.nerdquiz.security;

import org.springframework.stereotype.Component;

import java.util.regex.Pattern;

/**
 * Defense-in-depth XSS sanitizer for free-text fields.
 * Strips known XSS patterns. Primary protection is no user-generated HTML rendering;
 * this is a secondary layer applied per-field.
 *
 * <p>Does NOT include SQL injection patterns — JPA parameterized queries are the
 * primary SQLi defense.</p>
 */
@Component
public class InputSanitizer {

    private static final Pattern XSS_PATTERN = Pattern.compile(
        "</?script[^>]*>|javascript:|on\\w+\\s*=|</?iframe|</?object|</?embed|</?form",
        Pattern.CASE_INSENSITIVE
    );

    /**
     * Sanitize a string value by stripping XSS payloads.
     * Use on free-text fields (names, descriptions, comments).
     * Do NOT use on fields that must contain HTML (none in this app).
     *
     * @param input the raw user input
     * @return sanitized string with XSS patterns removed, or null if input was null
     */
    public String sanitize(String input) {
        if (input == null) {
            return null;
        }
        return XSS_PATTERN.matcher(input).replaceAll("");
    }

    /**
     * Check if input contains suspicious XSS patterns.
     *
     * @param input the raw user input
     * @return true if input is safe (or null), false if it contains XSS patterns
     */
    public boolean isSafe(String input) {
        if (input == null) {
            return true;
        }
        return !XSS_PATTERN.matcher(input).find();
    }
}
