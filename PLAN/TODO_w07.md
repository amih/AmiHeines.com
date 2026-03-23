# Week 7 — Verarta Multi-Device WebAuthn + Finish

**Dates:** 2026-05-04 to 2026-05-10
**Focus:** 70% Verarta completion / 20% outreach / 10% content
**Target hours:** 20

---

## Verarta Expansion (14 hours)

### V8 — Multi-Device WebAuthn Signers (6-8 hours)

This is the biggest single feature. Break it into sub-tasks:

#### Smart Contract Changes (2 hours)
- [ ] Add `devices` table to verarta.core contract:
  - device_id, user account, credential_id_hash, nickname, registered_at, last_used_at, is_active
- [ ] Add `recovery` table:
  - recovery_id, user account, trusted_accounts (vector of names), threshold (e.g., 2), created_at
- [ ] Add actions: `adddevice`, `rmdevice`, `setrecovery`, `execrecovery`
- [ ] Compile and deploy updated contract

#### Backend (2-3 hours)
- [ ] API: `POST /api/auth/devices/register` — register additional WebAuthn device to existing account
- [ ] API: `GET /api/auth/devices` — list user's registered devices (nickname, last used, active)
- [ ] API: `DELETE /api/auth/devices/:id` — revoke a device
- [ ] API: `POST /api/auth/recovery/setup` — configure trusted contacts (2-of-N)
- [ ] API: `POST /api/auth/recovery/initiate` — start recovery process
- [ ] API: `POST /api/auth/recovery/approve` — trusted contact approves recovery
- [ ] Update login flow: try all registered credentials, update last_used_at on success

#### Frontend (2-3 hours)
- [ ] Settings page: "My Devices" section
  - List all registered devices with nickname, last used date
  - "Add Device" button → WebAuthn registration flow → nickname prompt
  - "Revoke" button per device (with confirmation)
- [ ] Settings page: "Account Recovery" section
  - Configure trusted contacts (search by username/account)
  - Set threshold (minimum approvals needed)
  - Show current recovery config
- [ ] Recovery flow: "Lost access?" → enter username → trusted contacts notified → approvals → new device registration
- [ ] Test: register 2 devices, login with each, revoke one, verify can't login with revoked

### V9 — Demo Data Seeder (2 hours)
- [ ] Write seeder script:
  - Create 3-5 demo artist accounts
  - Register 10-15 demo artworks (use sample images, varied sizes)
  - Upload artwork files to chain (chunked)
  - Create provenance records
  - Set some artworks as public, some private
- [ ] Make script idempotent
- [ ] Run on production
- [ ] Verify: gallery shows demo artworks, provenance chains visible

### V10 — Public Demo Mode (3-4 hours)
- [ ] Create demo login: `POST /api/auth/demo`
  - Read-only session for demo user
  - Access to demo artworks, provenance, blockchain explorer
  - All write operations blocked with "Demo mode" message
- [ ] Add "Try Demo" button on Verarta landing page
- [ ] Add "Demo Mode" badge in UI header
- [ ] Restrict: no file uploads, no real WebAuthn registration, no settings changes
- [ ] Auto-expire after 30 minutes
- [ ] Add demo link to amiheines.com/portfolio
- [ ] Test: full exploration flow in demo mode

---

## Outreach (4 hours)

- [ ] Send 10-15 new LinkedIn messages
- [ ] Follow up on pipeline — prioritize warm leads
- [ ] Post 3-5 LinkedIn insights
- [ ] Comment on prospect posts
- [ ] Running total: 75-95 outreach messages
- [ ] **Revenue check:** How many discovery calls? Any closed deals? Pipeline value?
- [ ] If no calls yet: review message templates, try different angles, consider warm intro requests

---

## Content (2 hours)

- [ ] Publish blog post #6 or YouTube video
  - Candidate: "Multi-Device WebAuthn for Blockchain Accounts: A Recovery Strategy" (from V8)
  - Candidate video: first "Build With Me" recording (record while working on V8)
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] Verarta multi-device WebAuthn working (add, list, revoke devices)
- [ ] Account recovery configured and tested (2-of-N trusted contacts)
- [ ] Verarta demo data populated, gallery shows real artworks
- [ ] Verarta demo mode live with "Try Demo" button
- [ ] Verarta demo linked from amiheines.com/portfolio
- [ ] **Both ChainVault and Verarta now fully expanded, monitored, and demo-ready**
- [ ] 75-95 outreach messages total
