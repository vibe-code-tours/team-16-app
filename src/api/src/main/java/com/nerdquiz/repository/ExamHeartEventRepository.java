package com.nerdquiz.repository;

import com.nerdquiz.model.ExamHeartEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ExamHeartEventRepository extends JpaRepository<ExamHeartEvent, UUID> {
}
