package com.nerdquiz.controller;

import com.nerdquiz.dto.MistakeResponse;
import com.nerdquiz.dto.RecordMistakeRequest;
import com.nerdquiz.service.MistakeService;
import com.nerdquiz.util.UuidUtil;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/mistakes")
public class MistakeController {

    private final MistakeService mistakeService;

    public MistakeController(MistakeService mistakeService) {
        this.mistakeService = mistakeService;
    }

    @PostMapping
    public ResponseEntity<MistakeResponse> recordMistake(
            Authentication authentication,
            @Valid @RequestBody RecordMistakeRequest request) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(mistakeService.recordMistake(userId.get(), request));
    }
}
