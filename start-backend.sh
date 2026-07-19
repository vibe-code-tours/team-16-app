#!/bin/bash
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@25/25.0.3/libexec/openjdk.jdk/Contents/Home

# Load .env file
set -a
source src/api/.env
set +a

cd src/api
./gradlew bootRun