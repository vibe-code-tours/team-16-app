package com.nerdquiz.service;

import com.nerdquiz.dto.QuestionResponse;
import com.nerdquiz.dto.ExamQuestionResponse;
import com.nerdquiz.model.Question;
import com.nerdquiz.repository.QuestionRepository;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class QuestionService {

    private final QuestionRepository questionRepository;
    private final ObjectMapper objectMapper;

    public QuestionService(QuestionRepository questionRepository, ObjectMapper objectMapper) {
        this.questionRepository = questionRepository;
        this.objectMapper = objectMapper;
    }

    public List<QuestionResponse> getRandomQuestions(int count) {
        return questionRepository.findRandomQuestions(count).stream()
                .map(this::toResponse)
                .toList();
    }

    public List<QuestionResponse> getRandomQuestionsBySubtopic(UUID subtopicId, int count) {
        return questionRepository.findRandomBySubtopicIdLimit(subtopicId, count).stream()
                .map(this::toResponse)
                .toList();
    }

    public List<QuestionResponse> getUsableQuizForSubtopic(UUID subtopicId, int count) {
        return questionRepository.findUsableQuizBySubtopic(subtopicId, count).stream()
                .map(this::toResponse)
                .toList();
    }

    public List<QuestionResponse> getByExamSession(String examSession, String subject) {
        return questionRepository.findByExamSessionAndSubject(examSession, subject).stream()
                .map(this::toResponse)
                .toList();
    }

    public long countByExamSession(String examSession, String subject) {
        return questionRepository.countByExamSessionAndSubject(examSession, subject);
    }

    public QuestionResponse toResponse(Question question) {
        try {
            JsonNode imagesNode = objectMapper.readTree(question.getImages() != null ? question.getImages() : "[]");
            JsonNode choicesNode = objectMapper.readTree(question.getChoices());

            return new QuestionResponse(
                question.getId(),
                question.getSubtopicId(),
                question.getExamSession(),
                question.getSubject(),
                question.getQuestionNumber(),
                question.getQuestionText(),
                imagesNode,
                choicesNode,
                question.getCorrectAnswer(),
                question.getExplanation(),
                question.getDifficulty()
            );
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Failed to parse question JSON", e);
        }
    }

    public ExamQuestionResponse toExamResponse(Question question) {
        try {
            return new ExamQuestionResponse(
                question.getId(),
                question.getQuestionNumber(),
                question.getQuestionText(),
                objectMapper.readTree(question.getImages() != null ? question.getImages() : "[]"),
                objectMapper.readTree(question.getChoices()),
                question.getDifficulty(),
                true
            );
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Failed to parse exam question JSON", e);
        }
    }
}
