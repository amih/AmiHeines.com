# Reference Game — Content Calendar (W01–W12)

**Created:** 2026-04-30
**Parent docs:** `PLAN_amiheinesConsultant.md` (W01–W21 calendar), `GAME_spec.md` (game design)
**Purpose:** map build-in-public content beats onto the existing W01–W12 schedule. Goal = grow newsletter from 0 → ~600 subs by W12 to feed the W10 paid challenge.

---

## Cadence (per week, ≤20-hour cap)

| Channel | Output | Source |
|---|---|---|
| YouTube long-form | 1 × 30–45 min (Tue) | original record, screen + voice |
| LinkedIn | 3 posts | native value; first-comment link only |
| Blog (amiheines.com) | 1 post | auto-derived from video transcript |
| Newsletter (Listmonk) | 1 broadcast (Sun) | 3 takeaways + video link + post link |
| Shorts | 0 | dropped 2026-04-30 |

**LinkedIn rules:**
- No external links in post body (algorithm penalty: 3–5× reach cut).
- Full insight (~1000–1500 chars) lives in the post itself — give it away.
- "Full version: amiheines.com/..." goes in the **first comment** OR not at all (some posts: "DM 'KITTEN' for the deep dive" → drives profile visits).
- Post mix per week: one text-only hot take, one with screenshot/GIF, one carousel.
- Pin amiheines.com in LinkedIn "Featured" section + headline.
- One LI post per ~3 weeks asks for direct DM/email reply on a real open question (engine pick, fee model, etc.) — turns LI into a recruiter for the email channel.

---

## Newsletter as a 2-way channel

The newsletter is not a broadcast — it's an invitation to reply. **Ami reads every email.** This is the list-growth lever (promising direct access from a known builder converts), the idea pipeline (subscribers shape the build), and the moat (HN/Twitter audiences don't get this).

**Recurring CTA — append to every newsletter footer + blog post footer + video end-card:**

> Hit reply — I read every email and answer personally **while the list is small**. Tell me what you'd build, what you'd cut, which engine I should pick. The replies shape next week's video.

**Welcome email (Listmonk W01 sequence) opening line:**

> Welcome. Two things up front: (1) every email I send is from me, not a tool. (2) reply to any of them — while the list is small (under ~1,000 subs) I answer every reply personally. After that, I'll still read everything, but answers will move into a public Q&A column in the next issue. So early subscribers get the most direct line — that's the trade. I want your opinions on game dev directions, graphics/modeling engines, contract design — replies shape what I build next.

### Phase transitions (set expectations now, honor them later)

| List size | Reply mode | Comms |
|---|---|---|
| **0 – 1,000** (current phase) | Personal reply within 48h to every email | "You're early — I'm answering personally" in welcome + footer |
| **1,000 – 5,000** | Two-line personal reply; meaty threads quoted (with permission) into a public Q&A column in the next issue | Send a "the list crossed 1,000 — here's what changes" broadcast. The transition itself is content. |
| **5,000+** | Public Q&A column primary; personal replies triaged to high-signal | Same — announce, don't drift silently |

This is honest *and* a soft urgency lever — "subscribe now, get the direct line while it lasts" without being scammy because we'll genuinely deliver until we can't.

**Per-week reply prompt** (one specific question closing each broadcast):

| W | Reply prompt |
|---|---|
| W01 | What's the question you'd ask a chain you've never used? |
| W02 | What stack would you have picked? |
| W03 | What's missing from this contract spec? |
| W04 | How would you handle on-chain RNG — block-hash mod, commit-reveal, or VRF? |
| W05 | Which Antelope wallet have you actually used? |
| W06 | 0% fee, 2%, or burn-only — which marketplace fee makes the strongest demo? |
| W07 | Which 2D / sprite engine would you pick: Phaser, PixiJS, Cocos, plain Canvas? |
| W08 | Anything you'd run differently in this 4-node setup? |
| W09 | What's the most useful thing the challenge could deliver in 5 days? |
| W10 | Day-by-day — what should I cover tomorrow? |
| W11 | What did the challenge get wrong? |
| W12 | Which lesson from these 12 weeks should I record as its own deep-dive? |

**Inbox handling:**
- Listmonk `Reply-To` → `ami.heines@gmail.com`.
- Respond within 48h, even if 2 lines. The reply *is* the relationship.
- Gmail label: `nl-reply`. Star anything that becomes content; ask permission before quoting publicly.
- If a thread gets meaty, offer a 15-min call — no upsell, just relationship-building. Track those people; they're the warmest cohort/challenge prospects.

---

## Per-week beat sheet

Aligned to `PLAN_amiheinesConsultant.md` §5.

### W01 (May 04–10) — Reset & thesis
- **Dev:** local `nodeos` running on Ami's machine; hello-world contract compiled.
- **YT:** *"Why I'm Building a CryptoKitties Clone on Antelope in 2026"* (the thesis).
- **Blog:** transcript-derived thesis post.
- **LI:** ① the thesis (no link), ② "1 video, 1 game, 21 weeks — public", ③ stack-pick chart.
- **Newsletter:** welcome + roadmap + "follow at github.com/.../antelopes".
- **Shareable hook:** thesis → r/eos, r/ethdev (compare/contrast bait).

### W02 (May 11–17) — Channel refresh
- **Dev:** repo public, GitHub Project board live, README + roadmap committed.
- **YT:** *"From Zero to Antelope: A Web2 Dev's First On-Chain Hour"*.
- **Blog:** auto-derived setup walkthrough.
- **LI:** ① "the public board" screenshot, ② "stack decisions are content", ③ first-bug story.
- **Newsletter:** W02 digest.

### W03 (May 18–24) — Game spec + contract scaffold
- **Dev:** `kittens` table + `mint` action compile + tested locally with cleos.
- **YT:** *"I Designed an On-Chain Game Spec in 90 Minutes With Claude Code"*.
- **Blog:** the spec, annotated.
- **LI:** ① "60 lines of C++ = whole game state", ② code screenshot, ③ "RAM table math".
- **Newsletter:** the spec doc.
- **Shareable hook:** annotated spec → r/cpp, r/eos.

### W04 (May 25–31) — Breeding works on testnet
- **Dev:** `breed` action live, deterministic DNA derivation, cooldown enforced.
- **YT:** *"I Shipped a Breeding Smart Contract in 4 Hours with Claude Code"* (matches PLAN §2 example title).
- **Blog:** breeding action walkthrough.
- **LI:** ① "first-ever breeding tx" screenshot, ② "Solidity equivalent — would cost $X in gas", ③ "what I cut".
- **Newsletter:** mid-month retro.
- **🎁 Lead magnet drop:** Antelope C++ contract starter template (.zip + README), gated on subscribe → **first sub spike**.

### W05 (Jun 01–07) — Frontend wired
- **Dev:** React app shows owned kittens, calls `breed`, signed via WharfKit/Anchor.
- **YT:** *"Connecting React to an Antelope Contract: 3 SDKs Compared"*.
- **Blog:** SDK comparison + verdict.
- **LI:** ① "the SDK that didn't suck", ② first-kitten screenshot, ③ "wallet UX is broken — here's what I tried".
- **Newsletter:** the SDK comparison.

### W06 (Jun 08–14) — Marketplace + Magic Offer page
- **Dev:** `list`/`buy` actions, marketplace UI, first end-to-end "kitten changes hands" demo.
- **YT:** *"Building a 0% Fee On-Chain Marketplace in an Afternoon"*.
- **Blog:** marketplace contract + UX trade-offs.
- **LI:** ① "the cohort offer is live" (link to `/cohort` LP, in first comment), ② demo GIF of marketplace, ③ "why I'm not charging marketplace fees".
- **Newsletter:** cohort announcement + early-bird discount.
- **Shareable hook:** demo GIF → Twitter/X, Show HN warm-up.

### W07 (Jun 15–21) — OVH self-host begins
- **Dev:** node 1 (BP) + node 3 (API) provisioned on OVH, public RPC live, Cloudflare front.
- **YT:** *"Self-Hosting an Antelope Block Producer on OVH (Live)"*.
- **Blog:** the OVH provisioning walkthrough.
- **LI:** ① "€60/mo for a chain node — here's the math", ② screenshot of `nodeos` running, ③ "what could go wrong (and did)".
- **Newsletter:** "the chain is now public — try it".
- **🎁 Lead magnet drop:** OVH self-hosting checklist (PDF).

### W08 (Jun 22–28) — Full 4-node cluster + list growth push (Garnon-shaped HN shot)
- **Dev:** nodes 2 + 4 added, failover tested, snapshots automated, off-site backups working. (Infra ships, but it's NOT the public framing this week.)
- **YT:** *"8 Weeks Building a Web3 Game in Public — Numbers, Mistakes, What I'd Do Again"* (Garnon-aligned indie-hacker recap; pulls in junior devs who want to ship their own portfolio piece).
- **Blog:** the indie-hacker recap post — **THE HN post; schedule for Tuesday US morning**. Body: weekly subscriber count, hours spent (build vs marketing vs sales), why Antelope, code snippets from the contract, the OVH cost breakdown as a *closing aside* ("if you're curious about infra, here's the spreadsheet — but you don't need this until later"). Frames the OVH content for the right audience and avoids the senior-infra HN spike that hurts cohort conversion.
- **LI:** ① "8-week numbers carousel" (sub count, hours, $0 spent so far), ② "5 things I'd build differently if I started over" (Garnon hot-take), ③ "the contract that runs the whole game — 60 lines of C++".
- **Newsletter:** **primary lead magnet** = *"8-Week Build-in-Public Template (.zip — repo skeleton + GitHub Project board + weekly post template)"* → second sub spike, Garnon-shaped. **Secondary magnet** = the OVH cost spreadsheet (still there for the infra-curious tail; not the headline).
- **Shareable hook:** *"Show HN: 8 weeks building a Web3 game in public — full numbers, no hype"*. (The audience landing on this is junior devs + indie hackers, not SREs. That converts to challenge tickets at 5–10×.)
- **Note:** the OVH 4-node cluster + cost breakdown content is preserved — moves to W22+ as part of the "Antelope Operations at Scale" mini-series. See "Content backlog" below.

### W09 (Jun 29–Jul 05) — Game polish + challenge announce
- **Dev:** game live at `play.amiheines.com`, gen-0 minted, breeding open.
- **YT:** *"5-Day On-Chain Game Challenge — What You'll Build"*.
- **Blog:** challenge LP + curriculum reveal.
- **LI:** ① "challenge is live, $97/$297", ② "what 5 days will look like", ③ first attendees screenshot.
- **Newsletter:** challenge ticket pitch (heavy CTA week).

### W10 (Jul 06–12) — Paid 5-day challenge
- **Dev:** support attendees, fix anything that breaks under traffic.
- **YT:** delayed to W11 (challenge is the work this week).
- **Daily LI:** challenge BTS, attendee wins, tonight's recording link.
- **Newsletter:** mid-challenge update (Wed) + post-challenge offer pitch (Sat).
- **Shareable hook:** Friday recap → *"Show HN: I ran a paid 5-day on-chain game cohort with X attendees"*.

### W11 (Jul 13–19) — Cohort onboarding
- **Dev:** prep cohort materials, freeze game v1.
- **YT:** *"Lessons from Running a $97 Paid Challenge — All Numbers"*.
- **Blog:** challenge retro w/ full numbers (HN-bait if it went well; vulnerable retro if it didn't — both formats work).
- **LI:** ① "we sold X cohort seats", ② "what worked / what flopped", ③ thank-you to attendees.
- **Newsletter:** challenge retro.

### W12 (Jul 20–26) — Cohort live
- **Dev:** cohort wk1 sessions, students forking the game.
- **YT:** *"Cohort Day 1 — 8 Devs Forking the Same Game"* (BTS).
- **Blog:** cohort kickoff retro.
- **LI:** ① "cohort is live", ② student screenshot (with permission), ③ "this is what 'shipped on-chain in 60 days' actually looks like".
- **Newsletter:** quarterly retro — full 12-week numbers, no spin.
- **Shareable hook:** quarterly retro → HN.

---

## Launch playbook (W08–W11) — applies LCC patterns

Detailed playbook lives in `LAUNCH_playbook.md`. This section is the W10-challenge-specific schedule.

### W08 Sun (Jun 28) — list-only price + cliffhanger
- Broadcast announces W10 challenge dates + **list-only price**: subscribers get $20 off both tiers (final price $77 GA / $277 VIP, public $97 / $297) for the first 48h after the cart opens.
- Cliffhanger close: *"Next Monday I'll send the first of 3 pre-launch emails — Pain / Dream / Reason. Day-7 email is pure-value, no pitch. Then Wed. Then Fri. Cart opens Sun night."*
- Reply prompt: *"Anything you want me to address in the pre-launch sequence — drop it now."*

### W09 (Jun 29 – Jul 5) — Pain / Dream / Reason 3-email sequence
Mapped to Brandon's 7/5/1/0 cadence with W10 launch on Mon Jul 6.

| Day | Date | Type | Subject (draft) | Body angle |
|---|---|---|---|---|
| **Day-7** | Mon Jun 29 | **Pure value, no pitch** | *"You wanted to ship on-chain in 2025. Here's why you didn't."* | The 3 specific blockers Garnon hits (chain choice paralysis, gas anxiety, wallet UX). Useful even if reader never buys. |
| **Day-5** | Wed Jul 1 | **Dream + autobiographical** | *"The week I went from $0 chain experience to a deployed contract"* | Story-driven. Ami's own first Antelope deploy. End: "What if you had a structured 5 days to do this?" |
| **Day-3** | Fri Jul 3 | **Reason + price reveal** | *"Why I'm running this challenge — and what your subscriber discount looks like"* | Reason story (cohort funding the game OSS, etc.). Reveal $77/$277 list-only price. Cart opens Sun night IST. Cliffhanger: "Sunday night you'll get the link first." |
| **Day-1** | Sun Jul 5 | **Tomorrow / reply CTA** | *"Cart opens tonight 22:00 IST — what you get + reply with questions"* | Exact time, exact deliverables, reply for any pre-purchase Qs. List-only discount expires Wed 8am IST (TZ-aware extension for US/EU). |
| **Day-0** | Mon Jul 6 | **Available now** | *"It's live — 20 seats, list-only $77 link inside"* | Short, link, scarcity. 24h list-only window. |

### W10 (Jul 6–12) — daily emails during the live challenge

Pre-write all 6 in W08 — no improvisation under load.

| Day | Date | Email |
|---|---|---|
| Mon | Jul 6 | Day-0 launch (above) |
| Tue | Jul 7 | "Day 1 went down — here's tonight's session link + 14 of 20 seats sold" (live attendee count, transparent) |
| Wed | Jul 8 | Mid-challenge highlight + **gimmick**: *"Ticket #20 gets a free 30-min 1:1 chain-architecture review with me after the challenge."* |
| Thu | Jul 9 | "What attendees built tonight" + soft mention of $5k cohort starting W12 |
| Fri | Jul 10 | Last call — list-only price closes tonight; public price applies from tomorrow if any seats remain |
| Sat | Jul 11 | Post-challenge cohort offer pitch (per existing PLAN §3) — pre-written W08 |

### W11 (Jul 13–19) — vulnerability retro, drafted W08

The retro email gets a first draft in W08 with template blanks. Ship in W11 even if everything went well — the *"here's what almost broke"* angle outperforms the victory lap (Amy's $100k bungled-launch email is the #1 example).

Skeleton (fill in W11):
> *"What I expected: ___ attendees, ___ cohort sales. What happened: ___. The thing that almost killed it: ___. What I'd do differently next time: ___. The next cohort starts ___ — here's the link if you want in."*

### Anti-letdown rule

W11 broadcast + W11 LinkedIn posts + W12 video script all drafted by Fri W08. No "ship W10, then sit and watch the inbox." The momentum kills the slump.

---

## Sub-count targets

| Milestone | Date | Subs |
|---|---|---|
| W04 (lead magnet drop) | May 31 | 50 |
| W08 (OVH cost post) | Jun 28 | 200 |
| W12 (quarterly retro) | Jul 26 | 600 |

These are aggressive vs the `business_plans.xlsx → Funnel` base case (Cochrane mid-funnel rates). The accelerator here is **shareable infra/contract content** — the W04 contract template post and the W08 cost-breakdown post are designed as HN front-page candidates. One HN front-page ≈ ~3000 sessions ≈ ~30–60 subs by itself.

## Lead magnets

| Week | Magnet | Audience |
|---|---|---|
| W04 | Antelope C++ contract starter template (.zip + README) | Garnon |
| W07 | OVH self-hosting checklist (PDF) | infra-curious devs (secondary) |
| W08 | **PRIMARY:** 8-Week Build-in-Public Template (.zip — repo skeleton + GitHub Project board + weekly post template) | **Garnon** |
| W08 | SECONDARY: OVH cost spreadsheet (.xlsx) — for the infra-curious tail only | infra-curious devs (secondary) |
| W09 | Challenge curriculum preview | challenge-buyer adjacent |
| W12 | 90-day retro (PDF, gated) | newsletter spike |

## What we are NOT doing in W01–W12

- No daily Shorts (dropped 2026-04-30).
- No app-store submission arc — web only (see `GAME_spec.md` §2).
- No paid LinkedIn / Meta ads (unless W08 OVH post underperforms — re-evaluate W09).
- No external-link-in-body LinkedIn posts.
- No newsletter sponsorship swaps before W08 (need ≥200 subs first).
- No multi-topic content drift (gambling, meta-reporting only as it serves the build-in-public spine).

---

## Content backlog (post-W21 / Phase 2 / secondary audience)

> ⚠ **Audience note (locked 2026-05-01).** All four topics below target the **secondary infra-curious audience** — *not* Garnon (the cohort buyer). They are deliberately deferred to **W22+** so the W14–W21 video slots stay focused on Cohort #1 delivery + Cohort #2 enrollment for the right audience. Together Topics 2 + 3 + 4 form an "Antelope Operations at Scale" mini-series that can be repackaged as a standalone paid mini-course or a Cohort #2 bonus module — it is **not** Phase 1 funnel content.

Slot all four post-W21 in the Phase 2 calendar (TBD; depends on Phase 2 GO/NO-GO at W21).

### Topic 1 — Glacier-style cold storage, adapted (non-Bitcoin + tunable paranoia)

**Working title:** *"You Don't Need Glacier-Grade Paranoia for a $10k Wallet — Here's the Tier System"*

**Angle:** Glacier Protocol (glacierprotocol.org) is the gold-standard open-source cold-storage spec for Bitcoin: air-gapped laptops, geographically distributed multi-sig quorum, tamper-evident bags. It assumes nation-state adversary + 7-figure holdings. **Most devs need ~10% of that paranoia** — but no one tells them where the line is.

**Audience hook:** Garnon has $500–$50k in chain assets, uses MetaMask hot wallet, knows it's wrong but doesn't know what's right. Glacier looks like overkill (correct), so they do nothing (wrong).

**The tunable-paranoia tier framework (the post's spine):**

| Tier | Holding | Threat model | Setup |
|---|---|---|---|
| Casual | <$1k | Phishing, malware | Hardware wallet (Ledger/Trezor), seed in fireproof safe |
| Serious | $1k–$50k | Targeted phishing, home theft | 2-of-3 multi-sig, seeds in 3 physical locations, no cloud |
| Treasury | $50k–$1M | Sophisticated attacker, kidnapping | 3-of-5 multi-sig across people you trust, geographic distribution, 24h time-lock on large outflows |
| Glacier-grade | $1M+ / nation-state risk | State actor, $5 wrench attack | Full Glacier Protocol — air-gapped, geographic quorum, dead-man's switch |

**Adapt-to-any-chain section:** how the Glacier patterns translate to:
- **Antelope** — built-in `setpermission` multi-sig + custom `weight` thresholds (cleaner than Bitcoin); `delay_sec` for time-lock built into permission system
- **Ethereum** — Gnosis Safe is the closest analog; Safe + Aragon for time-locks
- **Solana** — Squads multi-sig (less mature, document the gaps)

**Format:** 1 long-form video (35 min) + 1 deep blog post (the framework table) + 1 LinkedIn carousel (the tier table is shareable on its own) + lead magnet ("Cold-storage tier picker — 5 questions that tell you which tier you need", PDF).

**Slot:** **W22+** (deferred from W14–W15 per audience-fit decision 2026-05-01 — senior-infra cold-storage content was clashing with Cohort #1 delivery + Cohort #2 enrollment Garnon-shape).

### Topic 2 — Antelope RAM at scale: what happens when you hit 1M users?

**Working title:** *"My Antelope Chain Hit 1 Million Users — Here's What Broke and What I Did"* (or, if it hasn't happened yet, *"What Happens to an Antelope Private Chain at 1M Users — A Capacity Plan"*)

**Angle:** Sequel to W08 OVH cost-breakdown. The W08 post sells "€300/mo for a chain" — this one earns trust by saying *"here's where €300/mo runs out and what you do next."* Honest scaling content is rare and shareable.

**Audience hook:** Garnon now believes he can ship on-chain. Next question: "but does it scale?" Most Antelope content stops before this.

**The capacity-planning math (the post's spine):**

```
1M users × 5 kittens avg × 150 bytes packed = 750 MB
+ ownership history (3× turnover): ~2 GB
+ marketplace listings (1% active): ~10 MB
+ breeding cooldowns + auxiliary tables: ~500 MB
≈ 3.5 GB chain RAM steady state
+ state-history-plugin growth: ~10 GB / month at 100 tx/sec
```

Tractable on 32 GB nodes for ~3M users; serious problems at ~10M.

**Scaling options ladder (each gets its own video segment):**

| Option | When | Cost | Trade-off |
|---|---|---|---|
| **Vertical — bigger OVH boxes** | First (1M → 5M users) | €500–€1,500/mo per node × 4 | Cheap, easy, but linear. Cap ~512 GB RAM on OVH High-Grade. |
| **Off-chain state + on-chain proofs** | Second (5M+) | Same boxes + S3/IPFS | Refactor: only hashes/commitments on-chain, full state in object storage. Standard Web3 pattern. |
| **Cloud bare-metal (AWS i4i, GCP)** | If you need geo-redundancy | 3–5× OVH cost | Buys cross-region failover, costs more for the same iron. |
| **Horizontal sharding** | 50M+ users / multi-product | High eng cost | Antelope doesn't shard natively — split product across multiple chains, or wait for Vaulta sharding research |
| **Move to Vaulta mainnet** | If decentralization > cost control | Variable | Trade your private-chain advantages for a real public chain |

**Format:** 1 long-form video (40 min, the capacity math is the visual) + 1 deep blog post (the math table is the lead magnet) + 1 LinkedIn carousel + spreadsheet lead magnet ("Antelope capacity calculator — input users, get RAM/disk/cost").

**Slot:** **W22+** (deferred from W18–W19 per audience-fit decision 2026-05-01 — those weeks ship the cohort retro + Phase 2 pivot videos, both Garnon-shaped).

### Topic 3 — Disk, blob storage, throughput, and chain pruning

**Working title:** *"How Big Does an Antelope Chain Get? Disk Math + the 1 GB Video Question + How to Throw the Old Chain Away"*

**Angle:** Pairs with the RAM-at-scale post (Topic 2). Where Topic 2 answers "how many users fit in RAM," this one answers "how much disk does it eat over time, and what do you do at year 5?" Disk content is rarer than RAM content in Antelope ecosystem, so high SEO value.

**Audience hook:** Garnon's first instinct is "store everything on-chain — that's the whole point, right?" This post says no, and shows the math.

**Spine — three sections:**

#### 3a. Disk-space math (empty chain → busy chain)

Antelope = 0.5s block time = ~172,800 blocks/day = ~63 M blocks/year.

| Scenario | blocks.log/yr | state-history/yr | Notes |
|---|---|---|---|
| **Empty chain** (no actions) | ~4 GB | ~30–50 GB | header bytes only; SHIP overhead dominates |
| **Game-typical** (10–100 tx/s) | ~50–200 GB | ~150–500 GB | breeding/marketplace tx are tiny |
| **At 1 MB/block sustained** | ~63 TB | ~80+ TB | catastrophic — see §3b |

Frame the takeaway: on a bare-metal cluster (Topic spec §6), a normal game chain costs you ~1 TB/yr disk. Cheap. A blob-storage chain costs you 60+ TB/yr. Plan for the right one.

#### 3b. The "1 GB video on-chain" question — should the app allow it?

**Answer: no, and here's why.**

- Block-size cap (~1–2 MB/block on a private chain at acceptable propagation) means a 1 GB blob = ~1000 transactions, ~8 minutes minimum to commit.
- blocks.log + state-history accumulate forever — every BP and replica pays the storage cost in perpetuity, multiplied by replica count.
- Network: 1 MB/block sustained = 16 Mbit/s on every node, every replica, every reader — survivable on OVH but kills budget cloud nodes.
- The chain becomes the bottleneck for a workload object storage was designed for.

**The right architecture: hash on-chain, blob off-chain.**

| Off-chain target | When to pick it | Cost (2026) |
|---|---|---|
| **S3 / MinIO / Backblaze B2** | Mutable, you control retention, app needs delete/edit/access-control | ~$5/TB/mo (B2); MinIO mesh ~$3–7/TB/mo all-in (see Topic 4) |
| **IPFS (self-pinned + Pinata)** | Content-addressed, dedupable, censorship-resistant, immutable | ~$20/TB/mo (Pinata pin); ~$0 if you self-pin + accept the risk |
| **Arweave** | "Pay once, store forever" — matches on-chain ethos for permanent assets | ~$15 per GB one-time (2026 est, verify) |
| **Filecoin** | Long-term archival with cryptographic proofs of replication | ~$2/TB/yr |

The contract stores: `{ blob_hash, blob_size, storage_uri, uploaded_by }`. Reject any `setrow` that exceeds a few KB at the contract level — make the wrong path impossible.

**IPFS deep-dive — same problem space as S3, fundamentally different paradigm**

Worth its own treatment because devs new to web3 confuse it with "decentralized S3" — it isn't.

| Dimension | S3 / MinIO | IPFS |
|---|---|---|
| Addressing | Location (`bucket/key` — mutable pointer) | Content (`CID = sha256-of-bytes` — pointer changes if content changes) |
| Mutability | Edit / overwrite / version / delete freely | **Immutable.** Edit = new CID. Old content lives until last pin drops. |
| Hosting | You (or cloud) own the bytes | Anyone in the IPFS swarm; **bytes disappear unless someone "pins" them** |
| Access control | IAM, signed URLs, bucket policies | **None native.** Anyone with the CID gets the bytes. Encrypt before upload if private. |
| Deduplication | Per-bucket, manual | Free + automatic across the entire swarm — same kitten sprite uploaded by 1M users = 1 stored copy globally |
| Best for | User-private blobs (saves, account data, anything you might delete) | Permanent shared assets (NFT art, game-wide sprites, public proofs) |
| Worst for | Permanent immutable proofs | Anything you might want to retract, edit, or access-control |

**When to use which (decision tree for the game):**

1. **Is the blob the SAME across many users?** (game art, sprite sheet, NFT metadata) → **IPFS** — dedup is free, perfect fit. Pin via own node + Pinata fallback.
2. **Is the blob private to one user?** (save game, settings, profile photo) → **MinIO/S3** — IAM + delete are required, IPFS gives you neither.
3. **Is the blob a permanent on-chain proof companion?** (auction record, breeding-event evidence) → **Arweave** — pay once, durable forever, content-addressed (so the on-chain hash = the Arweave key).
4. **Is the blob cold-archive backup?** (year-3 chain pruning artifact) → **Filecoin** or **S3 Glacier** — cheap, slow retrieval is fine.
5. **All of the above in one game?** Yes — a real-world game uses 3+ tiers. The contract just stores hash + storage_uri; the URI scheme (`ipfs://`, `s3://`, `ar://`) tells the client which retriever to use.

**Pinata / Web3.Storage / Filebase make IPFS feel like S3** — they expose an S3-API in front of an IPFS pinning service. App code does S3 puts/gets; underneath, content is pinned to IPFS + cached on Filecoin. Best of both for game art workloads where you want IPFS's dedup + permanence but don't want to operate pin nodes.

**Pros / cons summary:**

| | Pros | Cons |
|---|---|---|
| **IPFS** | Free dedup, censorship-resistant, content-addressed (hash IS the address), permanent if pinned, swarm caches popular content | No mutate/delete, no access control, **content disappears if no one pins**, gateway latency variable, hot-content vs cold-content imbalance |
| **MinIO/S3** | Mutable, IAM, predictable latency, mature ecosystem, fine-grained control | No native dedup, you pay per-byte stored regardless of demand, single point of trust (the bucket owner) |

#### 3c. Throwing the old chain away — pruning strategies after years 3–5

When blocks.log + state-history hit 5+ TB and snapshots take hours, you have four options:

| Strategy | What you keep | What you lose | Effort |
|---|---|---|---|
| **Snapshot + reset** | Current state, all balances, all contract storage | Full historical log (who-did-what-when) | Low — `nodeos --snapshot-to-snapshot` then start fresh chain from snapshot |
| **Archive + new chain** | Snapshot of state on new chain + cold tarball of old blocks.log | Live queryability of history (must rehydrate one node to query) | Low — same as above + tar to S3 Glacier (~$1/TB/mo) |
| **Hard fork to new genesis** | Migrated balances/state via contract calls; new chain ID | History continuity (apps must be re-pointed) | High — touches every dApp using the chain |
| **Vaulta mainnet migration** | State migrated to public chain | Self-host control | High + governance dependency |

**Recommended pattern (the user's instinct, validated):**

> Snapshot → tar → S3 Glacier. **Don't run replica nodes of the archived chain.** Keep one bootable image so you can spin a single forensic node on-demand if anyone ever asks "what happened in 2027?" Saves €240+/mo per archived chain. Forensic node can run on a cheap €30/mo VPS only when needed.

**Demo for the video:** live snapshot of the game chain, spin up a fresh chain from it, show that the new chain has all the kittens but none of the breeding history. Then `du -sh` the old `data/` dir to drive home what was thrown away.

**Format:**
- Long-form video (40 min): live disk-math walkthrough + intentionally-failed 1 GB upload demo + live snapshot+rehydrate
- Blog: the three tables + the architecture decision tree
- LinkedIn: ① "Stop storing files on-chain — the math" carousel, ② "How I throw away 5 years of chain history without losing customer balances" hot take, ③ snapshot-rehydrate GIF
- Lead magnet: **disk-space + blob-storage decision spreadsheet** — input tx/sec, avg tx size, blob size, retention years → output TB/yr per node + recommended off-chain target

**Slot:** **W22+** (deferred from W19–W20 per audience-fit decision 2026-05-01). Natural sequel to Topic 2; together they form the "Antelope Operations at Scale" mini-series, repackageable as a paid mini-course or Cohort #2 bonus module.

### Topic 4 — Self-hosted MinIO mesh: anti-fragile blob storage at home + family + cloud

**Working title:** *"I Replaced AWS S3 with 4 Cheap Boxes at Home, My Parents', My Brother's, and One Tiny VPS — Here's the Math"*

**Angle:** Concrete continuation of Topic 3's off-chain blob recommendation. Where Topic 3 lists S3 / IPFS / Arweave / Filecoin as targets, this post argues for **a self-hosted MinIO mesh with anti-fragile multi-site replication**, and shows it beats AWS S3 on TCO at >2 TB. The Taleb angle ("low-reliability nodes, but many of them") is the differentiator — most self-hosted-storage content assumes one beefy NAS in a basement; this post assumes 3–4 cheap boxes that each have a 90% uptime, replicated.

**Audience hook:** Garnon (and the wider self-host-curious dev audience) wants to escape AWS lock-in but believes "real" S3 replacement requires a homelab + UPS + 10G switch + a CCNA. This post says no — 4 × $500 mini-PCs running MinIO + Tailscale + a $20 VPS is enough to beat AWS Standard at TCO and survive any single home burning down.

**Spine — five sections:**

#### 4a. Why MinIO (not AWS S3, not Ceph, not Garage, not just rsync)

- **MinIO**: single Go binary, S3-API-compatible, BSD-3, built-in bucket replication to any other S3 target (including AWS, Backblaze, another MinIO). The pragmatic choice.
- **vs AWS S3 (managed):** S3 wins on zero-ops, baked-in HIPAA/SOC2/PCI, instant PB scale, 11-nines region durability. **Lose on:** ~$23/TB/mo storage + $90/TB egress (the killer — every game asset download bills you), surprise-bill risk (one misconfigured pipeline = $$$), US legal jurisdiction + account-suspension exposure (data hostage if AWS turns you off), and lock-in (S3 lifecycle policies are easy in, hard out). MinIO is bit-identical S3 API → apps don't notice the swap. For a sovereign, predictable-cost, ≤50 TB game-asset workload, MinIO wins on TCO from year ~2 and on sovereignty from day 1.
- **vs Ceph**: industrial-strength, but operational burden is high — plan 2 weeks to get comfortable, ongoing OSD-rebalance dramas. Overkill for ≤10 TB.
- **vs Garage**: newer, designed exactly for geo-distributed home setups, fewer features, smaller community. Worth a sidebar mention; not the recommendation.
- **vs rsync + cron**: fine for backup, not a usable storage tier — apps can't write to it via S3 API.

#### 4b. The architecture (4 sites, all independent)

| Site | Hardware | Role | Cost (one-time) |
|---|---|---|---|
| Home | N100 mini-PC + 4 TB NVMe + UPS | primary writer | ~$500 |
| Parents | Pi 5 + 4 TB USB SSD + small UPS | replica | ~$300 |
| Brother | N100 mini-PC + 4 TB NVMe | replica | ~$500 |
| Cloud (OVH small VPS) | 2 vCPU / 4 GB / 4 TB attached block storage | replica + public read endpoint | ~$20/mo |

**Topology:** **NOT distributed-mode MinIO** (that needs sub-100ms inter-node latency — home Internet won't deliver). Instead **4 independent single-node MinIO instances** with **bucket replication** between them. Each node is its own truth; replication is async, eventual consistency.

**Replication policy:**
- Home → Cloud + Parents + Brother (3-way fan-out, async)
- Cloud → Glacier lifecycle rule (objects older than 30 days → Glacier @ ~$1/TB/mo) — the doomsday-backup tier
- Parents/Brother → read-only mirrors, never written by apps

#### 4c. Networking: Tailscale, not Mailinabox-DDNS (mostly)

**Why DDNS alone doesn't solve this:**
- Most residential ISPs put you behind NAT (often CGNAT now). A DDNS A-record points to a public IP that can't accept inbound connections.
- Even when you have a real public IP, opening ports = exposed S3 endpoints = constant scanning + brute-force attacks.

**The right primitive: Tailscale (or self-hosted Headscale).**
- Each MinIO node joins one Tailnet. Each gets a stable `100.x.y.z` address.
- Inter-node MinIO replication runs over Tailscale — no port forwarding, no public exposure, WireGuard under the hood (fast, encrypted).
- Free for personal use up to 100 devices. Headscale = the open-source control plane if Ami wants full sovereignty.

**Where Mailinabox-DDNS *does* fit:**
- The public read endpoint. The Cloud node is the only one with a real public IP. Point `s3.amiheines.com` (CNAME or A record managed by Mailinabox's nsupdate API) at the Cloud node. Apps and end-users hit that endpoint; the home/family nodes stay invisible behind Tailscale.

#### 4d. Monitoring + remote management from laptop

- **MinIO Prometheus endpoint** (`/minio/v2/metrics/cluster`) → existing Grafana stack (you already run Grafana per credentials memory). Dashboards: per-node uptime, replication lag, disk %, SMART warnings.
- **Alerts** (Grafana → ntfy.sh or Pushover): node down >5 min, replication lag >10 min, disk >85%, SMART pre-fail.
- **Fleet management**: tiny Ansible playbook over Tailscale SSH. Targets: `apt update`, MinIO version bump, cert renewal (none needed if all-Tailscale), config sync.
- **Ami's laptop = the only ops console.** Family members are explicitly *not* sysadmins.

#### 4e. Cost comparison + the anti-fragile case

| Option | 4 TB usable, 1 yr | Survives 1 site loss? | Survives 3 site loss? |
|---|---|---|---|
| **AWS S3 Standard** | ~$1,100/yr | ✓ (S3's own redundancy) | ✗ (single region) |
| **AWS S3 Standard + Glacier replica** | ~$1,150/yr | ✓ | ✓ |
| **Backblaze B2** | ~$240/yr | ✓ | ✗ |
| **MinIO mesh (this proposal)** | $1,800 once + ~$420/yr (VPS + Glacier + power) | ✓ | ✓ (Glacier survives) |

**Break-even: ~year 2.** From year 3 on, MinIO mesh costs ~30% of AWS for the same redundancy.

**Anti-fragile angle (the headline):**
- Each node has 90% uptime. Mesh as a whole has 99.99%+ — you only lose service if 4 independent unreliable systems fail simultaneously.
- Hardware failure = swap a $300 box, replication backfills automatically.
- Family member unplugs node = it's back when they plug it back in. No sysadmin emergency.
- ISP outage = other 3 nodes serve, replication catches up when ISP returns.
- House fire / theft = 3 other replicas + Glacier. Sleep fine.
- *Actively gets stronger from stress*: every recovery exercise validates the topology, every alert tunes the noise floor.

#### 4f. Honest cons (don't hand-wave these)

- **Family is not your team.** They will unplug, repower, accidentally factory-reset. UPS + boot-on-power + auto-restart MinIO + remote IPMI/PiKVM where possible. Document recovery in a one-page PDF taped to the box.
- **Residential ISP T&Cs** sometimes prohibit "running servers." Practically ignored for personal use; legally fragile if you ever serve customer data and the ISP audits. Read your contract before storing anything that isn't yours.
- **Asymmetric upload bandwidth.** Home fiber: typical 1 Gbps down / 50–300 Mbps up. Replication writes saturate upstream — schedule heavy backfills overnight or rate-limit MinIO replication (`mc admin bandwidth`).
- **Insurance + GDPR** if anything other than your own data lives on a residential box in another country. Don't promise "production-grade compliance" on this stack.
- **Config is the real asset.** Losing the IAM users + bucket policies + replication rules is worse than losing a node. Back up `~/.minio/` to a separate target weekly. Use Ansible vault or sops for secrets.

**Format:**
- Long-form video (45 min): physical hardware unboxing of all 4 sites, install timelapse, live "unplug a node, watch the dashboard" demo, cost-comparison spreadsheet walkthrough
- Blog: the architecture diagram + cost table + Tailscale-vs-DDNS argument
- LinkedIn: ① "I run S3 across my parents' house" headline carousel, ② "Tailscale beats public DDNS for self-hosted storage — here's why" hot take, ③ uptime dashboard screenshot
- Lead magnet: **"4-site MinIO build kit"** — Ansible playbook + Tailscale ACL template + Grafana dashboard JSON + bill-of-materials spreadsheet

**Slot:** **W22+** (deferred from W20–W21 per audience-fit decision 2026-05-01). Paired with Topic 3 in the "Antelope Operations at Scale" mini-series. Topic 2 (RAM) + Topic 3 (disk + chain pruning) + Topic 4 (off-chain blob mesh) form a complete operational story repackageable as a paid mini-course or Cohort #2 bonus module.

### Adding new backlog topics

Append to this section as ideas surface. Each entry: working title + angle + audience hook + format + slot guess. Promote into the dated calendar when a slot opens.
