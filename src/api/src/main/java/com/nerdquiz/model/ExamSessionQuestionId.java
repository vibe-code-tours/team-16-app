package com.nerdquiz.model;

import jakarta.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;
import java.util.UUID;

@Embeddable
public class ExamSessionQuestionId implements Serializable {

    private UUID examSessionId;
    private UUID questionId;

    public ExamSessionQuestionId() {}

    public ExamSessionQuestionId(UUID examSessionId, UUID questionId) {
        this.examSessionId = examSessionId;
        this.questionId = questionId;
    }

    public UUID getExamSessionId() { return examSessionId; }
    public UUID getQuestionId() { return questionId; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ExamSessionQuestionId that = (ExamSessionQuestionId) o;
        return Objects.equals(examSessionId, that.examSessionId) &&
               Objects.equals(questionId, that.questionId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(examSessionId, questionId);
    }
}
