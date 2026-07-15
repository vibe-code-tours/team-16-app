package com.nerdquiz.repository;

import com.nerdquiz.model.QuizSessionQuestion;
import com.nerdquiz.model.QuizSessionQuestionId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface QuizSessionQuestionRepository extends JpaRepository<QuizSessionQuestion, QuizSessionQuestionId> {

    List<QuizSessionQuestion> findByQuizSessionIdOrderBySequenceNumberAsc(UUID quizSessionId);

    boolean existsByQuizSessionIdAndQuestionId(UUID quizSessionId, UUID questionId);
}
