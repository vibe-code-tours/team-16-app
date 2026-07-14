package com.nerdquiz.dto;

import com.fasterxml.jackson.databind.JsonNode;
import java.time.Instant;
import java.util.UUID;

public record MistakeResponse(
    UUID id,
    UUID userId,
    UUID questionId,
    String questionText,
    String correctAnswer,
    JsonNode choices,
    String explanation,
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
