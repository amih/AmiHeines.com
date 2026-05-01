# Week 7 — Cohort LP + payments + Video #6 + Build-in-Public Template (sub-growth over-cap)

**Dates:** 2026-06-15 to 2026-06-21
**Phase:** 1 — Cohort
**Target hours:** ~25 — **EXPLICITLY OVER 20h CAP** (changed 2026-05-01: OVH cluster bootstrap deferred to W22+ per the audience-fit + sub-growth-priority decision; freed 8h redirected to (a) the W08 primary lead magnet build, (b) warm-network DMs. Net cap-break is +5h instead of +8h.)
**Burnout watch:** if W07 actuals >28h, drop the warm-network DM continuation to W09 only.

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

## Build (4h)

### Cohort tooling decisions (4h)
- [ ] Pick group call platform (Zoom or Meet) — buy seat / verify recording.
- [ ] Pick async channel (private Discord server vs. Slack — Discord likely cheaper, devs-friendly).
- [ ] Provision both (Discord server, Zoom recurring meeting). Test.

### ~~OVH self-host bootstrap~~ — DEFERRED to W22+ (2026-05-01 decision)
The 4-node OVH cluster build was deferred to W22+ as part of the same audience-fit + sub-growth-priority decision that moved Topics 1–4 out of Phase 1. Per `PLAN §6` cash-burn abort gate, W07–W10 game work runs on either:
- a single $60–100/mo OVH node (if W06 list ≥100 + warm-network green/yellow), OR
- local `nodeos` + Vaulta testnet (if W06 thresholds missed)
Either is sufficient for the W08 indie-hacker recap post + W10 challenge demo (~20 attendees doing breeding tests). The $600+/mo full-cluster spend is now W22+ when it pays for itself via the deferred Operations-at-Scale series.

## Sub-growth (over-cap, 5h) — user-deliberate investment per 2026-05-01 decision

### W08 primary lead-magnet build: 8-Week Build-in-Public Template (3h)
- [ ] Repo skeleton (public GitHub) with: README template, GitHub Project board template, weekly post template (.md), weekly newsletter template (.md), simple sub-counter integration spec.
- [ ] Cover image / OG image for the magnet landing page.
- [ ] Magnet landing page on amiheines.com gated behind email signup.
- [ ] **Why this matters:** this is THE W08 HN-bait magnet. Conversion of W08 HN visitors → subs depends on this magnet's quality. 3h in W07 = polished launch in W08, not last-minute scramble.

### Warm-network DM continuation (2h)
- [ ] Personal messages to 6–8 names from `warm_network.md`. Soft mention that the challenge is coming. Not pitches — warm relationship maintenance.

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
- [ ] Game chain live on either a single OVH node OR local `nodeos` + Vaulta testnet (per W06 abort-gate decision).
- [ ] 8-Week Build-in-Public Template repo + landing page ready for W08 launch.
- [ ] 6–8 warm-network DMs sent.
- [ ] Hours **~25** (5h over-cap; sub-growth investment, not infra).
