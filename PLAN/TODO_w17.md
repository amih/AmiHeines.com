# Week 17 — ChainTalk: Site Registration + User Auth + Embed Widget Start

**Dates:** 2026-07-13 to 2026-07-19
**Focus:** 80% ChainTalk / 20% outreach + content
**Target hours:** 20

---

## ChainTalk Expansion (16 hours)

### CT4 — Site Registration + Domain Verification (3-4 hours)
- [ ] `POST /api/sites/register` — register a new site:
  - Input: domain, display_name, email
  - Generate API key (random 32-byte hex)
  - Generate verification token (random string)
  - Store in sites table (unverified state)
  - Return: API key + verification instructions (DNS TXT or meta tag)
- [ ] `GET /api/sites/:id/verify` — verify domain ownership:
  - **DNS TXT method:** check for TXT record `chaintalk-verify=<token>` on domain
  - **Meta tag method:** fetch domain homepage, check for `<meta name="chaintalk-verify" content="<token>">`
  - On verification: push `regsite` action to chain, update DB, mark verified
- [ ] `GET /api/sites/:id` — get site details (settings, stats, verification status)
- [ ] `PUT /api/sites/:id` — update site settings (moderation mode, theme, display name)
- [ ] API key middleware: validate API key header on embed requests
- [ ] Test: register site → verify via both methods → site active on chain

### CT5 — User Auth (3-4 hours)
- [ ] `POST /api/auth/register` — email + password + display name:
  - Create blockchain account for user (auto-generated name)
  - Push `reguser` action to chain
  - Hash password, store in DB
  - Send verification email
  - Return: session JWT
- [ ] `POST /api/auth/login` — email + password:
  - Validate credentials
  - Create session
  - Return: JWT
- [ ] `GET /api/auth/session` — get current user info
- [ ] `POST /api/auth/logout` — terminate session
- [ ] Anonymous posting mode:
  - If site settings allow anonymous: accept `display_name` without registration
  - Create ephemeral blockchain account per anonymous commenter
  - Anonymous comments marked as such in UI
- [ ] JWT token format: includes user_id, account name, display_name
- [ ] Test: register, verify email, login, post comment, logout

### CT6 — Embed Widget JS Loader (4-5 hours)
- [ ] Create `embed.js` — vanilla JavaScript, no framework:
  - Tiny loader (<5KB minified): reads `data-*` attributes from host `<div>`
  - Creates iframe pointing to `chaintalk.amiheines.com/widget/:siteId/:pageId`
  - Auto-resize iframe height based on content (via postMessage)
  - Pass theme (light/dark) and accent color to iframe
  - Handle error states: invalid site, API down, rate limited
- [ ] Serve from `GET /api/embed.js` with long cache headers + versioning
- [ ] PostMessage protocol between iframe and host:
  - `chaintalk:resize` — iframe sends height, host resizes
  - `chaintalk:ready` — iframe loaded
  - `chaintalk:error` — error state
  - `chaintalk:auth` — user logged in/out
- [ ] Test embed on a local HTML page:
  ```html
  <script src="http://localhost:4323/api/embed.js" async></script>
  <div id="chaintalk" data-site-id="test" data-page-id="/test" data-theme="light"></div>
  ```
- [ ] Verify: iframe loads, resizes correctly, theme applies

### CT7 — Embed Widget Iframe UI — Start (4-5 hours)

Build the iframe-hosted widget UI (this continues into week 18):

#### Comment List (3-4 hours)
- [ ] Create widget page: `/widget/:siteId/:pageId`
  - Minimal, self-contained HTML/CSS/JS (no heavy framework in iframe)
  - Or: lightweight React/Preact build specifically for widget
- [ ] Render comment list:
  - Threaded display (nested replies with indentation, max 3 levels)
  - Each comment shows: avatar, display name, time ago, body text, vote buttons (+/-), vote count
  - Blockchain receipt icon (🔗) linking to transaction on Verarta explorer
  - Hidden comments: show "[Comment hidden by moderator — reason: ...]" with link to moderation tx
  - "Load more" pagination at bottom
- [ ] Sort options: newest first, oldest first, most voted

#### Auth State in Widget (1 hour)
- [ ] Login/register form inline within widget:
  - "Sign in to comment" link → expand inline form (email + password + display name)
  - Or "Comment as guest" if site allows anonymous
  - JWT stored in iframe localStorage (scoped to chaintalk.amiheines.com)
- [ ] Show logged-in state: "Commenting as [name]" with logout link

---

## Outreach + Content (4 hours)

### Outreach (3 hours)
- [ ] Send 10 new LinkedIn messages
- [ ] Pipeline management
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 175-230 outreach messages

### Content (1 hour)
- [ ] Publish blog post #16
  - Candidate: "Building an Embeddable Widget with Vanilla JS and iframes — No React Required"
  - Candidate: "I Built a Blockchain Alternative to Disqus — Here's Why"
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] Site registration + domain verification working (DNS TXT + meta tag)
- [ ] User registration + login working
- [ ] Embed.js loader working — iframe loads on any HTML page
- [ ] Comment list rendering in widget iframe (threaded, with blockchain links)
- [ ] Auth inline in widget
- [ ] 175-230 outreach messages total
