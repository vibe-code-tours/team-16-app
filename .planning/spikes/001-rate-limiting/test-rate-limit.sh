#!/bin/bash
# Spike 001: Rate Limiter Test Script
# Tests per-IP rate limiting on the spike HTTP server.
#
# Prerequisites: Start the server first:
#   javac RateLimiterFilter.java SimpleHttpServer.java && java SimpleHttpServer
#
# Run: bash test-rate-limit.sh

BASE_URL="http://localhost:9999"
PASS=0
FAIL=0

check() {
  local desc="$1" expected="$2" actual="$3"
  if [ "$actual" = "$expected" ]; then
    echo "  ✓ $desc (got $actual)"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $desc (expected $expected, got $actual)"
    FAIL=$((FAIL + 1))
  fi
}

echo ""
echo "━━━ Spike 001: Rate Limiter Tests ━━━"
echo ""

# --- Test 1: Health endpoint (public, no rate limit) ---
echo "Test 1: Health endpoint is always accessible"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/api/v1/health")
check "GET /api/v1/health → 200" "200" "$STATUS"

# --- Test 2: First request allowed ---
echo ""
echo "Test 2: First request to rate-limited endpoint is allowed"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/api/v1/topics")
check "Request 1 → 200" "200" "$STATUS"

# --- Test 3: Requests within limit ---
echo ""
echo "Test 3: Requests within rate limit (5 per minute)"
for i in 2 3 4 5; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/api/v1/topics")
  check "Request $i → 200" "200" "$STATUS"
done

# --- Test 4: 6th request exceeds limit ---
echo ""
echo "Test 4: Request exceeding rate limit returns 429"
RESPONSE=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/v1/topics")
STATUS=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | head -1)
check "Request 6 → 429" "429" "$STATUS"

# --- Test 5: Response body is RFC 7807 Problem Details ---
echo ""
echo "Test 5: 429 response body is RFC 7807 Problem Details"
HAS_TYPE=$(echo "$BODY" | grep -c '"type"')
HAS_STATUS=$(echo "$BODY" | grep -c '"status":429')
check "Body has 'type' field" "1" "$HAS_TYPE"
check "Body has 'status':429" "1" "$HAS_STATUS"

# --- Test 6: Retry-After header present ---
echo ""
echo "Test 6: 429 response includes Retry-After header"
RETRY_AFTER=$(curl -s -D - -o /dev/null "$BASE_URL/api/v1/topics" | grep -i "Retry-After" | tr -d '\r')
HAS_RETRY=$( [ -n "$RETRY_AFTER" ] && echo "yes" || echo "no" )
check "Retry-After header present" "yes" "$HAS_RETRY"

# --- Test 7: X-RateLimit-Limit header ---
echo ""
echo "Test 7: 429 response includes X-RateLimit headers"
LIMIT_HEADER=$(curl -s -D - -o /dev/null "$BASE_URL/api/v1/topics" | grep -i "X-RateLimit-Limit" | tr -d '\r')
HAS_LIMIT=$( [ -n "$LIMIT_HEADER" ] && echo "yes" || echo "no" )
check "X-RateLimit-Limit header present" "yes" "$HAS_LIMIT"

# --- Test 8: Subsequent requests while rate-limited ---
echo ""
echo "Test 8: Requests remain blocked while rate-limited"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/api/v1/topics")
check "Still 429 on next request" "429" "$STATUS"

# --- Summary ---
echo ""
echo "━━━ Results: $PASS passed, $FAIL failed ━━━"
echo ""

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
