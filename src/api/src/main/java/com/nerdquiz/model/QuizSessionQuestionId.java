package com.nerdquiz.model;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;
import java.util.UUID;

@Embeddable
public class QuizSessionQuestionId implements Serializable {

    private UUID quizSessionId;
    private UUID questionId;

    public QuizSessionQuestionId() {}

    public QuizSessionQuestionId(UUID quizSessionId, UUID questionId) {
        this.quizSessionId = quizSessionId;
        this.questionId = questionId;
    }

    public UUID getQuizSessionId() { return quizSessionId; }
    public UUID getQuestionId() { return questionId; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        QuizSessionQuestionId that = (QuizSessionQuestionId) o;
        return Objects.equals(quizSessionId, that.quizSessionId)
            && Objects.equals(questionId, that.questionId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(quizSessionId, questionId);
    }
}
