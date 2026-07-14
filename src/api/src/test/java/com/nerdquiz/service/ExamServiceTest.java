package com.nerdquiz.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nerdquiz.dto.*;
import com.nerdquiz.model.*;
import com.nerdquiz.repository.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ExamServiceTest {

    @Mock
    private ExamRepository examRepository;

    @Mock
    private ExamSessionRepository examSessionRepository;

    @Mock
    private ExamAnswerRepository examAnswerRepository;

    @Mock
    private ExamHeartEventRepository examHeartEventRepository;

    @Mock
    private QuestionRepository questionRepository;

    @Spy
    private ObjectMapper objectMapper;

    @InjectMocks
    private ExamService examService;

    private UUID userId;
    private UUID examId;
    private UUID sessionId;
    private Exam sampleExam;
    private ExamSession sampleSession;
    private Question sampleQuestion;

    @BeforeEach
    void setUp() {
        userId = UUID.randomUUID();
        examId = UUID.randomUUID();
        sessionId = UUID.randomUUID();

        sampleExam = new Exam();
        sampleExam.setId(examId);
        sampleExam.setExamSession("2021-april");
        sampleExam.setSubject("A");
        sampleExam.setTitle("2021 April FE Subject A");
        sampleExam.setQuestionCount(60);
        sampleExam.setTimeLimitMinutes(150);
        sampleExam.setInitialHearts(5);
        sampleExam.setPublished(true);

        sampleSession = new ExamSession();
        sampleSession.setId(sessionId);
        sampleSession.setUserId(userId);
        sampleSession.setExamId(examId);
        sampleSession.setTotalQuestions(1);
        sampleSession.setInitialHearts(5);
        sampleSession.setHeartsRemaining(5);
        sampleSession.setTimeLimitMinutes(150);
        sampleSession.setExpiresAt(Instant.now().plus(150, ChronoUnit.MINUTES));
        sampleSession.setStatus("in_progress");

        sampleQuestion = new Question();
        sampleQuestion.setId(UUID.randomUUID());
        sampleQuestion.setExamSession("2021-april");
        sampleQuestion.setSubject("A");
        sampleQuestion.setQuestionNumber(1);
        sampleQuestion.setQuestionText("What is 2 + 2?");
        sampleQuestion.setChoices("[{\"label\":\"a\",\"text\":\"3\"},{\"label\":\"b\",\"text\":\"4\"}]");
        sampleQuestion.setCorrectAnswer("b");
        sampleQuestion.setDifficulty("easy");
        sampleQuestion.setImages("[]");
    }

    @Test
    void getAvailableExams_ReturnsPublishedExams() {
        when(examRepository.findByPublishedTrueOrderByExamSessionDescSubjectAsc())
                .thenReturn(List.of(sampleExam));

        List<ExamSummaryResponse> result = examService.getAvailableExams();

        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("2021-april", result.getFirst().examSession());
    }

    @Test
    void startExam_CreatesSessionAndReturnsQuestions() {
        when(examRepository.findByExamSessionAndSubject("2021-april", "A"))
                .thenReturn(Optional.of(sampleExam));
        when(questionRepository.findByExamSessionAndSubject("2021-april", "A"))
                .thenReturn(List.of(sampleQuestion));
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> {
                    ExamSession s = invocation.getArgument(0);
                    s.setId(sessionId);
                    return s;
                });
        when(examAnswerRepository.saveAll(anyList()))
                .thenReturn(List.of());

        StartExamRequest request = new StartExamRequest("2021-april", "A");

        ExamSessionResponse result = examService.startExam(userId, request);

        assertNotNull(result);
        assertEquals(sessionId, result.sessionId());
        assertEquals("in_progress", result.status());
        assertEquals(5, result.heartsRemaining());
        assertEquals(150, result.timeLimitMinutes());
        assertEquals(1, result.questions().size());
        // Correct answer should be hidden
        assertNull(result.questions().getFirst().isRequired() ? null : result.questions().getFirst().isRequired());
        // Subject A: all questions required
        assertTrue(result.questions().getFirst().isRequired());
    }

    @Test
    void startExam_SubjectA_AllQuestionsRequired() {
        when(examRepository.findByExamSessionAndSubject("2021-april", "A"))
                .thenReturn(Optional.of(sampleExam));
        when(questionRepository.findByExamSessionAndSubject("2021-april", "A"))
                .thenReturn(List.of(sampleQuestion));
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> {
                    ExamSession s = invocation.getArgument(0);
                    s.setId(sessionId);
                    return s;
                });
        when(examAnswerRepository.saveAll(anyList()))
                .thenReturn(List.of());

        StartExamRequest request = new StartExamRequest("2021-april", "A");
        ExamSessionResponse result = examService.startExam(userId, request);

        // All Subject A questions should be required
        assertTrue(result.questions().stream().allMatch(ExamQuestionResponse::isRequired));
    }

    @Test
    void startExam_SubjectB_OptionalQuestionsMarked() {
        Exam subjectBExam = new Exam();
        subjectBExam.setId(examId);
        subjectBExam.setExamSession("2021-april");
        subjectBExam.setSubject("B");
        subjectBExam.setTitle("2021 April FE Subject B");
        subjectBExam.setQuestionCount(8);
        subjectBExam.setTimeLimitMinutes(150);
        subjectBExam.setInitialHearts(5);
        subjectBExam.setPublished(true);

        List<Question> subjectBQuestions = new java.util.ArrayList<>();
        for (int i = 1; i <= 8; i++) {
            Question q = new Question();
            q.setId(UUID.randomUUID());
            q.setExamSession("2021-april");
            q.setSubject("B");
            q.setQuestionNumber(i);
            q.setQuestionText("Subject B Q" + i);
            q.setChoices("[{\"label\":\"a\",\"text\":\"Option A\"}]");
            q.setCorrectAnswer("a");
            q.setDifficulty("medium");
            q.setImages("[]");
            subjectBQuestions.add(q);
        }

        when(examRepository.findByExamSessionAndSubject("2021-april", "B"))
                .thenReturn(Optional.of(subjectBExam));
        when(questionRepository.findByExamSessionAndSubject("2021-april", "B"))
                .thenReturn(subjectBQuestions);
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> {
                    ExamSession s = invocation.getArgument(0);
                    s.setId(sessionId);
                    return s;
                });
        when(examAnswerRepository.saveAll(anyList()))
                .thenReturn(List.of());

        StartExamRequest request = new StartExamRequest("2021-april", "B");
        ExamSessionResponse result = examService.startExam(userId, request);

        // Q1 and Q6 should be required, Q2-Q5 and Q7-Q8 optional
        List<ExamQuestionResponse> questions = result.questions();
        assertTrue(questions.get(0).isRequired());   // Q1
        assertFalse(questions.get(1).isRequired());  // Q2
        assertFalse(questions.get(2).isRequired());  // Q3
        assertFalse(questions.get(3).isRequired());  // Q4
        assertFalse(questions.get(4).isRequired());  // Q5
        assertTrue(questions.get(5).isRequired());   // Q6
        assertFalse(questions.get(6).isRequired());  // Q7
        assertFalse(questions.get(7).isRequired());  // Q8
    }

    @Test
    void submitAnswer_CorrectAnswer_ReturnsCorrect() {
        when(examSessionRepository.findByIdAndUserId(sessionId, userId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.findByExamSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(Optional.of(new ExamAnswer()));
        when(questionRepository.findById(sampleQuestion.getId()))
                .thenReturn(Optional.of(sampleQuestion));
        when(examAnswerRepository.save(any(ExamAnswer.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), "b");

        ExamAnswerResponse result = examService.submitAnswer(userId, sessionId, request);

        assertTrue(result.isCorrect());
        assertEquals(5, result.heartsRemaining());
        assertFalse(result.examComplete());
    }

    @Test
    void submitAnswer_WrongAnswer_DecreasesHearts() {
        when(examSessionRepository.findByIdAndUserId(sessionId, userId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.findByExamSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(Optional.of(new ExamAnswer()));
        when(questionRepository.findById(sampleQuestion.getId()))
                .thenReturn(Optional.of(sampleQuestion));
        when(examAnswerRepository.save(any(ExamAnswer.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), "a");

        ExamAnswerResponse result = examService.submitAnswer(userId, sessionId, request);

        assertFalse(result.isCorrect());
        assertEquals(4, result.heartsRemaining());
    }

    @Test
    void submitAnswer_LastHeart_CompletesExam() {
        sampleSession.setHeartsRemaining(1);
        when(examSessionRepository.findByIdAndUserId(sessionId, userId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.findByExamSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(Optional.of(new ExamAnswer()));
        when(questionRepository.findById(sampleQuestion.getId()))
                .thenReturn(Optional.of(sampleQuestion));
        when(examAnswerRepository.save(any(ExamAnswer.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));
        when(examAnswerRepository.countByExamSessionIdAndIsCorrectTrue(sessionId))
                .thenReturn(0L);

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), "a");

        ExamAnswerResponse result = examService.submitAnswer(userId, sessionId, request);

        assertFalse(result.isCorrect());
        assertEquals(0, result.heartsRemaining());
        assertTrue(result.examComplete());
        assertEquals("completed", sampleSession.getStatus());
    }

    @Test
    void submitAnswer_ExpiredSession_ThrowsException() {
        sampleSession.setExpiresAt(Instant.now().minus(1, ChronoUnit.MINUTES));
        when(examSessionRepository.findByIdAndUserId(sessionId, userId))
                .thenReturn(Optional.of(sampleSession));
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), "a");

        assertThrows(RuntimeException.class, () -> examService.submitAnswer(userId, sessionId, request));
    }

    @Test
    void completeExam_ReturnsResults() {
        when(examSessionRepository.findByIdAndUserId(sessionId, userId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.countByExamSessionIdAndIsCorrectTrue(sessionId))
                .thenReturn(1L);
        when(examAnswerRepository.findByExamSessionIdOrderBySequenceNumberAsc(sessionId))
                .thenReturn(List.of());
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        ExamResultResponse result = examService.completeExam(userId, sessionId);

        assertNotNull(result);
        assertEquals("completed", sampleSession.getStatus());
        assertNotNull(sampleSession.getCompletedAt());
    }

    @Test
    void getResult_ReturnsExamResult() {
        sampleSession.setCorrectAnswers(1);
        sampleSession.setScorePercentage(100.0);
        when(examSessionRepository.findByIdAndUserId(sessionId, userId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.findByExamSessionIdOrderBySequenceNumberAsc(sessionId))
                .thenReturn(List.of());

        ExamResultResponse result = examService.getResult(userId, sessionId);

        assertNotNull(result);
        assertEquals(sessionId, result.sessionId());
    }
}
