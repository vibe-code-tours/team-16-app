package com.nerdquiz.controller;

import com.nerdquiz.config.CorsConfig;
import com.nerdquiz.config.JwtUtil;
import com.nerdquiz.dto.QuestionResponse;
import com.nerdquiz.service.QuestionService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

import java.util.List;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(QuestionController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class QuestionControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private QuestionService questionService;

    @MockitoBean
    private JwtUtil jwtUtil;

    @MockitoBean
    private CorsConfig corsConfig;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void getRandomQuestions_ReturnsQuestions() throws Exception {
        // Arrange
        QuestionResponse question = new QuestionResponse(
            UUID.randomUUID(),
            "2025-october",
            "A",
            1,
            "What is 2 + 2?",
            objectMapper.readTree("[]"),
            objectMapper.readTree("[{\"label\":\"a\",\"text\":\"3\"},{\"label\":\"b\",\"text\":\"4\"}]"),
            "b",
            null,
            "easy"
        );
        when(questionService.getRandomQuestions(anyInt()))
                .thenReturn(List.of(question));

        // Act & Assert
        mockMvc.perform(get("/api/v1/questions/random").param("count", "5"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].questionText").value("What is 2 + 2?"))
                .andExpect(jsonPath("$[0].correctAnswer").value("b"));
    }

    @Test
    void getRandomQuestions_EmptyList_ReturnsEmptyArray() throws Exception {
        // Arrange
        when(questionService.getRandomQuestions(anyInt()))
                .thenReturn(List.of());

        // Act & Assert
        mockMvc.perform(get("/api/v1/questions/random"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$").isEmpty());
    }
}
