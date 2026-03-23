# Week 4 — ChainVault Monitoring + Logging + Alerts

**Dates:** 2026-04-13 to 2026-04-19
**Focus:** 70% ChainVault observability / 20% outreach / 10% content
**Target hours:** 20

---

## ChainVault Expansion (14 hours)

### CV3 — Prometheus Metrics Enhancement (3-4 hours)
- [ ] Expand chain-service metrics:
  - `chainvault_wire_verifications_total{result}` (match/mismatch/flagged)
  - `chainvault_stripe_payments_total{status}` (succeeded/failed/refunded)
  - `blockchain_transaction_duration_seconds` (histogram)
  - `chainvault_documents_uploaded_total` (counter)
  - `chainvault_deals_total{status}` (gauge: open/closed/cancelled)
- [ ] Add metrics to Next.js API middleware:
  - Per-route latency and error tracking
  - `http_request_size_bytes` / `http_response_size_bytes`
- [ ] Add metrics to hyperion-sync:
  - `hyperion_sync_actions_processed_total`
  - `hyperion_sync_lag_seconds`
  - `hyperion_sync_reconnections_total`
- [ ] Update Prometheus scrape config for new endpoints
- [ ] Test: all new metrics visible in Prometheus

### CV4 — Structured Logging (2-3 hours)
- [ ] Install `pino` in chain-service
- [ ] Replace all `console.log` / `console.error` calls in chain-service/src/index.ts with pino:
  - `logger.info()` for normal operations
  - `logger.error()` for failures (include error stack, request context)
  - `logger.warn()` for retries, rate limits
- [ ] Add request ID to every log entry (generate UUID per request)
- [ ] Replace all logging in hyperion-sync/src/sync.ts with pino
- [ ] Configure pino to output JSON (Promtail auto-parses JSON)
- [ ] Test: Grafana Explore → Loki → can query ChainVault logs by level, request ID

### CV5 — Health Check Dashboard (2 hours)
- [ ] Expand chain-service `GET /health` to return detailed status:
  ```json
  {
    "status": "healthy|degraded|unhealthy",
    "blockchain": { "connected": true, "head_block": 12345, "producers_active": 4 },
    "database": { "connected": true, "pool_size": 10, "active": 3 },
    "redis": { "connected": true, "memory_mb": 45 },
    "minio": { "connected": true, "buckets": ["documents"] },
    "hyperion": { "connected": true, "last_indexed_block": 12340 }
  }
  ```
- [ ] Add health check metrics to Prometheus (gauge per component: 1=up, 0=down)
- [ ] Create Grafana health panel: traffic-light status for each component

### CV6 — ChainVault Grafana Dashboard (3 hours)
- [ ] Create comprehensive ChainVault dashboard with panels:
  - **Overview row:** total deals, total documents, total users, uptime
  - **API row:** request rate, error rate, latency p50/p95/p99, top endpoints
  - **Blockchain row:** head block, transactions/min, finality lag, producer status
  - **Business row:** deals created/day, documents uploaded/day, wire verifications
  - **Payments row:** Stripe payments by status, revenue (if available)
  - **Infrastructure row:** service health, memory, CPU per container
- [ ] Provision as JSON dashboard file
- [ ] Test: all panels render with real data

### CV7 — Alert Rules (2 hours)
- [ ] Add ChainVault-specific Prometheus alert rules:
  - `ChainVaultBlockchainStopped` — head block unchanged for > 5 minutes
  - `ChainVaultAPIErrorRateHigh` — error rate > 5% for 5 minutes
  - `ChainVaultStripeWebhookFailed` — any Stripe webhook failure
  - `ChainVaultDiskUsageHigh` — disk > 80%
  - `ChainVaultServiceRestarted` — container restart detected
  - `ChainVaultHyperionLag` — sync lag > 100 blocks
  - `ChainVaultHealthDegraded` — health endpoint returns degraded/unhealthy
- [ ] Test each alert by simulating the condition where possible
- [ ] Verify email delivery via Alertmanager

---

## Outreach (4 hours)

- [ ] Send 10-15 new LinkedIn messages
- [ ] Follow up on prior messages (2nd touch for non-responders from week 2)
- [ ] Post 3-5 LinkedIn insights
- [ ] Comment on 10+ prospect posts
- [ ] Any discovery calls: run, take notes, send follow-up proposals
- [ ] Running total: 45-50 outreach messages sent

---

## Content (2 hours)

- [ ] Write/publish blog post #3
  - Candidate: "Monitoring a Private Blockchain: What Metrics Actually Matter" (from CV3-CV6 work)
- [ ] Share on LinkedIn
- [ ] Set up YouTube channel if not done: name, branding, thumbnail template, channel description

---

## End-of-Week Checkpoints

- [ ] ChainVault fully observable: metrics, structured logs, health checks, alerts
- [ ] ChainVault Grafana dashboard showing real production data
- [ ] All alert rules tested and email delivery confirmed
- [ ] 45-50 total outreach messages sent, tracking response rate
- [ ] Blog post #3 published
- [ ] YouTube channel set up (even if no videos yet)
