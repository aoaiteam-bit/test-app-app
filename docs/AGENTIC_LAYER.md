# Agentic Layer

## Risk Levels & Actions

### Low Risk — Auto-execute
- `score_lead` — compute and write priority score on save.
- `tag_source` — normalise free-text source to canonical value.
- `summarise_notes` — generate a one-line summary from long notes.

### Medium Risk — Light approval
- `suggest_next_action` — propose "Send intro email" or "Schedule call"; rep clicks Confirm.
- `update_status` — agent proposes status change based on activity; rep approves.

### High Risk — Always approval
- `draft_email` — generate outreach email; shown in preview, rep must click Send.

### Critical — Human only
- Delete a lead (UI button, no agent path).

## Named Tools (v1)
- `score_lead(lead_id)` — server action, calls OpenAI, writes score fields.
- `log_activity(lead_id, action, detail)` — inserts activity row.
- `write_audit(lead_id, action, payload)` — inserts audit_log row.

## Audit Log Fields
`id, lead_id, actor_id, action, payload (before/after), created_at`

## v1 vs Later
- **v1:** `score_lead`, `log_activity`, `write_audit`.
- **Later:** `draft_email`, `suggest_next_action`, `bulk_import`.
