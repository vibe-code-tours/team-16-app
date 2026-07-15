package com.nerdquiz.repository;

import com.nerdquiz.model.UserSubtopicMastery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserSubtopicMasteryRepository
        extends JpaRepository<UserSubtopicMastery, UserSubtopicMastery.PK> {

    List<UserSubtopicMastery> findByUserId(UUID userId);

    Optional<UserSubtopicMastery> findByUserIdAndSubtopicId(UUID userId, UUID subtopicId);

    @Query(value = """
            SELECT t.id AS topicId, t.name AS topicName, t.slug AS topicSlug,
                   COALESCE(AVG(m.mastery_score), 0) AS masteryScore,
                   COALESCE(SUM(m.questions_seen), 0) AS questionsSeen,
                   COALESCE(SUM(m.questions_correct), 0) AS questionsCorrect
            FROM user_subtopic_mastery m
            JOIN subtopics s ON s.id = m.subtopic_id
            JOIN topics t ON t.id = s.topic_id
            WHERE m.user_id = :userId
            GROUP BY t.id, t.name, t.slug, t.display_order
            ORDER BY t.display_order ASC
            """, nativeQuery = true)
    List<TopicMasteryProjection> findTopicMasteryByUserId(@Param("userId") UUID userId);

    @Query(value = """
            SELECT s.id AS subtopicId, s.topic_id AS topicId, s.name AS subtopicName,
                   s.slug AS subtopicSlug, s.display_order AS displayOrder,
                   COALESCE(m.mastery_score, 0) AS masteryScore,
                   COALESCE(m.questions_seen, 0) AS questionsSeen,
                   COALESCE(m.questions_correct, 0) AS questionsCorrect
            FROM subtopics s
            JOIN topics t ON t.id = s.topic_id
            LEFT JOIN user_subtopic_mastery m ON m.subtopic_id = s.id AND m.user_id = :userId
            WHERE s.published = true AND t.published = true
            ORDER BY t.display_order ASC, s.display_order ASC
            """, nativeQuery = true)
    List<SubtopicMasteryProjection> findAllSubtopicMasteryByUserId(@Param("userId") UUID userId);

    interface TopicMasteryProjection {
        UUID getTopicId();
        String getTopicName();
        String getTopicSlug();
        Double getMasteryScore();
        Long getQuestionsSeen();
        Long getQuestionsCorrect();
    }

    interface SubtopicMasteryProjection {
        UUID getSubtopicId();
        UUID getTopicId();
        String getSubtopicName();
        String getSubtopicSlug();
        Integer getDisplayOrder();
        Double getMasteryScore();
        Long getQuestionsSeen();
        Long getQuestionsCorrect();
    }
}
