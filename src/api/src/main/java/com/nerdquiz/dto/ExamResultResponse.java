package com.nerdquiz.dto;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

public record ExamResultResponse(
    UUID sessionId,
    Integer totalQuestions,
    Integer correctAnswers,
    BigDecimal scorePercentage,
    Integer xpEarned,
    String status,
    Boolean passed,
    List<ExamAnswerDetail> answers
) {
    public record ExamAnswerDetail(
        UUID questionId,
        String questionText,
        String userAnswer,
        String correctAnswer,
        Boolean isCorrect,
        String explanation
    ) {}
}
