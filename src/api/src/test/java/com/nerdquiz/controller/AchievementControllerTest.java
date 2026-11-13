package com.nerdquiz.controller;

import com.nerdquiz.config.CorsConfig;
import com.nerdquiz.config.JwtUtil;
import com.nerdquiz.dto.AchievementResponse;
import com.nerdquiz.repository.UserProfileRepository;
import com.nerdquiz.service.AchievementService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(AchievementController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class AchievementControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private AchievementService achievementService;

    @MockitoBean
    private JwtUtil jwtUtil;

    @MockitoBean
    private CorsConfig corsConfig;

    @MockitoBean
    private UserProfileRepository userProfileRepository;

    @Test
    void getAchievements_AuthenticatedUser_ReturnsCatalogueForJwtUser() throws Exception {
        UUID userId = UUID.randomUUID();
        UsernamePasswordAuthenticationToken authentication =
                new UsernamePasswordAuthenticationToken(userId.toString(), null);

        when(achievementService.getAchievements(userId)).thenReturn(List.of(
                new AchievementResponse("first-quiz", "First Steps", "Complete your first quiz",
                        "🎯", true, 1, 1),
                new AchievementResponse("quiz-10", "Quiz Regular", "Complete 10 quizzes",
                        "📚", false, 1, 10)
        ));

        mockMvc.perform(get("/api/v1/me/achievements").principal(authentication))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2))
                .andExpect(jsonPath("$[0].id").value("first-quiz"))
                .andExpect(jsonPath("$[0].title").value("First Steps"))
                .andExpect(jsonPath("$[0].description").value("Complete your first quiz"))
                .andExpect(jsonPath("$[0].icon").value("🎯"))
                .andExpect(jsonPath("$[0].unlocked").value(true))
                .andExpect(jsonPath("$[0].progress").value(1))
                .andExpect(jsonPath("$[0].target").value(1))
                .andExpect(jsonPath("$[1].unlocked").value(false))
                .andExpect(jsonPath("$[1].progress").value(1))
                .andExpect(jsonPath("$[1].target").value(10));

        verify(achievementService).getAchievements(userId);
    }

    @Test
    void getAchievements_IgnoresClientSuppliedUserId_UsesJwtSubject() throws Exception {
        UUID jwtUserId = UUID.randomUUID();
        UUID otherUserId = UUID.randomUUID();
        UsernamePasswordAuthenticationToken authentication =
                new UsernamePasswordAuthenticationToken(jwtUserId.toString(), null);

        when(achievementService.getAchievements(jwtUserId)).thenReturn(List.of());

        mockMvc.perform(get("/api/v1/me/achievements")
                        .param("userId", otherUserId.toString())
                        .principal(authentication))
                .andExpect(status().isOk());

        verify(achievementService).getAchievements(jwtUserId);
        verify(achievementService, never()).getAchievements(otherUserId);
    }

    @Test
    void getAchievements_NonUuidSubject_ReturnsBadRequest() throws Exception {
        UsernamePasswordAuthenticationToken authentication =
                new UsernamePasswordAuthenticationToken("not-a-uuid", null);

        mockMvc.perform(get("/api/v1/me/achievements").principal(authentication))
                .andExpect(status().isBadRequest());

        verify(achievementService, never()).getAchievements(any());
    }
}
