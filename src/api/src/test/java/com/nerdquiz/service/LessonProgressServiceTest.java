package com.nerdquiz.service;

import com.nerdquiz.dto.LessonProgressResponse;
import com.nerdquiz.model.UserLessonProgress;
import com.nerdquiz.repository.UserLessonProgressRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class LessonProgressServiceTest {

    @Mock
    private UserLessonProgressRepository userLessonProgressRepository;

    @Mock
    private UserService userService;

    private LessonProgressService lessonProgressService;
    private UUID userId;
    private UUID lessonId;

    @BeforeEach
    void setUp() {
        lessonProgressService = new LessonProgressService(userLessonProgressRepository, userService);
        userId = UUID.randomUUID();
        lessonId = UUID.randomUUID();
    }

    @Test
    void markComplete_FirstCompletion_AwardsXpAndRecordsStudyActivity() {
        when(userLessonProgressRepository.findByUserIdAndLessonId(userId, lessonId))
                .thenReturn(Optional.empty());

        LessonProgressResponse response = lessonProgressService.markComplete(userId, lessonId);

        assertEquals("completed", response.status());
        verify(userService).incrementUserXp(userId, 20);
        verify(userService).recordStudyActivity(userId);
    }

    @Test
    void markComplete_AlreadyCompleted_DoesNotRecordStudyActivity() {
        UserLessonProgress completed = new UserLessonProgress();
        completed.setUserId(userId);
        completed.setLessonId(lessonId);
        completed.setStatus("completed");
        completed.setCompletedAt(Instant.now());
        when(userLessonProgressRepository.findByUserIdAndLessonId(userId, lessonId))
                .thenReturn(Optional.of(completed));

        lessonProgressService.markComplete(userId, lessonId);

        verify(userService, never()).incrementUserXp(any(), anyInt());
        verify(userService, never()).recordStudyActivity(any());
    }
}
