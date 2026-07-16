package com.nerdquiz.repository;

import com.nerdquiz.model.QuizSessionQuestion;
import com.nerdquiz.model.QuizSessionQuestionId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface QuizSessionQuestionRepository extends JpaRepository<QuizSessionQuestion, QuizSessionQuestionId> {

    @Query("SELECT q FROM QuizSessionQuestion q WHERE q.id.quizSessionId = :quizSessionId ORDER BY q.sequenceNumber ASC")
    List<QuizSessionQuestion> findByQuizSessionId(@Param("quizSessionId") UUID quizSessionId);

    @Query("SELECT CASE WHEN COUNT(q) > 0 THEN true ELSE false END FROM QuizSessionQuestion q WHERE q.id.quizSessionId = :quizSessionId AND q.id.questionId = :questionId")
    boolean existsByQuizSessionIdAndQuestionId(@Param("quizSessionId") UUID quizSessionId, @Param("questionId") UUID questionId);
}
