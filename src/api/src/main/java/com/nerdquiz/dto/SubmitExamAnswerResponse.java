package com.nerdquiz.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.UUID;

public record SubmitExamAnswerResponse(
    UUID answerId,
    UUID questionId,
    String userAnswer,
    @JsonIgnore Boolean isCorrect,
    @JsonIgnore String correctAnswer,
    @JsonIgnore String explanation
) {
    public SubmitExamAnswerResponse(UUID answerId, UUID questionId, String userAnswer) {
        this(answerId, questionId, userAnswer, null, null, null);
    }
}
