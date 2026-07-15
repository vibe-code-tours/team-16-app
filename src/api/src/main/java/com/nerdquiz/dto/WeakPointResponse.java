package com.nerdquiz.dto;

import java.util.List;
import java.util.UUID;

public record WeakPointResponse(
    List<TopicMastery> topics,
    List<SubtopicMastery> subtopics
) {
    public record TopicMastery(
        UUID topicId,
        String topicName,
        String topicSlug,
        double masteryScore,
        int questionsSeen,
        int questionsCorrect
    ) {}

    public record SubtopicMastery(
        UUID subtopicId,
        UUID topicId,
        String subtopicName,
        String subtopicSlug,
        double masteryScore,
        int questionsSeen,
        int questionsCorrect
    ) {}
}
