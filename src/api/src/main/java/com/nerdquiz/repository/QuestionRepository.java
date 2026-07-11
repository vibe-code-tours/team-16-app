package com.nerdquiz.repository;

import com.nerdquiz.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

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

    long countByExamSessionAndSubject(String examSession, String subject);
}
