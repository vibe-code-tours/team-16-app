package com.nerdquiz.repository;

import com.nerdquiz.model.QuizSession;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface QuizSessionRepository extends JpaRepository<QuizSession, UUID> {

    List<QuizSession> findByUserIdOrderByStartedAtDesc(UUID userId);

    List<QuizSession> findByUserIdAndStatus(UUID userId, String status);
}
