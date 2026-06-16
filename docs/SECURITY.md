# Security

## Secret Handling
- `OPENAI_API_KEY` and `SUPABASE_SERVICE_ROLE_KEY` live only in Vercel env vars.
- Frontend uses only `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY`.
- All AI calls go through `/api/score-lead` server route — never the browser.

## Permission Model (v1 — demo mode)
- RLS enabled on all tables with permissive policies so seed data is visible without login.
- No user-scoped filtering until the lock-down sprint.

## Lock-Down Sprint (after demo)
- Replace v1 RLS policies with `auth.uid() = user_id` owner policies.
- Add `profiles` table tied to `auth.users`.
- Redirect unauthenticated users to `/login` only after lock-down.

## Approved Tools Rule
- Agents may only call named functions (`score_lead`, `log_activity`, `write_audit`).
- No `run_any`, `eval`, or raw SQL from agent context.
- Every meaningful write emits an `audit_logs` row.

## Audit Principle
Every create, update, status change, and AI action writes an immutable `audit_logs` row with `before` and `after` snapshots in `payload`.
