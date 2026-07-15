package com.nerdquiz.controller;

import com.nerdquiz.config.CorsConfig;
import com.nerdquiz.config.JwtUtil;
import com.nerdquiz.dto.*;
import com.nerdquiz.service.ExamService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

import java.math.BigDecimal;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.UUID;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(ExamController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {"supabase.url=https://test.supabase.co"})
class ExamControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockitoBean
    private ExamService examService;

    @MockitoBean
    private JwtUtil jwtUtil;

    @MockitoBean
    private CorsConfig corsConfig;

    @Autowired
    private ObjectMapper objectMapper;

    private UsernamePasswordAuthenticationToken authenticatedUser() {
        return new UsernamePasswordAuthenticationToken(UUID.randomUUID().toString(), null);
    }

    @Test
    void startExam_ReturnsSession() throws Exception {
        UUID questionId = UUID.randomUUID();
        StartExamResponse response = new StartExamResponse(
            UUID.randomUUID(),
            List.of(new QuestionResponse(
                questionId, null, "2021-april", "A", 1,
                "What is 2+2?",
                objectMapper.readTree("[]"),
                objectMapper.readTree("[{\"label\":\"a\",\"text\":\"3\"},{\"label\":\"b\",\"text\":\"4\"}]"),
                "b", null, "easy"
            )),
            3, 60,
            Instant.now().plus(60, ChronoUnit.MINUTES)
        );
        when(examService.startExam(any(UUID.class), any(StartExamRequest.class)))
                .thenReturn(response);

        mockMvc.perform(post("/api/v1/exams/start")
                        .principal(authenticatedUser())
                        .contentType("application/json")
                        .content("{\"questionCount\":60,\"difficulty\":\"medium\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.questions").isArray())
                .andExpect(jsonPath("$.heartsRemaining").value(3))
                .andExpect(jsonPath("$.timeLimitMinutes").value(60));
    }

    @Test
    void startExam_InvalidDifficulty_ReturnsBadRequest() throws Exception {
        when(examService.startExam(any(UUID.class), any(StartExamRequest.class)))
                .thenThrow(new IllegalArgumentException("Invalid difficulty"));

        mockMvc.perform(post("/api/v1/exams/start")
                        .principal(authenticatedUser())
                        .contentType("application/json")
                        .content("{\"questionCount\":10,\"difficulty\":\"impossible\"}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    void submitAnswer_ReturnsAnswerResult() throws Exception {
        UUID questionId = UUID.randomUUID();
        SubmitExamAnswerResponse response = new SubmitExamAnswerResponse(
            UUID.randomUUID(), questionId, "b", true, 5
        );
        when(examService.submitAnswer(any(UUID.class), any(UUID.class), any(SubmitExamAnswerRequest.class)))
                .thenReturn(response);

        mockMvc.perform(post("/api/v1/exams/" + UUID.randomUUID() + "/answers")
                        .principal(authenticatedUser())
                        .contentType("application/json")
                        .content("{\"questionId\":\"" + questionId + "\",\"sequenceNumber\":1,\"answer\":\"b\",\"responseTimeMs\":5000}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.isCorrect").value(true))
                .andExpect(jsonPath("$.heartsRemaining").value(5));
    }

    @Test
    void submitAnswer_WrongAnswer_DecreasesHearts() throws Exception {
        UUID questionId = UUID.randomUUID();
        SubmitExamAnswerResponse response = new SubmitExamAnswerResponse(
            UUID.randomUUID(), questionId, "a", false, 4
        );
        when(examService.submitAnswer(any(UUID.class), any(UUID.class), any(SubmitExamAnswerRequest.class)))
                .thenReturn(response);

        mockMvc.perform(post("/api/v1/exams/" + UUID.randomUUID() + "/answers")
                        .principal(authenticatedUser())
                        .contentType("application/json")
                        .content("{\"questionId\":\"" + questionId + "\",\"sequenceNumber\":1,\"answer\":\"a\",\"responseTimeMs\":3000}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.isCorrect").value(false))
                .andExpect(jsonPath("$.heartsRemaining").value(4));
    }

    @Test
    void submitAnswer_MissingFields_ReturnsBadRequest() throws Exception {
        mockMvc.perform(post("/api/v1/exams/" + UUID.randomUUID() + "/answers")
                        .principal(authenticatedUser())
                        .contentType("application/json")
                        .content("{}"))
                .andExpect(status().isBadRequest());
    }

    @Test
    void finishExam_ReturnsResults() throws Exception {
        FinishExamResponse response = new FinishExamResponse(
            UUID.randomUUID(), 60, 50,
            BigDecimal.valueOf(83.33), 3, "completed", 500
        );
        when(examService.finishExam(any(UUID.class), any(UUID.class), any(FinishExamRequest.class)))
                .thenReturn(response);

        mockMvc.perform(post("/api/v1/exams/" + UUID.randomUUID() + "/finish")
                        .principal(authenticatedUser())
                        .contentType("application/json")
                        .content("{\"status\":\"completed\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("completed"))
                .andExpect(jsonPath("$.correctAnswers").value(50))
                .andExpect(jsonPath("$.xpEarned").value(500));
    }

    @Test
    void finishExam_Abandoned_NoXp() throws Exception {
        FinishExamResponse response = new FinishExamResponse(
            UUID.randomUUID(), 60, 30,
            BigDecimal.valueOf(50.00), 2, "abandoned", 0
        );
        when(examService.finishExam(any(UUID.class), any(UUID.class), any(FinishExamRequest.class)))
                .thenReturn(response);

        mockMvc.perform(post("/api/v1/exams/" + UUID.randomUUID() + "/finish")
                        .principal(authenticatedUser())
                        .contentType("application/json")
                        .content("{\"status\":\"abandoned\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("abandoned"))
                .andExpect(jsonPath("$.xpEarned").value(0));
    }
}
