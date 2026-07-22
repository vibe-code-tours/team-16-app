package com.nerdquiz.repository;

import com.nerdquiz.model.ExamSessionQuestion;
import com.nerdquiz.model.ExamSessionQuestionId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ExamSessionQuestionRepository extends JpaRepository<ExamSessionQuestion, ExamSessionQuestionId> {

    @Query("SELECT CASE WHEN COUNT(q) > 0 THEN true ELSE false END FROM ExamSessionQuestion q WHERE q.id.examSessionId = :examSessionId AND q.id.questionId = :questionId")
    boolean existsByExamSessionIdAndQuestionId(@Param("examSessionId") UUID examSessionId, @Param("questionId") UUID questionId);
}
