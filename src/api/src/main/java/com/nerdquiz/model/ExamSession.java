package com.nerdquiz.model;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "exam_sessions")
public class ExamSession {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "exam_id")
    private UUID examId;

    @Column(name = "total_questions", nullable = false)
    private Integer totalQuestions;

    @Column(name = "correct_answers", nullable = false)
    private Integer correctAnswers = 0;

    @Column(name = "score_percentage")
    private BigDecimal scorePercentage;

    @Column(name = "initial_hearts", nullable = false)
    private Integer initialHearts;

    @Column(name = "hearts_remaining", nullable = false)
    private Integer heartsRemaining;

    @Column(name = "time_limit_minutes", nullable = false)
    private Integer timeLimitMinutes;

    @Column(name = "started_at", nullable = false)
    private Instant startedAt = Instant.now();

    @Column(name = "expires_at", nullable = false)
    private Instant expiresAt;

    @Column(name = "completed_at")
    private Instant completedAt;

    @Column(nullable = false)
    private String status = "in_progress";

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public UUID getUserId() { return userId; }
    public void setUserId(UUID userId) { this.userId = userId; }

    public UUID getExamId() { return examId; }
    public void setExamId(UUID examId) { this.examId = examId; }

    public Integer getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(Integer totalQuestions) { this.totalQuestions = totalQuestions; }

    public Integer getCorrectAnswers() { return correctAnswers; }
    public void setCorrectAnswers(Integer correctAnswers) { this.correctAnswers = correctAnswers; }

    public BigDecimal getScorePercentage() { return scorePercentage; }
    public void setScorePercentage(BigDecimal scorePercentage) { this.scorePercentage = scorePercentage; }

    public Integer getInitialHearts() { return initialHearts; }
    public void setInitialHearts(Integer initialHearts) { this.initialHearts = initialHearts; }

    public Integer getHeartsRemaining() { return heartsRemaining; }
    public void setHeartsRemaining(Integer heartsRemaining) { this.heartsRemaining = heartsRemaining; }

    public Integer getTimeLimitMinutes() { return timeLimitMinutes; }
    public void setTimeLimitMinutes(Integer timeLimitMinutes) { this.timeLimitMinutes = timeLimitMinutes; }

    public Instant getStartedAt() { return startedAt; }
    public void setStartedAt(Instant startedAt) { this.startedAt = startedAt; }

    public Instant getExpiresAt() { return expiresAt; }
    public void setExpiresAt(Instant expiresAt) { this.expiresAt = expiresAt; }

    public Instant getCompletedAt() { return completedAt; }
    public void setCompletedAt(Instant completedAt) { this.completedAt = completedAt; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
