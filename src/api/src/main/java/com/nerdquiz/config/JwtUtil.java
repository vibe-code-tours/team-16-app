package com.nerdquiz.config;

import com.nimbusds.jose.JWSVerifier;
import com.nimbusds.jose.crypto.RSASSAVerifier;
import com.nimbusds.jose.jwk.JWK;
import com.nimbusds.jose.jwk.JWKSet;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jwt.SignedJWT;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URI;
import java.text.ParseException;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Verifies JWTs issued by Supabase Auth using their JWKS endpoint.
 * Caches the JWKS key set to avoid repeated HTTP calls.
 */
@Component
public class JwtUtil {

    private static final Logger log = LoggerFactory.getLogger(JwtUtil.class);

    private final String supabaseUrl;
    private volatile JWKSet cachedJwks;
    private volatile long cacheExpiry = 0;
    private static final long CACHE_DURATION_MS = 3600_000; // 1 hour

    private static final Map<String, JWSVerifier> verifierCache = new ConcurrentHashMap<>();

    public JwtUtil(@Value("${supabase.url}") String supabaseUrl) {
        this.supabaseUrl = supabaseUrl;
    }

    /**
     * Verify the JWT token and return the claims.
     *
     * @param token the raw JWT string
     * @return the parsed SignedJWT with verified signature
     * @throws Exception if verification fails
     */
    public SignedJWT verify(String token) throws Exception {
        SignedJWT signedJWT = SignedJWT.parse(token);

        // Check expiration
        Date expirationTime = signedJWT.getJWTClaimsSet().getExpirationTime();
        if (expirationTime != null && expirationTime.before(new Date())) {
            throw new SecurityException("JWT has expired");
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
                RSAKey rsaKey = jwk.toRSAKey();
                return new RSASSAVerifier(rsaKey);
            } catch (Exception e) {
                throw new RuntimeException("Failed to create verifier for kid: " + kid, e);
            }
        });

        // Verify signature
        if (!signedJWT.verify(verifier)) {
            throw new SecurityException("JWT signature verification failed");
        }

        return signedJWT;
    }

    /**
     * Extract user ID (sub claim) from a verified JWT.
     */
    public String extractUserId(SignedJWT jwt) throws ParseException {
        return jwt.getJWTClaimsSet().getSubject();
    }

    /**
     * Fetch JWKS from Supabase, with caching.
     */
    private JWKSet getJwks() throws Exception {
        long now = System.currentTimeMillis();
        if (cachedJwks != null && now < cacheExpiry) {
            return cachedJwks;
        }

        String jwksUrl = supabaseUrl + "/auth/v1/.well-known/jwks.json";
        log.debug("Fetching JWKS from: {}", jwksUrl);

        JWKSet jwkSet = JWKSet.load(new URI(jwksUrl).toURL());

        cachedJwks = jwkSet;
        cacheExpiry = now + CACHE_DURATION_MS;

        return jwkSet;
    }
}
