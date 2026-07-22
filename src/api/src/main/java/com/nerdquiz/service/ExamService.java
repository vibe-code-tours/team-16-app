package com.nerdquiz.service;

import com.nerdquiz.dto.*;
import com.nerdquiz.exception.ExamSessionNotFoundException;
import com.nerdquiz.exception.NoQuestionsAvailableException;
import com.nerdquiz.exception.QuestionNotFoundException;
import com.nerdquiz.exception.UnauthorizedQuizAccessException;
import com.nerdquiz.model.ExamAnswer;
import com.nerdquiz.model.ExamHeartEvent;
import com.nerdquiz.model.ExamSession;
import com.nerdquiz.model.ExamSessionQuestion;
import com.nerdquiz.model.Question;
import com.nerdquiz.repository.ExamAnswerRepository;
import com.nerdquiz.repository.ExamHeartEventRepository;
import com.nerdquiz.repository.ExamSessionQuestionRepository;
import com.nerdquiz.repository.ExamSessionRepository;
import com.nerdquiz.repository.QuestionRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Instant;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class ExamService {

    private static final int DEFAULT_QUESTION_COUNT = 60;
    private static final int TIME_LIMIT_MINUTES = 60;
    private static final int INITIAL_HEARTS = 3;
    private static final int XP_PER_CORRECT_ANSWER = 10;
    private static final Set<String> ALLOWED_DIFFICULTIES = Set.of("easy", "medium", "hard");
    private static final Set<String> FINISH_STATUSES = Set.of("completed", "expired", "abandoned");

    private final QuestionRepository questionRepository;
    private final ExamSessionRepository examSessionRepository;
    private final ExamAnswerRepository examAnswerRepository;
    private final ExamHeartEventRepository examHeartEventRepository;
    private final ExamSessionQuestionRepository examSessionQuestionRepository;
    private final QuestionService questionService;
    private final UserService userService;

    public ExamService(QuestionRepository questionRepository,
                       ExamSessionRepository examSessionRepository,
                       ExamAnswerRepository examAnswerRepository,
                       ExamHeartEventRepository examHeartEventRepository,
                       ExamSessionQuestionRepository examSessionQuestionRepository,
                       QuestionService questionService,
                       UserService userService) {
        this.questionRepository = questionRepository;
        this.examSessionRepository = examSessionRepository;
        this.examAnswerRepository = examAnswerRepository;
        this.examHeartEventRepository = examHeartEventRepository;
        this.examSessionQuestionRepository = examSessionQuestionRepository;
        this.questionService = questionService;
        this.userService = userService;
    }

    @Transactional
    public StartExamResponse startExam(UUID userId, StartExamRequest request) {
        int questionCount = request.questionCount() == null ? DEFAULT_QUESTION_COUNT : request.questionCount();
        String difficulty = normalizeDifficulty(request.difficulty());

        List<Question> questions = questionRepository.findUsableExamQuestions(questionCount, difficulty);
        if (questions.isEmpty()) {
            throw new NoQuestionsAvailableException();
        }

        Instant startedAt = Instant.now();
        ExamSession session = new ExamSession();
        session.setUserId(userId);
        session.setTotalQuestions(questions.size());
        session.setInitialHearts(INITIAL_HEARTS);
        session.setHeartsRemaining(INITIAL_HEARTS);
        session.setTimeLimitMinutes(TIME_LIMIT_MINUTES);
        session.setStartedAt(startedAt);
        session.setExpiresAt(startedAt.plusSeconds(TIME_LIMIT_MINUTES * 60L));
        session.setStatus("in_progress");
        ExamSession savedSession = examSessionRepository.save(session);

        // Persist issued questions so submitAnswer can validate against them
        java.util.ArrayList<ExamSessionQuestion> sessionQuestions = new java.util.ArrayList<>();
        for (int i = 0; i < questions.size(); i++) {
            sessionQuestions.add(new ExamSessionQuestion(
                savedSession.getId(), questions.get(i).getId(), i + 1));
        }
        examSessionQuestionRepository.saveAll(sessionQuestions);

        return new StartExamResponse(
                savedSession.getId(),
                questions.stream().map(questionService::toResponse).toList(),
                savedSession.getHeartsRemaining(),
                savedSession.getTimeLimitMinutes(),
                savedSession.getExpiresAt()
        );
    }

    @Transactional
    public SubmitExamAnswerResponse submitAnswer(UUID userId, UUID sessionId, SubmitExamAnswerRequest request) {
        ExamSession session = getOwnedSession(userId, sessionId);
        if (!"in_progress".equals(session.getStatus())) {
            throw new IllegalArgumentException("Exam session is already finished");
        }

        // Enforce time limit — reject answers after expires_at
        if (session.getExpiresAt().isBefore(Instant.now())) {
            session.setStatus("expired");
            session.setCompletedAt(Instant.now());
            examSessionRepository.save(session);
            throw new IllegalArgumentException("Exam session has expired");
        }

        // Validate that the question was issued for this session
        if (!examSessionQuestionRepository.existsByExamSessionIdAndQuestionId(sessionId, request.questionId())) {
            throw new IllegalArgumentException("Question does not belong to this exam session");
        }

        Question question = questionRepository.findById(request.questionId())
                .orElseThrow(QuestionNotFoundException::new);
        boolean isCorrect = question.getCorrectAnswer().equalsIgnoreCase(request.answer());

        ExamAnswer answer = examAnswerRepository
                .findByExamSessionIdAndQuestionId(sessionId, request.questionId())
                .orElseGet(ExamAnswer::new);
        boolean isNewAnswer = answer.getId() == null;
        answer.setExamSessionId(sessionId);
        answer.setQuestionId(request.questionId());
        answer.setSequenceNumber(request.sequenceNumber());
        answer.setUserAnswer(request.answer());
        answer.setIsCorrect(isCorrect);
        answer.setResponseTimeMs(request.responseTimeMs());
        ExamAnswer savedAnswer = examAnswerRepository.save(answer);

        if (!isCorrect && isNewAnswer) {
            session.setHeartsRemaining(Math.max(0, session.getHeartsRemaining() - 1));
            ExamHeartEvent event = new ExamHeartEvent();
            event.setExamSessionId(sessionId);
            event.setQuestionId(request.questionId());
            event.setDelta(-1);
            event.setReason("wrong_answer");
            examHeartEventRepository.save(event);
        }

        examSessionRepository.save(session);
        return new SubmitExamAnswerResponse(
                savedAnswer.getId(),
                savedAnswer.getQuestionId(),
                savedAnswer.getUserAnswer(),
                savedAnswer.getIsCorrect(),
                session.getHeartsRemaining()
        );
    }

    @Transactional
    public FinishExamResponse finishExam(UUID userId, UUID sessionId, FinishExamRequest request) {
        ExamSession session = getOwnedSession(userId, sessionId);
        String requestedStatus = request.status() == null ? "completed" : request.status();
        if (!FINISH_STATUSES.contains(requestedStatus)) {
            throw new IllegalArgumentException("Invalid exam status");
        }

        int correctAnswers = (int) examAnswerRepository.countByExamSessionIdAndIsCorrectTrue(sessionId);
        BigDecimal scorePercentage = calculateScorePercentage(correctAnswers, session.getTotalQuestions());
        int xpEarned = correctAnswers * XP_PER_CORRECT_ANSWER;
        boolean shouldAwardXp = "in_progress".equals(session.getStatus()) && !"abandoned".equals(requestedStatus);

        if ("in_progress".equals(session.getStatus())) {
            session.setCorrectAnswers(correctAnswers);
            session.setScorePercentage(scorePercentage);
            session.setCompletedAt(Instant.now());
            session.setStatus(requestedStatus);
            examSessionRepository.save(session);
        }

        if (shouldAwardXp && xpEarned > 0) {
            userService.incrementUserXp(userId, xpEarned);
        }

        int reportedXp = "abandoned".equals(session.getStatus()) ? 0 : xpEarned;

        return new FinishExamResponse(
                session.getId(),
                session.getTotalQuestions(),
                correctAnswers,
                scorePercentage,
                session.getHeartsRemaining(),
                session.getStatus(),
                reportedXp
        );
    }

    private ExamSession getOwnedSession(UUID userId, UUID sessionId) {
        ExamSession session = examSessionRepository.findById(sessionId)
                .orElseThrow(ExamSessionNotFoundException::new);
        if (!session.getUserId().equals(userId)) {
            throw new UnauthorizedQuizAccessException();
        }
        return session;
    }

    private String normalizeDifficulty(String difficulty) {
        if (difficulty == null || difficulty.isBlank() || "all".equalsIgnoreCase(difficulty)) {
            return null;
        }
        String normalized = difficulty.toLowerCase();
        if (!ALLOWED_DIFFICULTIES.contains(normalized)) {
            throw new IllegalArgumentException("Invalid difficulty");
        }
        return normalized;
    }

    private BigDecimal calculateScorePercentage(int correctAnswers, int totalQuestions) {
        if (totalQuestions <= 0) {
            return BigDecimal.ZERO.setScale(2, RoundingMode.HALF_UP);
        }
        return BigDecimal.valueOf(correctAnswers)
                .multiply(BigDecimal.valueOf(100))
                .divide(BigDecimal.valueOf(totalQuestions), 2, RoundingMode.HALF_UP);
    }
}
