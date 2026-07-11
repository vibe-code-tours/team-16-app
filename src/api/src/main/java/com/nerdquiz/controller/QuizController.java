package com.nerdquiz.controller;

import com.nerdquiz.dto.*;
import com.nerdquiz.service.QuizService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/quizzes")
public class QuizController {

    private final QuizService quizService;

    public QuizController(QuizService quizService) {
        this.quizService = quizService;
    }

    @PostMapping("/start")
    public ResponseEntity<QuizSessionResponse> startQuiz(
            Authentication authentication,
            @Valid @RequestBody StartQuizRequest request) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(quizService.startQuiz(userId, request));
    }

    @PostMapping("/{sessionId}/answers")
    public ResponseEntity<QuizAnswerResponse> submitAnswer(
            Authentication authentication,
            @PathVariable UUID sessionId,
            @Valid @RequestBody SubmitAnswerRequest request) {
        UUID userId = UUID.fromString(authentication.getName());
        QuizAnswerResponse answer = quizService.submitAnswer(userId, sessionId, request);
        return ResponseEntity.ok(answer);
    }

    @GetMapping("/{sessionId}/result")
    public ResponseEntity<QuizResultResponse> getResult(
            Authentication authentication,
            @PathVariable UUID sessionId) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(quizService.getResult(userId, sessionId));
    }
}
