package com.nerdquiz.service;

import com.nerdquiz.dto.TopicProgressResponse;
import com.nerdquiz.dto.TopicResponse;
import com.nerdquiz.model.Subtopic;
import com.nerdquiz.model.Topic;
import com.nerdquiz.model.UserSubtopicMastery;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.SubtopicRepository;
import com.nerdquiz.repository.TopicRepository;
import com.nerdquiz.repository.UserSubtopicMasteryRepository;
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
    private final UserSubtopicMasteryRepository masteryRepository;
    private final QuestionRepository questionRepository;

    public TopicService(TopicRepository topicRepository,
                        SubtopicRepository subtopicRepository,
                        UserSubtopicMasteryRepository masteryRepository,
                        QuestionRepository questionRepository) {
        this.topicRepository = topicRepository;
        this.subtopicRepository = subtopicRepository;
        this.masteryRepository = masteryRepository;
        this.questionRepository = questionRepository;
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

        Map<UUID, UserSubtopicMastery> masteryBySubtopic = userId == null
                ? Map.of()
                : masteryRepository.findByUserId(userId).stream()
                        .collect(Collectors.toMap(UserSubtopicMastery::getSubtopicId, m -> m));

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

                UserSubtopicMastery mastery = masteryBySubtopic.get(sub.getId());
                TopicProgressResponse progress = mastery == null
                        ? null
                        : toProgress(mastery, questionCount);

                String status = deriveStatus(progress, previousId, masteryBySubtopic, questionCountBySubtopic);

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

    private TopicProgressResponse toProgress(UserSubtopicMastery mastery, int questionCount) {
        int answered = mastery.getQuestionsSeen();
        int correct = mastery.getQuestionsCorrect();
        String status = (questionCount > 0 && answered >= questionCount)
                ? "completed"
                : (answered > 0 ? "in_progress" : "not_started");
        return new TopicProgressResponse(
                mastery.getSubtopicId(),
                status,
                answered,
                correct,
                mastery.getLastPracticedAt()
        );
    }

    private String deriveStatus(TopicProgressResponse progress,
                                UUID prerequisiteId,
                                Map<UUID, UserSubtopicMastery> masteryBySubtopic,
                                Map<UUID, Long> questionCountBySubtopic) {
        if (progress != null) return progress.status();
        if (prerequisiteId == null) return "not_started";
        UserSubtopicMastery prereq = masteryBySubtopic.get(prerequisiteId);
        if (prereq == null) return "locked";
        int prereqQuestions = questionCountBySubtopic.getOrDefault(prerequisiteId, 0L).intValue();
        boolean prereqCompleted = prereqQuestions > 0 && prereq.getQuestionsSeen() >= prereqQuestions;
        return prereqCompleted ? "not_started" : "locked";
    }
}
