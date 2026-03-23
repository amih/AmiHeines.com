# Week 21 — Final Integration, Review, and Acceleration Plan

**Dates:** 2026-08-10 to 2026-08-16
**Focus:** 30% final polish / 30% revenue acceleration / 40% content + outreach scaling
**Target hours:** 20

---

## Final Polish + Review (6 hours)

### Full System Smoke Test (2 hours)
- [ ] Walk through every project as a first-time visitor:
  - **amiheines.com:** Landing → Services → Portfolio → Blog → Contact → Newsletter signup
  - **ChainVault demo:** Click demo → explore deals → documents → audit trail → wire verification
  - **Verarta demo:** Click demo → explore artworks → gallery → provenance → blockchain explorer
  - **Parking demo:** Admin login → dashboard → tickets → employee view → public payment page
  - **POFOV:** Browse coins → enterprise page → comparison tool → download PDF → email captured
  - **ChainTalk:** Landing page → try demo → post comment → see blockchain receipt → admin dashboard
- [ ] Fix any UX issues, broken links, slow pages, or confusing flows
- [ ] Mobile test: repeat above on phone (or browser dev tools mobile mode)

### Grafana Dashboard Review (1 hour)
- [ ] Review all Grafana dashboards with real data:
  - Server, Docker, Blockchain, ChainVault, Verarta, Parking, POFOV, ChainTalk, PostgreSQL, Redis, ES, Nginx
- [ ] Fix any panels with no data or errors
- [ ] Create a "Portfolio Overview" dashboard:
  - Combined view: all 5 apps on one page
  - Total blockchain transactions across all apps
  - Combined API request rate and error rate
  - Status badges for all services
- [ ] Take screenshots of key dashboards for portfolio page and blog posts

### Documentation Pass (1 hour)
- [ ] Update each project's README with current state
- [ ] Ensure DEPLOYMENT.md files are current for all projects
- [ ] Update CLAUDE.md files with any new architecture decisions
- [ ] Clean up any leftover TODO_AMIH.md items

### Security Audit (2 hours)
- [ ] Check all production .env files: no secrets in git, correct permissions
- [ ] Verify all API endpoints require proper auth
- [ ] Check rate limiting on all login/payment/submission endpoints
- [ ] Verify Stripe webhook signature validation
- [ ] Check CORS configs: only allow expected origins
- [ ] Verify nginx: no open proxies, rate limiting active, SSL A+ rating
- [ ] Check ChainTalk embed: no XSS vectors, iframe sandbox attributes
- [ ] Run `npm audit` on all projects, fix any critical vulnerabilities

---

## Revenue Acceleration (6 hours)

### Revenue Review + Strategy Adjustment (2 hours)
- [ ] Compile revenue metrics for weeks 1-21:
  - Total outreach messages sent
  - Response rate
  - Discovery calls conducted
  - Proposals sent
  - Deals closed (number + total value)
  - Freelance platform revenue
  - POFOV leads generated
  - ChainTalk signups
- [ ] Identify what's working → double down
- [ ] Identify what's not working → drop or adjust
- [ ] Set revenue targets for weeks 22-30

### Testimonial Collection (1 hour)
- [ ] Request testimonials from any customers served so far
- [ ] Request LinkedIn recommendations from satisfied clients
- [ ] Ask: "Can I use your company as a case study on my portfolio?"
- [ ] Add testimonials to amiheines.com landing page and /services

### Referral System (1 hour)
- [ ] Reach out to satisfied customers: "Do you know anyone else who could benefit from tamper-proof records?"
- [ ] Offer referral incentive: 10% off their next engagement for each referral that converts
- [ ] Add to Listmonk: occasional referral request in newsletter

### Case Study Creation (2 hours)
- [ ] Write 1-2 detailed case studies from real customer engagements (if any)
- [ ] Or: write detailed case studies of your own projects (ChainVault, Parking Tickets) framed as client work:
  - Problem → Solution → Architecture → Results → Monitoring
  - Include Grafana screenshots as proof of production quality
- [ ] Publish on amiheines.com/portfolio and as blog posts
- [ ] Format as PDF for use in proposals

---

## Content + Outreach Scaling (8 hours)

### Content Batch Production (4-5 hours)
- [ ] Record 2-3 YouTube videos (batch recording session):
  - Video 1: "How I Built 5 Blockchain Apps in 20 Weeks Using Claude Code" (portfolio tour)
  - Video 2: "Enterprise Monitoring for $0: Grafana + Prometheus on a Single Server" (screen share)
  - Video 3: "I Built a Blockchain Alternative to Disqus — Here's Why" (ChainTalk walkthrough)
- [ ] Edit and publish at least video 1 this week
- [ ] Create blog post versions of each video
- [ ] Schedule: 1 video/week for next 3 weeks (batch gives buffer)

### Outreach at Scale (3 hours)
- [ ] Send 15-20 LinkedIn messages (bigger batch — now have stronger portfolio to reference)
- [ ] Include portfolio links and demo links in messages
- [ ] Post LinkedIn insight referencing video/case study
- [ ] Comment on 15+ prospect posts
- [ ] Running total: 215-280 outreach messages
- [ ] Consider: LinkedIn premium or Sales Navigator for better targeting

---

## Ongoing Operations Checklist

From this week forward, establish a weekly rhythm:

### Weekly Maintenance (2-3 hours/week)
- [ ] Check Grafana dashboards for anomalies
- [ ] Review Alertmanager — any alerts this week?
- [ ] Check Uptime Kuma — any downtime events?
- [ ] Review Matomo analytics across all sites
- [ ] Check Listmonk subscriber growth + email open rates
- [ ] Check POFOV scraper health (if auto-schedule running)
- [ ] Review ChainTalk: new sites registered? Comment volume?
- [ ] Clear Docker logs/old images if disk is growing

### Weekly Growth (10+ hours/week)
- [ ] 10-15 LinkedIn outreach messages
- [ ] 3-5 LinkedIn posts/insights
- [ ] 1 blog post published
- [ ] 1 YouTube video published (from batch)
- [ ] 1 newsletter sent via Listmonk
- [ ] Follow up on pipeline, close deals

---

## End-of-Week 21 Checkpoints — THE BIG PICTURE

### What's Live
- [ ] ✅ amiheines.com — main hub, blog, portfolio, services, newsletter
- [ ] ✅ chainvault.amiheines.com — wire fraud prevention, demo mode
- [ ] ✅ verarta.com — art provenance, public gallery, demo mode
- [ ] ✅ parking.amiheines.com — municipal parking tickets, full flow
- [ ] ✅ pofov.com — 1,000+ page SEO engine, email capture, comparisons
- [ ] ✅ chaintalk.amiheines.com — embeddable blockchain comments, demo site
- [ ] ✅ monitoring.amiheines.com — Grafana dashboards for everything
- [ ] ✅ status.amiheines.com — public uptime status page
- [ ] ✅ lists.amiheines.com — Listmonk email marketing
- [ ] ✅ matomo.amiheines.com — privacy-first analytics

### What's Monitored
- [ ] ✅ Every app has Prometheus metrics + Grafana dashboard
- [ ] ✅ Structured logging → Loki for all apps
- [ ] ✅ Alert rules → email notifications via Alertmanager
- [ ] ✅ Uptime monitoring → public status page

### Revenue Pipeline
- [ ] 215-280 total outreach messages sent over 21 weeks
- [ ] Blog: 19+ posts published
- [ ] YouTube: 3+ videos published (more in pipeline)
- [ ] Listmonk: subscribers growing from amiheines.com + POFOV
- [ ] POFOV: generating organic search traffic + email leads
- [ ] ChainTalk: sites registering, proof of concept for embeddable blockchain
- [ ] Target: $2K+/month recurring from consulting + freelance + managed services

### What Comes Next (Weeks 22+)
- Shift time allocation: 30% maintenance + dev, 70% outreach + content + sales
- Scale content: 2 videos/week now that portfolio is complete
- Pursue managed infrastructure contracts ($2-5K/month recurring)
- ChainTalk Product Hunt launch
- POFOV weekly auto-rescrape + newsletter automation
- Upsell existing customers to higher tiers
- Consider: conference talks, podcast appearances, guest blog posts for link building
