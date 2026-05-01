# Risk Register — Phase 1 (W01–W21)

**Created:** 2026-05-01
**Owner:** Ami
**Cadence:** Re-read every Monday (Reflection day per `PLAN §4`). Update probabilities + mitigations when reality changes.

> Why this exists: the strategic deep-dive (2026-05-01) flagged that no single file in `PLAN/` answered "what if W10 sells 0 cohort seats?" or "what if Ami is sick during cohort week 3?" The plan was missing a contingency layer. This file is that layer.

Risks are scored: **Likelihood** (Low / Medium / High) × **Impact** (Minor / Significant / Existential). Triggers + responses are pre-written so a tired Ami in the moment doesn't have to re-decide.

---

## R1 — W10 challenge sells 0 cohort seats

- **Likelihood:** Medium
- **Impact:** Significant (Phase 1 revenue → ~$2.3k of challenge tickets only; OVH burn unrecouped; Phase 2 GO/NO-GO has no Phase-1 evidence)
- **Trigger:** by 7 days post-W10 close, 0 paid cohort signups
- **Response:**
  1. Send a personal email to every challenge attendee asking 1 specific question: "what would the cohort have needed to be worth $5k to you?" Capture the language verbatim.
  2. Defer Cohort #1 by 4–6 weeks. Run a second free challenge with the curriculum gap addressed.
  3. Keep audience-build cadence; cap weekly hours at 15 (recovery mode).
  4. Re-evaluate price: $5k → $2.5k self-paced + 2 group calls? Cochrane discipline says no, but at 0 sales the discipline has lost.
  5. Trigger Phase 2 ChainVault discovery a month early — diversify the bet.

## R2 — W10 challenge sells 1–2 cohort seats (below base)

- **Likelihood:** Medium-High
- **Impact:** Significant (cohort runs but at thin margin, energy investment doesn't match output)
- **Trigger:** 1–2 paid signups by 7 days post-W10 close
- **Response:**
  1. Run the cohort. Two students = real testimonial source. Better than no-launch.
  2. Cap cohort delivery hours at 8/wk (down from planned 10/wk) to preserve content cadence for Cohort #2 enrollment.
  3. Cohort #2 enrollment opens W17 (not W21) — capitalize on the testimonial momentum.
  4. Update §6 base case in `PLAN_amiheinesConsultant.md` from 3 → 1 seat for revenue projection sanity.

## R3 — Ami sick / family emergency for ≥1 week between W08–W17

- **Likelihood:** Medium (statistically Ami will miss at least one week in a 21-week stretch)
- **Impact:** Significant if mid-cohort (W12–W17) → refund-window reopens, chargeback risk
- **Trigger:** any 3+ day inability to ship
- **Response:** see `PLAN/cohort_contingency.md` (created in W11). Key levers:
  - Pre-named co-host runs the Module call
  - Async-only week (recording + Discord text + offer 1:1 office hours)
  - Discord-only emergency mode for full-week loss
  - **Pre-state in cohort terms: refund window does NOT reopen for one missed live week if recording delivered ≤72h**

## R4 — OVH cluster outage during W08 HN post / W09–W10 challenge

- **Likelihood:** Low–Medium (single home/dev sysadmin; first production cluster)
- **Impact:** Significant if during W10 challenge (live demo broken in front of paying attendees)
- **Trigger:** chain liveness fails, RPC unreachable, `nodeos` stuck
- **Response:**
  1. **Pre-W08:** test failover drill (see `TODO_w08.md`). Document `PLAN/runbook_ovh_failover.md`.
  2. **During challenge:** keep a Vaulta testnet backup endpoint pre-configured in the frontend with a single config flag — flip the flag, attendees keep working with no dev visible to them.
  3. Comms: 1-line Discord post — "small infra hiccup, switching to backup endpoint, 5 min." No drama, no refund pressure created.
  4. Post-mortem in W11 retro post becomes content (vulnerability email, per `LAUNCH_playbook.md` §6).

## R5 — W08 Show HN post tanks (lands at #25, falls off in 4h)

- **Likelihood:** Medium (HN is unpredictable even with warmup)
- **Impact:** Significant (sub-spike from 200 → 600 by W12 depends partly on this)
- **Trigger:** ≤25 upvotes in first 4h, no front-page placement
- **Response:**
  1. Don't email `hn@` — the post just didn't land, that's normal.
  2. Backup channels in priority order: Reddit r/eos (~3k subs, friendly to non-Ethereum content), r/IndieHackers, r/SideProject, r/SaaS. Each one is a 200–500-word repost of the post tailored to the subreddit's voice + rules.
  3. Personal LinkedIn carousel of the same post — forces it into the Ami brand graph.
  4. Adjust W12 sub target down from 600 → 400. Continue plan.
  5. **Don't try the same post on HN again later** — once flagged "didn't land," reposts hurt. Save the next HN shot for a different angle (W11 cohort retro, W18+ Phase 2 pivot).

## R6 — Ami working >25h/week sustained for 3+ weeks (burnout signal)

- **Likelihood:** Medium-High (W06–W08 are deliberately over-cap; cohort weeks W12–W17 are full-cap)
- **Impact:** Existential if it triggers a multi-week crash
- **Trigger:** any 3 consecutive weeks logging >25h actuals, OR any single week >32h, OR partner explicitly raises concern
- **Response:**
  1. **Immediate:** drop the W+1 video. Replace with "off this week" personal note to the list.
  2. Defer the next non-revenue commit (next OVH node, next backlog topic, next blog post that's not auto-derived).
  3. Take 2 days off-grid. No phone notifications. Walk, sleep, family.
  4. Re-read `PLAN §4` (Dream Week wheel). Re-block calendar.
  5. **If the burnout signal repeats once recovered** → kill Cohort #2 from W21 plan; run Cohort #1 only and revisit Phase 2 timing with fresh perspective.

## R7 — Spouse / family unhappy with the over-cap weeks

- **Likelihood:** High if not pre-cleared (currently nothing in the plan does this)
- **Impact:** Existential to the relationship pillar; cascades to recharge + reflection failure
- **Trigger:** any voiced concern from partner about hours, attention, distraction
- **Response:**
  1. **Pre-emptive (action item: do this in W01):** sit-down conversation with partner — share the calendar, name the W06–W08 over-cap stretch, ask explicitly for buy-in. Not "telling" — *asking*. If partner says no, the over-cap stretch is not viable; reduce scope.
  2. Calendar gates that are *non-negotiable*: weekly date day, Friday off, Sunday recharge. These are protected before any cohort or content commitment.
  3. Mid-W08 check-in: 5-min "how are we doing" with partner. Adjust before W09.
  4. If concerns persist into W12 (cohort delivery) → drop to 8h/wk cohort delivery cap (per R2 response), buy back the time for relationship.

## R8 — Invoice4U decline / chargeback rate >5% on the 3-pay plan

- **Likelihood:** Low–Medium (3-pay plans default at 5–10% per `payment_plans.md`)
- **Impact:** Minor financially per default; significant if chargebacks → processor account flag
- **Trigger:** ≥1 chargeback or ≥2 declines that don't recover within 14 days
- **Response:**
  1. Per `payment_plans.md` §"Failure / drop-off handling" — auto-retry, then manual email at 7d, then Discord pause + pro-rate refund offer at 14d, then revoke at 21d.
  2. If 2nd chargeback: pause 3-pay option entirely; lump-sum only for Cohort #2.
  3. If processor flags account: have Stripe Billing as a 24h-spinnable backup (per `payment_plans.md` §Stack).

## R9 — Cohort #1 student goes hostile in Discord (refund threat, public callout)

- **Likelihood:** Low–Medium (8-12 students, first cohort, novel format = nontrivial risk)
- **Impact:** Significant if escalates to public; minor if contained
- **Trigger:** any student post in Discord expressing anger, demanding refund outside terms, or signaling intent to write publicly
- **Response:**
  1. **Within 4h:** private 1:1 message offering a call. Not defensive — ask "what would make this right for you?"
  2. If a refund inside terms: process it the same day, no questions, write the playbook for next time.
  3. If outside terms but they're suffering: offer a partial refund + access continuation. Cheaper than a public callout.
  4. **Never argue publicly.** Even if they're wrong, the audience watching will side with the customer.
  5. Post-incident: write a private retro to `PLAN/cohort_retro.md`. Identify what we missed in the offer/onboarding/expectations setting.

## R10 — Phase 2 audience pivot (Garnon → title-firm operators) finds zero traction

- **Likelihood:** Medium-High (audience is genuinely different; W19 trickle outreach starts mid-Phase-1 to de-risk per C4a)
- **Impact:** Significant for W22+ plan; doesn't kill Phase 1
- **Trigger:** by end of W21, fewer than 3 title-firm discovery calls completed AND no clear "yes, this is a real problem" signal
- **Response:**
  1. NO-GO on Phase 2 per `PLAN §8`.
  2. Run Cohort #2 W22+ as the primary revenue source.
  3. Spend Q2-2026 re-doing discovery on adjacent verticals (escrow lawyers, mortgage brokers, real-estate ops directors) before re-attempting Phase 2.
  4. Don't sink dev hours into ChainVault until a real customer pulls.

---

## Quarterly review template

Every 4 weeks (start W05, W09, W13, W17, W21), score each risk:

| Risk | Likelihood now | Impact now | Mitigation status | Action this period |
|---|---|---|---|---|
| R1 W10 0 seats | | | | |
| R2 W10 1–2 seats | | | | |
| R3 Sick week | | | | |
| ... | | | | |

If any risk moves from Medium → High likelihood, trigger the response *now*, not when the trigger fires.
