package com.nerdquiz.service;

import com.nerdquiz.dto.LessonProgressResponse;
import com.nerdquiz.model.UserLessonProgress;
import com.nerdquiz.repository.UserLessonProgressRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;

@Service
public class LessonProgressService {

    private final UserLessonProgressRepository userLessonProgressRepository;
    private final LessonService lessonService;

    public LessonProgressService(UserLessonProgressRepository userLessonProgressRepository,
                                 LessonService lessonService) {
        this.userLessonProgressRepository = userLessonProgressRepository;
        this.lessonService = lessonService;
    }

    @Transactional(readOnly = true)
    public LessonProgressResponse getProgress(UUID userId, UUID lessonId) {
        Optional<UserLessonProgress> progress = userLessonProgressRepository.findByUserIdAndLessonId(userId, lessonId);

        if (progress.isEmpty()) {
            return createDefaultProgress(userId, lessonId);
        }

        return toResponse(progress.get());
    }

    /**
     * Completes the lesson via {@link LessonService#completeLesson}, which owns the
     * single XP rule (lesson {@code xp_reward}, first completion only).
     */
    @Transactional
    public LessonProgressResponse markComplete(UUID userId, UUID lessonId) {
        lessonService.completeLesson(lessonId, userId);
        return getProgress(userId, lessonId);
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
