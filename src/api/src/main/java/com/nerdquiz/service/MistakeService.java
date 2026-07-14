package com.nerdquiz.service;

import com.nerdquiz.dto.MistakeResponse;
import com.nerdquiz.exception.MistakeNotFoundException;
import com.nerdquiz.exception.QuestionNotFoundException;
import com.nerdquiz.model.Question;
import com.nerdquiz.model.UserMistake;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.UserMistakeRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class MistakeService {

    private final UserMistakeRepository userMistakeRepository;
    private final QuestionRepository questionRepository;

    public MistakeService(UserMistakeRepository userMistakeRepository,
                          QuestionRepository questionRepository) {
        this.userMistakeRepository = userMistakeRepository;
        this.questionRepository = questionRepository;
    }

    @Transactional(readOnly = true)
    public List<MistakeResponse> getMistakes(UUID userId) {
        List<UserMistake> mistakes = userMistakeRepository.findByUserIdOrderByLastMissedAtDesc(userId);

        List<UUID> questionIds = mistakes.stream()
                .map(UserMistake::getQuestionId)
                .toList();

        Map<UUID, Question> questionMap = questionRepository.findByIdIn(questionIds).stream()
                .collect(Collectors.toMap(Question::getId, q -> q));

        return mistakes.stream()
                .map(mistake -> toResponse(mistake, questionMap.get(mistake.getQuestionId())))
                .toList();
    }

    @Transactional
    public MistakeResponse addMistake(UUID userId, UUID questionId, String source,
                                       UUID sourceSessionId, String userAnswer) {
        Question question = questionRepository.findById(questionId)
                .orElseThrow(QuestionNotFoundException::new);

        Optional<UserMistake> existing = userMistakeRepository.findByUserIdAndQuestionId(userId, questionId);

        UserMistake mistake;
        if (existing.isPresent()) {
            mistake = existing.get();
            mistake.setMistakeCount(mistake.getMistakeCount() + 1);
            mistake.setLastUserAnswer(userAnswer);
            mistake.setLastMissedAt(Instant.now());
        } else {
            mistake = new UserMistake();
            mistake.setUserId(userId);
            mistake.setQuestionId(questionId);
            mistake.setSource(source);
            mistake.setSourceSessionId(sourceSessionId);
            mistake.setLastUserAnswer(userAnswer);
            mistake.setMistakeCount(1);
            mistake.setFirstMissedAt(Instant.now());
            mistake.setLastMissedAt(Instant.now());
        }

        UserMistake saved = userMistakeRepository.save(mistake);
        return toResponse(saved, question);
    }

    @Transactional
    public MistakeResponse markReviewed(UUID userId, UUID mistakeId) {
        UserMistake mistake = userMistakeRepository.findById(mistakeId)
                .orElseThrow(MistakeNotFoundException::new);

        if (!mistake.getUserId().equals(userId)) {
            throw new MistakeNotFoundException("Unauthorized access to mistake");
        }

        mistake.setReviewCount(mistake.getReviewCount() + 1);
        mistake.setLastReviewedAt(Instant.now());

        UserMistake saved = userMistakeRepository.save(mistake);

        Question question = questionRepository.findById(saved.getQuestionId())
                .orElseThrow(QuestionNotFoundException::new);

        return toResponse(saved, question);
    }

    private MistakeResponse toResponse(UserMistake mistake, Question question) {
        return new MistakeResponse(
            mistake.getId(),
            mistake.getUserId(),
            mistake.getQuestionId(),
            question != null ? question.getQuestionText() : null,
            question != null ? question.getCorrectAnswer() : null,
            mistake.getSource(),
            mistake.getSourceSessionId(),
            mistake.getLastUserAnswer(),
            mistake.getMistakeCount(),
            mistake.getReviewCount(),
            mistake.getFirstMissedAt(),
            mistake.getLastMissedAt(),
            mistake.getLastReviewedAt(),
            mistake.getNextReviewAt(),
            mistake.getResolvedAt()
        );
    }
}
