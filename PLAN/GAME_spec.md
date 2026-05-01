# Reference Game — Spec

**Created:** 2026-04-30
**Owner:** Ami
**Status:** Draft v1
**Parent doc:** `PLAN_amiheinesConsultant.md` (the cohort that ships this game as its reference build)

This is the on-chain game Ami builds in public, as both the cohort's reference implementation and the primary client-magnet content over W01–W21.

---

## 1. Game concept

**Working name:** TBD (placeholder: "Antelopes")
**Genre:** Modern CryptoKitties — breeding & collecting, eye-candy 2D graphics (5–10× the look of the 2017 original).
**Mode:** single-player + global on-chain marketplace. No PvP combat in v1.
**Win condition:** none — collection/breeding, like the original. Long-tail engagement.
**Why this concept:** chain-native (every kitten + breeding action is meaningful state on-chain), proven appeal, audiences understand it without explanation, demoable in 30 seconds, fits Antelope's TPS + fee-less profile.

## 2. Distribution — web only

**Browser-playable** at `play.amiheines.com` (or chosen subdomain). No iOS, no Android.

**Why no app stores:**
- Apple's NFT/crypto rules in 2026 still penalize on-chain trading — breeding economy + marketplace = high reject risk.
- Google Play allows but ad reach is poor for crypto games.
- Removing the submission/rejection arc frees W09–W10 for actual launch + Show HN.
- Web-first matches the audience (desktop-first crypto-curious adults, web2 devs).

**Future:** mobile PWA wrapper post-W21 if there's demand. No native, no store risk.

## 3. Audience

**Primary (cohort target, "Garnon"):** junior full-stack devs, 25–32, React/Node 2–4 yrs, Web3-curious, wants portfolio piece. Same as `PLAN_amiheinesConsultant.md` §1.

**Secondary (newsletter / content reach):** crypto-curious adults + web2 devs not in scope for the cohort but useful for list/audience growth.

> ⚠ **Tension flagged.** Cochrane's "ONE Magic Offer" rule = pick ONE persona for the cohort. "Crypto-curious adults" is wider than Garnon. Treat them as a free-content audience only — do not soften the cohort positioning. If the wider audience proves more buyer-shaped than Garnon, that is a Phase 2 question, not a Phase 1 pivot.

## 4. Stack

| Layer | Choice | Why |
|---|---|---|
| Chain (primary) | **Antelope, private** (Leap `nodeos`, no native token) | Ami's existing depth; teach what you know; high TPS, fee-less, perfect for game state |
| Smart contract (primary) | **C++** on Antelope | the cohort curriculum |
| Smart contract (secondary, optional) | **Solidity** mirror contract | shown only as compare/contrast lesson — not deployed for production |
| Hosting | 4 × OVH bare-metal (see §6) | self-hosted teaches the full stack; cost-controlled |
| Frontend | React + Antelope chain SDK | what Garnon already knows |
| Wallet | TBD — Anchor / WharfKit | minimum-friction signing for Antelope |
| Asset graphics | procedural sprite sheets driven by on-chain DNA | most chain-native + strongest teaching angle |
| Audio | minimal (royalty-free) | de-prioritized for v1 |

## 5. Smart contract architecture (sketch)

**Tables (RAM-resident):**
- `kittens` — id, owner, dna (uint256), generation, parent_a, parent_b, born_at, cooldown_until, listed_price
- `marketplace` — kitten_id, seller, price, listed_at
- `params` — gen-0 cap, breeding cooldown formula, mint quota

**Actions:**
- `mint` (admin-only) — gen-0 cap (e.g. 1000 gen-0 kittens).
- `breed(a, b)` — owner-of-both, applies cooldown, derives child DNA deterministically (or via commit-reveal RNG).
- `transfer(to, kitten_id)` — standard.
- `list / unlist / buy` — marketplace.
- `feed(kitten_id)` (optional flavor action) — unlocks cosmetic state.

**RAM budget:** ~150 bytes packed per kitten → 1M kittens ≈ 150 MB chain RAM. Cheap on a private chain.

**Solidity mirror (teaching only):** ERC-721 + breeding modifier + simple marketplace. Used side-by-side with the C++ for the lesson "this is what you'd write on Ethereum, here's what it costs you in gas, here's why we picked Antelope."

## 6. Self-hosting topology — 4 × OVH

**Why self-host (vs Vaulta mainnet):**
- Real teaching value — Garnon never sees what's under a managed RPC.
- Material for a future cost-breakdown post (strong HN/Reddit hook — deferred to W22+ as part of "Antelope Operations at Scale" mini-series; see `GAME_content_calendar.md` Content backlog).
- Full control over chain config (no governance / token economics of Vaulta mainnet).
- A teaching chain that resets is a feature: demoable failures (intentional fork, replay) without spending real tokens.

**Topology:**

| Node | Role | RAM | Disk | Notes |
|---|---|---|---|---|
| 1 | BP primary | 32 GB | 1 TB NVMe | signs blocks |
| 2 | BP secondary / failover | 32 GB | 1 TB NVMe | takes over if #1 fails |
| 3 | API + state-history-plugin | 32 GB | 2 TB NVMe | what the frontend talks to; serves history queries |
| 4 | Read replica + backup target | 16 GB | 2 TB NVMe | observer node, snapshot source, off-site backup feeds from here |

**Total cluster:** 112 GB RAM, 6 TB SSD.

**Sizing rationale:**
- `nodeos` mmap-loads chain state and contract RAM into memory; private chain with <1 M actions/day stays comfortably under 16 GB. 32 GB gives headroom for state-history + traffic spikes.
- state-history-plugin grows fastest; 2 TB on the API + replica gives ~12 months of history at conservative volume.
- NVMe (not SATA SSD) is mandatory — block production latency dies on slow disk.

**Approximate cost (verify current OVH pricing at purchase time):**
- 4 × RISE-1 / Advance-class servers ≈ $240–400/month total.
- Bandwidth: included on OVH bare metal.
- Backups: rsync from node 4 → OVH "Public Cloud" object-storage ($5–10/mo).

**Pros:**
- Full control, infinite chain resets for teaching.
- Strong content angle (W08 cost transparency post = HN-bait).
- Cheap at this scale vs managed infra-as-a-service.

**Cons:**
- Ami is on-call for chain liveness.
- Patch / upgrade burden (Leap version bumps).
- DDoS exposure on public RPC — needs Cloudflare (or equivalent) in front of node 3.
- ~$300/mo before any cohort revenue → real cash burn in W01–W10.

**Mitigation (revised 2026-05-01):** the full 4-node cluster is **deferred to W22+** along with Topics 1–4 in `GAME_content_calendar.md` Content backlog. For Phase 1 (W01–W21):
- W01–W06: local `nodeos` dev env on Ami's laptop is sufficient for contract scaffolding + frontend wiring.
- W07–W10: per `PLAN §6` cash-burn abort gate — either single OVH node ($60–100/mo) if W06 list ≥100 + warm-network green/yellow, or local + Vaulta testnet if W06 thresholds missed. Either supports the W08 indie-hacker recap post + W10 challenge demo (~20 attendees doing breeding).
- W11–W21: cohort runs on the same single-node setup. Students don't need 4 BPs to learn Antelope.
- W22+: full 4-node cluster build ships when the deferred Operations-at-Scale series justifies the spend (and when there's revenue to absorb it).

## 7. Build milestones (overlay on PLAN §5 calendar)

See `GAME_content_calendar.md` for the full week-by-week dev + content mapping. Summary:

- **W01–W02:** thesis + repo public + local `nodeos` dev env
- **W03–W04:** contract scaffold → breeding works locally
- **W05–W06:** frontend → marketplace
- **W07–W08:** OVH self-host (2-node, then 4-node) → public testnet
- **W09:** polish + game live at `play.amiheines.com`
- **W10:** paid challenge runs against the live game
- **W11–W17:** cohort uses the same game as reference build, students fork variants

## 8. Open questions (resolve before W03)

- [ ] Game name (placeholder "Antelopes" is weak — needs branding pass)
- [ ] Wallet pick: Anchor vs WharfKit vs custom (UX matters more than completeness)
- [ ] On-chain RNG: simple block-hash mod vs commit-reveal (flag the trade-off in the contract walkthrough video)
- [ ] Marketplace fee: 0% (purist), 2% (revenue path), or burn-only (deflationary teaching)
- [ ] Asset pipeline: hand-drawn vs AI-generated vs procedural-DNA-driven (procedural is most chain-native)
- [ ] Cloudflare or HAProxy in front of node 3 for DDoS / RPC rate-limit
