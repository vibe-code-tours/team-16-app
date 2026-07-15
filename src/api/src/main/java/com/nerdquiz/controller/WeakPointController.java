package com.nerdquiz.controller;

import com.nerdquiz.dto.RecordPracticeAnswerRequest;
import com.nerdquiz.dto.WeakPointResponse;
import com.nerdquiz.service.WeakPointService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/me")
public class WeakPointController {

    private final WeakPointService weakPointService;

    public WeakPointController(WeakPointService weakPointService) {
        this.weakPointService = weakPointService;
    }

    @GetMapping("/weak-points")
    public ResponseEntity<WeakPointResponse> getWeakPointAnalysis(Authentication authentication) {
        UUID userId;
        try {
            userId = UUID.fromString(authentication.getName());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(weakPointService.getWeakPointAnalysis(userId));
    }

    @PostMapping("/weak-points/answers")
    public ResponseEntity<Map<String, Boolean>> recordPracticeAnswer(
            Authentication authentication,
            @Valid @RequestBody RecordPracticeAnswerRequest request) {
        UUID userId = UUID.fromString(authentication.getName());
        weakPointService.recordPracticeAnswer(userId, request.questionId(), request.selectedLabel());
        return ResponseEntity.ok(Map.of("recorded", true));
    }
}
