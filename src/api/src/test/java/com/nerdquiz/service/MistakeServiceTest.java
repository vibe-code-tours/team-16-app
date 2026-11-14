package com.nerdquiz.service;

import com.nerdquiz.dto.MistakeResponse;
import com.nerdquiz.dto.RecordMistakeRequest;
import com.nerdquiz.exception.MistakeNotFoundException;
import com.nerdquiz.model.UserMistake;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.SubtopicRepository;
import com.nerdquiz.repository.TopicRepository;
import com.nerdquiz.repository.UserMistakeRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Pageable;

import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class MistakeServiceTest {

    private static final UUID USER_ID = UUID.randomUUID();
    private static final UUID MISTAKE_ID = UUID.randomUUID();
    private static final UUID QUESTION_ID = UUID.randomUUID();

    @Mock
    private UserMistakeRepository userMistakeRepository;

    @Mock
    private QuestionRepository questionRepository;

    @Mock
    private SubtopicRepository subtopicRepository;

    @Mock
    private TopicRepository topicRepository;

    @Mock
    private ObjectMapper objectMapper;

    @InjectMocks
    private MistakeService mistakeService;

    private UserMistake mistakeWithInterval(int intervalDays, int reviewCount) {
        UserMistake mistake = new UserMistake();
        mistake.setId(MISTAKE_ID);
        mistake.setUserId(USER_ID);
        mistake.setQuestionId(QUESTION_ID);
        mistake.setSelectedLabel("a");
        mistake.setIntervalDays(intervalDays);
        mistake.setReviewCount(reviewCount);
        return mistake;
    }

    private UserMistake reviewAndCapture(UserMistake mistake) {
        when(userMistakeRepository.findByIdAndUserId(MISTAKE_ID, USER_ID)).thenReturn(Optional.of(mistake));

        mistakeService.reviewMistake(USER_ID, MISTAKE_ID);

        ArgumentCaptor<UserMistake> captor = ArgumentCaptor.forClass(UserMistake.class);
        verify(userMistakeRepository).save(captor.capture());
        return captor.getValue();
    }

    private static void assertDueInDays(Instant nextReviewAt, int days, Instant before, Instant after) {
        assertNotNull(nextReviewAt);
        Duration offset = Duration.ofDays(days);
        assertFalse(nextReviewAt.isBefore(before.plus(offset)), "next review is earlier than expected");
        assertFalse(nextReviewAt.isAfter(after.plus(offset)), "next review is later than expected");
    }

    @Test
    void nextIntervalDays_FollowsLadder_OneThreeSevenFourteen() {
        assertEquals(3, MistakeService.nextIntervalDays(1));
        assertEquals(7, MistakeService.nextIntervalDays(3));
        assertEquals(14, MistakeService.nextIntervalDays(7));
    }

    @Test
    void nextIntervalDays_AtTopOfLadder_StaysAtFourteen() {
        assertEquals(14, MistakeService.nextIntervalDays(14));
        assertEquals(14, MistakeService.nextIntervalDays(30));
    }

    @Test
    void reviewMistake_FirstCorrectReview_SchedulesThreeDaysOut() {
        Instant before = Instant.now();
        UserMistake saved = reviewAndCapture(mistakeWithInterval(1, 0));
        Instant after = Instant.now();

        assertEquals(3, saved.getIntervalDays());
        assertEquals(1, saved.getReviewCount());
        assertTrue(saved.getReviewed());
        assertDueInDays(saved.getNextReviewAt(), 3, before, after);
    }

    @Test
    void reviewMistake_AtSevenDays_ClimbsToFourteen() {
        Instant before = Instant.now();
        UserMistake saved = reviewAndCapture(mistakeWithInterval(7, 2));
        Instant after = Instant.now();

        assertEquals(14, saved.getIntervalDays());
        assertEquals(3, saved.getReviewCount());
        assertDueInDays(saved.getNextReviewAt(), 14, before, after);
    }

    @Test
    void reviewMistake_NotOwned_ThrowsMistakeNotFound() {
        when(userMistakeRepository.findByIdAndUserId(MISTAKE_ID, USER_ID)).thenReturn(Optional.empty());

        assertThrows(MistakeNotFoundException.class, () -> mistakeService.reviewMistake(USER_ID, MISTAKE_ID));
        verify(userMistakeRepository, never()).save(any());
    }

    @Test
    void recordMistake_WrongRetryOnScheduledMistake_ResetsIntervalToOneDay() {
        UserMistake existing = mistakeWithInterval(7, 2);
        when(questionRepository.existsById(QUESTION_ID)).thenReturn(true);
        when(userMistakeRepository.findByUserIdAndQuestionId(USER_ID, QUESTION_ID)).thenReturn(Optional.of(existing));
        when(userMistakeRepository.save(any(UserMistake.class))).thenAnswer(invocation -> invocation.getArgument(0));
        when(questionRepository.findById(QUESTION_ID)).thenReturn(Optional.empty());

        Instant before = Instant.now();
        mistakeService.recordMistake(USER_ID, new RecordMistakeRequest(QUESTION_ID, "c"));
        Instant after = Instant.now();

        assertEquals(1, existing.getIntervalDays());
        assertEquals(2, existing.getReviewCount(), "a miss does not erase past reviews");
        assertEquals("c", existing.getSelectedLabel());
        assertDueInDays(existing.getNextReviewAt(), 1, before, after);
    }

    @Test
    void recordMistake_NewMistake_IsDueInOneDay() {
        when(questionRepository.existsById(QUESTION_ID)).thenReturn(true);
        when(userMistakeRepository.findByUserIdAndQuestionId(USER_ID, QUESTION_ID)).thenReturn(Optional.empty());
        when(userMistakeRepository.save(any(UserMistake.class))).thenAnswer(invocation -> invocation.getArgument(0));
        when(questionRepository.findById(QUESTION_ID)).thenReturn(Optional.empty());

        Instant before = Instant.now();
        mistakeService.recordMistake(USER_ID, new RecordMistakeRequest(QUESTION_ID, "b"));
        Instant after = Instant.now();

        ArgumentCaptor<UserMistake> captor = ArgumentCaptor.forClass(UserMistake.class);
        verify(userMistakeRepository).save(captor.capture());
        assertEquals(1, captor.getValue().getIntervalDays());
        assertEquals(0, captor.getValue().getReviewCount());
        assertDueInDays(captor.getValue().getNextReviewAt(), 1, before, after);
    }

    @Test
    void getDueMistakes_QueriesMistakesDueNowForUser() {
        UserMistake due = mistakeWithInterval(3, 1);
        due.setCreatedAt(Instant.parse("2026-11-01T00:00:00Z"));
        when(userMistakeRepository.findByUserIdAndNextReviewAtLessThanEqualOrderByNextReviewAtAsc(
                eq(USER_ID), any(Instant.class), any(Pageable.class))).thenReturn(List.of(due));
        when(questionRepository.findByIdIn(any())).thenReturn(List.of());
        when(subtopicRepository.findAllById(any())).thenReturn(List.of());
        when(topicRepository.findAllById(any())).thenReturn(List.of());

        Instant before = Instant.now();
        List<MistakeResponse> result = mistakeService.getDueMistakes(USER_ID);
        Instant after = Instant.now();

        assertEquals(1, result.size());
        assertEquals(MISTAKE_ID, result.get(0).id());
        ArgumentCaptor<Instant> dueBy = ArgumentCaptor.forClass(Instant.class);
        verify(userMistakeRepository).findByUserIdAndNextReviewAtLessThanEqualOrderByNextReviewAtAsc(
                eq(USER_ID), dueBy.capture(), any(Pageable.class));
        assertFalse(dueBy.getValue().isBefore(before));
        assertFalse(dueBy.getValue().isAfter(after));
    }
}
