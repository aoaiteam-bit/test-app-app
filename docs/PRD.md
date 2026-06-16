# PRD — Lead Tracker for Sales Reps

## Problem
Sales reps lose track of leads scattered across notes and spreadsheets. There's no quick way to log a lead, see its status, and know what to do next — all in one place.

## Target User
A solo sales rep (or the recruiter demoing the portfolio) who needs to capture, track, and prioritize leads without a bloated CRM.

## Core Objects
- **Lead** — the central record: contact info, source, status, notes, AI-generated priority score.
- **Activity** — every action taken on a lead (note added, status changed, email drafted).
- **Audit Log** — immutable record of every write.

## MVP Checklist (v1 must-haves)
- [ ] Landing page shows live leads table (no login required)
- [ ] Add a new lead via a form (name, company, email, status, source, notes)
- [ ] Change lead status (New → Contacted → Qualified → Closed)
- [ ] View a lead detail page with activity timeline
- [ ] AI scores each lead 1–100 on save (rule-based v1, LLM v1+)
- [ ] Seed data makes the app look alive on first load
- [ ] Deployed to Vercel with a shareable URL

## Non-Goals (v1)
- No Salesforce sync
- No multi-user teams or invitations
- No email sending
- No login wall (auth is a later sprint)

## Success Criteria
A recruiter opens the URL, sees a populated leads dashboard, adds a new lead, changes its status, and sees the AI score — all in under 30 seconds, with every action persisted to the database.
