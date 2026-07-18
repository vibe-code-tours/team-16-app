package com.nerdquiz.config;

import com.nerdquiz.model.UserProfile;
import com.nerdquiz.repository.UserProfileRepository;
import com.nimbusds.jwt.SignedJWT;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextHolderStrategy;
import org.springframework.security.web.context.RequestAttributeSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.core.Ordered;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * JWT authentication filter that intercepts every request,
 * verifies the Supabase JWT, looks up the user profile for
 * role and is_active status, and sets the SecurityContext.
 */
public class JwtAuthenticationFilter extends OncePerRequestFilter implements Ordered {

    @Override
    public int getOrder() {
        return Ordered.HIGHEST_PRECEDENCE + 20;
    }

    private static final Logger log = LoggerFactory.getLogger(JwtAuthenticationFilter.class);
    private static final String BEARER_PREFIX = "Bearer ";

    private final JwtUtil jwtUtil;
    private final UserProfileRepository userProfileRepository;
    private final SecurityContextHolderStrategy contextHolderStrategy = SecurityContextHolder.getContextHolderStrategy();
    private final SecurityContextRepository contextRepository = new RequestAttributeSecurityContextRepository();

    public JwtAuthenticationFilter(JwtUtil jwtUtil, UserProfileRepository userProfileRepository) {
        this.jwtUtil = jwtUtil;
        this.userProfileRepository = userProfileRepository;
    }

    @Override
    protected void doFilterInternal(
            HttpServletRequest request,
            HttpServletResponse response,
            FilterChain filterChain
    ) throws ServletException, IOException {

        // Skip if already authenticated
        SecurityContext context = contextHolderStrategy.getContext();
        if (context.getAuthentication() != null) {
            filterChain.doFilter(request, response);
            return;
        }

        String authHeader = request.getHeader("Authorization");
        log.debug("JWT filter: method={}, uri={}, hasAuthHeader={}", request.getMethod(), request.getRequestURI(), authHeader != null);

        if (authHeader == null || !authHeader.startsWith(BEARER_PREFIX)) {
            log.debug("JWT filter: no Bearer token, passing through");
            filterChain.doFilter(request, response);
            return;
        }

        String token = authHeader.substring(BEARER_PREFIX.length());

        try {
            SignedJWT jwt = jwtUtil.verify(token);
            String userId = jwtUtil.extractUserId(jwt);

            // Look up user profile for role and is_active status
            UUID userUuid = UUID.fromString(userId);
            Optional<UserProfile> profileOpt = userProfileRepository.findById(userUuid);

            // Check is_active: reject deactivated users (null treated as active for backward compat)
            if (profileOpt.isPresent() && Boolean.FALSE.equals(profileOpt.get().getIsActive())) {
                log.debug("Deactivated user attempted access: {}", userId);
                contextHolderStrategy.clearContext();

                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/problem+json");
                response.getWriter().write(
                    "{\"type\":\"urn:nerdquiz:unauthorized\","
                    + "\"title\":\"Unauthorized\",\"status\":401,"
                    + "\"detail\":\"Account is deactivated\"}"
                );
                return;
            }

            // Determine authorities based on role
            List<SimpleGrantedAuthority> authorities;
            if (profileOpt.isPresent() && "admin".equals(profileOpt.get().getRole())) {
                authorities = List.of(
                    new SimpleGrantedAuthority("ROLE_ADMIN"),
                    new SimpleGrantedAuthority("ROLE_USER")
                );
            } else {
                // Regular user or no profile found (graceful fallback)
                authorities = List.of(new SimpleGrantedAuthority("ROLE_USER"));
            }

            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(
                            userId,
                            null,
                            authorities
                    );

            context.setAuthentication(authentication);
            contextHolderStrategy.setContext(context);
            contextRepository.saveContext(context, request, response);
            log.debug("JWT filter: authentication set for user={}, authorities={}", userId, authorities);

        } catch (Exception e) {
            log.warn("JWT verification failed: {}", e.getMessage());
            contextHolderStrategy.clearContext();

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/problem+json");
            response.getWriter().write(
                "{\"type\":\"urn:nerdquiz:unauthorized\","
                + "\"title\":\"Unauthorized\",\"status\":401,"
                + "\"detail\":\"Invalid or expired token\"}"
            );
            return;
        }

        filterChain.doFilter(request, response);
    }
}
