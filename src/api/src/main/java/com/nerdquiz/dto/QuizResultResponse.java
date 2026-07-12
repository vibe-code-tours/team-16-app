package com.nerdquiz.dto;

import java.util.List;
import java.util.UUID;

public record QuizResultResponse(
    UUID sessionId,
    Integer totalQuestions,
    Integer correctAnswers,
    Integer scorePercentage,
    Integer xpEarned,
    List<AnswerResult> answers
) {
    public record AnswerResult(
        QuestionResponse question,
        String userAnswer,
        Boolean isCorrect
    ) {}
}
