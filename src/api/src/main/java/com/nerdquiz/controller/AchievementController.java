package com.nerdquiz.controller;

import com.nerdquiz.dto.AchievementResponse;
import com.nerdquiz.service.AchievementService;
import com.nerdquiz.util.UuidUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

/**
 * Achievements for the authenticated user, derived on read from existing progress data.
 */
@RestController
@RequestMapping("/api/v1/me/achievements")
public class AchievementController {

    private final AchievementService achievementService;

    public AchievementController(AchievementService achievementService) {
        this.achievementService = achievementService;
    }

    /**
     * Returns the full achievement catalogue with the caller's unlock state and progress.
     */
    @GetMapping
    public ResponseEntity<List<AchievementResponse>> getAchievements(Authentication authentication) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(achievementService.getAchievements(userId.get()));
    }
}
