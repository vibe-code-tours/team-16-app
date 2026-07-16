package com.nerdquiz.dto;

import java.util.List;

public record AdminStatsResponse(
    long totalUsers,
    long activeToday,
    long activeThisWeek,
    long totalQuizAttempts,
    long totalExamAttempts,
    long totalQuizSessions,
    long totalExamSessions,
    double avgQuizScore,
    double avgExamScore,
    long examPassRate,
    long quizCompletionRate,
    List<TopicEngagementResponse> topicEngagement,
    List<DailyActiveUsersResponse> dailyActiveUsers
) {}
