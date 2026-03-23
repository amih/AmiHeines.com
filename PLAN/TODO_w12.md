# Week 12 — Parking Tickets: Employee Mobile UI + Public Payment + Deploy

**Dates:** 2026-06-08 to 2026-06-14
**Focus:** 80% Parking frontend completion + deployment / 20% outreach + content
**Target hours:** 20

---

## Parking Frontend — Employee + Public + Deploy (16 hours)

### P9 — Employee Mobile Frontend (6-8 hours)

#### Employee Auth (1 hour)
- [ ] `/auth/employee/login` — employee login form
- [ ] Employee session management (same JWT pattern, different user_type)
- [ ] First login: password change prompt

#### New Ticket Form — Mobile-First (3-4 hours)
- [ ] `/employee/ticket/new` — the core employee workflow:
  - **Camera:** `navigator.mediaDevices.getUserMedia()` integration
    - Take photo button → opens camera
    - Preview captured image, retake option
    - Support multiple photos per ticket
  - **GPS:** `navigator.geolocation.getCurrentPosition()`
    - Auto-capture lat/lng on form open
    - Reverse geocode to human-readable address (free API: Nominatim)
    - Show location on small map (Leaflet)
    - Manual address override option
  - **License plate input:** large text field, uppercase auto-format
  - **Violation type:** radio buttons from city's price options (amount shown per option)
  - **Notes:** optional textarea
  - **Submit button:** prominent, shows upload progress
- [ ] Upload progress UI:
  - Overall progress bar
  - Per-image chunk progress (X of Y chunks uploaded)
  - "Uploading to blockchain..." status message
  - Success confirmation with ticket number

#### Employee Ticket List (1-2 hours)
- [ ] `/employee` — home page with quick actions: "Issue Ticket" button (prominent)
- [ ] `/employee/tickets` — my issued tickets list (today / this week / all)
- [ ] `/employee/tickets/[id]` — ticket detail (same as admin but employee context)

#### Employee Layout (1 hour)
- [ ] Mobile-first layout: bottom navigation bar (Home, New Ticket, My Tickets)
- [ ] Header: employee name, badge number, city name
- [ ] Offline handling: show clear message if no network (tickets require connectivity)

### P10 — Public Payment Page (3-4 hours)
- [ ] `/pay/[token]` — public-facing payment page (no auth required):
  - Ticket details: violation type, amount, location + map, date, deadline countdown
  - Photo gallery: ticket evidence images (thumbnails from chain)
  - Blockchain verification link: "View on blockchain" → Verarta explorer
  - **Stripe Elements** payment form:
    - Card number, expiry, CVC
    - Pay button with amount
    - Loading state during payment processing
  - Success page: "Payment received" + receipt summary + blockchain transaction link
  - Failure page: "Payment failed" + retry button
- [ ] Already-paid state: "This ticket has been paid" with receipt
- [ ] Expired state: "This ticket has expired" with info
- [ ] Mobile responsive (car owners will open this on their phone from email)

### P15 — Demo Data Seeder (2-3 hours)
- [ ] Write seeder script:
  - Create demo city ("Demo City", USD, America/New_York, 90 days)
  - Create 3 price options (No Parking Zone $75, Expired Meter $50, Fire Hydrant $150)
  - Create 2 demo employees (with badge numbers)
  - Create 15-20 demo tickets:
    - 5 open (various violations, recent dates)
    - 5 paid (with mock payment refs, paid dates)
    - 3 expired (past deadline)
    - 2 cancelled
  - Upload 1-2 demo images per ticket (small JPEG test files, on-chain)
- [ ] Make idempotent
- [ ] Run on production

### P16 — Deployment (2-3 hours)
- [ ] Create nginx config for parking.amiheines.com:
  - Frontend (Next.js): proxy to port 3001
  - Backend API: proxy to port 4322 at /api/
  - Stripe webhook: proxy to port 4322 at /api/webhooks/stripe
  - Rate limiting on auth + API endpoints
  - SSL via certbot
- [ ] Create PM2 ecosystem config for parking-backend
- [ ] Create deploy script: build → rsync → restart services
- [ ] Production .env file from template
- [ ] Deploy to server
- [ ] DNS: A record for parking.amiheines.com
- [ ] Test: access parking.amiheines.com, full flow works

---

## Outreach + Content (4 hours)

### Outreach (3 hours)
- [ ] Send 10-15 new LinkedIn messages
- [ ] Nurture pipeline, close deals
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 125-170 outreach messages
- [ ] **Revenue check:** Should have $500-$2,000 revenue by now or strong pipeline

### Content (1 hour)
- [ ] Publish blog post #11 or YouTube video
  - Candidate: "Building a Mobile-First Ticket Issuing App with Next.js and Camera API"
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] Parking employee mobile UI complete: camera, GPS, ticket form, upload progress
- [ ] Public payment page working: view ticket → pay with Stripe → confirmation
- [ ] Demo data populated: city, employees, 20 tickets with images
- [ ] Parking system deployed to parking.amiheines.com
- [ ] Full end-to-end: admin setup → employee issues ticket → owner pays → all on chain
- [ ] 125-170 outreach messages total
