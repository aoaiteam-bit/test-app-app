# Data Model

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | owner, no FK yet |
| name | text | contact full name |
| company | text | |
| email | text | |
| source | text | e.g. LinkedIn, Referral, Cold Outreach |
| status | text | New / Contacted / Qualified / Closed |
| notes | text | |
| priority_score | numeric nullable | **AI field** |
| priority_source | text nullable | e.g. openai/gpt-4o |
| priority_confidence | numeric nullable | 0–1 |
| priority_review_status | text | default 'unreviewed' |
| created_at | timestamptz | now() |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| lead_id | uuid | FK → leads.id |
| user_id | uuid nullable | |
| action | text | lead_created, status_changed, note_added |
| detail | jsonb | e.g. {from: 'New', to: 'Contacted'} |
| created_at | timestamptz | |

## audit_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| lead_id | uuid nullable | |
| actor_id | uuid nullable | |
| action | text | |
| payload | jsonb | full before/after snapshot |
| created_at | timestamptz | |

## RLS
- v1: permissive read + write for all tables (demo mode).
- Lock-down sprint: restrict to `auth.uid() = user_id`.
