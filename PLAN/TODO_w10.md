# Week 10 — Parking Tickets: Payments + Expiration + Email

**Dates:** 2026-05-25 to 2026-05-31
**Focus:** 80% Parking backend completion / 20% outreach + content
**Target hours:** 20

---

## Parking Backend Completion (16 hours)

### P6 — Stripe Payment Integration (4-5 hours)

#### Payment Flow (3-4 hours)
- [ ] Install Stripe SDK in parking backend
- [ ] Create `stripe.ts` lib: client initialization, helper functions
- [ ] Generate secure payment tokens (UUID v4 + HMAC) for each ticket
- [ ] `GET /api/public/tickets/:token` — public ticket view (no auth):
  - Validate token
  - Return: ticket details, violation, amount, deadline, images (thumbnails)
  - Don't expose internal IDs or employee info
- [ ] `POST /api/public/tickets/:token/pay` — create Stripe PaymentIntent:
  - Validate ticket is open and not expired
  - Create PaymentIntent with ticket amount + currency
  - Return client_secret for Stripe Elements
- [ ] `POST /api/webhooks/stripe` — handle Stripe webhook:
  - Verify webhook signature
  - On `payment_intent.succeeded`:
    - Push `payticket` action to chain (with Stripe payment ID)
    - Update ticket status to "paid" in PostgreSQL
    - Send payment confirmation email to car owner
    - Log in payment_logs table
  - On `payment_intent.payment_failed`:
    - Log failure, don't change ticket status

#### Testing (1 hour)
- [ ] Test with Stripe test keys: full flow from link → view → pay → confirmed
- [ ] Test edge cases: expired ticket payment attempt, double payment, invalid token
- [ ] Verify: blockchain has `payticket` action, DB has correct status, email sent

### P7 — Deadline Expiration (2 hours)
- [ ] Install node-cron in parking backend
- [ ] Create `cron.ts`:
  - Daily job at 02:00 local time
  - Query: `SELECT * FROM tickets WHERE status = 'open' AND deadline_at < NOW()`
  - For each expired ticket:
    - Push `expireticket` action to chain
    - Update status to "expired" in PostgreSQL
    - Send final notice email to car owner
    - Notify city admin (optional summary email)
- [ ] Add cron initialization to Astro server startup
- [ ] Test: create ticket with past deadline → run cron manually → verify status change + email
- [ ] Log cron runs and results (pino)

### P11 — Email Templates (2-3 hours)
- [ ] Create HTML email templates:
  - **Ticket Issued:** ticket details, violation, amount, deadline, photo thumbnails, payment link button
  - **Payment Confirmation:** receipt with ticket summary, amount paid, transaction reference
  - **Deadline Reminder** (7 days before): reminder with payment link, countdown to deadline
  - **Ticket Expired:** final notice, escalation warning
  - **Admin: Payment Received:** notification with ticket + payment details
  - **Employee Invite:** login credentials + getting started instructions
- [ ] Make templates responsive (mobile email clients)
- [ ] Add email sending to:
  - Ticket issuance flow (P4)
  - Payment success (P6)
  - Expiration cron (P7)
- [ ] Create deadline reminder cron: 7 days before deadline, send reminder for open tickets
- [ ] Test: verify all templates render correctly, links work, images display

### Parking Backend — Wire Everything Together (4-5 hours)
- [ ] End-to-end integration test of full flow:
  1. Admin registers → verifies email → logs in
  2. Admin creates city → adds price options → adds employee
  3. Employee logs in → issues ticket (with location, plate, violation, photo)
  4. Photo uploads to chain (chunked) → progress tracked
  5. Car owner email received with payment link
  6. Car owner clicks link → views ticket + photos → pays via Stripe
  7. Payment confirmed → ticket marked paid on chain + DB → confirmation email
  8. Separate ticket: not paid → deadline passes → cron expires → final notice email
- [ ] Fix any integration bugs discovered
- [ ] Add error handling for edge cases found during testing
- [ ] Verify all blockchain transactions are indexed in Hyperion

---

## Outreach + Content (4 hours)

### Outreach (3 hours)
- [ ] Send 10-15 new LinkedIn messages
- [ ] Nurture pipeline: follow up on proposals, answer questions
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 105-140 outreach messages
- [ ] **Revenue milestone:** Target first $500-$1,500 paid engagement by end of week 10

### Content (1 hour)
- [ ] Publish blog post #9 or YouTube video
  - Candidate: "Stripe + Blockchain: Marking a Parking Ticket Paid On-Chain" (from P6)
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] Parking backend 100% feature-complete:
  - Admin flow, employee flow, ticketing, images, payments, expiration, emails
- [ ] Full end-to-end flow tested and working
- [ ] All blockchain transactions verified in Hyperion
- [ ] 105-140 outreach messages total
- [ ] Revenue pipeline review: deals closed, proposals pending, calls scheduled
