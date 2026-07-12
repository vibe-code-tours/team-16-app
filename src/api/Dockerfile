# ── Stage 1: Build with Gradle ──────────────────────────────
FROM eclipse-temurin:25-jdk-alpine AS build
WORKDIR /app

# Install only what's needed for Gradle
RUN apk add --no-cache bash

# Copy Gradle wrapper + config first (cached unless these change)
COPY gradlew settings.gradle build.gradle ./
COPY gradle/ gradle/

# Make gradlew executable and download dependencies (cached layer)
RUN chmod +x gradlew && ./gradlew dependencies --no-daemon

# Copy source code
COPY src/ src/

# Build the application JAR (skip tests — no DB in build stage)
RUN ./gradlew bootJar --no-daemon -x test \
    && mv build/libs/*.jar app.jar

# ── Stage 2: Run with slim JRE ──────────────────────────────
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/app.jar app.jar

EXPOSE 8080

# Health check — busybox wget is already on Alpine
HEALTHCHECK --interval=15s --timeout=5s --start-period=40s --retries=3 \
  CMD wget -qO /dev/null http://localhost:8080/ 2>/dev/null || exit 1

# Run the Spring Boot JAR
# JVM flags: reduce memory footprint for containers
ENTRYPOINT ["java", \
  "-XX:+UseContainerSupport", \
  "-XX:MaxRAMPercentage=75.0", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-jar", "app.jar"]
