package com.nerdquiz.service;

import com.nerdquiz.dto.UpdateUserProfileRequest;
import com.nerdquiz.dto.UserProfileResponse;
import com.nerdquiz.exception.UserProfileNotFoundException;
import com.nerdquiz.model.UserProfile;
import com.nerdquiz.repository.UserProfileRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserProfileService {

    private final UserProfileRepository userProfileRepository;

    public UserProfileService(UserProfileRepository userProfileRepository) {
        this.userProfileRepository = userProfileRepository;
    }

    @Transactional
    public UserProfileResponse getProfile(UUID userId) {
        UserProfile profile = userProfileRepository.findById(userId)
                .orElseGet(() -> createDefaultProfile(userId));
        return toResponse(profile);
    }

    @Transactional
    public UserProfileResponse upsertProfile(UUID userId, String email, String displayName, String avatarUrl) {
        Optional<UserProfile> existing = userProfileRepository.findById(userId);

        UserProfile profile;
        if (existing.isPresent()) {
            profile = existing.get();
            if (email != null) {
                profile.setEmail(email);
            }
            if (displayName != null) {
                profile.setDisplayName(displayName);
            }
            if (avatarUrl != null) {
                profile.setAvatarUrl(avatarUrl);
            }
            profile.setUpdatedAt(Instant.now());
        } else {
            profile = createDefaultProfile(userId);
            if (email != null) {
                profile.setEmail(email);
            }
            if (displayName != null) {
                profile.setDisplayName(displayName);
            }
            if (avatarUrl != null) {
                profile.setAvatarUrl(avatarUrl);
            }
        }

        return toResponse(userProfileRepository.save(profile));
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

    private UserProfile createDefaultProfile(UUID userId) {
        UserProfile profile = new UserProfile();
        profile.setId(userId);
        profile.setEmail("");
        profile.setTotalXp(0);
        profile.setStreakCount(0);
        return userProfileRepository.save(profile);
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
            null,
            profile.getLastLoginAt(),
            profile.getCreatedAt(),
            profile.getUpdatedAt()
        );
    }
}
