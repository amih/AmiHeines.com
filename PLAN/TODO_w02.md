# Week 2 — Content Engine Setup + Start Building Publicly

**Dates:** 2026-03-30 to 2026-04-05
**Phase:** 1 — The Foundation
**Focus:** 70% build (content infrastructure + first recorded session) / 30% content
**Target hours:** 20

---

## Build Work (14 hours)

### YouTube + Recording Infrastructure (4 hours)
- [x] Create YouTube channel (`@amiheines`), set name, description, branding, channel art
- [x] Install OBS Studio, configure screen recording: 1080p, 60fps, mic input, facecam overlay
- [x] Create thumbnail template in GIMP/Canva (consistent style: dark background, bold text, tech icon)
- [ ] Record 30-second test clip — verify audio quality, screen readability, facecam lighting
- [x] Define recording workflow: OBS → `~/Videos/raw/` → edit → `~/Videos/final/`
- [x] Install kdenlive, do a test edit

### Website Email Capture Optimization (3 hours)
- [x] Add subtle Subscribe component to bottom of every page: /about, /contact, /services, /portfolio, /blog posts (was already on most pages; added to contact, resources, and [...id] catch-all)
- [x] Add inline CTA to blog post template — lead magnet offer below every post (Subscribe component already present at bottom of blog/[id].astro)
- [ ] Configure Matomo goals: newsletter signups, resource downloads, contact form submissions, services page views

### Listmonk Welcome Sequence (3 hours)
- [x] Create branded HTML email template in Listmonk (responsive, matches amiheines.com design) — template id:5
- [x] Build 5-email welcome sequence (transactional templates id:6-10):
  1. Day 0: Welcome + deliver lead magnet PDF + "Here's what I'm building right now"
  2. Day 3: Ami's story + why private blockchain matters
  3. Day 7: Case study deep dive — ChainVault wire fraud prevention
  4. Day 10: "4 misconceptions about blockchain in enterprise"
  5. Day 14: "How I can help" + book a discovery call CTA
- [x] Configure automation: cron job at /opt/amiheines/welcome-sequence.sh runs daily 9:00 UTC, sends based on subscriber join date
- [x] Test end-to-end: transactional send to ami@amiheines.com confirmed working

### Grafana Dashboard Polish — FIRST RECORDED SESSION (3 hours)
- [ ] **Record entire session with OBS** — this becomes Video 1 footage
- [ ] Complete Server Overview and Docker Containers dashboards
- [ ] Provision dashboards as code (JSON files)
- [ ] Take screenshots for portfolio page and blog post

---

## Content Work (6 hours)

### Video 1: "Enterprise Monitoring for $0: Grafana + Prometheus on One Server"
- [ ] Edit monitoring dashboard recording (target: 12-15 minutes)
- [ ] Create YouTube thumbnail from template
- [ ] Upload to YouTube with SEO title, description (links to amiheines.com, lead magnet, subscribe), tags
- [ ] End video with CTA: "Download my Private Blockchain Infrastructure Checklist — link in description"

### Blog Post 1
- [ ] Write blog post derived from Video 1 script, publish to amiheines.com/blog

### LinkedIn
- [ ] Share Video 1 with 2-paragraph insight post
- [ ] Post 3 LinkedIn insights during the week (5 min each)

---

## End-of-Week Checkpoints

- [ ] YouTube channel live with 1 published video
- [ ] OBS recording workflow tested and working
- [x] Subtle per-page subscribe CTAs live on amiheines.com (no popup)
- [x] Listmonk welcome sequence configured, tested, auto-triggering
- [ ] Matomo goals configured
- [ ] Blog post 1 published
- [ ] Video 1 published
