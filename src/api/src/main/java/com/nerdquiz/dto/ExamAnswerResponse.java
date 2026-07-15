package com.nerdquiz.dto;

import java.util.UUID;

public record ExamAnswerResponse(
    UUID questionId,
    String userAnswer,
    Boolean isCorrect,
    String correctAnswer,
    String explanation,
    Integer heartsRemaining,
    Boolean examComplete
) {}
