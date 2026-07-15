package com.nerdquiz.repository;

import com.nerdquiz.model.ExamSession;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ExamSessionRepository extends JpaRepository<ExamSession, UUID> {
}
