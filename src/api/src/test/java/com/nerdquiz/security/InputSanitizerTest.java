package com.nerdquiz.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class InputSanitizerTest {

    private InputSanitizer sanitizer;

    @BeforeEach
    void setUp() {
        sanitizer = new InputSanitizer();
    }

    @Test
    void sanitize_ScriptTag_StripsTag() {
        String result = sanitizer.sanitize("<script>alert('xss')</script>");
        assertFalse(result.contains("<script>"));
        assertFalse(result.contains("</script>"));
    }

    @Test
    void sanitize_JavascriptProtocol_StripsProtocol() {
        String result = sanitizer.sanitize("javascript:alert(1)");
        assertFalse(result.contains("javascript:"));
    }

    @Test
    void sanitize_OnErrorEventHandler_StripsHandler() {
        String result = sanitizer.sanitize("<img onerror=alert(1)>");
        assertFalse(result.contains("onerror="));
    }

    @Test
    void sanitize_IframeTag_StripsTag() {
        String result = sanitizer.sanitize("<iframe src=evil.com>");
        assertFalse(result.contains("<iframe"));
    }

    @Test
    void sanitize_ObjectEmbedFormTags_StripsAll() {
        String result = sanitizer.sanitize("<object><embed><form>");
        assertFalse(result.contains("<object"));
        assertFalse(result.contains("<embed"));
        assertFalse(result.contains("<form"));
    }

    @Test
    void sanitize_NullInput_ReturnsNull() {
        assertNull(sanitizer.sanitize(null));
    }

    @Test
    void sanitize_CleanText_ReturnsUnchanged() {
        String input = "Hello World";
        assertEquals(input, sanitizer.sanitize(input));
    }

    @Test
    void isSafe_NormalText_ReturnsTrue() {
        assertTrue(sanitizer.isSafe("normal text"));
    }

    @Test
    void isSafe_XssPayload_ReturnsFalse() {
        assertFalse(sanitizer.isSafe("<script>xss</script>"));
    }

    @Test
    void isSafe_NullInput_ReturnsTrue() {
        assertTrue(sanitizer.isSafe(null));
    }
}
