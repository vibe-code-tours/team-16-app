-- XP is derived from trusted, idempotent completion flows in the backend.
-- Client-selected deltas allow authenticated users to forge progress.
REVOKE EXECUTE ON FUNCTION public.increment_user_xp(INTEGER) FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION public.increment_user_xp(INTEGER) FROM anon;
REVOKE EXECUTE ON FUNCTION public.increment_user_xp(INTEGER) FROM authenticated;

DROP FUNCTION IF EXISTS public.increment_user_xp(INTEGER);
