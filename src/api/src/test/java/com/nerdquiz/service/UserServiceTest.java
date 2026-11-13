package com.nerdquiz.service;

import com.nerdquiz.exception.UserProfileNotFoundException;
import com.nerdquiz.service.UserService.StreakSnapshot;
import com.nerdquiz.service.UserService.StreakState;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    private static final LocalDate TODAY = LocalDate.of(2026, 11, 13);

    @Mock
    private JdbcTemplate jdbcTemplate;

    @Mock
    private UserDailyActivityService activityService;

    private UserService userService;
    private UUID userId;

    @BeforeEach
    void setUp() {
        userService = new UserService(jdbcTemplate, activityService);
        userId = UUID.randomUUID();
    }

    @Test
    void nextStreak_SameDay_KeepsStreak() {
        StreakState state = UserService.nextStreak(new StreakSnapshot(3, 5, TODAY, TODAY));

        assertEquals(3, state.streakCount());
        assertEquals(5, state.longestStreak());
    }

    @Test
    void nextStreak_NextDay_IncrementsStreakAndLongest() {
        StreakState state = UserService.nextStreak(new StreakSnapshot(3, 3, TODAY.minusDays(1), TODAY));

        assertEquals(4, state.streakCount());
        assertEquals(4, state.longestStreak());
    }

    @Test
    void nextStreak_Gap_ResetsToOneAndKeepsLongest() {
        StreakState state = UserService.nextStreak(new StreakSnapshot(7, 9, TODAY.minusDays(2), TODAY));

        assertEquals(1, state.streakCount());
        assertEquals(9, state.longestStreak());
    }

    @Test
    void nextStreak_NoPreviousActivity_StartsAtOne() {
        StreakState state = UserService.nextStreak(new StreakSnapshot(0, 0, null, TODAY));

        assertEquals(1, state.streakCount());
        assertEquals(1, state.longestStreak());
    }

    @Test
    void recordStudyActivity_FirstEventOfNextDay_PersistsIncrementedStreak() throws Exception {
        stubStreakRow(3, 3, TODAY.minusDays(1));

        int streak = userService.recordStudyActivity(userId);

        assertEquals(4, streak);
        verify(jdbcTemplate).update(anyString(), eq(4), eq(4), eq(userId));
        verify(activityService).recordActivity(userId, 0, 0);
    }

    @Test
    void recordStudyActivity_LaterEventSameDay_LeavesStreakUnchanged() throws Exception {
        stubStreakRow(4, 6, TODAY);

        int streak = userService.recordStudyActivity(userId);

        assertEquals(4, streak);
        verify(jdbcTemplate).update(anyString(), eq(4), eq(6), eq(userId));
    }

    @Test
    void recordStudyActivity_AfterGap_ResetsStreak() throws Exception {
        stubStreakRow(5, 5, TODAY.minusDays(3));

        int streak = userService.recordStudyActivity(userId);

        assertEquals(1, streak);
        verify(jdbcTemplate).update(anyString(), eq(1), eq(5), eq(userId));
    }

    @Test
    void recordStudyActivity_ProfileMissing_ThrowsNotFound() {
        doReturn(List.of()).when(jdbcTemplate).query(anyString(), any(RowMapper.class), eq(userId));

        assertThrows(UserProfileNotFoundException.class, () -> userService.recordStudyActivity(userId));
        verify(activityService, never()).recordActivity(any(), any(Integer.class), any(Integer.class));
    }

    @Test
    void getCurrentStreak_ProfileExists_ReturnsStreakWithoutUpdating() {
        doReturn(List.of(2)).when(jdbcTemplate).query(anyString(), any(RowMapper.class), eq(userId));

        int streak = userService.getCurrentStreak(userId);

        assertEquals(2, streak);
        verify(jdbcTemplate, never()).update(anyString(), any(Object[].class));
        verify(activityService, never()).recordActivity(any(), any(Integer.class), any(Integer.class));
    }

    @Test
    void getCurrentStreak_ProfileMissing_ThrowsNotFound() {
        doReturn(List.of()).when(jdbcTemplate).query(anyString(), any(RowMapper.class), eq(userId));

        assertThrows(UserProfileNotFoundException.class, () -> userService.getCurrentStreak(userId));
    }

    /** Stubs the locked profile read by running the service's row mapper over a mocked row. */
    private void stubStreakRow(int streak, int longest, LocalDate lastActivity) throws Exception {
        ResultSet row = mock(ResultSet.class);
        when(row.getInt("streak_count")).thenReturn(streak);
        when(row.getInt("longest_streak")).thenReturn(longest);
        when(row.getObject("last_activity_date", LocalDate.class)).thenReturn(lastActivity);
        when(row.getObject("today", LocalDate.class)).thenReturn(TODAY);

        doAnswer(invocation -> {
            RowMapper<?> mapper = invocation.getArgument(1);
            return List.of(mapper.mapRow(row, 0));
        }).when(jdbcTemplate).query(anyString(), any(RowMapper.class), eq(userId));
    }
}
