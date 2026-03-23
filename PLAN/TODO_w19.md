# Week 19 — ChainTalk: Monitoring + Deploy + Integrate into POFOV

**Dates:** 2026-07-27 to 2026-08-02
**Focus:** 60% ChainTalk deploy + monitoring / 30% integrations / 10% outreach
**Target hours:** 20

---

## ChainTalk Deploy + Monitoring (12 hours)

### CT10 — Prometheus Metrics (2-3 hours)
- [ ] Install `prom-client` in ChainTalk backend:
  - `chaintalk_comments_posted_total{site}` — comments per site
  - `chaintalk_votes_total{site, direction}` — votes by direction
  - `chaintalk_moderations_total{site, action}` — moderation actions
  - `chaintalk_sites_registered_total` — total registered sites
  - `chaintalk_active_users_total` — users who posted in last 24h
  - `chaintalk_embed_loads_total{site}` — widget loads (from embed.js requests)
  - `blockchain_transaction_duration_seconds` — chain tx latency
  - Common: `http_requests_total`, `http_request_duration_seconds`, `app_errors_total`
- [ ] Expose `/metrics` endpoint
- [ ] Add to Prometheus scrape config
- [ ] Test: metrics visible in Prometheus

### CT11 — Grafana Dashboard (2-3 hours)
- [ ] Create ChainTalk dashboard:
  - **Overview:** total sites, total comments, total users, comments today
  - **Activity:** comments posted/day, votes/day, new users/day
  - **Sites:** top sites by comment volume, embed loads/day
  - **Moderation:** moderation actions/day, flagged comments pending
  - **API:** request rate, latency p50/p95/p99, error rate
  - **Blockchain:** tx latency, tx volume, chain health
- [ ] Provision as JSON dashboard file
- [ ] Test: panels render with data from test comments

### CT12 — Deployment (2-3 hours)
- [ ] Create nginx config for chaintalk.amiheines.com:
  - Landing page + dashboard: proxy to port 4323
  - API: proxy to /api/
  - Embed script: proxy to /api/embed.js with aggressive cache headers
  - Widget iframe: proxy to /widget/
  - SSL via certbot
  - CORS headers for embed cross-origin requests
- [ ] PM2 ecosystem config for chaintalk-backend
- [ ] Create deploy script
- [ ] Production .env from template
- [ ] DNS: A record for chaintalk.amiheines.com
- [ ] Deploy to server
- [ ] Add to Uptime Kuma
- [ ] Test: full flow from external site embedding to comment posting

---

## Integrations (6 hours)

### CT13 — Integrate ChainTalk into POFOV (3-4 hours)
- [ ] Register pofov.com as a site in ChainTalk
- [ ] Verify domain ownership
- [ ] Add ChainTalk embed to every POFOV coin page template:
  - Place below coin content, above footer
  - `data-page-id` = coin slug (e.g., `/project/bitcoin`)
  - Light theme to match POFOV design
- [ ] Add ChainTalk embed to comparison pages
- [ ] Add ChainTalk embed to enterprise pages
- [ ] Seed 5-10 starter comments on popular coin pages (from your account — kickstart discussion)
- [ ] Test: visit coin page → see comment widget → post a comment → appears on chain
- [ ] Matomo: track ChainTalk engagement on POFOV pages

### CT14 — Integrate ChainTalk into amiheines.com (1-2 hours)
- [ ] Register amiheines.com as a site in ChainTalk
- [ ] Add ChainTalk embed to blog post template
- [ ] `data-page-id` = blog post slug
- [ ] Seed 1-2 comments on existing blog posts
- [ ] Test: blog post → comments visible → can post
- [ ] Verify: "Powered by ChainTalk" links to chaintalk.amiheines.com

---

## Outreach + Content (2 hours)

### Outreach (1-2 hours)
- [ ] Send 5-10 LinkedIn messages
- [ ] Pipeline management
- [ ] Post 2-3 LinkedIn insights
- [ ] Running total: 190-250 outreach messages

### Content (1 hour)
- [ ] Publish blog post #18
  - Candidate: "Adding Blockchain Comments to 1,000 Pages in One Deploy" (CT13 experience)
  - Candidate: "Why I Added Blockchain Comments to 1,000 Crypto Research Pages (And What Happened)"
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] ChainTalk fully deployed at chaintalk.amiheines.com
- [ ] Monitoring: metrics, Grafana dashboard, Uptime Kuma
- [ ] ChainTalk embedded on all POFOV pages (1,000+ pages with blockchain comments)
- [ ] ChainTalk embedded on amiheines.com blog posts
- [ ] Both sites verified and active in ChainTalk
- [ ] 190-250 outreach messages total
