package com.nerdquiz.model;

import jakarta.persistence.*;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "exams")
public class Exam {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "exam_session", nullable = false)
    private String examSession;

    @Column(nullable = false)
    private String subject;

    @Column(nullable = false)
    private String title;

    @Column(name = "question_count", nullable = false)
    private Integer questionCount;

    @Column(name = "time_limit_minutes", nullable = false)
    private Integer timeLimitMinutes;

    @Column(name = "initial_hearts", nullable = false)
    private Integer initialHearts = 5;

    @Column(nullable = false)
    private Boolean published = false;

    @Column(name = "created_at")
    private Instant createdAt = Instant.now();

    @Column(name = "updated_at")
    private Instant updatedAt = Instant.now();

    public Exam() {}

    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getExamSession() { return examSession; }
    public void setExamSession(String examSession) { this.examSession = examSession; }

    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Integer getQuestionCount() { return questionCount; }
    public void setQuestionCount(Integer questionCount) { this.questionCount = questionCount; }

    public Integer getTimeLimitMinutes() { return timeLimitMinutes; }
    public void setTimeLimitMinutes(Integer timeLimitMinutes) { this.timeLimitMinutes = timeLimitMinutes; }

    public Integer getInitialHearts() { return initialHearts; }
    public void setInitialHearts(Integer initialHearts) { this.initialHearts = initialHearts; }

    public Boolean getPublished() { return published; }
    public void setPublished(Boolean published) { this.published = published; }

    public Instant getCreatedAt() { return createdAt; }
    public void setCreatedAt(Instant createdAt) { this.createdAt = createdAt; }

    public Instant getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Instant updatedAt) { this.updatedAt = updatedAt; }
}
