package com.nerdquiz.service;

import com.nerdquiz.dto.MistakeResponse;
import com.nerdquiz.dto.MistakeResponse.ChoiceOption;
import com.nerdquiz.dto.RecordMistakeRequest;
import com.nerdquiz.exception.MistakeNotFoundException;
import com.nerdquiz.exception.QuestionNotFoundException;
import com.nerdquiz.model.Question;
import com.nerdquiz.model.Subtopic;
import com.nerdquiz.model.Topic;
import com.nerdquiz.model.UserMistake;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.SubtopicRepository;
import com.nerdquiz.repository.TopicRepository;
import com.nerdquiz.repository.UserMistakeRepository;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class MistakeService {

    private static final int DEFAULT_PAGE_SIZE = 20;
    private static final int MAX_PAGE_SIZE = 100;

    private final UserMistakeRepository userMistakeRepository;
    private final QuestionRepository questionRepository;
    private final SubtopicRepository subtopicRepository;
    private final TopicRepository topicRepository;
    private final ObjectMapper objectMapper;

    public MistakeService(UserMistakeRepository userMistakeRepository,
                          QuestionRepository questionRepository,
                          SubtopicRepository subtopicRepository,
                          TopicRepository topicRepository,
                          ObjectMapper objectMapper) {
        this.userMistakeRepository = userMistakeRepository;
        this.questionRepository = questionRepository;
        this.subtopicRepository = subtopicRepository;
        this.topicRepository = topicRepository;
        this.objectMapper = objectMapper;
    }

    @Transactional
    public MistakeResponse recordMistake(UUID userId, RecordMistakeRequest request) {
        if (!questionRepository.existsById(request.questionId())) {
            throw new QuestionNotFoundException();
        }

        // Upsert: if the user already got this question wrong, update the record
        // instead of creating a duplicate.
        UserMistake mistake = userMistakeRepository
                .findByUserIdAndQuestionId(userId, request.questionId())
                .orElseGet(() -> {
                    UserMistake newMistake = new UserMistake();
                    newMistake.setUserId(userId);
                    newMistake.setQuestionId(request.questionId());
                    newMistake.setReviewed(false);
                    return newMistake;
                });
        mistake.setSelectedLabel(request.selectedLabel());
        mistake.setCreatedAt(Instant.now());
        UserMistake saved = userMistakeRepository.save(mistake);

        Question question = questionRepository.findById(saved.getQuestionId()).orElse(null);
        return toResponse(saved, question, Collections.emptyMap(), Collections.emptyMap());
    }

    @Transactional(readOnly = true)
    public List<MistakeResponse> getUserMistakes(UUID userId) {
        // Default to first page with max size to avoid unbounded queries
        return getUserMistakes(userId, 0, MAX_PAGE_SIZE);
    }

    @Transactional(readOnly = true)
    public List<MistakeResponse> getUserMistakes(UUID userId, int page, int size) {
        int pageSize = Math.min(size, MAX_PAGE_SIZE);
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by(Sort.Direction.DESC, "createdAt"));

        List<UserMistake> mistakes = userMistakeRepository.findByUserIdOrderByCreatedAtDesc(userId, pageable);

        Set<UUID> questionIds = mistakes.stream()
                .map(UserMistake::getQuestionId)
                .collect(Collectors.toSet());

        Map<UUID, Question> questions = questionRepository.findByIdIn(questionIds).stream()
                .collect(Collectors.toMap(Question::getId, q -> q));

        // Fetch subtopic and topic info for categorization
        Set<UUID> subtopicIds = questions.values().stream()
                .map(Question::getSubtopicId)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());
        Map<UUID, Subtopic> subtopics = subtopicRepository.findAllById(subtopicIds).stream()
                .collect(Collectors.toMap(Subtopic::getId, s -> s));
        Set<UUID> topicIds = subtopics.values().stream()
                .map(Subtopic::getTopicId)
                .collect(Collectors.toSet());
        Map<UUID, Topic> topics = topicRepository.findAllById(topicIds).stream()
                .collect(Collectors.toMap(Topic::getId, t -> t));

        return mistakes.stream()
                .map(m -> toResponse(m, questions.get(m.getQuestionId()), subtopics, topics))
                .collect(Collectors.toList());
    }

    @Transactional
    public void reviewMistake(UUID userId, UUID mistakeId) {
        UserMistake mistake = userMistakeRepository.findByIdAndUserId(mistakeId, userId)
                .orElseThrow(() -> new MistakeNotFoundException("Mistake not found or access denied"));
        mistake.setReviewed(true);
        userMistakeRepository.save(mistake);
    }

    private MistakeResponse toResponse(UserMistake mistake, Question question,
                                        Map<UUID, Subtopic> subtopics, Map<UUID, Topic> topics) {
        UUID questionId = mistake.getQuestionId();
        String questionText = question != null ? question.getQuestionText() : null;
        String correctAnswer = question != null ? question.getCorrectAnswer() : null;
        String explanation = question != null ? question.getExplanation() : null;
        List<ChoiceOption> choices = parseChoices(question);
        String lastUserAnswer = mistake.getSelectedLabel();
        Instant lastMissedAt = mistake.getCreatedAt();

        UUID subtopicId = question != null ? question.getSubtopicId() : null;
        String subtopicName = null;
        String topicName = null;
        if (subtopicId != null) {
            Subtopic subtopic = subtopics.get(subtopicId);
            if (subtopic != null) {
                subtopicName = subtopic.getName();
                Topic topic = topics.get(subtopic.getTopicId());
                if (topic != null) {
                    topicName = topic.getName();
                }
            }
        }

        return new MistakeResponse(
                mistake.getId(),
                questionId,
                subtopicId,
                subtopicName,
                topicName,
                questionText,
                correctAnswer,
                choices,
                explanation,
                lastUserAnswer,
                lastMissedAt
        );
    }

    private List<ChoiceOption> parseChoices(Question question) {
        if (question == null || question.getChoices() == null) {
            return Collections.emptyList();
        }
        try {
            List<Map<String, String>> raw = objectMapper.readValue(
                    question.getChoices(), new TypeReference<>() {});
            return raw.stream()
                    .map(m -> new ChoiceOption(m.get("label"), m.get("text")))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            return Collections.emptyList();
        }
    }
}
