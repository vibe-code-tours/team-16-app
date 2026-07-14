package com.nerdquiz.service;

import com.nerdquiz.dto.*;
import com.nerdquiz.exception.*;
import com.nerdquiz.model.*;
import com.nerdquiz.repository.*;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class ExamService {

    private static final int XP_PER_CORRECT_ANSWER = 10;
    private static final double PASS_THRESHOLD = 60.0;

    // Subject B selection rules: Q1 compulsory, Q2-Q5 select 2, Q6 compulsory, Q7-Q8 select 1
    private static final Set<Integer> SUBJECT_B_REQUIRED = Set.of(1, 6);
    private static final Set<Integer> SUBJECT_B_OPTIONAL_FIRST = Set.of(2, 3, 4, 5);
    private static final Set<Integer> SUBJECT_B_OPTIONAL_SECOND = Set.of(7, 8);
    private static final int SUBJECT_B_SELECT_FIRST = 2;
    private static final int SUBJECT_B_SELECT_SECOND = 1;

    private final ExamRepository examRepository;
    private final ExamSessionRepository examSessionRepository;
    private final ExamAnswerRepository examAnswerRepository;
    private final ExamHeartEventRepository examHeartEventRepository;
    private final QuestionRepository questionRepository;
    private final UserProfileRepository userProfileRepository;
    private final ObjectMapper objectMapper;

    public ExamService(ExamRepository examRepository,
                       ExamSessionRepository examSessionRepository,
                       ExamAnswerRepository examAnswerRepository,
                       ExamHeartEventRepository examHeartEventRepository,
                       QuestionRepository questionRepository,
                       UserProfileRepository userProfileRepository,
                       ObjectMapper objectMapper) {
        this.examRepository = examRepository;
        this.examSessionRepository = examSessionRepository;
        this.examAnswerRepository = examAnswerRepository;
        this.examHeartEventRepository = examHeartEventRepository;
        this.questionRepository = questionRepository;
        this.userProfileRepository = userProfileRepository;
        this.objectMapper = objectMapper;
    }

    @Transactional(readOnly = true)
    public List<ExamSummaryResponse> getAvailableExams() {
        return examRepository.findByPublishedTrueOrderByExamSessionDescSubjectAsc().stream()
                .map(ExamSummaryResponse::from)
                .toList();
    }

    @Transactional
    public ExamSessionResponse startExam(UUID userId, StartExamRequest request) {
        // Ensure user profile exists (needed for FK constraint on exam_sessions)
        if (!userProfileRepository.existsById(userId)) {
            com.nerdquiz.model.UserProfile profile = new com.nerdquiz.model.UserProfile();
            profile.setId(userId);
            profile.setEmail("");
            profile.setTotalXp(0);
            profile.setStreakCount(0);
            userProfileRepository.save(profile);
        }

        Exam exam = examRepository.findByExamSessionAndSubject(request.examSession(), request.subject())
                .orElseThrow(() -> new RuntimeException(
                    "No exam found for session " + request.examSession() + " subject " + request.subject()));

        List<Question> questions = questionRepository.findByExamSessionAndSubject(
                request.examSession(), request.subject()).stream()
                .sorted(Comparator.comparing(Question::getQuestionNumber))
                .toList();

        if (questions.isEmpty()) {
            throw new NoQuestionsAvailableException();
        }

        // Create exam session
        ExamSession session = new ExamSession();
        session.setUserId(userId);
        session.setExamId(exam.getId());
        session.setTotalQuestions(questions.size());
        session.setInitialHearts(exam.getInitialHearts());
        session.setHeartsRemaining(exam.getInitialHearts());
        session.setTimeLimitMinutes(exam.getTimeLimitMinutes());
        session.setExpiresAt(Instant.now().plus(exam.getTimeLimitMinutes(), ChronoUnit.MINUTES));
        session = examSessionRepository.save(session);

        // Create answer slots for each question
        List<ExamAnswer> answerSlots = new ArrayList<>();
        for (int i = 0; i < questions.size(); i++) {
            ExamAnswer answerSlot = new ExamAnswer();
            answerSlot.setExamSessionId(session.getId());
            answerSlot.setQuestionId(questions.get(i).getId());
            answerSlot.setSequenceNumber(i + 1);
            answerSlots.add(answerSlot);
        }
        examAnswerRepository.saveAll(answerSlots);

        // Convert questions to response (without correct answers)
        List<ExamQuestionResponse> questionResponses = questions.stream()
                .map(q -> toQuestionResponse(q, request.subject()))
                .toList();

        return new ExamSessionResponse(
            session.getId(),
            request.examSession(),
            request.subject(),
            exam.getTitle(),
            questionResponses,
            session.getTotalQuestions(),
            session.getHeartsRemaining(),
            session.getInitialHearts(),
            session.getTimeLimitMinutes(),
            session.getExpiresAt(),
            session.getStatus()
        );
    }

    @Transactional
    public ExamAnswerResponse submitAnswer(UUID userId, UUID sessionId, SubmitExamAnswerRequest request) {
        ExamSession session = examSessionRepository.findByIdAndUserId(sessionId, userId)
                .orElseThrow(() -> new RuntimeException("Exam session not found"));

        if (!"in_progress".equals(session.getStatus())) {
            throw new RuntimeException("Exam is no longer in progress");
        }

        if (Instant.now().isAfter(session.getExpiresAt())) {
            session.setStatus("expired");
            examSessionRepository.save(session);
            throw new RuntimeException("Exam has expired");
        }

        ExamAnswer answer = examAnswerRepository.findByExamSessionIdAndQuestionId(sessionId, request.questionId())
                .orElseThrow(() -> new RuntimeException("Question not found in this exam session"));

        // Get the question to check correct answer
        Question question = questionRepository.findById(request.questionId())
                .orElseThrow(() -> new QuestionNotFoundException());

        boolean isCorrect = request.answer() != null &&
                question.getCorrectAnswer().equalsIgnoreCase(request.answer());

        answer.setUserAnswer(request.answer());
        answer.setIsCorrect(isCorrect);
        answer.setAnsweredAt(Instant.now());

        int heartsRemaining = session.getHeartsRemaining();

        // Handle hearts for incorrect answers
        if (!isCorrect && request.answer() != null) {
            session.setHeartsRemaining(session.getHeartsRemaining() - 1);
            heartsRemaining = session.getHeartsRemaining();

            ExamHeartEvent heartEvent = new ExamHeartEvent();
            heartEvent.setExamSessionId(sessionId);
            heartEvent.setQuestionId(request.questionId());
            heartEvent.setDelta(-1);
            heartEvent.setReason("Incorrect answer");
            examHeartEventRepository.save(heartEvent);

            // Auto-complete if no hearts left
            if (heartsRemaining <= 0) {
                session.setStatus("completed");
                session.setCompletedAt(Instant.now());
                calculateFinalScore(session);
            }
        }

        examAnswerRepository.save(answer);
        examSessionRepository.save(session);

        return new ExamAnswerResponse(
            request.questionId(),
            request.answer(),
            isCorrect,
            question.getCorrectAnswer(),
            question.getExplanation(),
            heartsRemaining,
            "completed".equals(session.getStatus())
        );
    }

    @Transactional
    public ExamResultResponse completeExam(UUID userId, UUID sessionId) {
        ExamSession session = examSessionRepository.findByIdAndUserId(sessionId, userId)
                .orElseThrow(() -> new RuntimeException("Exam session not found"));

        if (!"in_progress".equals(session.getStatus())) {
            // Already completed or expired — just return results
            return buildResultResponse(session);
        }

        session.setStatus("completed");
        session.setCompletedAt(Instant.now());
        calculateFinalScore(session);
        examSessionRepository.save(session);

        return buildResultResponse(session);
    }

    @Transactional(readOnly = true)
    public ExamResultResponse getResult(UUID userId, UUID sessionId) {
        ExamSession session = examSessionRepository.findByIdAndUserId(sessionId, userId)
                .orElseThrow(() -> new RuntimeException("Exam session not found"));

        return buildResultResponse(session);
    }

    private void calculateFinalScore(ExamSession session) {
        long correctCount = examAnswerRepository.countByExamSessionIdAndIsCorrectTrue(session.getId());
        session.setCorrectAnswers((int) correctCount);
        double percentage = session.getTotalQuestions() > 0
                ? (correctCount * 100.0) / session.getTotalQuestions()
                : 0.0;
        session.setScorePercentage(Math.round(percentage * 100.0) / 100.0);
    }

    private ExamResultResponse buildResultResponse(ExamSession session) {
        List<ExamAnswer> answers = examAnswerRepository.findByExamSessionIdOrderBySequenceNumberAsc(session.getId());

        List<UUID> questionIds = answers.stream()
                .map(ExamAnswer::getQuestionId)
                .toList();
        Map<UUID, Question> questionMap = questionRepository.findByIdIn(questionIds).stream()
                .collect(Collectors.toMap(Question::getId, q -> q));

        int answeredCount = (int) answers.stream()
                .filter(a -> a.getUserAnswer() != null)
                .count();

        List<ExamResultResponse.ExamAnswerDetail> answerDetails = answers.stream()
                .filter(a -> a.getUserAnswer() != null)
                .map(answer -> {
                    Question question = questionMap.get(answer.getQuestionId());
                    return new ExamResultResponse.ExamAnswerDetail(
                        answer.getQuestionId(),
                        question.getQuestionNumber(),
                        question.getQuestionText(),
                        answer.getUserAnswer(),
                        question.getCorrectAnswer(),
                        answer.getIsCorrect(),
                        question.getExplanation()
                    );
                })
                .toList();

        int correctCount = session.getCorrectAnswers() != null ? session.getCorrectAnswers() : 0;
        int xpEarned = correctCount * XP_PER_CORRECT_ANSWER;
        boolean passed = session.getScorePercentage() != null && session.getScorePercentage() >= PASS_THRESHOLD;

        return new ExamResultResponse(
            session.getId(),
            session.getTotalQuestions(),
            answeredCount,
            correctCount,
            session.getScorePercentage(),
            xpEarned,
            passed,
            session.getHeartsRemaining(),
            answerDetails
        );
    }

    private ExamQuestionResponse toQuestionResponse(Question question, String subject) {
        try {
            JsonNode imagesNode = objectMapper.readTree(
                    question.getImages() != null ? question.getImages() : "[]");
            JsonNode choicesNode = objectMapper.readTree(question.getChoices());

            boolean isRequired = isQuestionRequired(question.getQuestionNumber(), subject);

            return new ExamQuestionResponse(
                question.getId(),
                question.getQuestionNumber(),
                question.getQuestionText(),
                imagesNode,
                choicesNode,
                question.getDifficulty(),
                isRequired
            );
        } catch (Exception e) {
            throw new RuntimeException("Failed to parse question JSON", e);
        }
    }

    /**
     * Determines if a question is required based on real ITPEC FE exam rules.
     * Subject A: all questions compulsory.
     * Subject B: Q1 compulsory, Q2-Q5 select 2 of 4, Q6 compulsory, Q7-Q8 select 1 of 2.
     */
    private boolean isQuestionRequired(int questionNumber, String subject) {
        if ("A".equals(subject)) {
            return true; // All Subject A questions are compulsory
        }
        // Subject B rules
        if (SUBJECT_B_REQUIRED.contains(questionNumber)) {
            return true;
        }
        // Optional questions are not individually required
        return false;
    }
}
