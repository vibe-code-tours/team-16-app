package com.nerdquiz.controller;

import com.nerdquiz.config.CorsConfig;
import com.nerdquiz.config.JwtUtil;
import com.nerdquiz.dto.MistakeResponse;
import com.nerdquiz.dto.MistakeResponse.ChoiceOption;
import com.nerdquiz.repository.UserProfileRepository;
import com.nerdquiz.service.MistakeService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(UserMistakeController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class UserMistakeControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private MistakeService mistakeService;

    @MockitoBean
    private JwtUtil jwtUtil;

    @MockitoBean
    private CorsConfig corsConfig;

    @MockitoBean
    private UserProfileRepository userProfileRepository;

    private static MistakeResponse dueMistake(UUID id) {
        return new MistakeResponse(
                id,
                UUID.randomUUID(),
                null,
                "Binary",
                "Technology",
                "What is 1 + 1 in binary?",
                "b",
                List.of(new ChoiceOption("a", "One"), new ChoiceOption("b", "Ten")),
                "Binary 10 equals decimal 2.",
                "a",
                Instant.parse("2026-11-01T00:00:00Z"));
    }

    @Test
    void getDueMistakes_AuthenticatedUser_ReturnsDueMistakes() throws Exception {
        UUID userId = UUID.randomUUID();
        UUID mistakeId = UUID.randomUUID();
        when(mistakeService.getDueMistakes(userId)).thenReturn(List.of(dueMistake(mistakeId)));

        mockMvc.perform(get("/api/v1/me/mistakes/due")
                        .principal(new UsernamePasswordAuthenticationToken(userId.toString(), null)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(1))
                .andExpect(jsonPath("$[0].id").value(mistakeId.toString()))
                .andExpect(jsonPath("$[0].questionText").value("What is 1 + 1 in binary?"))
                .andExpect(jsonPath("$[0].choices[1].text").value("Ten"));
    }

    @Test
    void getDueMistakes_NothingDue_ReturnsEmptyList() throws Exception {
        UUID userId = UUID.randomUUID();
        when(mistakeService.getDueMistakes(userId)).thenReturn(List.of());

        mockMvc.perform(get("/api/v1/me/mistakes/due")
                        .principal(new UsernamePasswordAuthenticationToken(userId.toString(), null)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(0));
    }

    @Test
    void getDueMistakes_NonUuidSubject_ReturnsBadRequest() throws Exception {
        mockMvc.perform(get("/api/v1/me/mistakes/due")
                        .principal(new UsernamePasswordAuthenticationToken("not-a-uuid", null)))
                .andExpect(status().isBadRequest());

        verify(mistakeService, never()).getDueMistakes(any());
    }
}
