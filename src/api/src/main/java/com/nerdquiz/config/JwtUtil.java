package com.nerdquiz.config;

import com.nimbusds.jose.JWSVerifier;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.crypto.ECDSAVerifier;
import com.nimbusds.jose.crypto.RSASSAVerifier;
import com.nimbusds.jose.jwk.JWK;
import com.nimbusds.jose.jwk.JWKSet;
import com.nimbusds.jwt.SignedJWT;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URI;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Verifies JWTs issued by Supabase Auth using their JWKS endpoint.
 * Caches the JWKS key set to avoid repeated HTTP calls.
 */
@Component
public class JwtUtil {

    private static final Logger log = LoggerFactory.getLogger(JwtUtil.class);

    /** Maximum allowed JWT token length — defense-in-depth against oversized payloads. */
    private static final int MAX_TOKEN_LENGTH = 2048;

    private final String supabaseUrl;
    private final String issuer;
    private final String audience;
    private volatile JWKSet cachedJwks;
    private volatile long cacheExpiry = 0;
    private static final long CACHE_DURATION_MS = 3600_000; // 1 hour
    private final Object jwksLock = new Object();

    private final Map<String, JWSVerifier> verifierCache = new ConcurrentHashMap<>();

    public JwtUtil(
            @Value("${supabase.url}") String supabaseUrl,
            @Value("${supabase.jwt-audience:authenticated}") String audience) {
        this.supabaseUrl = supabaseUrl.replaceAll("/+$", "");
        this.issuer = this.supabaseUrl + "/auth/v1";
        this.audience = audience;
    }

    JwtUtil(String supabaseUrl) {
        this(supabaseUrl, "authenticated");
    }

    /**
     * Verify the JWT token and return the claims.
     *
     * @param token the raw JWT string
     * @return the parsed SignedJWT with verified signature
     * @throws Exception if verification fails
     */
    public SignedJWT verify(String token) throws Exception {
        if (token == null || token.isEmpty()) {
            throw new IllegalArgumentException("Token must not be null or empty");
        }
        if (token.length() > MAX_TOKEN_LENGTH) {
            throw new SecurityException("Invalid token");
        }

        SignedJWT signedJWT = SignedJWT.parse(token);

        JWSAlgorithm algorithm = signedJWT.getHeader().getAlgorithm();
        if (!JWSAlgorithm.RS256.equals(algorithm) && !JWSAlgorithm.ES256.equals(algorithm)) {
            throw new SecurityException("JWT uses an unsupported algorithm");
        }

        // Get the key ID from the JWT header
        String keyId = signedJWT.getHeader().getKeyID();
        if (keyId == null) {
            throw new SecurityException("JWT header missing key ID (kid)");
        }

        // Get or create verifier for this key
        JWSVerifier verifier = verifierCache.computeIfAbsent(keyId, kid -> {
            try {
                JWKSet jwks = getJwks();
                JWK jwk = jwks.getKeyByKeyId(kid);
                if (jwk == null) {
                    throw new SecurityException("No matching key found for kid: " + kid);
                }
                if (jwk.getAlgorithm() != null && !algorithm.equals(jwk.getAlgorithm())) {
                    throw new SecurityException("JWT algorithm does not match signing key");
                }
                return switch (jwk.getKeyType().getValue()) {
                    case "RSA" -> new RSASSAVerifier(jwk.toRSAKey());
                    case "EC" -> new ECDSAVerifier(jwk.toECKey());
                    default -> throw new SecurityException(
                            "Unsupported JWK key type: " + jwk.getKeyType());
                };
            } catch (Exception e) {
                throw new RuntimeException("Failed to create verifier for kid: " + kid, e);
            }
        });

        // Verify signature
        if (!signedJWT.verify(verifier)) {
            throw new SecurityException("JWT signature verification failed");
        }

        validateClaims(signedJWT, new Date());

        return signedJWT;
    }

    void validateClaims(SignedJWT jwt, Date now) throws ParseException {
        var claims = jwt.getJWTClaimsSet();
        Date expiration = claims.getExpirationTime();
        if (expiration == null || !expiration.after(now)) {
            throw new SecurityException("JWT is missing an expiry or has expired");
        }
        if (!issuer.equals(claims.getIssuer())) {
            throw new SecurityException("JWT issuer is invalid");
        }
        List<String> audiences = claims.getAudience();
        if (audiences == null || !audiences.contains(audience)) {
            throw new SecurityException("JWT audience is invalid");
        }
        Date notBefore = claims.getNotBeforeTime();
        if (notBefore != null && notBefore.after(now)) {
            throw new SecurityException("JWT is not yet valid");
        }
        Date issuedAt = claims.getIssueTime();
        if (issuedAt != null && issuedAt.after(new Date(now.getTime() + 60_000))) {
            throw new SecurityException("JWT issued-at time is in the future");
        }
        try {
            UUID.fromString(claims.getSubject());
        } catch (RuntimeException e) {
            throw new SecurityException("JWT subject must be a UUID");
        }
    }

    /**
     * Extract user ID (sub claim) from a verified JWT.
     */
    public String extractUserId(SignedJWT jwt) throws ParseException {
        return jwt.getJWTClaimsSet().getSubject();
    }

    /**
     * Fetch JWKS from Supabase, with caching.
     * Uses synchronized block to prevent race condition on concurrent expiration.
     */
    private JWKSet getJwks() throws Exception {
        long now = System.currentTimeMillis();
        if (cachedJwks != null && now < cacheExpiry) {
            return cachedJwks;
        }

        synchronized (jwksLock) {
            // Double-check after acquiring lock
            if (cachedJwks != null && now < cacheExpiry) {
                return cachedJwks;
            }

            String jwksUrl = supabaseUrl + "/auth/v1/.well-known/jwks.json";
            log.debug("Fetching JWKS from: {}", jwksUrl);

            JWKSet jwkSet = JWKSet.load(new URI(jwksUrl).toURL());

            cachedJwks = jwkSet;
            cacheExpiry = System.currentTimeMillis() + CACHE_DURATION_MS;

            return jwkSet;
        }
    }
}
