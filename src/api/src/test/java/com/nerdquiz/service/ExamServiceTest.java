package com.nerdquiz.service;

import com.nerdquiz.dto.*;
import com.nerdquiz.exception.ExamSessionNotFoundException;
import com.nerdquiz.exception.UnauthorizedQuizAccessException;
import com.nerdquiz.model.ExamAnswer;
import com.nerdquiz.model.ExamSession;
import com.nerdquiz.model.Question;
import com.nerdquiz.repository.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
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
    private QuestionRepository questionRepository;

    @Mock
    private ExamSessionRepository examSessionRepository;

    @Mock
    private ExamAnswerRepository examAnswerRepository;

    @Mock
    private ExamHeartEventRepository examHeartEventRepository;

    @Mock
    private QuestionService questionService;

    @Mock
    private UserService userService;

    @InjectMocks
    private ExamService examService;

    private UUID userId;
    private UUID sessionId;
    private ExamSession sampleSession;
    private Question sampleQuestion;

    @BeforeEach
    void setUp() {
        userId = UUID.randomUUID();
        sessionId = UUID.randomUUID();

        sampleSession = new ExamSession();
        sampleSession.setId(sessionId);
        sampleSession.setUserId(userId);
        sampleSession.setTotalQuestions(1);
        sampleSession.setInitialHearts(5);
        sampleSession.setHeartsRemaining(5);
        sampleSession.setTimeLimitMinutes(60);
        sampleSession.setExpiresAt(Instant.now().plus(60, ChronoUnit.MINUTES));
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
    void startExam_CreatesSessionAndReturnsQuestions() {
        when(questionRepository.findUsableExamQuestions(60, null))
                .thenReturn(List.of(sampleQuestion));
        when(questionService.toResponse(sampleQuestion)).thenReturn(new QuestionResponse(
                sampleQuestion.getId(), null, "2021-april", "A", 1,
                "What is 2 + 2?", null, null, "b", null, "easy"
        ));
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> {
                    ExamSession s = invocation.getArgument(0);
                    s.setId(sessionId);
                    return s;
                });

        StartExamRequest request = new StartExamRequest(60, null);

        StartExamResponse result = examService.startExam(userId, request);

        assertNotNull(result);
        assertEquals(sessionId, result.sessionId());
        assertEquals(3, result.heartsRemaining());
        assertEquals(60, result.timeLimitMinutes());
        assertEquals(1, result.questions().size());
    }

    @Test
    void startExam_WithDifficulty过滤Questions() {
        when(questionRepository.findUsableExamQuestions(10, "easy"))
                .thenReturn(List.of(sampleQuestion));
        when(questionService.toResponse(sampleQuestion)).thenReturn(new QuestionResponse(
                sampleQuestion.getId(), null, "2021-april", "A", 1,
                "What is 2 + 2?", null, null, "b", null, "easy"
        ));
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> {
                    ExamSession s = invocation.getArgument(0);
                    s.setId(sessionId);
                    return s;
                });

        StartExamRequest request = new StartExamRequest(10, "easy");

        StartExamResponse result = examService.startExam(userId, request);

        assertNotNull(result);
        assertEquals(1, result.questions().size());
        verify(questionRepository).findUsableExamQuestions(10, "easy");
    }

    @Test
    void startExam_InvalidDifficulty_ThrowsException() {
        StartExamRequest request = new StartExamRequest(10, "impossible");

        assertThrows(IllegalArgumentException.class, () -> examService.startExam(userId, request));
    }

    @Test
    void submitAnswer_CorrectAnswer_ReturnsCorrect() {
        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.findByExamSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(Optional.of(new ExamAnswer()));
        when(questionRepository.findById(sampleQuestion.getId()))
                .thenReturn(Optional.of(sampleQuestion));
        when(examAnswerRepository.save(any(ExamAnswer.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), 1, "b", 5000);

        SubmitExamAnswerResponse result = examService.submitAnswer(userId, sessionId, request);

        assertTrue(result.isCorrect());
        assertEquals(5, result.heartsRemaining());
    }

    @Test
    void submitAnswer_WrongAnswer_DecreasesHearts() {
        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.findByExamSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(Optional.of(new ExamAnswer()));
        when(questionRepository.findById(sampleQuestion.getId()))
                .thenReturn(Optional.of(sampleQuestion));
        when(examAnswerRepository.save(any(ExamAnswer.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), 1, "a", 3000);

        SubmitExamAnswerResponse result = examService.submitAnswer(userId, sessionId, request);

        assertFalse(result.isCorrect());
        assertEquals(4, result.heartsRemaining());
    }

    @Test
    void submitAnswer_SessionNotFound_ThrowsException() {
        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.empty());

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), 1, "a", 3000);

        assertThrows(ExamSessionNotFoundException.class, () -> examService.submitAnswer(userId, sessionId, request));
    }

    @Test
    void submitAnswer_NotOwner_ThrowsException() {
        ExamSession otherUserSession = new ExamSession();
        otherUserSession.setId(sessionId);
        otherUserSession.setUserId(UUID.randomUUID());
        otherUserSession.setStatus("in_progress");

        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(otherUserSession));

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), 1, "a", 3000);

        assertThrows(UnauthorizedQuizAccessException.class, () -> examService.submitAnswer(userId, sessionId, request));
    }

    @Test
    void submitAnswer_AlreadyFinished_ThrowsException() {
        sampleSession.setStatus("completed");
        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), 1, "a", 3000);

        assertThrows(IllegalArgumentException.class, () -> examService.submitAnswer(userId, sessionId, request));
    }

    @Test
    void submitAnswer_QuestionNotFound_ThrowsException() {
        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(questionRepository.findById(sampleQuestion.getId()))
                .thenReturn(Optional.empty());

        SubmitExamAnswerRequest request = new SubmitExamAnswerRequest(sampleQuestion.getId(), 1, "a", 3000);

        assertThrows(com.nerdquiz.exception.QuestionNotFoundException.class,
                () -> examService.submitAnswer(userId, sessionId, request));
    }

    @Test
    void finishExam_CompletedSession_ReturnsResults() {
        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.countByExamSessionIdAndIsCorrectTrue(sessionId))
                .thenReturn(50L);
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        sampleSession.setTotalQuestions(60);
        FinishExamRequest request = new FinishExamRequest("completed");

        FinishExamResponse result = examService.finishExam(userId, sessionId, request);

        assertNotNull(result);
        assertEquals(sessionId, result.sessionId());
        assertEquals(60, result.totalQuestions());
        assertEquals(50, result.correctAnswers());
        assertEquals("completed", result.status());
        assertEquals(500, result.xpEarned());
    }

    @Test
    void finishExam_AbandonedSession_NoXp() {
        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.countByExamSessionIdAndIsCorrectTrue(sessionId))
                .thenReturn(50L);
        when(examSessionRepository.save(any(ExamSession.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        sampleSession.setTotalQuestions(60);
        FinishExamRequest request = new FinishExamRequest("abandoned");

        FinishExamResponse result = examService.finishExam(userId, sessionId, request);

        assertEquals("abandoned", result.status());
        assertEquals(0, result.xpEarned());
    }

    @Test
    void finishExam_AlreadyFinished_DoesNotUpdate() {
        sampleSession.setStatus("completed");
        sampleSession.setCorrectAnswers(40);
        sampleSession.setScorePercentage(BigDecimal.valueOf(66.67));
        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(examAnswerRepository.countByExamSessionIdAndIsCorrectTrue(sessionId))
                .thenReturn(40L);

        FinishExamRequest request = new FinishExamRequest("completed");

        FinishExamResponse result = examService.finishExam(userId, sessionId, request);

        assertNotNull(result);
        verify(examSessionRepository, never()).save(any());
    }

    @Test
    void finishExam_SessionNotFound_ThrowsException() {
        when(examSessionRepository.findById(sessionId))
                .thenReturn(Optional.empty());

        FinishExamRequest request = new FinishExamRequest("completed");

        assertThrows(ExamSessionNotFoundException.class, () -> examService.finishExam(userId, sessionId, request));
    }
}
