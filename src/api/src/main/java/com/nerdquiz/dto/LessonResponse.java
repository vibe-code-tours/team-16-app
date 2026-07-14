package com.nerdquiz.dto;

import com.fasterxml.jackson.databind.JsonNode;

import java.time.Instant;
import java.util.UUID;

public record LessonResponse(
    UUID id,
    UUID subtopicId,
    String title,
    String slug,
    String summary,
    JsonNode contentBlocks,
    Integer estimatedMinutes,
    Integer xpReward,
    Integer displayOrder,
    Boolean published,
    Instant createdAt,
    Instant updatedAt
) {}
