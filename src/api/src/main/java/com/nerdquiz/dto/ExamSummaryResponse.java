package com.nerdquiz.dto;

import java.util.List;
import java.util.UUID;

public record ExamSummaryResponse(
    UUID id,
    String examSession,
    String subject,
    String title,
    Integer questionCount,
    Integer timeLimitMinutes,
    Integer initialHearts
) {
    public static ExamSummaryResponse from(com.nerdquiz.model.Exam exam) {
        return new ExamSummaryResponse(
            exam.getId(),
            exam.getExamSession(),
            exam.getSubject(),
            exam.getTitle(),
            exam.getQuestionCount(),
            exam.getTimeLimitMinutes(),
            exam.getInitialHearts()
        );
    }
}
