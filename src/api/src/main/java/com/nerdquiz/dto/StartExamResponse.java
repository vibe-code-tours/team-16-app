package com.nerdquiz.dto;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record StartExamResponse(
    UUID sessionId,
    List<ExamQuestionResponse> questions,
    Integer timeLimitMinutes,
    Instant expiresAt
) {}
