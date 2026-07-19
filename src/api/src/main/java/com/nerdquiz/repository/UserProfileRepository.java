package com.nerdquiz.repository;

import com.nerdquiz.model.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.UUID;

@Repository
public interface UserProfileRepository extends JpaRepository<UserProfile, UUID> {

    @Modifying
    @Query(value = """
        INSERT INTO user_profiles (id, email, display_name, avatar_url, role, total_xp, streak_count, longest_streak, is_active, created_at, updated_at)
        VALUES (:userId, :email, :displayName, :avatarUrl, 'user', 0, 0, 0, true, :now, :now)
        ON CONFLICT (id) DO UPDATE SET
            email = COALESCE(EXCLUDED.email, user_profiles.email),
            display_name = COALESCE(EXCLUDED.display_name, user_profiles.display_name),
            avatar_url = COALESCE(EXCLUDED.avatar_url, user_profiles.avatar_url),
            updated_at = :now
        """, nativeQuery = true)
    void upsertProfile(@Param("userId") UUID userId,
                       @Param("email") String email,
                       @Param("displayName") String displayName,
                       @Param("avatarUrl") String avatarUrl,
                       @Param("now") Instant now);
}
