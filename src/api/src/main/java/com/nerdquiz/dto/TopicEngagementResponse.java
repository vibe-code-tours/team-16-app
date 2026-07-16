package com.nerdquiz.dto;

public record TopicEngagementResponse(
    String topicName,
    long quizCount,
    double avgScore
) {}
