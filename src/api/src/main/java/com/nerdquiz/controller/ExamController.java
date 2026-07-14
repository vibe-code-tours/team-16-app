package com.nerdquiz.controller;

import com.nerdquiz.annotation.Public;
import com.nerdquiz.dto.*;
import com.nerdquiz.service.ExamService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/exams")
public class ExamController {

    private final ExamService examService;

    public ExamController(ExamService examService) {
        this.examService = examService;
    }

    @Public
    @GetMapping("/sessions")
    public ResponseEntity<List<ExamSummaryResponse>> getAvailableExams() {
        return ResponseEntity.ok(examService.getAvailableExams());
    }

    @PostMapping("/start")
    public ResponseEntity<ExamSessionResponse> startExam(
            Authentication authentication,
            @Valid @RequestBody StartExamRequest request) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(examService.startExam(userId, request));
    }

    @PostMapping("/{sessionId}/answers")
    public ResponseEntity<ExamAnswerResponse> submitAnswer(
            Authentication authentication,
            @PathVariable UUID sessionId,
            @Valid @RequestBody SubmitExamAnswerRequest request) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(examService.submitAnswer(userId, sessionId, request));
    }

    @PostMapping("/{sessionId}/complete")
    public ResponseEntity<ExamResultResponse> completeExam(
            Authentication authentication,
            @PathVariable UUID sessionId) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(examService.completeExam(userId, sessionId));
    }

    @GetMapping("/{sessionId}/result")
    public ResponseEntity<ExamResultResponse> getResult(
            Authentication authentication,
            @PathVariable UUID sessionId) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(examService.getResult(userId, sessionId));
    }
}
