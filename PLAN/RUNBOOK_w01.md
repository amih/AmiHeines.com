# Week 1 Runbook — Operations & Verification

## Lead Magnet

### What was created
- **File:** `public/resources/private-blockchain-infrastructure-checklist.pdf` (and `.md` source)
- **Content:** 5-section checklist — use case validation, CTO questions, infrastructure requirements, build vs. buy matrix, vendor red flags
- **Served at:** https://amiheines.com/resources/private-blockchain-infrastructure-checklist.pdf

### How the gated download works
1. User visits https://amiheines.com/resources
2. User enters email in the form next to "Private Blockchain Infrastructure Checklist"
3. Form submits to Listmonk API (`lists.amiheines.com/api/public/subscription`)
4. User is added to the "Opt-in list" (UUID: `2f2d523d-5b13-48d1-8018-0c4f42078a27`)
5. Listmonk sends a confirmation email (double opt-in)
6. After confirmation, user should receive the download link

### What to configure in Listmonk
- Create a **welcome email template** in Listmonk that includes the PDF download link
- Or: set up a **campaign** triggered on subscription that delivers the PDF
- The PDF is publicly accessible at the URL above — the gating is the email capture, not access control

### To regenerate the PDF from source
```bash
cd /home/ami/dev/work/amiheines.com
pandoc public/resources/private-blockchain-infrastructure-checklist.md \
  -o public/resources/private-blockchain-infrastructure-checklist.pdf \
  --pdf-engine=pdflatex -V geometry:margin=1in -V fontsize=11pt \
  -V colorlinks=true -V linkcolor=blue
```

---

## Monitoring Stack

### Architecture
All services run in Docker on 158.69.27.200 via `/opt/monitoring/docker-compose.monitoring.yml`.

| Service | Container | Host Port | Internal Port | Purpose |
|---------|-----------|-----------|---------------|---------|
| Prometheus | monitoring-prometheus | 127.0.0.1:9090 | 9090 | Metrics collection & alerting |
| Grafana | monitoring-grafana | 127.0.0.1:3200 | 3000 | Dashboards & visualization |
| Loki | monitoring-loki | 127.0.0.1:3101 | 3100 | Log aggregation |
| Promtail | monitoring-promtail | — | 9080 | Log shipping to Loki |
| Node Exporter | monitoring-node-exporter | 127.0.0.1:9101 | 9100 | Host metrics |
| cAdvisor | monitoring-cadvisor | 127.0.0.1:8081 | 8080 | Container metrics |
| Alertmanager | monitoring-alertmanager | 127.0.0.1:9093 | 9093 | Alert routing |

### Access
- **Grafana UI:** https://grafana.amiheines.com (after DNS + certbot)
- **Default login:** admin / changeme (set via `GRAFANA_ADMIN_PASSWORD` env var)
- **Change password:** Set `GRAFANA_ADMIN_PASSWORD` in `/opt/monitoring/.env` and restart Grafana

### Common operations

**Start/stop the stack:**
```bash
ssh ubuntu@158.69.27.200
cd /opt/monitoring
sudo docker compose -f docker-compose.monitoring.yml up -d      # start
sudo docker compose -f docker-compose.monitoring.yml down        # stop
sudo docker compose -f docker-compose.monitoring.yml restart     # restart all
sudo docker compose -f docker-compose.monitoring.yml restart loki # restart one service
```

**Check health:**
```bash
# All containers running?
docker ps --filter 'name=monitoring-' --format 'table {{.Names}}\t{{.Status}}'

# Prometheus targets up?
curl -s http://localhost:9090/api/v1/targets | python3 -m json.tool | grep health

# Loki ready?
curl -s http://localhost:3101/ready

# Grafana healthy?
curl -s http://localhost:3200/api/health
```

**View logs for a monitoring service:**
```bash
docker logs monitoring-grafana --tail 50
docker logs monitoring-loki --tail 50
docker logs monitoring-promtail --tail 50
```

### Prometheus scrape targets
- `node-exporter:9100` — host CPU, memory, disk, network (15s interval)
- `cadvisor:8080` — container CPU, memory, network (15s interval)
- `localhost:9090` — Prometheus self-monitoring (60s interval)
- `grafana:3000` — Grafana health (60s interval)

### Alert rules (in alertmanager/rules.yml)
- **HostHighCpuUsage** — CPU > 85% for 5 minutes
- **HostHighMemoryUsage** — Memory > 90% for 5 minutes
- **HostDiskSpaceLow** — Root disk > 85% for 5 minutes
- **ContainerDown** — chainvault/verarta/matomo container missing for 2 minutes

Alert notifications are not yet configured. To add email alerts, edit `/opt/monitoring/alertmanager/alertmanager.yml` and add an email receiver.

### Grafana datasources (auto-provisioned)
- **Prometheus** — `http://prometheus:9090` (default)
- **Loki** — `http://loki:3100`

### Using Grafana
1. Log in at https://grafana.amiheines.com
2. **Explore → Prometheus** to query metrics:
   - `node_cpu_seconds_total` — CPU usage
   - `node_memory_MemAvailable_bytes` — available memory
   - `node_filesystem_avail_bytes` — disk space
   - `container_cpu_usage_seconds_total` — per-container CPU
   - `container_memory_usage_bytes` — per-container memory
3. **Explore → Loki** to query logs:
   - `{job="docker"}` — all container logs
   - `{job="docker", container_name="chainvault-bp1"}` — specific container
   - `{job="nginx", log_type="error"}` — nginx error logs
   - `{job="docker"} |= "error"` — search for "error" across all containers
4. **Dashboards → Import** — recommended community dashboards:
   - **1860** — Node Exporter Full (host metrics)
   - **14282** — cAdvisor (container metrics)
   - **13639** — Loki + Promtail (logs)

### Config files (local repo)
All configs are in `infra/monitoring/` and deployed to `/opt/monitoring/` on the server:
- `docker-compose.monitoring.yml` — service definitions
- `prometheus.yml` — scrape targets
- `promtail.yml` — log collection config
- `loki.yml` — log storage config
- `alertmanager/alertmanager.yml` — alert routing
- `alertmanager/rules.yml` — alert conditions
- `grafana/provisioning/datasources/datasources.yml` — auto-provisioned datasources

To update configs:
```bash
# From local machine
rsync -avz infra/monitoring/ ubuntu@158.69.27.200:/tmp/monitoring/
ssh ubuntu@158.69.27.200 "sudo cp -r /tmp/monitoring/* /opt/monitoring/"
ssh ubuntu@158.69.27.200 "cd /opt/monitoring && sudo docker compose -f docker-compose.monitoring.yml restart"
```

---

## Verification Checklist

### Pages — visit each and confirm it loads correctly

| Page | URL | What to check |
|------|-----|---------------|
| Home | https://amiheines.com/ | Hero section loads, "Book a Discovery Call" and "View My Work" buttons link correctly, newsletter subscribe form visible at bottom |
| About | https://amiheines.com/about/ | Bio content renders, navigation works |
| Services | https://amiheines.com/services/ | All tiers displayed ($997 assessment, $7.5K PoC, $20-50K, $15K audit, $2-5K/mo managed), "Book a Discovery Call" button links to /contact, subscribe form at bottom |
| Portfolio | https://amiheines.com/portfolio/ | ChainVault and Verarta case studies with tech stacks, links to chainvault.amiheines.com and verarta.com, "Discuss Your Project" button links to /contact |
| Blog | https://amiheines.com/blog/ | Shows 2 posts (parking ticket, Tel Aviv scandal), no placeholder posts visible |
| Blog Post | https://amiheines.com/blog/tel-aviv-parking-ticket-scandal-why-private-blockchain-matters/ | Full article renders, tags link to tag pages |
| Blog Post | https://amiheines.com/blog/benefits-of-private-blockchain-for-managing-parking-tickets-in-large-cities/ | Full article renders |
| Contact | https://amiheines.com/contact/ | Cal.com booking calendar loads in embed, contact form fields work, "Other Ways to Connect" shows email/LinkedIn/YouTube |
| Newsletter | https://amiheines.com/newsletter/ | "What You'll Get" and "Recent Topics" sections, subscribe form present |
| Resources | https://amiheines.com/resources/ | 3 lead magnets listed with email capture forms |
| Tags | https://amiheines.com/tags/ | Tag list renders |
| Terms | https://amiheines.com/terms/ | Terms page renders |

### Forms & Integrations

| Test | Steps | Expected result |
|------|-------|-----------------|
| Newsletter signup | Enter test email on /newsletter → click Subscribe | "Check your email to confirm your subscription" message. Email appears in Listmonk admin (lists.amiheines.com). Confirmation email received. |
| Resource download | Enter test email on /resources → click "Download PDF" | "Check your email to confirm" message. Email added to Listmonk opt-in list. |
| Contact form | Fill all fields on /contact → click "Send Message" | "Message sent!" confirmation (requires /api/contact backend — may not be implemented yet, expect graceful error) |
| Cal.com embed | Visit /contact | Cal.com booking widget loads and shows available time slots |
| Matomo tracking | Visit any page → check https://matomo.amiheines.com | Page view recorded in Matomo dashboard for site ID 1 |

### privateblockchaindatabase.com

| Test | Steps | Expected result |
|------|-------|-----------------|
| Home page | Visit https://privateblockchaindatabase.com/ | Static parked page: "This site is being restructured" with link to amiheines.com |
| Blog redirect | Visit https://privateblockchaindatabase.com/blog/ | 301 redirect to https://amiheines.com/blog/ |
| Post redirect | Visit https://privateblockchaindatabase.com/blog/tel-aviv-parking-ticket-scandal-why-private-blockchain-matters | 301 redirect to amiheines.com equivalent |
| SSL | Visit via https:// | Valid certificate, no warnings |

### Monitoring

| Test | Steps | Expected result |
|------|-------|-----------------|
| Grafana access | Visit https://grafana.amiheines.com | Login page loads (admin / changeme) |
| Prometheus targets | After login → Explore → Prometheus → query `up` | All 4 targets return value 1 (prometheus, node-exporter, cadvisor, grafana) |
| Host metrics | Explore → Prometheus → query `node_memory_MemAvailable_bytes` | Returns current available memory in bytes |
| Container metrics | Explore → Prometheus → query `container_cpu_usage_seconds_total` | Returns CPU usage per container |
| Container logs | Explore → Loki → query `{job="docker"}` | Shows live log streams from all Docker containers |
| Nginx logs | Explore → Loki → query `{job="nginx"}` | Shows nginx access and error log entries |

### RSS & SEO

| Test | Steps | Expected result |
|------|-------|-----------------|
| RSS feed | Visit https://amiheines.com/rss.xml | Valid RSS with 2 blog entries |
| Sitemap | Visit https://amiheines.com/sitemap-index.xml | Valid sitemap index |
| Open Graph | Check any page with https://www.opengraph.xyz/ | Title, description, and image preview render correctly |
