package com.nerdquiz.dto;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record ExamSessionResponse(
    UUID sessionId,
    String examSession,
    String subject,
    String title,
    List<ExamQuestionResponse> questions,
    Integer totalQuestions,
    Integer heartsRemaining,
    Integer initialHearts,
    Integer timeLimitMinutes,
    Instant expiresAt,
    String status
) {}
