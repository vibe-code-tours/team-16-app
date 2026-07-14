package com.nerdquiz.controller;

import com.nerdquiz.dto.UpdateUserProfileRequest;
import com.nerdquiz.dto.UpsertUserProfileRequest;
import com.nerdquiz.dto.UserProfileResponse;
import com.nerdquiz.service.UserProfileService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/v1/me/profile")
public class UserProfileController {

    private final UserProfileService userProfileService;

    public UserProfileController(UserProfileService userProfileService) {
        this.userProfileService = userProfileService;
    }

    @GetMapping
    public ResponseEntity<UserProfileResponse> getProfile(Authentication authentication) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(userProfileService.getProfile(userId));
    }

    @PostMapping
    public ResponseEntity<UserProfileResponse> upsertProfile(
            Authentication authentication,
            @RequestBody UpsertUserProfileRequest request) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(userProfileService.upsertProfile(
                userId,
                request.email(),
                request.displayName(),
                request.avatarUrl()
        ));
    }

    @PutMapping
    public ResponseEntity<UserProfileResponse> updateProfile(
            Authentication authentication,
            @Valid @RequestBody UpdateUserProfileRequest request) {
        UUID userId = UUID.fromString(authentication.getName());
        return ResponseEntity.ok(userProfileService.updateProfile(userId, request));
    }
}
