package com.nerdquiz.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.Instant;
import java.util.Objects;
import java.util.UUID;

@Entity
@Table(name = "user_subtopic_mastery")
@IdClass(UserSubtopicMastery.PK.class)
public class UserSubtopicMastery {

    @Id
    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Id
    @Column(name = "subtopic_id", nullable = false)
    private UUID subtopicId;

    @Column(name = "questions_seen", nullable = false)
    private Integer questionsSeen = 0;

    @Column(name = "questions_correct", nullable = false)
    private Integer questionsCorrect = 0;

    @Column(name = "mastery_score", nullable = false)
    private java.math.BigDecimal masteryScore = java.math.BigDecimal.ZERO;

    @Column(name = "last_practiced_at")
    private Instant lastPracticedAt;

    public UserSubtopicMastery() {}

    public UUID getUserId() { return userId; }
    public void setUserId(UUID userId) { this.userId = userId; }

    public UUID getSubtopicId() { return subtopicId; }
    public void setSubtopicId(UUID subtopicId) { this.subtopicId = subtopicId; }

    public Integer getQuestionsSeen() { return questionsSeen; }
    public void setQuestionsSeen(Integer questionsSeen) { this.questionsSeen = questionsSeen; }

    public Integer getQuestionsCorrect() { return questionsCorrect; }
    public void setQuestionsCorrect(Integer questionsCorrect) { this.questionsCorrect = questionsCorrect; }

    public java.math.BigDecimal getMasteryScore() { return masteryScore; }
    public void setMasteryScore(java.math.BigDecimal masteryScore) { this.masteryScore = masteryScore; }

    public Instant getLastPracticedAt() { return lastPracticedAt; }
    public void setLastPracticedAt(Instant lastPracticedAt) { this.lastPracticedAt = lastPracticedAt; }

    public static class PK implements Serializable {
        private UUID userId;
        private UUID subtopicId;

        public PK() {}
        public PK(UUID userId, UUID subtopicId) {
            this.userId = userId;
            this.subtopicId = subtopicId;
        }

        public UUID getUserId() { return userId; }
        public void setUserId(UUID userId) { this.userId = userId; }

        public UUID getSubtopicId() { return subtopicId; }
        public void setSubtopicId(UUID subtopicId) { this.subtopicId = subtopicId; }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof PK pk)) return false;
            return Objects.equals(userId, pk.userId) && Objects.equals(subtopicId, pk.subtopicId);
        }

        @Override
        public int hashCode() {
            return Objects.hash(userId, subtopicId);
        }
    }
}
