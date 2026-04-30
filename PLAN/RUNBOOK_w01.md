# Week 1 Runbook — Strategy reset (post-pivot)

**Active week:** 2026-05-04 to 2026-05-10
**Reference:** `PLAN_amiheinesConsultant.md`, `TODO_w01.md`, `FUTURE_MAYBE.md`, `business_plans.xlsx` → `Ami — Book Summary`

> The previous Week 1 runbook (lead magnet, monitoring stack ops, freelance profiles, etc.) is preserved in git history. That work stands; nothing in production has been deleted. This file documents how to execute the **post-pivot Week 1**, which is strategy work, not deployment.

---

## Goal

Lock in the new Cochrane-aligned plan: persona doc, perfect client code, magic offer brief, calendar, paused channels.

No code is deployed this week. No video is recorded this week. The output is **documents**.

---

## Deliverable docs (all under `PLAN/`)

| File | Source / Tool |
|---|---|
| `persona_marco.md` | Free write, 30 min. Then Claude review pass. |
| `perfect_client_code.md` | Cochrane Ch.3 6-element template. Section per element. |
| `magic_offer.md` | Cochrane Ch.5 5-step template. |
| `cohort_curriculum.md` | (W06 will fill v1 — leave a stub now.) |
| `energy_audit.md` | 2-column list. Hand-written first; transcribe. |

Each can be a 1-page markdown. Resist over-writing. The point is decisions, not prose.

---

## Persona — anchor questions for `persona_marco.md`

Answer these in 1–2 sentences each:

1. What are Marco's 5 burning questions about Web3 right now?
2. What is the lie he believes about blockchain/Web3? (Cochrane Ch.3)
3. Where does he hang out online? (subreddits, Discords, YouTube channels)
4. What does his portfolio look like today, and what does he wish it looked like?
5. What words does he actually use when complaining? (3rd-grade English, Cochrane)
6. What is he currently spending money on to learn Web3? (bootcamps, courses, books) — this is the price anchor.

---

## Site changes (production)

Two small edits to amiheines.com:

1. **Hero** — replace enterprise CTO targeting with Marco-targeting. Keep technical credibility, drop "tamper-proof records / fraud prevention" language from above the fold.
2. **/services** — replace 3-tier service ladder with a single panel: "Cohort: Ship Your First On-Chain Game in 60 Days — Doors open July 2026. [Join the waitlist]." Form posts to Listmonk list `cohort_waitlist` (create if missing).

Astro pages:
- `src/pages/index.astro` (or wherever hero copy lives)
- `src/pages/services.astro`

Build & deploy as usual (rsync to 158.69.27.200, no infra changes needed).

---

## Listmonk repoint

1. Log in to `lists.amiheines.com` (creds in `reference_credentials.md`).
2. Open transactional templates id 6–10 (welcome sequence days 0/3/7/10/14).
3. Edit subject + body to shift from "wire-fraud / private blockchain" framing to "Web2→Web3 with AI" framing. Keep the cadence and template structure.
4. Day 14 CTA → `/cohort` waitlist link.
5. Test send to `ami@amiheines.com` for each.

---

## Calendar block (Cochrane Dream Week)

Block in personal calendar through end of W21:

| Block | Days/time |
|---|---|
| Recharge | Mon–Fri 7:00–9:00 (gym/walk/breakfast/journaling). Sun off entirely. |
| Relationship | Daily mornings with kids (already happening); Friday = wife date day. |
| Rainmaker — Reflection | Mon 10:00–13:00 thinking + reading. |
| Rainmaker — Record | Tue 10:00–14:00 video record + edit. |
| Rainmaker — Build | Wed 10:00–15:00 cohort/challenge work. Thu 10:00–15:00 game build. |
| Light admin | Fri 10:00–12:00 only. |

Total contact hours ~17–19/week. Hard cap 20.

---

## EAD audit — what stops this week

Stop doing all of these starting Mon 2026-05-04:

- Original LinkedIn posts (auto-clip from YouTube once Video #1 ships in W02).
- Bespoke weekly email (auto-derive from W02 forward).
- Bespoke weekly blog post (same).
- Cold-outreach list-building / DMs.
- Toptal/Upwork bidding.
- POFOV new content / gating work.
- Any work on Parking Tickets project.
- Any service-ladder pricing on /services.

---

## End-of-week verification

Run through `TODO_w01.md` checkpoints. All must be green before opening `TODO_w02.md`.

If anything slipped: do **not** carry to W02. Reflect on why (Mon W02 reflection time), adjust scope.
