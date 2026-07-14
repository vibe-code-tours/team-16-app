package com.nerdquiz.repository;

import com.nerdquiz.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

/**
 * Aggregate lesson counts per subtopic — total published lessons and, for a given
 * user, how many have been completed. Used by the Learning Map to decide which
 * subtopics are unlocked.
 */
@Repository
public interface LessonRepository extends JpaRepository<Lesson, UUID> {

    List<Lesson> findBySubtopicIdAndPublishedTrueOrderByDisplayOrderAsc(UUID subtopicId);

    @Query(value = "SELECT l.subtopic_id AS subtopicId, COUNT(*) AS cnt " +
            "FROM lessons l " +
            "WHERE l.published = true " +
            "GROUP BY l.subtopic_id",
            nativeQuery = true)
    List<SubtopicLessonCount> countPublishedLessonsBySubtopic();

    @Query(value = "SELECT l.subtopic_id AS subtopicId, COUNT(*) AS cnt " +
            "FROM lessons l " +
            "JOIN user_lesson_progress ulp " +
            "  ON ulp.lesson_id = l.id AND ulp.user_id = :userId " +
            "WHERE l.published = true AND ulp.status = 'completed' " +
            "GROUP BY l.subtopic_id",
            nativeQuery = true)
    List<SubtopicLessonCount> countCompletedLessonsBySubtopicForUser(@Param("userId") UUID userId);

    interface SubtopicLessonCount {
        UUID getSubtopicId();
        Long getCnt();
    }
}
