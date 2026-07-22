#!/bin/bash
export JAVA_HOME=/home/myomin/.java/jdk-25.0.3+9

# Load .env file (strip \r for Windows-style files)
set -a
sed 's/\r$//' src/api/.env | grep -v '^\s*#' | grep -v '^\s*$' > /tmp/_env_clean
source /tmp/_env_clean
rm /tmp/_env_clean
set +a

cd src/api

# Debug: show loaded vars (first 40 chars only)
echo "DEBUG: DATABASE_URL=${DATABASE_URL:0:40}..."
echo "DEBUG: SUPABASE_URL=${SUPABASE_URL}"
echo "DEBUG: SUPABASE_ANON_KEY length=${#SUPABASE_ANON_KEY}"

./gradlew bootRun
