package com.nerdquiz.repository;

import com.nerdquiz.model.QuizAnswer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface QuizAnswerRepository extends JpaRepository<QuizAnswer, UUID> {

    List<QuizAnswer> findByQuizSessionId(UUID quizSessionId);

    long countByQuizSessionIdAndIsCorrect(UUID quizSessionId, Boolean isCorrect);
}
