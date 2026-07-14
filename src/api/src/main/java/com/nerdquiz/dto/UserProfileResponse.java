package com.nerdquiz.dto;

import java.time.Instant;
import java.util.UUID;

public record UserProfileResponse(
    UUID id,
    String displayName,
    String avatarUrl,
    String email,
    Integer totalXp,
    Integer streakCount,
    Integer longestStreak,
    Instant lastLoginAt,
    Instant createdAt,
    Instant updatedAt
) {}
