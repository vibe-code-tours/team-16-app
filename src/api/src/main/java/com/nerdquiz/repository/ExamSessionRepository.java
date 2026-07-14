package com.nerdquiz.repository;

import com.nerdquiz.model.ExamSession;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ExamSessionRepository extends JpaRepository<ExamSession, UUID> {

    List<ExamSession> findByUserIdOrderByStartedAtDesc(UUID userId);

    Optional<ExamSession> findByIdAndUserId(UUID id, UUID userId);

    List<ExamSession> findByUserIdAndStatus(UUID userId, String status);
}
