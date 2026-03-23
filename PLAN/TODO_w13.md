# Week 13 — Parking Monitoring + POFOV Lead Gen Start

**Dates:** 2026-06-15 to 2026-06-21
**Focus:** 40% Parking monitoring / 40% POFOV lead gen / 20% outreach + content
**Target hours:** 20

---

## Parking Monitoring (8 hours)

### P12 — Prometheus Metrics (2-3 hours)
- [ ] Install `prom-client` in parking Astro backend
- [ ] Add metrics:
  - `parking_tickets_issued_total{city, violation_type}`
  - `parking_tickets_paid_total{city}`
  - `parking_tickets_expired_total{city}`
  - `parking_revenue_total_cents{city, currency}`
  - `parking_payment_conversion_rate{city}`
  - `parking_image_upload_duration_seconds`
  - Common: `http_requests_total`, `http_request_duration_seconds`, `app_errors_total`
- [ ] Expose `GET /metrics` endpoint
- [ ] Add Parking scrape target to Prometheus config
- [ ] Test: metrics visible in Prometheus

### P13 — Grafana Dashboard (3 hours)
- [ ] Create Parking Tickets dashboard:
  - **Overview row:** total tickets, revenue, active cities, active employees
  - **Tickets row:** tickets issued/day, by violation type breakdown, by city
  - **Revenue row:** payments/day, payment conversion rate, revenue cumulative
  - **Operations row:** image uploads, upload duration, expired tickets/day
  - **API row:** request rate, error rate, latency p50/p95/p99
- [ ] Provision as JSON dashboard file
- [ ] Test: all panels render with demo data

### P14 — Alert Rules (1-2 hours)
- [ ] Add Parking-specific alert rules:
  - `ParkingPaymentFailure` — Stripe webhook returns failure
  - `ParkingExpirationCronMissed` — cron didn't run in last 26 hours
  - `ParkingAPIErrorRate` — error rate > 5%
  - `ParkingBlockchainLag` — chain transaction taking > 30 seconds
  - `ParkingImageUploadStuck` — incomplete upload older than 2 hours
- [ ] Test alerts
- [ ] Add parking.amiheines.com to Uptime Kuma

---

## POFOV Lead Gen Start (8 hours)

### PF1 — Email Capture Infrastructure (3-4 hours)
- [ ] Create POFOV-specific list in Listmonk
- [ ] Build email signup component for pofov.com:
  - Modal popup (triggered on scroll 50% or after 30 seconds, once per session)
  - Inline form at bottom of every coin page
  - "Get the full report" CTA on coin detail pages
- [ ] Integrate Listmonk API: subscribe endpoint, double opt-in
- [ ] Store subscriber state in cookie (suppress modal for existing subscribers)
- [ ] Test: sign up on pofov.com → appears in Listmonk POFOV list → double opt-in email → confirmed

### PF2 — Content Gating System (4-5 hours)
- [ ] Build gating middleware in Astro:
  - Check for `pofov_subscriber` cookie on gated routes
  - If no cookie: show content preview + email wall overlay
  - After email signup: set cookie, Listmonk API confirms subscription, unlock content
  - Cookie expires after 30 days (re-prompt for re-engagement)
- [ ] Implement gated states for:
  - Full AI report (all 5 questions, all 3 providers) → gated
  - Comparison tool (when built) → gated after first comparison
  - CSV export of any data → gated
- [ ] Free state: basic coin page (about, single AI Q&A, stats) always free
- [ ] Test: visit coin page free → click "full report" → email wall → sign up → content unlocked
- [ ] Track gating events in Matomo (impressions, signups, unlock rate)

---

## Outreach + Content (4 hours)

### Outreach (3 hours)
- [ ] Send 10-15 new LinkedIn messages
- [ ] Pipeline management: follow up, close, propose
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 135-185 outreach messages
- [ ] **Portfolio update:** Add parking.amiheines.com to amiheines.com/portfolio with screenshots and demo link

### Content (1 hour)
- [ ] Publish blog post #12 or YouTube video
  - Candidate: "Grafana Dashboard for a Municipal Parking System — Real-Time Revenue Tracking" (from P13)
  - Candidate: "How I Built 3 Blockchain Apps in 14 Weeks Using Claude Code" (milestone recap)
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] Parking system fully monitored: metrics, dashboard, alerts, uptime
- [ ] **All 3 original projects (ChainVault, Verarta, Parking) complete and monitored**
- [ ] POFOV email capture live: modals, inline forms, Listmonk integration
- [ ] Content gating system working on pofov.com
- [ ] amiheines.com/portfolio updated with all 3 app links
- [ ] 135-185 outreach messages total
