#!/usr/bin/env bash
set -euo pipefail

# ─── amiheines.com deployment script ───────────────────────────
# Builds the Astro site locally and deploys to the production server.
# Usage: bash infra/scripts/deploy.sh
# ───────────────────────────────────────────────────────────────

SERVER="ubuntu@verarta.com"
DEPLOY_PATH="/opt/amiheines.com"
LOCAL_DIR="$(cd "$(dirname "$0")/../.." && pwd)"

echo "=== amiheines.com deploy ==="
echo "Local:  $LOCAL_DIR"
echo "Remote: $SERVER:$DEPLOY_PATH"
echo ""

# ─── Build ─────────────────────────────────────────────────────
echo "→ Installing dependencies..."
cd "$LOCAL_DIR"
npm install

echo "→ Building Astro site..."
npm run build

# ─── Deploy static files ──────────────────────────────────────
echo "→ Syncing dist/ to server..."
ssh "$SERVER" "sudo mkdir -p $DEPLOY_PATH/dist"
rsync -avz --delete \
    "$LOCAL_DIR/dist/" \
    "$SERVER:/tmp/amiheines-dist/"

ssh "$SERVER" "sudo rsync -a --delete /tmp/amiheines-dist/ $DEPLOY_PATH/dist/ && rm -rf /tmp/amiheines-dist"

# ─── Deploy nginx config ──────────────────────────────────────
echo "→ Syncing nginx configs..."
rsync -avz \
    "$LOCAL_DIR/infra/nginx/amiheines.com" \
    "$LOCAL_DIR/infra/nginx/privateblockchaindatabase.com" \
    "$SERVER:/tmp/"

ssh "$SERVER" "
    sudo cp /tmp/amiheines.com /etc/nginx/sites-available/amiheines.com
    sudo cp /tmp/privateblockchaindatabase.com /etc/nginx/sites-available/privateblockchaindatabase.com
    sudo ln -sf /etc/nginx/sites-available/amiheines.com /etc/nginx/sites-enabled/amiheines.com
    sudo ln -sf /etc/nginx/sites-available/privateblockchaindatabase.com /etc/nginx/sites-enabled/privateblockchaindatabase.com
    sudo nginx -t && sudo systemctl reload nginx
    rm -f /tmp/amiheines.com /tmp/privateblockchaindatabase.com
"

echo ""
echo "=== Deploy complete ==="
echo ""
echo "Next steps (first deploy only):"
echo "  1. Add DNS A record: amiheines.com → 158.69.27.200"
echo "  2. Add DNS AAAA record: amiheines.com → 2607:5300:60:80c8::1"
echo "  3. Add DNS A record: www.amiheines.com → 158.69.27.200"
echo "  4. Run SSL: sudo certbot --nginx -d amiheines.com -d www.amiheines.com"
echo "  5. (If redirecting) Add DNS for privateblockchaindatabase.com pointing to same IP"
echo "  6. Run SSL: sudo certbot --nginx -d privateblockchaindatabase.com -d www.privateblockchaindatabase.com"
