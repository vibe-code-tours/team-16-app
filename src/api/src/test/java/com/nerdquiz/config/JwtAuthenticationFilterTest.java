package com.nerdquiz.config;

import com.nerdquiz.model.UserProfile;
import com.nerdquiz.repository.UserProfileRepository;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.core.context.SecurityContextHolder;

import java.io.IOException;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class JwtAuthenticationFilterTest {

    @Mock
    private JwtUtil jwtUtil;

    @Mock
    private UserProfileRepository userProfileRepository;

    @Mock
    private FilterChain filterChain;

    private JwtAuthenticationFilter filter;

    @BeforeEach
    void setUp() {
        filter = new JwtAuthenticationFilter(jwtUtil, userProfileRepository);
        SecurityContextHolder.clearContext();
    }

    @Test
    void doFilterInternal_AdminUser_GetsRoleAdminAndRoleUser() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("Authorization", "Bearer valid-admin-token");
        MockHttpServletResponse response = new MockHttpServletResponse();

        com.nimbusds.jwt.SignedJWT mockJwt = mock(com.nimbusds.jwt.SignedJWT.class);
        UUID adminUserId = UUID.randomUUID();
        when(jwtUtil.verify("valid-admin-token")).thenReturn(mockJwt);
        when(jwtUtil.extractUserId(mockJwt)).thenReturn(adminUserId.toString());

        UserProfile adminProfile = new UserProfile();
        adminProfile.setId(adminUserId);
        adminProfile.setRole("admin");
        adminProfile.setIsActive(true);
        when(userProfileRepository.findById(adminUserId)).thenReturn(Optional.of(adminProfile));

        filter.doFilterInternal(request, response, filterChain);

        var auth = SecurityContextHolder.getContext().getAuthentication();
        assertNotNull(auth, "Authentication should be set");
        var authorities = auth.getAuthorities().stream()
                .map(a -> a.getAuthority()).toList();
        assertTrue(authorities.contains("ROLE_ADMIN"), "Admin user should have ROLE_ADMIN");
        assertTrue(authorities.contains("ROLE_USER"), "Admin user should have ROLE_USER");
        verify(filterChain).doFilter(request, response);
    }

    @Test
    void doFilterInternal_RegularUser_GetsOnlyRoleUser() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("Authorization", "Bearer valid-user-token");
        MockHttpServletResponse response = new MockHttpServletResponse();

        com.nimbusds.jwt.SignedJWT mockJwt = mock(com.nimbusds.jwt.SignedJWT.class);
        UUID regularUserId = UUID.randomUUID();
        when(jwtUtil.verify("valid-user-token")).thenReturn(mockJwt);
        when(jwtUtil.extractUserId(mockJwt)).thenReturn(regularUserId.toString());

        UserProfile userProfile = new UserProfile();
        userProfile.setId(regularUserId);
        userProfile.setRole("user");
        userProfile.setIsActive(true);
        when(userProfileRepository.findById(regularUserId)).thenReturn(Optional.of(userProfile));

        filter.doFilterInternal(request, response, filterChain);

        var auth = SecurityContextHolder.getContext().getAuthentication();
        assertNotNull(auth, "Authentication should be set");
        var authorities = auth.getAuthorities().stream()
                .map(a -> a.getAuthority()).toList();
        assertFalse(authorities.contains("ROLE_ADMIN"), "Regular user should not have ROLE_ADMIN");
        assertTrue(authorities.contains("ROLE_USER"), "Regular user should have ROLE_USER");
        verify(filterChain).doFilter(request, response);
    }

    @Test
    void doFilterInternal_DeactivatedUser_RejectedWith401() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("Authorization", "Bearer valid-token");
        MockHttpServletResponse response = new MockHttpServletResponse();

        com.nimbusds.jwt.SignedJWT mockJwt = mock(com.nimbusds.jwt.SignedJWT.class);
        UUID deactivatedUserId = UUID.randomUUID();
        when(jwtUtil.verify("valid-token")).thenReturn(mockJwt);
        when(jwtUtil.extractUserId(mockJwt)).thenReturn(deactivatedUserId.toString());

        UserProfile deactivatedProfile = new UserProfile();
        deactivatedProfile.setId(deactivatedUserId);
        deactivatedProfile.setRole("user");
        deactivatedProfile.setIsActive(false);
        when(userProfileRepository.findById(deactivatedUserId)).thenReturn(Optional.of(deactivatedProfile));

        filter.doFilterInternal(request, response, filterChain);

        assertEquals(401, response.getStatus(), "Deactivated user should get 401");
        assertEquals("application/problem+json", response.getContentType());
        String body = response.getContentAsString();
        assertTrue(body.contains("Account is deactivated"),
                "Response should contain deactivation detail: " + body);
        assertNull(SecurityContextHolder.getContext().getAuthentication(),
                "SecurityContext should be empty for deactivated user");
        verify(filterChain, never()).doFilter(any(), any());
    }

    @Test
    void doFilterInternal_DeactivatedUser_NoProfileRecord_GetsRoleUser() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("Authorization", "Bearer valid-token");
        MockHttpServletResponse response = new MockHttpServletResponse();

        com.nimbusds.jwt.SignedJWT mockJwt = mock(com.nimbusds.jwt.SignedJWT.class);
        UUID userId = UUID.randomUUID();
        when(jwtUtil.verify("valid-token")).thenReturn(mockJwt);
        when(jwtUtil.extractUserId(mockJwt)).thenReturn(userId.toString());

        // No profile found -- graceful fallback to ROLE_USER
        when(userProfileRepository.findById(userId)).thenReturn(Optional.empty());

        filter.doFilterInternal(request, response, filterChain);

        var auth = SecurityContextHolder.getContext().getAuthentication();
        assertNotNull(auth, "Authentication should be set");
        var authorities = auth.getAuthorities().stream()
                .map(a -> a.getAuthority()).toList();
        assertTrue(authorities.contains("ROLE_USER"),
                "User with no profile should fallback to ROLE_USER");
        assertFalse(authorities.contains("ROLE_ADMIN"),
                "User with no profile should not get ROLE_ADMIN");
        verify(filterChain).doFilter(request, response);
    }

    @Test
    void doFilterInternal_MissingAuthHeader_PassesThroughWithoutAuth() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        // No Authorization header
        MockHttpServletResponse response = new MockHttpServletResponse();

        filter.doFilterInternal(request, response, filterChain);

        assertNull(SecurityContextHolder.getContext().getAuthentication(),
                "No authentication should be set when Authorization header is missing");
        verify(filterChain).doFilter(request, response);
    }

    @Test
    void doFilterInternal_InvalidJwt_Returns401WithProblemJson() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("Authorization", "Bearer invalid-token");
        MockHttpServletResponse response = new MockHttpServletResponse();

        when(jwtUtil.verify("invalid-token"))
                .thenThrow(new SecurityException("JWT signature verification failed"));

        filter.doFilterInternal(request, response, filterChain);

        assertEquals(401, response.getStatus(), "Invalid JWT should return 401");
        assertEquals("application/problem+json", response.getContentType());
        String body = response.getContentAsString();
        assertTrue(body.contains("Invalid or expired token"),
                "Response should contain invalid token detail: " + body);
        verify(filterChain, never()).doFilter(any(), any());
    }

    @Test
    void doFilterInternal_AdminRoleFalse_SetsIsActiveNull_TreatedAsActive() throws Exception {
        // Backward compatibility: null is_active treated as active
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.addHeader("Authorization", "Bearer token-null-active");
        MockHttpServletResponse response = new MockHttpServletResponse();

        com.nimbusds.jwt.SignedJWT mockJwt = mock(com.nimbusds.jwt.SignedJWT.class);
        UUID userId = UUID.randomUUID();
        when(jwtUtil.verify("token-null-active")).thenReturn(mockJwt);
        when(jwtUtil.extractUserId(mockJwt)).thenReturn(userId.toString());

        UserProfile profileNoActive = new UserProfile();
        profileNoActive.setId(userId);
        profileNoActive.setRole("admin");
        profileNoActive.setIsActive(null);
        when(userProfileRepository.findById(userId)).thenReturn(Optional.of(profileNoActive));

        filter.doFilterInternal(request, response, filterChain);

        var auth = SecurityContextHolder.getContext().getAuthentication();
        assertNotNull(auth, "Null is_active should be treated as active");
        var authorities = auth.getAuthorities().stream()
                .map(a -> a.getAuthority()).toList();
        assertTrue(authorities.contains("ROLE_ADMIN"),
                "Admin with null is_active should still get ROLE_ADMIN");
        verify(filterChain).doFilter(request, response);
    }
}
