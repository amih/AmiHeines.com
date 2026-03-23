# Week 18 — ChainTalk: Widget UI Completion + Landing Page

**Dates:** 2026-07-20 to 2026-07-26
**Focus:** 80% ChainTalk / 20% outreach + content
**Target hours:** 20

---

## ChainTalk Widget + Landing (16 hours)

### CT7 continued — Embed Widget Iframe UI Completion (4-5 hours)

#### Comment Posting (2-3 hours)
- [ ] Post comment form:
  - Textarea with character counter (max 2000)
  - "Post to blockchain" button with loading state
  - After post: new comment appears immediately (optimistic UI), blockchain tx link appears when confirmed
  - Reply: "Reply" button on each comment → expand reply form inline below comment
- [ ] Voting UI:
  - Up/down arrow buttons per comment
  - Current vote count between arrows
  - Highlight user's own vote
  - Prevent self-voting
  - Loading state during blockchain transaction
- [ ] Error handling:
  - Network errors: "Failed to post. Retry?"
  - Rate limiting: "Please wait before posting again"
  - Auth required: "Sign in to comment"

#### Theming + Polish (2 hours)
- [ ] Light theme (default): white background, dark text
- [ ] Dark theme: dark background, light text
- [ ] Customizable accent color via `data-accent` attribute
- [ ] CSS variables for all theme tokens (easy for Pro tier customization later)
- [ ] Responsive: works on mobile (320px) to desktop
- [ ] Loading skeleton while comments load
- [ ] Empty state: "Be the first to comment!"
- [ ] "Powered by ChainTalk 🔗" footer link (links to landing page)

### CT8 — ChainTalk Landing Page (4-5 hours)
- [ ] Create marketing page at `chaintalk.amiheines.com`:
  - **Hero:** "Comments that can't be silently deleted." — subhead: "Drop-in blockchain-backed comments for any website."
  - **How it works:** 3-step: 1. Add script tag, 2. Comments stored on blockchain, 3. Every message has a receipt
  - **Live demo:** Embedded ChainTalk widget right on the landing page (meta!)
  - **Comparison table:** ChainTalk vs Disqus vs Commento (the pitch from section 11.10.5)
  - **Pricing:** Free / Pro / Enterprise / Self-hosted tiers
  - **Setup wizard:** "Get started in 2 minutes" → register site → get embed code → copy-paste
  - **FAQ:** How does it work? Is it really immutable? What about spam? Can I moderate? How fast?
  - **Footer:** "Built by Ami Heines — Blockchain Infrastructure Consultant" → amiheines.com
- [ ] SEO: title, meta description, Open Graph
- [ ] Matomo tracking
- [ ] Test: page loads, demo widget works, setup wizard generates valid embed code

### CT9 — Admin Dashboard (5-6 hours)
- [ ] Site owner dashboard at `chaintalk.amiheines.com/dashboard`:
  - **Stats:** total comments, comments today, active users, vote count
  - **Comment moderation queue:**
    - Flagged comments requiring review
    - Recent comments (newest first)
    - Hide/unhide actions with reason input
    - Bulk moderation (select multiple → hide)
  - **Site settings:**
    - Display name, moderation mode (pre-approve / post-moderate / open)
    - Anonymous commenting toggle
    - Theme selection (light/dark/auto)
    - Accent color picker
  - **API key management:**
    - Show current API key (masked, reveal on click)
    - Regenerate API key (with confirmation warning)
  - **Embed code generator:**
    - Preview embed code with current settings
    - Copy-to-clipboard button
    - Live preview of widget with current theme
  - **Pages list:** all pages with comments, sorted by recent activity
- [ ] Dashboard auth: site owner login (same auth system, site_owner flag)
- [ ] Test: full dashboard flow — login, view stats, moderate comment, update settings, copy embed code

---

## Outreach + Content (4 hours)

### Outreach (3 hours)
- [ ] Send 10 new LinkedIn messages
- [ ] Pipeline management, close deals
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 185-240 outreach messages
- [ ] **Revenue milestone check:** Should be at $2K+/month by now from outreach + freelance + any POFOV leads

### Content (1 hour)
- [ ] Publish blog post #17 or YouTube video
  - Candidate: "I Built a Blockchain Alternative to Disqus — Here's Why and How" (great video)
  - Candidate: "Why Your Comment Section Should Be on a Blockchain (5 Minutes for CTOs)"
- [ ] Share on LinkedIn + Product Hunt consideration for ChainTalk launch

---

## End-of-Week Checkpoints

- [ ] ChainTalk widget fully functional: post, reply, vote, moderate, themed
- [ ] Landing page live at chaintalk.amiheines.com with live demo
- [ ] Admin dashboard working: stats, moderation, settings, embed code generator
- [ ] Setup wizard: register → verify → get embed code → works on any site
- [ ] 185-240 outreach messages total
