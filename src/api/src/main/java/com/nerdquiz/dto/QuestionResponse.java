package com.nerdquiz.dto;

import com.fasterxml.jackson.annotation.JsonRawValue;
import com.fasterxml.jackson.databind.JsonNode;

import java.util.UUID;

public record QuestionResponse(
    UUID id,
    String examSession,
    String subject,
    Integer questionNumber,
    String questionText,
    JsonNode images,
    JsonNode choices,
    String correctAnswer,
    String explanation,
    String difficulty
) {}
