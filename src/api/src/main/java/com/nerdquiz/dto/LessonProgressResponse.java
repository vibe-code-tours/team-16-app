package com.nerdquiz.dto;

import java.time.Instant;
import java.util.UUID;

public record LessonProgressResponse(
    UUID id,
    UUID userId,
    UUID lessonId,
    Boolean completed,
    Instant completedAt,
    Instant createdAt,
    Instant updatedAt
) {}
