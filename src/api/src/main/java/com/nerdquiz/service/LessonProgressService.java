package com.nerdquiz.service;

import com.nerdquiz.dto.LessonProgressResponse;
import com.nerdquiz.model.UserLessonProgress;
import com.nerdquiz.repository.UserLessonProgressRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
public class LessonProgressService {

    private final UserLessonProgressRepository userLessonProgressRepository;

    public LessonProgressService(UserLessonProgressRepository userLessonProgressRepository) {
        this.userLessonProgressRepository = userLessonProgressRepository;
    }

    @Transactional(readOnly = true)
    public LessonProgressResponse getProgress(UUID userId, UUID lessonId) {
        Optional<UserLessonProgress> progress = userLessonProgressRepository.findByUserIdAndLessonId(userId, lessonId);

        if (progress.isEmpty()) {
            return createDefaultProgress(userId, lessonId);
        }

        return toResponse(progress.get());
    }

    @Transactional
    public LessonProgressResponse markComplete(UUID userId, UUID lessonId) {
        UserLessonProgress progress = userLessonProgressRepository.findByUserIdAndLessonId(userId, lessonId)
                .orElseGet(() -> {
                    UserLessonProgress newProgress = new UserLessonProgress();
                    newProgress.setUserId(userId);
                    newProgress.setLessonId(lessonId);
                    return newProgress;
                });

        if (!Boolean.TRUE.equals(progress.getCompleted())) {
            progress.setCompleted(true);
            progress.setCompletedAt(Instant.now());
            progress.setUpdatedAt(Instant.now());
            userLessonProgressRepository.save(progress);
        }

        return toResponse(progress);
    }

    private LessonProgressResponse createDefaultProgress(UUID userId, UUID lessonId) {
        UserLessonProgress progress = new UserLessonProgress();
        progress.setUserId(userId);
        progress.setLessonId(lessonId);
        progress.setCompleted(false);
        return toResponse(progress);
    }

    private LessonProgressResponse toResponse(UserLessonProgress progress) {
        return new LessonProgressResponse(
            progress.getId(),
            progress.getUserId(),
            progress.getLessonId(),
            progress.getCompleted(),
            progress.getCompletedAt(),
            progress.getCreatedAt(),
            progress.getUpdatedAt()
        );
    }
}
