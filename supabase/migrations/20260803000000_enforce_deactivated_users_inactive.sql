-- Backfill accounts deactivated before is_active was updated by the admin flow.
UPDATE public.user_profiles
SET is_active = false,
    updated_at = now()
WHERE role = 'deactivated'
  AND is_active IS DISTINCT FROM false;

-- Preserve the invariant even for direct SQL/admin tooling updates.
CREATE OR REPLACE FUNCTION public.enforce_deactivated_user_inactive()
RETURNS trigger
LANGUAGE plpgsql
SET search_path = ''
AS $$
BEGIN
  IF NEW.role = 'deactivated' THEN
    NEW.is_active := false;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS enforce_deactivated_user_inactive ON public.user_profiles;
CREATE TRIGGER enforce_deactivated_user_inactive
BEFORE INSERT OR UPDATE OF role, is_active ON public.user_profiles
FOR EACH ROW
EXECUTE FUNCTION public.enforce_deactivated_user_inactive();
