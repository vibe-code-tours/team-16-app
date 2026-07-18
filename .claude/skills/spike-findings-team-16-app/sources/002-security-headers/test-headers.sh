#!/bin/bash
# Spike 002: Security Headers Test Script
#
# Prerequisites: Start the server first:
#   javac SecurityHeadersServer.java && java SecurityHeadersServer
#
# Run: bash test-headers.sh

BASE_URL="http://localhost:9998"
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
  if echo "$haystack" | grep -qi "$needle"; then
    echo "  ✓ $desc"
    PASS=$((PASS + 1))
  else
    echo "  ✗ $desc (missing: $needle)"
    FAIL=$((FAIL + 1))
  fi
}

check_not_contains() {
  local desc="$1" haystack="$2" needle="$3"
  if echo "$haystack" | grep -qi "$needle"; then
    echo "  ✗ $desc (unexpectedly contains: $needle)"
    FAIL=$((FAIL + 1))
  else
    echo "  ✓ $desc"
    PASS=$((PASS + 1))
  fi
}

echo ""
echo "━━━ Spike 002: Security Headers Tests ━━━"
echo ""

# Get all headers
HEADERS=$(curl -s -D - -o /dev/null "$BASE_URL/api/v1/health")

# --- Test 1: Content-Security-Policy ---
echo "Test 1: Content-Security-Policy header"
check_contains "CSP header present" "$HEADERS" "content-security-policy"
check_contains "CSP default-src 'self'" "$HEADERS" "default-src 'self'"
check_contains "CSP connect-src includes supabase" "$HEADERS" "connect-src"
check_contains "CSP frame-src 'none'" "$HEADERS" "frame-src 'none'"
check_contains "CSP object-src 'none'" "$HEADERS" "object-src 'none'"

# --- Test 2: HSTS ---
echo ""
echo "Test 2: Strict-Transport-Security"
check_contains "HSTS header present" "$HEADERS" "strict-transport-security"
check_contains "HSTS max-age=31536000" "$HEADERS" "max-age=31536000"
check_contains "HSTS includeSubDomains" "$HEADERS" "includeSubDomains"

# --- Test 3: X-Frame-Options ---
echo ""
echo "Test 3: X-Frame-Options"
check_contains "X-Frame-Options present" "$HEADERS" "x-frame-options"
FRAME_VALUE=$(echo "$HEADERS" | grep -i "x-frame-options" | head -1 | cut -d: -f2- | tr -d '\r ')
check "X-Frame-Options is DENY" "DENY" "$FRAME_VALUE"

# --- Test 4: X-Content-Type-Options ---
echo ""
echo "Test 4: X-Content-Type-Options"
check_contains "X-Content-Type-Options present" "$HEADERS" "x-content-type-options"
CTYPE_VALUE=$(echo "$HEADERS" | grep -i "x-content-type-options" | head -1 | cut -d: -f2- | tr -d '\r ')
check "X-Content-Type-Options is nosniff" "nosniff" "$CTYPE_VALUE"

# --- Test 5: Referrer-Policy ---
echo ""
echo "Test 5: Referrer-Policy"
check_contains "Referrer-Policy present" "$HEADERS" "referrer-policy"
check_contains "Referrer-Policy value" "$HEADERS" "strict-origin-when-cross-origin"

# --- Test 6: Permissions-Policy ---
echo ""
echo "Test 6: Permissions-Policy"
check_contains "Permissions-Policy present" "$HEADERS" "permissions-policy"
check_contains "Camera disabled" "$HEADERS" "camera=()"
check_contains "Microphone disabled" "$HEADERS" "microphone=()"

# --- Test 7: CSP Supabase compatibility ---
echo ""
echo "Test 7: CSP allows Supabase SDK connections"
CSP_LINE=$(echo "$HEADERS" | grep -i "content-security-policy" | head -1)
check_contains "connect-src allows supabase.co" "$CSP_LINE" "supabase.co"
check_contains "connect-src allows wss (WebSocket)" "$CSP_LINE" "wss:"
check_contains "script-src allows self" "$CSP_LINE" "script-src 'self'"

# --- Test 8: No server identification leak ---
echo ""
echo "Test 8: Server identification removed"
check_not_contains "No X-Powered-By header" "$HEADERS" "x-powered-by"

# --- Summary ---
echo ""
echo "━━━ Results: $PASS passed, $FAIL failed ━━━"
echo ""

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
