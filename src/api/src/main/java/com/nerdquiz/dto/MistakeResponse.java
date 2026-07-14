package com.nerdquiz.dto;

import java.time.Instant;
import java.util.UUID;

public record MistakeResponse(
    UUID id,
    UUID userId,
    UUID questionId,
    String questionText,
    String correctAnswer,
    String source,
    UUID sourceSessionId,
    String lastUserAnswer,
    Integer mistakeCount,
    Integer reviewCount,
    Instant firstMissedAt,
    Instant lastMissedAt,
    Instant lastReviewedAt,
    Instant nextReviewAt,
    Instant resolvedAt
) {}
