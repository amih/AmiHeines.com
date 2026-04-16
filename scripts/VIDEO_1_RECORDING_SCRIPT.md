# Video 1 Recording Script
## "Enterprise Monitoring for $0: Grafana + Prometheus on One Server"

**Target length:** 15-18 minutes
**Format:** Screen recording with voiceover (facecam optional)
**Tone:** Conversational, like explaining to a colleague

---

## Screen Layout

**Tilix** split into two panes:
- **Left pane:** Claude Code in terminal (your working environment)
- **Right pane:** SSH to server (`ssh ubuntu@158.69.27.200`)

**Chrome** (Recording profile, clean tab bar):
- https://grafana.amiheines.com (logged in, dark theme)

You'll switch between Tilix and Chrome during the recording. The viewer sees how you actually work — Claude Code on the left, server on the right, Grafana in the browser.

## Before You Hit Record

1. Open Tilix, split right (`Ctrl+Alt+R`), set up left=Claude Code, right=SSH
2. Open Chrome (Recording profile), log into Grafana
3. Set Grafana dark theme (Settings > Preferences > UI Theme > Dark)
4. Set browser zoom to 110-125% so text is readable on YouTube
5. OBS: make sure mic is picking up, screen capture is 1080p
6. Script on your phone for reference

---

## Script

### INTRO (1-2 min)

> "I run 37 Docker containers on a single server — blockchain nodes, databases, web apps, mail, analytics. The question is: how do you know everything is healthy without checking each one manually?
>
> Today I'll show you a full monitoring stack — Grafana, Prometheus, Loki — running on the same server as everything else. Total cost: zero. No SaaS subscriptions, no vendor lock-in, all open source.
>
> And I'll show you my actual workflow — I use Claude Code as my development partner, so you'll see that running alongside the server terminal."

**[Show: Tilix — left pane has Claude Code, right pane has SSH session]**
**[Right pane: run `docker ps --format "table {{.Names}}\t{{.Status}}" | sort` — let it scroll so viewers see 37 containers]**

> "37 containers, all on one box. Let's see how we keep an eye on all of this."

### THE STACK (2 min)

> "Here's what's running the monitoring:"

**[Show: terminal, quickly list the components]**

> "**Prometheus** scrapes metrics every 15 seconds — CPU, memory, disk, network, and container-level stats.
>
> **Loki** collects logs from every container automatically — no log agents to configure per service.
>
> **Grafana** ties it all together into dashboards.
>
> Then there's **Node Exporter** for host metrics, **cAdvisor** for container metrics, **Promtail** to ship logs to Loki, and **Alertmanager** for when things go wrong.
>
> All of this runs in Docker Compose. One file, `docker compose up -d`, done."

### SERVER OVERVIEW DASHBOARD (3-4 min)

**[Navigate to: Server Overview dashboard]**

> "Let's look at the server itself first."

**[Point to each stat panel as you talk]**

> "Four numbers at the top: CPU, memory, disk, uptime. At a glance I know the server is healthy.
>
> Below that, CPU usage over time — broken down into user, system, and IO wait. If I see IO wait spiking, that tells me the disk is the bottleneck, not the CPU.
>
> Memory — I can see total vs. used vs. cached. Linux caches aggressively, so high memory usage isn't always a problem. What matters is whether available memory is shrinking over time.
>
> Disk I/O — reads and writes per second. Useful when a database is doing something unexpected.
>
> Network — inbound and outbound traffic. I filter out the Docker virtual interfaces so I only see real traffic."

**[Change time range to 24h or 7d to show trends]**

> "If I zoom out to 24 hours, I can see patterns — traffic spikes, scheduled jobs, that kind of thing."

### DOCKER CONTAINERS DASHBOARD (3-4 min)

**[Navigate to: Docker Containers dashboard]**

> "This is where it gets interesting. I have 37 containers — four blockchain nodes, databases, web servers, a mail server, analytics.
>
> The bar charts show CPU and memory per container, sorted by usage. Right away I can see which containers are the heaviest."

**[Point to specific containers]**

> "Elasticsearch is always hungry for memory — that's normal. The blockchain nodes use steady CPU because they're producing blocks every half second.
>
> The time series below shows how this changes over time. If a container starts using more memory than usual, I'll see it here before it becomes a problem."

**[Scroll to network chart]**

> "Container network I/O — I can see which services are actually talking to the outside world vs. just internal traffic."

### CATCHING A REAL PROBLEM LIVE (5-6 min)

> "Now let me show you something real. When I ran `docker ps` at the start, did you notice anything?"

**[Switch to Tilix, right pane: run `docker ps --format "table {{.Names}}\t{{.Status}}" | sort`]**

> "See this? `chainvault-hyperion-indexer — Up 1 second`. Every other container has been up for weeks. This one just restarted. That's suspicious. Let's investigate."

**Step 1: Check the dashboard**

**[Switch to Chrome: Docker Containers dashboard]**

> "First, the container dashboard. If I look at the CPU time series..."

**[Look at the hyperion-indexer line — it will show gaps or spikes where it restarts]**

> "You can see the pattern — it keeps dropping to zero and coming back. That's a crash loop. The container starts, runs for a bit, crashes, and Docker restarts it."

**Step 2: Check the logs**

**[Switch to Chrome: Container Logs dashboard, select `chainvault-hyperion-indexer` from dropdown]**

> "Now let's see what it's actually saying. Every container's logs flow into Loki automatically — I just pick the container from this dropdown."

**[Read the logs, look for error messages]**

> "There it is — [describe whatever error you see]. So now I know exactly what's wrong."

**Step 3: Fix it with Claude Code**

**[Switch to Tilix, left pane: Claude Code]**

> "Now here's how I actually work. Instead of manually digging through config files, I ask Claude Code to help."

**[Type something like: "the chainvault-hyperion-indexer container keeps restarting. The logs show [error]. Can you investigate and fix it?"]**

> "Claude Code has access to the project files, can read the docker compose config, check the logs, and suggest a fix — or just make the fix directly. This is how I build everything. It's like pair programming with someone who never gets tired."

**[Let Claude Code investigate and propose/apply a fix. If it works, show the container stabilizing. If not, explain what you'd do next.]**

> "The log volume chart in Grafana is useful too — see how it spikes every time the container restarts? If I had alerts configured, I'd get notified the first time this happened instead of discovering it during a video recording."

### WHY THIS MATTERS (1-2 min)

> "A few things I want to highlight.
>
> First — this entire stack is open source. Prometheus, Grafana, Loki — all free, all battle-tested at massive scale. I'm not paying for Datadog or New Relic or any monitoring SaaS. And if I move to a different server tomorrow, I take it all with me.
>
> Second — this runs on the same server as everything else. You don't need a separate monitoring server for small to medium deployments. Prometheus and Loki are lightweight.
>
> Third — you saw the workflow. Grafana shows me what's wrong, Claude Code helps me fix it. That combination means I can move fast without cutting corners. This is how I build everything — client projects included. When I deliver a proof of concept, it comes with dashboards like these. You don't just get working code — you get visibility into whether it's still working next month."

### OUTRO + CTA (30 sec)

> "If you're running services in production without monitoring, you're flying blind. And there's no reason to — this took about 3 hours to set up.
>
> I wrote a checklist for evaluating private blockchain infrastructure — it covers monitoring as one of the readiness criteria. Link in the description if you want it.
>
> Next week I'll show you how I integrate this with specific application metrics — not just host and container stats, but business-level numbers like transactions per second and payment success rates.
>
> Thanks for watching."

---

## After Recording

1. Save raw file to `~/Videos/raw/video-01-monitoring.mkv`
2. Edit in kdenlive: trim dead air, cut mistakes, add chapter markers
3. Export to `~/Videos/final/video-01-monitoring.mp4`
4. Thumbnail: dark background, text "Enterprise Monitoring for $0", Grafana dashboard screenshot
5. YouTube upload with description (see below)

## YouTube Description Template

```
Full monitoring stack on one server — Grafana, Prometheus, Loki — monitoring 37 Docker containers including blockchain nodes, databases, and web services. Zero cost, all open source.

What's covered:
00:00 - Intro: Why you need monitoring
01:30 - The monitoring stack
03:30 - Server Overview dashboard
07:00 - Docker Containers dashboard
10:00 - Catching a real problem live (crashing container investigation)
14:00 - Why open source monitoring matters

📋 Free checklist — Private Blockchain Infrastructure Checklist:
https://amiheines.com/resources

🔗 Links:
Website: https://amiheines.com
Book a call: https://amiheines.com/contact
Newsletter: https://amiheines.com/newsletter

Tools used:
- Grafana: https://grafana.com
- Prometheus: https://prometheus.io
- Loki: https://grafana.com/oss/loki/
- Docker: https://docker.com

#monitoring #grafana #prometheus #devops #selfhosted #opensource
```
