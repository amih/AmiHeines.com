# Week 6 — Verarta Logging + Monitoring + File Pipeline

**Dates:** 2026-04-27 to 2026-05-03
**Focus:** 80% Verarta expansion / 20% outreach + content
**Target hours:** 20

---

## Verarta Expansion (16 hours)

### V3 — Structured Logging (3-4 hours)
- [ ] Install `pino` in Verarta backend
- [ ] Replace `console.error()` in all 32 API endpoints with pino structured logs:
  - `logger.info()` for successful operations
  - `logger.error()` with full error context (stack, request body, user)
  - `logger.warn()` for retries, rate limits, validation failures
- [ ] Add request ID middleware (generate UUID per request, include in all logs)
- [ ] Add user context to logs where available (blockchain account, user ID)
- [ ] Configure pino JSON output for Promtail consumption
- [ ] Test: Grafana → Loki → query Verarta logs by endpoint, level, request ID, user

### V4 — Verarta Grafana Dashboard (3 hours)
- [ ] Create Verarta dashboard with panels:
  - **Overview row:** total artworks, total users, active uploads, uptime
  - **API row:** request rate, error rate, latency p50/p95/p99, top endpoints
  - **Blockchain row:** head block, Savanna finality status, pace controller state, transactions/min
  - **Upload row:** artworks registered/day, chunks uploaded, upload duration, failed uploads
  - **Auth row:** WebAuthn registration/login success rate, active sessions
  - **Quota row:** per-user quota utilization, users near limit
- [ ] Provision as JSON dashboard file
- [ ] Test: all panels render with real data

### V5 — Alert Rules (1-2 hours)
- [ ] Add Verarta-specific Prometheus alert rules:
  - `VerartaBlockchainFinalityLag` — finality lag > 30 seconds
  - `VerartaPaceControllerStuck` — state unchanged for > 10 minutes during activity
  - `VerartaUploadFailureRate` — chunk upload failure > 10% in 5 minutes
  - `VerartaAuthFailureSpike` — WebAuthn failures > 20% in 5 minutes
  - `VerartaAPIErrorRate` — error rate > 5% for 5 minutes
- [ ] Test alerts where possible
- [ ] Verify email delivery

### V6 — File Download / Reassembly (4-5 hours)
- [ ] Implement image retrieval pipeline in Verarta backend:
  - Query all chunks for an image from Hyperion history API (ordered by chunk_index)
  - Reassemble chunks in order
  - Decode from base64
  - Serve with correct Content-Type header
- [ ] Implement Redis-cached thumbnails:
  - Generate 300x300 thumbnail on first request (Sharp)
  - Cache in Redis with TTL (24 hours)
  - Serve cached version on subsequent requests
- [ ] Add API endpoint: `GET /api/artworks/:id/image` and `GET /api/artworks/:id/thumbnail`
- [ ] Handle edge cases: incomplete uploads, missing chunks, corrupted data
- [ ] Test: upload artwork → retrieve full image → verify matches original → verify thumbnail

### V7 — Public Gallery (4-5 hours)
- [ ] Create public gallery page at verarta.com:
  - Grid of registered artworks with thumbnails
  - Click through to individual artwork page
  - Show provenance chain: registration date, blockchain transaction, artist info
  - Link to blockchain explorer for each artwork (transaction ID)
- [ ] Add artwork visibility controls (artist can mark artwork as public/private)
- [ ] SEO: meta tags, Open Graph, structured data for artworks
- [ ] Add gallery link to amiheines.com/portfolio
- [ ] Test: public gallery renders, images load from chain, provenance links work

---

## Outreach + Content (4 hours)

### Outreach (2-3 hours)
- [ ] Send 10-15 new LinkedIn messages
- [ ] Follow up on pipeline (anyone close to booking a call?)
- [ ] Post 3-5 LinkedIn insights
- [ ] Comment on prospect posts
- [ ] Running total: 65-80 outreach messages

### Content (1-2 hours)
- [ ] Publish blog post #5 or YouTube video #2
  - Candidate: "Reassembling Files Stored on a Blockchain — The Art Provenance Pipeline" (from V6 work)
  - Candidate: "Digital Provenance for Physical Art: How Verarta Works Under the Hood"
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] Verarta has structured logging, queryable in Grafana
- [ ] Verarta Grafana dashboard live with real data
- [ ] Verarta alert rules active and tested
- [ ] File download/reassembly pipeline working (upload → retrieve → matches)
- [ ] Public gallery page live at verarta.com
- [ ] Gallery linked from amiheines.com/portfolio
- [ ] 65-80 outreach messages total
