package com.nerdquiz.dto;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public record MistakeResponse(
    UUID id,
    UUID questionId,
    UUID subtopicId,
    String subtopicName,
    String topicName,
    String questionText,
    String correctAnswer,
    List<ChoiceOption> choices,
    String explanation,
    String lastUserAnswer,
    Instant lastMissedAt
) {
    public record ChoiceOption(String label, String text) {}
}
