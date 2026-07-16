-- Fix restrict_profile_columns trigger to allow backend JDBC connections
--
-- The trigger was created outside migrations and only allowed 'service_role'
-- to modify streak_count/total_xp. The Spring Boot backend connects via JDBC
-- as the 'postgres' user, which gets blocked by this trigger.
-- Fix: also allow 'postgres' and superuser roles.

DROP TRIGGER IF EXISTS restrict_profile_columns ON public.user_profiles;

CREATE OR REPLACE FUNCTION restrict_profile_columns()
RETURNS TRIGGER AS $$
DECLARE
    current_role TEXT := current_setting('role');
BEGIN
    -- Allow service_role (Supabase API) and postgres/superuser (JDBC/backend)
    IF current_role NOT IN ('service_role', 'postgres', 'rds_superuser') THEN
        IF NEW.streak_count IS DISTINCT FROM OLD.streak_count THEN
            RAISE EXCEPTION 'streak_count cannot be modified directly';
        END IF;
        IF NEW.total_xp IS DISTINCT FROM OLD.total_xp THEN
            RAISE EXCEPTION 'total_xp cannot be modified directly';
        END IF;
        IF NEW.role IS DISTINCT FROM OLD.role THEN
            RAISE EXCEPTION 'role cannot be modified directly';
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER restrict_profile_columns
    BEFORE UPDATE ON public.user_profiles
    FOR EACH ROW
    EXECUTE FUNCTION restrict_profile_columns();
