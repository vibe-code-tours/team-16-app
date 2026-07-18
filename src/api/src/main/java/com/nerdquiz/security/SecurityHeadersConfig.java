package com.nerdquiz.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.header.writers.ReferrerPolicyHeaderWriter;

/**
 * Security headers configuration — CSP, HSTS, frame DENY, nosniff,
 * referrer-policy, and permissions-policy.
 *
 * Per spike findings: CSP allows *.supabase.co for connect-src and wss://
 * for WebSocket connections. frame-src 'none' prevents clickjacking.
 */
@Configuration
public class SecurityHeadersConfig {

    // Merged into SecurityConfig.securityFilterChain() to avoid
    // UnreachableFilterChainException (two "any request" chains).
    // Kept as reference — remove when confirmed unnecessary.
    public SecurityFilterChain securityHeadersFilterChain(HttpSecurity http) throws Exception {
        http
            .headers(headers -> headers
                .contentSecurityPolicy(csp -> csp.policyDirectives(
                    "default-src 'self'; "
                    + "script-src 'self' 'unsafe-inline'; "
                    + "style-src 'self' 'unsafe-inline'; "
                    + "img-src 'self' data: https:; "
                    + "font-src 'self' https://fonts.gstatic.com; "
                    + "connect-src 'self' https://*.supabase.co wss://*.supabase.co; "
                    + "frame-src 'none'; "
                    + "object-src 'none'; "
                    + "base-uri 'self'; "
                    + "form-action 'self'; "
                    + "upgrade-insecure-requests"
                ))
                .frameOptions(frame -> frame.deny())
                .contentTypeOptions(Customizer.withDefaults())
                .httpStrictTransportSecurity(hsts -> hsts
                    .maxAgeInSeconds(31536000)
                    .includeSubDomains(true)
                )
                .referrerPolicy(referrer -> referrer
                    .policy(ReferrerPolicyHeaderWriter.ReferrerPolicy.STRICT_ORIGIN_WHEN_CROSS_ORIGIN)
                )
                .permissionsPolicy(permissions -> permissions
                    .policy("camera=(), microphone=(), geolocation=()")
                )
            );
        return http.build();
    }
}
