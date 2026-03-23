# Week 20 — ChainTalk Demo Site + Final Integration + Portfolio Update

**Dates:** 2026-08-03 to 2026-08-09
**Focus:** 40% ChainTalk demo / 40% portfolio + cross-project / 20% outreach + content
**Target hours:** 20

---

## ChainTalk Demo + Polish (8 hours)

### CT15 — Demo Site (3-4 hours)
- [ ] Create demo blog at `demo.chaintalk.amiheines.com`:
  - Simple Astro site with 5 blog posts about blockchain/tech topics
  - Each post has ChainTalk widget embedded
  - Pre-seeded with demo comments showing:
    - Threaded replies (2-3 levels deep)
    - Upvoted/downvoted comments
    - At least 1 moderated (hidden) comment with visible moderation reason
    - Mix of registered and anonymous (if enabled) commenters
  - Header: "This is a demo of ChainTalk — blockchain-backed comments. Try it yourself!"
  - Each comment has visible blockchain receipt link
- [ ] Nginx config + certbot for demo.chaintalk.amiheines.com
- [ ] Link from ChainTalk landing page: "See it in action → demo.chaintalk.amiheines.com"
- [ ] Test: visitors can post real comments on demo site

### ChainTalk Polish (2-3 hours)
- [ ] Review and fix any bugs found during POFOV/amiheines integration
- [ ] Performance: ensure embed.js loads in <100ms, widget renders in <500ms
- [ ] Verify CORS works from all integrated domains
- [ ] Rate limiting on comment posting (5 comments/min per user)
- [ ] Spam protection: basic keyword filter + honeypot field in post form
- [ ] Accessibility: keyboard navigation, ARIA labels, screen reader support

### PF12 — POFOV ChainTalk Review (2 hours)
- [ ] Review ChainTalk integration on POFOV:
  - Test on 5-10 different coin pages
  - Verify loading speed, theme consistency
  - Check mobile rendering
  - Verify page_id uniqueness across all pages
- [ ] Monitor first organic comments on POFOV (if any)
- [ ] Seed additional starter comments/questions on high-traffic coin pages
- [ ] Add "Join the discussion below" CTA text above ChainTalk widget on POFOV pages

---

## Cross-Project Integration + Portfolio (8 hours)

### Portfolio Page Update (3-4 hours)
- [ ] Update amiheines.com/portfolio with all 5 projects:
  - **ChainVault:** Screenshot, description, demo link, Grafana dashboard screenshot
  - **Verarta:** Screenshot, gallery link, demo link, Grafana dashboard screenshot
  - **Parking Tickets:** Screenshot, description, demo link, Grafana dashboard screenshot
  - **POFOV:** Screenshot, link, description of scale (1,000+ pages)
  - **ChainTalk:** Screenshot, demo link, embed code example, landing page link
- [ ] Each project shows: tech stack badges, "View Grafana Dashboard" link (if public), "Try Demo" button
- [ ] Add "Monitoring" section: screenshot of Grafana overview + link to status.amiheines.com
- [ ] Add "Open-Source Stack" section: cost savings table from plan section 11.8
- [ ] SEO: update meta tags, Open Graph images for portfolio page

### Status Page Review (1 hour)
- [ ] Verify Uptime Kuma monitors all 5 apps + infrastructure:
  - amiheines.com
  - chainvault.amiheines.com
  - verarta.com
  - parking.amiheines.com
  - pofov.com
  - chaintalk.amiheines.com
  - monitoring.amiheines.com
  - lists.amiheines.com
  - matomo.amiheines.com
- [ ] Verify status.amiheines.com is publicly accessible and shows all monitors
- [ ] Check uptime percentages — fix any intermittent issues

### Cross-Promotion Audit (2 hours)
- [ ] Verify all cross-links work:
  - amiheines.com → all project demos
  - POFOV → amiheines.com consulting CTAs
  - ChainTalk → amiheines.com footer link
  - All projects → status.amiheines.com
  - Blog posts → relevant project links
- [ ] Verify all Matomo tracking fires on all sites
- [ ] Review Listmonk subscriber growth: amiheines.com list + POFOV list
- [ ] Check email sequence delivery rates and open rates
- [ ] Fix any broken links or missing tracking

### Services Page Update (1 hour)
- [ ] Update amiheines.com/services with ChainTalk self-hosted tier:
  - Add: "$2,500 — ChainTalk Self-Hosted Setup" (deploy blockchain comment system on your infrastructure)
  - Add: "$99/month — ChainTalk Enterprise" managed tier
- [ ] Add ChainTalk demo to discovery call script as a live demo option
- [ ] Update proposal template with ChainTalk as a portfolio reference

---

## Outreach + Content (4 hours)

### Outreach (3 hours)
- [ ] Send 10 new LinkedIn messages
- [ ] Pipeline management
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 200-260 outreach messages
- [ ] **Share portfolio update on LinkedIn:** "I just finished building 5 blockchain apps — all open source, all monitored, all on one server"

### Content (1 hour)
- [ ] Publish blog post #19 — milestone post:
  - "How I Built 5 Blockchain Apps in 20 Weeks Using Claude Code"
  - Or: "My Full Stack: 5 Blockchain Apps, Open-Source Monitoring, One Server, $0 in Licensing"
- [ ] Share on LinkedIn, cross-post key points to POFOV blog

---

## End-of-Week Checkpoints

- [ ] ChainTalk demo site live with seeded conversations
- [ ] All 5 projects polished and demo-ready
- [ ] amiheines.com/portfolio fully updated with all projects
- [ ] All cross-links verified
- [ ] status.amiheines.com monitoring all services
- [ ] Matomo tracking on all sites
- [ ] 200-260 outreach messages total
- [ ] **Milestone blog post published**
