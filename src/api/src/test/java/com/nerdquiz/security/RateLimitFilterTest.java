package com.nerdquiz.security;

import jakarta.servlet.FilterChain;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class RateLimitFilterTest {

    private RateLimitFilter filter;
    private FilterChain filterChain;

    @BeforeEach
    void setUp() {
        filter = new RateLimitFilter();
        filterChain = mock(FilterChain.class);
    }

    @Test
    void doFilterInternal_WithinLimit_PassesThrough() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("192.168.1.1");
        MockHttpServletResponse response = new MockHttpServletResponse();

        for (int i = 0; i < 5; i++) {
            filter.doFilterInternal(request, response, filterChain);
        }

        verify(filterChain, times(5)).doFilter(request, response);
    }

    @Test
    void doFilterInternal_ExceedingLimit_Returns429() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("192.168.1.2");
        MockHttpServletResponse response = new MockHttpServletResponse();

        // Exhaust the limit (default 60)
        for (int i = 0; i < 60; i++) {
            filter.doFilterInternal(request, new MockHttpServletResponse(), filterChain);
        }

        // 61st request should be rejected
        MockHttpServletResponse response2 = new MockHttpServletResponse();
        filter.doFilterInternal(request, response2, filterChain);

        assertEquals(429, response2.getStatus());
        assertEquals("application/problem+json", response2.getContentType());
        String body = response2.getContentAsString();
        assertTrue(body.contains("Rate Limit Exceeded"), "Body should contain rate limit detail: " + body);
    }

    @Test
    void doFilterInternal_ExceedingLimit_IncludesRetryAfterHeader() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("192.168.1.3");
        MockHttpServletResponse response = new MockHttpServletResponse();

        for (int i = 0; i < 60; i++) {
            filter.doFilterInternal(request, new MockHttpServletResponse(), filterChain);
        }

        MockHttpServletResponse response2 = new MockHttpServletResponse();
        filter.doFilterInternal(request, response2, filterChain);

        assertNotNull(response2.getHeader("Retry-After"), "Retry-After header should be present");
        String retryAfter = response2.getHeader("Retry-After");
        assertTrue(Integer.parseInt(retryAfter) > 0, "Retry-After should be positive");
    }

    @Test
    void doFilterInternal_ExceedingLimit_IncludesRateLimitHeaders() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("192.168.1.4");
        MockHttpServletResponse response = new MockHttpServletResponse();

        for (int i = 0; i < 60; i++) {
            filter.doFilterInternal(request, new MockHttpServletResponse(), filterChain);
        }

        MockHttpServletResponse response2 = new MockHttpServletResponse();
        filter.doFilterInternal(request, response2, filterChain);

        assertNotNull(response2.getHeader("X-RateLimit-Limit"), "X-RateLimit-Limit should be present");
        assertEquals("60", response2.getHeader("X-RateLimit-Limit"));
        assertNotNull(response2.getHeader("X-RateLimit-Remaining"), "X-RateLimit-Remaining should be present");
        assertEquals("0", response2.getHeader("X-RateLimit-Remaining"));
    }

    @Test
    void doFilterInternal_HealthEndpoint_BypassesRateLimiting() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("192.168.1.5");
        request.setRequestURI("/api/v1/health");
        MockHttpServletResponse response = new MockHttpServletResponse();

        // Send 100 requests to health endpoint -- should all pass
        for (int i = 0; i < 100; i++) {
            MockHttpServletResponse healthResponse = new MockHttpServletResponse();
            filter.doFilterInternal(request, healthResponse, filterChain);
        }

        // All should pass (filterChain called 100 times, no 429)
        verify(filterChain, times(100)).doFilter(request, any(MockHttpServletResponse.class));
    }

    @Test
    void doFilterInternal_XForwardedFor_UsesFirstIp() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest();
        request.setRemoteAddr("127.0.0.1");
        request.addHeader("X-Forwarded-For", "203.0.113.50, 70.41.3.18, 150.172.238.178");
        MockHttpServletResponse response = new MockHttpServletResponse();

        // Make requests from the forwarded IP
        for (int i = 0; i < 5; i++) {
            filter.doFilterInternal(request, response, filterChain);
        }

        verify(filterChain, times(5)).doFilter(request, response);

        // Verify that requests from a different IP are not rate limited
        MockHttpServletRequest otherRequest = new MockHttpServletRequest();
        otherRequest.setRemoteAddr("198.51.100.1");
        otherRequest.addHeader("X-Forwarded-For", "10.0.0.1, 10.0.0.2");
        MockHttpServletResponse otherResponse = new MockHttpServletResponse();
        filter.doFilterInternal(otherRequest, otherResponse, filterChain);
        // Should pass through (different IP, fresh window)
        assertEquals(200, otherResponse.getStatus());
    }

    @Test
    void doFilterInternal_DifferentIps_IndependentRateLimits() throws Exception {
        // Exhaust limit for IP 1
        MockHttpServletRequest request1 = new MockHttpServletRequest();
        request1.setRemoteAddr("10.0.0.1");
        for (int i = 0; i < 60; i++) {
            filter.doFilterInternal(request1, new MockHttpServletResponse(), filterChain);
        }

        // IP 2 should still be allowed
        MockHttpServletRequest request2 = new MockHttpServletRequest();
        request2.setRemoteAddr("10.0.0.2");
        MockHttpServletResponse response2 = new MockHttpServletResponse();
        filter.doFilterInternal(request2, response2, filterChain);
        assertEquals(200, response2.getStatus(), "Different IP should not be rate limited");
    }
}
