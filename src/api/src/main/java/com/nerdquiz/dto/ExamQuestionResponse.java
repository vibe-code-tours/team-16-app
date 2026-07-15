package com.nerdquiz.dto;

import com.fasterxml.jackson.databind.JsonNode;

import java.util.UUID;

public record ExamQuestionResponse(
    UUID id,
    Integer questionNumber,
    String questionText,
    JsonNode images,
    JsonNode choices,
    String difficulty,
    Boolean isRequired
) {}
