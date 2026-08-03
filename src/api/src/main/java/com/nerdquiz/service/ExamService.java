package com.nerdquiz.service;

import com.nerdquiz.dto.*;
import com.nerdquiz.exception.*;
import com.nerdquiz.model.ExamAnswer;
import com.nerdquiz.model.ExamSession;
import com.nerdquiz.model.ExamSessionQuestion;
import com.nerdquiz.model.Question;
import com.nerdquiz.repository.ExamAnswerRepository;
import com.nerdquiz.repository.ExamSessionQuestionRepository;
import com.nerdquiz.repository.ExamSessionRepository;
import com.nerdquiz.repository.QuestionRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.dao.DataIntegrityViolationException;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.Instant;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@Service
public class ExamService {

    private static final int DEFAULT_QUESTION_COUNT = 60;
    private static final int TIME_LIMIT_MINUTES = 60;
    private static final int XP_PER_CORRECT_ANSWER = 10;
    private static final Set<String> ALLOWED_DIFFICULTIES = Set.of("easy", "medium", "hard");
    private static final Set<String> FINISH_STATUSES = Set.of("completed", "expired", "abandoned");

    private final QuestionRepository questionRepository;
    private final ExamSessionRepository examSessionRepository;
    private final ExamAnswerRepository examAnswerRepository;
    private final ExamSessionQuestionRepository examSessionQuestionRepository;
    private final QuestionService questionService;
    private final UserService userService;

    public ExamService(QuestionRepository questionRepository,
                       ExamSessionRepository examSessionRepository,
                       ExamAnswerRepository examAnswerRepository,
                       ExamSessionQuestionRepository examSessionQuestionRepository,
                       QuestionService questionService,
                       UserService userService) {
        this.questionRepository = questionRepository;
        this.examSessionRepository = examSessionRepository;
        this.examAnswerRepository = examAnswerRepository;
        this.examSessionQuestionRepository = examSessionQuestionRepository;
        this.questionService = questionService;
        this.userService = userService;
    }

    @Transactional
    public StartExamResponse startExam(UUID userId, StartExamRequest request) {
        int questionCount = request.questionCount() == null ? DEFAULT_QUESTION_COUNT : request.questionCount();
        String difficulty = normalizeDifficulty(request.difficulty());

        List<Question> questions = difficulty == null
                ? questionRepository.findUsableExamQuestionsAll(questionCount)
                : questionRepository.findUsableExamQuestionsByDifficulty(questionCount, difficulty);
        if (questions.isEmpty()) {
            throw new NoQuestionsAvailableException();
        }

        Instant startedAt = Instant.now();
        ExamSession session = new ExamSession();
        session.setUserId(userId);
        session.setTotalQuestions(questions.size());
        session.setTimeLimitMinutes(TIME_LIMIT_MINUTES);
        session.setStartedAt(startedAt);
        session.setExpiresAt(startedAt.plusSeconds(TIME_LIMIT_MINUTES * 60L));
        session.setInitialHearts(5);
        session.setHeartsRemaining(5);
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
                questions.stream().map(questionService::toExamResponse).toList(),
                savedSession.getTimeLimitMinutes(),
                savedSession.getExpiresAt()
        );
    }

    @Transactional
    public SubmitExamAnswerResponse submitAnswer(UUID userId, UUID sessionId, SubmitExamAnswerRequest request) {
        ExamSession session = getOwnedSession(userId, sessionId);
        if (!"in_progress".equals(session.getStatus())) {
            throw new ExamSessionStateException("Exam session is already finished");
        }

        // Enforce time limit — reject answers after expires_at
        if (session.getExpiresAt().isBefore(Instant.now())) {
            session.setStatus("expired");
            session.setCompletedAt(Instant.now());
            examSessionRepository.save(session);
            throw new ExamSessionExpiredException();
        }

        ExamSessionQuestion issuedQuestion = examSessionQuestionRepository
                .findIssuedQuestion(sessionId, request.questionId())
                .orElseThrow(QuestionNotInExamSessionException::new);
        if (!issuedQuestion.getSequenceNumber().equals(request.sequenceNumber())) {
            throw new ExamQuestionSequenceMismatchException();
        }
        if (examAnswerRepository.findByExamSessionIdAndQuestionId(sessionId, request.questionId()).isPresent()) {
            throw new DuplicateExamAnswerException();
        }

        Question question = questionRepository.findById(request.questionId())
                .orElseThrow(QuestionNotFoundException::new);
        boolean isCorrect = question.getCorrectAnswer().equalsIgnoreCase(request.answer());

        Instant answeredAt = Instant.now();
        Instant previousEventAt = examAnswerRepository
                .findFirstByExamSessionIdOrderByAnsweredAtDesc(sessionId)
                .map(ExamAnswer::getAnsweredAt)
                .orElse(session.getStartedAt());
        long responseTimeMs = Math.max(0, Duration.between(previousEventAt, answeredAt).toMillis());

        ExamAnswer answer = new ExamAnswer();
        answer.setExamSessionId(sessionId);
        answer.setQuestionId(request.questionId());
        answer.setSequenceNumber(issuedQuestion.getSequenceNumber());
        answer.setUserAnswer(request.answer());
        answer.setIsCorrect(isCorrect);
        answer.setResponseTimeMs((int) Math.min(responseTimeMs, Integer.MAX_VALUE));
        answer.setAnsweredAt(answeredAt);
        ExamAnswer savedAnswer;
        try {
            savedAnswer = examAnswerRepository.saveAndFlush(answer);
        } catch (DataIntegrityViolationException ex) {
            throw new DuplicateExamAnswerException();
        }

        return new SubmitExamAnswerResponse(
                savedAnswer.getId(),
                savedAnswer.getQuestionId(),
                savedAnswer.getUserAnswer()
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
                session.getStatus(),
                reportedXp
        );
    }

    @Transactional(readOnly = true)
    public ExamResultResponse getResult(UUID userId, UUID sessionId) {
        ExamSession session = getOwnedSession(userId, sessionId);
        if ("in_progress".equals(session.getStatus())) {
            throw new ExamSessionStateException("Exam results are unavailable until the exam is finished");
        }

        int correctAnswers = (int) examAnswerRepository.countByExamSessionIdAndIsCorrectTrue(sessionId);
        BigDecimal scorePercentage = calculateScorePercentage(correctAnswers, session.getTotalQuestions());
        int xpEarned = correctAnswers * XP_PER_CORRECT_ANSWER;
        boolean passed = scorePercentage.compareTo(BigDecimal.valueOf(60)) >= 0;

        List<ExamAnswer> answers = examAnswerRepository.findByExamSessionIdOrderBySequenceNumber(sessionId);
        List<ExamResultResponse.ExamAnswerDetail> answerDetails = new ArrayList<>();
        for (ExamAnswer answer : answers) {
            Question question = questionRepository.findById(answer.getQuestionId()).orElse(null);
            if (question == null) continue;
            answerDetails.add(new ExamResultResponse.ExamAnswerDetail(
                question.getId(),
                question.getQuestionText(),
                answer.getUserAnswer(),
                question.getCorrectAnswer(),
                answer.getIsCorrect(),
                question.getExplanation()
            ));
        }

        return new ExamResultResponse(
            session.getId(),
            session.getTotalQuestions(),
            correctAnswers,
            scorePercentage,
            xpEarned,
            session.getStatus(),
            passed,
            answerDetails
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
