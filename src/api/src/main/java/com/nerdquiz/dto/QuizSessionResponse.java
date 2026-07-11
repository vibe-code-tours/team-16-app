package com.nerdquiz.dto;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record QuizSessionResponse(
    UUID id,
    List<QuestionResponse> questions,
    Integer currentIndex,
    Integer score,
    Integer xpEarned,
    Instant startedAt,
    Instant completedAt,
    String status
) {}
