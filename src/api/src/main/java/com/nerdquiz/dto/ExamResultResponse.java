package com.nerdquiz.dto;

import java.util.List;
import java.util.UUID;

public record ExamResultResponse(
    UUID sessionId,
    Integer totalQuestions,
    Integer answeredQuestions,
    Integer correctAnswers,
    Double scorePercentage,
    Integer xpEarned,
    Boolean passed,
    Integer heartsRemaining,
    List<ExamAnswerDetail> answers
) {
    public record ExamAnswerDetail(
        UUID questionId,
        Integer questionNumber,
        String questionText,
        String userAnswer,
        String correctAnswer,
        Boolean isCorrect,
        String explanation
    ) {}
}
