# Week 8 — Parking Tickets: Smart Contract + Backend Foundation

**Dates:** 2026-05-11 to 2026-05-17
**Focus:** 70% Parking Tickets new build / 20% outreach / 10% content
**Target hours:** 20

---

## Parking Tickets — New Build Start (14 hours)

### P1 — Smart Contract: parking.core (6-8 hours)

#### Contract Code (4-5 hours)
- [ ] Create project structure: `parking/blockchain/contracts/parking.core/`
- [ ] Write `parking.core.hpp` — tables and action declarations:
  - `cities` table (city_id, admin_account, city_name, currency, timezone, deadline_days, created_at, is_active)
  - `priceopts` table (option_id, city_id, label, amount, is_active)
  - `employees` table (employee_id, city_id, account, display_name, badge_number, is_active, added_at)
  - `tickets` table (ticket_id, city_id, employee_id, license_plate, location, option_id, amount, image_count, status, issued_at, deadline_at, paid_at, payment_ref, notes)
  - `tktimages` table (image_id, ticket_id, uploader, filename, mime_type, file_size, file_hash, total_chunks, uploaded_chunks, upload_complete)
  - `tktchunks` table (chunk_id, image_id, uploader, chunk_index, chunk_data, chunk_size)
  - Secondary indices: by_city, by_employee, by_plate, by_status, by_ticket, by_image
- [ ] Write `parking.core.cpp` — action implementations:
  - `createcity`, `updatecity` (admin auth)
  - `addpriceopt`, `rmpriceopt` (admin auth)
  - `addemployee`, `rmemployee` (admin auth)
  - `issueticket` (employee auth, validates city/employee/priceopt)
  - `addimage`, `uploadchunk`, `completeimg` (employee auth, chunked upload)
  - `payticket` (backend service auth)
  - `cancelticket` (admin auth)
  - `expireticket` (backend service auth)
- [ ] Write `CMakeLists.txt`

#### Compile + Deploy (2-3 hours)
- [ ] Compile with Antelope CDT (eosio-cpp)
- [ ] Create `parkingcore` account on Verarta blockchain
- [ ] Deploy WASM + ABI to `parkingcore`
- [ ] Test all actions via cleos:
  - Create a test city
  - Add price options
  - Add an employee
  - Issue a ticket
  - Upload image chunks, complete
  - Pay, cancel, expire tickets
- [ ] Verify via Hyperion: all actions and table deltas indexed

### P2 — Backend Foundation (4-5 hours)
- [ ] Initialize Astro 5 SSR project: `parking/backend/`
- [ ] Install dependencies: @astrojs/node, pg, redis, zod, jsonwebtoken, bcrypt, nodemailer, prom-client
- [ ] Create PostgreSQL database `parking`
- [ ] Write and run migration `001_initial_schema.sql`:
  - admins, employees, cities, sessions, tickets, ticket_images, image_chunk_uploads, payment_logs, vehicle_registry_cache
- [ ] Create core libs:
  - `db.ts` — PostgreSQL connection pool
  - `redis.ts` — Redis client
  - `auth.ts` — JWT + bcrypt password hashing + session management
  - `antelope.ts` — Antelope/Spring chain client (reuse pattern from Verarta)
  - `email.ts` — Nodemailer SMTP via MiaB
- [ ] Create middleware: `auth.ts` — JWT verification, user type extraction (admin/employee)
- [ ] Create Astro config: SSR mode, Node adapter, port 4322
- [ ] Create PM2 ecosystem config
- [ ] Test: backend starts, connects to DB + Redis + chain, health endpoint responds

---

## Outreach (4 hours)

- [ ] Send 10-15 new LinkedIn messages
- [ ] Follow up on pipeline
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 85-110 outreach messages
- [ ] **Revenue milestone check:** Should be approaching first paid engagement by now
- [ ] If calls are happening: refine proposal template based on feedback

---

## Content (2 hours)

- [ ] Publish blog post #7 or YouTube video
  - Candidate: "Writing an Antelope Smart Contract for Parking Tickets — From Scratch" (from P1 work — great "Build With Me" video)
- [ ] Record development session if doing video (screen capture while coding P1)

---

## End-of-Week Checkpoints

- [ ] parking.core smart contract compiled, deployed, and tested on Verarta chain
- [ ] All contract actions verified via cleos and Hyperion
- [ ] Parking backend running: DB, Redis, chain connection, auth, health endpoint
- [ ] 85-110 outreach messages total
- [ ] Revenue pipeline review done
