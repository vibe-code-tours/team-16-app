package com.nerdquiz.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nerdquiz.dto.*;
import com.nerdquiz.exception.*;
import com.nerdquiz.model.Question;
import com.nerdquiz.model.QuizAnswer;
import com.nerdquiz.model.QuizSession;
import com.nerdquiz.model.QuizSessionQuestion;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.QuizAnswerRepository;
import com.nerdquiz.repository.QuizSessionQuestionRepository;
import com.nerdquiz.repository.QuizSessionRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class QuizService {

    private static final int XP_PER_CORRECT_ANSWER = 10;

    private final QuestionRepository questionRepository;
    private final QuizSessionRepository quizSessionRepository;
    private final QuizAnswerRepository quizAnswerRepository;
    private final QuizSessionQuestionRepository quizSessionQuestionRepository;
    private final QuestionService questionService;
    private final WeakPointService weakPointService;
    private final UserDailyActivityService activityService;
    private final ObjectMapper objectMapper;

    public QuizService(QuestionRepository questionRepository,
                       QuizSessionRepository quizSessionRepository,
                       QuizAnswerRepository quizAnswerRepository,
                       QuizSessionQuestionRepository quizSessionQuestionRepository,
                       QuestionService questionService,
                       WeakPointService weakPointService,
                       UserDailyActivityService activityService,
                       ObjectMapper objectMapper) {
        this.questionRepository = questionRepository;
        this.quizSessionRepository = quizSessionRepository;
        this.quizAnswerRepository = quizAnswerRepository;
        this.quizSessionQuestionRepository = quizSessionQuestionRepository;
        this.questionService = questionService;
        this.weakPointService = weakPointService;
        this.activityService = activityService;
        this.objectMapper = objectMapper;
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
            throw new NoQuestionsAvailableException();
        }

        // Create quiz session
        QuizSession session = new QuizSession();
        session.setUserId(userId);
        session.setSubtopicId(request.subtopicId());
        session.setQuestionCount(questions.size());
        session = quizSessionRepository.save(session);

        // Persist issued questions so submitAnswer can validate against them
        List<QuizSessionQuestion> sessionQuestions = new java.util.ArrayList<>();
        for (int i = 0; i < questions.size(); i++) {
            sessionQuestions.add(new QuizSessionQuestion(
                session.getId(), questions.get(i).getId(), i + 1));
        }
        quizSessionQuestionRepository.saveAll(sessionQuestions);

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
    public QuizAnswerResponse submitAnswer(UUID userId, UUID sessionId, SubmitAnswerRequest request) {
        QuizSession session = quizSessionRepository.findById(sessionId)
                .orElseThrow(() -> new QuizSessionNotFoundException());

        if (!session.getUserId().equals(userId)) {
            throw new UnauthorizedQuizAccessException();
        }

        if ("completed".equals(session.getStatus())) {
            throw new QuizAlreadyCompletedException();
        }

        // Validate that the question was issued for this session
        if (!quizSessionQuestionRepository.existsByQuizSessionIdAndQuestionId(sessionId, request.questionId())) {
            throw new QuestionNotInQuizSessionException();
        }

        // Reject duplicate answers for the same question in this session
        if (quizAnswerRepository.existsByQuizSessionIdAndQuestionId(sessionId, request.questionId())) {
            throw new DuplicateAnswerException();
        }

        Question question = questionRepository.findById(request.questionId())
                .orElseThrow(() -> new QuestionNotFoundException());

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

        // Check if all questions answered (count includes the answer we're about to save)
        long answeredCount = quizAnswerRepository.countByQuizSessionId(sessionId);
        if (answeredCount + 1 >= session.getQuestionCount()) {
            session.setStatus("completed");
            session.setCompletedAt(Instant.now());
        }

        quizSessionRepository.save(session);
        QuizAnswer savedAnswer = quizAnswerRepository.save(answer);

        // Record daily activity when quiz is completed
        if ("completed".equals(session.getStatus())) {
            activityService.recordActivity(userId, 1, session.getXpEarned());
        }

        weakPointService.updateMastery(userId, request.questionId(), isCorrect);

        return toAnswerResponse(savedAnswer);
    }

    @Transactional(readOnly = true)
    public QuizResultResponse getResult(UUID userId, UUID sessionId) {
        QuizSession session = quizSessionRepository.findById(sessionId)
                .orElseThrow(() -> new QuizSessionNotFoundException());

        if (!session.getUserId().equals(userId)) {
            throw new UnauthorizedQuizAccessException();
        }

        List<QuizAnswer> answers = quizAnswerRepository.findByQuizSessionId(sessionId);

        List<UUID> questionIds = answers.stream()
                .map(QuizAnswer::getQuestionId)
                .toList();
        Map<UUID, Question> questionMap = questionRepository.findByIdIn(questionIds).stream()
                .collect(Collectors.toMap(Question::getId, q -> q));

        List<QuizResultResponse.AnswerResult> answerResults = answers.stream()
                .map(answer -> {
                    Question question = questionMap.get(answer.getQuestionId());
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

    private QuizAnswerResponse toAnswerResponse(QuizAnswer answer) {
        return new QuizAnswerResponse(
            answer.getId(),
            answer.getQuizSessionId(),
            answer.getQuestionId(),
            answer.getUserAnswer(),
            answer.getIsCorrect(),
            answer.getAnsweredAt()
        );
    }

    private QuestionResponse toResponse(Question question) {
        try {
            com.fasterxml.jackson.databind.JsonNode imagesNode =
                objectMapper.readTree(
                    question.getImages() != null ? question.getImages() : "[]");
            com.fasterxml.jackson.databind.JsonNode choicesNode =
                objectMapper.readTree(question.getChoices());

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
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse question JSON", e);
        }
    }

    private QuestionResponse toResponseWithoutAnswer(Question question) {
        try {
            com.fasterxml.jackson.databind.JsonNode imagesNode =
                objectMapper.readTree(
                    question.getImages() != null ? question.getImages() : "[]");
            com.fasterxml.jackson.databind.JsonNode choicesNode =
                objectMapper.readTree(question.getChoices());

            return new QuestionResponse(
                question.getId(),
                question.getSubtopicId(),
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
