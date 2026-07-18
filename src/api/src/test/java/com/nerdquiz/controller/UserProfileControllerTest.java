package com.nerdquiz.controller;

import com.nerdquiz.config.CorsConfig;
import com.nerdquiz.config.JwtUtil;
import com.nerdquiz.dto.UserProfileResponse;
import com.nerdquiz.repository.UserProfileRepository;
import com.nerdquiz.service.UserProfileService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.UUID;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(UserProfileController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class UserProfileControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private UserProfileService userProfileService;

    @MockitoBean
    private JwtUtil jwtUtil;

    @MockitoBean
    private CorsConfig corsConfig;

    @MockitoBean
    private UserProfileRepository userProfileRepository;

    @Test
    void upsertProfile_UsesAuthenticatedUserAndProfileMetadata() throws Exception {
        UUID userId = UUID.randomUUID();
        Instant now = Instant.now();
        UsernamePasswordAuthenticationToken authentication =
                new UsernamePasswordAuthenticationToken(userId.toString(), null);
        UserProfileResponse response = new UserProfileResponse(
                userId,
                "Nerd Learner",
                "https://example.com/avatar.png",
                "learner@example.com",
                "user",
                0,
                1,
                1,
                now,
                now,
                now
        );

        when(userProfileService.upsertProfile(
                userId,
                "learner@example.com",
                "Nerd Learner",
                "https://example.com/avatar.png"
        )).thenReturn(response);

        mockMvc.perform(post("/api/v1/me/profile")
                        .principal(authentication)
                        .contentType("application/json")
                        .content("""
                                {
                                  "email": "learner@example.com",
                                  "displayName": "Nerd Learner",
                                  "avatarUrl": "https://example.com/avatar.png"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(userId.toString()))
                .andExpect(jsonPath("$.displayName").value("Nerd Learner"));

        verify(userProfileService).upsertProfile(
                userId,
                "learner@example.com",
                "Nerd Learner",
                "https://example.com/avatar.png"
        );
    }
}
