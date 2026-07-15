package com.nerdquiz.repository;

import com.nerdquiz.model.ExamAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface ExamAnswerRepository extends JpaRepository<ExamAnswer, UUID> {

    long countByExamSessionIdAndIsCorrectTrue(UUID examSessionId);

    Optional<ExamAnswer> findByExamSessionIdAndQuestionId(UUID examSessionId, UUID questionId);
}
