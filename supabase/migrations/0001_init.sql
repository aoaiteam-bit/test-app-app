create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  company text,
  email text,
  source text,
  status text not null default 'New',
  notes text,
  priority_score numeric,
  priority_source text,
  priority_confidence numeric,
  priority_review_status text not null default 'unreviewed',
  created_at timestamptz not null default now()
);

alter table leads enable row level security;

drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);
drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  lead_id uuid references leads(id) on delete cascade,
  action text not null,
  detail jsonb,
  created_at timestamptz not null default now()
);

alter table activities enable row level security;

drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  lead_id uuid,
  actor_id uuid,
  action text not null,
  payload jsonb,
  created_at timestamptz not null default now()
);

alter table audit_logs enable row level security;

drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into leads (id, name, company, email, source, status, notes, priority_score, priority_source, priority_confidence, priority_review_status) values
  ('a1b2c3d4-0001-0001-0001-000000000001', 'Sarah Chen', 'Momentum Labs', 'sarah.chen@momentumlabs.io', 'Referral', 'Qualified', 'Met at SaaStr. VP of Sales, evaluating tools for a 30-person team. Budget confirmed for Q3.', 87, 'rule-based', 0.9, 'unreviewed'),
  ('a1b2c3d4-0002-0002-0002-000000000002', 'Marcus Rivera', 'Bridgepoint Capital', 'mrivera@bridgepoint.com', 'LinkedIn', 'Contacted', 'Engaged with two LinkedIn posts. Interested in reducing CRM overhead. Follow up Friday.', 64, 'rule-based', 0.85, 'unreviewed'),
  ('a1b2c3d4-0003-0003-0003-000000000003', 'Priya Nair', 'Stackline Inc', 'priya.nair@stackline.com', 'Cold Outreach', 'New', 'Found via job posting — hiring 5 AEs. Reached out cold. No reply yet.', 45, 'rule-based', 0.75, 'unreviewed'),
  ('a1b2c3d4-0004-0004-0004-000000000004', 'Tom Weston', 'Clearpath Logistics', 'tweston@clearpath.io', 'Conference', 'Contacted', 'Chatted at RevSummit. Needs a demo for his director. Scheduling next week.', 71, 'rule-based', 0.88, 'unreviewed');

insert into activities (lead_id, action, detail) values
  ('a1b2c3d4-0001-0001-0001-000000000001', 'lead_created', '{"note": "Seeded demo lead"}'),
  ('a1b2c3d4-0001-0001-0001-000000000001', 'status_changed', '{"from": "New", "to": "Qualified"}'),
  ('a1b2c3d4-0002-0002-0002-000000000002', 'lead_created', '{"note": "Seeded demo lead"}'),
  ('a1b2c3d4-0002-0002-0002-000000000002', 'status_changed', '{"from": "New", "to": "Contacted"}'),
  ('a1b2c3d4-0003-0003-0003-000000000003', 'lead_created', '{"note": "Seeded demo lead"}'),
  ('a1b2c3d4-0004-0004-0004-000000000004', 'lead_created', '{"note": "Seeded demo lead"}'),
  ('a1b2c3d4-0004-0004-0004-000000000004', 'status_changed', '{"from": "New", "to": "Contacted"}');

insert into audit_logs (lead_id, action, payload) values
  ('a1b2c3d4-0001-0001-0001-000000000001', 'lead_created', '{"after": {"name": "Sarah Chen", "status": "Qualified"}}'),
  ('a1b2c3d4-0002-0002-0002-000000000002', 'lead_created', '{"after": {"name": "Marcus Rivera", "status": "Contacted"}}'),
  ('a1b2c3d4-0003-0003-0003-000000000003', 'lead_created', '{"after": {"name": "Priya Nair", "status": "New"}}'),
  ('a1b2c3d4-0004-0004-0004-000000000004', 'lead_created', '{"after": {"name": "Tom Weston", "status": "Contacted"}}');