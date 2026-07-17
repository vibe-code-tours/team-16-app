package com.nerdquiz.controller;

import com.nerdquiz.config.CorsConfig;
import com.nerdquiz.config.JwtUtil;
import com.nerdquiz.dto.*;
import com.nerdquiz.exception.AdminAccessDeniedException;
import com.nerdquiz.exception.UserProfileNotFoundException;
import com.nerdquiz.repository.UserProfileRepository;
import com.nerdquiz.service.AdminService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

import static org.hamcrest.Matchers.containsString;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(AdminController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class AdminControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private AdminService adminService;

    @MockitoBean
    private JwtUtil jwtUtil;

    @MockitoBean
    private CorsConfig corsConfig;

    @MockitoBean
    private UserProfileRepository userProfileRepository;

    @Autowired
    private ObjectMapper objectMapper;

    private UsernamePasswordAuthenticationToken authenticatedUser() {
        return new UsernamePasswordAuthenticationToken(UUID.randomUUID().toString(), null);
    }

    @Test
    void getStats_ReturnsOk() throws Exception {
        AdminStatsResponse response = new AdminStatsResponse(
            0L, 0L, 0L, 0L, 0L, 0L, 0L,
            0.0, 0.0, 0L, 0L,
            List.of(), List.of()
        );
        when(adminService.getStats(any(UUID.class))).thenReturn(response);

        mockMvc.perform(get("/api/v1/admin/stats")
                        .principal(authenticatedUser()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.totalUsers").value(0));
    }

    @Test
    void getStats_NonAdmin_ThrowsForbidden() throws Exception {
        when(adminService.getStats(any(UUID.class)))
                .thenThrow(new AdminAccessDeniedException());

        mockMvc.perform(get("/api/v1/admin/stats")
                        .principal(authenticatedUser()))
                .andExpect(status().isForbidden());
    }

    @Test
    void getUsers_ReturnsOk_DefaultParams() throws Exception {
        AdminUserListResponse response = new AdminUserListResponse(
            List.of(), 0L, 1, 25
        );
        when(adminService.getUsers(any(UUID.class), any(), any(), any(), any(), any(), anyInt(), anyInt()))
                .thenReturn(response);

        mockMvc.perform(get("/api/v1/admin/users")
                        .principal(authenticatedUser()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.users").isArray())
                .andExpect(jsonPath("$.page").value(1))
                .andExpect(jsonPath("$.pageSize").value(25));
    }

    @Test
    void getUsers_ReturnsOk_AllParams() throws Exception {
        AdminUserListResponse response = new AdminUserListResponse(
            List.of(), 0L, 1, 25
        );
        when(adminService.getUsers(any(UUID.class), any(), any(), any(), any(), any(), anyInt(), anyInt()))
                .thenReturn(response);

        mockMvc.perform(get("/api/v1/admin/users")
                        .principal(authenticatedUser())
                        .param("search", "aung")
                        .param("role", "user")
                        .param("filter", "active_today")
                        .param("sort", "email")
                        .param("order", "asc"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.users").isArray());
    }

    @Test
    void getUserDetail_ReturnsOk() throws Exception {
        UUID targetId = UUID.randomUUID();
        AdminUserDetailResponse response = new AdminUserDetailResponse(
            targetId, "Aung Aung", "aung@example.com", null,
            "user", "active", 100, 5, 10,
            Instant.now(), Instant.now(),
            20L, 15L, 75.0,
            5L, 3L, 80.0, 60L,
            List.of()
        );
        when(adminService.getUserDetail(any(UUID.class), any(UUID.class)))
                .thenReturn(response);

        mockMvc.perform(get("/api/v1/admin/users/" + targetId)
                        .principal(authenticatedUser()))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value("aung@example.com"));
    }

    @Test
    void getUserDetail_NotFound_ThrowsNotFound() throws Exception {
        when(adminService.getUserDetail(any(UUID.class), any(UUID.class)))
                .thenThrow(new UserProfileNotFoundException());

        mockMvc.perform(get("/api/v1/admin/users/" + UUID.randomUUID())
                        .principal(authenticatedUser()))
                .andExpect(status().isNotFound());
    }

    @Test
    void updateUserRole_ReturnsNoContent() throws Exception {
        UUID targetId = UUID.randomUUID();
        doNothing().when(adminService).updateUserRole(any(UUID.class), any(UUID.class), any());

        mockMvc.perform(patch("/api/v1/admin/users/" + targetId + "/role")
                        .principal(authenticatedUser())
                        .contentType("application/json")
                        .content("{\"role\":\"admin\"}"))
                .andExpect(status().isNoContent());
    }

    @Test
    void updateUserRole_MissingRole_ReturnsBadRequest() throws Exception {
        mockMvc.perform(patch("/api/v1/admin/users/" + UUID.randomUUID() + "/role")
                        .principal(authenticatedUser())
                        .contentType("application/json")
                        .content("{}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    void deactivateUser_ReturnsNoContent() throws Exception {
        UUID targetId = UUID.randomUUID();
        doNothing().when(adminService).deactivateUser(any(UUID.class), any(UUID.class));

        mockMvc.perform(post("/api/v1/admin/users/" + targetId + "/deactivate")
                        .principal(authenticatedUser()))
                .andExpect(status().isNoContent());
    }

    @Test
    void resetUserStreak_ReturnsNoContent() throws Exception {
        UUID targetId = UUID.randomUUID();
        doNothing().when(adminService).resetUserStreak(any(UUID.class), any(UUID.class));

        mockMvc.perform(post("/api/v1/admin/users/" + targetId + "/reset-streak")
                        .principal(authenticatedUser()))
                .andExpect(status().isNoContent());
    }

    @Test
    void exportUsers_ReturnsCsvWithHeaders() throws Exception {
        when(adminService.exportUsers(any(UUID.class), any(), any(), any()))
                .thenReturn("ID,Name,Email\n");

        mockMvc.perform(get("/api/v1/admin/users/export")
                        .principal(authenticatedUser()))
                .andExpect(status().isOk())
                .andExpect(header().string(HttpHeaders.CONTENT_DISPOSITION, containsString("attachment")))
                .andExpect(content().string(containsString("ID,Name,Email")));
    }

    @Test
    void exportUsers_WithFilters_AppliesParams() throws Exception {
        when(adminService.exportUsers(any(UUID.class), any(), any(), any()))
                .thenReturn("ID,Name,Email\n");

        mockMvc.perform(get("/api/v1/admin/users/export")
                        .principal(authenticatedUser())
                        .param("search", "aung")
                        .param("role", "user")
                        .param("filter", "active_today"))
                .andExpect(status().isOk());

        verify(adminService).exportUsers(any(UUID.class), eq("aung"), eq("user"), eq("active_today"));
    }
}
