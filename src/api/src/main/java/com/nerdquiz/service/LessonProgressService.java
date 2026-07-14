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

        if (!"completed".equals(progress.getStatus())) {
            Instant completedAt = Instant.now();
            progress.setStatus("completed");
            if (progress.getStartedAt() == null) {
                progress.setStartedAt(completedAt);
            }
            progress.setCompletedAt(completedAt);
            userLessonProgressRepository.save(progress);
        }

        return toResponse(progress);
    }

    private LessonProgressResponse createDefaultProgress(UUID userId, UUID lessonId) {
        UserLessonProgress progress = new UserLessonProgress();
        progress.setUserId(userId);
        progress.setLessonId(lessonId);
        return toResponse(progress);
    }

    private LessonProgressResponse toResponse(UserLessonProgress progress) {
        return new LessonProgressResponse(
            progress.getUserId(),
            progress.getLessonId(),
            progress.getStatus(),
            progress.getStartedAt(),
            progress.getCompletedAt()
        );
    }
}
