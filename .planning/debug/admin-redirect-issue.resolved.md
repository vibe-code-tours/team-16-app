# Debug: Admin Account Login Redirects to Normal User Pages

## Issue
When logging in with an admin account, users are redirected to `/map` (normal user page) instead of `/admin` (admin dashboard).

## Root Cause Analysis

### Issue 1: Backend doesn't return `role` field
- **File:** `src/api/src/main/java/com/nerdquiz/dto/UserProfileResponse.java`
- **Problem:** The `role` field exists in the database (migration `20260715042300_add_admin_role.sql`) but is not included in the API response DTO
- **Impact:** Frontend cannot determine if user is admin

### Issue 2: Frontend doesn't map `role` field
- **File:** `src/web/src/hooks/useAuth.tsx` (lines 80-90)
- **Problem:** When setting user profile, `role` field is not included in the state
- **Impact:** `user.role` is always `undefined`, so `AdminRoute` check fails

### Issue 3: LoginPage always redirects to `/map`
- **File:** `src/web/src/routes/LoginPage.tsx` (line 24)
- **Problem:** `navigate('/map')` is called unconditionally after login
- **Impact:** Admin users never reach `/admin` automatically

## Fix Applied

### Backend Changes
1. **`UserProfileResponse.java`** - Added `role` field to the response DTO
2. **`UserProfile.java`** - Added `role` field to the JPA entity with getter/setter
3. **`UserProfileService.java`** - Updated `toResponse()` to include role

### Frontend Changes
1. **`useAuth.tsx`** - Added `role` to `ApiUserProfile` interface and mapped it in `setUser()`
2. **`LoginPage.tsx`** - Added `useEffect` to redirect based on user role after sign-in:
   - Sets `justSignedIn` flag after successful sign-in
   - Watches for user profile to load
   - Redirects admin users to `/admin`, normal users to `/map`

## Verification
- Login with admin account → should redirect to `/admin`
- Login with normal user account → should redirect to `/map`
- Navigate to `/admin` as normal user → should redirect to `/` (via AdminRoute)

## Status: RESOLVED
