package com.nerdquiz.service;

import com.nerdquiz.dto.TopicProgressResponse;
import com.nerdquiz.dto.TopicResponse;
import com.nerdquiz.model.Subtopic;
import com.nerdquiz.model.Topic;
import com.nerdquiz.repository.LessonRepository;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.SubtopicRepository;
import com.nerdquiz.repository.TopicRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class TopicService {

    private static final Set<String> VALID_CATEGORIES =
            Set.of("Technology", "Security", "Management", "Strategy", "Business");
    private static final String DEFAULT_SUBJECT = "A";
    private static final String DEFAULT_DESCRIPTION = "Lessons coming soon.";

    private final TopicRepository topicRepository;
    private final SubtopicRepository subtopicRepository;
    private final QuestionRepository questionRepository;
    private final LessonRepository lessonRepository;

    public TopicService(TopicRepository topicRepository,
                        SubtopicRepository subtopicRepository,
                        QuestionRepository questionRepository,
                        LessonRepository lessonRepository) {
        this.topicRepository = topicRepository;
        this.subtopicRepository = subtopicRepository;
        this.questionRepository = questionRepository;
        this.lessonRepository = lessonRepository;
    }

    @Transactional(readOnly = true)
    public List<TopicResponse> getLearningMap(UUID userId) {
        Map<UUID, Topic> topicsById = topicRepository.findByPublishedTrueOrderByDisplayOrderAsc()
                .stream()
                .filter(t -> VALID_CATEGORIES.contains(t.getName()))
                .collect(Collectors.toMap(Topic::getId, t -> t));

        List<Subtopic> subtopics = subtopicRepository.findByPublishedTrueOrderByDisplayOrderAsc()
                .stream()
                .filter(s -> topicsById.containsKey(s.getTopicId()))
                .toList();

        Map<UUID, Long> questionCountBySubtopic = questionRepository
                .countPublishedGroupedBySubtopic()
                .stream()
                .collect(Collectors.toMap(
                        QuestionRepository.SubtopicQuestionCount::getSubtopicId,
                        QuestionRepository.SubtopicQuestionCount::getCnt));

        Map<UUID, Long> totalLessonsBySubtopic = lessonRepository
                .countPublishedLessonsBySubtopic()
                .stream()
                .collect(Collectors.toMap(
                        LessonRepository.SubtopicLessonCount::getSubtopicId,
                        LessonRepository.SubtopicLessonCount::getCnt));

        Map<UUID, Long> completedLessonsBySubtopic = userId == null
                ? Map.of()
                : lessonRepository.countCompletedLessonsBySubtopicForUser(userId).stream()
                        .collect(Collectors.toMap(
                                LessonRepository.SubtopicLessonCount::getSubtopicId,
                                LessonRepository.SubtopicLessonCount::getCnt));

        Map<UUID, List<Subtopic>> byCategoryId = subtopics.stream()
                .collect(Collectors.groupingBy(Subtopic::getTopicId));

        List<TopicResponse> result = new ArrayList<>();
        for (Topic topic : topicsById.values()) {
            List<Subtopic> group = byCategoryId.getOrDefault(topic.getId(), List.of())
                    .stream()
                    .sorted(Comparator.comparingInt(Subtopic::getDisplayOrder))
                    .toList();

            UUID previousId = null;
            for (Subtopic sub : group) {
                int questionCount = questionCountBySubtopic
                        .getOrDefault(sub.getId(), 0L).intValue();

                int totalLessons = totalLessonsBySubtopic.getOrDefault(sub.getId(), 0L).intValue();
                int completedLessons = completedLessonsBySubtopic.getOrDefault(sub.getId(), 0L).intValue();

                boolean prereqCompleted = previousId == null
                        || isSubtopicCompleted(previousId, totalLessonsBySubtopic, completedLessonsBySubtopic);

                String status = deriveStatus(totalLessons, completedLessons, prereqCompleted);

                // TODO: Track actual question answers at subtopic level
                // For now, use lesson completion as a proxy for progress
                TopicProgressResponse progress = completedLessons > 0
                        ? new TopicProgressResponse(sub.getId(), status, completedLessons, 0, null)
                        : null;

                String description = sub.getDescription() == null || sub.getDescription().isBlank()
                        ? DEFAULT_DESCRIPTION
                        : sub.getDescription();

                result.add(new TopicResponse(
                        sub.getId(),
                        DEFAULT_SUBJECT,
                        topic.getName(),
                        sub.getDisplayOrder(),
                        sub.getName(),
                        description,
                        questionCount,
                        previousId,
                        status,
                        progress
                ));

                previousId = sub.getId();
            }
        }

        return result;
    }

    private static boolean isSubtopicCompleted(UUID subtopicId,
                                               Map<UUID, Long> totals,
                                               Map<UUID, Long> completed) {
        long total = totals.getOrDefault(subtopicId, 0L);
        long done = completed.getOrDefault(subtopicId, 0L);
        return total > 0 && done >= total;
    }

    private static String deriveStatus(int totalLessons, int completedLessons, boolean prereqCompleted) {
        if (!prereqCompleted) return "locked";
        if (totalLessons > 0 && completedLessons >= totalLessons) return "completed";
        if (completedLessons > 0) return "in_progress";
        return "not_started";
    }
}
