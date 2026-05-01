# Week 7 — Cohort LP + payments + Video #6 + OVH bootstrap (over-cap week)

**Dates:** 2026-06-15 to 2026-06-21
**Phase:** 1 — Cohort
**Target hours:** ~28 — **EXPLICITLY OVER 20h CAP** (per W06 note; OVH self-host content track. Returns to ≤20h cap from W09.)
**Burnout watch:** if W07 actuals >30h, defer node 3 (API) to W08 — single-BP-only is enough for the W07 video; API node added in W08 alongside cluster expansion.

---

## Rainmaker (6h)

### Payment flow (Invoice4U) (4h)
**See `PLAN/payment_plans.md` for full checkout flow + offer matrix.**
- [ ] Set up Invoice4U product: lump-sum $5,000 + 3-pay $1,750/mo × 3 ($5,250 total).
- [ ] Test charge both options with own card, refund. Verify receipt + tax handling.
- [ ] Wire success webhooks → Listmonk list `cohort_paid` → onboarding email auto-fires.
- [ ] Wire 3-pay payment_failed webhook → Slack #cohort-ops + retry email.

### Refund / terms / contract (2h)
- [ ] Refund policy: 7-day money-back from Module 1 start (per `payment_plans.md`).
- [ ] Cohort participation agreement / NDA-lite. Save to `PLAN/cohort_terms.md`.

---

## Build (12h — over-cap)

### Cohort tooling decisions (4h)
- [ ] Pick group call platform (Zoom or Meet) — buy seat / verify recording.
- [ ] Pick async channel (private Discord server vs. Slack — Discord likely cheaper, devs-friendly).
- [ ] Provision both (Discord server, Zoom recurring meeting). Test.

### OVH self-host bootstrap — node 1 (BP) + node 3 (API) (8h) — for `GAME_content_calendar.md` W07 dev beats
- [ ] Order 2 × OVH RISE-1 / Advance-class servers (32 GB RAM, NVMe). Verify current pricing first.
- [ ] Provision Ubuntu 24.04 LTS, harden SSH (key-only, fail2ban, ufw).
- [ ] Compile / install Antelope Leap `nodeos`. Genesis the private chain (single-BP genesis JSON).
- [ ] Node 1: BP role, signs blocks. Node 3: API role with `chain_api` + `state_history` plugins enabled.
- [ ] Cloudflare in front of node 3's RPC endpoint (rate limit + DDoS shield).
- [ ] Deploy game contract to the OVH chain. Smoke test from laptop: mint, breed, list, buy.
- [ ] Record OBS screen capture of the full provision → genesis → contract deploy flow for W07 video.
- [ ] **Public IPs only this week.** Tailscale hardening lands W08 (Tailscale learning slot already there).
- [ ] **If over budget:** ship single-node BP + API on the same box; split into 2 nodes in W08.

---

## Content (6h)

### Video #6 — "End-to-End Cohort Sales Page Built in One Day" (6h)
- [ ] Build-in-public timelapse + voiceover of assembling the offer page.
- [ ] Show the Invoice4U integration.
- [ ] CTA: waitlist; mention paid challenge coming in ~3 weeks.

---

## EAD / admin (4h)

- [ ] Auto pipeline.
- [ ] EAD audit on tooling: anything else to cut?

---

## End-of-week checkpoints

- [ ] /cohort page accepts a real $5,000 charge end-to-end (test mode).
- [ ] Discord + Zoom provisioned.
- [ ] Refund policy + agreement drafted.
- [ ] Video #6 live.
- [ ] OVH chain live: 2 nodes up, public RPC behind Cloudflare, game contract deployed and reachable.
- [ ] Provision flow recorded for W07 self-host video.
- [ ] Hours **~28** (over-cap, deliberate).
