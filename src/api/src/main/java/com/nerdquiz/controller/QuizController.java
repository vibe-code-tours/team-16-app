package com.nerdquiz.controller;

import com.nerdquiz.dto.*;
import com.nerdquiz.service.QuizService;
import com.nerdquiz.util.UuidUtil;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
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
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(quizService.startQuiz(userId.get(), request));
    }

    @PostMapping("/{sessionId}/answers")
    public ResponseEntity<QuizAnswerResponse> submitAnswer(
            Authentication authentication,
            @PathVariable UUID sessionId,
            @Valid @RequestBody SubmitAnswerRequest request) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        QuizAnswerResponse answer = quizService.submitAnswer(userId.get(), sessionId, request);
        return ResponseEntity.ok(answer);
    }

    @GetMapping("/{sessionId}/result")
    public ResponseEntity<QuizResultResponse> getResult(
            Authentication authentication,
            @PathVariable UUID sessionId) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(quizService.getResult(userId.get(), sessionId));
    }
}
