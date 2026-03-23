# Week 15 — POFOV Finish + Email Sequences + Scraper Upgrades

**Dates:** 2026-06-29 to 2026-07-05
**Focus:** 80% POFOV completion / 20% outreach + content
**Target hours:** 20

---

## POFOV Completion (16 hours)

### PF5 — Capability Matrix Page (4-5 hours)
- [ ] Create `/matrix` page — interactive filterable blockchain comparison table:
  - Columns: Platform, Consensus, Smart Contracts (yes/no), On-Chain Storage (yes/no), Privacy Features, TPS Claimed, Enterprise Ready, Category
  - Data sources: AI scrape answers (parsed into structured fields) + manual curation for 7 enterprise chains
  - Filters: by capability (checkboxes), by category, by enterprise-ready
  - Sort: by any column
  - Search: text search across platform names
- [ ] "Export to CSV" button (gated — email required)
- [ ] Highlight enterprise chains with visual badge
- [ ] Link each row to corresponding POFOV coin/enterprise page
- [ ] SEO: target "blockchain comparison chart", "which blockchain supports smart contracts"
- [ ] Test: filter, sort, search all work; export triggers email gate

### PF8 — Listmonk Email Sequences (3-4 hours)
- [ ] Create POFOV-specific welcome sequence in Listmonk (5 emails over 14 days):
  1. **Day 0:** Deliver gated content (report/comparison) + "Here's what else POFOV offers" (matrix, enterprise guides)
  2. **Day 3:** "3 things most teams get wrong choosing a blockchain platform" — educational, positions you as expert
  3. **Day 7:** "Private vs public blockchain: when each one wins" — links to amiheines.com blog post
  4. **Day 10:** Case study: "How ChainVault uses Antelope for wire fraud prevention" — links to amiheines.com/portfolio
  5. **Day 14:** "Want help evaluating blockchain for your project? → Book a free 30-min discovery call" → amiheines.com/contact
- [ ] Create weekly digest template:
  - New coins added to POFOV this week
  - Enterprise blockchain news highlights
  - Featured comparison of the week
  - Every 4th issue: consulting CTA
- [ ] Configure sending: welcome sequence auto-triggered on POFOV list signup
- [ ] Test: full sequence delivery, links work, unsubscribe works

### PF9 — Category Deep Dive Pages (5-6 hours)
- [ ] Create `/category/[name]` pages for all 17 categories:
  - Category description and significance
  - Curated top 10 picks in the category (from POFOV data, ranked by market cap + editorial opinion)
  - Key trends in this category (editorial — 2-3 paragraphs)
  - "Enterprise applicability" assessment (high/medium/low)
  - Downloadable PDF summary (gated)
  - Grid of all coins in this category (linking to individual pages)
- [ ] Prioritize enterprise-relevant categories first:
  1. Enterprise, 2. Infrastructure, 3. Identity, 4. Data/Oracles, 5. Storage, 6. Payments
- [ ] SEO: "best enterprise blockchain 2026", "blockchain for identity management", etc.
- [ ] Link from main navigation and homepage category filter

### PF10 — POFOV Monitoring (3-4 hours)
- [ ] Install `prom-client` in pofov.com Astro backend:
  - `pofov_page_views_total{page_type, slug}` — views by page type (coin, compare, matrix, enterprise)
  - `pofov_email_signups_total{source}` — signups by source (modal, inline, gated content)
  - `pofov_pdf_downloads_total{slug}` — PDF report downloads
  - `pofov_comparison_views_total{pair}` — which comparisons are popular
  - Common: `http_requests_total`, `http_request_duration_seconds`
- [ ] Add metrics to scraper FastAPI:
  - `scraper_job_duration_seconds{type}` — scrape job duration
  - `scraper_coins_processed_total{type}` — coins processed per scrape
  - `scraper_errors_total{type, error}` — scrape errors
- [ ] Expose `/metrics` on both
- [ ] Create POFOV Grafana dashboard:
  - Traffic: page views/day, top coins, top comparisons
  - Conversions: email signups/day, PDF downloads, signup sources
  - Scraper health: last job run, duration, errors, coins processed
- [ ] Add pofov.com + scrapecmc.pofov.com to Uptime Kuma

### PF11 — Scraper Improvements (time permitting, 2-3 hours)
- [ ] Add cron scheduling to scraper (weekly auto-rescrape on Sunday 02:00):
  - Phase 1: listings refresh
  - Phase 2: deep scrape (new coins only, unless full rescrape flag)
  - Phase 3: AI questions for new coins
- [ ] Add new enterprise-focused AI questions:
  - "Is [coin] suitable for enterprise private deployments?"
  - "What are the storage capabilities of [coin] blockchain?"
- [ ] Add structured capability classification to AI output:
  - Parse AI answers to extract: has_smart_contracts, has_storage, has_privacy, enterprise_ready (boolean fields)
  - Store in new structured field alongside raw Q&A
  - Feed into capability matrix (PF5)

---

## Outreach + Content (4 hours)

### Outreach (2-3 hours)
- [ ] Send 10 new LinkedIn messages
- [ ] Pipeline management
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 155-210 outreach messages
- [ ] Share POFOV matrix page on LinkedIn: "I mapped the capabilities of 50+ blockchain platforms"

### Content (1-2 hours)
- [ ] Publish blog post #14
  - Candidate: "I Asked AI to Evaluate Every Major Blockchain for Enterprise Use — Here's the Ranking"
  - Candidate: "Building an AI-Powered Comparison Tool for Blockchain Platforms"
- [ ] Share on LinkedIn with link to POFOV

---

## End-of-Week Checkpoints

- [ ] POFOV complete:
  - Email capture + gating + comparison tool + PDF reports + matrix + enterprise pages + category pages
  - Listmonk sequences configured and tested
  - Monitoring + Grafana dashboard live
  - Scraper auto-scheduling (if completed)
- [ ] **POFOV is now a full lead generation engine**
- [ ] 155-210 outreach messages total
- [ ] Track: POFOV signups this week, gated content unlocks, consulting CTAs clicked
