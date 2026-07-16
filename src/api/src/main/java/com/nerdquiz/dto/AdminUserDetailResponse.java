package com.nerdquiz.dto;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record AdminUserDetailResponse(
    UUID id,
    String displayName,
    String email,
    String avatarUrl,
    String role,
    String status,
    Integer totalXp,
    Integer streakCount,
    Integer longestStreak,
    Instant lastLoginAt,
    Instant createdAt,
    long totalQuizzes,
    long completedQuizzes,
    double avgQuizScore,
    long totalExams,
    long completedExams,
    double avgExamScore,
    long examPassRate,
    List<RecentActivityResponse> recentActivity
) {}
