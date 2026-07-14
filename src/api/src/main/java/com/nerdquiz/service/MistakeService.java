package com.nerdquiz.service;

import com.nerdquiz.dto.MistakeResponse;
import com.nerdquiz.dto.RecordMistakeRequest;
import com.nerdquiz.exception.QuestionNotFoundException;
import com.nerdquiz.model.UserMistake;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.UserMistakeRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
public class MistakeService {

    private final UserMistakeRepository userMistakeRepository;
    private final QuestionRepository questionRepository;

    public MistakeService(UserMistakeRepository userMistakeRepository,
                          QuestionRepository questionRepository) {
        this.userMistakeRepository = userMistakeRepository;
        this.questionRepository = questionRepository;
    }

    @Transactional
    public MistakeResponse recordMistake(UUID userId, RecordMistakeRequest request) {
        if (!questionRepository.existsById(request.questionId())) {
            throw new QuestionNotFoundException();
        }

        UserMistake mistake = new UserMistake();
        mistake.setUserId(userId);
        mistake.setQuestionId(request.questionId());
        mistake.setSelectedLabel(request.selectedLabel());
        UserMistake saved = userMistakeRepository.save(mistake);

        return new MistakeResponse(
                saved.getId(),
                saved.getQuestionId(),
                saved.getSelectedLabel(),
                saved.getCreatedAt(),
                saved.getReviewed()
        );
    }
}
