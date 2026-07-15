package com.nerdquiz.model;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "quiz_session_questions", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"quiz_session_id", "question_id"}),
    @UniqueConstraint(columnNames = {"quiz_session_id", "sequence_number"})
})
public class QuizSessionQuestion {

    @EmbeddedId
    private QuizSessionQuestionId id;

    @Column(name = "sequence_number", nullable = false)
    private Integer sequenceNumber;

    public QuizSessionQuestion() {}

    public QuizSessionQuestion(UUID quizSessionId, UUID questionId, Integer sequenceNumber) {
        this.id = new QuizSessionQuestionId(quizSessionId, questionId);
        this.sequenceNumber = sequenceNumber;
    }

    public QuizSessionQuestionId getId() { return id; }
    public void setId(QuizSessionQuestionId id) { this.id = id; }

    public Integer getSequenceNumber() { return sequenceNumber; }
    public void setSequenceNumber(Integer sequenceNumber) { this.sequenceNumber = sequenceNumber; }

    public UUID getQuizSessionId() { return id.getQuizSessionId(); }
    public UUID getQuestionId() { return id.getQuestionId(); }
}
