package com.nerdquiz.repository;

import com.nerdquiz.model.UserLessonProgress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserLessonProgressRepository
        extends JpaRepository<UserLessonProgress, UserLessonProgress.PK> {

    List<UserLessonProgress> findByUserIdAndLessonIdIn(UUID userId, Collection<UUID> lessonIds);

    Optional<UserLessonProgress> findByUserIdAndLessonId(UUID userId, UUID lessonId);
}
