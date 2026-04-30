# Payment Plans — Cohort checkout flow

**Goal:** offer a 3-pay option alongside lump-sum to lift conversion on $5,000 cohort.

---

## Offer matrix

| Option | Total | Schedule | Customer sees |
|---|---|---|---|
| Lump sum | $5,000 | charged once at signup | "Pay in full — save $250" |
| 3-pay plan | $5,250 | $1,750 today + $1,750 in 30d + $1,750 in 60d | "3 monthly payments of $1,750" |

Uplift on plan = 5% (industry norm; covers extra processing fees + risk + softens lump-discount framing).

Optional 6-pay (only on request, not on the LP): $5,500 total in 6 × $917. Only if a serious buyer asks; do not advertise.

---

## Checkout flow

```
                         ┌─────────────────────────────────────┐
                         │  Cohort sales page                  │
                         │  amiheines.com/cohort               │
                         │                                     │
                         │  [Pay $5,000 in full]   ◀── default │
                         │  [3 payments of $1,750]             │
                         └─────────┬───────────────────────────┘
                                   │
                          buyer picks an option
                                   │
                ┌──────────────────┴───────────────────┐
                ▼                                      ▼
   ┌────────────────────────┐         ┌──────────────────────────────┐
   │ Invoice4U checkout —   │         │ Invoice4U recurring —        │
   │ one-time $5,000 USD    │         │ 3 × $1,750 monthly,          │
   │                        │         │ first charge today           │
   └────────────┬───────────┘         └──────────────┬───────────────┘
                │                                    │
                │ Webhook: invoice.paid              │ Webhook: subscription.created
                ▼                                    ▼
   ┌────────────────────────────────────────────────────────────────┐
   │ Backend handler                                                │
   │  1. Create cohort student record (Postgres)                    │
   │  2. Add to Listmonk "Cohort #1 students" list                  │
   │  3. Send Discord invite (auto-trigger to email)                │
   │  4. Send signed terms PDF via SignWell / DocuSign              │
   │  5. Slack #cohort-sales: "🎉 NEW SEAT: <name> (lump|3-pay)"     │
   └────────────────────────────────────────────────────────────────┘
                │
                ▼
   ┌────────────────────────────────────────────────────────────────┐
   │ Welcome email (Listmonk transactional)                         │
   │  Subject: You're in. Cohort #1 starts Mon Jul 20.              │
   │  Body: Discord link, calendar holds, Module 1 prep, terms PDF  │
   └────────────────────────────────────────────────────────────────┘
```

For 3-pay, additional webhooks:
- `invoice.payment_succeeded` (months 2 + 3) → log to ledger, no action
- `invoice.payment_failed` → email buyer, retry in 3 days, alert Slack #cohort-ops
- `subscription.completed` → mark student "paid in full"

---

## Failure / drop-off handling

**3-pay risk:** ~5-10% of plan-buyers default on month 2 or 3.

| Event | Action | Owner |
|---|---|---|
| Card decline (1st retry) | Invoice4U auto-retries in 24h | system |
| Card decline (2nd retry) | Email buyer with update-card link | system |
| 7 days past due | Slack alert + manual email from Ami | Ami |
| 14 days past due | Discord access paused; pro-rate refund offered | Ami |
| 21 days past due | Cohort access revoked; debt written off | Ami |

Don't chase: time spent on a $1,750 collection beats the value of the next sale by a lot.

---

## Refund policy (publish on checkout)

> **7-day money back.** If you decide the cohort isn't right within 7 days of Module 1 starting, email refund@amiheines.com for a full refund. After Day 7, no refunds (you've consumed live content).

Why 7 days specifically: matches Day 1 of cohort plus a 6-day grace period. Most buyer remorse hits before live delivery starts; clean refund here = fewer chargebacks later.

---

## Numbers to track (per cohort)

| Metric | Target |
|---|---|
| Lump-vs-plan split | ~55/45 |
| Plan default rate | <10% |
| Refunds within 7-day window | <15% of seats |
| Chargebacks (90 days) | <1% (industry threshold) |
| Average revenue per seat | ≥ $5,100 (after plan uplift, before fees) |

---

## Stack

- **Payment processor:** Invoice4U (Israel-based, accepts USD; reference: `reference_invoice4u.md` in memory)
- **Subscription billing:** Invoice4U recurring (preferred) or Stripe Billing if Invoice4U recurring is too clunky for 3-pay
- **Webhook handler:** small Node/Bun service on existing 158.69.27.200 box, behind nginx + bearer-token auth
- **Student CRM:** Postgres table `cohort_students` (already deployed for Listmonk)
- **Transactional email:** Listmonk (already deployed)
- **Signed terms:** SignWell free tier (5 docs/mo) or DocuSign Personal ($10/mo) — pick when first sale lands
- **Discord automation:** webhook bot via Cloudflare Worker (free tier)

---

## Implementation order

1. **W07** (cohort LP build week): hard-code the two pricing options on the page; checkout buttons → Invoice4U test charge
2. **W08–W09:** wire webhook handler + Listmonk auto-add + Discord invite
3. **W09:** dry-run the full flow with a test card before challenge week
4. **W10–W11:** real charges; manually monitor first 5 transactions
5. **Post-Cohort #1:** measure splits, defaults, refunds. Iterate the offer matrix for Cohort #2.
