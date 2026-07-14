package com.nerdquiz.controller;

import com.nerdquiz.config.CorsConfig;
import com.nerdquiz.config.JwtUtil;
import com.nerdquiz.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.UUID;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(UserController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private UserService userService;

    @MockitoBean
    private JwtUtil jwtUtil;

    @MockitoBean
    private CorsConfig corsConfig;

    @Test
    void updateStreak_UsesAuthenticatedUser() throws Exception {
        UUID userId = UUID.randomUUID();
        UsernamePasswordAuthenticationToken authentication =
                new UsernamePasswordAuthenticationToken(userId.toString(), null);

        when(userService.updateUserStreak(userId)).thenReturn(3);

        mockMvc.perform(post("/api/v1/me/streak").principal(authentication))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.streakCount").value(3));
    }
}
