package com.nerdquiz.model;

import jakarta.persistence.*;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "mistakes")
public class UserMistake {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "question_id", nullable = false)
    private UUID questionId;

    @Column(nullable = false)
    private String source;

    @Column(name = "source_session_id")
    private UUID sourceSessionId;

    @Column(name = "last_user_answer")
    private String lastUserAnswer;

    @Column(name = "mistake_count", nullable = false)
    private Integer mistakeCount = 1;

    @Column(name = "review_count", nullable = false)
    private Integer reviewCount = 0;

    @Column(name = "first_missed_at")
    private Instant firstMissedAt;

    @Column(name = "last_missed_at")
    private Instant lastMissedAt;

    @Column(name = "last_reviewed_at")
    private Instant lastReviewedAt;

    @Column(name = "next_review_at")
    private Instant nextReviewAt;

    @Column(name = "resolved_at")
    private Instant resolvedAt;

    // Constructors
    public UserMistake() {}

    // Getters and Setters
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public UUID getUserId() { return userId; }
    public void setUserId(UUID userId) { this.userId = userId; }

    public UUID getQuestionId() { return questionId; }
    public void setQuestionId(UUID questionId) { this.questionId = questionId; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }

    public UUID getSourceSessionId() { return sourceSessionId; }
    public void setSourceSessionId(UUID sourceSessionId) { this.sourceSessionId = sourceSessionId; }

    public String getLastUserAnswer() { return lastUserAnswer; }
    public void setLastUserAnswer(String lastUserAnswer) { this.lastUserAnswer = lastUserAnswer; }

    public Integer getMistakeCount() { return mistakeCount; }
    public void setMistakeCount(Integer mistakeCount) { this.mistakeCount = mistakeCount; }

    public Integer getReviewCount() { return reviewCount; }
    public void setReviewCount(Integer reviewCount) { this.reviewCount = reviewCount; }

    public Instant getFirstMissedAt() { return firstMissedAt; }
    public void setFirstMissedAt(Instant firstMissedAt) { this.firstMissedAt = firstMissedAt; }

    public Instant getLastMissedAt() { return lastMissedAt; }
    public void setLastMissedAt(Instant lastMissedAt) { this.lastMissedAt = lastMissedAt; }

    public Instant getLastReviewedAt() { return lastReviewedAt; }
    public void setLastReviewedAt(Instant lastReviewedAt) { this.lastReviewedAt = lastReviewedAt; }

    public Instant getNextReviewAt() { return nextReviewAt; }
    public void setNextReviewAt(Instant nextReviewAt) { this.nextReviewAt = nextReviewAt; }

    public Instant getResolvedAt() { return resolvedAt; }
    public void setResolvedAt(Instant resolvedAt) { this.resolvedAt = resolvedAt; }

}
