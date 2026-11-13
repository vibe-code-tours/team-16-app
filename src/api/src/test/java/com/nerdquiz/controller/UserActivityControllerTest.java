package com.nerdquiz.controller;

import com.nerdquiz.config.CorsConfig;
import com.nerdquiz.config.JwtUtil;
import com.nerdquiz.dto.DailyActivityResponse;
import com.nerdquiz.repository.UserProfileRepository;
import com.nerdquiz.service.UserDailyActivityService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(UserActivityController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class UserActivityControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private UserDailyActivityService activityService;

    @MockitoBean
    private JwtUtil jwtUtil;

    @MockitoBean
    private CorsConfig corsConfig;

    @MockitoBean
    private UserProfileRepository userProfileRepository;

    private final UUID userId = UUID.randomUUID();

    private UsernamePasswordAuthenticationToken authenticatedUser() {
        return new UsernamePasswordAuthenticationToken(userId.toString(), null);
    }

    @Test
    void getActivity_DefaultDays_UsesSevenDaysForAuthenticatedUser() throws Exception {
        when(activityService.getRecentActivity(userId, 7)).thenReturn(List.of(
                new DailyActivityResponse(LocalDate.of(2026, 11, 12), 0, 0),
                new DailyActivityResponse(LocalDate.of(2026, 11, 13), 12, 90)
        ));

        mockMvc.perform(get("/api/v1/me/activity").principal(authenticatedUser()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2))
                .andExpect(jsonPath("$[0].date").value("2026-11-12"))
                .andExpect(jsonPath("$[0].questionsAnswered").value(0))
                .andExpect(jsonPath("$[1].date").value("2026-11-13"))
                .andExpect(jsonPath("$[1].questionsAnswered").value(12))
                .andExpect(jsonPath("$[1].xpEarned").value(90));
    }

    @Test
    void getActivity_CustomDays_PassesDaysToService() throws Exception {
        when(activityService.getRecentActivity(userId, 30)).thenReturn(List.of());

        mockMvc.perform(get("/api/v1/me/activity").param("days", "30").principal(authenticatedUser()))
                .andExpect(status().isOk());

        verify(activityService).getRecentActivity(userId, 30);
    }

    @Test
    void getActivity_DaysZero_ReturnsBadRequestProblemDetails() throws Exception {
        mockMvc.perform(get("/api/v1/me/activity").param("days", "0").principal(authenticatedUser()))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.status").value(400))
                .andExpect(jsonPath("$.title").value("Validation Error"));

        verify(activityService, never()).getRecentActivity(any(), anyInt());
    }

    @Test
    void getActivity_DaysAboveMaximum_ReturnsBadRequestProblemDetails() throws Exception {
        mockMvc.perform(get("/api/v1/me/activity").param("days", "31").principal(authenticatedUser()))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.status").value(400));

        verify(activityService, never()).getRecentActivity(any(), anyInt());
    }

    @Test
    void getActivity_NonNumericDays_ReturnsBadRequestProblemDetails() throws Exception {
        mockMvc.perform(get("/api/v1/me/activity").param("days", "abc").principal(authenticatedUser()))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.status").value(400))
                .andExpect(jsonPath("$.title").value("Validation Error"));
    }
}
