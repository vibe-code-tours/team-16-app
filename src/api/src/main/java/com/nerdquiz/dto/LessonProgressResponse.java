package com.nerdquiz.dto;

import java.time.Instant;
import java.util.UUID;

public record LessonProgressResponse(
    UUID userId,
    UUID lessonId,
    String status,
    Instant startedAt,
    Instant completedAt
) {}
