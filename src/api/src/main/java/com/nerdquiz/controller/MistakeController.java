package com.nerdquiz.controller;

import com.nerdquiz.dto.MistakeResponse;
import com.nerdquiz.service.MistakeService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/me/mistakes")
public class MistakeController {

    private final MistakeService mistakeService;

    public MistakeController(MistakeService mistakeService) {
        this.mistakeService = mistakeService;
    }

    @GetMapping
    public ResponseEntity<List<MistakeResponse>> getMistakes(Authentication authentication) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(mistakeService.getMistakes(userId));
    }

    @PostMapping
    public ResponseEntity<MistakeResponse> addMistake(
            Authentication authentication,
            @Valid @RequestBody AddMistakeRequest request) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(mistakeService.addMistake(
                userId,
                request.questionId(),
                request.source(),
                request.sourceSessionId(),
                request.userAnswer()
        ));
    }

    @PutMapping("/{id}/review")
    public ResponseEntity<MistakeResponse> markReviewed(
            Authentication authentication,
            @PathVariable UUID id) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(mistakeService.markReviewed(userId, id));
    }

    public record AddMistakeRequest(
        UUID questionId,
        String source,
        UUID sourceSessionId,
        String userAnswer
    ) {}
}
