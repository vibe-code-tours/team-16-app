#!/bin/bash
# Spike 004: JWT Auth Hardening Test Script
#
# Prerequisites: Start the server first:
#   javac JwtHardeningServer.java && java JwtHardeningServer
#
# Run: bash test-jwt-hardening.sh

BASE_URL="http://localhost:9996"
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

# Helper: create a JWT-like token with custom header/payload/signature
make_jwt() {
  local header="$1" payload="$2" sig="$3"
  local h=$(echo -n "$header" | base64 -w 0 | tr '+/' '-_' | tr -d '=')
  local p=$(echo -n "$payload" | base64 -w 0 | tr '+/' '-_' | tr -d '=')
  echo "${h}.${p}.${sig}"
}

# Valid token (simulated)
VALID_TOKEN=$(make_jwt '{"alg":"HS256","typ":"JWT"}' '{"sub":"user-123","exp":9999999999}' 'valid-sig')

# Expired token
EXPIRED_TOKEN=$(make_jwt '{"alg":"HS256","typ":"JWT"}' '{"sub":"user-123","exp":1000000000}' 'valid-sig')

# Tampered signature
TAMPERED_TOKEN=$(make_jwt '{"alg":"HS256","typ":"JWT"}' '{"sub":"user-123","exp":9999999999}' 'tampered-sig')

# Algorithm none attack
ALG_NONE_TOKEN=$(make_jwt '{"alg":"none","typ":"JWT"}' '{"sub":"admin","exp":9999999999}' 'forged-sig')

# Algorithm RSA confusion
ALG_RSA_TOKEN=$(make_jwt '{"alg":"RS256","typ":"JWT"}' '{"sub":"user-123","exp":9999999999}' 'fake-rsa-sig')

# Malformed tokens
MALFORMED_2PART="header.payload"
MALFORMED_EMPTY=""
MALFORMED_JUNK="not-a-jwt-token-at-all"
MALFORMED_BASE64="!!!invalid-base64!!!.payload.sig"

echo ""
echo "━━━ Spike 004: JWT Auth Hardening Tests ━━━"
echo ""

# --- Test 1: Public endpoint (no auth needed) ---
echo "Test 1: Public endpoint accessible without token"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$BASE_URL/api/v1/health")
check "GET /api/v1/health → 200 (no auth)" "200" "$STATUS"

# --- Test 2: Protected endpoint without token ---
echo ""
echo "Test 2: Protected endpoint requires token"
RESPONSE=$(curl -s -w "\n%{http_code}" "$BASE_URL/api/v1/profile")
STATUS=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | head -1)
check "GET /api/v1/profile without token → 401" "401" "$STATUS"

# --- Test 3: Valid token accepted ---
echo ""
echo "Test 3: Valid JWT is accepted"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer $VALID_TOKEN" "$BASE_URL/api/v1/profile")
check "Valid JWT → 200" "200" "$STATUS"

# --- Test 4: Expired token rejected ---
echo ""
echo "Test 4: Expired JWT is rejected"
RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer $EXPIRED_TOKEN" "$BASE_URL/api/v1/profile")
STATUS=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | head -1)
check "Expired JWT → 401" "401" "$STATUS"
check_not_contains "No expiry time leaked" "$BODY" "exp"
check_not_contains "No timestamp leaked" "$BODY" "1000000000"

# --- Test 5: Tampered signature rejected ---
echo ""
echo "Test 5: Tampered JWT signature is rejected"
RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer $TAMPERED_TOKEN" "$BASE_URL/api/v1/profile")
STATUS=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | head -1)
check "Tampered JWT → 401" "401" "$STATUS"
check_not_contains "No signature info leaked" "$BODY" "signature"
check_not_contains "No algorithm info leaked" "$BODY" "HS256"

# --- Test 6: Algorithm none attack ---
echo ""
echo "Test 6: Algorithm 'none' attack is rejected"
RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer $ALG_NONE_TOKEN" "$BASE_URL/api/v1/profile")
STATUS=$(echo "$RESPONSE" | tail -1)
check "alg:none JWT → 401" "401" "$STATUS"

# --- Test 7: Algorithm RSA confusion ---
echo ""
echo "Test 7: Algorithm RSA confusion is rejected"
RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer $ALG_RSA_TOKEN" "$BASE_URL/api/v1/profile")
STATUS=$(echo "$RESPONSE" | tail -1)
check "alg:RS256 JWT → 401 (only HS256 allowed)" "401" "$STATUS"

# --- Test 8: Malformed tokens ---
echo ""
echo "Test 8: Malformed tokens are rejected"
RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer $MALFORMED_2PART" "$BASE_URL/api/v1/profile")
STATUS=$(echo "$RESPONSE" | tail -1)
check "2-part token → 401" "401" "$STATUS"

RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer $MALFORMED_JUNK" "$BASE_URL/api/v1/profile")
STATUS=$(echo "$RESPONSE" | tail -1)
check "Random string token → 401" "401" "$STATUS"

RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer " "$BASE_URL/api/v1/profile")
STATUS=$(echo "$RESPONSE" | tail -1)
check "Empty Bearer token → 401" "401" "$STATUS"

# --- Test 9: SQL injection in token ---
echo ""
echo "Test 9: SQL injection in token is harmless"
RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer ' OR 1=1--" "$BASE_URL/api/v1/profile")
STATUS=$(echo "$RESPONSE" | tail -1)
check "SQLi in token → 401" "401" "$STATUS"

# --- Test 10: Error response format ---
echo ""
echo "Test 10: 401 error uses RFC 7807 Problem Details"
BODY=$(curl -s -H "Authorization: Bearer invalid" "$BASE_URL/api/v1/profile")
check_contains "Error has 'type' field" "$BODY" '"type"'
check_contains "Error has 'status':401" "$BODY" '"status":401'
check_contains "Error has 'detail' field" "$BODY" '"detail"'

# --- Test 11: No internal details in error ---
echo ""
echo "Test 11: Error response leaks no internal details"
check_not_contains "No library name" "$BODY" "Nimbus"
check_not_contains "No stack trace" "$BODY" "at "
check_not_contains "No Java class" "$BODY" ".java"
check_not_contains "No version info" "$BODY" "version"

# --- Summary ---
echo ""
echo "━━━ Results: $PASS passed, $FAIL failed ━━━"
echo ""

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi
