package com.nerdquiz.service;

import com.nerdquiz.dto.TopicProgressResponse;
import com.nerdquiz.dto.TopicResponse;
import com.nerdquiz.model.Subtopic;
import com.nerdquiz.model.Topic;
import com.nerdquiz.model.UserSubtopicMastery;
import com.nerdquiz.repository.LessonRepository;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.SubtopicRepository;
import com.nerdquiz.repository.TopicRepository;
import com.nerdquiz.repository.UserSubtopicMasteryRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class TopicServiceTest {

    @Mock private TopicRepository topicRepository;
    @Mock private SubtopicRepository subtopicRepository;
    @Mock private QuestionRepository questionRepository;
    @Mock private LessonRepository lessonRepository;
    @Mock private UserSubtopicMasteryRepository masteryRepository;

    @InjectMocks
    private TopicService topicService;

    private final UUID userId = UUID.randomUUID();
    private final UUID topicId = UUID.randomUUID();
    private final UUID firstSubtopicId = UUID.randomUUID();
    private final UUID secondSubtopicId = UUID.randomUUID();

    @BeforeEach
    void setUp() {
        Topic topic = new Topic();
        topic.setId(topicId);
        topic.setName("Technology");
        topic.setDisplayOrder(1);
        when(topicRepository.findByPublishedTrueOrderByDisplayOrderAsc()).thenReturn(List.of(topic));
        when(subtopicRepository.findByPublishedTrueOrderByDisplayOrderAsc()).thenReturn(List.of(
                subtopic(firstSubtopicId, 1), subtopic(secondSubtopicId, 2)));
        when(questionRepository.countPublishedGroupedBySubtopic()).thenReturn(List.of(
                questionCount(firstSubtopicId, 20), questionCount(secondSubtopicId, 15)));
        when(lessonRepository.countPublishedLessonsBySubtopic()).thenReturn(List.of(
                lessonCount(firstSubtopicId, 2), lessonCount(secondSubtopicId, 2)));
    }

    @Test
    void getLearningMap_WithMastery_MapsQuestionStatsFromMastery() {
        Instant practicedAt = Instant.parse("2026-11-01T10:00:00Z");
        when(lessonRepository.countCompletedLessonsBySubtopicForUser(userId))
                .thenReturn(List.of(lessonCount(firstSubtopicId, 1)));
        when(masteryRepository.findByUserId(userId))
                .thenReturn(List.of(mastery(firstSubtopicId, 10, 8, "0.80", practicedAt)));

        TopicProgressResponse progress = findById(topicService.getLearningMap(userId), firstSubtopicId).progress();

        assertNotNull(progress);
        assertEquals("in_progress", progress.status());
        assertEquals(10, progress.questionsAnswered());
        assertEquals(8, progress.questionsCorrect());
        assertEquals(0.8, progress.masteryScore(), 1e-9);
        assertEquals(practicedAt, progress.lastAttemptedAt());
    }

    @Test
    void getLearningMap_LessonsCompletedWithoutMastery_ReturnsZeroQuestionStats() {
        when(lessonRepository.countCompletedLessonsBySubtopicForUser(userId))
                .thenReturn(List.of(lessonCount(firstSubtopicId, 1)));
        when(masteryRepository.findByUserId(userId)).thenReturn(List.of());

        TopicProgressResponse progress = findById(topicService.getLearningMap(userId), firstSubtopicId).progress();

        assertNotNull(progress);
        assertEquals(0, progress.questionsAnswered());
        assertEquals(0, progress.questionsCorrect());
        assertEquals(0.0, progress.masteryScore(), 1e-9);
        assertNull(progress.lastAttemptedAt());
    }

    @Test
    void getLearningMap_MasteryWithoutLessons_KeepsStatusAndReturnsProgress() {
        when(lessonRepository.countCompletedLessonsBySubtopicForUser(userId)).thenReturn(List.of());
        when(masteryRepository.findByUserId(userId))
                .thenReturn(List.of(mastery(firstSubtopicId, 4, 3, "0.75", null)));

        TopicResponse first = findById(topicService.getLearningMap(userId), firstSubtopicId);

        assertEquals("not_started", first.status());
        assertNotNull(first.progress());
        assertEquals(4, first.progress().questionsAnswered());
    }

    @Test
    void getLearningMap_NoActivity_ReturnsNullProgress() {
        when(lessonRepository.countCompletedLessonsBySubtopicForUser(userId)).thenReturn(List.of());
        when(masteryRepository.findByUserId(userId)).thenReturn(List.of());

        List<TopicResponse> map = topicService.getLearningMap(userId);

        assertNull(findById(map, firstSubtopicId).progress());
        assertNull(findById(map, secondSubtopicId).progress());
    }

    @Test
    void getLearningMap_MasteryOnLockedSubtopic_StaysLocked() {
        when(lessonRepository.countCompletedLessonsBySubtopicForUser(userId)).thenReturn(List.of());
        when(masteryRepository.findByUserId(userId))
                .thenReturn(List.of(mastery(secondSubtopicId, 10, 10, "1.00", null)));

        TopicResponse second = findById(topicService.getLearningMap(userId), secondSubtopicId);

        assertEquals("locked", second.status());
    }

    @Test
    void getLearningMap_MultipleSubtopics_LoadsMasteryInSingleQuery() {
        when(lessonRepository.countCompletedLessonsBySubtopicForUser(userId)).thenReturn(List.of());
        when(masteryRepository.findByUserId(userId)).thenReturn(List.of(
                mastery(firstSubtopicId, 5, 2, "0.40", null),
                mastery(secondSubtopicId, 6, 6, "1.00", null)));

        topicService.getLearningMap(userId);

        verify(masteryRepository, times(1)).findByUserId(userId);
        verifyNoMoreInteractions(masteryRepository);
    }

    @Test
    void getLearningMap_AnonymousUser_DoesNotQueryMastery() {
        List<TopicResponse> map = topicService.getLearningMap(null);

        assertEquals(2, map.size());
        verifyNoInteractions(masteryRepository);
    }

    private static TopicResponse findById(List<TopicResponse> map, UUID id) {
        return map.stream().filter(t -> t.id().equals(id)).findFirst().orElseThrow();
    }

    private Subtopic subtopic(UUID id, int order) {
        Subtopic subtopic = new Subtopic();
        subtopic.setId(id);
        subtopic.setTopicId(topicId);
        subtopic.setName("Subtopic " + order);
        subtopic.setDisplayOrder(order);
        return subtopic;
    }

    private UserSubtopicMastery mastery(UUID subtopicId, int seen, int correct, String score, Instant practicedAt) {
        UserSubtopicMastery mastery = new UserSubtopicMastery();
        mastery.setUserId(userId);
        mastery.setSubtopicId(subtopicId);
        mastery.setQuestionsSeen(seen);
        mastery.setQuestionsCorrect(correct);
        mastery.setMasteryScore(new BigDecimal(score));
        mastery.setLastPracticedAt(practicedAt);
        return mastery;
    }

    private static LessonRepository.SubtopicLessonCount lessonCount(UUID subtopicId, long count) {
        return new LessonRepository.SubtopicLessonCount() {
            @Override public UUID getSubtopicId() { return subtopicId; }
            @Override public Long getCnt() { return count; }
        };
    }

    private static QuestionRepository.SubtopicQuestionCount questionCount(UUID subtopicId, long count) {
        return new QuestionRepository.SubtopicQuestionCount() {
            @Override public UUID getSubtopicId() { return subtopicId; }
            @Override public Long getCnt() { return count; }
        };
    }
}
