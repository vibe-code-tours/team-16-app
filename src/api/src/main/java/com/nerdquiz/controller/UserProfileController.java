package com.nerdquiz.controller;

import com.nerdquiz.dto.UpdateUserProfileRequest;
import com.nerdquiz.dto.UpsertUserProfileRequest;
import com.nerdquiz.dto.UserProfileResponse;
import com.nerdquiz.service.UserProfileService;
import com.nerdquiz.util.UuidUtil;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;
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
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(userProfileService.getProfile(userId.get()));
    }

    @PostMapping
    public ResponseEntity<UserProfileResponse> upsertProfile(
            Authentication authentication,
            @Valid @RequestBody UpsertUserProfileRequest request) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(userProfileService.upsertProfile(
                userId.get(),
                request.email(),
                request.displayName(),
                request.avatarUrl()
        ));
    }

    @PutMapping
    public ResponseEntity<UserProfileResponse> updateProfile(
            Authentication authentication,
            @Valid @RequestBody UpdateUserProfileRequest request) {
        Optional<UUID> userId = UuidUtil.tryParse(authentication.getName());
        if (userId.isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        return ResponseEntity.ok(userProfileService.updateProfile(userId.get(), request));
    }
}
