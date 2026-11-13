package com.nerdquiz.service;

import com.nerdquiz.dto.DailyActivityResponse;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.Date;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserDailyActivityServiceTest {

    @Mock
    private JdbcTemplate jdbcTemplate;

    private UserDailyActivityService activityService;
    private UUID userId;

    @BeforeEach
    void setUp() {
        activityService = new UserDailyActivityService(jdbcTemplate);
        userId = UUID.randomUUID();
    }

    @Test
    void recordAnsweredQuestion_IncrementsQuestionsAnsweredByOne() {
        activityService.recordAnsweredQuestion(userId);

        verify(jdbcTemplate).update(contains("INSERT INTO user_daily_activity"), eq(userId), eq(1), eq(0));
    }

    @Test
    void getRecentActivity_QueriesRequestedWindowForUser() {
        when(jdbcTemplate.query(anyString(), any(RowMapper.class), eq(6), eq(userId)))
                .thenReturn(List.of());

        activityService.getRecentActivity(userId, 7);

        verify(jdbcTemplate).query(contains("generate_series"), any(RowMapper.class), eq(6), eq(userId));
    }

    @Test
    @SuppressWarnings("unchecked")
    void getRecentActivity_MapsRowsToResponses() throws Exception {
        LocalDate today = LocalDate.of(2026, 11, 13);
        when(jdbcTemplate.query(anyString(), any(RowMapper.class), eq(0), eq(userId)))
                .thenAnswer(invocation -> {
                    RowMapper<DailyActivityResponse> mapper = invocation.getArgument(1);
                    ResultSet rs = mock(ResultSet.class);
                    when(rs.getDate("activity_date")).thenReturn(Date.valueOf(today));
                    when(rs.getInt("questions_answered")).thenReturn(12);
                    when(rs.getInt("xp_earned")).thenReturn(90);
                    return List.of(mapper.mapRow(rs, 0));
                });

        List<DailyActivityResponse> activity = activityService.getRecentActivity(userId, 1);

        assertEquals(List.of(new DailyActivityResponse(today, 12, 90)), activity);
    }

    @Test
    void getRecentActivity_DaysBelowMinimum_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> activityService.getRecentActivity(userId, 0));
        verifyNoInteractions(jdbcTemplate);
    }

    @Test
    void getRecentActivity_DaysAboveMaximum_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> activityService.getRecentActivity(userId, 31));
        verifyNoInteractions(jdbcTemplate);
    }
}
