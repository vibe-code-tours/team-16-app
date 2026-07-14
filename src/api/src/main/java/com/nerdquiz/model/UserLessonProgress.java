package com.nerdquiz.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.Instant;
import java.util.Objects;
import java.util.UUID;

@Entity
@Table(name = "user_lesson_progress")
@IdClass(UserLessonProgress.PK.class)
public class UserLessonProgress {

    @Id
    @Column(name = "user_id")
    private UUID userId;

    @Id
    @Column(name = "lesson_id")
    private UUID lessonId;

    @Column(nullable = false)
    private String status = "locked";

    @Column(name = "started_at")
    private Instant startedAt;

    @Column(name = "completed_at")
    private Instant completedAt;

    public UserLessonProgress() {}

    public UUID getUserId() { return userId; }
    public void setUserId(UUID userId) { this.userId = userId; }

    public UUID getLessonId() { return lessonId; }
    public void setLessonId(UUID lessonId) { this.lessonId = lessonId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Instant getStartedAt() { return startedAt; }
    public void setStartedAt(Instant startedAt) { this.startedAt = startedAt; }

    public Instant getCompletedAt() { return completedAt; }
    public void setCompletedAt(Instant completedAt) { this.completedAt = completedAt; }

    public static class PK implements Serializable {
        private UUID userId;
        private UUID lessonId;

        public PK() {}
        public PK(UUID userId, UUID lessonId) {
            this.userId = userId;
            this.lessonId = lessonId;
        }

        public UUID getUserId() { return userId; }
        public void setUserId(UUID userId) { this.userId = userId; }
        public UUID getLessonId() { return lessonId; }
        public void setLessonId(UUID lessonId) { this.lessonId = lessonId; }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof PK)) return false;
            PK pk = (PK) o;
            return Objects.equals(userId, pk.userId) && Objects.equals(lessonId, pk.lessonId);
        }

        @Override
        public int hashCode() {
            return Objects.hash(userId, lessonId);
        }
    }
}
