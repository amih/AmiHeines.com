# Week 8 — List growth + Video #7 + 4-node cluster + Tailscale (over-cap week)

**Dates:** 2026-06-22 to 2026-06-28
**Phase:** 1 — Cohort
**Target hours:** ~26 — **EXPLICITLY OVER 20h CAP** (last of the over-cap stretch — W06/W07/W08 ship the OVH self-host content track. Returns to ≤20h cap from W09 — non-negotiable, the W10 challenge launch demands clear-headedness.)
**Burnout watch:** if W08 actuals >28h, defer node 4 (read replica + backup target) to W11. Three nodes is enough for the W08 cost-breakdown video; a 4th adds the off-site backup story which can land later.

---

## Rainmaker (8h)

### Drive list to ≥200 (8h)
- [ ] Pin Video #1 with strong CTA in description + first comment.
- [ ] Refresh older videos' descriptions to include waitlist link.
- [ ] Reach out to 5 niche dev-newsletter authors / podcast hosts: offer to be a guest. (Inbound-only re-frame: offering value, not pitching.)
- [ ] Submit to relevant Web3 dev directories / communities (passive listings, not cold DMs).

---

## Build (9h — over-cap)

### Learn Tailscale + Headscale (3h) — foundational for self-host content track
- [ ] Install Tailscale on laptop + 1 spare box. Tailnet up.
- [ ] Read docs: ACLs, MagicDNS, subnet routes, exit nodes.
- [ ] Stand up Headscale in a Docker container for sovereignty option.
- [ ] Outcome: enough fluency to use Tailnet for OVH BP cluster inter-node + future MinIO mesh. Notes → `PLAN/notes_tailscale.md`.

### OVH cluster expansion: nodes 2 + 4, Tailscale hardening, snapshots, backups (6h) — for `GAME_content_calendar.md` W08 dev beats
- [ ] Order 2 more OVH servers — node 2 (BP secondary 32 GB / 1 TB NVMe), node 4 (read replica + backup target 16 GB / 2 TB NVMe).
- [ ] Tailscale on all 4 nodes. ACL: BPs talk to each other + API on Tailnet only; only node 3 RPC stays publicly reachable through Cloudflare. Public-IP-direct inter-BP traffic disabled.
- [ ] Configure node 2 as failover BP — sync from node 1's snapshot, P2P over Tailnet.
- [ ] Configure node 4 as read replica + state-history snapshot source. Cron: nightly snapshot → tar → rsync to OVH Object Storage bucket (€5–10/mo).
- [ ] Failover drill: kill node 1 `nodeos`, verify node 2 picks up block production within 30s. Restart node 1 as observer. Document the runbook → `PLAN/runbook_ovh_failover.md`.
- [ ] Compile actual €/mo + actuals (server costs, bandwidth, storage) → spreadsheet for W08 lead magnet.
- [ ] **Defers:** "Game side improvements as cohort demo material" — cohort polish moves to W09 if time permits, otherwise students will see W08 build state.
- [ ] **If over budget:** node 4 + off-site backup automation slips to W11 (post-challenge); the W08 video focuses on the 3-node failover drill instead.

---

## Content (5h)

### Video #7 — "From 0 to 200 Email Subscribers Without Posting Daily" (5h)
- [ ] Honest breakdown: what's working, what isn't, the exact numbers.
- [ ] Garnon-relevant lesson: how he can do same when he ships his portfolio piece.
- [ ] CTA: waitlist + tease challenge dates.

---

## EAD / admin (4h)

- [ ] Auto pipeline.
- [ ] Pre-launch admin: draft challenge daily-session topics for W09.

---

## End-of-week checkpoints

- [ ] Email list ≥200 subscribers.
- [ ] Video #7 live.
- [ ] 5 podcast/newsletter outreach replies tracked.
- [ ] OVH 4-node cluster live; Tailnet enforced; failover drill passed and documented.
- [ ] OVH cost spreadsheet ready as W08 lead magnet (Topic 4 lead magnet feed).
- [ ] Tailscale fluency confirmed; primer post outline drafted for W18 finalization.
- [ ] Hours **~26** (over-cap, deliberate — last over-cap week before W09 reset).
