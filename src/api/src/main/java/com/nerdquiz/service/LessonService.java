package com.nerdquiz.service;

import com.nerdquiz.dto.LessonResponse;
import com.nerdquiz.exception.LessonNotFoundException;
import com.nerdquiz.model.Lesson;
import com.nerdquiz.repository.LessonRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
public class LessonService {

    private final LessonRepository lessonRepository;

    public LessonService(LessonRepository lessonRepository) {
        this.lessonRepository = lessonRepository;
    }

    @Transactional(readOnly = true)
    public List<LessonResponse> getLessonsBySubtopic(UUID subtopicId) {
        List<Lesson> lessons = lessonRepository.findBySubtopicIdAndPublishedTrueOrderByDisplayOrderAsc(subtopicId);
        return lessons.stream()
                .map(this::toResponse)
                .toList();
    }

    @Transactional(readOnly = true)
    public LessonResponse getLessonById(UUID lessonId) {
        Lesson lesson = lessonRepository.findById(lessonId)
                .orElseThrow(LessonNotFoundException::new);
        return toResponse(lesson);
    }

    private LessonResponse toResponse(Lesson lesson) {
        try {
            com.fasterxml.jackson.databind.JsonNode contentBlocksNode =
                new com.fasterxml.jackson.databind.ObjectMapper().readTree(
                    lesson.getContentBlocks() != null ? lesson.getContentBlocks() : "[]");

            return new LessonResponse(
                lesson.getId(),
                lesson.getSubtopicId(),
                lesson.getTitle(),
                lesson.getSlug(),
                lesson.getSummary(),
                contentBlocksNode,
                lesson.getEstimatedMinutes(),
                lesson.getXpReward(),
                lesson.getDisplayOrder(),
                lesson.getPublished(),
                lesson.getCreatedAt(),
                lesson.getUpdatedAt()
            );
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse lesson content blocks JSON", e);
        }
    }
}
