package com.nerdquiz.config;

import com.nerdquiz.controller.HealthController;
import com.nerdquiz.repository.UserProfileRepository;
import com.nerdquiz.security.RateLimitFilter;
import com.nerdquiz.service.AdminService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Verifies SecurityHeadersConfig compiles and instantiates correctly.
 * Runtime security header verification is done in the manual checkpoint (Task 4).
 * This test ensures the security filter chain bean definition is valid and
 * the application context loads without errors.
 */
@WebMvcTest(controllers = HealthController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class SecurityConfigTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private RateLimitFilter rateLimitFilter;

    @MockitoBean
    private CorsConfig corsConfig;

    @MockitoBean
    private com.nerdquiz.config.JwtUtil jwtUtil;

    @MockitoBean
    private UserProfileRepository userProfileRepository;

    @MockitoBean
    private AdminService adminService;

    @Test
    void healthEndpoint_ReturnsOk() throws Exception {
        mockMvc.perform(get("/api/v1/health"))
                .andExpect(status().isOk());
    }

}
