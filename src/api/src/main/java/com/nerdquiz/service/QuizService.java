package com.nerdquiz.service;

import com.nerdquiz.dto.*;
import com.nerdquiz.model.Question;
import com.nerdquiz.model.QuizAnswer;
import com.nerdquiz.model.QuizSession;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.QuizAnswerRepository;
import com.nerdquiz.repository.QuizSessionRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
public class QuizService {

    private static final int XP_PER_CORRECT_ANSWER = 10;

    private final QuestionRepository questionRepository;
    private final QuizSessionRepository quizSessionRepository;
    private final QuizAnswerRepository quizAnswerRepository;
    private final QuestionService questionService;

    public QuizService(QuestionRepository questionRepository,
                       QuizSessionRepository quizSessionRepository,
                       QuizAnswerRepository quizAnswerRepository,
                       QuestionService questionService) {
        this.questionRepository = questionRepository;
        this.quizSessionRepository = quizSessionRepository;
        this.quizAnswerRepository = quizAnswerRepository;
        this.questionService = questionService;
    }

    @Transactional
    public QuizSessionResponse startQuiz(UUID userId, StartQuizRequest request) {
        // Get random questions
        List<Question> questions;
        if (request.subtopicId() != null) {
            questions = questionRepository.findRandomBySubtopicIdLimit(
                request.subtopicId(), request.questionCount());
        } else {
            questions = questionRepository.findRandomQuestions(request.questionCount());
        }

        if (questions.isEmpty()) {
            throw new RuntimeException("No questions available");
        }

        // Create quiz session
        QuizSession session = new QuizSession();
        session.setUserId(userId);
        session.setSubtopicId(request.subtopicId());
        session.setQuestionCount(questions.size());
        session = quizSessionRepository.save(session);

        // Convert to response (without correct answers)
        List<QuestionResponse> questionResponses = questions.stream()
                .map(q -> toResponseWithoutAnswer(q))
                .toList();

        return new QuizSessionResponse(
            session.getId(),
            questionResponses,
            0,
            0,
            0,
            session.getStartedAt(),
            null,
            "in_progress"
        );
    }

    @Transactional
    public QuizAnswer submitAnswer(UUID userId, UUID sessionId, SubmitAnswerRequest request) {
        QuizSession session = quizSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Quiz session not found"));

        if (!session.getUserId().equals(userId)) {
            throw new RuntimeException("Unauthorized");
        }

        if ("completed".equals(session.getStatus())) {
            throw new RuntimeException("Quiz already completed");
        }

        Question question = questionRepository.findById(request.questionId())
                .orElseThrow(() -> new RuntimeException("Question not found"));

        boolean isCorrect = question.getCorrectAnswer().equalsIgnoreCase(request.answer());

        QuizAnswer answer = new QuizAnswer();
        answer.setQuizSessionId(sessionId);
        answer.setQuestionId(request.questionId());
        answer.setUserAnswer(request.answer());
        answer.setIsCorrect(isCorrect);

        // Update session score
        if (isCorrect) {
            session.setScore(session.getScore() + 1);
            session.setXpEarned(session.getXpEarned() + XP_PER_CORRECT_ANSWER);
        }

        // Check if all questions answered
        List<QuizAnswer> allAnswers = quizAnswerRepository.findByQuizSessionId(sessionId);
        if (allAnswers.size() + 1 >= session.getQuestionCount()) {
            session.setStatus("completed");
            session.setCompletedAt(Instant.now());
        }

        quizSessionRepository.save(session);
        return quizAnswerRepository.save(answer);
    }

    @Transactional(readOnly = true)
    public QuizResultResponse getResult(UUID userId, UUID sessionId) {
        QuizSession session = quizSessionRepository.findById(sessionId)
                .orElseThrow(() -> new RuntimeException("Quiz session not found"));

        if (!session.getUserId().equals(userId)) {
            throw new RuntimeException("Unauthorized");
        }

        List<QuizAnswer> answers = quizAnswerRepository.findByQuizSessionId(sessionId);

        List<QuizResultResponse.AnswerResult> answerResults = answers.stream()
                .map(answer -> {
                    Question question = questionRepository.findById(answer.getQuestionId())
                            .orElseThrow();
                    return new QuizResultResponse.AnswerResult(
                        toResponse(question),
                        answer.getUserAnswer(),
                        answer.getIsCorrect()
                    );
                })
                .toList();

        int correctCount = (int) answers.stream().filter(QuizAnswer::getIsCorrect).count();
        int total = session.getQuestionCount();
        int percentage = total > 0 ? (correctCount * 100) / total : 0;

        return new QuizResultResponse(
            sessionId,
            total,
            correctCount,
            percentage,
            session.getXpEarned(),
            answerResults
        );
    }

    private QuestionResponse toResponse(Question question) {
        try {
            com.fasterxml.jackson.databind.JsonNode imagesNode =
                new com.fasterxml.jackson.databind.ObjectMapper().readTree(
                    question.getImages() != null ? question.getImages() : "[]");
            com.fasterxml.jackson.databind.JsonNode choicesNode =
                new com.fasterxml.jackson.databind.ObjectMapper().readTree(question.getChoices());

            return new QuestionResponse(
                question.getId(),
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
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse question JSON", e);
        }
    }

    private QuestionResponse toResponseWithoutAnswer(Question question) {
        try {
            com.fasterxml.jackson.databind.JsonNode imagesNode =
                new com.fasterxml.jackson.databind.ObjectMapper().readTree(
                    question.getImages() != null ? question.getImages() : "[]");
            com.fasterxml.jackson.databind.JsonNode choicesNode =
                new com.fasterxml.jackson.databind.ObjectMapper().readTree(question.getChoices());

            return new QuestionResponse(
                question.getId(),
                question.getExamSession(),
                question.getSubject(),
                question.getQuestionNumber(),
                question.getQuestionText(),
                imagesNode,
                choicesNode,
                null, // Hide correct answer during quiz
                null, // Hide explanation during quiz
                question.getDifficulty()
            );
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse question JSON", e);
        }
    }
}
