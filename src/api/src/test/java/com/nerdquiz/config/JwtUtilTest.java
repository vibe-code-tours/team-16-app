package com.nerdquiz.config;

import com.nimbusds.jose.jwk.JWKSet;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.lang.reflect.Field;
import java.time.Instant;
import java.util.Date;
import java.util.List;
import java.util.UUID;

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
        jwtUtil = new JwtUtil("https://test.supabase.co", "authenticated");
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

    @Test
    void validateClaims_ValidSupabaseClaims_Accepts() {
        SignedJWT jwt = token(new JWTClaimsSet.Builder()
                .subject(UUID.randomUUID().toString())
                .issuer("https://test.supabase.co/auth/v1")
                .audience("authenticated")
                .expirationTime(Date.from(Instant.now().plusSeconds(300)))
                .build());

        assertDoesNotThrow(() -> jwtUtil.validateClaims(jwt, new Date()));
    }

    @Test
    void validateClaims_MissingExpiry_Rejects() {
        SignedJWT jwt = token(new JWTClaimsSet.Builder()
                .subject(UUID.randomUUID().toString())
                .issuer("https://test.supabase.co/auth/v1")
                .audience("authenticated")
                .build());
        assertThrows(SecurityException.class, () -> jwtUtil.validateClaims(jwt, new Date()));
    }

    @Test
    void validateClaims_WrongIssuerOrAudience_Rejects() {
        JWTClaimsSet wrongIssuer = baseClaims().issuer("https://other.example/auth/v1").build();
        JWTClaimsSet wrongAudience = baseClaims().audience(List.of("other")).build();

        assertThrows(SecurityException.class,
                () -> jwtUtil.validateClaims(token(wrongIssuer), new Date()));
        assertThrows(SecurityException.class,
                () -> jwtUtil.validateClaims(token(wrongAudience), new Date()));
    }

    @Test
    void validateClaims_FutureNotBeforeOrInvalidSubject_Rejects() {
        JWTClaimsSet future = baseClaims()
                .notBeforeTime(Date.from(Instant.now().plusSeconds(300))).build();
        JWTClaimsSet invalidSubject = baseClaims().subject("not-a-uuid").build();

        assertThrows(SecurityException.class,
                () -> jwtUtil.validateClaims(token(future), new Date()));
        assertThrows(SecurityException.class,
                () -> jwtUtil.validateClaims(token(invalidSubject), new Date()));
    }

    private JWTClaimsSet.Builder baseClaims() {
        return new JWTClaimsSet.Builder()
                .subject(UUID.randomUUID().toString())
                .issuer("https://test.supabase.co/auth/v1")
                .audience("authenticated")
                .expirationTime(Date.from(Instant.now().plusSeconds(300)));
    }

    private SignedJWT token(JWTClaimsSet claims) {
        return new SignedJWT(new JWSHeader(JWSAlgorithm.RS256), claims);
    }
}
