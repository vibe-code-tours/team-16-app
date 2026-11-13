package com.nerdquiz.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nerdquiz.exception.LessonNotFoundException;
import com.nerdquiz.model.Lesson;
import com.nerdquiz.model.UserLessonProgress;
import com.nerdquiz.repository.LessonRepository;
import com.nerdquiz.repository.SubtopicRepository;
import com.nerdquiz.repository.UserLessonProgressRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class LessonServiceTest {

    private static final int LESSON_XP_REWARD = 15;

    @Mock
    private LessonRepository lessonRepository;

    @Mock
    private SubtopicRepository subtopicRepository;

    @Mock
    private UserLessonProgressRepository progressRepository;

    @Mock
    private UserService userService;

    @Mock
    private ObjectMapper objectMapper;

    @InjectMocks
    private LessonService lessonService;

    private UUID userId;
    private UUID lessonId;
    private Lesson lesson;

    @BeforeEach
    void setUp() {
        userId = UUID.randomUUID();
        lessonId = UUID.randomUUID();
        lesson = new Lesson();
        lesson.setId(lessonId);
        lesson.setPublished(true);
        lesson.setXpReward(LESSON_XP_REWARD);
    }

    @Test
    void completeLesson_FirstCompletion_AwardsLessonXpReward() {
        when(lessonRepository.findById(lessonId)).thenReturn(Optional.of(lesson));
        when(progressRepository.findByUserIdAndLessonId(userId, lessonId)).thenReturn(Optional.empty());

        lessonService.completeLesson(lessonId, userId);

        ArgumentCaptor<UserLessonProgress> saved = ArgumentCaptor.forClass(UserLessonProgress.class);
        verify(progressRepository).save(saved.capture());
        assertEquals("completed", saved.getValue().getStatus());
        assertEquals(userId, saved.getValue().getUserId());
        assertNotNull(saved.getValue().getStartedAt());
        assertNotNull(saved.getValue().getCompletedAt());
        verify(userService).incrementUserXp(userId, LESSON_XP_REWARD);
    }

    @Test
    void completeLesson_InProgressLesson_AwardsXpAndKeepsStartedAt() {
        Instant startedAt = Instant.parse("2026-01-01T00:00:00Z");
        UserLessonProgress inProgress = progress("in_progress");
        inProgress.setStartedAt(startedAt);
        when(lessonRepository.findById(lessonId)).thenReturn(Optional.of(lesson));
        when(progressRepository.findByUserIdAndLessonId(userId, lessonId)).thenReturn(Optional.of(inProgress));

        lessonService.completeLesson(lessonId, userId);

        assertEquals("completed", inProgress.getStatus());
        assertEquals(startedAt, inProgress.getStartedAt());
        verify(progressRepository).save(inProgress);
        verify(userService).incrementUserXp(userId, LESSON_XP_REWARD);
    }

    @Test
    void completeLesson_AlreadyCompleted_AwardsNothing() {
        when(lessonRepository.findById(lessonId)).thenReturn(Optional.of(lesson));
        when(progressRepository.findByUserIdAndLessonId(userId, lessonId))
                .thenReturn(Optional.of(progress("completed")));

        lessonService.completeLesson(lessonId, userId);

        verify(progressRepository, never()).save(any());
        verify(userService, never()).incrementUserXp(any(), anyInt());
    }

    @Test
    void completeLesson_UnknownLesson_ThrowsLessonNotFound() {
        when(lessonRepository.findById(lessonId)).thenReturn(Optional.empty());

        assertThrows(LessonNotFoundException.class, () -> lessonService.completeLesson(lessonId, userId));

        verify(userService, never()).incrementUserXp(any(), anyInt());
    }

    @Test
    void completeLesson_UnpublishedLesson_ThrowsLessonNotFound() {
        lesson.setPublished(false);
        when(lessonRepository.findById(lessonId)).thenReturn(Optional.of(lesson));

        assertThrows(LessonNotFoundException.class, () -> lessonService.completeLesson(lessonId, userId));

        verify(progressRepository, never()).save(any());
        verify(userService, never()).incrementUserXp(any(), anyInt());
    }

    private UserLessonProgress progress(String status) {
        UserLessonProgress row = new UserLessonProgress();
        row.setUserId(userId);
        row.setLessonId(lessonId);
        row.setStatus(status);
        return row;
    }
}
