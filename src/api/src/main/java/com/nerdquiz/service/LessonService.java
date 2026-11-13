package com.nerdquiz.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nerdquiz.dto.LessonDetailResponse;
import com.nerdquiz.dto.LessonResponse;
import com.nerdquiz.exception.LessonNotFoundException;
import com.nerdquiz.model.Lesson;
import com.nerdquiz.model.Subtopic;
import com.nerdquiz.model.UserLessonProgress;
import com.nerdquiz.repository.LessonRepository;
import com.nerdquiz.repository.SubtopicRepository;
import com.nerdquiz.repository.UserLessonProgressRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class LessonService {

    private static final String STATUS_COMPLETED = "completed";

    private final LessonRepository lessonRepository;
    private final SubtopicRepository subtopicRepository;
    private final UserLessonProgressRepository progressRepository;
    private final UserService userService;
    private final ObjectMapper objectMapper;

    public LessonService(LessonRepository lessonRepository,
                         SubtopicRepository subtopicRepository,
                         UserLessonProgressRepository progressRepository,
                         UserService userService,
                         ObjectMapper objectMapper) {
        this.lessonRepository = lessonRepository;
        this.subtopicRepository = subtopicRepository;
        this.progressRepository = progressRepository;
        this.userService = userService;
        this.objectMapper = objectMapper;
    }

    @Transactional(readOnly = true)
    public List<LessonResponse> getLessonsForSubtopic(UUID subtopicId, UUID userId) {
        List<Lesson> lessons = lessonRepository
                .findBySubtopicIdAndPublishedTrueOrderByDisplayOrderAsc(subtopicId);

        Map<UUID, String> statusByLessonId = userId == null ? Map.of() :
                progressRepository.findByUserIdAndLessonIdIn(userId,
                        lessons.stream().map(Lesson::getId).toList()
                ).stream().collect(Collectors.toMap(
                        UserLessonProgress::getLessonId,
                        UserLessonProgress::getStatus
                ));

        return lessons.stream().map(l -> toResponse(l, statusByLessonId.get(l.getId()))).toList();
    }

    @Transactional(readOnly = true)
    public LessonDetailResponse getLesson(UUID lessonId) {
        Lesson lesson = lessonRepository.findById(lessonId)
                .filter(Lesson::getPublished)
                .orElseThrow(LessonNotFoundException::new);
        Subtopic subtopic = subtopicRepository.findById(lesson.getSubtopicId())
                .orElseThrow(LessonNotFoundException::new);

        try {
            JsonNode contentNode = objectMapper.readTree(
                    lesson.getContentBlocks() == null || lesson.getContentBlocks().isBlank()
                            ? "[]" : lesson.getContentBlocks()
            );
            return new LessonDetailResponse(
                    lesson.getId(),
                    lesson.getSubtopicId(),
                    subtopic.getTopicId(),
                    subtopic.getName(),
                    lesson.getTitle(),
                    lesson.getSlug(),
                    lesson.getSummary(),
                    contentNode,
                    lesson.getEstimatedMinutes(),
                    lesson.getXpReward(),
                    lesson.getDisplayOrder(),
                    lesson.getPublished()
            );
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse lesson content_blocks", e);
        }
    }

    /**
     * Marks a published lesson as completed for the user. The lesson's {@code xp_reward}
     * is awarded on the first completion only; repeating it is a no-op.
     */
    @Transactional
    public void completeLesson(UUID lessonId, UUID userId) {
        Lesson lesson = lessonRepository.findById(lessonId)
                .filter(Lesson::getPublished)
                .orElseThrow(LessonNotFoundException::new);

        UserLessonProgress row = progressRepository
                .findByUserIdAndLessonId(userId, lessonId)
                .orElseGet(() -> newProgress(userId, lessonId));
        if (STATUS_COMPLETED.equals(row.getStatus())) {
            return;
        }

        Instant now = Instant.now();
        if (row.getStartedAt() == null) {
            row.setStartedAt(now);
        }
        row.setStatus(STATUS_COMPLETED);
        row.setCompletedAt(now);
        progressRepository.save(row);
        userService.incrementUserXp(userId, lesson.getXpReward());
    }

    private static UserLessonProgress newProgress(UUID userId, UUID lessonId) {
        UserLessonProgress fresh = new UserLessonProgress();
        fresh.setUserId(userId);
        fresh.setLessonId(lessonId);
        return fresh;
    }

    private LessonResponse toResponse(Lesson lesson, String status) {
        try {
            JsonNode contentNode = objectMapper.readTree(
                    lesson.getContentBlocks() == null || lesson.getContentBlocks().isBlank()
                            ? "[]" : lesson.getContentBlocks()
            );
            return new LessonResponse(
                    lesson.getId(),
                    lesson.getSubtopicId(),
                    lesson.getTitle(),
                    lesson.getSlug(),
                    lesson.getSummary(),
                    contentNode,
                    lesson.getEstimatedMinutes(),
                    lesson.getXpReward(),
                    lesson.getDisplayOrder(),
                    lesson.getPublished(),
                    status == null ? "locked" : status
            );
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse lesson content_blocks", e);
        }
    }
}
