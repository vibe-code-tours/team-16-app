package com.nerdquiz.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

/**
 * CORS configuration — allows only the configured frontend origin(s).
 * Set {@code CORS_ALLOWED_ORIGINS} as a comma-separated list of origins
 * (e.g. {@code http://localhost:5173,https://nerdquiz.example.com}).
 * Defaults to {@code http://localhost:5173} for local development.
 */
@Configuration
public class CorsConfig {

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();

        String originsEnv = System.getenv("CORS_ALLOWED_ORIGINS");
        List<String> origins = (originsEnv != null && !originsEnv.isBlank())
                ? List.of(originsEnv.split(","))
                : List.of("http://localhost:5173");
        config.setAllowedOrigins(origins);

        config.setAllowedMethods(List.of("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
        config.setAllowedHeaders(List.of("Authorization", "Content-Type"));
        config.setAllowCredentials(true);
        config.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);

        return source;
    }
}
