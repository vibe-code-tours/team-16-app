package com.nerdquiz.model;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "exam_session_questions", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"exam_session_id", "question_id"}),
    @UniqueConstraint(columnNames = {"exam_session_id", "sequence_number"})
})
public class ExamSessionQuestion {

    @EmbeddedId
    private ExamSessionQuestionId id;

    @Column(name = "sequence_number", nullable = false)
    private Integer sequenceNumber;

    public ExamSessionQuestion() {}

    public ExamSessionQuestion(UUID examSessionId, UUID questionId, Integer sequenceNumber) {
        this.id = new ExamSessionQuestionId(examSessionId, questionId);
        this.sequenceNumber = sequenceNumber;
    }

    public ExamSessionQuestionId getId() { return id; }
    public void setId(ExamSessionQuestionId id) { this.id = id; }

    public Integer getSequenceNumber() { return sequenceNumber; }
    public void setSequenceNumber(Integer sequenceNumber) { this.sequenceNumber = sequenceNumber; }

    public UUID getExamSessionId() { return id.getExamSessionId(); }
    public UUID getQuestionId() { return id.getQuestionId(); }
}
