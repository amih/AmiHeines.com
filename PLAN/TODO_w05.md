# Week 5 — ChainVault Finish + Verarta Start

**Dates:** 2026-04-20 to 2026-04-26
**Focus:** 50% ChainVault completion / 30% Verarta start / 20% outreach + content
**Target hours:** 20

---

## ChainVault Completion (10 hours)

### CV8 — Smart Contract Deployment (2-3 hours)
- [ ] Compile chainvault, auditlog, wirevault contracts (C++ → WASM + ABI)
- [ ] Deploy to production chain:
  - Create contract accounts if not existing
  - Set contract code + ABI via `cleos set contract`
  - Set account permissions
- [ ] Verify deployment via Hyperion API (query contract tables)
- [ ] Test: push a sample transaction, confirm it appears in Hyperion history
- [ ] Document deployment steps in DEPLOYMENT.md

### CV9 — Demo Data Seeder (2 hours)
- [ ] Write seeder script (Node.js / TypeScript):
  - Create 2-3 demo organizations
  - Create 5-10 demo users across orgs
  - Create 10-15 demo deals (mix of open, closed, cancelled)
  - Upload 5-10 demo documents (small test files, encrypted)
  - Create 3-5 wire verification records (match, mismatch, flagged)
  - Generate audit trail entries
- [ ] Make script idempotent (safe to re-run)
- [ ] Run on production to populate demo data
- [ ] Verify: data appears correctly in UI and on chain

### CV10 — Public Demo Mode (3-4 hours)
- [ ] Create demo login endpoint: `POST /api/auth/demo`
  - Returns session for read-only demo user
  - Demo user has access to all demo org data
  - All write operations return "Demo mode — read only" error
- [ ] Add "Try Demo" button on ChainVault landing page
- [ ] Add "Demo Mode" badge in UI header when demo session active
- [ ] Restrict demo session: no document downloads, no real Stripe, no email sends
- [ ] Auto-expire demo sessions after 30 minutes
- [ ] Test: click demo → explore deals, documents, audit trail, wire verifications → all read-only
- [ ] Add demo link to amiheines.com/portfolio

---

## Verarta Start (6 hours)

### V1 — Email Infrastructure (3-4 hours)
- [ ] Configure MiaB SMTP credentials in Verarta backend .env
- [ ] Implement actual email sending in email.ts (replace DEV_MODE bypass):
  - Verification code emails (6-digit code, styled HTML template)
  - Welcome email after verification
  - Artwork share notifications
- [ ] Test SMTP delivery: send to test addresses, check deliverability (SPF, DKIM, DMARC)
- [ ] Handle SMTP errors gracefully (retry once, log failure, don't block user action)
- [ ] Verify: full registration flow works with real email delivery

### V2 — Verarta Prometheus Metrics (2-3 hours)
- [ ] Expand existing `prom-client` setup with Verarta-specific metrics:
  - `verarta_artworks_registered_total` — artwork registration counter
  - `verarta_chunks_uploaded_total` — chunk throughput counter
  - `verarta_chunk_upload_duration_seconds` — histogram
  - `verarta_webauthn_auth_total{result}` — auth success/failure
  - `verarta_quota_usage_ratio{user}` — gauge
  - `verarta_pace_controller_state` — gauge (SLOW=0, BURST=1)
- [ ] Verify Prometheus scrapes new metrics
- [ ] Spot-check metrics in Grafana Explore

---

## Outreach + Content (4 hours)

### Outreach (2-3 hours)
- [ ] Send 10-15 new LinkedIn messages
- [ ] Follow up on prior non-responders (3rd touch for week 2, 2nd for week 3)
- [ ] Post 3-5 LinkedIn insights
- [ ] Any discovery calls or proposals
- [ ] Running total: 55-65 outreach messages sent
- [ ] **First revenue check:** any paid engagements closed? Any in pipeline?

### Content (1-2 hours)
- [ ] Publish blog post #4 or first YouTube video
  - Candidate video: "Building a Demo Mode So Prospects Can Try Before They Buy" (from CV10 work)
  - Candidate blog: "How I Built a Wire Fraud Prevention System for Real Estate Closings"
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] ChainVault 100% complete: contracts deployed, demo data, demo mode live
- [ ] ChainVault demo link added to amiheines.com/portfolio
- [ ] Verarta email infrastructure working (real email delivery)
- [ ] Verarta metrics in Prometheus
- [ ] 55-65 total outreach messages, tracking conversion
- [ ] 4 blog posts or 1 video + 3 posts published
