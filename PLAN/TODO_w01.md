# Week 1 — Foundation: Website + Outreach Setup + Monitoring Start

**Dates:** _____ to _____
**Focus:** 70% business foundation / 30% monitoring infra start
**Target hours:** 20

---

## Business Foundation (14 hours)

### amiheines.com Website Launch (8 hours)
- [x] Fork/adapt the Dante Astro theme from privateblockchaindatabase.com
- [x] Create landing page: hero section, value prop, social proof placeholder
- [x] Create /about page: bio, background, philosophy
- [x] Create /services page with all 5 tiers ($500 → $5K → managed infra)
- [x] Create /portfolio page: ChainVault and Verarta case studies with screenshots
- [x] Create /contact page: contact form + Cal.com booking embed
- [x] Create /newsletter page: Listmonk signup form
- [x] Create /resources page: gated lead magnets (placeholder for now)
- [x] Create /blog page: removed 14 placeholder posts, kept 2 original blockchain posts
- [x] Integrate Listmonk API for newsletter signup (list UUID configured)
- [x] Add Matomo tracking to all pages (site ID configured)
- [x] Deploy to server (158.69.27.200): nginx config, certbot SSL
- [x] Set up 301 redirects from privateblockchaindatabase.com → amiheines.com/blog
- [ ] **Verify:** visit every page, test signup flow, confirm Matomo fires, check redirects

### LinkedIn Profile Optimization (2 hours)
- [ ] Rewrite headline: problem you solve, not job title (e.g., "I build tamper-proof infrastructure for companies that can't afford data tampering — Private Blockchain | Wire Fraud Prevention | Audit Trails")
- [ ] Update About section: who you help, what you've built, CTA to book a call
- [ ] Add amiheines.com as website
- [ ] Add ChainVault and Verarta as projects/experience
- [ ] Update banner image (professional, relates to blockchain infra)
- [ ] Connect with 20-30 people in target verticals (don't pitch yet — just connect)

### Lead Magnet — First Draft (2 hours)
- [x] Write "Private Blockchain Infrastructure Checklist" (PDF, 3 pages)
  - What to evaluate before choosing a platform
  - Key questions for your CTO/VP Engineering
  - Red flags in vendor proposals
- [x] Design in simple template (Markdown → PDF via pandoc)
- [x] Upload to /resources page (public/resources/), gated behind Listmonk email capture

### Freelance Platform Profiles (2 hours)
- [ ] Create/update Toptal profile (apply if not yet accepted)
- [ ] Create/update Upwork profile (expert-vetted tier)
- [ ] Create/update Catalant profile
- [ ] Position as: blockchain infrastructure / tamper-proof records specialist
- [ ] Include links to amiheines.com, ChainVault, Verarta as portfolio

---

## Monitoring Stack Start (6 hours)

### M1 — docker-compose.monitoring.yml (3-4 hours)
- [x] Create `/opt/monitoring/` directory structure on server
- [x] Write `docker-compose.monitoring.yml` with:
  - Prometheus (latest)
  - Grafana (latest, provisioned with admin password)
  - Loki (latest)
  - Promtail (latest)
  - cAdvisor (latest)
  - Node Exporter (latest)
  - Alertmanager (latest)
- [x] Configure volume mounts for persistent data
- [x] Configure networking (all on internal Docker network)
- [x] Test: `docker compose up -d`, verify all containers healthy
- Note: remapped ports to avoid conflicts (Grafana→3200, Loki→3101, Node Exporter→9101, cAdvisor→8081)

### M2 — Prometheus scrape configs (1 hour)
- [x] Write `prometheus.yml` with scrape targets:
  - Node Exporter (host metrics)
  - cAdvisor (container metrics)
  - Prometheus self-monitoring
  - Grafana health
- [x] Set scrape intervals (15s for critical, 60s for others)
- [x] Test: Prometheus UI shows all targets as UP

### M3 — Promtail config (1 hour)
- [x] Write `promtail.yml`:
  - Docker container log discovery (auto-discover all containers)
  - nginx access + error logs (/var/log/nginx/)
- [x] Label enrichment: container_name, service, log_level
- [ ] Test: Grafana Explore → Loki → can see container logs (needs nginx proxy for Grafana UI access)

---

## End-of-Week Checkpoints

- [ ] amiheines.com is live with all pages, working forms, Matomo tracking
- [ ] 301 redirects from privateblockchaindatabase.com working
- [ ] LinkedIn profile optimized and 20+ new connections
- [ ] Lead magnet PDF created and gated on /resources
- [ ] Freelance platform profiles submitted
- [ ] Prometheus + Grafana + Loki running on server
- [ ] Can view host metrics and container logs in Grafana
