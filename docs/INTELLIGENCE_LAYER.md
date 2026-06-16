# Intelligence Layer

## Messy Input
Rep pastes a name, company, a few notes, and a source. No structure guaranteed.

## Auto-Structure on Save
```json
{
  "lead_id": "uuid",
  "priority_score": 72,
  "priority_source": "openai/gpt-4o",
  "priority_confidence": 0.81,
  "priority_review_status": "unreviewed",
  "reasoning": "Decision-maker title, warm referral source, company in ICP"
}
```

## Events Tracked
- Lead created
- Status changed
- Note added
- Score generated

## Scoring Rules (v1 — rule-based)
| Signal | Points |
|---|---|
| Source = Referral | +20 |
| Status = Qualified | +15 |
| Has email | +10 |
| Has company | +10 |
| Notes length > 50 chars | +10 |
| Baseline | 35 |

Max 100. Stored even if AI call skipped.

## What Gets Ranked
- Leads table sorted by `priority_score DESC` by default.

## v1 vs Later
- **v1:** rule-based score on save.
- **Next:** GPT-4o prompt replaces rule engine, confidence stored.
- **Later:** score drift alerts, next-best-action suggestions.
