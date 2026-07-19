package com.nerdquiz.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nerdquiz.dto.*;
import com.nerdquiz.exception.DuplicateAnswerException;
import com.nerdquiz.exception.QuestionNotInQuizSessionException;
import com.nerdquiz.model.Question;
import com.nerdquiz.model.QuizAnswer;
import com.nerdquiz.model.QuizSession;
import com.nerdquiz.repository.QuestionRepository;
import com.nerdquiz.repository.QuizAnswerRepository;
import com.nerdquiz.repository.QuizSessionQuestionRepository;
import com.nerdquiz.repository.QuizSessionRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class QuizServiceTest {

    @Mock
    private QuestionRepository questionRepository;

    @Mock
    private QuizSessionRepository quizSessionRepository;

    @Mock
    private QuizAnswerRepository quizAnswerRepository;

    @Mock
    private QuizSessionQuestionRepository quizSessionQuestionRepository;

    @Mock
    private QuestionService questionService;

    @Mock
    private WeakPointService weakPointService;

    @Mock
    private UserDailyActivityService activityService;

    @Mock
    private UserService userService;

    @Mock
    private MistakeService mistakeService;

    private QuizService quizService;

    private UUID userId;
    private UUID sessionId;
    private Question sampleQuestion;
    private QuizSession sampleSession;

    @BeforeEach
    void setUp() {
        userId = UUID.randomUUID();
        sessionId = UUID.randomUUID();

        sampleQuestion = new Question();
        sampleQuestion.setId(UUID.randomUUID());
        sampleQuestion.setExamSession("2025-october");
        sampleQuestion.setSubject("A");
        sampleQuestion.setQuestionNumber(1);
        sampleQuestion.setQuestionText("What is 2 + 2?");
        sampleQuestion.setChoices("[{\"label\":\"a\",\"text\":\"3\"},{\"label\":\"b\",\"text\":\"4\"}]");
        sampleQuestion.setCorrectAnswer("b");
        sampleQuestion.setDifficulty("easy");
        sampleQuestion.setImages("[]");

        sampleSession = new QuizSession();
        sampleSession.setId(sessionId);
        sampleSession.setUserId(userId);
        sampleSession.setQuestionCount(5);
        sampleSession.setScore(0);
        sampleSession.setXpEarned(0);
        sampleSession.setStatus("in_progress");

        // Construct service manually with a real ObjectMapper (stateless, safe in tests)
        quizService = new QuizService(
                questionRepository, quizSessionRepository, quizAnswerRepository,
                quizSessionQuestionRepository, questionService, weakPointService,
                activityService, userService, mistakeService, new ObjectMapper());
    }

    @Test
    void startQuiz_CreatesSession() {
        // Arrange
        when(questionRepository.findRandomQuestions(anyInt()))
                .thenReturn(List.of(sampleQuestion));
        when(quizSessionRepository.save(any(QuizSession.class)))
                .thenReturn(sampleSession);

        StartQuizRequest request = new StartQuizRequest(null, 5);

        // Act
        QuizSessionResponse result = quizService.startQuiz(userId, request);

        // Assert
        assertNotNull(result);
        assertEquals(sessionId, result.id());
        assertEquals("in_progress", result.status());
        verify(quizSessionRepository).save(any(QuizSession.class));
    }

    @Test
    void submitAnswer_CorrectAnswer_UpdatesScore() {
        // Arrange
        when(quizSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(quizSessionQuestionRepository.existsByQuizSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(true);
        when(quizAnswerRepository.existsByQuizSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(false);
        when(questionRepository.findById(sampleQuestion.getId()))
                .thenReturn(Optional.of(sampleQuestion));
        when(quizAnswerRepository.countByQuizSessionId(sessionId))
                .thenReturn(0L);
        when(quizAnswerRepository.save(any(QuizAnswer.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        SubmitAnswerRequest request = new SubmitAnswerRequest(sampleQuestion.getId(), "b");

        // Act
        QuizAnswerResponse result = quizService.submitAnswer(userId, sessionId, request);

        // Assert
        assertTrue(result.isCorrect());
        assertEquals(1, sampleSession.getScore());
        assertEquals(10, sampleSession.getXpEarned());
        verify(weakPointService).updateMastery(userId, sampleQuestion.getId(), true);
    }

    @Test
    void submitAnswer_WrongAnswer_DoesNotUpdateScore() {
        // Arrange
        when(quizSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(quizSessionQuestionRepository.existsByQuizSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(true);
        when(quizAnswerRepository.existsByQuizSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(false);
        when(questionRepository.findById(sampleQuestion.getId()))
                .thenReturn(Optional.of(sampleQuestion));
        when(quizAnswerRepository.countByQuizSessionId(sessionId))
                .thenReturn(0L);
        when(quizAnswerRepository.save(any(QuizAnswer.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        SubmitAnswerRequest request = new SubmitAnswerRequest(sampleQuestion.getId(), "a");

        // Act
        QuizAnswerResponse result = quizService.submitAnswer(userId, sessionId, request);

        // Assert
        assertFalse(result.isCorrect());
        assertEquals(0, sampleSession.getScore());
        assertEquals(0, sampleSession.getXpEarned());
        verify(weakPointService).updateMastery(userId, sampleQuestion.getId(), false);
        verify(mistakeService).recordMistake(eq(userId), any(RecordMistakeRequest.class));
    }

    @Test
    void submitAnswer_AllQuestionsAnswered_CompletesSession() {
        // Arrange
        sampleSession.setQuestionCount(1);
        when(quizSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(quizSessionQuestionRepository.existsByQuizSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(true);
        when(quizAnswerRepository.existsByQuizSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(false);
        when(questionRepository.findById(sampleQuestion.getId()))
                .thenReturn(Optional.of(sampleQuestion));
        // Already has 0 answers, adding 1 will match questionCount
        when(quizAnswerRepository.countByQuizSessionId(sessionId))
                .thenReturn(0L);
        when(quizAnswerRepository.save(any(QuizAnswer.class)))
                .thenAnswer(invocation -> invocation.getArgument(0));

        SubmitAnswerRequest request = new SubmitAnswerRequest(sampleQuestion.getId(), "b");

        // Act
        quizService.submitAnswer(userId, sessionId, request);

        // Assert
        assertEquals("completed", sampleSession.getStatus());
        assertNotNull(sampleSession.getCompletedAt());
    }

    @Test
    void submitAnswer_QuestionNotInSession_ThrowsException() {
        // Arrange
        when(quizSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(quizSessionQuestionRepository.existsByQuizSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(false);

        SubmitAnswerRequest request = new SubmitAnswerRequest(sampleQuestion.getId(), "b");

        // Act & Assert
        assertThrows(QuestionNotInQuizSessionException.class,
                () -> quizService.submitAnswer(userId, sessionId, request));
    }

    @Test
    void submitAnswer_DuplicateAnswer_ThrowsException() {
        // Arrange
        when(quizSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(quizSessionQuestionRepository.existsByQuizSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(true);
        when(quizAnswerRepository.existsByQuizSessionIdAndQuestionId(sessionId, sampleQuestion.getId()))
                .thenReturn(true);

        SubmitAnswerRequest request = new SubmitAnswerRequest(sampleQuestion.getId(), "b");

        // Act & Assert
        assertThrows(DuplicateAnswerException.class,
                () -> quizService.submitAnswer(userId, sessionId, request));
    }

    @Test
    void getResult_ReturnsQuizResult() {
        // Arrange
        sampleSession.setQuestionCount(1);
        QuizAnswer answer = new QuizAnswer();
        answer.setQuestionId(sampleQuestion.getId());
        answer.setUserAnswer("b");
        answer.setIsCorrect(true);

        when(quizSessionRepository.findById(sessionId))
                .thenReturn(Optional.of(sampleSession));
        when(quizAnswerRepository.findByQuizSessionId(sessionId))
                .thenReturn(List.of(answer));
        when(questionRepository.findByIdIn(List.of(sampleQuestion.getId())))
                .thenReturn(List.of(sampleQuestion));

        // Act
        QuizResultResponse result = quizService.getResult(userId, sessionId);

        // Assert
        assertNotNull(result);
        assertEquals(1, result.totalQuestions());
        assertEquals(1, result.correctAnswers());
        assertEquals(100, result.scorePercentage());
    }
}
