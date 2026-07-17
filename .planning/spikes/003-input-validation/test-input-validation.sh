#!/bin/bash
# Spike 003: Input Validation Test Script
#
# Prerequisites: Start the server first:
#   javac InputValidationServer.java && java InputValidationServer
#
# Run: bash test-input-validation.sh

BASE_URL="http://localhost:9997"
PASS=0
FAIL=0

check() {
  local desc="$1" expected="$2" actual="$3"
  if [ "$actual" = "$expected" ]; then
    echo "  ✓ $desc"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $desc (expected: $expected, got: $actual)"
    FAIL=$((FAIL + 1))
  fi
}

check_contains() {
  local desc="$1" haystack="$2" needle="$3"
  if echo "$haystack" | grep -q "$needle"; then
    echo "  ✓ $desc"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $desc (missing: $needle)"
    FAIL=$((FAIL + 1))
  fi
}

echo ""
echo "━━━ Spike 003: Input Validation Tests ━━━"
echo ""

# --- SQL Injection Tests ---
echo "Test 1: SQL Injection in query parameter"
# Use --data-urlencode to avoid shell interpretation of special chars
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -G "$BASE_URL/api/v1/search" --data-urlencode "q=' OR 1=1--")
check "SQL injection (' OR 1=1--) → 400" "400" "$STATUS"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" -G "$BASE_URL/api/v1/search" --data-urlencode "q=UNION SELECT * FROM users")
check "SQL injection (UNION SELECT) → 400" "400" "$STATUS"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" -G "$BASE_URL/api/v1/search" --data-urlencode "q=;DROP TABLE users")
check "SQL injection (;DROP TABLE) → 400" "400" "$STATUS"

# --- XSS Tests ---
echo ""
echo "Test 2: XSS payloads in query parameter"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -G "$BASE_URL/api/v1/search" --data-urlencode "q=<script>alert('xss')</script>")
check "XSS script tag → 400" "400" "$STATUS"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" -G "$BASE_URL/api/v1/search" --data-urlencode "q=javascript:alert(1)")
check "XSS javascript: protocol → 400" "400" "$STATUS"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" -G "$BASE_URL/api/v1/search" --data-urlencode "q=<img onerror=alert(1) src=x>")
check "XSS event handler → 400" "400" "$STATUS"

# --- XSS in JSON Body ---
echo ""
echo "Test 3: XSS payloads in JSON body"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" \
  --data-raw '{"name":"<script>alert(1)</script>"}' "$BASE_URL/api/v1/profiles")
check "XSS in JSON body → 400" "400" "$STATUS"

# --- Path Traversal Tests ---
echo ""
echo "Test 4: Path traversal attempts"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/api/v1/files/..%2F..%2Fetc%2Fpasswd")
check "Path traversal (encoded ../../) → 403" "403" "$STATUS"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/api/v1/files/..%252f..%252fetc/passwd")
check "Path traversal (double-encoded) → 403" "403" "$STATUS"

# --- Payload Size Tests ---
echo ""
echo "Test 5: Oversized payload"
# Write large payload to file to avoid shell arg limit
python3 -c "print('{\"data\":\"' + 'A' * 200000 + '\"}')" > /tmp/spike-oversized.json 2>/dev/null
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" \
  -d @/tmp/spike-oversized.json "$BASE_URL/api/v1/profiles")
check "Oversized payload (200KB) → 413" "413" "$STATUS"
rm -f /tmp/spike-oversized.json

# --- Malformed JSON Tests ---
echo ""
echo "Test 6: Malformed JSON"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" \
  -d 'not json at all' "$BASE_URL/api/v1/profiles")
check "Malformed JSON → 400" "400" "$STATUS"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" \
  -d '' "$BASE_URL/api/v1/profiles")
check "Empty body → 400" "400" "$STATUS"

# --- Valid Input Tests ---
echo ""
echo "Test 7: Valid input passes through"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/api/v1/search?q=technology")
check "Valid search query → 200" "200" "$STATUS"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com"}' "$BASE_URL/api/v1/profiles")
check "Valid profile creation → 201" "201" "$STATUS"

# --- Response Format Tests ---
echo ""
echo "Test 8: Error responses use RFC 7807 format"
BODY=$(curl -s -G "$BASE_URL/api/v1/search" --data-urlencode "q=<script>alert(1)</script>")
check_contains "Error has 'type' field" "$BODY" '"type"'
check_contains "Error has 'status' field" "$BODY" '"status"'
check_contains "Error has 'detail' field" "$BODY" '"detail"'

# --- Summary ---
echo ""
echo "━━━ Results: $PASS passed, $FAIL failed ━━━"
echo ""

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
