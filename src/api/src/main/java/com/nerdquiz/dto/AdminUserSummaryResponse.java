package com.nerdquiz.dto;

import java.time.Instant;
import java.util.UUID;

public record AdminUserSummaryResponse(
    UUID id,
    String displayName,
    String email,
    String avatarUrl,
    String role,
    String status,
    Integer totalXp,
    Integer streakCount,
    Instant lastLoginAt,
    Instant createdAt
) {}
