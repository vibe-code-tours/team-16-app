package com.nerdquiz.repository;

import com.nerdquiz.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.UUID;

@Repository
public interface QuestionRepository extends JpaRepository<Question, UUID> {

    List<Question> findByExamSessionAndSubject(String examSession, String subject);

    @Query("SELECT q FROM Question q WHERE q.subtopicId = :subtopicId ORDER BY FUNCTION('RANDOM')")
    List<Question> findRandomBySubtopicId(@Param("subtopicId") UUID subtopicId);

    @Query("SELECT q FROM Question q ORDER BY FUNCTION('RANDOM') LIMIT :limit")
    List<Question> findRandomQuestions(@Param("limit") int limit);

    @Query("SELECT q FROM Question q WHERE q.subtopicId = :subtopicId ORDER BY FUNCTION('RANDOM') LIMIT :limit")
    List<Question> findRandomBySubtopicIdLimit(@Param("subtopicId") UUID subtopicId, @Param("limit") int limit);

    @Query("SELECT q FROM Question q WHERE q.difficulty = :difficulty ORDER BY FUNCTION('RANDOM') LIMIT :limit")
    List<Question> findRandomByDifficulty(@Param("difficulty") String difficulty, @Param("limit") int limit);

    @Query(value = "SELECT * FROM questions " +
            "WHERE subtopic_id = :subtopicId " +
            "  AND subject = 'A' " +
            "  AND published = true " +
            "  AND jsonb_array_length(choices) > 0 " +
            "  AND correct_answer ~ '^[a-z]$' " +
            "ORDER BY random() " +
            "LIMIT :count",
            nativeQuery = true)
    List<Question> findUsableQuizBySubtopic(@Param("subtopicId") UUID subtopicId, @Param("count") int count);

    long countByExamSessionAndSubject(String examSession, String subject);

    List<Question> findByIdIn(Collection<UUID> ids);

    @Query(value = "SELECT subtopic_id AS subtopicId, COUNT(*) AS cnt " +
            "FROM questions " +
            "WHERE published = true AND subtopic_id IS NOT NULL " +
            "GROUP BY subtopic_id",
            nativeQuery = true)
    List<SubtopicQuestionCount> countPublishedGroupedBySubtopic();

    interface SubtopicQuestionCount {
        UUID getSubtopicId();
        Long getCnt();
    }
}
