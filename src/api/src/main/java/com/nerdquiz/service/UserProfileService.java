package com.nerdquiz.service;

import com.nerdquiz.dto.UpdateUserProfileRequest;
import com.nerdquiz.dto.UserProfileResponse;
import com.nerdquiz.exception.UserProfileNotFoundException;
import com.nerdquiz.model.UserProfile;
import com.nerdquiz.repository.UserProfileRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.UUID;

@Service
public class UserProfileService {

    private final UserProfileRepository userProfileRepository;

    public UserProfileService(UserProfileRepository userProfileRepository) {
        this.userProfileRepository = userProfileRepository;
    }

    @Transactional
    public UserProfileResponse getProfile(UUID userId) {
        userProfileRepository.findById(userId).ifPresentOrElse(
                profile -> { /* already exists, nothing to do */ },
                () -> userProfileRepository.upsertProfile(userId, null, null, null, Instant.now())
        );
        UserProfile profile = userProfileRepository.findById(userId)
                .orElseThrow(() -> new IllegalStateException("Profile creation failed"));
        return toResponse(profile);
    }

    @Transactional
    public UserProfileResponse upsertProfile(UUID userId, String email, String displayName, String avatarUrl) {
        userProfileRepository.upsertProfile(userId, email, displayName, avatarUrl, Instant.now());

        UserProfile profile = userProfileRepository.findById(userId)
                .orElseThrow(() -> new IllegalStateException("Upsert failed: profile not found after atomic insert"));
        return toResponse(profile);
    }

    @Transactional
    public UserProfileResponse updateProfile(UUID userId, UpdateUserProfileRequest request) {
        UserProfile profile = userProfileRepository.findById(userId)
                .orElseThrow(UserProfileNotFoundException::new);

        if (request.displayName() != null) {
            profile.setDisplayName(request.displayName());
        }
        if (request.avatarUrl() != null) {
            profile.setAvatarUrl(request.avatarUrl());
        }
        profile.setUpdatedAt(Instant.now());

        return toResponse(userProfileRepository.save(profile));
    }

    private UserProfileResponse toResponse(UserProfile profile) {
        return new UserProfileResponse(
            profile.getId(),
            profile.getDisplayName(),
            profile.getAvatarUrl(),
            profile.getEmail(),
            profile.getRole(),
            profile.getTotalXp(),
            profile.getStreakCount(),
            profile.getLongestStreak(),
            profile.getLastLoginAt(),
            profile.getCreatedAt(),
            profile.getUpdatedAt()
        );
    }
}
