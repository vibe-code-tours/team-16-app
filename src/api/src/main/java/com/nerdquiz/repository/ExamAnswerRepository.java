package com.nerdquiz.repository;

import com.nerdquiz.model.ExamAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ExamAnswerRepository extends JpaRepository<ExamAnswer, UUID> {

    List<ExamAnswer> findByExamSessionIdOrderBySequenceNumberAsc(UUID examSessionId);

    Optional<ExamAnswer> findByExamSessionIdAndQuestionId(UUID examSessionId, UUID questionId);

    List<ExamAnswer> findByExamSessionIdAndIsCorrectFalse(UUID examSessionId);

    long countByExamSessionIdAndIsCorrectTrue(UUID examSessionId);

    long countByExamSessionIdAndUserAnswerIsNotNull(UUID examSessionId);
}
