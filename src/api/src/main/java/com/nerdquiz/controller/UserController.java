package com.nerdquiz.controller;

import com.nerdquiz.dto.IncrementXpRequest;
import com.nerdquiz.dto.StreakResponse;
import com.nerdquiz.dto.XpResponse;
import com.nerdquiz.service.UserService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;
import java.util.UUID;

/**
 * Example protected endpoint — returns the authenticated user's ID.
 * Verifies that JWT verification and SecurityContext are working.
 */
@RestController
@RequestMapping("/api/v1")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/me")
    public ResponseEntity<Map<String, String>> getCurrentUser(Authentication authentication) {
        String userId = (String) authentication.getPrincipal();
        return ResponseEntity.ok(Map.of(
                "user_id", userId
        ));
    }

    @PostMapping("/me/streak")
    public ResponseEntity<StreakResponse> updateStreak(Authentication authentication) {
        UUID userId = UUID.fromString(authentication.getName());
        int streakCount = userService.updateUserStreak(userId);
        return ResponseEntity.ok(new StreakResponse(streakCount));
    }

    @PostMapping("/me/xp")
    public ResponseEntity<XpResponse> incrementXp(
            Authentication authentication,
            @Valid @RequestBody IncrementXpRequest request) {
        UUID userId = UUID.fromString(authentication.getName());
        int totalXp = userService.incrementUserXp(userId, request.delta());
        return ResponseEntity.ok(new XpResponse(totalXp));
    }
}
