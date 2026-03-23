# Week 3 — Monitoring Polish + ChainVault Stripe & OAuth

**Dates:** 2026-04-06 to 2026-04-12
**Focus:** 40% monitoring completion / 40% ChainVault / 20% outreach continuation
**Target hours:** 20

---

## Monitoring Polish (8 hours)

### M7 — Per-App Grafana Dashboards (2-3 hours)
- [ ] Create ChainVault App dashboard:
  - API request rate + error rate
  - Latency p50/p95/p99
  - Active deals gauge
  - Document uploads/day
  - Wire verifications by result
  - Stripe payment outcomes
- [ ] Create Verarta App dashboard:
  - API request rate
  - Artwork uploads/day
  - Chunk upload throughput
  - WebAuthn auth success/failure ratio
  - Pace controller state
- [ ] Provision as JSON dashboard files

### M8 — Database Exporters (1 hour)
- [ ] Add to docker-compose.monitoring.yml:
  - `postgres-exporter` (pointing to ChainVault + Verarta PostgreSQL instances)
  - `redis-exporter` (pointing to Redis instances)
  - `elasticsearch-exporter` (pointing to ES clusters)
- [ ] Add scrape targets to Prometheus config
- [ ] Test: all exporters reporting metrics

### M9 — Database Grafana Dashboards (2 hours)
- [ ] Create PostgreSQL dashboard: active connections, queries/sec, cache hit ratio, table sizes, slow queries
- [ ] Create Redis dashboard: memory usage, key count, hit/miss ratio, connected clients
- [ ] Create Elasticsearch dashboard: cluster health, shard count, indexing rate, search latency
- [ ] Provision as JSON dashboard files

### M10 — Alertmanager (1 hour)
- [ ] Configure Alertmanager with MiaB SMTP (ami@amiheines.com)
- [ ] Write alert rules in Prometheus:
  - Host disk usage > 80%
  - Container restart count > 3 in 5 minutes
  - Any scrape target down for > 2 minutes
  - Node memory usage > 90%
- [ ] Test: trigger a test alert, verify email arrives

### M11 — Uptime Kuma (1-2 hours)
- [ ] Deploy Uptime Kuma container
- [ ] Configure endpoint monitors:
  - amiheines.com (HTTPS)
  - chainvault.amiheines.com (HTTPS)
  - verarta.com (HTTPS)
  - pofov.com (HTTPS)
  - lists.amiheines.com (HTTPS)
  - matomo.amiheines.com (HTTPS)
- [ ] Set up public status page at status.amiheines.com
- [ ] Configure email notifications on downtime

### M12 — Nginx Configs (30 min)
- [ ] Create nginx config for monitoring.amiheines.com → Grafana (auth-protected)
- [ ] Create nginx config for status.amiheines.com → Uptime Kuma (public)
- [ ] Run certbot for both domains
- [ ] Test: access both URLs, verify SSL

---

## ChainVault Expansion Start (8 hours)

### CV1 — Stripe Live Integration (3-4 hours)
- [ ] Add Stripe live API keys to production .env
- [ ] Test webhook endpoint with Stripe CLI (`stripe listen --forward-to`)
- [ ] Create test subscription lifecycle: sign up → trial → payment → invoice → cancel
- [ ] Verify billing_subscriptions and billing_usage tables update correctly
- [ ] Test edge cases: failed payment, card update, plan change
- [ ] Confirm email notifications fire on billing events

### CV2 — OAuth SSO Completion (3-4 hours)
- [ ] Configure Google OAuth app (Google Cloud Console):
  - Set authorized redirect URIs
  - Add amiheines.com domain
- [ ] Configure Microsoft Entra ID app:
  - Register app in Azure Portal
  - Set redirect URIs
  - Configure permissions
- [ ] Wire up Auth.js providers in ChainVault Next.js config
- [ ] Test login flow: Google sign-in → account creation → session → dashboard
- [ ] Test login flow: Microsoft sign-in → account creation → session → dashboard
- [ ] Verify SSO users can access all features (deals, documents, wire verification)

---

## Outreach Continuation (4 hours)

- [ ] Send 10-15 new personalized LinkedIn messages
- [ ] Follow up on week 2 messages (anyone who viewed but didn't respond)
- [ ] Post 3-5 LinkedIn insights this week (short, opinion-driven)
- [ ] Comment on 10+ prospect posts (add value, build visibility)
- [ ] Track metrics: messages sent, responses, calls booked
- [ ] If any discovery calls happen: run them, take notes, iterate pitch

---

## Content (spare time)

- [ ] Write/publish blog post #2 (candidate: "Why Your Sysadmin Can Edit Your Audit Logs")
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] All monitoring dashboards live (Server, Docker, Blockchain, Apps, DBs)
- [ ] Alertmanager sending email alerts
- [ ] Uptime Kuma public status page at status.amiheines.com
- [ ] monitoring.amiheines.com accessible with auth
- [ ] ChainVault Stripe live and tested end-to-end
- [ ] ChainVault Google + Microsoft SSO working
- [ ] 30-35 total LinkedIn outreach messages sent
- [ ] Blog post #2 published
