#!/bin/bash
# Welcome sequence drip emailer for Listmonk
# Runs daily via cron. Sends the right welcome email based on subscriber join date.
# Schedule: 0 9 * * * /opt/amiheines/welcome-sequence.sh >> /var/log/welcome-sequence.log 2>&1
#
# Template IDs (transactional):
#   6 = Day 0:  Welcome + checklist download
#   7 = Day 3:  My story + why private blockchain
#   8 = Day 7:  ChainVault case study
#   9 = Day 10: 4 misconceptions
#  10 = Day 14: How I can help + book a call
#
# Logic: query subscribers from "Opt-in list" (id:2), check their subscription age,
# send the appropriate email if they haven't received it yet (tracked via attribs).

set -euo pipefail

LISTMONK_URL="https://lists.amiheines.com"
API_USER="api"
API_PASS="admin123"
AUTH="$API_USER:$API_PASS"
LIST_ID=2

# Template ID → day offset mapping
declare -A SCHEDULE=(
  [6]=0
  [7]=3
  [8]=7
  [9]=10
  [10]=14
)

# Template ID → subject line (tx API requires explicit subject)
declare -A SUBJECTS=(
  [6]="Your Private Blockchain Checklist (+ what I am building right now)"
  [7]="Why I build infrastructure that nobody can tamper with"
  [8]="Case study: how ChainVault prevents wire fraud"
  [9]="4 things enterprises get wrong about private blockchains"
  [10]="How I can help (if any of this resonated)"
)

log() {
  echo "[$(date -u '+%Y-%m-%d %H:%M:%S')] $*"
}

# Get all confirmed subscribers from opt-in list
get_subscribers() {
  local page=1
  local per_page=100
  while true; do
    local resp
    resp=$(curl -sf -u "$AUTH" \
      "${LISTMONK_URL}/api/subscribers?list_id=${LIST_ID}&subscription_status=confirmed&per_page=${per_page}&page=${page}" 2>/dev/null)

    local count
    count=$(echo "$resp" | python3 -c "import sys,json; d=json.load(sys.stdin); print(len(d['data']['results']))" 2>/dev/null)

    if [ "$count" = "0" ] || [ -z "$count" ]; then
      break
    fi

    echo "$resp"
    page=$((page + 1))
  done
}

# Send transactional email
send_tx_email() {
  local subscriber_email="$1"
  local template_id="$2"
  local subject="${SUBJECTS[$template_id]}"

  curl -sf -u "$AUTH" \
    -H 'Content-Type: application/json' \
    -X POST "${LISTMONK_URL}/api/tx" \
    -d "{
      \"subscriber_email\": \"${subscriber_email}\",
      \"template_id\": ${template_id},
      \"subject\": \"${subject}\"
    }" > /dev/null 2>&1
}

# Update subscriber attribs to track sent emails
mark_sent() {
  local subscriber_id="$1"
  local template_id="$2"
  local current_attribs="$3"

  # Add this template to the welcome_sent list
  local new_attribs
  new_attribs=$(echo "$current_attribs" | python3 -c "
import sys, json
attribs = json.load(sys.stdin)
sent = attribs.get('welcome_sent', [])
sent.append($template_id)
attribs['welcome_sent'] = sent
print(json.dumps(attribs))
")

  curl -sf -u "$AUTH" \
    -H 'Content-Type: application/json' \
    -X PUT "${LISTMONK_URL}/api/subscribers/${subscriber_id}" \
    -d "{\"attribs\": ${new_attribs}}" > /dev/null 2>&1
}

log "Starting welcome sequence check"

get_subscribers | python3 -c "
import sys, json
from datetime import datetime, timezone

results = []
for line in sys.stdin:
    data = json.loads(line)
    for sub in data['data']['results']:
        results.append(sub)

for sub in results:
    # Find subscription date for list $LIST_ID
    sub_date = None
    for lst in sub.get('lists', []):
        if lst['id'] == $LIST_ID:
            sub_date = lst.get('subscription_created_at', sub.get('created_at'))
            break
    if not sub_date:
        sub_date = sub['created_at']

    print(json.dumps({
        'id': sub['id'],
        'email': sub['email'],
        'created_at': sub_date,
        'attribs': sub.get('attribs', {})
    }))
" | while IFS= read -r subscriber; do
  sub_id=$(echo "$subscriber" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")
  sub_email=$(echo "$subscriber" | python3 -c "import sys,json; print(json.load(sys.stdin)['email'])")
  sub_created=$(echo "$subscriber" | python3 -c "import sys,json; print(json.load(sys.stdin)['created_at'])")
  sub_attribs=$(echo "$subscriber" | python3 -c "import sys,json; print(json.dumps(json.load(sys.stdin)['attribs']))")

  # Calculate days since subscription
  days_since=$(python3 -c "
from datetime import datetime, timezone
created = datetime.fromisoformat('$sub_created'.replace('Z', '+00:00'))
now = datetime.now(timezone.utc)
print((now - created).days)
")

  # Get already-sent template IDs
  sent_templates=$(echo "$sub_attribs" | python3 -c "
import sys, json
attribs = json.load(sys.stdin)
print(','.join(str(x) for x in attribs.get('welcome_sent', [])))
")

  for template_id in 6 7 8 9 10; do
    day_offset=${SCHEDULE[$template_id]}

    # Skip if already sent
    if echo ",$sent_templates," | grep -q ",$template_id,"; then
      continue
    fi

    # Send if subscriber is old enough
    if [ "$days_since" -ge "$day_offset" ]; then
      log "Sending template $template_id (day $day_offset) to $sub_email (subscribed $days_since days ago)"
      if send_tx_email "$sub_email" "$template_id"; then
        mark_sent "$sub_id" "$template_id" "$sub_attribs"
        log "  OK"
        # Update attribs for next iteration
        sub_attribs=$(echo "$sub_attribs" | python3 -c "
import sys, json
attribs = json.load(sys.stdin)
sent = attribs.get('welcome_sent', [])
sent.append($template_id)
attribs['welcome_sent'] = sent
print(json.dumps(attribs))
")
      else
        log "  FAILED to send template $template_id to $sub_email"
      fi
    fi
  done
done

log "Welcome sequence check complete"
