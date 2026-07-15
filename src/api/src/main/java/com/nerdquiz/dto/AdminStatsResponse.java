package com.nerdquiz.dto;

import java.util.List;

public record AdminStatsResponse(
    long totalUsers,
    long activeToday,
    long activeThisWeek,
    long totalQuizAttempts,
    long totalExamAttempts,
    List<TopicEngagementResponse> topicEngagement
) {}
