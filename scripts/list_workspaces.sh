#!/usr/bin/env bash
set -euo pipefail

# 1. Validate token
if [[ -z "${FABRIC_TOKEN:-}" ]]; then
  echo "ERROR: FABRIC_TOKEN is not set"
  exit 1
fi

# 2. Call Fabric API
RESPONSE=$(curl -s \
  -H "Authorization: Bearer ${FABRIC_TOKEN}" \
  -H "Content-Type: application/json" \
  https://api.fabric.microsoft.com/v1/workspaces)

# 3. Defensive check: did we actually get workspaces?
if ! echo "$RESPONSE" | jq -e '.value' >/dev/null; then
  echo "ERROR: Unexpected response from Fabric API"
  echo "$RESPONSE"
  exit 1
fi

# 4. Emit non-personal workspaces only
echo "$RESPONSE" \
  | jq '[.value[] | select(.type != "Personal")]'
