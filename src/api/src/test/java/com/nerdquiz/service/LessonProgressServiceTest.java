package com.nerdquiz.service;

import com.nerdquiz.dto.LessonProgressResponse;
import com.nerdquiz.model.UserLessonProgress;
import com.nerdquiz.repository.UserLessonProgressRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class LessonProgressServiceTest {

    @Mock
    private UserLessonProgressRepository userLessonProgressRepository;

    @Mock
    private LessonService lessonService;

    @InjectMocks
    private LessonProgressService lessonProgressService;

    @Test
    void markComplete_DelegatesToLessonService_ReturnsStoredProgress() {
        UUID userId = UUID.randomUUID();
        UUID lessonId = UUID.randomUUID();
        UserLessonProgress completed = new UserLessonProgress();
        completed.setUserId(userId);
        completed.setLessonId(lessonId);
        completed.setStatus("completed");
        when(userLessonProgressRepository.findByUserIdAndLessonId(userId, lessonId))
                .thenReturn(Optional.of(completed));

        LessonProgressResponse response = lessonProgressService.markComplete(userId, lessonId);

        verify(lessonService).completeLesson(lessonId, userId);
        assertEquals("completed", response.status());
    }
}
