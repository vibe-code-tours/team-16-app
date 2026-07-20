package com.nerdquiz.util;

import java.util.Optional;
import java.util.UUID;

public final class UuidUtil {

    private UuidUtil() {
        // Utility class
    }

    /**
     * Parses a UUID string with proper error handling.
     *
     * @param uuidString the UUID string to parse
     * @return the parsed UUID
     * @throws IllegalArgumentException if the string is not a valid UUID
     */
    public static UUID parse(String uuidString) {
        if (uuidString == null || uuidString.isBlank()) {
            throw new IllegalArgumentException("UUID cannot be null or blank");
        }
        try {
            return UUID.fromString(uuidString);
        } catch (IllegalArgumentException e) {
            throw new IllegalArgumentException("Invalid UUID format: " + uuidString, e);
        }
    }

    /**
     * Attempts to parse a UUID string, returning empty on failure instead of throwing.
     * Use this in controllers to return 400 Bad Request for invalid UUIDs.
     *
     * @param uuidString the UUID string to parse
     * @return Optional containing the parsed UUID, or empty if the string is not a valid UUID
     */
    public static Optional<UUID> tryParse(String uuidString) {
        if (uuidString == null || uuidString.isBlank()) {
            return Optional.empty();
        }
        try {
            return Optional.of(UUID.fromString(uuidString));
        } catch (IllegalArgumentException e) {
            return Optional.empty();
        }
    }
}
