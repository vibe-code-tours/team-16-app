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
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

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

    @Test
    void getAvailableExams_ReturnsExams() throws Exception {
        ExamSummaryResponse exam = new ExamSummaryResponse(
            UUID.randomUUID(), "2021-april", "A", "2021 April FE Subject A",
            60, 150, 5
        );
        when(examService.getAvailableExams()).thenReturn(List.of(exam));

        mockMvc.perform(get("/api/v1/exams/sessions"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].examSession").value("2021-april"))
                .andExpect(jsonPath("$[0].subject").value("A"))
                .andExpect(jsonPath("$[0].questionCount").value(60));
    }

    @Test
    void getAvailableExams_EmptyList_ReturnsEmptyArray() throws Exception {
        when(examService.getAvailableExams()).thenReturn(List.of());

        mockMvc.perform(get("/api/v1/exams/sessions"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$").isArray())
                .andExpect(jsonPath("$").isEmpty());
    }

    @Test
    void startExam_ReturnsSession() throws Exception {
        ExamSessionResponse session = new ExamSessionResponse(
            UUID.randomUUID(), "2021-april", "A", "2021 April FE Subject A",
            List.of(new ExamQuestionResponse(
                UUID.randomUUID(), 1, "What is 2+2?",
                objectMapper.readTree("[]"),
                objectMapper.readTree("[{\"label\":\"a\",\"text\":\"3\"},{\"label\":\"b\",\"text\":\"4\"}]"),
                "easy", true
            )),
            60, 5, 5, 150,
            Instant.now().plus(150, ChronoUnit.MINUTES),
            "in_progress"
        );
        when(examService.startExam(any(UUID.class), any(StartExamRequest.class)))
                .thenReturn(session);

        mockMvc.perform(post("/api/v1/exams/start")
                        .contentType("application/json")
                        .content("{\"examSession\":\"2021-april\",\"subject\":\"A\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.examSession").value("2021-april"))
                .andExpect(jsonPath("$.subject").value("A"))
                .andExpect(jsonPath("$.status").value("in_progress"));
    }

    @Test
    void submitAnswer_ReturnsAnswerResult() throws Exception {
        ExamAnswerResponse answer = new ExamAnswerResponse(
            UUID.randomUUID(), "b", true, "b", "Basic arithmetic",
            5, false
        );
        when(examService.submitAnswer(any(UUID.class), any(UUID.class), any(SubmitExamAnswerRequest.class)))
                .thenReturn(answer);

        mockMvc.perform(post("/api/v1/exams/" + UUID.randomUUID() + "/answers")
                        .contentType("application/json")
                        .content("{\"questionId\":\"" + UUID.randomUUID() + "\",\"answer\":\"b\"}"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.isCorrect").value(true))
                .andExpect(jsonPath("$.heartsRemaining").value(5));
    }

    @Test
    void completeExam_ReturnsResults() throws Exception {
        ExamResultResponse result = new ExamResultResponse(
            UUID.randomUUID(), 60, 60, 50, 83.33,
            500, true, 3, List.of()
        );
        when(examService.completeExam(any(UUID.class), any(UUID.class)))
                .thenReturn(result);

        mockMvc.perform(post("/api/v1/exams/" + UUID.randomUUID() + "/complete"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.passed").value(true))
                .andExpect(jsonPath("$.scorePercentage").value(83.33));
    }

    @Test
    void getResult_ReturnsResults() throws Exception {
        ExamResultResponse result = new ExamResultResponse(
            UUID.randomUUID(), 60, 60, 50, 83.33,
            500, true, 3, List.of()
        );
        when(examService.getResult(any(UUID.class), any(UUID.class)))
                .thenReturn(result);

        mockMvc.perform(get("/api/v1/exams/" + UUID.randomUUID() + "/result"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.passed").value(true));
    }
}
