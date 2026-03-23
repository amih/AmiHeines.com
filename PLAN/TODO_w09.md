# Week 9 — Parking Tickets: Admin Flow + Ticketing

**Dates:** 2026-05-18 to 2026-05-24
**Focus:** 80% Parking backend features / 20% outreach + content
**Target hours:** 20

---

## Parking Backend — Admin + Ticketing (16 hours)

### P3 — Admin Auth + City Setup (5-6 hours)

#### Authentication (2-3 hours)
- [ ] `POST /api/auth/admin/register` — email + password registration
- [ ] `POST /api/auth/verify-email` — 6-digit verification code
- [ ] `POST /api/auth/admin/login` — login, return JWT
- [ ] `POST /api/auth/logout` — terminate session
- [ ] `GET /api/auth/session` — get current session info
- [ ] Send verification emails via MiaB SMTP
- [ ] Test: full registration → verification → login → session flow

#### City Management (1-2 hours)
- [ ] `POST /api/cities` — create city:
  - Create blockchain account for admin
  - Push `createcity` action to chain
  - Insert into PostgreSQL
- [ ] `PUT /api/cities/:id` — update city settings (chain + DB)
- [ ] `GET /api/cities/:id` — get city details
- [ ] `GET /api/cities/:id/stats` — dashboard statistics query

#### Price Options (1 hour)
- [ ] `GET /api/cities/:id/prices` — list price options
- [ ] `POST /api/cities/:id/prices` — add price option (chain + DB)
- [ ] `PUT /api/prices/:id` — update price option
- [ ] `DELETE /api/prices/:id` — deactivate (chain + DB)

#### Employee Management (1 hour)
- [ ] `GET /api/cities/:id/employees` — list employees
- [ ] `POST /api/cities/:id/employees` — invite employee:
  - Create blockchain account
  - Push `addemployee` action
  - Send invite email with temp credentials
- [ ] `PUT /api/employees/:id` — update employee
- [ ] `DELETE /api/employees/:id` — deactivate (chain + DB)
- [ ] `POST /api/auth/employee/login` — employee login

### P4 — Ticket Issuance (4-5 hours)
- [ ] `POST /api/tickets` — issue a new ticket:
  - Validate: employee auth, city, price option exists
  - Look up vehicle owner from registry (see below)
  - Push `issueticket` action to chain
  - Insert into PostgreSQL (with deadline_at = now + deadline_days)
  - Return ticket ID + details
- [ ] `GET /api/tickets` — list tickets with filters (city, status, plate, date range, employee)
- [ ] `GET /api/tickets/:id` — ticket detail with images
- [ ] `PUT /api/tickets/:id/cancel` — admin cancel (chain + DB)

#### Vehicle Registry Mock (1 hour)
- [ ] `GET /api/vehicles/:plate` — lookup vehicle owner
- [ ] Implement mock mode: return fake owner data based on plate prefix
- [ ] Implement cache: check `vehicle_registry_cache` first (24h TTL)
- [ ] Interface ready for real registry API integration later

### P5 — On-Chain Image Upload (5-6 hours)
- [ ] `POST /api/tickets/:id/images/init` — initialize image upload:
  - Accept full file (multipart, max 10MB)
  - Validate: JPEG/PNG/WebP (magic bytes, not just extension)
  - Save to temp disk, compute SHA256, calculate chunk count
  - Push `addimage` action to chain
  - Insert into ticket_images + create tracking rows
  - Return image_id, total_chunks
- [ ] `POST /api/tickets/:id/images/:imageId/chunk` — upload one chunk:
  - Read 256KB from temp file at correct offset
  - Base64 encode
  - Push `uploadchunk` action to chain
  - Update image_chunk_uploads tracking
  - Return chunk_index, chunks_remaining
- [ ] `POST /api/tickets/:id/images/:imageId/complete` — complete upload:
  - Verify all chunks uploaded
  - Push `completeimg` action to chain
  - Delete temp file
  - Update ticket image_count on chain
- [ ] `GET /api/tickets/:id/images` — list images for a ticket
- [ ] `GET /api/tickets/:id/images/:imageId` — reconstruct and serve image:
  - Query chunks from Hyperion by image_id
  - Reassemble in order by chunk_index
  - Decode base64
  - Serve with correct Content-Type
- [ ] Thumbnail generation: Sharp, 300x300, Redis cached
- [ ] Test: upload JPEG → all chunks on chain → retrieve → matches original

---

## Outreach + Content (4 hours)

### Outreach (3 hours)
- [ ] Send 10-15 new LinkedIn messages
- [ ] Follow up on warm leads
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 95-125 outreach messages
- [ ] Focus on closing pipeline: anyone who had a discovery call — send follow-up proposal

### Content (1 hour)
- [ ] Publish blog post #8
  - Candidate: "Storing Evidence Photos on a Blockchain: Chunked Upload Deep Dive" (from P5)
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] Parking admin flow complete: registration, city setup, prices, employees
- [ ] Ticket issuance working: create, list, filter, detail, cancel
- [ ] On-chain image upload pipeline working end-to-end
- [ ] Vehicle registry mock responding
- [ ] 95-125 outreach messages total
