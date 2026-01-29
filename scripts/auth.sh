#!/usr/bin/env bash
set -euo pipefail

TOKEN_RESPONSE=$(curl -s -X POST \
  "https://login.microsoftonline.com/${FABRIC_TENANT_ID}/oauth2/v2.0/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=${FABRIC_CLIENT_ID}" \
  -d "client_secret=${FABRIC_CLIENT_SECRET}" \
  -d "scope=${FABRIC_SCOPE}" \
  -d "grant_type=client_credentials")

FABRIC_TOKEN=$(echo "$TOKEN_RESPONSE" | jq -r '.access_token')

if [[ -z "$FABRIC_TOKEN" || "$FABRIC_TOKEN" == "null" ]]; then
  echo "ERROR: Failed to acquire Fabric access token"
  echo "$TOKEN_RESPONSE"
  exit 1
fi

echo "FABRIC_TOKEN=$FABRIC_TOKEN" >> "$GITHUB_ENV"
