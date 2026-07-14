package com.nerdquiz.repository;

import com.nerdquiz.model.UserMistake;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserMistakeRepository extends JpaRepository<UserMistake, UUID> {

    List<UserMistake> findByUserIdOrderByLastMissedAtDesc(UUID userId);

    Optional<UserMistake> findByUserIdAndQuestionId(UUID userId, UUID questionId);
}
