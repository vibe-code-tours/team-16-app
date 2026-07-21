package com.nerdquiz.controller;

import com.nerdquiz.dto.MistakeResponse;
import com.nerdquiz.service.MistakeService;
import com.nerdquiz.util.UuidUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
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
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(mistakeService.getUserMistakes(userId.get()));
    }

    @PutMapping("/{id}/review")
    public ResponseEntity<Void> reviewMistake(
            Authentication authentication,
            @PathVariable UUID id) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        mistakeService.reviewMistake(userId.get(), id);
        return ResponseEntity.ok().build();
    }
}
