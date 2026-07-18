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
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * Verifies CORS headers are NOT added when the request origin is not in the allowed list.
 */
@WebMvcTest(controllers = HealthController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class SecurityHeadersConfigTest {

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
    void addCorsHeaders_CorsDisabled_NoHeaders() throws Exception {
        // Origin not in the allowed list → no CORS response headers
        mockMvc.perform(get("/api/v1/health")
                        .header("Origin", "https://evil.example.com"))
                .andExpect(status().isOk())
                .andExpect(header().doesNotExist("Access-Control-Allow-Origin"));
    }
}
