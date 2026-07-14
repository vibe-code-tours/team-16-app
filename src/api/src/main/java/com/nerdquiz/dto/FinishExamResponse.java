package com.nerdquiz.dto;

import java.math.BigDecimal;
import java.util.UUID;

public record FinishExamResponse(
    UUID sessionId,
    Integer totalQuestions,
    Integer correctAnswers,
    BigDecimal scorePercentage,
    Integer heartsRemaining,
    String status,
    Integer xpEarned
) {}
