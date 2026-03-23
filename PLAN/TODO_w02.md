# Week 2 — Outreach Launch + Listmonk Setup + Monitoring Dashboards

**Dates:** 2026-03-30 to 2026-04-05
**Focus:** 50% outreach & email infrastructure / 50% monitoring completion
**Target hours:** 20

---

## Outreach & Email (10 hours)

### Prospect List Building (4 hours)
- [ ] Build spreadsheet/CRM with 120+ contacts across 4 verticals:
  - 50 real estate title company CTOs / IT directors
  - 30 legal firm technology partners / CIOs
  - 20 healthcare compliance officers
  - 20 government IT directors
- [ ] For each: name, company, title, LinkedIn URL, specific pain point note
- [ ] Research 5-10 companies deeply (recent news, transactions, compliance issues) for personalized outreach

### Outreach Templates (2 hours)
- [ ] Write 3-4 LinkedIn message templates:
  - Template A: Real estate / wire fraud angle
  - Template B: Legal / document integrity angle
  - Template C: Healthcare / audit trail angle
  - Template D: General tamper-proof records angle
- [ ] Each template: 1 specific reference to their company/industry, 1 pain point sentence, offer free 30-min audit, link to amiheines.com
- [ ] Create discovery call script (30 min format: 10 min listen, 10 min diagnose, 10 min propose)
- [ ] Create proposal template (1-page, covers all tiers)

### First Outreach Batch (2 hours)
- [ ] Send 15-20 personalized LinkedIn messages (use templates, customize per prospect)
- [ ] Comment on 10-15 target prospects' LinkedIn posts (add value, don't pitch)
- [ ] Post first LinkedIn insight (1-2 paragraphs on wire fraud, audit trails, or tamper-proof records)
- [ ] Track: messages sent, connection requests accepted, responses received

### Listmonk Setup — Phase 3 (2 hours)
- [ ] Create lists in Listmonk:
  - amiheines.com subscribers
  - POFOV subscribers (for later)
  - Lead magnet downloaders
- [ ] Configure double opt-in
- [ ] Create email templates (branded, responsive HTML)
- [ ] Build welcome sequence (5 emails over 14 days):
  1. Welcome + link to best resource (checklist PDF)
  2. Your story + why private blockchain
  3. Case study: ChainVault
  4. Common misconceptions about blockchain in enterprise
  5. "How I can help" + book a call CTA
- [ ] Test: sign up → receive welcome email → sequence triggers correctly

---

## Monitoring Stack Completion (10 hours)

### M4 — Grafana Dashboard JSON Files (3-4 hours)
- [ ] Create Server Overview dashboard: Host CPU, RAM, disk, network, load average
- [ ] Create Docker Containers dashboard: per-container CPU, RAM, network I/O, restart count
- [ ] Create Blockchain Health dashboard: block production rate, head block, finality
- [ ] Provision all dashboards as code (JSON files in `/opt/monitoring/grafana/dashboards/`)
- [ ] Configure Grafana datasources provisioning (Prometheus + Loki)
- [ ] Test: dashboards auto-load on fresh Grafana start

### M5 — ChainVault Prometheus Metrics (2-3 hours)
- [ ] Install `prom-client` in ChainVault chain-service
- [ ] Add metrics middleware to Express.js:
  - `http_requests_total{method, route, status}`
  - `http_request_duration_seconds{method, route}`
  - `blockchain_head_block_number`
  - `blockchain_transactions_total{contract, action}`
  - `chainvault_deals_total{status}`
  - `chainvault_documents_uploaded_total`
- [ ] Expose `GET /metrics` endpoint on chain-service
- [ ] Add `prom-client` to Next.js API routes (via middleware)
- [ ] Add ChainVault scrape targets to Prometheus config
- [ ] Test: Prometheus can scrape ChainVault metrics

### M6 — Verarta Prometheus Metrics (2 hours)
- [ ] Install `prom-client` in Verarta Astro backend
- [ ] Add metrics middleware:
  - `http_requests_total{method, route, status}`
  - `http_request_duration_seconds{method, route}`
  - `verarta_artworks_registered_total`
  - `verarta_chunks_uploaded_total`
  - `verarta_webauthn_auth_total{result}`
- [ ] Expose `GET /metrics` endpoint
- [ ] Add Verarta scrape targets to Prometheus config
- [ ] Test: Prometheus can scrape Verarta metrics

---

## Content — First Blog Posts (ongoing, 1-2 hours spare time)

- [ ] Write first blog post for amiheines.com (derived from setup work this week):
  - Candidate: "How I Self-Host My Entire Business Infrastructure" or "Enterprise Monitoring for $0"
- [ ] Publish to amiheines.com/blog
- [ ] Share on LinkedIn as a post with key takeaway

---

## End-of-Week Checkpoints

- [ ] 120+ prospects in spreadsheet/CRM
- [ ] 15-20 LinkedIn messages sent, tracking responses
- [ ] Listmonk welcome sequence live and tested
- [ ] Grafana has Server, Docker, and Blockchain dashboards with real data
- [ ] ChainVault and Verarta exposing `/metrics` to Prometheus
- [ ] First blog post published
