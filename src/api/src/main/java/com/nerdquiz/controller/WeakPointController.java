package com.nerdquiz.controller;

import com.nerdquiz.dto.WeakPointResponse;
import com.nerdquiz.service.WeakPointService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(weakPointService.getWeakPointAnalysis(userId));
    }
}
