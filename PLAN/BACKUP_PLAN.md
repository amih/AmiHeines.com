# Backup and Infrastructure Documentation

**Author:** Ami Heines
**Created:** 2026-03-23
**Last updated:** 2026-03-23

This document covers backup strategy, disaster recovery, secrets management, and infrastructure-as-code planning for all of Ami's services across all servers.

---

## Table of Contents

1. [Backup Strategy Overview](#1-backup-strategy-overview)
2. [Mail-in-a-Box Backup](#2-mail-in-a-box-backup)
3. [Listmonk Backup](#3-listmonk-backup)
4. [Matomo Backup](#4-matomo-backup)
5. [Private Blockchain Backup (CRITICAL)](#5-private-blockchain-backup-critical)
6. [Monitoring Stack Backup](#6-monitoring-stack-backup)
7. [Static Sites Backup](#7-static-sites-backup)
8. [nginx and SSL Configuration Backup](#8-nginx-and-ssl-configuration-backup)
9. [Home Server (tv.amiheines.com) Backup](#9-home-server-tvamiheiniscom-backup)
10. [Password and Secrets Management](#10-password-and-secrets-management)
11. [Infrastructure as Code: Terraform vs Alternatives](#11-infrastructure-as-code-terraform-vs-alternatives)
12. [Disaster Recovery Runbook](#12-disaster-recovery-runbook)

---

## 1. Backup Strategy Overview

### Server Inventory

| Server | IP / Hostname | Provider | Role |
|--------|---------------|----------|------|
| Main production | 158.69.27.200 | OVH | All services: ChainVault, Verarta, Listmonk, Matomo, monitoring, static sites |
| Old server | 51.83.10.201 | OVH | Decommissioned (privateblockchaindatabase.com moved to main) |
| Mail server | mail.amiheines.com | OVH / VPS | Mail-in-a-Box: email + authoritative DNS |
| Home server | tv.amiheines.com | Home | Media server, dynamic DNS |

### Asset Backup Matrix

| Asset | What to Backup | Frequency | Priority | Retention | Rebuild Time (no backup) |
|-------|---------------|-----------|----------|-----------|--------------------------|
| MiaB email + DNS | Built-in backup (full system) | Daily | **CRITICAL** | 30 days | Hours (DNS propagation) |
| Producer keys & wallet keys | Key files, wallet passwords | On change | **CRITICAL** | Forever | Unrecoverable |
| MinIO (ChainVault) | Encrypted document store | Daily | **CRITICAL** | 30 days | Unrecoverable |
| Blockchain blocks.log | Block log + index (both chains) | Weekly | **HIGH** | 3 copies | Days (replay from peers) |
| SHIP (State History) node data | State history files | Weekly | **HIGH** | 2 copies | Days (full replay) |
| Nodeos snapshots | Portable snapshots | Daily | **HIGH** | 7 days | Hours (with blocks.log) |
| Listmonk database | PostgreSQL dump | Daily | **HIGH** | 30 days | Subscriber list lost |
| Listmonk uploads | /listmonk/uploads/ directory | Weekly | MEDIUM | 30 days | Minutes (re-upload) |
| Matomo database | MariaDB/MySQL dump | Daily | MEDIUM | 30 days | Analytics history lost |
| Matomo config | config.ini.php | On change | MEDIUM | 30 days | Minutes (reconfigure) |
| Hyperion / Elasticsearch | Index snapshots | Monthly | LOW | 1 copy | Hours (rebuild from chain) |
| PostgreSQL (chain read cache) | Not needed | N/A | LOW | N/A | Hours (sync daemon rebuild) |
| MongoDB (Hyperion metadata) | Not needed | N/A | LOW | N/A | Hours (rebuild from chain) |
| Grafana dashboards | JSON export | On change | LOW | In git | Minutes (re-import) |
| Monitoring configs | Already in git | On commit | LOW | In git | Minutes (redeploy) |
| nginx configs | Already in git | On commit | LOW | In git | Minutes (redeploy) |
| Static sites | Already in git | On commit | LOW | In git | Minutes (rebuild + deploy) |
| SSL certificates | /etc/letsencrypt/ | Monthly | LOW | 1 copy | Minutes (certbot re-issue) |
| Home server config | Docker configs, cron jobs | Monthly | LOW | 1 copy | Hours |

### Where to Store Backups

Backups should be stored **off-server**. Options in order of preference:

1. **A second OVH server or OVH Object Storage (S3-compatible)** -- same provider, different datacenter
2. **Backblaze B2** -- cheap ($0.005/GB/month), S3-compatible API
3. **Home server (tv.amiheines.com)** -- free, but single point of failure (fire, theft, ISP outage)
4. **Encrypted local disk** -- for key material only, stored physically separate

The 3-2-1 rule: 3 copies, 2 different media, 1 offsite. At minimum, keep production + one remote copy.

---

## 2. Mail-in-a-Box Backup

Mail-in-a-Box (MiaB) is the most operationally critical service. If email goes down, you lose client communication and DNS resolution for all amiheines.com services.

### Built-in Backup System

MiaB has a built-in backup system that uses `duplicity` for encrypted, incremental backups. It backs up:

- All mailboxes (email data)
- User database and aliases
- DNS zone files
- SSL certificates
- Roundcube contacts
- Nextcloud data (if used)
- All MiaB configuration

### Configuring Remote Backups

1. **SSH into the mail server:**
   ```bash
   ssh admin@mail.amiheines.com
   ```

2. **Access the admin panel:**
   Navigate to `https://mail.amiheines.com/admin` and go to **System > Backup Status**.

3. **Configure S3-compatible remote backup:**
   In the admin panel, set the backup target. For Backblaze B2:
   ```
   Target: s3://s3.us-west-002.backblazeb2.com/your-bucket-name/maib-backup
   Access Key: your-b2-application-key-id
   Secret Key: your-b2-application-key
   ```

   For a remote server via `rsync`:
   ```
   Target: rsync://backupuser@158.69.27.200/backups/miab/
   ```

4. **Verify backups are running:**
   Check the admin panel's Backup Status page. It shows the last backup time, size, and any errors. Backups run automatically via cron (typically nightly at 3 AM).

5. **Verify backup encryption:**
   MiaB encrypts backups automatically. The encryption key is stored in `/home/user-data/backup/secret_key.txt`. **Back up this key separately** -- without it, backups are unrecoverable. Store it in your password manager.

### Manual Backup

```bash
# SSH to mail server
ssh admin@mail.amiheines.com

# Trigger a manual backup
sudo /root/mailinabox/management/backup.py

# Check backup status
sudo /root/mailinabox/management/backup.py --status
```

### Restoring Mail-in-a-Box

Full restore (new server):

1. Provision a new Ubuntu server (same version as current -- check with `lsb_release -a`)
2. Set the hostname to `mail.amiheines.com`
3. Install MiaB:
   ```bash
   curl -s https://mailinabox.email/setup.sh | sudo bash
   ```
4. During setup, use the same email domain and admin account
5. Stop MiaB services:
   ```bash
   sudo systemctl stop mailinabox
   ```
6. Restore from backup:
   ```bash
   # If backup is on S3/B2:
   export AWS_ACCESS_KEY_ID=your-key
   export AWS_SECRET_ACCESS_KEY=your-secret
   export PASSPHRASE=$(cat /path/to/saved/secret_key.txt)

   duplicity restore \
     s3://s3.us-west-002.backblazeb2.com/your-bucket/miab-backup \
     /home/user-data/
   ```
7. Re-run the MiaB setup to regenerate configs:
   ```bash
   sudo /root/mailinabox/setup/start.sh
   ```
8. Update DNS at your registrar to point `mail.amiheines.com` to the new IP
9. Wait for DNS propagation (up to 48 hours, typically 1-4 hours)

### Critical Reminder

Since MiaB also serves as your **authoritative DNS**, if this server dies:
- All `*.amiheines.com` DNS records stop resolving
- Email stops working
- All subdomains (grafana.amiheines.com, lists.amiheines.com, etc.) go down

**Mitigation:** Consider adding a secondary DNS provider (e.g., Cloudflare as secondary) or at minimum, keep a written record of all DNS zones so you can recreate them quickly on a new MiaB instance.

```bash
# Export current DNS zones (run periodically and save output)
ssh admin@mail.amiheines.com "sudo cat /etc/nsd/zones/*.zone" > ~/dns-zones-backup-$(date +%Y%m%d).txt
```

---

## 3. Listmonk Backup

Listmonk runs as a Docker container on 158.69.27.200 and uses the `verarta-postgres` PostgreSQL instance for its database.

### What to Backup

| Component | Location | Method |
|-----------|----------|--------|
| Listmonk database | `verarta-postgres` container, database `listmonk` | `pg_dump` |
| Uploaded files | `/listmonk/uploads/` (or Docker volume) | `rsync` / `tar` |
| Listmonk config | `config.toml` or environment variables in docker-compose | In git / copy |

### Database Backup Script

```bash
#!/usr/bin/env bash
# /opt/backups/scripts/backup-listmonk.sh
set -euo pipefail

BACKUP_DIR="/opt/backups/listmonk"
DATE=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS=30

mkdir -p "$BACKUP_DIR"

# Dump the listmonk database from the verarta-postgres container
docker exec verarta-postgres pg_dump \
  -U postgres \
  -d listmonk \
  --format=custom \
  --compress=9 \
  > "$BACKUP_DIR/listmonk_${DATE}.dump"

# Backup uploads directory
if [ -d "/opt/listmonk/uploads" ]; then
  tar -czf "$BACKUP_DIR/listmonk_uploads_${DATE}.tar.gz" \
    -C /opt/listmonk uploads/
fi

# Clean old backups
find "$BACKUP_DIR" -name "listmonk_*.dump" -mtime +${RETENTION_DAYS} -delete
find "$BACKUP_DIR" -name "listmonk_uploads_*.tar.gz" -mtime +${RETENTION_DAYS} -delete

echo "[$(date)] Listmonk backup complete: $BACKUP_DIR/listmonk_${DATE}.dump"
```

### Cron Entry

```bash
# /etc/cron.d/backup-listmonk
0 2 * * * root /opt/backups/scripts/backup-listmonk.sh >> /var/log/backup-listmonk.log 2>&1
```

### Restoring Listmonk

```bash
# 1. Ensure the verarta-postgres container is running
docker ps | grep verarta-postgres

# 2. Drop and recreate the listmonk database
docker exec -i verarta-postgres psql -U postgres -c "DROP DATABASE IF EXISTS listmonk;"
docker exec -i verarta-postgres psql -U postgres -c "CREATE DATABASE listmonk;"

# 3. Restore from dump
docker exec -i verarta-postgres pg_restore \
  -U postgres \
  -d listmonk \
  --no-owner \
  --no-privileges \
  < /opt/backups/listmonk/listmonk_20260323_020000.dump

# 4. Restore uploads
tar -xzf /opt/backups/listmonk/listmonk_uploads_20260323_020000.tar.gz \
  -C /opt/listmonk/

# 5. Restart Listmonk
docker restart listmonk
```

---

## 4. Matomo Backup

Matomo runs on 158.69.27.200 as two Docker containers: `matomo-app` and `matomo-db` (MariaDB/MySQL).

### What to Backup

| Component | Location | Method |
|-----------|----------|--------|
| Matomo database | `matomo-db` container | `mysqldump` |
| Matomo config | `config/config.ini.php` inside matomo-app volume | File copy |
| Matomo plugins | Custom plugins (if any) | File copy |

### Database Backup Script

```bash
#!/usr/bin/env bash
# /opt/backups/scripts/backup-matomo.sh
set -euo pipefail

BACKUP_DIR="/opt/backups/matomo"
DATE=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS=30

mkdir -p "$BACKUP_DIR"

# Dump the Matomo database
# Adjust MYSQL_ROOT_PASSWORD to match your docker-compose environment variable
docker exec matomo-db mysqldump \
  -u root \
  -p"${MATOMO_DB_ROOT_PASSWORD}" \
  --single-transaction \
  --routines \
  --triggers \
  matomo \
  | gzip > "$BACKUP_DIR/matomo_db_${DATE}.sql.gz"

# Backup the config file
docker cp matomo-app:/var/www/html/config/config.ini.php \
  "$BACKUP_DIR/config.ini.php_${DATE}"

# Clean old backups
find "$BACKUP_DIR" -name "matomo_db_*.sql.gz" -mtime +${RETENTION_DAYS} -delete
find "$BACKUP_DIR" -name "config.ini.php_*" -mtime +${RETENTION_DAYS} -delete

echo "[$(date)] Matomo backup complete: $BACKUP_DIR/matomo_db_${DATE}.sql.gz"
```

### Cron Entry

```bash
# /etc/cron.d/backup-matomo
30 2 * * * root MATOMO_DB_ROOT_PASSWORD=your_password /opt/backups/scripts/backup-matomo.sh >> /var/log/backup-matomo.log 2>&1
```

**Note:** Storing the password in a cron file is not ideal. Better to store it in `/opt/backups/.env` with `chmod 600` and source it from the script.

### Restoring Matomo

```bash
# 1. Ensure matomo-db container is running
docker ps | grep matomo-db

# 2. Restore the database
gunzip < /opt/backups/matomo/matomo_db_20260323_023000.sql.gz \
  | docker exec -i matomo-db mysql -u root -p"$MATOMO_DB_ROOT_PASSWORD" matomo

# 3. Restore config file
docker cp /opt/backups/matomo/config.ini.php_20260323_023000 \
  matomo-app:/var/www/html/config/config.ini.php

# 4. Restart Matomo
docker restart matomo-app
```

---

## 5. Private Blockchain Backup (CRITICAL)

This is the most important section. Both ChainVault and Verarta run Antelope-based private blockchains on 158.69.27.200, all in Docker containers. The blockchain is the **immutable source of truth** -- everything else is a derived, rebuildable read layer.

### Architecture Recap

Each chain (ChainVault and Verarta) consists of:

| Component | Containers | Criticality | Rebuildable? |
|-----------|-----------|-------------|--------------|
| **Block Producers (4 nodes)** | `*-bp1` through `*-bp4` | CRITICAL | Yes, with keys + blocks.log |
| **SHIP Node (State History)** | `*-ship` | CRITICAL | Yes, with blocks.log (slow) |
| **Hyperion Indexer** | `*-hyperion` | LOW | Yes, from chain |
| **Elasticsearch** | `*-elasticsearch` | LOW | Yes, reindex from chain |
| **PostgreSQL** | `*-postgres` | LOW | Yes, sync daemon rebuilds |
| **MongoDB** | `*-mongodb` | LOW | Yes, Hyperion rebuilds |
| **Redis** | `*-redis` | NONE | Ephemeral cache |
| **RabbitMQ** | `*-rabbitmq` | NONE | Ephemeral queue |
| **MinIO** (ChainVault only) | `chainvault-minio` | **CRITICAL** | NO -- contains user uploads |
| **Next.js Frontend** (ChainVault) | `chainvault-frontend` | LOW | Rebuild from git |

### 5.1 Key Backup (MOST SENSITIVE)

**If you lose the producer keys, you cannot produce blocks. The chain dies.**

Keys to back up:
- **Producer private keys** for all 4 block producers per chain (8 keys total)
- **Wallet password** (keosd wallet)
- **eosio system account key** (used for system contract deployment)
- **Application-level keys** (e.g., the key used by the Next.js backend to push transactions)

Where keys typically live:
```
# Inside the nodeos container or on the host
~/eosio-wallet/default.wallet    # keosd wallet file
config.ini                        # may contain producer private key (signature-provider)
```

**Backup procedure:**

```bash
# 1. Export the wallet (from inside the container or host)
# Find where the wallet files are mounted
docker inspect chainvault-bp1 | grep -A5 Mounts

# 2. Copy wallet files to backup
cp -r /path/to/eosio-wallet/ /opt/backups/keys/chainvault/

# 3. Export the producer key from config.ini
grep "signature-provider" /path/to/chainvault-bp1/config.ini

# 4. Repeat for all 4 producers and both chains
```

**Storage:** Producer keys must be stored:
- Encrypted (GPG or age encryption)
- In your password manager (Bitwarden/KeePassXC)
- On an encrypted USB drive stored in a separate physical location
- **NEVER** in git, even in a private repo
- **NEVER** in plaintext on the server

```bash
# Encrypt key backup with age (simple, modern encryption)
age -p -o /opt/backups/keys/chainvault-keys.age /opt/backups/keys/chainvault/

# Or with GPG
tar -czf - /opt/backups/keys/chainvault/ | gpg --symmetric --cipher-algo AES256 \
  -o /opt/backups/keys/chainvault-keys.tar.gz.gpg
```

### 5.2 Block Log Backup

The `blocks.log` file is the append-only record of every block ever produced. Combined with the genesis state, it can fully reconstruct the chain. The `blocks.index` file is a lookup index for blocks.log -- it can be regenerated but saving it speeds up recovery.

**Location (inside the nodeos container or mounted volume):**
```
/data/blocks/blocks.log
/data/blocks/blocks.index
```

**Backup procedure:**

```bash
#!/usr/bin/env bash
# /opt/backups/scripts/backup-blockchain-blocks.sh
set -euo pipefail

DATE=$(date +%Y%m%d)
BACKUP_DIR="/opt/backups/blockchain"

for CHAIN in chainvault verarta; do
  echo "[$(date)] Backing up $CHAIN blocks.log..."

  # Find the blocks volume mount
  BLOCKS_DIR=$(docker inspect ${CHAIN}-ship --format '{{ range .Mounts }}{{ if eq .Destination "/data" }}{{ .Source }}{{ end }}{{ end }}')/blocks

  # Alternative: if you know the path
  # BLOCKS_DIR="/opt/${CHAIN}/ship/data/blocks"

  mkdir -p "$BACKUP_DIR/$CHAIN"

  # Use rsync for incremental copy (blocks.log is append-only, so this is efficient)
  rsync -av --progress \
    "$BLOCKS_DIR/blocks.log" \
    "$BLOCKS_DIR/blocks.index" \
    "$BACKUP_DIR/$CHAIN/"

  echo "[$(date)] $CHAIN blocks.log backup complete ($(du -h "$BACKUP_DIR/$CHAIN/blocks.log" | cut -f1))"
done
```

**Frequency:** Weekly (blocks.log is append-only, so rsync is efficient after the first copy).

**Off-site transfer:**
```bash
# Sync to remote backup location
rsync -avz /opt/backups/blockchain/ backupuser@remote-server:/backups/blockchain/
```

### 5.3 Nodeos Snapshots

A snapshot captures the current **chain state** (account balances, table rows, permissions) at a specific block height. It is much smaller and faster to restore than replaying the entire blocks.log.

**Taking a snapshot:**

```bash
# Via the nodeos HTTP API (producer API plugin must be enabled)
# Replace port with the actual HTTP port for the SHIP node

# ChainVault SHIP node
curl -X POST http://localhost:8888/v1/producer/create_snapshot

# Response includes the snapshot path:
# {"head_block_id":"...","snapshot_name":"/data/snapshots/snapshot-0000abcd....bin"}
```

**Automated snapshot script:**

```bash
#!/usr/bin/env bash
# /opt/backups/scripts/backup-blockchain-snapshots.sh
set -euo pipefail

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/opt/backups/blockchain/snapshots"
RETENTION_DAYS=7

mkdir -p "$BACKUP_DIR"

for CHAIN in chainvault verarta; do
  # Determine the HTTP API port for the SHIP node
  # Adjust these ports to match your actual configuration
  case $CHAIN in
    chainvault) PORT=8888 ;;
    verarta)    PORT=8889 ;;
  esac

  echo "[$(date)] Creating $CHAIN snapshot..."
  RESPONSE=$(curl -s -X POST http://localhost:${PORT}/v1/producer/create_snapshot)
  SNAP_PATH=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin)['snapshot_name'])")

  if [ -n "$SNAP_PATH" ]; then
    # Copy snapshot from container volume to backup dir
    CONTAINER="${CHAIN}-ship"
    docker cp "$CONTAINER:$SNAP_PATH" "$BACKUP_DIR/${CHAIN}_snapshot_${DATE}.bin"

    # Compress it
    gzip "$BACKUP_DIR/${CHAIN}_snapshot_${DATE}.bin"

    echo "[$(date)] $CHAIN snapshot saved: ${CHAIN}_snapshot_${DATE}.bin.gz"
  else
    echo "[$(date)] ERROR: Failed to create $CHAIN snapshot. Response: $RESPONSE"
  fi
done

# Clean old snapshots
find "$BACKUP_DIR" -name "*_snapshot_*.bin.gz" -mtime +${RETENTION_DAYS} -delete
```

**Frequency:** Daily. Snapshots are small (MB range for a private chain) and fast to create.

### 5.4 State History Plugin (SHIP) Node Data

The SHIP node maintains a full history of every state change on the chain. This is the most complete dataset -- it allows you to query any historical state at any block height.

**What to backup:**
```
/data/state-history/         # SHIP trace and state files
  trace_history-*.log
  chain_state_history-*.log
```

**These files can be large.** For a private chain they may be manageable (GB range), but for an active chain they can grow significantly.

**Backup strategy:**
- The SHIP data can be fully reconstructed by replaying blocks.log with the state history plugin enabled. This takes time but is deterministic.
- If you have the storage space, back up SHIP data weekly alongside blocks.log.
- If storage is tight, just back up blocks.log and accept a longer recovery time.

```bash
# Backup SHIP data (rsync for incremental)
SHIP_DATA="/opt/chainvault/ship/data/state-history"
rsync -av "$SHIP_DATA/" /opt/backups/blockchain/chainvault/state-history/
```

### 5.5 Smart Contract WASM and ABI

Smart contracts deployed on the chain are stored on-chain. However, the **source code** and **build artifacts** should be in git.

**Verify contracts are in git:**
```bash
# Check your contract repos
ls ~/dev/work/chainvault/contracts/
ls ~/dev/work/verarta/contracts/
```

**Extract deployed contracts from chain (as a backup):**
```bash
# Get the contract WASM and ABI for an account
cleos -u http://localhost:8888 get code <account_name> -c /opt/backups/contracts/<account>.wasm -a /opt/backups/contracts/<account>.abi
```

**Do this for every account that has a contract deployed.** Keep these alongside your source code in git.

### 5.6 MinIO (ChainVault) -- CRITICAL

MinIO stores encrypted user-uploaded documents for ChainVault. These files are **not on the blockchain** (only their hashes are on-chain). If MinIO data is lost, the documents are gone forever -- the blockchain hash proves they existed but cannot reconstruct them.

**Backup procedure:**

```bash
#!/usr/bin/env bash
# /opt/backups/scripts/backup-minio.sh
set -euo pipefail

DATE=$(date +%Y%m%d)
BACKUP_DIR="/opt/backups/minio"

mkdir -p "$BACKUP_DIR"

# Option 1: Use mc (MinIO Client) for bucket-level backup
# Install mc if not present:
# wget https://dl.min.io/client/mc/release/linux-amd64/mc && chmod +x mc && mv mc /usr/local/bin/

# Configure mc alias (do this once)
# mc alias set chainvault-minio http://localhost:9000 ACCESS_KEY SECRET_KEY

# Mirror all buckets
mc mirror --overwrite chainvault-minio/ "$BACKUP_DIR/$DATE/"

# Option 2: Backup the raw Docker volume
MINIO_VOLUME=$(docker inspect chainvault-minio --format '{{ range .Mounts }}{{ if eq .Destination "/data" }}{{ .Source }}{{ end }}{{ end }}')
rsync -av "$MINIO_VOLUME/" "$BACKUP_DIR/raw-data/"

echo "[$(date)] MinIO backup complete"
```

**Frequency:** Daily. This data is irreplaceable.

**Off-site:** Always sync MinIO backups off-site immediately.

### 5.7 Hyperion / Elasticsearch

Elasticsearch powers the Hyperion history API. It indexes all blockchain actions and deltas for fast querying. It can be **fully rebuilt from the chain** by reindexing, but this takes hours to days depending on chain size.

**If you want to save rebuild time:**

```bash
# Register a snapshot repository in Elasticsearch
curl -X PUT "http://localhost:9200/_snapshot/backup_repo" -H 'Content-Type: application/json' -d '{
  "type": "fs",
  "settings": {
    "location": "/snapshots",
    "compress": true
  }
}'

# Create a snapshot
curl -X PUT "http://localhost:9200/_snapshot/backup_repo/snapshot_$(date +%Y%m%d)?wait_for_completion=true"
```

**Note:** The Elasticsearch container needs the `/snapshots` path mounted as a volume.

**Recommendation:** For a private chain with modest activity, it is usually faster and simpler to just let Hyperion reindex from the chain rather than maintaining Elasticsearch snapshots. Only invest in ES backups if reindexing takes more than a few hours.

### 5.8 PostgreSQL (Chain Read Cache)

The PostgreSQL databases for ChainVault and Verarta are **read caches** populated by a sync daemon that reads from the blockchain. They contain a relational view of on-chain data for the frontend to query.

**These are fully rebuildable.** The sync daemon will repopulate them from the chain.

**You do NOT need to back these up**, with one exception: the `listmonk` database that lives in `verarta-postgres` (covered in Section 3).

If you want to speed up recovery, you can dump them:

```bash
# Optional: dump the chain read databases
docker exec verarta-postgres pg_dump -U postgres -d verarta --format=custom > /opt/backups/verarta-postgres.dump
docker exec chainvault-postgres pg_dump -U postgres -d chainvault --format=custom > /opt/backups/chainvault-postgres.dump
```

But this is low priority since the sync daemon handles reconstruction.

### 5.9 MongoDB (Hyperion Metadata)

MongoDB stores Hyperion's internal metadata and action mappings. It is rebuilt when Hyperion reindexes from the chain.

**No backup needed.** Rebuilding from chain is the standard recovery path.

### 5.10 Docker Volumes Classification

| Volume | Chain | Critical? | Backup? |
|--------|-------|-----------|---------|
| `*-bp{1-4}-data` | Both | HIGH | Keys only (from config) |
| `*-ship-data` | Both | HIGH | blocks.log + state-history |
| `*-minio-data` | ChainVault | **CRITICAL** | YES -- irreplaceable |
| `*-postgres-data` | Both | LOW | Only listmonk DB |
| `*-elasticsearch-data` | Both | LOW | Optional (saves rebuild time) |
| `*-mongodb-data` | Both | NONE | No (Hyperion rebuilds) |
| `*-redis-data` | Both | NONE | No (ephemeral) |
| `*-rabbitmq-data` | Both | NONE | No (ephemeral) |
| `*-hyperion-data` | Both | LOW | Config only |
| `*-frontend` | ChainVault | NONE | No (rebuild from git) |

---

## 6. Monitoring Stack Backup

The monitoring stack runs at `/opt/monitoring/` on 158.69.27.200 with configs already tracked in git at `infra/monitoring/`.

### What is Already Covered

All configuration files are in the repo at `/home/ami/dev/work/amiheines.com/infra/monitoring/`:
- `docker-compose.monitoring.yml`
- `prometheus.yml`
- `promtail.yml`
- `loki.yml`
- `alertmanager/alertmanager.yml`
- `alertmanager/rules.yml`
- `grafana/provisioning/datasources/datasources.yml`

As long as the git repo is pushed to a remote, these configs are backed up.

### Grafana Dashboards

Grafana dashboards created via the UI are stored in the `grafana_data` Docker volume, not in git. Export them:

```bash
# Export all dashboards via API
GRAFANA_URL="http://localhost:3200"
GRAFANA_AUTH="admin:changeme"  # Use actual password
BACKUP_DIR="/opt/backups/grafana/dashboards"

mkdir -p "$BACKUP_DIR"

# Get all dashboard UIDs
UIDS=$(curl -s -u "$GRAFANA_AUTH" "$GRAFANA_URL/api/search?type=dash-db" | \
  python3 -c "import sys,json; [print(d['uid']) for d in json.load(sys.stdin)]")

for UID in $UIDS; do
  curl -s -u "$GRAFANA_AUTH" "$GRAFANA_URL/api/dashboards/uid/$UID" | \
    python3 -m json.tool > "$BACKUP_DIR/${UID}.json"
done

echo "Exported $(echo "$UIDS" | wc -w) dashboards to $BACKUP_DIR"
```

**Better approach:** Use Grafana provisioning to define dashboards as JSON files in `infra/monitoring/grafana/provisioning/dashboards/` so they are tracked in git. Then no backup is needed.

### Prometheus Data

Prometheus data is configured with `--storage.tsdb.retention.time=30d`. This is ephemeral monitoring data. If lost, you just lose historical metrics -- not a disaster.

**No backup needed** for Prometheus TSDB data.

### Loki Data

Log data in Loki is similarly ephemeral. Logs are for debugging, not long-term records.

**No backup needed** for Loki data.

---

## 7. Static Sites Backup

Both static sites are built from git repos and deployed via `infra/scripts/deploy.sh`:

| Site | Repo | Server Path |
|------|------|-------------|
| amiheines.com | `/home/ami/dev/work/amiheines.com` | `/opt/amiheines.com/dist/` |
| privateblockchaindatabase.com | Same repo (nginx config) | `/var/www/privateblockchaindatabase.com/` |

### Backup Strategy

The source of truth is the git repository. Ensure:

```bash
# Verify remote is configured and pushed
cd /home/ami/dev/work/amiheines.com
git remote -v
git push origin main

# The built dist/ directory is in .gitignore -- this is correct.
# It can be rebuilt with: npm install && npm run build
```

**No additional backup needed** as long as the git repo is pushed to a remote (GitHub, GitLab, etc.).

If you want belt-and-suspenders, the deploy script (`infra/scripts/deploy.sh`) already copies `dist/` to the server, so there is always a deployed copy on the server.

---

## 8. nginx and SSL Configuration Backup

### nginx Configuration

The nginx configs for amiheines.com sites are in git at `infra/nginx/`:
- `infra/nginx/amiheines.com`
- `infra/nginx/privateblockchaindatabase.com`

**However**, the server likely has additional nginx configs for other services (ChainVault, Verarta, Listmonk, Matomo, Grafana, etc.) that are NOT in this git repo.

**Backup all nginx configs:**

```bash
# On the server: backup all nginx site configs
ssh ubuntu@158.69.27.200 "sudo tar -czf /tmp/nginx-configs.tar.gz \
  /etc/nginx/sites-available/ \
  /etc/nginx/nginx.conf \
  /etc/nginx/snippets/ \
  /etc/nginx/conf.d/"

scp ubuntu@158.69.27.200:/tmp/nginx-configs.tar.gz /opt/backups/nginx/nginx-configs-$(date +%Y%m%d).tar.gz
```

**Recommendation:** Add all nginx configs to the git repo under `infra/nginx/` so they are version-controlled.

### SSL Certificates

SSL certificates are managed by Certbot with Let's Encrypt auto-renewal.

**Backup option 1: Just re-run certbot (recommended)**

Certificates auto-renew every 90 days. If you rebuild the server, just run:
```bash
sudo certbot --nginx -d amiheines.com -d www.amiheines.com
sudo certbot --nginx -d privateblockchaindatabase.com -d www.privateblockchaindatabase.com
sudo certbot --nginx -d grafana.amiheines.com
sudo certbot --nginx -d lists.amiheines.com
sudo certbot --nginx -d matomo.amiheines.com
# ... for each domain
```

**Backup option 2: Backup the Let's Encrypt directory**

```bash
# On the server
sudo tar -czf /opt/backups/ssl/letsencrypt-$(date +%Y%m%d).tar.gz /etc/letsencrypt/
```

This saves time during recovery but is not essential since certbot can re-issue certificates in minutes.

---

## 9. Home Server (tv.amiheines.com) Backup

The home server at `tv.amiheines.com` uses dynamic DNS updated via a cron job calling the MiaB API.

### Dynamic DNS Cron Job

This is critical to document and back up because if the home server dies and you rebuild, you need this to restore connectivity.

**Document the current cron job:**
```bash
# SSH to home server and capture the cron configuration
ssh user@tv.amiheines.com "crontab -l" > ~/backups/home-server/crontab-backup.txt
```

The dynamic DNS update likely looks something like:
```bash
# Update dynamic DNS via Mail-in-a-Box Custom DNS API
*/5 * * * * curl -s -X PUT \
  "https://mail.amiheines.com/admin/dns/custom/tv.amiheines.com/A" \
  -d "$(curl -s ifconfig.me)" \
  -u "admin@amiheines.com:PASSWORD" \
  > /dev/null 2>&1
```

**Back up this cron entry** and store the MiaB admin credentials in your password manager.

### Media Server (Jellyfin/Plex)

If the home server runs a media server like Jellyfin:

**What to backup:**

| Component | Path (Jellyfin typical) | Priority | Size |
|-----------|------------------------|----------|------|
| Config/database | `/var/lib/jellyfin/` or `~/.config/jellyfin/` | HIGH | Small (MB) |
| Metadata & images | `/var/lib/jellyfin/metadata/` | MEDIUM | Moderate (GB) |
| Media files | `/media/`, `/mnt/storage/` | LOW | Very large (TB) |
| Plugins | `/var/lib/jellyfin/plugins/` | LOW | Small |
| Watch history | In the database | HIGH | In config backup |

**Recommended strategy:**

1. **Config and database:** Back up regularly (weekly). This preserves users, watch history, library settings, and metadata preferences. Small enough for any backup destination.

   ```bash
   # Jellyfin config backup
   tar -czf /opt/backups/jellyfin-config-$(date +%Y%m%d).tar.gz \
     /var/lib/jellyfin/data/ \
     /var/lib/jellyfin/config/
   ```

2. **Metadata and images:** Back up monthly or on-demand. Jellyfin can re-download metadata from TMDB/TVDB, so this just saves time.

3. **Media files:** These are typically too large (terabytes) for regular backups. Options:
   - **RAID array** on the home server (protects against single-disk failure, NOT a backup)
   - **External hard drive** rotated periodically (old-school but effective)
   - **Second NAS** if you have one
   - **Accept the risk** if media can be re-acquired -- most people do this

**If running in Docker:**
```bash
# Identify the Jellyfin volumes
docker inspect jellyfin --format '{{ json .Mounts }}' | python3 -m json.tool

# Back up the config volume
docker run --rm -v jellyfin_config:/data -v /opt/backups:/backup \
  alpine tar czf /backup/jellyfin-config-$(date +%Y%m%d).tar.gz /data
```

### Other Home Server Services

Document any other services running on the home server. SSH in and check:

```bash
# What Docker containers are running?
docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'

# What systemd services are active?
systemctl list-units --type=service --state=running

# What is listening on ports?
ss -tlnp
```

Store the output of these commands in your backup documentation so you know what to rebuild.

---

## 10. Password and Secrets Management

### Current Problem

Passwords and secrets are likely scattered across:
- Docker Compose environment variables
- `.env` files on the server
- config.ini files
- Your memory
- Maybe a text file somewhere

This is not sustainable. A single server compromise, a lost laptop, or a forgotten password can lock you out of your own infrastructure.

### Recommended Solution: Vaultwarden (Self-hosted Bitwarden)

**Vaultwarden** is a lightweight, self-hosted implementation of the Bitwarden API. It is the best fit because:

- You already run Docker infrastructure, so adding one more container is trivial
- Bitwarden clients are excellent (browser extension, mobile app, CLI)
- End-to-end encrypted -- the server never sees your passwords
- Free for self-hosted (Bitwarden cloud charges for some features)
- Can be hosted on the main server or the home server

```yaml
# docker-compose.vaultwarden.yml
services:
  vaultwarden:
    image: vaultwarden/server:latest
    container_name: vaultwarden
    restart: unless-stopped
    environment:
      - DOMAIN=https://vault.amiheines.com
      - SIGNUPS_ALLOWED=false
      - ADMIN_TOKEN=your-long-random-admin-token
    volumes:
      - vaultwarden_data:/data/
    ports:
      - "127.0.0.1:8222:80"

volumes:
  vaultwarden_data:
```

**Chicken-and-egg problem:** If Vaultwarden runs on the same server as everything else, and the server dies, you lose access to your password manager. Mitigations:
- Export an encrypted backup of the Vaultwarden vault regularly
- Keep a KeePassXC database file as a secondary copy (synced to local machine)
- Memorize the Vaultwarden master password (obviously)

### Alternative Options

| Solution | Pros | Cons |
|----------|------|------|
| **Vaultwarden (self-hosted)** | Free, full control, Docker-native | Self-hosted means you maintain it |
| **Bitwarden Cloud** | Zero maintenance, reliable | $10/year for premium; data on their servers |
| **1Password** | Excellent UX, team features | $36/year; vendor lock-in |
| **KeePassXC** | Offline, fully local | No sync built-in; manual file management |
| **Plaintext files** | -- | **NEVER. DO NOT DO THIS.** |

### What Secrets Must Be Stored

**Infrastructure:**
- [ ] MiaB admin password (`admin@amiheines.com`)
- [ ] MiaB backup encryption key (`/home/user-data/backup/secret_key.txt`)
- [ ] Server SSH keys (or document where they are)
- [ ] OVH account credentials
- [ ] Domain registrar credentials

**Blockchain (CRITICAL):**
- [ ] ChainVault producer keys (4 keys: bp1, bp2, bp3, bp4)
- [ ] Verarta producer keys (4 keys: bp1, bp2, bp3, bp4)
- [ ] eosio system account key (both chains)
- [ ] Wallet passwords (keosd)
- [ ] Application signing keys

**Services:**
- [ ] Listmonk admin credentials
- [ ] Listmonk API key (used by amiheines.com signup forms)
- [ ] Matomo admin credentials
- [ ] Grafana admin password
- [ ] MinIO access key and secret key
- [ ] PostgreSQL passwords (verarta-postgres, chainvault-postgres)
- [ ] MongoDB credentials (if authentication is enabled)

**External Services:**
- [ ] Cal.com credentials (booking calendar)
- [ ] GitHub/GitLab credentials
- [ ] Backblaze B2 or backup storage credentials
- [ ] DNS registrar credentials
- [ ] SSL certificate account (Let's Encrypt email)

**Home Server:**
- [ ] MiaB API credentials (for dynamic DNS updates)
- [ ] Media server admin credentials
- [ ] Any other service credentials

---

## 11. Infrastructure as Code: Terraform vs Alternatives

### The Question

Should you use Terraform, Ansible, or something else to manage your infrastructure reproducibly?

### Terraform

**What it does:** Provisions cloud resources (VMs, networks, DNS records, object storage buckets) declaratively.

**Verdict: Overkill for your setup.**

Why:
- You have 1-2 bare metal OVH servers, not a cloud-native fleet
- Terraform excels at managing AWS/GCP/Azure resources that have APIs for creation and destruction
- OVH has a Terraform provider, but for bare metal servers, "provisioning" mostly means buying/configuring a server through the OVH API -- something you do once every few years
- Terraform adds complexity (state files, state locking, HCL syntax) without proportional benefit for your scale

**When Terraform would make sense:** If you move to OVH Public Cloud instances, Kubernetes, or multi-cloud, Terraform becomes valuable. Not yet.

### Ansible

**What it does:** Configures servers declaratively. Given a fresh server, an Ansible playbook installs packages, copies configs, starts services, and configures everything to a known state.

**Verdict: Good fit, but optional.**

Pros:
- Idempotent: run it repeatedly, it always converges to the desired state
- Can reproduce your entire server from scratch
- YAML-based, relatively readable
- Strong Docker/Docker Compose support via modules

Cons:
- Learning curve if you have not used it before
- Requires maintaining playbooks as infrastructure evolves
- For 1-2 servers, the overhead may not be worth it

**If you go with Ansible, here is a skeleton:**

```yaml
# playbook.yml -- configure main production server
---
- hosts: production
  become: yes
  vars_files:
    - vault.yml  # encrypted secrets

  tasks:
    - name: Install base packages
      apt:
        name: [docker.io, docker-compose-plugin, nginx, certbot, python3-certbot-nginx]
        state: present
        update_cache: yes

    - name: Copy Docker Compose files
      copy:
        src: "{{ item.src }}"
        dest: "{{ item.dest }}"
      loop:
        - { src: 'chainvault/docker-compose.yml', dest: '/opt/chainvault/' }
        - { src: 'verarta/docker-compose.yml', dest: '/opt/verarta/' }
        - { src: 'monitoring/docker-compose.monitoring.yml', dest: '/opt/monitoring/' }

    - name: Start ChainVault stack
      community.docker.docker_compose_v2:
        project_src: /opt/chainvault
        state: present

    - name: Copy nginx configs
      copy:
        src: "nginx/{{ item }}"
        dest: "/etc/nginx/sites-available/{{ item }}"
      loop:
        - amiheines.com
        - privateblockchaindatabase.com
        - chainvault.conf
        - verarta.conf
      notify: reload nginx

  handlers:
    - name: reload nginx
      systemd:
        name: nginx
        state: reloaded
```

### Docker Compose (Already Doing This)

You already use Docker Compose for nearly everything:
- ChainVault: full stack in Docker Compose
- Verarta: full stack in Docker Compose
- Listmonk: Docker container
- Matomo: Docker Compose (matomo-app + matomo-db)
- Monitoring: `docker-compose.monitoring.yml`

**This is already 80% of infrastructure-as-code.** Docker Compose files are declarative, version-controllable, and reproducible.

### Recommended Approach: Pragmatic IaC

For your scale (1-2 servers, one operator), the recommended stack is:

```
git repo (infra/)
  |
  +-- docker-compose files     # Service definitions (already exist)
  |     chainvault/docker-compose.yml
  |     verarta/docker-compose.yml
  |     monitoring/docker-compose.monitoring.yml
  |     matomo/docker-compose.yml
  |     listmonk/docker-compose.yml
  |
  +-- nginx/                   # nginx site configs (partially exists)
  |     amiheines.com
  |     privateblockchaindatabase.com
  |     chainvault.conf
  |     ...
  |
  +-- scripts/
  |     deploy.sh              # Already exists
  |     setup-server.sh        # NEW: bootstrap a fresh server
  |     backup.sh              # NEW: master backup script
  |
  +-- configs/                 # Service configs (prometheus.yml, etc.)
        monitoring/
        chainvault/
        verarta/
```

**The missing piece is `setup-server.sh`** -- a documented shell script that takes a fresh Ubuntu server and installs everything:

```bash
#!/usr/bin/env bash
# setup-server.sh -- Bootstrap a fresh production server
# Run on a fresh Ubuntu 22.04 server as root
set -euo pipefail

echo "=== 1. System packages ==="
apt update && apt upgrade -y
apt install -y docker.io docker-compose-plugin nginx certbot python3-certbot-nginx \
  ufw fail2ban htop tmux git curl jq

echo "=== 2. Firewall ==="
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

echo "=== 3. Create directories ==="
mkdir -p /opt/{chainvault,verarta,monitoring,matomo,listmonk,amiheines.com,backups}

echo "=== 4. Copy Docker Compose files ==="
echo ">> Copy your docker-compose files to /opt/{service}/ now"

echo "=== 5. Start services ==="
echo ">> cd /opt/chainvault && docker compose up -d"
echo ">> cd /opt/verarta && docker compose up -d"
echo ">> cd /opt/monitoring && docker compose -f docker-compose.monitoring.yml up -d"

echo "=== 6. nginx + SSL ==="
echo ">> Copy nginx configs to /etc/nginx/sites-available/"
echo ">> sudo certbot --nginx -d amiheines.com -d www.amiheines.com"

echo "=== 7. Restore data from backups ==="
echo ">> See BACKUP_PLAN.md Section 12: Disaster Recovery Runbook"
```

This approach gives you:
- **Reproducibility** via Docker Compose + documented setup script
- **Version control** via git for all configs
- **Simplicity** -- no Terraform state files, no Ansible inventory, no new tools to learn
- **Composability** -- you can add Ansible later if needed, wrapping the same Docker Compose files

---

## 12. Disaster Recovery Runbook

### Scenario: Main Server (158.69.27.200) Is Gone

Everything on it is lost. You have backups stored off-site. Here is the recovery sequence, in priority order.

### Phase 0: Immediate (First 15 Minutes)

1. **Verify MiaB is unaffected.** The mail server is separate. Confirm `mail.amiheines.com` is still resolving and email is working.

2. **Provision a new server.** Log into OVH, order a new dedicated server or VPS. Install Ubuntu 22.04 LTS. Note the new IP address.

3. **Update DNS.** SSH into `mail.amiheines.com` and update all A records pointing to the old IP:
   ```bash
   # Via MiaB admin panel or API
   # Update: amiheines.com, www.amiheines.com, grafana.amiheines.com,
   #         lists.amiheines.com, matomo.amiheines.com, chainvault.amiheines.com,
   #         verarta.com (if using MiaB DNS), etc.

   curl -s -X PUT \
     "https://mail.amiheines.com/admin/dns/custom/amiheines.com/A" \
     -d "NEW_IP_ADDRESS" \
     -u "admin@amiheines.com:PASSWORD"
   ```

### Phase 1: Base System (30 Minutes)

```bash
# SSH to new server
ssh root@NEW_IP

# Install essentials
apt update && apt upgrade -y
apt install -y docker.io docker-compose-plugin nginx certbot python3-certbot-nginx \
  ufw fail2ban htop tmux git curl jq

# Firewall
ufw allow 22/tcp && ufw allow 80/tcp && ufw allow 443/tcp && ufw --force enable

# Create directory structure
mkdir -p /opt/{chainvault,verarta,monitoring,matomo,listmonk,amiheines.com,backups}

# Add deploy user
adduser ubuntu
usermod -aG docker ubuntu
usermod -aG sudo ubuntu
# Copy SSH authorized_keys for the ubuntu user
```

### Phase 2: Restore Blockchain (Priority: CRITICAL, Time: 1-4 Hours)

The blockchain is the core product. Restore it first.

```bash
# 1. Copy Docker Compose files from backup/git
scp -r /path/to/backup/chainvault/docker-compose.yml root@NEW_IP:/opt/chainvault/
scp -r /path/to/backup/verarta/docker-compose.yml root@NEW_IP:/opt/verarta/

# 2. Restore producer keys
# Decrypt and copy keys to the correct locations
age -d chainvault-keys.age > /opt/chainvault/keys/
# Place keys into each BP's config.ini signature-provider field

# 3. Restore blocks.log
scp /opt/backups/blockchain/chainvault/blocks.log root@NEW_IP:/opt/chainvault/ship/data/blocks/
scp /opt/backups/blockchain/chainvault/blocks.index root@NEW_IP:/opt/chainvault/ship/data/blocks/

# 4. Restore latest snapshot (for fast state recovery)
scp /opt/backups/blockchain/snapshots/chainvault_snapshot_latest.bin.gz root@NEW_IP:/opt/chainvault/snapshots/
gunzip /opt/chainvault/snapshots/chainvault_snapshot_latest.bin.gz

# 5. Start the SHIP node from snapshot
# Edit the SHIP node's config to start from snapshot:
#   --snapshot /opt/chainvault/snapshots/chainvault_snapshot_latest.bin
# After first boot, remove the --snapshot flag

# 6. Start block producers
cd /opt/chainvault && docker compose up -d

# 7. Verify chain is producing blocks
cleos -u http://localhost:8888 get info
# head_block_num should be advancing

# 8. Repeat for Verarta
```

### Phase 3: Restore MinIO (Priority: CRITICAL, Time: 30 Minutes)

```bash
# Restore MinIO data from backup
rsync -av /path/to/backup/minio/raw-data/ /opt/chainvault/minio-data/

# Start MinIO container
docker compose -f /opt/chainvault/docker-compose.yml up -d minio

# Verify
mc alias set local http://localhost:9000 ACCESS_KEY SECRET_KEY
mc ls local/
```

### Phase 4: Restore Listmonk (Priority: HIGH, Time: 15 Minutes)

```bash
# 1. Start the PostgreSQL container (verarta-postgres) first
cd /opt/verarta && docker compose up -d postgres

# 2. Wait for PostgreSQL to be ready
sleep 10

# 3. Create the listmonk database and restore
docker exec -i verarta-postgres psql -U postgres -c "CREATE DATABASE listmonk;"
docker exec -i verarta-postgres pg_restore -U postgres -d listmonk --no-owner \
  < /opt/backups/listmonk/listmonk_latest.dump

# 4. Start Listmonk
docker compose up -d listmonk
```

### Phase 5: Restore Static Sites (Priority: MEDIUM, Time: 15 Minutes)

```bash
# Clone the repo and build
git clone https://github.com/youruser/amiheines.com.git /tmp/amiheines
cd /tmp/amiheines
npm install && npm run build
rsync -a /tmp/amiheines/dist/ /opt/amiheines.com/dist/

# Or just run the deploy script from your local machine
bash infra/scripts/deploy.sh
```

### Phase 6: Restore nginx + SSL (Priority: MEDIUM, Time: 15 Minutes)

```bash
# Copy nginx configs from git repo or backup
cp infra/nginx/* /etc/nginx/sites-available/
# Also restore configs for chainvault, verarta, listmonk, matomo, grafana

# Enable sites
for site in /etc/nginx/sites-available/*; do
  ln -sf "$site" /etc/nginx/sites-enabled/$(basename "$site")
done

# Test and reload
nginx -t && systemctl reload nginx

# Get SSL certificates (DNS must be pointing to new IP already)
certbot --nginx -d amiheines.com -d www.amiheines.com
certbot --nginx -d grafana.amiheines.com
certbot --nginx -d lists.amiheines.com
certbot --nginx -d matomo.amiheines.com
# ... for each domain
```

### Phase 7: Restore Matomo (Priority: LOW, Time: 15 Minutes)

```bash
# Start Matomo containers
cd /opt/matomo && docker compose up -d

# Wait for MariaDB to initialize, then restore
gunzip < /opt/backups/matomo/matomo_db_latest.sql.gz \
  | docker exec -i matomo-db mysql -u root -p"$PASSWORD" matomo

# Restore config
docker cp /opt/backups/matomo/config.ini.php matomo-app:/var/www/html/config/config.ini.php

docker restart matomo-app
```

### Phase 8: Restore Monitoring (Priority: LOW, Time: 10 Minutes)

```bash
# Copy configs from git
rsync -av infra/monitoring/ /opt/monitoring/

# Start the stack
cd /opt/monitoring
docker compose -f docker-compose.monitoring.yml up -d

# Import Grafana dashboards (if exported)
for dashboard in /opt/backups/grafana/dashboards/*.json; do
  curl -s -u "admin:changeme" \
    -H "Content-Type: application/json" \
    -X POST http://localhost:3200/api/dashboards/db \
    -d @"$dashboard"
done
```

### Phase 9: Rebuild Derived Data (Priority: LOW, Time: Hours-Days)

These steps happen in the background after the core services are running:

1. **Hyperion reindex:** Start Hyperion and let it reindex from the chain. Monitor progress in logs.
2. **PostgreSQL sync daemon:** Start the sync daemon and let it repopulate the read cache.
3. **Elasticsearch:** Will be populated by Hyperion during reindex.
4. **MongoDB:** Will be populated by Hyperion during reindex.

### Recovery Timeline Summary

| Phase | Time | What is Restored |
|-------|------|-----------------|
| 0: DNS + provision | 15 min | New server exists, DNS updated |
| 1: Base system | 30 min | Docker, nginx, firewall |
| 2: Blockchain | 1-4 hrs | Chains producing blocks |
| 3: MinIO | 30 min | Document storage online |
| 4: Listmonk | 15 min | Newsletter system online |
| 5: Static sites | 15 min | Websites serving |
| 6: nginx + SSL | 15 min | HTTPS working for all domains |
| 7: Matomo | 15 min | Analytics collecting |
| 8: Monitoring | 10 min | Grafana/Prometheus online |
| 9: Derived data | Hours-days | Full API history available |
| **Total to functional** | **~3-6 hours** | **Core services running** |
| **Total to full** | **1-3 days** | **All indexes rebuilt** |

### Scenario: Mail Server (mail.amiheines.com) Is Gone

This is the scariest scenario because DNS goes down for everything.

1. **Provision a new VPS immediately.**
2. **Install MiaB from scratch** (see Section 2).
3. **Restore from MiaB backup** (duplicity restore).
4. **Update the registrar's nameserver records** to point to the new IP. This is the slow part -- nameserver changes can take 24-48 hours to propagate globally.
5. **While waiting for DNS:** Manually update `/etc/hosts` on your local machine and the production server to point critical domains to the correct IPs.

**Mitigation (do this now):**
- Set up a secondary DNS provider (Cloudflare, Route53) so DNS survives a MiaB outage
- Or at minimum, keep TTLs low (300s) on critical records so changes propagate fast

---

## Appendix A: Master Backup Script

A single script that runs all backup jobs. Schedule this via cron on the production server.

```bash
#!/usr/bin/env bash
# /opt/backups/scripts/backup-all.sh
# Master backup script -- runs nightly at 2 AM
set -euo pipefail

LOG="/var/log/backup-all.log"
BACKUP_ROOT="/opt/backups"
DATE=$(date +%Y%m%d_%H%M%S)

exec >> "$LOG" 2>&1
echo "========================================"
echo "Backup started: $(date)"
echo "========================================"

# --- Listmonk ---
echo "[$(date)] Starting Listmonk backup..."
/opt/backups/scripts/backup-listmonk.sh

# --- Matomo ---
echo "[$(date)] Starting Matomo backup..."
/opt/backups/scripts/backup-matomo.sh

# --- Blockchain snapshots ---
echo "[$(date)] Starting blockchain snapshot..."
/opt/backups/scripts/backup-blockchain-snapshots.sh

# --- MinIO ---
echo "[$(date)] Starting MinIO backup..."
/opt/backups/scripts/backup-minio.sh

# --- Grafana dashboards ---
echo "[$(date)] Starting Grafana dashboard export..."
GRAFANA_URL="http://localhost:3200"
GRAFANA_AUTH="admin:${GRAFANA_ADMIN_PASSWORD:-changeme}"
DASHBOARD_DIR="$BACKUP_ROOT/grafana/dashboards"
mkdir -p "$DASHBOARD_DIR"
UIDS=$(curl -s -u "$GRAFANA_AUTH" "$GRAFANA_URL/api/search?type=dash-db" 2>/dev/null | \
  python3 -c "import sys,json; [print(d['uid']) for d in json.load(sys.stdin)]" 2>/dev/null || true)
for UID in $UIDS; do
  curl -s -u "$GRAFANA_AUTH" "$GRAFANA_URL/api/dashboards/uid/$UID" > "$DASHBOARD_DIR/${UID}.json"
done

# --- nginx configs ---
echo "[$(date)] Backing up nginx configs..."
mkdir -p "$BACKUP_ROOT/nginx"
tar -czf "$BACKUP_ROOT/nginx/nginx-configs-${DATE}.tar.gz" \
  /etc/nginx/sites-available/ /etc/nginx/nginx.conf 2>/dev/null || true
find "$BACKUP_ROOT/nginx" -name "nginx-configs-*.tar.gz" -mtime +30 -delete

# --- Sync to remote ---
echo "[$(date)] Syncing to remote backup location..."
# Uncomment and configure one of these:
# rsync -avz --delete "$BACKUP_ROOT/" backupuser@remote-server:/backups/production/
# aws s3 sync "$BACKUP_ROOT/" s3://your-bucket/backups/production/ --delete
# mc mirror --overwrite "$BACKUP_ROOT/" remote/backups/production/

echo "========================================"
echo "Backup complete: $(date)"
echo "========================================"
```

### Cron Entry

```bash
# /etc/cron.d/backup-all
0 2 * * * root /opt/backups/scripts/backup-all.sh
```

### Weekly: Block Log Backup

Block logs are large and only need weekly backup:

```bash
# /etc/cron.d/backup-blocks
0 4 * * 0 root /opt/backups/scripts/backup-blockchain-blocks.sh >> /var/log/backup-blocks.log 2>&1
```

---

## Appendix B: Quick Reference -- What Lives Where

```
158.69.27.200 (Main Server)
  /opt/chainvault/           # ChainVault Docker Compose + data
  /opt/verarta/              # Verarta Docker Compose + data
  /opt/monitoring/           # Prometheus, Grafana, Loki stack
  /opt/matomo/               # Matomo Docker Compose
  /opt/listmonk/             # Listmonk Docker Compose
  /opt/amiheines.com/dist/   # Built Astro site
  /opt/backups/              # Local backup staging area
  /etc/nginx/sites-available/  # nginx site configs
  /etc/letsencrypt/          # SSL certificates

mail.amiheines.com (Mail Server)
  /home/user-data/           # All MiaB data (mail, DNS, config)
  /home/user-data/backup/secret_key.txt  # Backup encryption key (CRITICAL)

tv.amiheines.com (Home Server)
  crontab                    # Dynamic DNS update cron job
  Media server config        # Jellyfin/Plex config + database
  Media files                # Movies, TV shows, etc.

Local Machine
  ~/dev/work/amiheines.com/  # Website source + infra configs
  ~/dev/work/chainvault/     # ChainVault application code
  ~/dev/work/verarta/        # Verarta application code
```

---

## Appendix C: Action Items (Do These Now)

These are the immediate steps to go from "no backup strategy" to "basic coverage":

- [ ] **1. Store all secrets in a password manager.** Set up Vaultwarden or use Bitwarden cloud. Migrate every password, key, and credential into it today. (1 hour)
- [ ] **2. Back up MiaB encryption key.** Copy `/home/user-data/backup/secret_key.txt` from the mail server to your password manager. Without it, MiaB backups are useless. (5 minutes)
- [ ] **3. Configure MiaB remote backups.** Set up S3-compatible backup target in the MiaB admin panel. (30 minutes)
- [ ] **4. Export and save all blockchain producer keys.** Encrypt them and store in your password manager plus an offline encrypted USB. (30 minutes)
- [ ] **5. Export DNS zones.** Run the DNS zone export command and save the output. (5 minutes)
- [ ] **6. Create the backup scripts directory.** On the server: `mkdir -p /opt/backups/scripts` and deploy the scripts from this document. (1 hour)
- [ ] **7. Set up cron jobs for automated backups.** Start with Listmonk + Matomo + blockchain snapshots. (30 minutes)
- [ ] **8. Test a Listmonk restore.** Dump the database, drop it, restore it, verify. Do this once so you know the process works. (30 minutes)
- [ ] **9. Set up off-site backup sync.** Choose Backblaze B2 or a second server and configure rsync/s3cmd to push backups off-site. (1 hour)
- [ ] **10. Document the home server.** SSH in, list services, document the dynamic DNS cron job. (30 minutes)

**Total estimated time: ~6 hours.** After this, you have basic disaster recovery capability.
