package com.nerdquiz.config;

import com.nimbusds.jose.jwk.JWKSet;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.lang.reflect.Field;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
class JwtUtilTest {

    @Mock
    private JWKSet mockJwks;

    private JwtUtil jwtUtil;

    @BeforeEach
    void setUp() throws Exception {
        jwtUtil = new JwtUtil("https://test.supabase.co");
        // Inject mock JWKS via reflection to avoid network calls
        Field cachedJwksField = JwtUtil.class.getDeclaredField("cachedJwks");
        cachedJwksField.setAccessible(true);
        cachedJwksField.set(jwtUtil, mockJwks);

        Field cacheExpiryField = JwtUtil.class.getDeclaredField("cacheExpiry");
        cacheExpiryField.setAccessible(true);
        cacheExpiryField.set(jwtUtil, System.currentTimeMillis() + 3600_000);
    }

    @Test
    void verify_TokenExceedingMaxLength_ThrowsBeforeNetworkCall() {
        // Build a token string longer than MAX_TOKEN_LENGTH (2048)
        String longToken = "a".repeat(3000);

        SecurityException ex = assertThrows(SecurityException.class,
                () -> jwtUtil.verify(longToken));
        assertEquals("Invalid token", ex.getMessage());
    }

    @Test
    void verify_NullToken_ThrowsIllegalArgument() {
        assertThrows(IllegalArgumentException.class,
                () -> jwtUtil.verify(null));
    }

    @Test
    void verify_EmptyToken_ThrowsIllegalArgument() {
        assertThrows(IllegalArgumentException.class,
                () -> jwtUtil.verify(""));
    }

    @Test
    void verify_TokenAtMaxLength_DoesNotThrowLengthCheck() {
        // 2048 chars exactly should pass the length check
        // It will fail at parse time (not a valid JWT), but should NOT
        // throw SecurityException("Invalid token") from the length guard
        String exactLengthToken = "a".repeat(2048);

        Exception ex = assertThrows(Exception.class,
                () -> jwtUtil.verify(exactLengthToken));
        // The exception should NOT be our length guard
        assertTrue(!"Invalid token".equals(ex.getMessage()),
                "Token at max length should pass length check but fail at parse");
    }

    @Test
    void verify_TokenJustOverMaxLength_ThrowsInvalidToken() {
        String justOverToken = "a".repeat(2049);

        SecurityException ex = assertThrows(SecurityException.class,
                () -> jwtUtil.verify(justOverToken));
        assertEquals("Invalid token", ex.getMessage());
    }
}
