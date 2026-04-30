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

### W08 (Jun 22–28) — Full 4-node cluster + list growth push
- **Dev:** nodes 2 + 4 added, failover tested, snapshots automated, off-site backups working.
- **YT:** *"I Run an Antelope BP Cluster for €300/Month — Full Cost Breakdown"*.
- **Blog:** cost breakdown post — **THE HN post; schedule for Tuesday US morning**.
- **LI:** ① cost-breakdown carousel, ② "my full failover drill", ③ "what self-hosting taught me that managed never would".
- **Newsletter:** "€300/mo BP cluster" cost spreadsheet (lead magnet) → **second sub spike**.
- **Shareable hook:** *"Show HN: I run my chain on €300/mo of OVH — here's the breakdown"*.

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
| W07 | OVH self-hosting checklist (PDF) | infra-curious devs |
| W08 | "€300/mo BP cluster" cost spreadsheet (.xlsx) | infra-curious devs |
| W09 | Challenge curriculum preview | challenge-buyer adjacent |
| W12 | 90-day retro (PDF, gated) | newsletter spike |

## What we are NOT doing in W01–W12

- No daily Shorts (dropped 2026-04-30).
- No app-store submission arc — web only (see `GAME_spec.md` §2).
- No paid LinkedIn / Meta ads (unless W08 OVH post underperforms — re-evaluate W09).
- No external-link-in-body LinkedIn posts.
- No newsletter sponsorship swaps before W08 (need ≥200 subs first).
- No multi-topic content drift (gambling, meta-reporting only as it serves the build-in-public spine).
