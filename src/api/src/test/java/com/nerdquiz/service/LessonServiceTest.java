package com.nerdquiz.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nerdquiz.exception.LessonNotFoundException;
import com.nerdquiz.model.UserLessonProgress;
import com.nerdquiz.repository.LessonRepository;
import com.nerdquiz.repository.SubtopicRepository;
import com.nerdquiz.repository.UserLessonProgressRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class LessonServiceTest {

    @Mock
    private LessonRepository lessonRepository;

    @Mock
    private SubtopicRepository subtopicRepository;

    @Mock
    private UserLessonProgressRepository progressRepository;

    @Mock
    private UserService userService;

    private LessonService lessonService;
    private UUID userId;
    private UUID lessonId;

    @BeforeEach
    void setUp() {
        lessonService = new LessonService(lessonRepository, subtopicRepository, progressRepository,
                new ObjectMapper(), userService);
        userId = UUID.randomUUID();
        lessonId = UUID.randomUUID();
    }

    @Test
    void completeLesson_FirstCompletion_RecordsStudyActivity() {
        when(lessonRepository.existsById(lessonId)).thenReturn(true);
        when(progressRepository.findByUserIdAndLessonId(userId, lessonId)).thenReturn(Optional.empty());

        lessonService.completeLesson(lessonId, userId);

        verify(progressRepository).save(any(UserLessonProgress.class));
        verify(userService).recordStudyActivity(userId);
    }

    @Test
    void completeLesson_RepeatCompletion_DoesNotRecordStudyActivity() {
        UserLessonProgress completed = new UserLessonProgress();
        completed.setUserId(userId);
        completed.setLessonId(lessonId);
        completed.setStatus("completed");
        completed.setCompletedAt(Instant.now());
        when(lessonRepository.existsById(lessonId)).thenReturn(true);
        when(progressRepository.findByUserIdAndLessonId(userId, lessonId)).thenReturn(Optional.of(completed));

        lessonService.completeLesson(lessonId, userId);

        verify(userService, never()).recordStudyActivity(any());
    }

    @Test
    void completeLesson_LessonMissing_ThrowsNotFoundWithoutStudyActivity() {
        when(lessonRepository.existsById(lessonId)).thenReturn(false);

        assertThrows(LessonNotFoundException.class, () -> lessonService.completeLesson(lessonId, userId));
        verify(userService, never()).recordStudyActivity(any());
    }
}
