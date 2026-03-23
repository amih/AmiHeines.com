# Week 11 — Parking Tickets: Frontend — Admin Dashboard

**Dates:** 2026-06-01 to 2026-06-07
**Focus:** 80% Parking frontend / 20% outreach + content
**Target hours:** 20

---

## Parking Frontend — Admin (16 hours)

### Initialize Frontend Project (2 hours)
- [ ] Create `parking/frontend/` Next.js 16 project:
  - App Router, React 19, TypeScript
  - Tailwind CSS 4
  - Zustand 5 (state management)
  - TanStack Query 5 (data fetching)
- [ ] Set up API client module (`lib/api/`) with typed fetch helpers
- [ ] Set up auth store (Zustand): login state, JWT token, user info
- [ ] Create base layout with header, navigation, footer
- [ ] Configure next.config.ts: API proxy to parking backend

### P8 — Admin Frontend (8-10 hours)

#### Auth Pages (2 hours)
- [ ] `/auth/admin/register` — registration form (email, password, confirm password)
- [ ] `/auth/admin/login` — login form
- [ ] Email verification page (enter 6-digit code)
- [ ] Auth redirect logic: unauthenticated → login, authenticated → dashboard
- [ ] Login persistence (JWT in httpOnly cookie or localStorage)

#### City Setup Wizard (2 hours)
- [ ] `/admin/setup` — first-time setup wizard (shown when admin has no city):
  - Step 1: City name, currency, timezone
  - Step 2: Add first price options (violation types + amounts)
  - Step 3: Invite first employee (optional)
  - Step 4: Confirmation + "Go to Dashboard"
- [ ] Wizard state in Zustand, submit all at once
- [ ] Redirect to dashboard after completion

#### Admin Dashboard (2-3 hours)
- [ ] `/admin` — dashboard with stats cards:
  - Total tickets (open / paid / expired / cancelled)
  - Revenue this month / this week / today
  - Tickets issued today
  - Payment conversion rate
  - Upcoming expirations (next 7 days)
- [ ] Recent tickets list (last 10, clickable)
- [ ] Quick stats chart: tickets over time (last 30 days)

#### Ticket Management (2-3 hours)
- [ ] `/admin/tickets` — filterable ticket list:
  - Filters: status, date range, license plate, employee, violation type
  - Sortable columns: date, amount, status
  - Pagination
  - Click row → ticket detail
- [ ] `/admin/tickets/[id]` — ticket detail view:
  - Full ticket info: violation, amount, location (map embed), plate, employee, dates
  - Image gallery (thumbnails, click to expand)
  - Blockchain transaction link
  - Status badge (open/paid/expired/cancelled)
  - Cancel button (admin only, with confirmation modal)
  - Payment info (if paid): Stripe ref, date, amount

#### Employee & Price Management (2 hours)
- [ ] `/admin/employees` — employee list:
  - Table: name, badge, email, status, tickets issued
  - Add employee form (modal: name, email, badge number)
  - Deactivate toggle
- [ ] `/admin/prices` — price options list:
  - Table: label, amount, status
  - Add price option form (modal: label, amount)
  - Deactivate toggle
  - Inline edit for label and amount

### Admin Layout & Navigation (1-2 hours)
- [ ] Admin sidebar navigation:
  - Dashboard, Tickets, Employees, Prices, Settings
  - City name + currency in sidebar header
  - Logout at bottom
- [ ] Responsive: sidebar collapses to hamburger on mobile
- [ ] Breadcrumbs on detail pages
- [ ] Loading states (skeletons) on all data-dependent pages

---

## Outreach + Content (4 hours)

### Outreach (3 hours)
- [ ] Send 10-15 new LinkedIn messages
- [ ] Nurture pipeline: follow up, answer questions
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 115-155 outreach messages
- [ ] Close pending proposals — push for commitment

### Content (1 hour)
- [ ] Publish blog post #10 or YouTube video
  - Candidate video: "Building a Mobile-First Ticket Issuing App with Next.js and Camera API" (preview of P9 coming next week)
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] Parking admin frontend fully functional:
  - Registration, login, city setup wizard
  - Dashboard with real stats
  - Ticket list with filters + detail view
  - Employee and price management
- [ ] All admin pages connected to backend API
- [ ] Responsive layout (sidebar, mobile)
- [ ] 115-155 outreach messages total
