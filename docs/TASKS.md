# Tasks & Sprints

## Sprint 1 — DB + Core Lead Engine ✅ v1 functional milestone
**Goal:** Leads are visible on the homepage, and a rep can add, edit, and change the status of a lead end-to-end — all persisted to the database. No login required.

- [ ] Apply migration SQL (leads, activities, audit_logs tables + seed data)
- [ ] Build `/` page: leads table sorted by priority_score, shows name/company/status/score
- [ ] Build "Add Lead" drawer/modal form (name, company, email, source, status, notes)
- [ ] Server action: insert lead → write activity row → write audit row
- [ ] Build lead detail page `/leads/[id]`: fields + activity timeline
- [ ] Status-change dropdown on detail page → updates DB → logs activity + audit
- [ ] Rule-based priority score computed on save (no AI yet), stored in DB
- [ ] Empty state copy on dashboard when no leads exist
- [ ] Loading and error states on form submit

**Definition of Done:** Open `/`, see seeded leads with scores. Click Add Lead, fill form, submit — new row appears with a score. Open lead, change status — timeline updates. All writes hit Supabase.

---

## Sprint 2 — AI Scoring + Polish
**Goal:** Replace rule-based score with GPT-4o; app looks portfolio-ready.

- [ ] `/api/score-lead` server route calls OpenAI, writes score + source + confidence + review_status
- [ ] Score badge shows confidence indicator (color-coded)
- [ ] "Suggest next action" call-to-action on lead detail (medium-risk: rep confirms)
- [ ] Responsive layout, clear typography, favicon, page titles
- [ ] Deploy to Vercel, confirm shareable URL works

**Definition of Done:** Add a lead → AI score appears within 3 s. Suggest next action shows a proposal the rep can confirm or dismiss.

---

## Sprint 3 — Lock It Down (Auth + Per-User RLS)
**Goal:** Real users can sign up, log in, and see only their own leads.

- [ ] Enable Supabase Auth (email/password)
- [ ] Add `/login` and `/signup` pages
- [ ] Replace v1 RLS policies with `auth.uid() = user_id` owner policies
- [ ] Stamp `user_id` on all writes post-login
- [ ] Redirect unauthenticated users to `/login`

**Definition of Done:** Two different accounts each see only their own leads. Anonymous visit to `/` redirects to `/login`.

---

## Gantt (sprints × weeks)
```
Week 1: Sprint 1 — DB + Core Lead Engine
Week 2: Sprint 2 — AI Scoring + Polish
Week 3: Sprint 3 — Lock It Down
```
