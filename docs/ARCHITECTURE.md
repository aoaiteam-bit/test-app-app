# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router, TypeScript)
- **Database:** Supabase (Postgres + RLS)
- **Hosting:** Vercel
- **AI:** OpenAI API (server-side route only)

## Now vs Later
**Now:** leads table, add/edit/status-change, AI priority score on save, activity log, seed data visible without login.
**Later:** auth + per-user RLS, email-draft tool, bulk import, team sharing.

## Key User Action — Add a Lead
1. Rep fills the "Add Lead" form and hits Save.
2. Next.js server action validates and inserts a row into `leads`.
3. A server-side call to OpenAI scores the lead (1–100); result stored as `priority_score`, `priority_source`, `priority_confidence`, `priority_review_status`.
4. An `activities` row is inserted: `action=lead_created`.
5. An `audit_logs` row is written.
6. The leads dashboard re-fetches and shows the new row with its score.

## Layer Plan
1. **Data first** — schema, seed data, RLS policies.
2. **App logic** — CRUD server actions, status machine, activity writes.
3. **Smart features** — AI scoring, next-action suggestions.

## Core Without AI
If the OpenAI call fails, the lead is saved with `priority_score = null` and `priority_review_status = 'error'`. Every core CRUD action works independently of the AI.
