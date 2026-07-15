package com.nerdquiz.controller;

import com.nerdquiz.dto.MistakeResponse;
import com.nerdquiz.service.MistakeService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/me/mistakes")
public class UserMistakeController {

    private final MistakeService mistakeService;

    public UserMistakeController(MistakeService mistakeService) {
        this.mistakeService = mistakeService;
    }

    @GetMapping
    public ResponseEntity<List<MistakeResponse>> getUserMistakes(Authentication authentication) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(mistakeService.getUserMistakes(userId));
    }

    @PutMapping("/{id}/review")
    public ResponseEntity<Void> reviewMistake(
            Authentication authentication,
            @PathVariable UUID id) {
        UUID userId = UUID.fromString(authentication.getName());
        mistakeService.reviewMistake(userId, id);
        return ResponseEntity.ok().build();
    }
}
