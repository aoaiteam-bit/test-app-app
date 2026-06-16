# Test Plan

## v1 Success Scenario (manual)
1. Open `/` — leads table renders with ≥ 3 seeded rows, each showing name, company, status, priority score.
2. Click **Add Lead** — drawer opens.
3. Fill: Name=`Jane Doe`, Company=`Acme`, Email=`jane@acme.com`, Source=`Referral`, Status=`New`, Notes=`Met at SaaStr, interested in Q3 deal`.
4. Click **Save** — drawer closes, new row appears in table with a priority score > 0.
5. Click the row — lead detail page loads with all fields and one activity: `lead_created`.
6. Change status to `Contacted` — dropdown updates, activity timeline shows `status_changed: New → Contacted`.
7. Reload the page — changes persist (data is in Supabase, not just local state).

## Empty State
- Delete all leads (or use a fresh Supabase project with no seed). Open `/` — empty state message visible, no JS errors.

## Error Cases
- Submit Add Lead form with email field blank — inline validation error, no DB write.
- Simulate OpenAI timeout (set bad API key) — lead saves successfully with `priority_score = null` and `priority_review_status = 'error'`; no crash.
- Navigate to `/leads/nonexistent-uuid` — 404 message shown, not a blank screen.

## Audit Check
- After any create or status change, query `audit_logs` in Supabase dashboard — row exists with correct `action` and `payload`.
