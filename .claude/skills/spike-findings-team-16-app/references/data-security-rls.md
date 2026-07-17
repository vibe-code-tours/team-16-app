# Data Security (Row Level Security)

## Requirements

- Must not break existing Supabase Auth flow
- Service role key must stay server-side only (never in frontend code)
- All user-data tables must have RLS enabled with `auth.uid()` policies

## How to Build It

**1. Verify RLS is enabled on every user-data table:**

```sql
-- In migration files, every user-data table must include:
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- Policy for user-scoped access
CREATE POLICY "Users can view own profile" ON user_profiles
    FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can update own profile" ON user_profiles
    FOR UPDATE USING (auth.uid() = user_id);
```

**2. Public tables (questions, topics) need read-only access for all:**

```sql
-- Public read access for content tables
CREATE POLICY "Anyone can view questions" ON questions
    FOR SELECT USING (true);
```

**3. Use the audit script after any schema changes:**

```bash
# Run from project root
bash .planning/spikes/005-supabase-rls/audit-rls.sh
```

**4. Frontend Supabase client must use anon key:**

```typescript
// src/web/src/lib/supabase.ts
import { createClient } from '@supabase/supabase-js'

export const supabase = createClient(
  import.meta.env.VITE_SUPABASE_URL,
  import.meta.env.VITE_SUPABASE_ANON_KEY  // anon key —受限 by RLS
  // NEVER use SERVICE_ROLE_KEY here — it bypasses RLS
)
```

**5. Two-layer security model:**

```
Layer 1: Spring Boot JWT filter → verifies signature, extracts user ID
Layer 2: Supabase RLS → enforces row-level access at database level

If Layer 1 is bypassed (e.g., direct Supabase SDK call), Layer 2 still protects data.
If Layer 2 is misconfigured, Layer 1 still requires valid JWT.
```

## What to Avoid

- **Don't put `SUPABASE_SERVICE_ROLE_KEY` in frontend code.** This key bypasses ALL RLS policies. If it leaks, anyone can read/write all data. Audit confirms it's not in `src/web/`.
- **Don't forget RLS on new tables.** When adding a new user-data table in a migration, always include `ENABLE ROW LEVEL SECURITY` + policy. Run the audit script to verify.
- **Don't use `FOR ALL` policies without careful consideration.** `FOR ALL` applies to SELECT, INSERT, UPDATE, DELETE. Use specific operation policies for clarity.
- **Don't rely solely on RLS for authorization.** RLS is defense-in-depth. The backend JWT filter is the primary auth gate. Both layers together provide robust security.
- **Don't disable RLS for "convenience" during development.** If you need to bypass RLS for admin operations, use the service role key in the backend, not in the frontend.

## Constraints

- RLS is enforced at the Postgres level — no bypass possible via SDK or API
- `auth.uid()` returns the user ID from the JWT's `sub` claim
- Supabase anon key is public — it's safe because RLS restricts what it can access
- Service role key bypasses RLS — must only be used in backend (Spring Boot) for admin operations
- The audit script checks for: RLS enabled, policies exist, auth.uid() used, no service role in frontend

## Origin

Synthesized from spikes: 005
Source files available in: sources/005-supabase-rls/
