package com.nerdquiz.dto;

import java.util.UUID;

public record SubmitExamAnswerResponse(
    UUID answerId,
    UUID questionId,
    String userAnswer,
    Boolean isCorrect,
    Integer heartsRemaining
) {}
