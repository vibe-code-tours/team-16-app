package com.nerdquiz.dto;

import java.time.Instant;
import java.util.UUID;

public record QuizAnswerResponse(
    UUID id,
    UUID quizSessionId,
    UUID questionId,
    String userAnswer,
    Boolean isCorrect,
    Instant answeredAt
) {}
