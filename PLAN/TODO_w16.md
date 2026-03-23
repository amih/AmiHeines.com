# Week 16 — ChainTalk: Smart Contract + Backend Core

**Dates:** 2026-07-06 to 2026-07-12
**Focus:** 80% ChainTalk new build / 20% outreach + content
**Target hours:** 20

---

## ChainTalk — Blockchain Comment System (16 hours)

### CT1 — Smart Contract: chaintalk.core (5-6 hours)

#### Contract Code (3-4 hours)
- [ ] Create project structure: `chaintalk/blockchain/contracts/chaintalk.core/`
- [ ] Write `chaintalk.core.hpp` — tables:
  - `sites` (site_id, owner, domain, display_name, created_at, is_active, mod_mode, theme)
  - `comments` (comment_id, site_id, page_path, author, parent_id, body, body_hash, created_at, is_hidden)
  - `users` (user_id, account, display_name, email_hash, avatar_url, created_at)
  - `votes` (vote_id, comment_id, voter, value, created_at)
  - `moderations` (mod_id, comment_id, moderator, action, reason, created_at)
  - Indices: by_site_page (comments), by_author, by_comment (votes), by_moderator
- [ ] Write `chaintalk.core.cpp` — actions:
  - `regsite` (self auth — register domain)
  - `updatesite` (site owner — update settings)
  - `reguser` (self auth — register user account)
  - `postcomment` (user auth — post or reply, validate site_id + page_path)
  - `editcomment` (author auth — edit body, store new hash, history preserved via Hyperion)
  - `vote` (user auth — +1/-1, one vote per user per comment, toggle on re-vote)
  - `moderate` (site owner auth — hide/unhide/flag with reason)
- [ ] Write `CMakeLists.txt`

#### Compile + Deploy (1-2 hours)
- [ ] Compile with Antelope CDT
- [ ] Create `chaintalkco` account on Verarta blockchain
- [ ] Deploy WASM + ABI
- [ ] Test all actions via cleos:
  - Register a site
  - Register users
  - Post comments and replies (verify threading via parent_id)
  - Vote on comments
  - Edit a comment (verify old version accessible via Hyperion history)
  - Moderate: hide, unhide, verify moderation record
- [ ] Verify all actions and deltas in Hyperion

### CT2 — Backend Foundation (4-5 hours)
- [ ] Create `chaintalk/backend/` Astro 5 SSR project
- [ ] Install dependencies: @astrojs/node, pg, redis, jsonwebtoken, bcrypt, prom-client, zod
- [ ] Create PostgreSQL database `chaintalk`
- [ ] Write migration:
  ```
  sites (id, domain, owner_account, api_key_hash, display_name, settings, created_at)
  users (id, account, email, password_hash, display_name, avatar_url, created_at)
  sessions (id, user_id, token_hash, expires_at, created_at)
  comments_cache (id, blockchain_comment_id, site_id, page_path, author_account, author_name, parent_id, body, body_hash, created_at, is_hidden, upvotes, downvotes)
  ```
- [ ] Create core libs:
  - `db.ts` — PostgreSQL pool
  - `redis.ts` — Redis client
  - `auth.ts` — JWT + bcrypt + sessions
  - `antelope.ts` — chain client (Verarta cluster)
  - `api-key.ts` — API key generation + validation for site owners
- [ ] Create auth middleware (JWT for users, API key for site embed requests)
- [ ] Astro config: SSR, Node adapter, port 4323
- [ ] PM2 ecosystem config
- [ ] Test: starts, connects to DB + Redis + chain

### CT3 — Comment CRUD API (5-6 hours)
- [ ] `GET /api/comments/:siteId/:pageId` — get comments for a page:
  - Paginated (default 50 per page)
  - Returns threaded tree structure (comments with nested replies)
  - Include: author display name, avatar, vote counts, created_at, blockchain tx link
  - Include moderation status (hidden comments show "[hidden by moderator — reason]")
  - Cache in Redis (invalidate on new comment/vote/moderation)
- [ ] `POST /api/comments` — post a comment:
  - Validate: site_id exists, page_path non-empty, body 1-2000 chars
  - If parent_id > 0: validate parent exists and belongs to same site+page
  - Push `postcomment` action to chain
  - Insert into comments_cache
  - Invalidate Redis cache for this page
  - Return: new comment with blockchain tx ID
- [ ] `PUT /api/comments/:id` — edit a comment:
  - Validate: user is author
  - Push `editcomment` action to chain (new body + hash)
  - Update comments_cache
  - Invalidate cache
- [ ] `POST /api/comments/:id/vote` — vote:
  - Validate: user is not author (can't self-vote)
  - Push `vote` action to chain
  - Update vote counts in cache
  - Return: new vote counts
- [ ] `POST /api/comments/:id/moderate` — moderate:
  - Validate: user is site owner
  - Push `moderate` action to chain
  - Update comments_cache (is_hidden)
  - Return: moderation record
- [ ] Test: full CRUD cycle — post, reply, edit, vote, moderate — all reflected on chain + cache

---

## Outreach + Content (4 hours)

### Outreach (3 hours)
- [ ] Send 10 new LinkedIn messages
- [ ] Pipeline management, close deals
- [ ] Post 3-5 LinkedIn insights
- [ ] Running total: 165-220 outreach messages

### Content (1 hour)
- [ ] Publish blog post #15
  - Candidate: "Writing a Smart Contract for a Comment System — Why Blockchain Comments Can't Be Silently Deleted"
- [ ] Share on LinkedIn

---

## End-of-Week Checkpoints

- [ ] chaintalk.core contract deployed and tested on Verarta chain
- [ ] ChainTalk backend running with full comment CRUD API
- [ ] Comments stored on chain + cached in PostgreSQL + cached in Redis
- [ ] Threading, voting, and moderation all working
- [ ] 165-220 outreach messages total
