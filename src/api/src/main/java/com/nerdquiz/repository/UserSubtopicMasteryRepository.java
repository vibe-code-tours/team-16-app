package com.nerdquiz.repository;

import com.nerdquiz.model.UserSubtopicMastery;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface UserSubtopicMasteryRepository
        extends JpaRepository<UserSubtopicMastery, UserSubtopicMastery.PK> {

    List<UserSubtopicMastery> findByUserId(UUID userId);
}
