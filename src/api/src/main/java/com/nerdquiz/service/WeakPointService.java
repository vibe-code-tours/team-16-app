package com.nerdquiz.service;

import com.nerdquiz.dto.WeakPointResponse;
import com.nerdquiz.model.Question;
import com.nerdquiz.model.UserSubtopicMastery;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.UserSubtopicMasteryRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

@Service
public class WeakPointService {

    private final UserSubtopicMasteryRepository masteryRepository;
    private final QuestionRepository questionRepository;

    public WeakPointService(UserSubtopicMasteryRepository masteryRepository,
                            QuestionRepository questionRepository) {
        this.masteryRepository = masteryRepository;
        this.questionRepository = questionRepository;
    }

    @Transactional
    public void updateMastery(UUID userId, UUID questionId, boolean isCorrect) {
        Question question = questionRepository.findById(questionId).orElse(null);
        if (question == null || question.getSubtopicId() == null) {
            return;
        }

        UUID subtopicId = question.getSubtopicId();
        UserSubtopicMastery.PK pk = new UserSubtopicMastery.PK(userId, subtopicId);

        UserSubtopicMastery mastery = masteryRepository.findById(pk)
                .orElseGet(() -> {
                    UserSubtopicMastery newMastery = new UserSubtopicMastery();
                    newMastery.setUserId(userId);
                    newMastery.setSubtopicId(subtopicId);
                    return newMastery;
                });

        mastery.setQuestionsSeen(mastery.getQuestionsSeen() + 1);
        if (isCorrect) {
            mastery.setQuestionsCorrect(mastery.getQuestionsCorrect() + 1);
        }

        BigDecimal score = BigDecimal.valueOf(mastery.getQuestionsCorrect())
                .divide(BigDecimal.valueOf(mastery.getQuestionsSeen()), 4, RoundingMode.HALF_UP);
        mastery.setMasteryScore(score);
        mastery.setLastPracticedAt(Instant.now());

        masteryRepository.save(mastery);
    }

    @Transactional(readOnly = true)
    public WeakPointResponse getWeakPointAnalysis(UUID userId) {
        List<WeakPointResponse.TopicMastery> topics = masteryRepository
                .findTopicMasteryByUserId(userId).stream()
                .map(p -> new WeakPointResponse.TopicMastery(
                        p.getTopicId(),
                        p.getTopicName(),
                        p.getTopicSlug(),
                        p.getMasteryScore(),
                        p.getQuestionsSeen().intValue(),
                        p.getQuestionsCorrect().intValue()
                ))
                .sorted((a, b) -> Double.compare(a.masteryScore(), b.masteryScore()))
                .toList();

        List<WeakPointResponse.SubtopicMastery> subtopics = masteryRepository
                .findAllSubtopicMasteryByUserId(userId).stream()
                .map(p -> new WeakPointResponse.SubtopicMastery(
                        p.getSubtopicId(),
                        p.getTopicId(),
                        p.getSubtopicName(),
                        p.getSubtopicSlug(),
                        p.getMasteryScore(),
                        p.getQuestionsSeen().intValue(),
                        p.getQuestionsCorrect().intValue()
                ))
                .toList();

        return new WeakPointResponse(topics, subtopics);
    }
}
