package com.nerdquiz.service;

import com.nerdquiz.dto.QuestionResponse;
import com.nerdquiz.model.Question;
import com.nerdquiz.repository.QuestionRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Spy;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class QuestionServiceTest {

    @Mock
    private QuestionRepository questionRepository;

    @InjectMocks
    private QuestionService questionService;

    private Question sampleQuestion;

    @BeforeEach
    void setUp() {
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
    }

    @Test
    void getRandomQuestions_ReturnsQuestions() {
        // Arrange
        when(questionRepository.findRandomQuestions(anyInt()))
                .thenReturn(List.of(sampleQuestion));

        // Act
        List<QuestionResponse> result = questionService.getRandomQuestions(5);

        // Assert
        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("What is 2 + 2?", result.get(0).questionText());
        assertEquals("b", result.get(0).correctAnswer());
    }

    @Test
    void getRandomQuestions_EmptyList_ReturnsEmpty() {
        // Arrange
        when(questionRepository.findRandomQuestions(anyInt()))
                .thenReturn(List.of());

        // Act
        List<QuestionResponse> result = questionService.getRandomQuestions(5);

        // Assert
        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    @Test
    void getByExamSession_ReturnsFilteredQuestions() {
        // Arrange
        when(questionRepository.findByExamSessionAndSubject("2025-october", "A"))
                .thenReturn(List.of(sampleQuestion));

        // Act
        List<QuestionResponse> result = questionService.getByExamSession("2025-october", "A");

        // Assert
        assertEquals(1, result.size());
        assertEquals("2025-october", result.get(0).examSession());
    }

    @Test
    void countByExamSession_ReturnsCount() {
        // Arrange
        when(questionRepository.countByExamSessionAndSubject("2025-october", "A"))
                .thenReturn(60L);

        // Act
        long count = questionService.countByExamSession("2025-october", "A");

        // Assert
        assertEquals(60L, count);
    }
}
